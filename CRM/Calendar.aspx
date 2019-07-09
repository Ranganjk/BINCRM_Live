<%@ Page Title="Appointments" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="Calendar" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script src="Calender/jquery-1.10.2.js" type="text/javascript"></script>

    <script src="Calender/fullcalendar.js" type="text/javascript"></script>
    <link href="Calender/fullcalendar.css" rel="stylesheet" />       
  
    <script src="Calender/jquery.validate.js" type="text/javascript"></script>
    <script src="Calender/moment.js" type="text/javascript"></script>

    <link href="Calender/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <%-- <script src="Calender/jquery-ui.js" type="text/javascript"></script>--%>

    <script src="Calender/jquery.timepicker.js" type="text/javascript"></script>
    <link href="Calender/jquery.timepicker.css" rel="Stylesheet" />
    <%--<script src="Calender/lib/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="Calender/lib/bootstrap-datepicker.css" rel="stylesheet" />--%>
    <script src="Calender/lib/site.js" type="text/javascript"></script>
    <link href="Calender/lib/site.css" rel="stylesheet" />

    <%--Auto complete Jquery files  --%>
    <script src="Calender/Auto/jquery-ui.min.js" type="text/javascript"></script>

    <style type="text/css">
        .modal {
            z-index: 999;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

        .Hide {
            display: none;
        }

        .Button {
            background-color: #008dde;
            border: none;
            border-radius: 3px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            color: #f4f4f4;
            cursor: pointer;
            /*font-family: 'Open Sans', Verdana, Helvetica, sans-serif;*/
            font-family: Verdana;
            height: 20px;
            text-transform: uppercase;
            width: 100px;
            -webkit-appearance: none;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            //DisplayCalendar();
            $("[id*='dvPros']").show();
            var date = new Date();
            var yr = date.getFullYear();
            //alert(yr);
            var month = date.getMonth() + 1;
            //alert(month);
            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
            var newdate = yr + '-' + month + '-' + day;
            $("[id*='txtDate']").datepicker({
                autoOpen: false, minDate: date, dateFormat: 'yy-mm-dd', maxDate: '+6M', onSelect: function (text) {
                    var sdate = $(this).val(); GetApptCounts(sdate);
                }
            });
            //$("[id*='txtDate']").datepicker({ autoopen: false, minDate: date, dateFormat: 'dd-mm-yy' });
            $("[id*='txtTimer']").timepicker({ 'minTime': '8:00am', 'maxTime': '9:00pm' });
            $("[id*='txtutimer']").timepicker();
            //LoadDropdown();
            GetStaff();
            GetApptCountsAll(newdate);
        });

        function LoadSaveTime() {
            var loadsave = $("[id*='ddlSavetime']");
            $.ajax({
                url: "Calendar.aspx/GetSaveTime",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    loadsave.empty();
                    //$(data.d).find('temp').
                    loadsave.append('<option> Please Select </option>');
                    $(data.d).find('temp').each(function () {
                        var objval = $(this).find('Savetimeentry').text();
                        var objtext = $(this).find('Savetimeentry').text();
                        loadsave.append($('<option></option>').val(objval).html(objtext));
                    });
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function GetStaff() {
            var target = $("[id*='ddlStaff']");
            $.ajax({
                url: "Calendar.aspx/GetStaff",
                type: "POST",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //var test = data.d.length;                   
                    var i = 0;
                    var Name;
                    target.append('<option> All </option>');
                    $(data.d).find('temp').each(function () {
                        i = i + 1;
                        var objval = $(this).find('Username').text();
                        var objtext = $(this).find('StaffName').text();
                        //alert(objtext);
                        Name = objval;
                        target.append($('<option></option>').val(objval).html(objtext));
                    });
                    if (i <= 1) {
                        $("[id*='dvAdminRights']").hide();
                        //alert(Name);
                        target.val(Name);
                        DisplayCalendarByUsers();
                    } else {
                        DisplayCalendarByUsers();
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function IsEmail(email) {
            var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!regex.test(email)) {
                return false;
            } else {
                return true;
            }
        }
        function validatePhone(phoneText) {
            var filter = /^[0-9-+]+$/;
            if (filter.test(phoneText) && phoneText.length <= 13) {
                return true;
            }
            else {
                return false;
            }
        }

        function test() {
            //alert('test');
        }
        function AddNewTasks() {
            var details = $("[id*='txtDetails']").val();
            var dropdownfor = $("[id*='hbtnFor']").val();
            var Name = $("[id*='txtName']").val();
            var Mobile = $("[id*='txtmno']").val();
            var Email = $("[id*='txtEmail']").val();
            var Assign = $("[id*='ddlAssignto']").val();
            var Fdate = $("[id*='txtDate']").val();
            var title = $("[id*='ddlMr']").val();
            var Time = $("[id*='txtTimer']").val();           
            var date = new Date(Fdate);          
            var yr = date.getFullYear();            
            var month = date.getMonth() + 1;            
            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
            var newdate = yr + '-' + month + '-' + day + ' ' + Time;               
            if (dropdownfor == '') {
                $.ajax({
                    url: "Calendar.aspx/AddProspects",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{'title':'" + title + "','Name':'" + Name + "','Mobile':'" + Mobile + "','Email':'" + Email + "'}",
                    dataType: "json",
                    success: function (data) {
                        var sts = data.d;
                        if (sts != "false") {
                            dropdownfor = sts;
                        }
                        AddNewTask(dropdownfor, Assign, details, newdate);
                    },
                    error: function (response) {
                        alert(response.responseText);
                        return;
                    }
                });
            } else {
                AddNewTask(dropdownfor, Assign, details, newdate);
            }            
        }
        $(function () {
            $("[id*='btnSave']").click(function () {
                AddNewTasks();
            });
            $("[id*='btnClear']").click(function () {
                $("[id*='txtName']").val('');
                $("[id*='txtmno']").val('');
                $("[id*='txtEmail']").val('');
                $("[id*='txtDetails']").val('');
            });
            $("[id*='ddlFor']").change(function () {
                var sval = $("[id*='ddlFor']").val();
                //alert(sval);
                if (sval != 0) {
                    $("[id*='dvPros']").hide();
                    $("[id*='lblOR']").hide();
                } else {
                    $("[id*='dvPros']").show();
                    $("[id*='lblOR']").show();
                }
            });
            $("[id*='btnstaffsearch']").click(function () {
                DisplayCalendarByUsers();
            });
            $("[id*='btnstaffviewall']").click(function () {
                DisplayCalendar();
            });
            $("[id*='ibtnsavetime']").click(function () {
                var details = $("[id*='txtDetails']");
                //details.empty();
                var value = $("[id*='ddlSavetime']").val();
                //details.append(val)
                if (value != "Please Select") {
                    details.val(details.val() + ' ' + value);
                }
            });
            $("[id*='btnAddsavetime']").click(function () {
                $("[id*='dvSaveTime']").show();
            });
            $("[id*='btnclosesave']").click(function () {
                //$("[id*='dvSaveTime']").hide();
                var tentry = $("[id*='txtAddSavetime']").val();
                //alert(tentry);
                if (tentry = '') {
                    alert('Please enter save time information');
                    return;
                } else {
                    $.ajax({
                        url: "Calendar.aspx/AddSaveTime",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: "{'Savetime':'" + $("[id*='txtAddSavetime']").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            var obj = data.d;
                            if (obj == "true") {
                                alert('Your details are saved');
                                $("[id*='txtAddSavetime']").val('');
                                LoadSaveTime();
                            }
                            else {
                                alert('Please enter save time information');
                            }
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                }
            });
            $("[id*='newbtnsavetimeinfo']").click(function () {
                $("[id*='dvSaveTime']").hide();
            });
            $("[id*='btnPopuphelp']").click(function () {
                //$("#calender").hide();
                $("#calender").css("opacity", "0.6");
                $("[id*='dvHelp']").dialog({
                    title: "Help",
                    autoopen: false,
                    closeOnEscape: true,
                    width: "auto",
                    height: "auto",
                    modal: false,
                    open: function (event, ui) { $(".ui-dialog-titlebar-close").hide(); },
                    buttons: {
                        Close: function () {
                            //$("#calender").show();
                            $("#calender").css("opacity", "");
                            $(this).dialog('close');
                        }
                    }
                });
            });

            $("[id*='chkAppointment']").change(function () {
                if ($(this).is(":checked")) {
                    //alert('test');
                    $("[id*='txtTimer']").timepicker('option', 'minTime', '8:00am');
                    $("[id*='txtTimer']").timepicker('option', 'maxTime', '9:00pm');
                }
                else {
                    $("[id*='txtTimer']").timepicker('option', 'minTime', '12:00am');
                    $("[id*='txtTimer']").timepicker('option', 'maxTime', '11:30pm');
                }
            });

            $("[id*='txtTimer']").on('changeTime', function () {
                if ($("[id*='chkAppointment']").is(":checked")) {
                    //alert('test');
                    var time = $(this).val();
                    var date = $("[id*='txtDate']").val();
                    var newdate = date + ' ' + time;
                    $.ajax({
                        url: "Calendar.aspx/CheckAppointments",
                        type: "POST",
                        data: "{'date':'" + newdate + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var obj = data.d;
                            var Name, Activity;
                            if (obj != "false") {
                                $(obj).find('temp').each(function () {
                                    Name = $(this).find('Name').text();
                                    Activity = $(this).find('ActivityAssigned').text();
                                });
                                //$("[id*='txtDate']").val('');
                                $("[id*='txtTimer']").timepicker('setTime', new Date());
                                alert('Appointment already fixed for the time that you have chosen ' + '\n' + 'With  : ' + Name + ' \n ' + 'For : ' + Activity);
                            }
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                }
            });

            $("[id*='txtFor']").autocomplete({
                source: function (request, response) {
                    var param = { keyword: $("[id*='txtFor']").val() };
                    $.ajax({
                        url: "Calendar.aspx/GetUsers",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(param),
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('|')[0],
                                    val: item.split('|')[1]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (event, ui) {
                    if (ui.item) {
                        $("[id*='hbtnFor']").val(ui.item.val);
                    }
                },
                minLength: 3
            });
        });
        function DisplayCalendarByUsers() {
            var Name = $("[id*='ddlStaff']").val();
            //alert(Name);
            //LastAccess = DisplayCalendarByUsers;
            $.ajax({
                url: "Calendar.aspx/GetEventsByUsers",
                type: "POST",
                contentType: "application/json",
                data: "{'username':'" + Name + "'}",
                dataType: "json",
                success: function (data) {
                    $('div[id*=calender]').empty();
                    $('div[id*=calender]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay,timelineFourDays'
                        },
                        timeFormat: 'h:mm tt',
                        height: 450,                       
                        theme: true,                        
                        editable: true,
                        eventLimit: true,
                        //droppable: true,
                        draggable: false,
                        selectable: true,
                        //selectHelper: true,
                        weekends: true,    // if false = Hide saturday and sunday                      
                        events:
                        $.map(data.d, function (item, i) {
                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            event.end = item.EndDate;
                            event.title = item.EventName;                            
                            event.description = item.Url;
                            event.color = item.color;
                            event.imageurl = item.imageurl;
                            event.allDay = item.allday;                           
                            //event.dow = [1];
                            //event.rendering = 'background';
                            return event;
                        }),
                        views: {
                            timelineFourDays: { type: 'timeline', duration : { days : 4 } }
                        },
                        eventsources: [
                            { editable: true }
                        ],
                        eventClick: function (event) {
                            // alert(event.id);
                            //alert(event.title);
                            var color = event.color;
                            if (color != '#ddf6dd' && event.title != 'Holiday') {
                                $("[id*='hbtnRSN']").empty();
                                $("[id*='hbtnRSN']").val(event.id);
                                var test = $("[id*='hbtnRSN']").val();
                                //alert(test);
                                $("[id*='dvPros']").hide();
                                var start = $.fullCalendar.formatDate(event.start, 'yyyy-MM-dd hh:mm');
                                //OpenUpdateTasks(start);
                                OpenNewUpdateTasks(start);
                                return false;
                            }
                        },
                        dayRender:function(date,cell) {
                            var check = $.fullCalendar.formatDate(date, 'yyyy-mm-dd');
                            var today = $.fullCalendar.formatDate(new Date(), 'yyyy-mm-dd');
                            if (check > today) {
                                cell.css("background-color", "red");
                            }
                        },
                        eventAfterRender: function (event, element) {
                            //$(element).css('height', '50px');
                            //alert(event.status);  // can change color events
                            element.find(".fc-title").append("<img src='Calender/ok.png' width='12' height='12'>");
                            element.find(".fc-content").before($("<span class=\"fc-event-icons\"></span>").html("<img src='Calendar/ok.png' width='12' height='12'>"));
                        },
                        eventAfterAllRender: function (event,element) {
                            
                        },
                        eventMouseover: function (event, jsEvent) {
                            //alert(event.title);  
                            var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm tt');
                            $(jsEvent.target).attr('title', sdate + '\n' + event.description);
                        },
                        eventMouseout: function (event) {

                        },
                        eventRender: function (event, element, view) {
                            //$(element).tooltip({ tooltip: event.title });  
                            // $(element).find('div.fc-content').prepend("<img src='" + event.imageurl + "' width='12' height='12'>");
                            //if (event.start.getDay() == monday) {
                            //    alert('test');
                            //}                            
                            if (event.imageurl) {                                
                                element.find(".fc-event-time").before($("<span class=\"fc-event-icons\"></span>").html("<img src='" + event.imageurl + "' onclick='javascript:test();' title='Appointment is completed' width='12' height='12'>"));                               
                            } 
                        },
                        select: function (calEvent, start, allday) {
                            //alert(calEvent.title);
                            if (calEvent.title != 'Holiday' || calEvent.title != 'undefined') {
                                var check = $.fullCalendar.formatDate(start, 'yyyy-MM-dd');
                                var today = $.fullCalendar.formatDate(new Date(), 'yyyy-MM-dd');

                                var Passdate = $.fullCalendar.formatDate(start, 'dd-MMM-yyyy');
                                //alert(check);
                                //alert(today);
                                if (check < today) {
                                    alert('Please select a future date');
                                    return;
                                } else {
                                    //Navigate(Passdate);  
                                    GetApptCounts(check);
                                    OpenModelPopup(check);
                                }
                            }
                        }                       
                    });
                    $('div[id*=calender]').fullCalendar('refetchEvents');
                    //$("#pnlCalender").show().css('visibility', 'visible');
                   // $('div[id*=calender]').fullCalendar('addEventSource',
                   //function (start, end, callback,event) {
                   //    // When requested, dynamically generate a
                   //    // repeatable event for every monday.                       
                   //    var events = [];
                   //    var monday = 1;
                   //    var one_day = (24 * 60 * 60 * 1000);

                   //    for (loop = start.getTime() ;
                   //         loop <= end.getTime() ;
                   //         loop = loop + one_day) {
                   //        var column_date = new Date(loop);

                   //        if (column_date.getDay() == monday) {
                   //            // we're in Moday, create the event
                   //            events.push({
                   //                title: 'Morning Meeting',
                   //                start: new Date(column_date.setHours(10, 00)),
                   //                end: new Date(column_date.setHours(10, 40)),
                   //                allDay: false
                   //            });
                   //        }

                   //    } // for loop
                   //    // return events generated
                   //    callback(events);
                   //}
                   //                  );
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });
        }
        function GetApptCountsAll(start) {
            var Total = $("[id*='lbltotcount']");
            var done = $("[id*='lbldonecount']");
            var sched = $("[id*='lblschedcount']");
            var date = new Date();
            $.ajax({
                url: "Calendar.aspx/GetCounts",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'i':'1','date':'" + start + "'}",
                dataType: "json",
                success: function (data) {
                    var obj = data.d;
                    //alert(data.d[0].Total);
                    Total.empty();
                    done.empty();
                    sched.empty();
                    if (obj.length > 0) {
                        Total.text(data.d[0].Total);
                        done.text(data.d[0].Done);
                        sched.text(data.d[0].Scheduled);
                    } else {
                        Total.text(0);
                        done.text(0);
                        sched.text(0);
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function GetApptCounts(start) {
            var Total = $("[id*='lblAddTotal']");
            var comp = $("[id*='lblAddComp']");
            var dispdate = $("[id*='lbldispday']");
            var weekday = new Array(7);
            weekday[0] = "Sunday";
            weekday[1] = "Monday";
            weekday[2] = "Tuesday";
            weekday[3] = "Wednesday";
            weekday[4] = "Thursday";
            weekday[5] = "Friday";
            weekday[6] = "Saturday";
            var date = new Date(start);
            var test = weekday[date.getDay()];
            //alert(test);
            $.ajax({
                url: "Calendar.aspx/GetCounts",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'i':'1','date':'" + start + "'}",
                dataType: "json",
                success: function (data) {
                    var obj = data.d;
                    if (obj.length > 0) {
                        comp.empty();
                        dispdate.text(data.d[0].Date);
                        //Total.text(start + '  ' + test);
                        Total.text(data.d[0].Date + '  ' + test);
                        comp.text(data.d[0].Scheduled);
                    } else {
                        comp.empty();
                        dispdate.text(data.d[0].Date);
                        Total.text(data.d[0].Date + '  ' + test);
                        comp.text(0);
                    }
                    //alert(data.d[0].Total);
                    //Total.empty();                   
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function NewUpdateTasks(commnts, sts, stscommnts) {
            var Taskid = $("[id*='hbtnRSN']").val();
            //var x = confirm('Do you want to submit?');
            $.ajax({
                url: "Calendar.aspx/UpdateTasks",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                //data: "{'Taskid':'" + Taskid + "','comments':'" + commnts + "','date':'" + txtudate + "','status':'" + sts + "'}",
                data: "{'Taskid':'" + Taskid + "','comments':'" + commnts + "','status':'" + sts + "','stscommnts':'" + stscommnts + "'}",
                dataType: "json",
                success: function (data) {
                    var obj = data.d;
                    if (obj == 'true') {
                        alert('Appointment details updated successfully');
                        //DisplayCalendar();
                    } else {
                        alert('error');
                    }
                },
                error: function (res) {
                    alert(res.responseText);
                }
            });
        }
        function OpenNewUpdateTasks(start) {
            //$("#calender").hide();
            $("#calender").css("opacity", "0.6");
            GetUpdateDetails(start);
            $("[id*='dvTasksUpdate']").dialog({
                autoopen: false,
                title: "Update Appointment",
                width: "auto",
                height: 250,
                modal: false,
                open: function (event, ui) { $(".ui-dialog-titlebar-close").hide(); },
                buttons: {
                    Done: function () {
                        var x = confirm('Appointment will be marked as Completed.OK?');
                        if (x) {
                            var tudetails = $("[id*='lbltaskudetails']").text();
                            var tfdate = $("[id*='lbltaskudate']").text();
                            NewUpdateTasks(tudetails, '98', 'Done');
                            var date = new Date();
                            var yr = date.getFullYear();
                            var month = date.getMonth() + 1;
                            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                            var newdate = yr + '-' + month + '-' + day;
                            GetApptCountsAll(newdate);
                        }
                    },
                    Cancelled: function () {
                        var x = confirm('Appointment will be marked as Cancelled.OK?');
                        if (x) {
                            var tudetails = $("[id*='lbltaskudetails']").text();
                            var tfdate = $("[id*='lbltaskudate']").text();
                            NewUpdateTasks(tudetails, '98', 'Cancelled');
                            var date = new Date();
                            var yr = date.getFullYear();
                            var month = date.getMonth() + 1;
                            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                            var newdate = yr + '-' + month + '-' + day;
                            GetApptCountsAll(newdate);
                        }
                    },
                    Close: function () {
                        $("#calender").css("opacity", "");
                        DisplayCalendarByUsers();
                        $(this).dialog('close');
                    }
                }
            });
           // $('.ui-widget-overlay').css('background', 'yellow');
        }
        function GetUpdateDetails(start) {
            var taskid = $("[id*='hbtnRSN']").val();
            var tudate = $("[id*='lbltasksufor']");
            var tudetails = $("[id*='lbltaskudetails']");
            var tassign = $("[id*='lbltasksuassignto']");
            var tfdate = $("[id*='lbltaskudate']");
            $.ajax({
                url: "Calendar.aspx/GetTasksDetails",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'taskid':'" + taskid + "'}",
                dataType: "json",
                success: function (data) {
                    $(data.d).find('temp').each(function () {
                        var fdate = $(this).find('Followupdate').text();
                        var fName = $(this).find('Name').text();
                        var fdetails = $(this).find('Comments').text();
                        var fassign = $(this).find('Assignedto').text();
                        //alert(fdate);
                        //var date = new Date(fdate);
                        ////alert(Fdate);
                        //var yr = date.getFullYear();
                        ////alert(yr);
                        //var month = date.getMonth() + 1;
                        ////alert(month);
                        //var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                        //var newdate = yr + '-' + month + '-' + day;
                        tfdate.text(start);
                        tudate.text(fName);
                        tudetails.text(fdetails);
                        tassign.text(fassign);
                    });
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function GetUpdateDetailsOld() {
            var taskid = $("[id*='hbtnRSN']").val();
            var tudate = $("[id*='lbltasksufor']");
            var tudetails = $("[id*='lbltaskudetails']");
            var tassign = $("[id*='lbltasksuassignto']");
            var tfdate = $("[id*='lbltaskudate']");
            $.ajax({
                url: "Calendar.aspx/GetTasksDetails",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'taskid':'" + taskid + "'}",
                dataType: "json",
                success: function (data) {
                    $(data.d).find('temp').each(function () {
                        var fdate = $(this).find('Followupdate').text();
                        var fName = $(this).find('Name').text();
                        var fdetails = $(this).find('Comments').text();
                        var fassign = $(this).find('Assignedto').text();
                        alert(fdate);
                        tfdate.text(fdate);
                        tudate.text(fName);
                        tudetails.text(fdetails);
                        tassign.text(fassign);
                    });
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function AddNewTask(dropdownfor, Assign, details, Fdate) {
            //alert(Fdate);
            $.ajax({
                url: "Calendar.aspx/AddTask",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'CustName':'" + dropdownfor + "','AssignTo':'" + Assign + "','Tasks':'" + details + "','Fdate':'" + Fdate + "'}",
                dataType: "json",
                success: function (data) {
                    var res = data.d;
                    if (res == "false") {
                        alert('Error');
                    } else {
                        //DisplayCalendar();
                        alert('The appointment will now appear in the appointment list of the concerned person');
                        //DisplayCalendarByUsers();
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function Navigate(date) {
            var x = confirm('Are you sure want to book appointment on ' + date + '?')
            if (x) {
                var group = 'Group=' + 'Marketing' + '&' + 'Date=' + date;
                var url = 'Addnewtask.aspx?' + group;
                window.open(url, "Appointment", "status=no,Height=600,width=800,left=300,right=300,top=100,bottom=200");
            } else {
                return;
            }
        }

        function LoadAssigned() {
            var ddlstaff = $("[id*='ddlAssignto']");
            $.ajax({
                url: "Calendar.aspx/LoadAssignedTo",
                type: "POST",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    ddlstaff.empty();
                    $(data.d).find('temp').each(function () {
                        var optval = $(this).find('UserID').text();
                        var opttext = $(this).find('UserName').text();
                        var option = $("<option>" + opttext + "</option>");
                        option.attr("value", optval);
                        ddlstaff.append(option);
                    })
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function LoadDropdown() {
            var test = $("[id*='ddlFor']");
            //alert(test);
            $.ajax({
                url: "Calendar.aspx/LoadProspectCustomer",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    // alert(data.d);   
                    test.empty();
                    test.append($('<option></option>').val(0).html('Please Select'));
                    $(data.d).find('test').each(function () {
                        var optval = $(this).find('CustRSN').text();
                        var optext = $(this).find('Name').text();
                        //var option = $("<option>" + optext + "</option>");
                        //option.attr("value", optval);                       
                        //cust.append(option);
                        //alert(optval);
                        test.append($('<option></option>').val(optval).html(optext));
                    });
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function OpenModelPopup(start) {
            $("#calender").css("opacity", "0.6");
            //LoadDropdown();  Hide for dropdownlist for customer
            LoadAssigned();
            LoadSaveTime();
            $("[id*='dvPros']").show();
            //$("#calender").hide();
            var date = new Date();
            $("[id*='ddlFor']").val('0');
            //$.datepicker.formatDate('yy-mm-dd');
            //$("[id*='txtDate']").val(start);
            $("[id*='txtDate']").datepicker("setDate", start);
            $("#dvTasks").dialog({
                title: "New Appointment",
                autoopen: false,
                closeOnEscape: true,
                width: "auto",
                height: "auto",
                position: { my: "center", at: "center", of: window },
                modal: false,                
                open: function (event, ui) {
                    $(".ui-dialog-titlebar-close").hide();
                    $(ui).find("[id*='txtDate']").datepicker().click(function () {
                        $(this).datepicker('show');
                    });
                },
                buttons: {
                    Save: function () {
                        var time = $("[id*='txtTimer']").val();
                        var date = $("[id*='txtDate']").val();
                        var newdate = date + ' ' + time;
                        if (time == '') {
                            alert('Please select a Time');
                            return;
                        }
                        var details = $("[id*='txtDetails']").val();
                        var dropdownfor = $("[id*='hbtnFor']").val();
                        var fordetails = $("[id*='txtFor']").val();
                        var Name = $("[id*='txtName']").val();
                        var Mobile = $("[id*='txtmno']").val();
                        var Email = $("[id*='txtEmail']").val();
                        if ((dropdownfor == '' || fordetails == '')  && (Name == '' || Mobile == '')) {
                            alert('Please Enter customer name or Add new Customer Name and Mobile number.');
                            return;
                        }
                        if (details != '') {
                            if (dropdownfor == '') {
                                if (Email != '') {
                                    if (!IsEmail(Email)) {
                                        alert('Please enter valid email address');
                                        return;
                                    }
                                }
                                if (!validatePhone(Mobile)) {
                                    alert('Please enter valid mobile number');
                                    return;
                                }
                            }
                        } else {
                            alert('Please enter details');
                            return;
                        }
                        if ($("[id*='chkAppointment']").is(":checked")) {
                            $.ajax({
                                url: "Calendar.aspx/CheckAppointments",
                                type: "POST",
                                data: "{'date':'" + newdate + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    var obj = data.d;
                                    var Name, Activity;
                                    if (obj == "false") {
                                        var x = confirm('Do you want to submit?');
                                        if (x) {
                                            AddNewTasks();
                                            var date = new Date();
                                            var yr = date.getFullYear();                                            
                                            var month = date.getMonth() + 1;                                           
                                            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                                            var newdate = yr + '-' + month + '-' + day;
                                            GetApptCountsAll(newdate);
                                            $("[id*='txtFor']").val('');
                                            $("[id*='hbtnFor']").val('');
                                            $("[id*='txtTimer']").val('');
                                            $("[id*='txtName']").val('');
                                            $("[id*='txtmno']").val('');
                                            $("[id*='txtEmail']").val('');
                                            $("[id*='txtDetails']").val('');
                                        } else {
                                            return;
                                        }
                                    } else {
                                        $("[id*='txtTimer']").val('');
                                        alert('Appointment already fixed for the time that you have chosen');
                                    }
                                },
                                error: function (response) {
                                    alert(response.responseText);
                                }
                            });
                        }
                        else {
                            var x = confirm('Do you want to submit?');
                            if (x) {
                                AddNewTasks();
                                var date = new Date();
                                var yr = date.getFullYear();
                                var month = date.getMonth() + 1;
                                var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                                var newdate = yr + '-' + month + '-' + day;
                                GetApptCountsAll(newdate);
                                $("[id*='txtFor']").val('');
                                $("[id*='hbtnFor']").val('');
                                $("[id*='txtTimer']").val('');
                                $("[id*='txtName']").val('');
                                $("[id*='txtmno']").val('');
                                $("[id*='txtEmail']").val('');
                                $("[id*='txtDetails']").val('');
                            }
                        }
                    },
                    Clear: function () {
                        $("[id*='txtTimer']").val('');
                        $("[id*='txtFor']").val('');
                        $("[id*='hbtnFor']").val('');
                        $("[id*='txtName']").val('');
                        $("[id*='txtmno']").val('');
                        $("[id*='txtEmail']").val('');
                        $("[id*='txtDetails']").val('');
                    },
                    Close: function () {
                        $("#calender").css("opacity", "");
                        DisplayCalendarByUsers();
                        $(this).dialog('close');
                    }
                }
            });
        }
        function DisplayCalendar() {
            //LastAccess = DisplayCalendar;
            $.ajax({
                type: "POST",
                contentType: "application/json",
                data: "{}",
                url: "Calendar.aspx/GetEvents",
                dataType: "json",
                success: function (data) {
                    $('div[id*=calender]').empty();
                    $('div[id*=calender]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'
                        },
                        height: 450,
                        selectable: true,
                        theme: true,
                        //defaultDate: moment(Date).format('DD/MM/YYYY'),
                        editable: true,
                        droppable: true,
                        draggable: true,
                        selectable: true,
                        selectHelper: true,
                        //contentHeight: 300,
                        //eventTextColor: 'White',
                        //eventBackgroundColor: 'purple',
                        events:
                        $.map(data.d, function (item, i) {
                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            event.end = item.EndDate;
                            event.title = item.EventName;                           
                            //event.url = item.EventName;
                            event.color = item.color;
                            //event.dow = [1];
                            //event.rendering = 'background';
                            return event;
                        }),
                        eventsources: [
                            { editable: true }
                        ],
                        eventClick: function (event) {
                            // alert(event.id);
                            var color = event.color;
                            if (color != '#008000') {
                                $("[id*='hbtnRSN']").empty();
                                $("[id*='hbtnRSN']").val(event.id);
                                var test = $("[id*='hbtnRSN']").val();
                                //alert(test);
                                $("[id*='dvPros']").hide();
                                var start = $.fullCalendar.formatDate(event.start, 'yyyy-MM-dd hh:mm');
                                OpenUpdateTasks(start);
                                return false;
                            }
                        },
                        eventAfterRender: function (event, element) {
                            //$(element).css('height', '50px');
                            //alert(event.status);  // can change color events
                        },
                        eventMouseover: function (event, jsEvent) {
                            //alert(event.title);             
                            $(jsEvent.target).attr('title', event.title + '\n' + event.start);
                        },
                        eventMouseout: function (event) {

                        },
                        eventRender: function (event, element) {
                            $(element).tooltip({ tooltip: event.title });
                        },
                        select: function (start, allday) {
                            //alert(view);
                            var check = $.fullCalendar.formatDate(start, 'yyyy-MM-dd');
                            var today = $.fullCalendar.formatDate(new Date(), 'yyyy-MM-dd');

                            var Passdate = $.fullCalendar.formatDate(start, 'dd-MMM-yyyy');
                            //alert(check);
                            //alert(today);

                            if (check < today) {
                                alert('Please select future date');
                                return;
                            } else {
                                //Navigate(Passdate);      
                                OpenModelPopup(check);
                            }
                        }
                    });
                    $("#calender").fullCalendar('refetchEvents');
                    //$("#pnlCalender").show().css('visibility', 'visible');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });
        }

        function OpenUpdateTasks(fdate) {
            $("#calender").hide();
            $("[id*='txtudate']").datepicker({ autoopen: false, dateFormat: 'yy-mm-dd' })
            //$.datepicker.formatDate('yy-mm-dd', fdate);
            var newdate = new Date(fdate);
            var hr = newdate.getHours() + ":" + newdate.getMinutes();
            //alert(fdate);
            //alert(hr);
            $("[id*='txtudate']").val(fdate);
            $.datepicker.formatDate('yy-mm-dd');
            $("[id*='txtutimer']").val(hr);
            $("#dvUTasks").dialog({
                title: "Update Appointment",
                autoopen: false,
                height: 'auto',
                width: 'auto',
                buttons: {
                    Save: function () {
                        //alert('test');                       
                        UpdateTasks();                       
                        $("[id*='txtprogwork']").val('');
                    },
                    Clear: function () {
                        $("[id*='txtprogwork']").val('');
                    },
                    Close: function () {
                        //$("#calender").hide();
                        DisplayCalendarByUsers();
                        $("#calender").show();
                        $(this).dialog('close');

                    }
                }
            });
        }
        function UpdateTasks() {
            var Taskid = $("[id*='hbtnRSN']").val();
            var commnts = $("[id*='txtprogwork']").val();
            var fdate = $("[id*='txtudate']").val();
            var sts = $("[id*='ddlstatus']").val();
            var Time = $("[id*='txtutimer']").val();
            if (commnts == '') {
                alert('Please enter the progress of appointment');
                return;
            }
            var date = new Date(fdate);
            //alert(Fdate);
            var yr = date.getFullYear();
            //alert(yr);
            var month = date.getMonth() + 1;
            //alert(month);
            var day = +date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
            var newdate = yr + '-' + month + '-' + day + ' ' + Time;
            var x = confirm('Do you want to submit?');
            if (x) {
                $.ajax({
                    url: "Calendar.aspx/UpdateTasks",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //data: "{'Taskid':'" + Taskid + "','comments':'" + commnts + "','date':'" + txtudate + "','status':'" + sts + "'}",
                    data: "{'Taskid':'" + Taskid + "','comments':'" + commnts + "','status':'" + sts + "','date':'" + newdate + "'}",
                    dataType: "json",
                    success: function (data) {
                        var obj = data.d;
                        if (obj == 'true') {
                            alert('Appointment details updated successfully');
                            //DisplayCalendar();
                        } else {
                            alert('error');
                        }
                    },
                    error: function (res) {
                        alert(res.responseText);
                    }
                });
            } else {
                return;
            }

        }
    </script>
    <script type="text/javascript">
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();
            var navigateUrl = item.get_navigateUrl();
           // alert(navigateUrl);
            if (navigateUrl == "#") {
                NavigateNewComplaints();
            }            
        }
        function NavigateNewComplaints() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (500 + 10);
            iMyHeight = (window.screen.height / 2) - (300 + 25);
            //alert('test');
            var Y = 'AddNewComplaints.aspx';
            var win = window.open(Y, "Window2", "status=no,height=620,width=1000,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div>
                <asp:HiddenField ID="hbtnRSN" runat="server" Value="test" />
                <asp:HiddenField ID="hbtnFor" runat="server" />
                <table style="width: 100%">
                    <tr style="width: 100%;">
                        <td style="width: 5%;" align="left">
                            <telerik:RadMenu Font-Names="verdana" Width="110px" ForeColor="Blue" ID="rmenuQuick" runat="server" ShowToggleHandle="false" Skin="Outlook" OnClientItemClicking="onClicking" EnableRoundedCorners="true" EnableShadows="true" ClickToOpen="false" ExpandAnimation-Type="OutBounce" Flow="Vertical" DefaultGroupSettings-Flow="Horizontal">
                                <Items>
                                    <telerik:RadMenuItem Font-Names="Verdana" PostBack="false" Text="Quick Links" ExpandMode="ClientSide" ToolTip="Click here to view quick links" Width="110px">
                                        <Items>
                                            <telerik:RadMenuItem Width="75px" Font-Bold="false" Text="MyTasks" NavigateUrl="Mytasks.aspx" ToolTip="View and manage tasks (activities/work) assigned to you." PostBack="false"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="55px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="ByMe" NavigateUrl="ByMe.aspx" ToolTip="Tasks delegated by me and assigned by me."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="85px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Customers" NavigateUrl="Customers.aspx" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="90px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Infographics" NavigateUrl="BusinessDashboard.aspx" ToolTip="Click here to open business dashboard."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Reports" NavigateUrl="SMReports.aspx" ToolTip="Click here to open Reports."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Settings" NavigateUrl="Admin.aspx" ToolTip="Click here to manage users and system parameters."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Customer Care" ToolTip="Register a Customer Complaint or a Service Request or a Warranty Service here."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Appointments" NavigateUrl="Calendar.aspx" ToolTip="Click to enter a new appointment or to view calendar appointments."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Recharge" NavigateUrl="PayDetails.aspx" ToolTip="Click to Recharge you BinCRM account."></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </td>
                        <td align="center" style="width: 80%;">
                            <asp:Label ID="Label41" runat="server" Text="Appointments" Font-Size="Large"
                                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                        </td>
                        <td align="right" style="width: 5%;">
                            <asp:ImageButton ID="ImageButton2" PostBackUrl="~/Home.aspx" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
                        </td>
                        <td style="width: 2%;" align="right" valign="middle">
                            <asp:LinkButton ID="Label14" Height="10px" Font-Underline="false" PostBackUrl="~/Home.aspx" ToolTip="Click here to return back to home" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
                        </td>
                        <td style="width: 2%;" align="right">
                            <asp:ImageButton ID="ImageButton3" PostBackUrl="~/Login.aspx" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                        </td>
                        <td style="width: 6%;" align="left" valign="middle">
                            <asp:LinkButton ID="Label39" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work." Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="width: 100%; min-height: 600px; max-width: auto; border: solid 4px Blue; border-radius: 10px 10px;">
                <div>
                    <table style="width: 99%;">
                        <tr>
                            <td align="left" style="width:77%;">
                                <div id="dvAdminRights" runat="server" style="font-family: Verdana; font-size: small;">
                                    <table>
                                        <tr>
                                            <td style="font-weight: bold;">User :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlStaff" ToolTip="Level 1 and Level 2 users can view appointments of all users.Users in levels 3,4 and more can view only appointments scheduled in their name.#Reference code used = #Aptmnt" runat="server" Width="130px">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnstaffsearch" CssClass="Button" runat="server" Text="View" ToolTip="Click here to view the appointments for the selected month/week/date" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnstaffviewall" CssClass="Button" runat="server" Text="View All" Visible="false" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnPopuphelp" runat="server" Text="Help" CssClass="Button" />
                                            </td>                                            
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td align="right" style="font-family: Verdana;text-align: left; color: blueviolet; font-size: small;width:22%;">
                                <asp:Label ID="lblPending" runat="server" Text="For Today Total:"></asp:Label>
                                <asp:Label ID="lbltotcount" runat="server" ForeColor="Black"></asp:Label>&nbsp;
                                <asp:Label ID="lblCompleted" runat="server" Text="Done:"></asp:Label>
                                <asp:Label ID="lbldonecount" runat="server" ForeColor="Black"></asp:Label>&nbsp;
                                <asp:Label ID="lblUpcoming" runat="server" Text="Due:"></asp:Label>
                                <asp:Label ID="lblschedcount" runat="server" ForeColor="Black"></asp:Label>    <br />
                                <img src="Calender/ok.png" height="10px" width="10px" alt="Completed" /> <text style="color:gray;font-weight:bold;">Completed</text>   &nbsp;&nbsp;
                                <img src="Calender/cancel.png" height="10px" width="10px" alt="Cancelled" /> <text style="color:gray;font-weight:bold;">Cancelled</text>                           
                            </td>                            
                        </tr>
                        <tr>
                            <td colspan="2">
                                <b>Prev | Next</b>
                                <div id="calender"></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dvTasks" style="display: none; width: 100%;">
                    <table style="width: 100%;">
                        <tr>
                            <td>Date :</td>
                            <td>
                                <asp:TextBox ID="txtDate" runat="server" Width="80px" TabIndex="-1"></asp:TextBox> 
                                <asp:Label ID="lbldispday" runat="server" Font-Size="Smaller" Font-Bold="true" ForeColor="Green"></asp:Label>
                                Time : 
                                <asp:TextBox ID="txtTimer" runat="server" Width="60px" TabIndex="-1"></asp:TextBox>
                            </td>
                            <td>
                                <%-- &nbsp;--%>
                                <asp:CheckBox ID="chkAppointment" TabIndex="-1" Checked="true" runat="server" ToolTip="If Unchecked, half hour time slots for the entire 24 hours are displayed.If Checked,time slots between 8AM to 9PM alone are displayed.A Validation occurs later, to warn if there is a clash of appointment for the same time slot." Text="Show from 8AM to 9PM." />
                                &nbsp;
                               <%-- <text style="color:green;font-size:13px;text-align:right;font-weight:bold;"> For Today Done: </text>--%>
                                <asp:Label ID="lblAddTotal" runat="server" Font-Bold="true" Font-Size="14px" Text="0"></asp:Label>
                                &nbsp;
                                <text style="color: green; font-size: 13px; text-align: right; font-weight: bold;"> Scheduled: </text>
                                <asp:Label ID="lblAddComp" runat="server" Font-Bold="true" Font-Size="14px" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr style="width: 100%;">
                            <td style="width: 10%;">For :
                            </td>
                            <td style="width: 15%;">
                                <asp:TextBox ID="txtFor" TabIndex="1" runat="server" Width="250px" Visible="true" ToolTip="Click HELP button in the main Calendar screen to learn how to select a customer or to add a new lead."></asp:TextBox>
                                <asp:DropDownList ID="ddlFor" Visible="false" runat="server" Width="250px" ToolTip="Click HELP button in the main Calendar screen to learn how to select a customer or to add a new lead.">
                                    <%--<asp:ListItem Value="0" Text="Please Select"></asp:ListItem>--%>
                                </asp:DropDownList>
                                <asp:Label ID="lblOR" Font-Bold="true" runat="server" Text="OR"></asp:Label>
                            </td>
                            <td style="width: 100%;">
                                <div id="dvPros" style="width: 100%;">
                                    <table style="font-family: Verdana; font-size: small; width: 100%;">
                                        <tr style="width: 100%;">
                                            <td>Mr.:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMr" runat="server">
                                                    <asp:ListItem Text="Mr." Value="Mr."></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
                                                    <asp:ListItem Text="Ms." Value="Ms."></asp:ListItem>
                                                    <asp:ListItem Text="Biz." Value="Biz."></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>Name<text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                            </td>
                                            <td>Mobile No<text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtmno" runat="server"></asp:TextBox>
                                            </td>
                                            <td>Email ID
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Details : &nbsp;<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDetails" TextMode="MultiLine" runat="server" Width="300" Height="70"></asp:TextBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Save Time :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSavetime" runat="server"></asp:DropDownList>
                                &nbsp;
                                <asp:ImageButton ID="ibtnsavetime" runat="server" ImageUrl="~/Calender/add1.png" ToolTip="Select from a standard picklist of frequently used sentences and press the + button." />
                            </td>
                            <td align="left">
                                <asp:Button ID="btnAddsavetime" runat="server" Text="SaveTime" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments. Remember whatever you add once is available everywhere in the system." />
                                <div id="dvSaveTime" style="display: none;">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSavetimeTitle" runat="server" Text="Add to PickList to SaveTime"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtAddSavetime" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnclosesave" runat="server" Text="Submit" />
                                                <asp:Button ID="newbtnsavetimeinfo" runat="server" Text="Close" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Assigned To :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAssignto" runat="server"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Hide" />
                            </td>
                            <td align="left">
                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="Hide" />
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </div>
                <div id="dvHelp" style="display: none; background-color: beige; height: 300px; width: 300px;">
                    <table style="font-family: Verdana; font-size: small;">
                        <tr>
                            <td>
                                <text style="color: green;">What is an appointment?</text>
                                <br />
                                <text style="color: black;">What you add in the calendar could be an appointment scheduled for a customer.<br />
                                     It can also be a self-reminder for the To-Do Lists.</text>
                                <br />
                                <br />
                                <text style="color: green;">How to add a new appointment? </text>
                                <br />
                                <text style="color: black">
                                    Here you can register a new appointment for a particular time slot for a particular day <br />
                                    (today or in future upto next six months)
                                    <br />
                                    Select the date from the calendar which pops up when you place the cursor on the date field.<br />
                                    Select the time slot.<br /> 
                                    The appointment can be for an existing customer or for some one new prospective customer.<br />
                                    First select if the customer is a Lady  (Ms. Or Miss or Mrs.)   or a Gentleman (Mr.)  <br />
                                    or if it is for some business establishment (Biz.).<br />
                                </text>
                                <br />
                                <text style="color: green;">How to fix an appointment for an existing customer? </text>
                                <br />
                                <text style="color: black">
                                    Type first three letters of the name to view list of matching names.Select the name.<br />
                                </text>
                                <br />
                                <text style="color: green;">How to fix an appointment for a new prospective customer? </text>
                                <br />
                                <text style="color: black">
                                    A prospective customer is one who has not yet done any business with your company.<br />
                                    He/she is known as a customer only after the first appointment is completed.<br />
                                    Type the name of the customer, his/her mobile number and email id.  <br />
                                    Mobile number is important to call the customer if needed. <br />
                                    Email Id is important for the system to send automatic reminders and thank you notes. <br />
                                    Let us move on….. <br />
                                    Enter some details on the particular reason for which the appointment is being booked. <br />
                                    Press SAVE button.  (But be sure you have entered all the details correctly). <br />
                                    The SAVE initiates the appointment confirmation.  <br />
                                    An EMAIL is sent to the user to whom the work is assigned immediately. <br />
                                    An EMAIL also goes to the customer immediately.<br />
                                    In addition, a reminder is also sent to the customer one day before the appointment date.<br />
                                </text>
                                <br />
                                <text style="color: green;">How to close an appointment after it is over?</text>
                                <br />
                                <text style="color: black">
                                    This step is very important. The system is not a fortune teller to know what happened. <br />
                                     If the appointment happened, mark it as ‘Done’ (Completed). <br />
                                     If it did not happen and got cancelled for some reason, mark it ‘Cancelled’. <br />
                                    If this is not done, the appointment will appear in RED the next day and will be considered as Overdue tasks.<br />
                                </text>
                                <br />
                                <text style="color: green;">How to close an appointment even before it is due?</text>
                                <br />
                                <text style="color: black">
                                    Follow the same step as described above.<br />
                                </text>
                                <br />
                                <text style="color: green;">What happens if the prospective customer never turns up?</text>
                                <br />
                                <text style="color: black">
                                    Mark the appointment as Cancelled. The Prospective name automatically goes to the DROPPED bin.<br />
                                </text>
                                <br />
                                <text style="color: green;">What happens if the prospective customer does turn-up?</text>
                                <br />
                                <text style="color: black">
                                   This is what we all want. More customers. <br />
                                   When the appointment is completed, the prospective customer becomes a customer and a thank you mail goes to him/her.<br />
                                   Next time, select his/her name from the existing customer list.<br />
                                   Various EMAILS are sent to the customer and the assignee user. <br />
                                   When the appointment is registered and when it is completed or cancelled. <br />
                                   One day before the appointment date, as a reminder. <br />
                                   These help the customer to plan his/her time. <br />
                                </text>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dvUTasks" style="display: none;" class="center">
                    <table style="width: 600px;">
                        <tr>
                            <td style="width: 200px;">Progress of Appointment : &nbsp;<asp:Label ID="lblprog" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td style="width: 400px;">
                                <asp:TextBox ID="txtprogwork" runat="server" Width="350px" Height="55px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Status :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlstatus" runat="server" Width="150px">
                                    <asp:ListItem Text="InProgress" Value="01"></asp:ListItem>
                                    <asp:ListItem Text="Completed" Value="98"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Appointment On:
                            </td>
                            <td>
                                <asp:TextBox ID="txtudate" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Time :
                            </td>
                            <td>
                                <asp:TextBox ID="txtutimer" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnUSave" runat="server" Text="Save" CssClass="Hide" />
                                <asp:Button ID="btnUCancel" runat="server" Text="Clear" CssClass="Hide" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dvTasksUpdate" style="display: none; width: 100%;">
                    <table style="width: 100%;">
                        <tr>
                            <td style="font-weight: bold;">Date :</td>
                            <td>
                                <asp:Label ID="lbltaskudate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">For :
                            </td>
                            <td>
                                <asp:Label ID="lbltasksufor" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">Details :
                            </td>
                            <td>
                                <asp:Label ID="lbltaskudetails" runat="server"></asp:Label>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">Assigned To :
                            </td>
                            <td>
                                <asp:Label ID="lbltasksuassignto" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress AssociatedUpdatePanelID="upnlMain" ID="upnlprogress" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                    <br />
                    <asp:ImageButton ID="btnUpdateLoad" runat="server" ImageUrl="~/images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

</asp:Content>

