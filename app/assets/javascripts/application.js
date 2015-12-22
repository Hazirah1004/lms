// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require jquery-ui/datepicker
//= require jquery_ujs
//= require_tree .


$(document).on('ready page:load', function () {
  // you code here
  $('#employee_startdate').datepicker({
      changeMonth: true,
      changeYear: true,
      altField: "#post_alternate",
      altFormat: "DD, d MM, yy"
    })
  $( "#employee_startdate").datepicker( "option", "dateFormat", "yy-mm-dd" )   
  $('#apply_start_date').datepicker({
      changeMonth: true,
      changeYear: true,
onSelect: function(dateText) {
      display(dateText);
      $(this).change();
    }
  })

  function display(msg) {

  if (window.XMLHttpRequest) {
    // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
  } else { // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmlhttp.onreadystatechange=function() {
    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
      document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    }
  }
  xmlhttp.open("GET","http://localhost:3000/applies/searchresult?a="+msg,true);
  xmlhttp.send();
    $( ".inner" ).html( msg );
  }
  $( "#apply_start_date").datepicker( "option", "dateFormat", "yy-mm-dd" )
    $('#apply_end_date').datepicker({
      changeMonth: true,
      changeYear: true,
onSelect: function(dateText) {
      display2(dateText);
      $(this).change();
    }
  })

  function display2(msg) {

  if (window.XMLHttpRequest) {
    // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
  } else { // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmlhttp.onreadystatechange=function() {
    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
      document.getElementById("txtHint2").innerHTML=xmlhttp.responseText;
    }
  }
  xmlhttp.open("GET","http://localhost:3000/applies/searchresult?a="+msg,true);
  xmlhttp.send();
    $( ".inner" ).html( msg );
  }
  $( "#apply_end_date").datepicker( "option", "dateFormat", "yy-mm-dd" )
});