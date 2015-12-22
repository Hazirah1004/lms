class AppliesController < ApplicationController
  before_action :set_apply, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:login]
  before_action :authenticate, except: [:login]
  before_action :current_user
  # GET /applies
  # GET /applies.json
  
#helper_method :current_user
def report
  @report = Employee.where('dept=?',@current_user.dept)
   @apply = Apply.new

end

def searchresult

  @searchresult = Apply.where("employee_id=?",@current_user.id)
  render :layout => false
end
def calendar
  @applies = Apply.all
  @date = Date.today
  @date = params[:date] ? Date.parse(params[:date]) : Date.today
end

def status_reject
    @user = Apply.find(params[:a])
      @user.status = 'Reject'
       if @user.save
        redirect_to @user
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end


  def status_approve
    @user = Apply.find(params[:a])
      @user.status = 'Approved'
      @a = Employee.find(@user.employee_id)
      PostMailer.apprv_user(@a).deliver
       if @user.save
        redirect_to @user
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  def approval
      if @current_user.position == "CEO"
        @applies = Apply.where('status= "Pending"')
      else
        @applies = Apply.where('dept=?',@current_user.dept).where('status= "Pending"')
      end
  end

  def index
    @applies = Apply.where("employee_id=?", @current_user.id)

  end

  # GET /applies/1
  # GET /applies/1.json
  def show
  end

  # GET /applies/new
  def new

    @gender = @current_user.gender
    @apply = Apply.new
    @apply1 = Apply.where("employee_id=? and leave_type=?",@current_user.id,1) 
    @apply2 = Apply.where("employee_id=? and leave_type=?",@current_user.id,2) 
    @apply3 = Apply.where("employee_id=? and leave_type=?",@current_user.id,3) 
    @apply4 = Apply.where("employee_id=? and leave_type=?",@current_user.id,4) 
    @type1 = @apply1.sum(:no_day)
    @type2 = @apply2.sum(:no_day)
    @type3 = @apply3.sum(:no_day)
    @type4 = @apply4.sum(:no_day)

    @tyear = Time.now.year #DateTime.now.utc.to_date
    @noyear = @tyear - @current_user.startdate.year #(Time.now- @current_user.startdate.to_time)/1.day
    if @noyear <= 3
      @balance = 8 - @type1
    elsif @noyear <= 5
      @balance = 12 - @type1
    elsif @noyear > 5
      @balance = 16
  end


  end

  # GET /applies/1/edit
  def edit
  end

  # POST /applies
  # POST /applies.json
  def create
@date4 = params[:apply][:start_date].to_date
@date5 = params[:apply][:end_date].to_date
@date6 = (@date4..@date5)
@searchresult = Apply.where("employee_id=?",@current_user.id)   
@count=0
@searchresult.each do |a|

  @date1 = a.start_date.to_date
  @date2 = a.end_date.to_date
  @date3 = (@date1..@date2)
  if @date3.include?(@date6) == true 
    @count = @count + 1 
  end
end





    @apply = Apply.new(apply_params)
    @apply.employee_id = @current_user.id
    @apply.dept = @current_user.dept
    @apply.status = 'Pending'
    @apply.no_day = @apply.end_date - @apply.start_date
    if @apply.leave_type == 1
      @current_user.annualleave = @current_user.annualleave + @apply.no_day
    end
    if @apply.leave_type == 2
      @current_user.medicalleave = @current_user.medicalleave + @apply.no_day
    end
    if @apply.leave_type == 3
      @current_user.compasleave = @current_user.compasleave + @apply.no_day
    end
    if @apply.leave_type == 4
      @current_user.maternityleave = @current_user.maternityleave + @apply.no_day
    end
    @current_user.save

      if @count == 0
              if @apply.save
                redirect_to @apply, notice: "Apply was successfully created.#{@count}#{@date4}#{@date5}"
              else
                format.html { render :new }
                format.json { render json: @apply.errors, status: :unprocessable_entity }
              end
    else
          redirect_to new_apply_path, notice: 'Fail '
    end
    
  end

  # PATCH/PUT /applies/1
  # PATCH/PUT /applies/1.json

  def update
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to @apply, notice: 'Apply was successfully updated.' }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /applies/1
  # DELETE /applies/1.json
  def destroy
    @apply.destroy
    respond_to do |format|
      format.html { redirect_to applies_url, notice: 'Apply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apply
      @apply = Apply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apply_params
      params.require(:apply).permit(:employee_id, :leave_type, :start_date, :end_date, :replace_person, :address_on_leave)
    end
end
