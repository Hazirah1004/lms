class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:login]
  before_action :authenticate, except: [:login]
  before_action :current_user
  #before_filter :set_layout#, except: [:login]
  layout :emp_layout, except: [:login]
  layout "login", only: [:login]

  
  def changepassword
    @employee= Employee.where("id=?",@current_user.id).first
    @a=BCrypt::Password.new("#{@employee.hashed_password}")
    @b=params[:employee][:hashed_password]
    @employee.password = params[:password]
    if @a == @b
      if @employee.save
       redirect_to password_employees_path, notice: 'Successfully changed password'
      end
    else
      redirect_to password_employees_path, alert: 'Password are not the same!'
    end
  end

  def password
    @employee = Employee.new
  end
    
  
  def emp_layout
    @current_user.position="Staff" ? "employee" : "employees"
  end
  
  def current_user
   if session[:user_id]
      @current_user ||= Employee.find(session[:user_id])
   end
  end

helper_method :current_user

  def authenticate
    if session[:user_id].nil?
      redirect_to(root_path)
    end
  end

  def logout
    reset_session
    redirect_to root_path
    flash[:notice] = "Success Logout "
  end
  


  def login
    reset_session
    if request.post?
      if employee = Employee.authenticate(params[:employee][:email], params[:employee][:password])
        session[:user_id] = employee.id
        flash[:notice] = 'Succesfully login'
        redirect_to(employees_path)
      else
        flash[:notice] = 'Please try again'
        return login_employees_path
      end
    end
  end


  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
     @departments = Department.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @departments = Department.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @recipe}
    end
  end

  # GET /employees/1/edit
  def edit
    @departments = Department.all
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.password = @employee.ic
    @employee.annualleave = 0
    @employee.medicalleave = 0
    @employee.compasleave = 0
    @employee.maternityleave = 0
    PostMailer.reg_user(@employee).deliver

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :ic, :gender, :address, :phone, :position, :email, :dept, :startdate, :password)
    end
end