<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SMReports.aspx.cs" Inherits="SMReports"  MasterPageFile="~/MasterPage.master" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%--<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>--%>
<%--<%@ Register Assembly="DayPilot.MonthPicker" Namespace="DayPilot.Web.UI" TagPrefix="DayPilot" %>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">   
     
    <script src="Calender/jquery-1.10.2.js" type="text/javascript"></script>  
    <script src="Calender/fullcalendar.js" type="text/javascript"></script>
    <link href="Calender/fullcalendar.css" rel="stylesheet" />
    <script src="Calender/jquery.validate.js" type="text/javascript"></script>
    <script src="Calender/moment.js" type="text/javascript"></script>
    <link href="Calender/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            // DisplayCalendar();
            $("[id*='pnlCalender']").hide();
        });
        function Navigate(date) {
            var x = confirm('Are you sure want to book appointment on '+ date + '?')
            if (x) {
                var group = 'Group=' + 'General' +'&' +'Date='+ date;
                var url = 'Addnewtask.aspx?'+ group;
                window.open(url, "Appointment","status=no,Height=600,width=800,left=300,right=300,top=100,bottom=200");
            } else {
                return;
            }           
        }
        function DisplayCalendar() {
            $("[id*='pnlCalender']").show();
            $.ajax({
                type: "POST",
                contentType: "application/json",
                data: "{}",
                url: "SMReports.aspx/GetEvents",
                dataType: "json",
                success: function (data) {
                    $('div[id*=calender]').empty();                    
                    $('div[id*=calender]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'
                        },
                        height: 500,
                        selectable: true,
                        theme: true,
                        //defaultDate: moment(Date).format('DD/MM/YYYY'),
                        editable: true,
                        droppable: true,
                        draggable: true,
                        selectable: true,
                        selectHelper: true,
                        //eventTextColor: 'White',
                        //eventBackgroundColor: 'purple',
                        events:
                        $.map(data.d, function (item, i) {
                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            //event.end = item.EndDate;
                            event.title = item.EventName;
                            event.allDay = false;
                            event.dow = [1, 2, 3, 4];
                            event.rendering = 'background';
                            return event;
                        }),
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
                              Navigate(Passdate);
                          }                         
                        }
                    });
                    //$("#calender").fullCalendar('refetchEvents');
                    //$("#pnlCalender").show().css('visibility', 'visible');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });
        }
    </script>
     <script type="text/javascript" src="js/Disablebackbtn.js"></script>   
    <script type="text/javascript">
        SMReports();
    </script>
    <title>SM Reports</title>

    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/adminCenterPositionCSS.css" rel="stylesheet" />
     <link href="css/MenuCSS.css" rel="stylesheet" />    
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />
    <link href="css/demo.css" rel="Stylesheet" />

    <style type="text/css">
        .ButtonVisible {
           visibility:hidden;
        }
    </style>

    <style type="text/css">
        .modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 80px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 128px;
                width: 80px;
            }

        .Button {
            background-color: #008dde;
            border: none;
            border-radius: 3px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            color: #f4f4f4;
            cursor: pointer;
            font-family: 'Open Sans', Verdana, Helvetica, sans-serif;
            height: 50px;
            text-transform: uppercase;
            width: 300px;
            -webkit-appearance: none;
        }

        .rwbackcolor {
            background-color: beige;
        }
    </style>
    <style type="text/css">
        .button_example {
            border: 1px solid #25729a;
            -webkit-border-radius: 3px;
            font-stretch: normal;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 12px;
            font-family: verdana, sans-serif;
            padding: 5px 5px 5px 5px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #3093c7;
            background-image: -webkit-gradient(linear, left top, left bottom, from(#3093c7), to(#1c5a85));
            background-image: -webkit-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -moz-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -ms-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -o-linear-gradient(top, #3093c7, #1c5a85);
            background-image: linear-gradient(to bottom, #3093c7, #1c5a85);
            filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#3093c7, endColorstr=#1c5a85);
        }

            .button_example:hover {
                border: 1px solid #1c5675;
                background-color: #26759e;
                background-image: -webkit-gradient(linear, left top, left bottom, from(#26759e), to(#133d5b));
                background-image: -webkit-linear-gradient(top, #26759e, #133d5b);
                background-image: -moz-linear-gradient(top, #26759e, #133d5b);
                background-image: -ms-linear-gradient(top, #26759e, #133d5b);
                background-image: -o-linear-gradient(top, #26759e, #133d5b);
                background-image: linear-gradient(to bottom, #26759e, #133d5b);
                filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#26759e, endColorstr=#133d5b);
            }
    </style>
    <style type="text/css">
        .Activity {
            background-color: red !important;
        }

        .style2 {
            text-align: center;
        }

        .style3 {
        }
    </style>
    <script type="text/javascript">
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();
            var navigateUrl = item.get_navigateUrl();
            //alert(navigateUrl);
            if (navigateUrl == "#") {
                NavigateNewComplaints();
            }
            //if (navigateUrl && navigateUrl != "#") {
            //    var proceed = confirm("Click yes to proceed to" + navigateUrl);
            //}
            //if (!proceed) {
            //    eventArgs.set_cancel(true);
            //}
            //else {
            //    eventArgs.set_cancel(false);
            //}
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
        function ConfirmClick() {
            DisplayCalendar();
        }
    </script>     
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">

      <script type="text/javascript">
          function confirmCallbackFn(arg) {
              if (arg) //the user clicked OK
              {
                  __doPostBack("<%=HiddenButton.UniqueID %>", "");
              }
          }
    </script>

     <script type="text/javascript">
         function confirmMR1ExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonMR1Export.UniqueID %>", "");
             }
         }
    </script>

     <script type="text/javascript">
         function confirmMR3ExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonMR3Export.UniqueID %>", "");
             }
         }
    </script>

     <script type="text/javascript">
         function confirmMR4ExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonMR4Export.UniqueID %>", "");
             }
         }
    </script>

    

     <script type="text/javascript">
         function confirmMarActExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonMarActExport.UniqueID %>", "");
             }
         }
    </script>
       
     <script type="text/javascript">
         function confirmEnqRegExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonEnqRegExport.UniqueID %>", "");
             }
         }
    </script>

     <script type="text/javascript">
         function confirmQuoSubExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=HiddenButtonQuoSubExport.UniqueID %>", "");
             }
         }
    </script>
    
     <script type="text/javascript">
         function confirmOrdersSubExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=hbtnR4Orders.UniqueID %>", "");
             }
         }
    </script>
     
     <script type="text/javascript">
         function confirmServiceSubExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=hbtnR5serAct.UniqueID %>", "");
             }
         }
    </script>
       
      <script type="text/javascript">
          function confirmGeneralSubExportFn(arg) {
              if (arg) //the user clicked OK
              {
                  __doPostBack("<%=hbtnR6genAct.UniqueID %>", "");
              }
          }
    </script>  
     <script type="text/javascript">
         function confirmWorkProgSubExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=hbtnR7workprog.UniqueID %>", "");
             }
         }
    </script>  
    
    <%--SMX Reports --%> 
     <script type="text/javascript">
         function confirmCallbackFn1(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=btnHiddensmxExport.UniqueID %>", "");
             }
         }
</script>
         <script type="text/javascript">
             function confirmCallbackFn2(arg) {
                 if (arg) //the user clicked OK
                 {
                     __doPostBack("<%=btn2Hiddensmx2Export.UniqueID %>", "");
                 }
             }
</script>    

 <script type="text/javascript">
     function confirmCallbackFn6(arg) {
         if (arg) //the user clicked OK
         {
             __doPostBack("<%=btnHiddensmx5Export.UniqueID %>", "");
         }
     }
  </script>

    <script type="text/javascript">
        function confirmHrsSpentSubExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnR9hrsspent.UniqueID %>", "");
            }
        }
    </script>  
     <script type="text/javascript">
         function confirmROLSubExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=hbtnR11ROL.UniqueID %>", "");
             }
         }
    </script>  
     <script type="text/javascript">
         function confirmTimeConsumeExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=hbtnR12TimeCons.UniqueID %>", "");
             }
         }
    </script> 
     <script type="text/javascript">
         function confirmR13TimeDetailExportFn(arg) {
             if (arg) //the user clicked OK
             {
                 __doPostBack("<%=nbtnR13TimeDetail.UniqueID %>", "");
             }
         }
    </script>  
    <script type="text/javascript">
        function confirmR5SExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnR5SServices.UniqueID %>", "");
            }
        }
    </script>
    <script type="text/javascript">
        function confirmEODUsersExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnEODUsers.UniqueID %>", "");
            }
        }
    </script>
    <script type="text/javascript">
        function confirmEODCustomerExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnEODCustomers.UniqueID %>", "");
            }
        }
    </script>
    <script type="text/javascript">
        function confirmCompReportExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnCompReport.UniqueID %>", "");
            }
        }
    </script>
    <script type="text/javascript">
        function confirmRefReportExportFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=hbtnRefSummReport.UniqueID %>", "");
            }
        }
    </script>
    
        <div style ="width:100%;font-family:Verdana;background-color:beige;">

          <asp:UpdatePanel ID="uptab" runat="server" UpdateMode ="Conditional"  ChildrenAsTriggers="true">
              <ContentTemplate>              
            <table>
                <tr>                   
                    <td>                      
                        <telerik:RadWindow ID="rwDiary" VisibleOnPageLoad="false" Width="1000" MinHeight="400"  Font-Names="Verdana"
                                                                        runat="server" EnableShadow ="true" EnableEmbeddedSkins ="false" Modal ="true"  >
                                                                        <ContentTemplate>
                                                                            <div>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td align="left" >
                                                                                            <asp:Label ID="lbldiaryhead" runat="server" Text="All activities carried out for the selected profile"
                                                                                                CssClass="style2" ForeColor="DarkBlue" Font-Bold="true" ></asp:Label>
                                                                                            <asp:Label ID="lbldiaryheadName" runat="server" Text="" CssClass="style2" ForeColor="DarkBlue"
                                                                                                Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                                                            <asp:Label ID="lbldiaryheadStatus" runat="server" Text="" CssClass="style2" ForeColor="DarkGray"
                                                                                                Font-Size="Small"></asp:Label>
                                                                                            <asp:Button ID="btnDiaryClose" runat="server" Text="Close" CssClass="Button" Width="50px" Height="30px"
                                                                                                ToolTip="Click to return to Profile page." OnClick="btnDiaryClose_Click" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            
                                                                                            <%--<asp:Label ID="lbldiaryheadType" runat="server" Text="" CssClass="style2" ForeColor="DarkGray" Font-Size="Small"></asp:Label>--%>
                                                                                            
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            <asp:GridView ID="gvDiary" runat="server" AutoGenerateColumns="false" OnDataBound="onDataBound" 
                                                                                                AllowPaging="true" PageSize="10" OnPageIndexChanging="OnDiaryPaging">
                                                                                                <Columns>
                                                                                                    <asp:BoundField HeaderText="#" DataField="TaskID" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Reference" DataField="TrackOn" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Activities [InProgress entries in blue]" DataField="Comments" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="300px"
                                                                                                        ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Date" DataField="Datestamp" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="125px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="By" DataField="Userid" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="30px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Timespent" DataField="Timespent" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Followupdate" DataField="Followupdate" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Task Status" DataField="TaskStatus" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />

                                                                                                </Columns>
                                                                                            </asp:GridView><br />
                                                                                           <%-- <asp:Label ID="Label19" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Activity IDs in BLUE are currently in progress."></asp:Label><br />--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadWindow>                     
                    </td>
                    <td>
                        <telerik:RadWindow ID="rwCustomerProfile" VisibleOnPageLoad="false" Width="1000px" Height="400" Font-Names="Verdana" runat="server" Modal="true" CssClass="rwbackcolor">
                                            <ContentTemplate>
                                                <div style ="width:100%; float:left">
                                                <div style ="width:40%; float:left">
                                                    <table style="border-collapse: collapse; border: 1px solid black;font-family:Verdana;font-size:small">
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Label ID="lblcphead" runat="server" Text="Profile"  CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblcptitle" runat="server" Text="Title" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblscptitle" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpname" runat="server" Text="Name" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcategory" runat="server" Text="Category" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcategory" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcomapanyname" runat="server" Text="Main Contact/Company" Width="100px"
                                                                    CssClass="style2" ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcompanyname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcptype" runat="server" Text="Type" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscptype" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                      
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpdoorno" runat="server" Text="Door No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpdoorno" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstreet" runat="server" Text="Street" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstreet" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcity" runat="server" Text="City" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcity" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcppinzip" runat="server" Text="Pincode" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscppinzip" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstate" runat="server" Text="State" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstate" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcountry" runat="server" Text="Country" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcountry" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpphone" runat="server" Text="Phone No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpphone" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpmobile" runat="server" Text="Mobile No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpmobile" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail" runat="server" Text="EmailID" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail2" runat="server" Text="EmailID2" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail2" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>                                                     
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Button ID="btnCPClose" runat="server" Text="Close" CssClass="Button" Width="50px" Height="20px"
                                                                    OnClick="btnCPClose_Click" ToolTip="Click to close customer status history." />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style ="width:60%; float:left">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label16" runat="server" Text="Contacts within the Company" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                 <asp:GridView ID="gvrwcontacts" runat="server" EmptyDataText="No Records has been added."
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" Font-Names ="verdana" Font-Size ="X-Small"
                                                                                    DataKeyNames="RSN">
                                                                     <HeaderStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                     <RowStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Designation" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="EmailID" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="PhoneNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="MobileNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Department" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Location" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                       
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblcpinprogress"  runat="server" Font-Names="verdana"  Font-Size="X-Small" ForeColor="Black" BackColor="Yellow" Text="No of activities in progress now"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                    </div>
                                            </ContentTemplate>
                                        </telerik:RadWindow>                              

                    </td>
                     <td>  
                         <telerik:RadWindowManager ID="rwmMain" runat="server"></telerik:RadWindowManager>
                           <telerik:RadWindow ID="rwStatusHelp"  VisibleOnPageLoad="true" CenterIfModal="false" Width="400" Height="300"  Font-Names="Verdana"
                             runat="server" EnableShadow ="true" EnableEmbeddedSkins ="false" Modal ="true"  >
                             <ContentTemplate>
                                 <div style="background-color:white;">
                                  <table>
                               <tr>
                                   <td style ="font-size:smaller; color:darkgreen; font-weight:bold;font-family:Verdana" align="center">                                
                                 <asp:Label ID="Label37" runat="server" Text="Status Help" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                              </td>
                                 </tr>  
                               <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">                                
                                   <asp:Label ID="Label38" runat="server" Text="Profiles are classified into the following statuses" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                </td>
                               </tr>
                                <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">
                               <%--Recent -  Any profile added in the last three days (All Statuses included)--%>                   
                               <asp:Label ID="Label40" runat="server" Text="Customer, Vendor, Other and Leads." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                       </td> 
                               </tr>
                               <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">           
                                                        
                                   <asp:Label ID="Label51" runat="server" Text="Leads have these substatuses  - Registered, Warm and Hot." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                       </td> 
                                   </tr>                                 
                               <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">                               
                                       <asp:Label ID="Label73" runat="server" Text="Cold leads are those whose status is marked Cold." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                   </td> 
                                   </tr> 
                               <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">           
                                                           
                                <asp:Label ID="Label74" runat="server" Text="Dropped leads are those with whom no activities are planned." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                               </td>
                                   </tr>
                                <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana">
                                   <asp:Label ID="Label75" runat="server" Text="Recent means all profiles added in the last three days." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>            
                                                  
                                       </td>
                                    </tr>
                               <tr>
                                   <td style ="font-size:smaller; color:darkgray; font-weight:normal; font-family:Verdana"> 
                                   <asp:Label ID="Label76" runat="server" Text="All includes all Leads, Customers, Vendors,Others,Cold and Dropped." Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>            
                                                                 
                                       </td>
                                   </tr>
             
                               
                                        <tr>
                                           <td align="center" colspan="2">
                                            <asp:Button ID="btnHelpscrn" runat="server" Text="Close" CssClass="Button" Width="100px" OnClick="btnHelpscrn_Click" ToolTip="Click to close help screen." />
                                         </td>
                                        </tr>
                                   </table>
                                              </div>
                                      </ContentTemplate>
                         </telerik:RadWindow>                  
                    </td>                    
                </tr>
            </table>         
       
                   <table style="width: 100%">
                        <tr style="width:100%;">                            
                            <td align="center" style="width:80%;">
                                <asp:Label ID="Label41" runat="server" Text="Reports" Font-Size="Large" 
                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label> 
                            </td>
                             <td  style="width:5%;">
                      <telerik:RadMenu Font-Names="verdana" Width="110px" OnClientItemClicking="onClicking" ForeColor="Blue" ID="rmenuQuick" runat="server" ShowToggleHandle="false" Skin="Outlook" EnableRoundedCorners="true" EnableShadows="true" ClickToOpen="false" ExpandAnimation-Type="OutBounce" Flow="Vertical" DefaultGroupSettings-Flow="Horizontal"> 
                            <Items>
                                <telerik:RadMenuItem Font-Names="Verdana" PostBack="false" Text="Quick Links" ExpandMode="ClientSide" ToolTip="Click here to view quick links" Width="110px">
                                    <Items>
                                        <telerik:RadMenuItem Width="75px" Font-Bold="false" Text="MyTasks" NavigateUrl="Mytasks.aspx" ToolTip="View and manage tasks (activities/work) assigned to you." PostBack="false"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="55px" Font-Bold="false" ForeColor="Black"  BackColor="Transparent" Text="ByMe" NavigateUrl="ByMe.aspx" ToolTip="Tasks delegated by me and assigned by me."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="85px" Font-Bold="false" ForeColor="Black"  BackColor="Transparent" Text="Customers" NavigateUrl="Customers.aspx" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="90px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Infographics" NavigateUrl="BusinessDashboard.aspx" ToolTip="Click here to open business dashboard."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Reports" NavigateUrl="SMReports.aspx" ToolTip="Click here to open Reports."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Settings" NavigateUrl="Admin.aspx" ToolTip="Click here to manage users and system parameters."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem  Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Customer Care" ToolTip="Register a Customer Complaint or a Service Request or a Warranty Service here."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Appointments" NavigateUrl="Calendar.aspx" ToolTip="Click to enter a new appointment or to view calendar appointments."></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Recharge" NavigateUrl="PayDetails.aspx" ToolTip="Click to Recharge your BinCRM account."></telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenuItem>                               
                            </Items>      
                        </telerik:RadMenu>
                    </td>
                            <td align="right" style="width:5%;">                             
                                <asp:ImageButton ID="ImageButton2" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png"  ToolTip="Click here to return back to home" />
                            </td>
                            <td style="width:2%;" align="right" valign="middle">
                                <asp:LinkButton ID="Label14" Height="10px" Font-Underline="false" PostBackUrl="~/Home.aspx" ToolTip="Click here to return back to home" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server"/>
                            </td>
                             <td style="width:2%;" align="right">
                                 <asp:ImageButton ID="ImageButton3" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                             </td>
                              <td style="width:6%;" align="left" valign="middle">
                                <asp:LinkButton ID="Label39" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work." Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                            </td>
                        </tr>
                       <tr>
                           <td colspan="6" align="center">
                               <asp:Label ID="lblSMHelp" runat="server" ForeColor="Gray" Text="Select the report of your choice. Most of the reports have multiple selection options. Reports can be either viewed on screen or copied to an Excel sheet for further analysis." Font-Names="verdana" Font-Size="Smaller"></asp:Label>
                               <br />
                               <asp:Label ID="lblSmReporthelp" Font-Names="verdana" Font-Size="Small" runat="server" ForeColor="Gray" Text="Some reports are disabled (or) not available for level 3 and 4 users."></asp:Label>
                           </td>
                       </tr>
                    </table> 
                 
       <%-- Add by Prakash-28/08/2015-- --%>               
      <div style="width: 80%; margin: 100px auto;border-style:solid;border-width:3px;border-color:darkblue;border-radius: 10px;padding: 10px 40px; background-color:beige  " runat="server" id="dvHeaderMenu">                
            <table id="tblMain" runat="server" style="border-collapse: separate;border-spacing: 0 1em;background-color:beige;">
                <tr style="width: 80%; align-content:center;padding-top:5em;padding-bottom:5em;max-height:20px;">
                    <td style="width: 20%; text-align: center;font-size:small;">                       
                        <asp:Button ID="btnR1CusList" runat="server" Width="230px" ToolTip="Click here to open R1-Customer List Reports." Text="R1- Customer List" CssClass="button_example"  OnClick="btnR1CusList_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;font-size:small;">
                        <asp:Button ID="btnR2Leadsflup" runat="server" Width="230px" ToolTip="Click here to open R2-Leads followup Reports." Text="R2-Leads Followup" CssClass="button_example" OnClick="btnR2Leadsflup_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;font-size:small;">
                        <asp:Button ID="btnR3NoSales" runat="server" Width="230px" Text="R3-No Followups" ToolTip="Click here to open R3-No Followups." CssClass="button_example" OnClick="btnR3NoSales_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;font-size:small;">
                        <asp:Button ID="btnR4MarkAct" runat="server" Width="230px" Text="R4-Marketing Activities" ToolTip="Click here to open R4-Marketing activities." CssClass="button_example" OnClick="btnR4MarkAct_Click" />
                    </td>
                </tr>
                <tr style="width: 80%; align-content:center;padding-top:5em;padding-bottom:5em;max-height:20px;">
                    <td style="width: 20%; text-align: center;font-size:small;">                       
                        <asp:Button ID="btnR4Enquiry" runat="server" Width="230px" ToolTip="Click here to open R4E-Enquiries Registered Reports." Text="R4E - Enquiries Registered" CssClass="button_example"  OnClick="btnR4Enquiry_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;font-size:small;">
                        <asp:Button ID="btnR4Quotation" runat="server" Width="230px" ToolTip="Click here to open R4Q-Quotations Submitted Reports." Text="R4Q - Quotations Submitted" CssClass="button_example" OnClick="btnR4Quotation_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;font-size:small;">
                        <asp:Button ID="btnR4Orders" runat="server" Width="230px" Text="R4O - Orders Booked" ToolTip="Click here to open R4O-Orders Booked." CssClass="button_example" OnClick="btnR4Orders_Click" />
                    </td>
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR5ServAct" runat="server" Width="230px" ToolTip="Click here to open R5-Service Activities Reports." Text="R5-Service Activities" CssClass="button_example" OnClick="btnR5ServAct_Click" />
                    </td>
                </tr>
                <tr style="width: 80%; align-content:center;padding-top:2em;padding-bottom:2em;max-height:50px;">
                     <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnR15serpro"  runat="server" Width="230px" Text="R5S-Services" ToolTip="Click here to open R5S-Services Reports." CssClass="button_example" OnClick="btnR15serpro_Click" />
                    </td>
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR6GenAct" runat="server" Width="230px" ToolTip="Click here to open R6-General Activities Reports." Text="R6-General Activities" CssClass="button_example" OnClick="btnR6GenAct_Click" />
                    </td>
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR7WorkProg" runat="server" Width="230px" Text="R7-Work Progress" ToolTip="Click here to open R7-Work progress Reports." CssClass="button_example"  OnClick="btnR7WorkProg_Click" />
                    </td>
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR8QuickSrch" runat="server" Width="230px" Text="R8-Quick Search" ToolTip="Click here to open R8-Quick Search Reports." CssClass="button_example"  OnClick="btnR8QuickSrch_Click" />
                    </td>                    
                </tr>
                 <tr style="width: 80%;align-content:center;padding-top:2em;padding-bottom:2em;max-height:50px;">
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR7HrsSpent" runat="server" Width="230px" ToolTip="Click here to open R9-Hours Spent Reports." Text="R9-Hours Spent" CssClass="button_example"  OnClick="btnR7HrsSpent_Click" />
                    </td>
                     <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnR10cuslistloc"  runat="server" Width="230px" Text="R10-Customer List by Location" ToolTip="Click here to open R10-Customer list by location Reports." CssClass="button_example"  OnClick="btnR10cuslistloc_Click" />
                    </td>
                     <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnR50ROL"  runat="server" Width="230px" Text="R11-Recognitions&Observations" ToolTip="Click here to open R11-Recognitions and Observations Reports." CssClass="button_example" OnClick="btnR50ROL_Click" />
                    </td>
                    <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnR12timesummary"  runat="server" Width="230px" Text="R12-Time consumed -Summary" ToolTip="Click here to open R12-Time consumed per client-Summary Reports." CssClass="button_example" OnClick="btnR12timesummary_Click" />
                    </td>                   
                   
                </tr>
                <tr style="width: 80%;align-content:center;padding-top:2em;padding-bottom:2em;max-height:50px;"> 
                     <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnR13timedetailed"  runat="server" Width="230px" Text="R13-Time consumed -Detailed" ToolTip="Click here to open R13-Time consumed per client-Detailed Reports." CssClass="button_example" OnClick="btnR13timedetailed_Click" />
                    </td>                  
                    <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnR14sysnotused"  runat="server" Width="230px" Text="R14-System Usage Report" ToolTip="Click here to open R14-System usage Report Reports." CssClass="button_example" OnClick="btnR14sysnotused_Click" />
                    </td>                    
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnX1cusdump"  runat="server" Width="230px" ToolTip="Click here to open X1-Customer Dump Report based on a Customer Type." Text="X1-Customer Dump" CssClass="button_example" OnClick="btnX1cusdump_Click" />
                    </td>
                    <td style="width: 20%; text-align: center">
                        <asp:Button ID="btnX2reflist"  runat="server" Width="230px" Text="X2-Reference List Dump" ToolTip="Click here to open X2-Reference list dump Reports." CssClass="button_example" OnClick="btnX2reflist_Click" Visible="false" />
                        <asp:Button ID="btneodcusstats"  runat="server" Width="230px" Text="R15-User tasks summary" ToolTip="Click here to open End of the day user status." CssClass="button_example" OnClick="btneodcusstats_Click"  />
                    </td>
                </tr>
                <tr style="width: 80%;align-content:center;padding-top:2em;padding-bottom:2em;max-height:50px;">
                    <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btneoduserstats"  runat="server" Width="230px" Text="R16-Customer tasks summary" ToolTip="Click here to open End of the day Customer status." CssClass="button_example" OnClick="btneoduserstats_Click" />
                    </td>                  
                    <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnCompSerRep"  runat="server" Width="230px" Text="R17-Service tasks summary" ToolTip="Click here to open service tasks summary report." CssClass="button_example" OnClick="btnCompSerRep_Click" />
                    </td>   
                    <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnRefsummreport"  runat="server" Width="230px" Text="Reference Summary Report" ToolTip="Click here to open reference summary report." CssClass="button_example" OnClick="btnRefsummreport_Click" />
                    </td> 
                     <td style="width: 20%; text-align: center;">
                        <asp:Button ID="btnDailyUsageBillingReport"  runat="server" Width="230px" Text="Daily Usage Biling" ToolTip="Click here to open daily usage biling report." CssClass="button_example"  OnClick="btnDailyUsageBillingReport_Click" />
                    </td>     
                </tr>
            </table>              
        </div>      
        
        <div id="dvMainSMReports" runat="server" visible="false">            
            <table style="width:100%;">              
               <div style="text-align:right">
                    <asp:Button ID="btnReturn" runat="server" CssClass="level_menu" Width="90" Font-Size="X-Small" Text="Back" ToolTip="Click here to return home." OnClick="btnReturn_Click"/>
               </div>               
                <tr style="width:100%">                    
                    <td style="width:100%;border:black 2px"">
                         <div id="divMR1" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                                    <table>
                                                        <tr>
                                                            <td>                                                               
                                                                <div style="text-align: center">
                                                                    <asp:Label ID="Label11" runat="server" Text="R1-Customer List" Font-Size="Medium" 
                                                                     Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>                                                                   
                                                                 </div>
                                                                 &nbsp;                                                            
                                                                
                                                                <div style="text-align:left ">
                                                                <%--<asp:Label ID="Label13" runat="server" Text="Choose Status and one of the selection criteria mentioned."
                                                                        Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Ariel"></asp:Label>--%>
                                                                </div>                                                               
                                              
                                                                <table>
                                                                     <tr>
                                                                         <td>
                                                                             <asp:Label ID="lblmrType" runat="server" CssClass="style2" Font-Bold="true"  Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status:"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmrType" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="" 
                                                                                 Width="100px" AutoPostBack="True" OnSelectedIndexChanged="ddlmrType_SelectedIndexChanged">
                                                                                 <asp:ListItem Text="All" Value="8"></asp:ListItem>
                                                                                 <asp:ListItem Text="Recent" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Registered" Value="10"></asp:ListItem>
                                                                                 <asp:ListItem Text="Leads" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Hot" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Customers" Value="4"></asp:ListItem>
                                                                                 <asp:ListItem Text="Vendors" Value="5"></asp:ListItem>
                                                                                 <asp:ListItem Text="Others" Value="6"></asp:ListItem>
                                                                                 <asp:ListItem Text="Cold Leads" Value="7"></asp:ListItem>
                                                                                 <asp:ListItem Text ="Dropped" Value="9"></asp:ListItem>
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <br />
                                                                             <%-- CssClass="btnSmallMainpage"--%>
                                                                             <asp:Button ID="btnStatusHelp" BackColor="DarkGray" CssClass="btnSmallMainpage" Font-Names="Verdana" runat="server" Text="?" OnClick ="btnStatusHelp_Click" Width="30px" 
                                                                       ToolTip="Click for help." /> 
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="lblrReference" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Category:"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmrReference" runat="server" CssClass="style3" ToolTip="Choose a reference (or #Tag) to identify Profiles matching the reference"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="125px" AutoPostBack="True" OnSelectedIndexChanged="ddlmrReference_SelectedIndexChanged">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="lblrLeadSource" runat="server" CssClass="style2"  Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="LeadSource:"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmrLeadSource" runat="server" CssClass="style3" 
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="125px" AutoPostBack="True" OnSelectedIndexChanged="ddlmrLeadSource_SelectedIndexChanged">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="lblmr1Campaign" runat="server" CssClass="style2"  Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Campaign:"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmr1Campaign" runat="server" CssClass="style3" 
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="155px" AutoPostBack="True" OnSelectedIndexChanged="ddlmr1Campaign_SelectedIndexChanged">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="lblmr1Mobile" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Search by MobileNo:"></asp:Label>
                                                                             <br />
                                                                             <asp:TextBox ID="txtmr1mobileNo" runat="server" CssClass="style3"  Font-Names="Verdana"
                                                                                 Font-Size="Small" TextMode="SingleLine" Width="150px" ToolTip ="Enter All Part of Mobile Number to Search"></asp:TextBox>
                                                                         </td>                                                                       
                                                                         <td>
                                                                             <asp:Label ID="lblmr1name" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Search by Name:"></asp:Label>
                                                                             <br />
                                                                             <asp:TextBox ID="txtmr1name" runat="server" CssClass="style3"  Font-Names="Verdana"
                                                                                 Font-Size="Small" TextMode="SingleLine" Width="150px" ToolTip ="Enter Part of a Name to Search"></asp:TextBox>
                                                                         </td>
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnmr1Search" runat="server" CssClass="btnReportpage" Font-Names="Verdana"  
                                                                                 OnClick="btnmr1Search_Click" Text="Search" 
                                                                                 ToolTip="Select either Reference(or)LeadSource(or)Camapaign" Width="60px" />
                                                                         </td>                                                                        
                                                                         <td>
                                                                             <br />
                                                                              <asp:Button ID="btnClearmr1" runat="server" CssClass="btnReportpage" Font-Names="Verdana"
                                                                                 OnClick="btnClearmr1_Click" Text="Clear" 
                                                                                 ToolTip="Clear the selected details" Width="50px" />
                                                                         </td>
                                                                          <td>
                                                                             <br />
                                                                             <asp:Button ID="btnimgmr1exporttoexcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnimgmr1exporttoexcel_Click" Width="76px" />   
                                                                             <%--<asp:ImageButton ID="btnimgmr1exporttoexcel"  runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgmr1exporttoexcel_Click"  />--%>
                                                                         <telerik:RadWindowManager runat="server" ID="rwmMR1Export"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonMR1Export" Text="" Style="display: none;" OnClick="HiddenButtonMR1Export_Click" runat="server" />
                                                                          </td>
                                                                         
                                                                         <td>
                                                                             <br /> 
                                                                              <asp:Label ID="lblCount" runat="server" CssClass="style2" Font-Bold="true"  align="center"
                                                                                 Font-Names="Verdana" ForeColor="DarkGreen" Text=""></asp:Label>                                                                            
                                                                         </td>
                                                                     </tr>                                                                    
                                                         </table>         
                                                                    
                                                            </td>
                                                        </tr>
                                                        <tr>                                                            
                                                            <td>
                                                               

                                                                <asp:GridView ID="gvMarketingReport1" runat="server" AutoGenerateColumns="False" Width="100%" AllowPaging="True" PageSize="20" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"
                                                                    OnPageIndexChanging="OnMR1Paging" DataKeyNames="RSN" ToolTip="View by clicking on the icon."
                                                                    AllowSorting="True" OnSorting="gvMarketingReport1_Sorting" OnRowCommand="gvMarketingReport1_RowCommand" EnableModelValidation="True" ShowFooter="false">
                                                                   
                                                                    <Columns>
                                                                       
                                                                        <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png"  CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                    CommandName="Select" />
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                        </asp:TemplateField>
                                                                       
                                                                        <asp:TemplateField HeaderText="Name" ControlStyle-Font-Names="Verdana" SortExpression="Name">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                                            </EditItemTemplate>                                                                           
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>                                                                            
                                                                            <ControlStyle Font-Names="Verdana" />
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                                            <ItemStyle Font-Names="Verdana" Width="200px" HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                       
                                                                        <asp:TemplateField HeaderText="Status" SortExpression="Status" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Status") %>' Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>                                                                           
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="200px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="MobileNo" SortExpression="Mobile" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("Mobile") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="200px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="PhoneNo" SortExpression="Mobile" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("Phone") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="180px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="EmailID" SortExpression="Email" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("Email") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="300px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Category" SortExpression="Category" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Category") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Category") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>                                                                            
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="LeadSource" SortExpression="LeadSource" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                          <asp:Label ID="Label4" runat="server" Text='<%# Eval("LeadSource") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("LeadSource") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Campaign" SortExpression="Campaign" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Campaign") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Campaign") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>                                                                          
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Remarks/Notes" SortExpression="Notes" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("Notes") %>'></asp:Label>
                                                                            </EditItemTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("Notes") %>'  Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="250px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Activities" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'  Font-Size="X-Small" Font-Names="Verdana"
                                                                                    Text="View " CommandName="Diary" ToolTip="Select to view a consolidated report of all interations.">View</asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="100px" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>                         
                         <div id="divMR3" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td>
                                                                <div style="text-align: center">
                                                                    <asp:Label ID="Label19" runat="server" Text="R2-Leads Followup" Font-Size="Medium"
                                                                        Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                                                        <br />
                                                                        <asp:Label ID="Label42" runat="server" Text="These Leads [Prospective customers] underwent a change in lead status in the last 30 days." Font-Size="Smaller" 
                                                                        Font-Bold="true" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                                                </div>                                                     
                                                              <div>
                                                                  <table>
                                                                      <tr align="left">
                                                                          <td>
                                                                      <asp:Button ID="btnimgMR3Excel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnimgMR3Excel_Click" Width="76px" />   
                                                                     <%--<asp:ImageButton ID="btnimgMR3Excel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgMR3Excel_Click"   />                                                               --%>
                                                                    <telerik:RadWindowManager runat="server" ID="rwmMR3Export"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonMR3Export" Text="" Style="display: none;" OnClick="HiddenButtonMR3Export_Click" runat="server" />
                                                                              </td>
                                                                          <td>
                                                                           <asp:Label ID="lblmr3count" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label> 
                                                                              </td>   
                                                                      </tr>
                                                                  </table>
                                                              </div>
                                                                <asp:GridView ID="gvMarketingReport3" runat="server" AutoGenerateColumns="False" RowStyle-Font-Names="Verdana" HeaderStyle-Font-Names="Verdana"
                                                                    AllowPaging="True" PageSize="20" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"
                                                                    OnPageIndexChanging="OnMR3Paging" DataKeyNames="ProspectRSN" ToolTip="View/Edit by clicking on the icon."
                                                                    AllowSorting="True" OnSorting="gvMarketingReport3_Sorting" OnRowCommand="gvMarketingReport3_RowCommand" EnableModelValidation="True">
                                                                    <Columns>
                                                                        <%--<asp:CommandField ButtonType ="Image" SelectImageUrl ="~/Images/edit-notes.png" ShowSelectButton ="true"   /> --%>
                                                                        <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                    CommandName="Select" />
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                        </asp:TemplateField>
                                                                        <%--<asp:BoundField HeaderText ="RSN" DataField ="RSN" ReadOnly ="true"  />--%>
                                                                        <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                                        <ItemStyle Font-Names="Verdana" Width="200px" HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                         <asp:BoundField HeaderText="Previous" DataField="Previous" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Previous" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left"/>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="Now" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left"/>
                                                                        </asp:BoundField>
                                                                         <asp:BoundField HeaderText="StatusDate" DataField="laststatusdate" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="statusdate" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center" />
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="MobileNo" DataField="Mobile" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Mobile" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center"/>
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="100px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="EmailID" DataField="Email" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Email" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Category" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="LeadSource" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="LeadSource" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField HeaderText="Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Campaign" ItemStyle-Font-Names="Verdana" >
                                                                        <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                                        <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Activities" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                    Text="View " CommandName="Diary" ToolTip="Select to view a consolidated report of all interations.">View</asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="100px" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                         <div id="divMR4" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                                <table style="width:100%">
                                                 <tr>
                                                  <td>
                                                    <div style="text-align: center">
                                                        <asp:Label ID="Label44" runat="server" Text="R3-No Followups" Font-Size="Medium"
                                                            Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="Label46" runat="server" Text="These Leads [Prospective customers] did not have any sales followup activities in the last 30 days." Font-Size="Smaller" 
                                                            Font-Bold="true" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                                    </div>                                                 
                                              
                                                    <div>
                                                        <table>
                                                            <tr align="left">
                                                                <td>
                                                                <asp:Button ID="btnimgMR4Excel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnimgMR4Excel_Click" Width="76px" />   
                                                                 <%--<asp:ImageButton ID="btnimgMR4Excel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgMR4Excel_Click"   />                           --%>
                                                                 <telerik:RadWindowManager runat="server" ID="rwmMR4Export"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonMR4Export" Text="" Style="display: none;" OnClick="HiddenButtonMR4Export_Click" runat="server" />
                                                                </td> 
                                                                <td>
                                                                     <asp:Label ID="lblmr4count" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                                    </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <asp:GridView ID="gvMarketingReport4" runat="server" AutoGenerateColumns="False"
                                                        AllowPaging="True" PageSize="20" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"
                                                        OnPageIndexChanging="OnMR4Paging" DataKeyNames="ProspectRSN" ToolTip="Click the icon before the name for viewing the profile of the Prospect/Customer."
                                                        AllowSorting="True" OnSorting="gvMarketingReport4_Sorting" OnRowCommand="gvMarketingReport4_RowCommand" EnableModelValidation="True">
                                                        <Columns>
                                                            <%--<asp:CommandField ButtonType ="Image" SelectImageUrl ="~/Images/edit-notes.png" ShowSelectButton ="true"   /> --%>
                                                            <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                        CommandName="Select" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                            </asp:TemplateField>
                                                            <%--<asp:BoundField HeaderText ="RSN" DataField ="RSN" ReadOnly ="true"  />--%>
                                                            <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" NullDisplayText="No Records" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                            <ItemStyle Font-Names="Verdana" Width="200px" HorizontalAlign="Left"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Now" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="MobileNo" DataField="Mobile" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Mobile" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="EmailID" DataField="Email" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Email" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Category" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="LeadSource" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="LeadSource" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Campaign" ItemStyle-Font-Names="Verdana" >
                                                            <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left"/>
                                                            <ItemStyle Font-Names="Verdana" HorizontalAlign="Left" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Activities" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                        Text="View " CommandName="Diary" ToolTip="Select to view a consolidated report of all interations.">View</asp:LinkButton>
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" />
                                                                <ItemStyle Font-Names="Verdana" HorizontalAlign="Center" Width="100px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                                
                                                                
                                                  </td>
                                                </tr>
                                                </table>
                                                </div>                   
                         <div id="dvMarkettingAct" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label10" runat="server" Text="R4 - Marketing activities" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblMarActPrintDate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblMarActBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                        <td>
                                                                             <asp:Label ID="Label20" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="#Reference"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmarkactref" runat="server" CssClass="style3" ToolTip="Choose a reference (or #Tag) to identify Profiles matching the reference"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px" OnSelectedIndexChanged="ddlmarkactref_SelectedIndexChanged">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label18" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlmarkactstatus" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status" 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label21" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="RadDatemarkactfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar3" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput3" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label22" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="RadDatemarkactto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput1" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnMarkActSub" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select either Reference(or)Status" Width="76px" OnClick="btnMarkActSub_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnMarActExcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnMarActExcel_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwmMarActExport"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonMarActExport" Text="" Style="display: none;" OnClick="HiddenButtonMarActExport_Click" runat="server" />
                                                                </td>    
                                                                <td valign="bottom" align="center">
                                                                    <asp:Label ID="lblMarkActCount" runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                </td>                                                            
                                                                       
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                          
                                                                        
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvMarkActDetails" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvMarkActDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                            
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference" HeaderStyle-Font-Names="verdana" SortExpression="Reference" ItemStyle-Font-Names="verdana"
                                                                Visible="true" FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                            <%-- <telerik:GridBoundColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>   --%> 
                                                             <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                            
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                               <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                 <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                  <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>  
                                                                   <%--<ItemStyle ForeColor="#84acff" Font-Names="Verdana" Wrap="true"/>                                                              --%>
                                                            </telerik:GridBoundColumn>

                                                                                                               
                                                             <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                         <div id="dvR4EnqRegistered" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label104" runat="server" Text="R4E - Enquiries Registered" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblR4EnqRegdate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblR4enqregby" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                         <td>
                                                                             <asp:Label ID="Label108" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlR4enqregsts" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status" 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label109" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="dtpR4engregfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar17" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput17" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label110" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="dtpR4engregto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar18" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput18" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnR4EnqRegSub" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select the status for displaying records." Width="76px" OnClick="btnR4EnqRegSub_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnR4EnqRegExcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnR4EnqRegExcel_Click" Width="76px" />   
                                                                <telerik:RadWindowManager runat="server" ID="rwmEnqRegExport"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonEnqRegExport" Text="" Style="display: none;" OnClick="HiddenButtonEnqRegExport_Click" runat="server" />
                                                                </td>                                                                
                                                                  <td valign="bottom" align="center">                                                            
                                                             <asp:Label ID="lblR4EnqRegCount" runat="server" CssClass="style2" Font-Bold="true" Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>        
                                                                                                                                     
                                                                 </td>  
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR4EnqRegDetails" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="15" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR4EnqRegDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                           
                                                              <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                           
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                           <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                               <HeaderStyle Font-Names="Verdana" Wrap="true" />
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                 <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>  
                                                                   <%--<ItemStyle ForeColor="#84acff" Font-Names="Verdana" Wrap="true"/>                                                              --%>
                                                            </telerik:GridBoundColumn>

                                                                                                                   
                                                             <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                         <div id="dvR4QuoateSubmitted" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label105" runat="server" Text="R4Q - Quotations Submitted" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblR4Quoatesubdate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblR4QuoatesubBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                         <td>
                                                                             <asp:Label ID="Label111" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlr4quoatesubsts" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status from dropdown." 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label112" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="dtpR4Quoatesubfrom" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar19" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput19" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label113" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="dtpR4Quoatesubto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar20" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput20" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnR4quoatesubmit" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select the status for displaying records." Width="76px" OnClick="btnR4quoatesubmit_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnr4quoatesubexcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnr4quoatesubexcel_Click" Width="76px" />   
                                                                      <telerik:RadWindowManager runat="server" ID="rwmQuoSubExport"></telerik:RadWindowManager>
                                                                               <asp:Button ID="HiddenButtonQuoSubExport" Text="" Style="display: none;" OnClick="HiddenButtonQuoSubExport_Click" runat="server" />
                                                                </td>                                                                
                                                                        <td valign="bottom" align="center">                                                            
                                                             <asp:Label ID="lblR4quoatesubcount" runat="server" CssClass="style2" Font-Bold="true" 
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>        
                                                                                                                                     
                                                         </td>      
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>                                                       
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR4QuoateSubDetails" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="15" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR4QuoateSubDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                                                                                       
                                                            <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                           
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                           <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                 <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                  <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                   <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>  
                                                                   <%--<ItemStyle ForeColor="#84acff" Font-Names="Verdana" Wrap="true"/>                                                              --%>
                                                            </telerik:GridBoundColumn>

                                                                                                                   
                                                            
                                                             <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                          <div id="dvR4OrdersBooked" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label106" runat="server" Text="R4O - Orders Booked" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblR4Ordersbookdate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblR4OrdersbookBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                         <td>
                                                                             <asp:Label ID="Label115" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlR4OrdersBooksts" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status from dropdown." 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label116" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="dtpR4OrderBookfrom" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar21" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput21" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label117" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="dtpR4OrderBookto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar22" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput22" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnR4OrdersBookSub" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select the status for displaying records." Width="76px" OnClick="btnR4OrdersBookSub_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnR4OrdersBookExcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnR4OrdersBookExcel_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwR4orders"></telerik:RadWindowManager>
                                                                               <asp:Button ID="hbtnR4Orders" Text="" Style="display: none;" OnClick="hbtnR4Orders_Click" runat="server" />
                                                                </td>                                                                
                                                                      <td valign="bottom" align="center">                                                            
                                                             <asp:Label ID="lblR4Ordersbookcount" runat="server" CssClass="style2" Font-Bold="true" 
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>        
                                                                                                                                     
                                                         </td>  
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>                                                         
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR4OrdersBookDetails" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="15" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR4OrdersBookDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                                                                                       
                                                              <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                                   
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                               <HeaderStyle BackColor="#00cc00" BorderColor="#00cc00" ForeColor="White" />
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                  <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>  
                                                                   <%--<ItemStyle ForeColor="#84acff" Font-Names="Verdana" Wrap="true"/>                                                              --%>
                                                            </telerik:GridBoundColumn>
                                                       
                                                             <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                         <div id="dvServiceActivity" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%" >
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label13" runat="server" Text="R5 - Service activities" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblSerActDate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblSerActBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                
                                                                            
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                        <td>
                                                                             <asp:Label ID="Label17" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="#Reference"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlSerActReference" runat="server" CssClass="style3" ToolTip="Choose a reference (or #Tag) to identify Profiles matching the reference"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label24" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlSerActStatus" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status" 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label25" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="RadDateSerActFrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDateSerActFrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput2" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label26" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="RadDateSerActTo" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." OnSelectedDateChanged="RadDateSerActTo_SelectedDateChanged">
                                                            <Calendar ID="Calendar4" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput4" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnSerActSub" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select either Reference(or)Status" Width="76px" OnClick="btnSerActSub_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnSerActExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnSerActExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwR5serAct"></telerik:RadWindowManager>
                                                                               <asp:Button ID="hbtnR5serAct" Text="" Style="display: none;" OnClick="hbtnR5serAct_Click" runat="server" />
                                                                </td>                                                                
                                                                  <td valign="bottom" align="center">
                                                                      <asp:Label ID="lblSerActCount" runat="server" CssClass="style2" Font-Bold="true"  
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label> 
                                                                  </td>
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                            
                                                                    
                                                                                                                                     
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvSerActDetails"  GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvSerActDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                            
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference" HeaderStyle-Font-Names="verdana" SortExpression="Reference" ItemStyle-Font-Names="verdana"
                                                                Visible="true" FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                             
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                               <HeaderStyle BackColor="#00cc00" BorderColor="#00cc00" ForeColor="White" />
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                <HeaderStyle BackColor="#ff9933" ForeColor="White" />
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                  <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                              
                                                            </telerik:GridBoundColumn>

                                                                                                                    
                                                             <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>                        
                         <div id="dvGeneralActivity" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label28" runat="server" Text="R6 - General activities" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblGenActDate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblGenActBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                  
                                                        
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                        <td>
                                                                             <asp:Label ID="Label31" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="#Reference"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlGenActReference" runat="server" CssClass="style3" ToolTip="Choose a reference (or #Tag) to identify Profiles matching the reference"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px" OnSelectedIndexChanged="ddlmarkactref_SelectedIndexChanged">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label32" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Status"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlGenActStatus" runat="server" 
                                                                                 CssClass="style3" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" 
                                                                                 ToolTip="Please select the status" 
                                                                                 Width="132px" >
                                                                                 <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                                                 <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                                                                                 <asp:ListItem Text="Done 7 Days" Value="2"></asp:ListItem>
                                                                                 <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                                                 <asp:ListItem Text="Completed" Value="4"></asp:ListItem>                                                                                
                                                                             </asp:DropDownList>
                                                                         </td>      
                                                                         <td>
                                                                             <asp:Label ID="Label33" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Completed from"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="RadDateGenActFrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." AutoPostBack="True" OnSelectedDateChanged="RadDateGenActFrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar5" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput5" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true" AutoPostBack="True">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label34" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="RadDateGenActTo" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Completed tasks Report." AutoPostBack="True" OnSelectedDateChanged="RadDateGenActTo_SelectedDateChanged">
                                                            <Calendar ID="Calendar6" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput6" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true" AutoPostBack="True">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnGenActSubmit" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select either Reference(or)Status" Width="76px" OnClick="btnGenActSubmit_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnGenActExcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana" Width="76px"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnGenActExcel_Click" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwR6genact"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnR6genAct" Text="" Style="display: none;" OnClick="hbtnR6genAct_Click" runat="server" />
                                                                </td>                                                              
                                                                 <td valign="bottom" align="center">
                                                             <asp:Label ID="lblGenActCount" runat="server" CssClass="style2" Font-Bold="true"
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                 </td>      
                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                            
                                                               
                                                                                                                                     
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvGenActDetails" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvGenActDetails_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                            
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference" HeaderStyle-Font-Names="verdana" SortExpression="Reference" ItemStyle-Font-Names="verdana"
                                                                Visible="true" FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                             
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="Tracker" HeaderText="Activity"  UniqueName="Tracker" HeaderStyle-Font-Names="verdana" SortExpression="Tracker" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarActTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +","+ Eval("taskid") %>' Text='<%# Eval("Tracker") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                               <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                              <%-- <ItemStyle ForeColor="#00cc00" Font-Names="Verdana"/>                                                --%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                               <HeaderStyle Font-Names="Verdana" Wrap="true" /> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Executive" HeaderText="Executive" UniqueName="Executive" HeaderStyle-Font-Names="verdana" SortExpression="Executive" ItemStyle-Font-Names="verdana"
                                                                  FilterControlWidth ="50px">  
                                                                  <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                   <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                              
                                                            </telerik:GridBoundColumn>

                                                           
                                                            
                                                            <telerik:GridBoundColumn DataField="AssignedOn" HeaderText="AssignedOn" UniqueName="AssignedOn" SortExpression="AssignedOn" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridBoundColumn DataField="CompletionDate" HeaderText="Completion Date" UniqueName="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>                                                    
                                                            
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                        <%--WMReports --%>                         
                         <div id="divwfr2" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: center">
                                            <asp:Label ID="Label56" runat="server" Text="R7-Work Progress" Font-Size="Medium"
                                                Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>

                                            <table>
                                                <tr>
                                                    <td>
                                                         <asp:CheckBox ID="Chkwfr2date" runat="server" />
                                                        <asp:Label ID="Label52" runat="server" Text="For a date range" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <telerik:RadDatePicker ID="dtpwfr2StartDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for InProgress and Completed tasks Report.">
                                                            <Calendar ID="Calendar7" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput7" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbldtpwfr2todate" runat="server" Text="To" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <telerik:RadDatePicker ID="dtpwfr2ToDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for InProgress and Completed tasks Report.">
                                                            <Calendar ID="Calendar8" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput8" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label15" runat="server" Text="Type" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr2Type" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlwfr2Type_SelectedIndexChanged">
                                                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                                            <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                                            <asp:ListItem Value="CUSTOMER" Text="CUSTOMER"></asp:ListItem>
                                                            <asp:ListItem Value="VENDOR" Text="VENDOR"></asp:ListItem>
                                                            <asp:ListItem Value="OTHER" Text="OTHER"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label60" runat="server" Text="Customer" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr2Customer" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label64" runat="server" Text="Reference" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr2Reference" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label68" runat="server" Text="By" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr2By" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label70" runat="server" Text="Report" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr2Report" runat="server" Width="140px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                            <asp:ListItem Text="OnComingFollowup" Value="OnComingFollowup"></asp:ListItem>
                                                            <asp:ListItem Text="OverdueFollowup" Value="OverdueFollowup"></asp:ListItem>
                                                            <asp:ListItem Text="InProgress" Value="InProgress"></asp:ListItem>
                                                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>

                                                        <br />
                                                        <asp:Button ID="btnwfr2Search" runat="server" Text="Search" CssClass="btnReportpage" OnClick="btnwfr2Search_Click" Width="60px" ToolTip="Please click here to list out the details based on the search criteria." />
                                                    </td>
                                                    <td>

                                                        <br />
                                                        <asp:Button ID="btnwfr2Clear" runat="server" Text="Clear" CssClass="btnReportpage" OnClick="btnwfr2Clear_Click" Width="50px" ToolTip="Please click here to clear the details." />
                                                    </td>
                                                    <td>
                                                        <br />
                                                        <asp:Button ID="btnimgwfr2exporttoexcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnimgwfr2exporttoexcel_Click" Width="76px" />   
                                                       <telerik:RadWindowManager runat="server" ID="rwR7workprog"></telerik:RadWindowManager>
                                                       <asp:Button ID="hbtnR7workprog" Text="" Style="display: none;" OnClick="hbtnR7workprog_Click" runat="server" />
                                                    </td>
                                                    <td valign="bottom" align="center">
                                                     <asp:Label ID="lblR7workprogcount" Visible="false" runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                  </td>        
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvWFR2" runat="server" AutoGenerateColumns="false" Font-Names="Verdana" AllowPaging="true" PageSize="50"
                                                Font-Size="Small" ForeColor="DarkBlue" DataKeyNames="customerrsn,TaskID" PagerSettings-Visible="true"
                                                OnRowCommand="gvWFR2_RowCommand" AllowSorting="true" OnPageIndexChanging="gvWFR2_PageIndexChanging"
                                                OnSorting="gvWFR2_Sorting" ShowFooter="true" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                CommandName="Select" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>                                               

                                                    <asp:BoundField HeaderText="TaskID" DataField="Taskid" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Taskid" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Customer" DataField="Customer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                        SortExpression="Customer" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="Reference" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="Work" DataField="Work" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="Work" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                     <asp:BoundField HeaderText="AsignDate" DataField="AsignDate" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" DataFormatString="{0:D}" HtmlEncode="false"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Date" ItemStyle-Font-Names="Verdana" />
                                                     <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" DataFormatString="{0:D}" HtmlEncode="false"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Date" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Followupdate" DataField="ShowFudate" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="ShowFudate" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField HeaderText="Status" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="Time" DataField="Time" ReadOnly="true"
                                                        HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="50px"
                                                        HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" SortExpression="Time" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="For" DataField="By" ReadOnly="true"
                                                        HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="By" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Priority" DataField="Priority" ReadOnly="true"
                                                        HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="Priority" ItemStyle-Font-Names="Verdana" />
                                                    <asp:TemplateField HeaderText="Diary" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White"
                                                        ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                Text="View " CommandName="Diary" ToolTip="Select to view all interactions with this Customer/Prospect.">View</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                         <div id="divwfr3" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                <table style="width: 100%">
                                    <tr>

                                        <td style="text-align: center">
                                            <asp:Label ID="Label27" runat="server" Text="R8-Quick Search" Font-Size="Medium"
                                                Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label29" runat="server" Text="Enter words on which you wish to search" Font-Size="Small"
                                             Font-Bold="true" ForeColor="Gray" CssClass="style2" Font-Names="Verdana"></asp:Label><br />
                                            <asp:TextBox ID="TxtSearchValue" runat="server" Width="200px" Font-Size="Medium" CssClass="style3"
                                                TextMode="SingleLine" MaxLength="40" ToolTip="Enter few letters of a word which may have occurred in any Activity progress entry."></asp:TextBox>
                                            <telerik:RadWindowManager runat="server" ID="SearchWindowManager1"></telerik:RadWindowManager>

                                            <asp:Button ID="Search" runat="server" Text="Search" CssClass="btnReportpage" OnClick="btnwfr3Search_Click" ToolTip="Enter 4 (or) more characters to search from the work progress/tracker entries." />
                                             <asp:Label ID="lblR8QuicksrchCount" Visible="false" runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                            <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />
                                            <br />
                                             <asp:Label ID="Label23" runat="server" Text="Use this as a Search Engine to locate text from the activity progress entries.Enter atleast four characters.More text you enter, more accurate will be the result.Remember,larger the selection, slower the retrieval could be." Font-Size="Small"
                                                        ForeColor="Gray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                        </td>
                                         <td valign="bottom" align="center">
                                           
                                          </td>  
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvWFR3" runat="server" AutoGenerateColumns="false" Font-Names="Calibri"
                                                AllowSorting="true" OnSorting="gvWFR3_Sorting" Font-Size="Small" ForeColor="DarkBlue" DataKeyNames="customerrsn,TaskID" OnRowCommand="gvWFR3_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/edit-notes.png" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                CommandName="Select" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:BoundField HeaderText="Task Id" DataField="Taskid" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="30px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Taskid" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Customer" DataField="Customer" ReadOnly="true"
                                                        HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" ItemStyle-Width="150px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="Customer" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" SortExpression="Reference" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="40px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="Work Progress Entry" DataField="Work" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" SortExpression="Work" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Date" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Followup Date" DataField="Followupdate" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Followupdate" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Status" DataField="Status" ReadOnly="true"
                                                        HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" ItemStyle-Width="80px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="Status" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Time" DataField="Time" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Time" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="For" DataField="AssignedTo" ReadOnly="true"
                                                        HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" ItemStyle-Width="80px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="AssignedTo" ItemStyle-Font-Names="Verdana" />
                                                    <asp:TemplateField HeaderText="Activities" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White"
                                                        ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                Text="View " CommandName="Diary" ToolTip="Select to view a consolidated report of all interations.">View</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>

                                        </td>
                                    </tr>
                                </table>
                            </div>
                         <div id="divwfr4" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: center">
                                            <asp:Label ID="Label1" runat="server" Text="R9-Hours Spent" Font-Size="Medium"
                                                Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:CheckBox ID="Chkwfr4date" runat="server" />
                                                        <asp:Label ID="Label2" runat="server" Text="For a date range" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <telerik:RadDatePicker ID="dtpwfr4from" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Hours Spent and Completed tasks Report.">
                                                            <Calendar ID="Calendar9" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput9" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text="To" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <telerik:RadDatePicker ID="dtpwfr4to" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Date range is valid only for Hours Spent and Completed tasks Report.">
                                                            <Calendar ID="Calendar10" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput10" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Type" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr4Type" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlwfr4Type_SelectedIndexChanged">
                                                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                                            <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                                            <asp:ListItem Value="CUSTOMER" Text="CUSTOMER"></asp:ListItem>
                                                            <asp:ListItem Value="VENDOR" Text="VENDOR"></asp:ListItem>
                                                            <asp:ListItem Value="OTHER" Text="OTHER"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text="Customer" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr4Customer" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text="Reference" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr4Reference" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="By" CssClass="style2" ForeColor="DarkGray"
                                                            Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                        <br />
                                                        <asp:DropDownList ID="ddlwfr4By" runat="server" Width="120px" CssClass="style3"
                                                            Font-Size="Small" ForeColor="DarkGreen" Font-Names="Verdana">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <br />
                                                        <asp:Button ID="btnwfr4Search" runat="server" Text="Search" CssClass="btnReportpage" Width="60px" OnClick="btnwfr4Search_Click" ToolTip="Please click here to list out the details based on the search criteria." />
                                                    </td>
                                                    <td>
                                                        <br />
                                                        <asp:Button ID="btnwfr4Clear" runat="server" Text="Clear" CssClass="btnReportpage" Width="50px" OnClick="btnwfr4Clear_Click" ToolTip="Please click here to clear the details." />
                                                    </td>
                                                    <td>
                                                        <br />
                                                        <asp:Button ID="btnimgwfr4exporttoexcel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnimgwfr4exporttoexcel_Click" Width="76px" />   
                                                       <telerik:RadWindowManager runat="server" ID="rwR9hrsSpent"></telerik:RadWindowManager>
                                                       <asp:Button ID="hbtnR9hrsspent" Text="" Style="display: none;" OnClick="hbtnR9hrsspent_Click" runat="server" />
                                                    </td>
                                                    <td valign="bottom" align="center">
                                                        <asp:Label ID="lblR9hrspentcount" Visible="false" runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                     </td> 
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvwfr4" runat="server" OnPageIndexChanging="gvwfr4_PageIndexChanging" AutoGenerateColumns="false" Font-Names="Verdana" OnSorting="gvwfr4_Sorting" AllowPaging="true" PageSize="50"
                                                Font-Size="Small" ForeColor="DarkBlue" DataKeyNames="customerrsn,TaskID" AllowSorting="true" OnRowCommand="gvwfr4_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="V" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                CommandName="Select" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:BoundField HeaderText="Customer" DataField="Customer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                        SortExpression="Customer" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="By" DataField="By" ReadOnly="true"
                                                        HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="By" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="Reference" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Date" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Min" DataField="Time" ReadOnly="true"
                                                        HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="50px"
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Time" ItemStyle-Font-Names="Verdana" />
                                                    <asp:BoundField HeaderText="Activity" DataField="Work" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="Work" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField HeaderText="TaskID" DataField="Taskid" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                        SortExpression="Taskid" ItemStyle-Font-Names="Verdana" />
                                                    <asp:TemplateField HeaderText="Diary" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White"
                                                        ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                Text="View " CommandName="Diary" ToolTip="Select to view all interactions with this Customer/Prospect.">View</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>                       
                        <%--SMX Reports --%>
                         <div id="divsmx1" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                    <table>
                                        <div style="text-align:center">
                                             <asp:Label ID="Label30" runat="server" Text="X1-Customer Dump"
                                                    Font-Size="Medium" Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="verdana"></asp:Label>
                                        </div>                                       
                                        <%-- Changes starts--%>
                                        <div style="text-align:center;">                                            
                                          <asp:Label ID="lblsmx1" runat="server" CssClass="style2" Font-Bold="true" Font-Names="verdana" Font-Size="Small" ForeColor="DarkGray" Text="Select a customer type and press Export to copy the matching profiles to a spread sheet file."></asp:Label>                                              
                                        </div>

                                        <caption>
                                            <br />
                                            <div>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label35" runat="server" CssClass="style3" Font-Bold="true" Font-Names="verdana" ForeColor="DarkGray" Text="Type:"></asp:Label>
                                                        <asp:DropDownList ID="ddlSMXReport1" runat="server" CssClass="style3" Font-Names="Verdana" ToolTip="Please Select a Customer type.">
                                                        </asp:DropDownList>
                                                        <telerik:RadWindowManager ID="SearchWindowManager2" runat="server">
                                                        </telerik:RadWindowManager>
                                                        &nbsp;
                                                        <asp:Button ID="btnimgexporttoexcel1" runat="server" CssClass="btnReportpage" Font-Names="Verdana" OnClick="btnimgexporttoexcel1_Click1" Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." Width="76px" />
                                                         <telerik:RadWindowManager runat="server" ID="rwX1Cusdump"></telerik:RadWindowManager>
                                                        <asp:Button ID="btnHiddensmxExport" runat="server" OnClick="btnHiddensmxExport_Click" Style="display: none;" Text="" />
                                                    </td>
                                                </tr>
                                                <caption>
                                                    <br />
                                                    <%-- Changes ends--%>
                                                    <tr align="left">
                                                        <td>
                                                            <asp:Label ID="Label47" runat="server" CssClass="style3" Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small" ForeColor="DarkGray" Text="Uses template X1-CustomerDump.XLTX"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr align="right">
                                                        <td>
                                                            <asp:GridView ID="gvSMX1" runat="server" AutoGenerateColumns="false" Font-Names="Verdana" Font-Size="11" ForeColor="DarkBlue">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Type" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left" HeaderText="Type" ItemStyle-Font-Names="Ariel" ItemStyle-Width="30px" ReadOnly="true" SortExpression="Taskid" />
                                                                    <asp:BoundField DataField="Title" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Title" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px" ReadOnly="true" SortExpression="Title" />
                                                                    <asp:BoundField DataField="Name" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Name" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Name" />
                                                                    <asp:BoundField DataField="Status" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Status" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="200px" ReadOnly="true" SortExpression="Status" />
                                                                    <asp:BoundField DataField="ACManager" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="AC Manager" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="200px" ReadOnly="true" SortExpression="ACManager" />
                                                                    <asp:BoundField DataField="CompanyName" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="CompanyName" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="CompanyName" />
                                                                    <asp:BoundField DataField="DoorNo" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="DoorNo" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="DoorNo" />
                                                                    <asp:BoundField DataField="Street" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Street" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Time" />
                                                                    <asp:BoundField DataField="City" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="City" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="City" />
                                                                    <asp:BoundField DataField="PostCode" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="PostCode" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="PostCode" />
                                                                    <asp:BoundField DataField="State" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="State" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="State" />
                                                                    <asp:BoundField DataField="Country" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Country" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Country" />
                                                                    <asp:BoundField DataField="Phone" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Phone" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Phone" />
                                                                    <asp:BoundField DataField="Mobile" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Mobile" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Mobile" />
                                                                    <asp:BoundField DataField="Email" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Email" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Email" />
                                                                    <asp:BoundField DataField="Email2" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Email2" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Email2" />
                                                                    <asp:BoundField DataField="Gender" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Gender" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Gender" />
                                                                    <asp:BoundField DataField="VIP_Imp" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Category" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="VIP_Imp" />
                                                                    <asp:BoundField DataField="New_Old" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="New_Old" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="New_Old" />
                                                                    <asp:BoundField DataField="Notes" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Notes" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Notes" />
                                                                    <asp:BoundField DataField="LeadSource" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="LeadSource" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="LeadSource" />
                                                                    <asp:BoundField DataField="Campaign" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Campaign" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Campaign" />
                                                                    <asp:BoundField DataField="Budget" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Budget" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Budget" />
                                                                    <asp:BoundField DataField="Requirements" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Requirements" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Requirements" />
                                                                    <asp:BoundField DataField="ProjectCode" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="ProjectCode" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="ProjectCode" />
                                                                    <asp:BoundField DataField="Executive" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Executive" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Executive" />
                                                                    <asp:BoundField DataField="C_ID" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Created ID" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="C_ID" />
                                                                    <asp:BoundField DataField="C_Date" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Created Date" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="C_Date" />
                                                                    <asp:BoundField DataField="M_Id" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Modified ID" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="M_Id" />
                                                                    <asp:BoundField DataField="M_Date" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Modified Date" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="M_Date" />
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </caption>
                                            </div>
                                        </caption>
                                    </table>
                                </div>                                
                         <div id="divsmx2" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                   <div style="text-align:center;">
                                            <asp:Label ID="Label36" runat="server" Text="X2-Reference List Dump"
                                                    Font-Size="Medium" Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Ariel"></asp:Label>
                                            <br />
                                       <asp:Label ID="lblsmx2" runat="server" CssClass="style2" Font-Bold="true" Font-Names="Ariel" Font-Size="Small" ForeColor="DarkGray" Text="Click the Export to Excel button to export the Tracker report on Reference &amp; Remarks to Excel."></asp:Label>
                                   </div>                                        
                                 
                                    <table align="left">                                       
                                        <%-- Changes Starts--%>                                        
                                        <tr>
                                            <td>
                                                <telerik:RadWindowManager runat="server" ID="SearchWindowManager3">
                                                </telerik:RadWindowManager>
                                                <asp:Button ID="btnimgexporttoexcel2" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Click the Export button to copy details of various #Reference codes defined in the system." OnClick="btnimgexporttoexcel2_Click" Width="76px" />   
                                                 <%--<asp:ImageButton ID="btnimgexporttoexcel2" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall.png" OnClick="btnimgexporttoexcel2_Click"  />--%>
                                                <asp:Button ID="btn2Hiddensmx2Export" runat="server" Text="" OnClick="btn2Hiddensmx2Export_Click" Style="display: none;" />
                                            </td>
                                        </tr>
                                        <%-- Changes ends--%>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label48" runat="server" Text="SMXReport2.xltx" CssClass="style3" Font-Names="Verdana" Font-Size="Small"
                                                    ForeColor="DarkGray" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvSMX2" runat="server" AutoGenerateColumns="false" Font-Names="Verdana"
                                                    Font-Size="11" ForeColor="DarkBlue">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="RSN" DataField="RSN" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="30px" HeaderStyle-HorizontalAlign="Left"
                                                            SortExpression="Taskid" ItemStyle-Font-Names="Ariel" />
                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                                                            SortExpression="Title" ItemStyle-Font-Names="Ariel" />
                                                        <asp:BoundField HeaderText="Remarks" DataField="Remarks" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                            HeaderStyle-ForeColor="White" SortExpression="Name" ItemStyle-Font-Names="Ariel"
                                                            ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </div>                         
                         <div id="divsmx5" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                    <table>
                                        <div style="text-align:center;">
                                             <asp:Label ID="Label61" runat="server" Text="R10-Customer List by Location."
                                                    Font-Size="Medium" Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>                                            
                                        </div> 
                                        <caption>
                                            <br />
                                            <div style="text-align:left;width:500px;">
                                                <asp:Label ID="lblsmx5" runat="server" CssClass="style2" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGray" Text="Select Area name to export the corresponding details to Excel."></asp:Label>
                                            </div>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label62" runat="server" CssClass="style3" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGray" Text="Search by Location (Area) :"></asp:Label>
                                                    <asp:DropDownList ID="ddlArea" runat="server" CssClass="style3" Font-Names="Verdana" ToolTip="Please select an area." Width="150px">
                                                    </asp:DropDownList>
                                                    <telerik:RadWindowManager ID="SearchWindowManager8" runat="server">
                                                    </telerik:RadWindowManager>
                                                    <asp:Button ID="btnimgexporttoexcel5" runat="server" CssClass="btnReportpage" Font-Names="Verdana" OnClick="btnimgexporttoexcel5_Click" Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." Width="76px" />
                                                    <%--<asp:ImageButton ID="btnimgexporttoexcel5" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall.png" OnClick="btnimgexporttoexcel5_Click"  />--%>
                                                    <asp:Button ID="btnHiddensmx5Export" runat="server" OnClick="btnHiddensmx5Export_Click" Style="display: none;" Text="" />
                                                </td>
                                            </tr>
                                            <%-- Changes ends--%>
                                            <tr>
                                                <td><%-- <asp:Label ID="Label63" runat="server" Text="SMXReport5.xltx" CssClass="style3" Font-Names="Verdana"
                                                    ForeColor="DarkGray" Font-Bold="true" Font-Size="Small"></asp:Label>--%></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvSMX5" runat="server" AutoGenerateColumns="false" Font-Names="verdana" Font-Size="11" ForeColor="DarkBlue">
                                                        <Columns>
                                                            <asp:BoundField DataField="Type" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left" HeaderText="Type" ItemStyle-Font-Names="Ariel" ItemStyle-Width="30px" ReadOnly="true" SortExpression="Taskid" />
                                                            <asp:BoundField DataField="Title" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Title" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px" ReadOnly="true" SortExpression="Title" />
                                                            <asp:BoundField DataField="Name" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Name" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Name" />
                                                            <asp:BoundField DataField="Status" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Status" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="200px" ReadOnly="true" SortExpression="Status" />
                                                            <asp:BoundField DataField="ACManager" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="AC Manager" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="200px" ReadOnly="true" SortExpression="ACManager" />
                                                            <asp:BoundField DataField="CompanyName" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="CompanyName" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="CompanyName" />
                                                            <asp:BoundField DataField="DoorNo" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="DoorNo" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="DoorNo" />
                                                            <asp:BoundField DataField="Street" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Street" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Time" />
                                                            <asp:BoundField DataField="City" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="City" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="City" />
                                                            <asp:BoundField DataField="PostCode" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="PostCode" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="PostCode" />
                                                            <asp:BoundField DataField="State" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="State" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="State" />
                                                            <asp:BoundField DataField="Country" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Country" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Country" />
                                                            <asp:BoundField DataField="Phone" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Phone" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Phone" />
                                                            <asp:BoundField DataField="Mobile" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Mobile" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Mobile" />
                                                            <asp:BoundField DataField="Email" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Email" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Email" />
                                                            <asp:BoundField DataField="Email2" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Email2" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Email2" />
                                                            <asp:BoundField DataField="Gender" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Gender" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Gender" />
                                                            <asp:BoundField DataField="VIP_Imp" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Category" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="VIP_Imp" />
                                                            <asp:BoundField DataField="New_Old" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="New_Old" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="New_Old" />
                                                            <asp:BoundField DataField="Notes" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Notes" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Notes" />
                                                            <asp:BoundField DataField="LeadSource" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="LeadSource" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="LeadSource" />
                                                            <asp:BoundField DataField="Campaign" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Campaign" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Campaign" />
                                                            <asp:BoundField DataField="Budget" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Budget" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Budget" />
                                                            <asp:BoundField DataField="Requirements" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Requirements" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Requirements" />
                                                            <asp:BoundField DataField="ProjectCode" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="ProjectCode" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="ProjectCode" />
                                                            <asp:BoundField DataField="Executive" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Executive" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="Executive" />
                                                            <asp:BoundField DataField="C_ID" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Created ID" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="C_ID" />
                                                            <asp:BoundField DataField="C_Date" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Created Date" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="C_Date" />
                                                            <asp:BoundField DataField="M_Id" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Modified ID" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="M_Id" />
                                                            <asp:BoundField DataField="M_Date" HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" HeaderText="Modified Date" ItemStyle-Font-Names="Ariel" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" ReadOnly="true" SortExpression="M_Date" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </caption>
                                    </table>
                                </div>                        
                        <%--R50-ROL --%>
                        <div id="dvROL" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div style="text-align:left;">                                    
                                     <asp:Label ID="Label78" runat="server" Text="R11 - Recognitions and Observations" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>                                                                                                                              
                                   </div>                                            
                                  
                                  <table>
                                              <tr>                                                                                                                                          

                                               <td>
                                                 <asp:Label ID="Label96" runat="server" CssClass="style2" Font-Size="X-Small"
                                                  Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Recorded from"></asp:Label>
                                                  <br />
                                                  <telerik:RadDatePicker ID="rdpROLfrom" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date range to filter the records." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar11" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput11" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                     <td>
                                                      <asp:Label ID="Label97" runat="server" CssClass="style2" Font-Size="X-Small"
                                                         Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Until"></asp:Label>
                                                                             <br />
                                                            <telerik:RadDatePicker ID="rdpROLTo" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date range to filter the records.." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar12" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput12" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td> 
                                                   <td>
                                                        <asp:Label ID="Label83" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                         Font-Names="Verdana" ForeColor="DarkGray" Text="Staff"></asp:Label>
                                                                             <br />
                                                     <asp:DropDownList ID="ddlROLStaff" runat="server" CssClass="style3" ToolTip="Selection of a staff name is allowed only for users in level 1"
                                                       Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px" OnSelectedIndexChanged="ddlmarkactref_SelectedIndexChanged">
                                                       </asp:DropDownList>
                                                                         </td>                                                                        
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnROLSearch" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search based on your filter dates and staff names." Width="76px" OnClick="btnROLSearch_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnROLExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnROLExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwR11ROL"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnR11ROL" Text="" Style="display: none;" OnClick="hbtnR11ROL_Click" runat="server" />
                                                                </td>                                                                
                                                                 <td valign="bottom" align="center">
                                                                      <asp:Label ID="lblROLCount" runat="server" CssClass="style2" Font-Bold="true" 
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>       
                                                                 </td>
                                                                     </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                            
                                                             
                                                                                                                                     
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvROL" runat="server" Skin="WebBlue" GroupingSettings-CaseSensitive="false" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="70%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvROL_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                            
                                                            <telerik:GridBoundColumn DataField="Name" HeaderText="Name" HeaderStyle-Width="10%" UniqueName="Name" HeaderStyle-Font-Names="verdana" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" SortExpression="Name" ItemStyle-Font-Names="verdana"
                                                                Visible="true" FilterControlWidth ="50px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date" HeaderStyle-Width="15%" SortExpression="Date" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana"  AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">                                                                
                                                            </telerik:GridBoundColumn>    
                                                                                                                      
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" HeaderStyle-Width="10%" HeaderStyle-Font-Names="verdana" SortExpression="Type" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Description" HeaderStyle-Width="35%" HeaderText="Description" UniqueName="Description" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Description" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>                                                          
                                                                                       
                                                            
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                        <%--R12--%>
                         <div id="dvR12TimeSummary" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label81" runat="server" Text="R12 -Time consumed per client - Summary" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>                                         
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table width="50%">
                                                            <tr>                                                                                                                                            
                                                                       
                                                                <td style="width:6%">
                                                                   <asp:Label ID="Label100" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="From date :"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="dtpr12from" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="select the from date to search the time consumed per client." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar13" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput13" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td style="width:6%">
                                                                             <asp:Label ID="Label101" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till date :"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="dtpR12till" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="select the till date to search the time consumed per client." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar14" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput14" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td style="width:5%"> 
                                                                             <br />                                                                           
                                                                             <asp:Button ID="btnR12search" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the Time consumed per client - Summary details" Width="76px" OnClick="btnR12search_Click" />
                                                                         </td>  
                                                                <td>  
                                                                     <br />                                                                   
                                                                     <asp:Button ID="btnR12excel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnR12excel_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwR12TimeCons"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnR12TimeCons" Text="" Style="display: none;" OnClick="hbtnR12TimeCons_Click" runat="server" />
                                                                     <asp:Label ID="lblR12Count" runat="server" CssClass="style2" Font-Bold="true"
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>
                                                                </td>                                                               
                                                                
                                                                     </tr>
                                      <tr>
                                          <td colspan="4">
                                              <asp:Label ID="Label82" runat="server" CssClass="style2" Font-Bold="true"  
                                               Font-Names="Verdana" Font-Size="X-Small" ForeColor="DarkGray" Text="Summary of total time spent per customer during the date range"></asp:Label> 
                                          </td>
                                      </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                            
                                                                
                                                                                                                                     
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR12details" runat="server" GroupingSettings-CaseSensitive="false" Skin="WebBlue" Visible="false" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="60%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR12details_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >  
                                                          <HeaderStyle HorizontalAlign="Justify" />                                                           
                                                        <Columns>                                                    
                                                            
                                                             <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer Name" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px" HeaderStyle-Width="20%" HeaderStyle-HorizontalAlign="Left">
                                                                  <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtncusprofile" CommandName="Profile" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                 <HeaderStyle HorizontalAlign="Left" Font-Names="Verdana" />
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                                     
                                                           
                                                            <telerik:GridBoundColumn DataField="By" HeaderText="By" UniqueName="By" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="By" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" HeaderStyle-Width="10%">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <HeaderStyle HorizontalAlign="Left" Font-Names="Verdana" />
                                                            </telerik:GridBoundColumn>                                                          
                                                            <telerik:GridBoundColumn DataField="Hours" HeaderText="Hrs.Mins" UniqueName="Hours" HeaderStyle-Font-Names="verdana" SortExpression="Hours" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" AllowFiltering="false" HeaderStyle-Width="20%">
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true"/>
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>                                                                                                                    
                                                            
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                         <%--R13--%>
                         <div id="dvR13TimeDetailed" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr>
                                          <td style="text-align: left">
                                              <asp:Label ID="Label95" runat="server" Text="R13 -Time consumed per client - Detailed" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>                                         
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table width="50%">
                                                            <tr>                                                                                                                                            
                                                                       
                                                                <td style="width:6%">
                                                                   <asp:Label ID="Label98" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="From date "></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="dtpR13from" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="select the from date to search the time consumed per client." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar15" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput15" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td style="width:6%">
                                                                             <asp:Label ID="Label99" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till date "></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="dtpR13to" runat="server" Culture="English (United Kingdom)"
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="select the till date to search the time consumed per client." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar16" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput16" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td style="width:5%"> 
                                                                             <br />                                                                           
                                                                             <asp:Button ID="btnR13search" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the Time consumed per client - Detailed reports" Width="76px" OnClick="btnR13search_Click" />
                                                                         </td>  
                                                                <td>  
                                                                     <br />                                                                   
                                                                     <asp:Button ID="btnR13excel" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnR13excel_Click" Width="76px" />   
                                                                     <telerik:RadWindowManager runat="server" ID="rwR13TimeDetail"></telerik:RadWindowManager>
                                                                    <asp:Button ID="nbtnR13TimeDetail" Text="" Style="display: none;" OnClick="nbtnR13TimeDetail_Click" runat="server" />
                                                                    &nbsp;
                                                                     <asp:Label ID="lblR13count" runat="server" CssClass="style2" Font-Bold="true" 
                                                             Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>  
                                                                   
                                                                </td>                                                                                                                               
                                                                       
                                                                     </tr>
                                      <tr>
                                          <td colspan="4">
                                              <asp:Label ID="Label102" runat="server" CssClass="style2" Font-Bold="true"  
                                               Font-Names="Verdana" Font-Size="X-Small" ForeColor="DarkGray" Text="Details of  time spent per customer by each user during the date range."></asp:Label> 
                                          </td>
                                      </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                            
                                                                 
                                                                                                                                     
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR13Details" runat="server" GroupingSettings-CaseSensitive="false" Skin="WebBlue" Visible="false" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR13Details_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >   
                                                             <HeaderStyle HorizontalAlign="Left" Font-Names="Verdana" />
                                                        <Columns>                                              
                                                            
                                                             <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer Name" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px" HeaderStyle-Width="20%" HeaderStyle-HorizontalAlign="Left">
                                                                  <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtncusprofile" CommandName="Profile" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                  <HeaderStyle HorizontalAlign="Left" Font-Names="Verdana" />
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>                                                            
                                                           
                                                           <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference" HeaderStyle-Font-Names="verdana" SortExpression="Reference" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" HeaderStyle-Width="20%">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="By" HeaderText="By" UniqueName="By" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="By" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" HeaderStyle-Width="10%">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>   
                                                            <telerik:GridBoundColumn DataField="OnDate" HeaderText="On Date" UniqueName="OnDate" HeaderStyle-Font-Names="verdana" SortExpression="OnDate" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  AllowFiltering="false" HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Center">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true" HorizontalAlign="Center"/> 
                                                            </telerik:GridBoundColumn>                                                    
                                                            <telerik:GridBoundColumn DataField="Minutes" HeaderText="Hrs.Mins" UniqueName="Minutes" HeaderStyle-Font-Names="verdana" SortExpression="Minutes" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" AllowFiltering="false" HeaderStyle-Width="5%">
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true"/>
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                                 <%--<ItemStyle ForeColor="#ff9933" Font-Names="Verdana" HorizontalAlign="Right"/>--%>
                                                            </telerik:GridBoundColumn>                                                                                                                    
                                                             <%--<telerik:GridBoundColumn DataField="Activity" HeaderText="Activity" UniqueName="Activity" HeaderStyle-Font-Names="verdana" SortExpression="Activity" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="150px" HeaderStyle-Width="35%" HeaderStyle-HorizontalAlign="Left">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true" HorizontalAlign="Left"/> 
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridTemplateColumn DataField="Activity" HeaderText="Activity"  UniqueName="Activity" HeaderStyle-Font-Names="verdana" SortExpression="Activity" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="150px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnTimeConsTaskID" CommandName="Tasks" CommandArgument='<%# Eval("RSN") +";" + Eval("TaskID") %>' Text='<%# Eval("Activity") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Names="Verdana" Wrap="true" />
                                                               <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                         <%--R14--%>
                         <div id="dvR14sysnotused" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                                                                                
                                  <div >
                                      <table width="100%">
                                       <tr>
                                          <td style="text-align: left">
                                              <asp:Label ID="Label103" runat="server" Text="R14 - System Usage Report" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                              <br />
                                              <asp:Label ID="lblr14msg" runat="server" Text="This report is showing all the active users and their Last acces date for our application." ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                               <br />
                                          </td>                                         
                                        </tr>                                         
                                        <tr>
                                            <td align="left">
                                                 <br />
                                                <telerik:RadGrid ID="gvR14Details" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" Visible="false" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="40%" AllowPaging="True"  PageSize="20" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR14Details_ItemCommand" >

                                                  <MasterTableView ShowHeadersWhenNoRecords="true" >                                                                                                                   
                                                        <Columns>                                                    
                                                            
                                                             <telerik:GridBoundColumn DataField="Customer" HeaderText="User" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px" HeaderStyle-Width="20%">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="LastAccess" HeaderText="Last Access" AllowFiltering="false" UniqueName="LastAccess" HeaderStyle-Font-Names="verdana" SortExpression="LastAccess" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  HeaderStyle-Width="20%" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>      
                                                        </Columns>
                                                      </MasterTableView>

                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                            
                                      
                         </div>
                         <div id="dvR5SServiceReport" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label12" runat="server" Text="R5S - Services" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblR5Sdate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblR5Sby" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                        <td>
                                                                             <asp:Label ID="Label49" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="#Reference"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlR5SReference" runat="server" CssClass="style3" ToolTip="Choose a reference (or #Tag) to identify Profiles matching the reference"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px">
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                        
                                                                         <td>
                                                                             <asp:CheckBox ID="chkR5Service" runat="server" ToolTip="Click here to services shows as per selected date range." Text="For a date range" CssClass="style2" Font-Size="X-Small" Font-Names="verdana" ForeColor="DarkGray" />
                                                                            <%-- <asp:Label ID="Label53" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="From"></asp:Label>--%>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="raddateR5Sfromdate" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date range to search the records." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar23" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput23" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label54" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="raddateR5Stodate" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date range to search the records." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar24" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput24" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                         
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnR5Sservices" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Select #Reference to search" Width="76px" OnClick="btnR5Sservices_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnR5SExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnR5SExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwmgrR5S"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnR5SServices" Text="" Style="display: none;" OnClick="hbtnR5SServices_Click" runat="server" />
                                                                </td>    
                                                                <td valign="bottom" align="center">
                                                                    <asp:Label ID="lblR5SCount" Visible="false"  runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                </td>                                                          
                                                                       
                                                            </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                          
                                                                        
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="100%">                                                             

                                                        <telerik:RadGrid ID="gvR5SServices" Visible="false" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" AutoGenerateColumns="False" Width="100%" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True" OnItemCommand="gvR5SServices_ItemCommand" >
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" >                                                             
                                                        <Columns>                                                            
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" HeaderStyle-Width="75px" UniqueName="Reference" HeaderStyle-Font-Names="verdana" SortExpression="Reference" ItemStyle-Font-Names="verdana"
                                                                Visible="true" FilterControlWidth ="80px">
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>                                                           
                                                             <telerik:GridTemplateColumn DataField="Customer" HeaderStyle-Width="150px" HeaderText="Customer" UniqueName="Customer" HeaderStyle-Font-Names="verdana" SortExpression="Customer" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="130px">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lbtnMarACtcustomer" CommandName="Select" CommandArgument='<%# Eval("RSN") %>' Text='<%# Eval("Customer") %>' runat="server"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn>  
                                                             <telerik:GridBoundColumn DataField="FromDate" HeaderStyle-Width="100px" HeaderText="From Date" UniqueName="FromDate" SortExpression="FromDate" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn> 
                                                             <telerik:GridBoundColumn DataField="ToDate" HeaderText="To Date" HeaderStyle-Width="100px" UniqueName="ToDate" SortExpression="ToDate" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="-" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"> 
                                                                <HeaderStyle Font-Names="Verdana" Wrap="true" />   
                                                                <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                           
                                                            </telerik:GridBoundColumn>                                                   
                                                                                                                     
                                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" HeaderStyle-Width="50px" HeaderStyle-Font-Names="verdana" SortExpression="Value" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                 <HeaderStyle Font-Names="Verdana" Wrap="true" />  
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/>                                                                 
                                                            </telerik:GridBoundColumn>                                                                             
                                                            
                                                            <telerik:GridBoundColumn DataField="Remarks" HeaderText="Remarks" UniqueName="Remarks" ItemStyle-Width="100px" HeaderStyle-Font-Names="verdana" SortExpression="Category" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  FilterControlWidth ="100px">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>                         
                        <div id="dvEODStats" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr>
                                          <td style="text-align: left">
                                              <asp:Label ID="Label43" runat="server" Text="R15-User tasks summary" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lbleoduserdate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lbleodusertby" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                      <tr>
                                          <td colspan="3">
                                              <asp:Label ID="lblEodUsersMsg" runat="server" Text="(Compare user work status based on First and Second date)" Font-Names="verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                                          </td>
                                      </tr>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                        
                                                                         <td>                                                                             
                                                                             <asp:CheckBox ID="chkEODUsers" runat="server" Visible="false" ToolTip="Click here to services shows as per selected date range." Text="Compare Date 1 and" Font-Bold="true" CssClass="style2" Font-Size="X-Small" Font-Names="verdana" ForeColor="DarkGray" />
                                                                             <asp:Label ID="Label53" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Date:" Visible="false"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="raddateeoduserfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date to compare with second date." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar25" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput25" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label55" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Date 2" Visible="false"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="raddateeoduserto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date to compare with first date" OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar26" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput26" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td> 
                                                                          <%-- <td>
                                                                             <asp:Label ID="lblEODUserSearch" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Users"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddleodusers" runat="server" CssClass="style3" ToolTip="Select the user name to search"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px">
                                                                             </asp:DropDownList>
                                                                         </td>   --%>                                                                
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnEODUsersearch" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the users work status details based on your date selection" Width="76px" OnClick="btnEODUsersearch_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnEODUsersExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnEODUsersExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwmgrEODusers"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnEODUsers" Text="" Style="display: none;" OnClick="hbtnEODUsers_Click" runat="server" />
                                                                </td>    
                                                                <td valign="bottom" align="center">
                                                                    <asp:Label ID="lblEODUsersCount" Visible="false"  runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                </td>                                                         
                                                                  
                                                            </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left;width:100%;">                                                          
                                                                        
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr style="width:100%;">    
                                                                                                                    
                                                            <td width="50%">    
                                                                <div id="dvEODUser" runat="server" visible="false">                                                             
                                                             
                                                                    
                                                       <telerik:RadGrid ID="gvEODUsersListTotal" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana"  AutoGenerateColumns="False" Width="600px" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >                                                             
                                                        <Columns>                                                       
                                                             <telerik:GridBoundColumn DataField="Date" HeaderStyle-Width="150px" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>  
                                                             <telerik:GridBoundColumn DataField="Total" HeaderStyle-Width="150px" HeaderText="Total" UniqueName="Total" SortExpression="Date" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                      
                                                            
                                                             <telerik:GridBoundColumn DataField="YettoStart" HeaderStyle-Width="100px" HeaderText="Yet to Start" UniqueName="YettoStart" SortExpression="YettoStart" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[InProgress]" HeaderText="InProgress" UniqueName="[InProgress]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px" HeaderStyle-Font-Names="verdana" SortExpression="[InProgress]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="[Completed]"  HeaderStyle-Width="75px" HeaderText="Completed" UniqueName="[Completed]" SortExpression="[Completed]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>   
                                                               </Columns> 
                                                            </MasterTableView>
                                                       </telerik:RadGrid>          
                                                                
                                                        <telerik:RadGrid ID="gvEODUsersList" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" OnItemCommand="gvEODUsersList_ItemCommand" AutoGenerateColumns="False" Width="600px" AllowPaging="True"  PageSize="10" Font-Names="Verdana" Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >                                                             
                                                        <Columns>                                                       
                                                            <telerik:GridTemplateColumn DataField="staffname" HeaderStyle-Width="150px" HeaderText="Name" UniqueName="staffname" HeaderStyle-Font-Names="verdana" SortExpression="staffname" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  AllowFiltering="false">
                                                                 <ItemTemplate>
                                                                     <asp:Label ID="lbtnMarACtcustomer" CommandName="Select" Text='<%# Eval("staffname") %>' runat="server"></asp:Label>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn> 
                                                            <telerik:GridBoundColumn DataField="Date" HeaderStyle-Width="150px" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                        
                                                               
                                                             <telerik:GridBoundColumn DataField="YettoStart" HeaderStyle-Width="100px" HeaderText="Yet to Start" UniqueName="YettoStart" SortExpression="YettoStart" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[InProgress]" HeaderText="InProgress" UniqueName="[InProgress]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px" HeaderStyle-Font-Names="verdana" SortExpression="[InProgress]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="[Completed]"  HeaderStyle-Width="75px" HeaderText="Completed" UniqueName="[Completed]" SortExpression="[Completed]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                  
                                                            
                                                            
                                                        </Columns>                                                            

                                                    </MasterTableView>
                                                       </telerik:RadGrid>                                                 
                                                                </div>
                                                            </td>                                                          
                                                        </tr>
                                                    </table>
                         </div>
                        <div id="dvEODCustStats" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr >
                                          <td style="text-align: left">
                                              <asp:Label ID="Label45" runat="server" Text="R16-Customer tasks summary" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>
                                          <td style="text-align: right">
                                    <asp:Label ID="lblEODCustDate" runat="server" Text="Print date:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                     &nbsp;&nbsp;
                                <asp:Label ID="lblEODCustBy" runat="server" Text="By:"
                                    Font-Bold="true" Font-Size="Small" ForeColor="DarkGray" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                          </td>
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                                 
                               
                                                            
                                  <table>
                                      <tr>
                                          <td colspan="3">
                                              <asp:Label ID="Label71" runat="server" Text="(Compare customer work status based on First and Second date)" Font-Names="verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                                          </td>
                                      </tr>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                        
                                                                         <td>
                                                                             <%--<asp:CheckBox ID="chkEODCust" runat="server" ToolTip="Click here to services shows as per selected date range." Text="For a date range" Font-Bold="true" CssClass="style2" Font-Size="X-Small" Font-Names="verdana" ForeColor="DarkGray" />--%>
                                                                             <asp:Label ID="lblEODCustomerlable" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Date" Visible="false"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="raddateEODCusfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date to compare with second date." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar27" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput27" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label58" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till" Visible="false"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="raddateEODCusto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the date to compare with previous selected date." OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar28" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput28" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td> 
                                                                <%-- <td style="visibility:hidden">
                                                                             <asp:Label ID="Label59" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Customers"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlEODCustomers" runat="server" CssClass="style3" ToolTip="Select the customer name to search"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px">
                                                                             </asp:DropDownList>
                                                                         </td>--%>                                                                        
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnEODCustSearch" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the customer status details based on your date selection" Width="76px" OnClick="btnEODCustSearch_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnEODCustExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnEODCustExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwmgrEODCustomer"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnEODCustomers" Text="" Style="display: none;" OnClick="hbtnEODCustomers_Click" runat="server" />
                                                                </td>    
                                                                <td valign="bottom" align="center">
                                                                    <asp:Label ID="lblEODCustCount" Visible="false"  runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                </td>                                                         
                                                                       
                                                            </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                         <td style="text-align: left">                                                          
                                                                        
                                                         </td>                                                                                                            
                                                        </tr>
                                                        <tr>                                                            
                                                            <td width="50%"> 
                                                                
                                                                
                                                        <telerik:RadGrid ID="gvEODCustomerListTotal" Visible="false" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" OnItemCommand="gvEODCustomerList_ItemCommand" AutoGenerateColumns="False" Width="600px" AllowPaging="True"  PageSize="15" Font-Names="Verdana"  Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >                                                             
                                                        <Columns>                                                       
                                                             <telerik:GridBoundColumn DataField="Total" HeaderStyle-Width="150px" HeaderText="Total" UniqueName="Total" SortExpression="Total" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn> 

                                                             <telerik:GridBoundColumn DataField="Date" HeaderStyle-Width="150px" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                            
                                                              
                                                             <telerik:GridBoundColumn DataField="YettoStart" HeaderStyle-Width="100px" HeaderText="Yet to Start" UniqueName="YettoStart" SortExpression="YettoStart" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[InProgress]" HeaderText="InProgress" UniqueName="[InProgress]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px" HeaderStyle-Font-Names="verdana" SortExpression="[InProgress]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="[Completed]"  HeaderStyle-Width="75px" HeaderText="Completed" UniqueName="[Completed]" SortExpression="[Completed]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[TotalCompleted]" HeaderText="Total Completed" UniqueName="[TotalCompleted]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" HeaderStyle-Font-Names="verdana" SortExpression="[TotalCompleted]" ItemStyle-Font-Names="verdana"
                                                                Visible="false"  AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>                                                            
                                                        </Columns>
                                                        
                                                    </MasterTableView>
                                                       </telerik:RadGrid>      
                                                                                                                            

                                                        <telerik:RadGrid ID="gvEODCustomerList" Visible="false" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" OnItemCommand="gvEODCustomerList_ItemCommand" AutoGenerateColumns="False" Width="600px" AllowPaging="True"  PageSize="15" Font-Names="Verdana"  Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                         <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >                                                             
                                                        <Columns>                                                       
                                                             <telerik:GridTemplateColumn DataField="Name" HeaderStyle-Width="150px" HeaderText="Customer Name" UniqueName="Name" HeaderStyle-Font-Names="verdana" SortExpression="Name" ItemStyle-Font-Names="verdana"
                                                                Visible="true"  AllowFiltering="false">
                                                                 <ItemTemplate>
                                                                     <asp:Label ID="lbtnMarACtcustomer" CommandName="Select" Text='<%# Eval("Name") %>' runat="server"></asp:Label>
                                                                 </ItemTemplate>
                                                              <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridTemplateColumn> 
                                                             <telerik:GridBoundColumn DataField="Date" HeaderStyle-Width="150px" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                            
                                                              
                                                             <telerik:GridBoundColumn DataField="YettoStart" HeaderStyle-Width="100px" HeaderText="Yet to Start" UniqueName="YettoStart" SortExpression="YettoStart" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[InProgress]" HeaderText="InProgress" UniqueName="[InProgress]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px" HeaderStyle-Font-Names="verdana" SortExpression="[InProgress]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="[Completed]"  HeaderStyle-Width="75px" HeaderText="Completed" UniqueName="[Completed]" SortExpression="[Completed]" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>                                                                                                                                   
                                                            
                                                            <telerik:GridBoundColumn DataField="[TotalCompleted]" HeaderText="Total Completed" UniqueName="[TotalCompleted]" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" HeaderStyle-Font-Names="verdana" SortExpression="[TotalCompleted]" ItemStyle-Font-Names="verdana"
                                                                Visible="false"  AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>                                                            
                                                        </Columns>
                                                        
                                                    </MasterTableView>
                                                       </telerik:RadGrid>
                                                  
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                         </div>
                        <div id="dvCompReport" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr>
                                          <td style="text-align: left">
                                              <asp:Label ID="Label50" runat="server" Text="R17-Service tasks summary" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>                                        
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                               
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                        
                                                                         <td>
                                                                             <asp:Label ID="Label65" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="From Date:"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="raddatecompreportfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the from date." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar29" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput29" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label66" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till :"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="raddatecompreportto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the till date to search" OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar30" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput30" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td> 
                                                                           <td>
                                                                             <asp:Label ID="Label67" runat="server" CssClass="style2" Font-Bold="true" Font-Size="X-Small"
                                                                                 Font-Names="Verdana" ForeColor="DarkGray" Text="Services :" Visible="false"></asp:Label>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlCompReportServices" runat="server" CssClass="style3" ToolTip="Select the type of service to search"
                                                                                 Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGreen" Width="128px" Visible="false">
                                                                                 <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                                                                 <asp:ListItem Text="#Service" Value="#Service"></asp:ListItem>
                                                                                 <asp:ListItem Text="#Complaint" Value="#Complaint"></asp:ListItem>
                                                                                 <asp:ListItem Text="#Warranty" Value="#Warranty"></asp:ListItem>                                                                                 
                                                                             </asp:DropDownList>
                                                                         </td>                                                                   
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnCompRepSearch" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the complaint reference report for your date selection" Width="76px" OnClick="btnCompRepSearch_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnComReportExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana" 
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnComReportExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwmgrComReport"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnCompReport" Text="" Style="display: none;" OnClick="hbtnCompReport_Click" runat="server" />                                                                    
                                                                </td>    
                                                                <td valign="bottom" align="center">
                                                                    <asp:Label ID="lblCompReportCount" Visible="false"  runat="server" CssClass="style2" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium" ForeColor="DarkGreen" Text=""></asp:Label>   
                                                                </td>                                                         
                                                                  
                                                            </tr>                                                             
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <br />
                                                        <tr style="width:100%;">                                                                                                                    
                                                            <td width="45%" valign="top">    
                                                                 <telerik:RadGrid ID="gvCompreport" Visible="false" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" OnItemCommand="gvCompreport_ItemCommand" AutoGenerateColumns="False" Width="500px" AllowPaging="True"  PageSize="15" Font-Names="Verdana"  Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                                     <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >
                                                                         <Columns>
                                                                         <telerik:GridBoundColumn DataField="TrackOnDesc" HeaderText="Reference" UniqueName="Service" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="55px" HeaderStyle-Font-Names="verdana" SortExpression="Service" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                                             <telerik:GridBoundColumn DataField="Registered" HeaderText="Registered" UniqueName="Registered" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="55px" HeaderStyle-Font-Names="verdana" SortExpression="Registered" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="Completed"  HeaderStyle-Width="55px" HeaderText="Completed" UniqueName="Completed" SortExpression="Completed" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>  
                                                              <telerik:GridBoundColumn DataField="Pending" HeaderStyle-Width="55px" HeaderText="Pending" UniqueName="Total" SortExpression="Pending" ItemStyle-Font-Names="verdana"
                                                                Visible="false" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>  
                                                                         </Columns>
                                                                     </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>       
                                                            
                                                         <td style="font-size:small;" valign="top">
                                                            <asp:Label ID="lblhlpSerReport" runat="server" Font-Names="verdana" ForeColor="Gray" Text="Registered: All activities that were ‘Registered’ during the given date range, are selected. It does not matter if such an activity is in progress or completed within the same date range."></asp:Label>
                                                             <br /><br />
                                                            <asp:Label ID="lblhlp1SerReport" runat="server" Font-Names="verdana" ForeColor="Gray"
                                                                         Text="Completed: All activities that were marked ‘Completed’during the given date range, are selected. It does not matter if such an activity was Registered or was in progress within the same date range.Here you see the status of #Complaint, #Service and #Warranty only."></asp:Label>
                                                         </td>                                               
                                                        </tr>
                                                    </table>
                         </div>

                        <div id="dvRefSummReport" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">
                            <table width="100%">
                             <tr>
                                <td>                                                               
                                  <div >
                                      <table width="100%">
                                       <tr>
                                          <td style="text-align: left">
                                              <asp:Label ID="Label57" runat="server" Text="Reference Summary Report" Font-Size="Medium" 
                                    Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>    
                                          </td>                                        
                                        </tr>
                                      </table>                                                                                                  
                                   </div>                                               
                               
                                                            
                                  <table>
                                                            <tr>                                                                                                                                            
                                                                       
                                                                        
                                                                         <td>
                                                                             <asp:Label ID="Label63" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="From Date:"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="raddaterefsummfrom" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the from date to search." OnSelectedDateChanged="RadDatemarkactfrom_SelectedDateChanged">
                                                            <Calendar ID="Calendar31" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput31" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label69" runat="server" CssClass="style2" Font-Size="X-Small"
                                                                                 Font-Bold="true" Font-Names="Verdana" ForeColor="DarkGray" Text="Till :"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="raddaterefsummto" runat="server" Culture="English (United Kingdom)" 
                                                            Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the till date to search" OnSelectedDateChanged="RadDatemarkactto_SelectedDateChanged">
                                                            <Calendar ID="Calendar32" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput32" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>                                                                                                                                   
                                                                         <td>
                                                                             <br/ />
                                                                             <asp:Button ID="btnRefSummSearch" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                                 Text="Search" ToolTip="Click here to search the reference based report for your date selection" Width="76px" OnClick="btnRefSummSearch_Click" />
                                                                         </td>  
                                                                <td>
                                                                    <br/ />
                                                                     <asp:Button ID="btnRefSummExport" runat="server" CssClass="btnReportpage"  Font-Names="Verdana"
                                                                    Text="Export" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." OnClick="btnRefSummExport_Click" Width="76px" />   
                                                                    <telerik:RadWindowManager runat="server" ID="rwRefsumm"></telerik:RadWindowManager>
                                                                    <asp:Button ID="hbtnRefSummReport" Text="" Style="display: none;" OnClick="hbtnRefSummReport_Click" runat="server" />
                                                                </td>   
                                                            </tr>
                                                                    
                                                         </table>           
                                                                    
                                                            </td>
                                                        </tr>
                                                         <br />
                                                        <tr style="width:100%;">                                                                                                                     
                                                            <td width="45%" valign="top">    
                                                                 <telerik:RadGrid ID="gvRefSummDetails" Visible="false" GroupingSettings-CaseSensitive="false" runat="server" Skin="WebBlue" GridLines="Both" HeaderStyle-Font-Names="verdana" ItemStyle-Font-Names="verdana" OnItemCommand="gvRefSummDetails_ItemCommand" AutoGenerateColumns="False" Width="500px" AllowPaging="True"  PageSize="12" Font-Names="Verdana"  Font-Size="Small"  AllowFilteringByColumn="True" AllowSorting="True">
                                                                     <MasterTableView ShowHeadersWhenNoRecords="true" AllowFilteringByColumn="false" >
                                                                         <Columns>
                                                                         <telerik:GridBoundColumn DataField="Service" HeaderText="Reference" UniqueName="Service" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="55px" HeaderStyle-Font-Names="verdana" SortExpression="Service" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                              <telerik:GridBoundColumn DataField="Registered" HeaderText="Registered" UniqueName="Registered" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px" HeaderStyle-Font-Names="verdana" SortExpression="Registered" ItemStyle-Font-Names="verdana"
                                                                Visible="true" AllowFiltering="false" EmptyDataText="0">
                                                                 <ItemStyle Font-Names="Verdana" Wrap="true"/> 
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="Completed"  HeaderStyle-Width="55px" HeaderText="Completed" UniqueName="Completed" SortExpression="Completed" ItemStyle-Font-Names="verdana"
                                                                Visible="true" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>  
                                                              <telerik:GridBoundColumn DataField="Pending"  HeaderStyle-Width="55px" HeaderText="Pending" UniqueName="Total" SortExpression="Pending" ItemStyle-Font-Names="verdana"
                                                                Visible="false" HeaderStyle-Font-Names="verdana" EmptyDataText="0" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                                                                                                     
                                                            </telerik:GridBoundColumn>  
                                                                         </Columns>
                                                                     </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>  
                                                            <td style="font-size:small;" valign="top">
                                                            <asp:Label ID="Label72" runat="server" Font-Names="verdana" ForeColor="Gray" Text="Registered: All activities that were ‘Registered’ during the given date range, are selected. It does not matter if such an activity is in progress or completed within the same date range."></asp:Label>
                                                             <br /><br />
                                                            <asp:Label ID="Label77" runat="server" Font-Names="verdana" ForeColor="Gray"
                                                            Text="Completed: All activities that were marked ‘Completed’during the given date range, are selected. It does not matter if such an activity was Registered or was in progress within the same date range.Here you see the status of all #References."></asp:Label>
                                                         </td>                                                              
                                                        </tr>
                                                    </table>
                         </div>
                         
                        <div id="dvDailyUsageBilllingReport" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:600px">                           
                                      <table style="width:100%">
                    <tr>
                        <td align="center">
                            <asp:Label ID="lblLevelY" runat="server" Visible="True" Text="Daily Usage Billing" Font-Underline="false" Font-Bold="true" Font-Names="verdana" Font-Size="Medium" ForeColor="Green"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table>

                    <tr>
                                          <td>
                                                <asp:Label ID="lblfordate" runat="Server" Text="From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date in the future, for which you wish to do the booking. " AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>

                                            <td>
                                                <asp:Label ID="lbluntildate" runat="Server" Text="To Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date upto which you wish to do the booking." AutoPostBack="true" >
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>

                       
                        <td style="right: auto">

                            <asp:Button ID="BtnShow" runat="server" CssClass="btnReportpage" ToolTip="Click here to Show daily usage Billing Report." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btnReportpage" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." Width="180px" />
                            
                        </td>
                        <td>
                            <asp:Label ID="Label59" runat="Server" Text="Here you get all the daily usage billing for  a given date range." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                        </td>
                    </tr>
                    

                </table>
                <table style="width:97%">
                    <tr>
                        <td align="right">
                            <asp:Label ID="lbltotoutstanding" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                             <asp:Label ID="lbltotdebitcredit" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>

                        <td style="width: 1200px; height: 185px; vertical-align: top;">
                            <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="true" PageSize="50" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                CellSpacing="5" Width="98%"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false">
                                    <NoRecordsTemplate>
                                        No Records Found.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>

                                         <telerik:GridBoundColumn HeaderText="RSN" DataField="RSN" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        
                                         <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false"  Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" DataField="Description" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Amount" DataField="Amount" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="ClosingBalance" DataField="ClosingBalance" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                         
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                    <PagerStyle AlwaysVisible="True"></PagerStyle>
                                </MasterTableView>
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <FilterMenu Skin="WebBlue" EnableTheming="True">
                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                </FilterMenu>
                            </telerik:RadGrid>


                        </td>

                    </tr>




                </table>
                        </div>
                    </td>
                </tr>             
               
            </table>

        </div>                    
       
            </ContentTemplate>
              <Triggers>
                  <asp:PostBackTrigger ControlID ="gvMarketingReport1" />
                  <asp:PostBackTrigger ControlID ="gvMarketingReport3" />
                  <asp:PostBackTrigger ControlID ="gvMarketingReport4" />
                  <asp:PostBackTrigger ControlID ="btnimgmr1exporttoexcel" />
                  <asp:PostBackTrigger ControlID ="HiddenButtonMR1Export" />              
                  <asp:PostBackTrigger ControlID ="btnimgMR3Excel" />
                  <asp:PostBackTrigger ControlID="HiddenButtonMR3Export" />
                  <asp:PostBackTrigger ControlID ="btnimgMR4Excel" />
                  <asp:PostBackTrigger ControlID ="HiddenButtonMR4Export" />
                  <asp:PostBackTrigger ControlID ="btnMarActExcel" />
                  <asp:PostBackTrigger ControlID ="HiddenButtonMarActExport" />
                  <asp:PostBackTrigger ControlID ="btnSerActExport" />
                  <asp:PostBackTrigger ControlID ="btnGenActExcel" />

                 
                  <%--WM Reports --%>
                   <asp:PostBackTrigger ControlID="btnwfr2Search" />
                <%--<asp:PostBackTrigger ControlID ="rmWMReports" />--%>
                <asp:PostBackTrigger ControlID="Search" />
                <asp:PostBackTrigger ControlID="gvWFR2" />
                <asp:PostBackTrigger ControlID ="gvWFR4" />
                <asp:PostBackTrigger ControlID ="gvWFR3" />
                <asp:PostBackTrigger ControlID="btnimgwfr2exporttoexcel" />
                <asp:PostBackTrigger ControlID="btnimgwfr4exporttoexcel" />
             
                    <asp:PostBackTrigger ControlID ="btnHiddensmxExport" />
                    <asp:PostBackTrigger ControlID ="btn2Hiddensmx2Export" />
  
                    <asp:PostBackTrigger ControlID ="btnHiddensmx5Export" />

                    <asp:PostBackTrigger ControlID="btnimgexporttoexcel1" />
                    <asp:PostBackTrigger ControlID="btnimgexporttoexcel2" />
                   
                
                    <asp:PostBackTrigger ControlID="btnimgexporttoexcel5" />            

                  <asp:PostBackTrigger ControlID ="btnROLExport" />
                  <asp:PostBackTrigger ControlID ="btnR12excel" />
                  <asp:PostBackTrigger ControlID ="btnR13excel" />
                  <asp:PostBackTrigger ControlID ="btnR4EnqRegExcel" />
                  <asp:PostBackTrigger ControlID ="HiddenButtonEnqRegExport" />
                  <asp:PostBackTrigger ControlID ="btnr4quoatesubexcel" />
                  <asp:PostBackTrigger ControlID="HiddenButtonQuoSubExport" />
                  <asp:PostBackTrigger ControlID ="btnR4OrdersBookExcel" />
                  <asp:PostBackTrigger ControlID ="hbtnR4Orders" />
                  <asp:PostBackTrigger ControlID ="hbtnR5serAct" />
                  <asp:PostBackTrigger ControlID ="hbtnR6genAct" />
                  <asp:PostBackTrigger ControlID ="hbtnR7workprog" />
                  <asp:PostBackTrigger ControlID ="hbtnR9hrsspent" />
                  <asp:PostBackTrigger ControlID ="hbtnR11ROL" />
                  <asp:PostBackTrigger ControlID ="hbtnR12TimeCons" />
                  <asp:PostBackTrigger ControlID ="nbtnR13TimeDetail" />
                  <asp:PostBackTrigger ControlID="hbtnR5SServices" />
                  <asp:PostBackTrigger ControlID="hbtnEODUsers" />
                  <asp:PostBackTrigger ControlID="hbtnEODCustomers" />
                  <asp:PostBackTrigger ControlID="hbtnCompReport" />
                  <asp:PostBackTrigger ControlID="hbtnRefSummReport" />  
                  <asp:PostBackTrigger  ControlID="BtnnExcelExport" /> 
                  <asp:PostBackTrigger ControlID="btnimgmr1exporttoexcel" />                
              </Triggers>  
              </asp:UpdatePanel>
            
             <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="uptab" runat="server">
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
        
        </div>
    <div id="pnlCalender" style="display:none;">
        <div style="text-align:right">
         <asp:Button ID="Button1" runat="server" CssClass="ButtonVisible" Width="90" Font-Size="X-Small" Text="Back" ToolTip="Click here to return home." OnClick="btnReturn_Click"/>
      </div>  
        <div id="calender" style="display:none;"></div>     
     </div>       
</asp:Content>

                                    