<%@ Page Title="" Language="C#" EnableEventValidation="false" ValidateRequest="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ByMe.aspx.cs" Inherits="ByMe" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/ManageTask.js"></script>
    <script type="text/javascript" src="js/Validations.js"></script>
    <script type="text/javascript" src="js/Disablebackbtn.js"></script>

    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />

    <script type="text/javascript">
        function ConfirmClick() {
            document.getElementById('<%=wsgetLatestbtn.ClientID%>').click();
        }
        function BulkClick() {
            document.getElementById('<%=Button3.ClientID%>').click();
        }
    </script>
    <script type="text/javascript">
        ByMeblock();
    </script>
    
   <style type="text/css">
    .preference .rwWindowContent
    {
        background-color: beige !important;
    }
    .availability .rwWindowContent
    {
        background-color: Yellow !important;
    }
    
</style>
    <title>By Me</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
    </telerik:RadWindowManager>
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="JQuery/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="JQuery/jquery.autocomplete.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function NavigateDir(X, Z) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (600 + 5);
            iMyHeight = (window.screen.height / 2) - (250 + 35);
            var Y = 'AddTaskTracker.aspx?TTID=' + X + '&UserID=' + Z;
            var win = window.open(Y, "Window2", "status=no,height=570,width=850,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
            win.focus();
        }

        function NavigateDir2(cusrsn) {
            var iMyWidth;
            var iMyHeight;
            var rsn ='RSN=' + cusrsn;
            var taskid = document.getElementById('<%=Label21.ClientID %>').innerText;
            iMyWidth = (window.screen.width / 2) - (450 + 50);
            iMyHeight = (window.screen.height / 2) - (285 + 30);
            var Y = 'AddTaskTracker.aspx?' + rsn;
            var win = window.open(Y, "Window2", "status=no,height=630,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }

        function NavigateNewTask(getlatestbtn) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);
            var X = window.document.getElementById('<%= HDLoginUser.ClientID %>').value;
            var Y = 'AddNewTask.aspx?ctrlID=' + getlatestbtn + '&UserID=' + X;
            var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
        function NavigateNewEnquiry(getlatestbtn) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);
            var X = window.document.getElementById('<%= HDLoginUser.ClientID %>').value;
              var Y = 'AddNewEnquiry.aspx?ctrlID=' + getlatestbtn + '&UserID=' + X;
              var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
              win.focus();
        }
        function NavigateNewActivity(getlatestbtn) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (600 + 10);
            iMyHeight = (window.screen.height / 2) - (300 + 25);
            var X = window.document.getElementById('<%= HDLoginUser.ClientID %>').value;
            var Y = 'Activity.aspx?ctrlID=' + getlatestbtn + '&UserID=' + X;
            var win = window.open(Y, "Window2", "status=no,height=620,width=1200,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
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
        function alertmsg() {
            var x = confirm('You are about to change the status of activities you have selected.This may be irreversible confirm.', "Alert");
            if (x) {
                BulkClick();
                //return true;
            }
            else {
                //return false;
            }
        }
        function alertmsg1() {
            alert('Do you wish to write a common remark and/or update status for more than one activity? If so, Select two or more activities first');
        }
        function confirmbulk(count, update) {
            //alert(count);
            var len = count;
            var lupdate = update;
            alert('Total number of selected tasks : ' + len + '\n' + 'Total number of updated tasks : ' + lupdate);
        }
        function BulkValidate() {
            var summ = "";
            summ += comments();
            if (summ != "") {
                alert(summ);
                return false;
            } else {
                var x = confirm('Do you want to save?');
                if (x)
                    return true;
                else
                    return false;
            }
        }
        function comments() {
            var comm = document.getElementById('<%=txtbulktext.ClientID%>').value;
            if (comm == "") {
                return "Please enter comments";
            } else {
                return "";
            }
        }
    </script>
    <script type="text/javascript">
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();            
            var navigateUrl = item.get_navigateUrl();
            //alert(navigateUrl);
            if(navigateUrl == "#")
            {
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
        function NavigateCalendar() {
            var url = "Calendar.aspx";
            //window.open(url, "_self");    // For replacing same page
            window.open(url, "_blank");
        }
    </script> 
    <table style="width: 100%;">
        <asp:Button ID="wsgetLatestbtn" runat="server" Text="WS Get Latest" OnClick="wsgetLatestbtn_Click" CssClass="hidden" CausesValidation="false" />
        <asp:Button ID="Button3" runat="server" Text="WS Get Latest" onclick="Button3_Click" CssClass="hidden"  CausesValidation="false" />
        <tr>
            <table style="width: 100%">
                <tr style="width: 100%;">
                    <td align="center" style="width: 78%;">
                       <%-- <asp:Label ID="lblHeading" runat="server" Text="By Me" Font-Size="Large" Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>--%>
                         <asp:LinkButton ID="lnkmytasks" Height="10px" Font-Underline="false" OnClick="lnkmytasks_Click"  ToolTip="Click here to view activities meant for you." Font-Bold="true" Font-Size="Large" Text="Activities for me " Font-Names ="verdana"  runat="server" />
                        <asp:LinkButton ID="lnkbyme" Height="10px" Font-Underline="false" OnClick="lnkbyme_Click"  ToolTip="Click here to view activities assigned by you for others." Font-Bold="true" Font-Size="Large" Text=" / Assigned by me" Font-Names ="verdana"  runat="server" />
                        <asp:LinkButton ID="lnknewactiviy" Height="10px" Font-Underline="false"  ToolTip="Click here to add a new activity" Font-Bold="true" Font-Size="Large" Text=" / New Activity" runat="server" Font-Names ="verdana" /><br />
                        <asp:LinkButton ID="LinkButton1" Height="10px" Font-Underline="false"  ToolTip="Click grey title to open new screen." ForeColor ="DarkGray" Font-Bold="true" Font-Size="Small" Text="Click grey title to open new screen." runat="server" Font-Names ="verdana" />

                    </td>
                     <td>
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
                    <td align="right" style="width: 5%;">                       
                        <asp:ImageButton ID="ImageButton2" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
                    </td>
                    <td style="width: 2%;" align="right" valign="middle">
                        <asp:LinkButton ID="lblHome" Font-Underline="false" PostBackUrl="~/Home.aspx" ToolTip="Click here to return back to home" Height="10px" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
                    </td>
                    <td style="width: 3%;" align="right">
                        <asp:ImageButton ID="ImageButton1" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                    </td>
                    <td style="width: 5%;" align="left" valign="middle">
                        <asp:LinkButton ID="lbSignOut" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work."  Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                    </td>
                </tr>
            </table>
            <td>
                <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwDiary" VisibleOnPageLoad="false" Width="1000" MinHeight="400"
                                        runat="server" EnableShadow="true" EnableEmbeddedSkins="false" Modal="true">
                                        <ContentTemplate>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td align="left">

                                                            <asp:Label ID="lbldiaryheadName" runat="server" Text="" CssClass="style2" ForeColor="DarkBlue"
                                                                Font-Bold="true" Font-Size="Medium"></asp:Label>

                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lbldiarycount" runat="server" Text="" Font-Names="Calibri" Font-Bold="true" ForeColor="Green"></asp:Label>
                                                            <asp:Button ID="btnDiaryClose" runat="server" Text="Close" CssClass="Button" Width="50px"
                                                                ToolTip="Click to return to Profile page." OnClick="btnDiaryClose_Click" />
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <asp:GridView ID="gvDiary" runat="server" AutoGenerateColumns="false" OnDataBound="onDataBound"
                                                                AllowPaging="true" PageSize="10" OnPageIndexChanging="OnDiaryPaging">
                                                                <Columns>
                                                                    <%-- <asp:BoundField HeaderText="#" DataField="TaskID" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />--%>

                                                                    <asp:TemplateField HeaderText="#" HeaderStyle-BackColor="DarkBlue" HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small"
                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lbltaskid" runat="server" Text='<%# Eval("TaskID") %>'></asp:LinkButton>

                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>


                                                                    <asp:BoundField HeaderText="Reference" DataField="TrackOn" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                    <asp:BoundField HeaderText="Activity" DataField="Comments" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="400px"
                                                                        ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" />
                                                                    <asp:BoundField HeaderText="Date and Time" DataField="Datestamp" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
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
                                                            </asp:GridView>
                                                            <br />
                                                            <%-- <asp:Label ID="Label19" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Activity IDs in BLUE are currently in progress."></asp:Label><br />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center"></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                             <tr>
                        <td>
                            <telerik:RadWindow ID="rwHelp" CssClass ="availability" BackColor="#ffff00" Title="Help" VisibleOnPageLoad="false" Width="900" Height="350" runat="server" Modal="true">
                            <ContentTemplate>
                                <div>
                                     <table>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label2" runat="server" Text="Select one or more tasks and click 'Update' button." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label3" runat="server" Text="You can also select a task by clicking the 'Assigned To' name." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label5" runat="server" Text="Click on a # number (Task ID)  to request for Progress Update. A mail goes to the person." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label6" runat="server" Text="Place mouse on a field title and click to sort on that field either on ascending or descending order." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label7" runat="server" Text="Example: If you wish to sort by Customer Name, click on Name." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label8" runat="server" Text="By default: My Tasks are shown in Descending order of #.  In By Me the sorting is by LatestProgressUpdate." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label9" runat="server" Text="Priority Tasks : All activities marked Hot and Very Hot are considered as Priority Tasks." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label11" runat="server" Text="#MobileApp : This is the reference used if the activity is assigned from the Mobile App." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label12" runat="server" Text="For #MobileApp activities, the default customer name is the name of the Software Licensee. Remember to change it appropriately." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label13" runat="server" Text="LeadStatus:  This is valid only for Prospective customers.   If this field value is ‘Other’ it refers to a party neither a customer nor a lead." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label14" runat="server" Text="You can Update Status of a task or write progress report for a task, either by clicking on the ‘Assigned to’ name or by ‘Selecting the Check Box and clicking the Update button." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label15" runat="server" Text="What to do if you have more than one task to update and wish to write same progress report for all of them or wish to update status for all of them?" CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label17" runat="server" Text="It is easy. Simply select all the tasks and click the Bulk Update button. A Popup will appear. Write the comments and if needed change the status. All tasks will be updated." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         
                                     </table>
                                </div>
                            </ContentTemplate>    
                            </telerik:RadWindow>
                        </td>
                    </tr>
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwCustomerProfile" VisibleOnPageLoad="false" Width="900" Height="350"
                                        runat="server" Modal="true">
                                        <ContentTemplate>
                                            <div style="width: 100%; float: left">
                                                <div style="width: 40%; float: left">
                                                    <table style="border-collapse: collapse; border: 1px solid black; font-family: Verdana; font-size: small">
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Label ID="lblcphead" runat="server" Text="Profile" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblcptitle" runat="server" Text="Title" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblscptitle" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpname" runat="server" Text="Name" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcategory" runat="server" Text="Category" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcategory" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcomapanyname" runat="server" Text="Main Contact/Company" Width="100px"
                                                                    CssClass="style2" ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcompanyname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcptype" runat="server" Text="Type" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscptype" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpdoorno" runat="server" Text="Door No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpdoorno" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstreet" runat="server" Text="Street" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstreet" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcity" runat="server" Text="City" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcity" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcppinzip" runat="server" Text="Pincode" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscppinzip" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstate" runat="server" Text="State" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstate" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcountry" runat="server" Text="Country" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcountry" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpphone" runat="server" Text="Phone No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpphone" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpmobile" runat="server" Text="Mobile No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpmobile" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail" runat="server" Text="EmailID" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail2" runat="server" Text="EmailID2" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail2" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Button ID="btnCPClose" runat="server" Text="Close" CssClass="Button" Width="100px"
                                                                    OnClick="btnCPClose_Click" ToolTip="Click to close customer status history." />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="width: 60%; float: left">
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
                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" Font-Names="verdana" Font-Size="X-Small"
                                                                    DataKeyNames="RSN">
                                                                    <HeaderStyle Font-Bold="false" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Designation" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="EmailID" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="PhoneNo" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="MobileNo" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Department" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Location" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
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
                                                                <asp:Label ID="lblcpinprogress" runat="server" Font-Names="verdana" Font-Size="X-Small" ForeColor="Black" BackColor="Yellow" Text="No of activities inprogress now"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upnlbulk" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <telerik:RadWindow ID="rwBulkUpdate" Skin="Default" CssClass ="preference" Behaviors="None" BackColor="Gray" BorderColor="Blue" Title="Bulk Update" runat="server" BorderStyle="Solid" Modal="true" Height="320" Width="500">
                                                <ContentTemplate>
                                                    <table style="width: 100%; font-family: Verdana; font-size: small;">
                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <asp:Label ID="lblbulkhead" CssClass="style2" runat="server" Font-Size="Large" Text="Bulk Update"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="lblbulktext" CssClass="style3" Text="Enter text/comments for all selected activities :" runat="server" Font-Size="Medium"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtbulktext" ToolTip="Write here notes about the progress of the task in detail. Do not be cryptic. It will save time later" runat="server" TextMode="MultiLine" Height="75px" Width="250px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="Label1" CssClass="style3" Text="New status for all selected activities :" runat="server" Font-Size="Medium"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlbulkstatus" runat="server" Width="250px" CssClass="style3" ToolTip="Set status to Completed if this work is now done. Caution! You cannot undo the action.">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <asp:Button ID="btnbulksubmit" ToolTip="Click here to update status and details to you have selected tasks." OnClientClick="return BulkValidate()" runat="server" Text="Save" CssClass="btnMainpage" OnClick="btnbulksubmit_Click" />
                                                                <asp:Button ID="btnbulkclose" ToolTip="click here to close the screen and return back to home." OnClientClick="ConfirmClick()" runat="server" Text="Close" CssClass="btnMainpage" OnClick="btnbulkclose_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr align ="center">
                                                            <td colspan ="2">
                                                                <asp:Label ID="lbl1" runat="server" Text="You can write one common remark for all selected activities." Font-Names ="verdana" ForeColor ="Gray" Font-Size="Smaller"></asp:Label><br />
                                                                <asp:Label ID="Label4" runat="server" Text="You can also update status of all the selected activities." Font-Names ="verdana" ForeColor ="Gray" Font-Size="Smaller"></asp:Label><br />
                                                                <asp:Label ID="Label10" runat="server" Text="Use this option only if the remarks to be entered are the same or if you wish to mark as ‘Completed’ several activities in one-shot." Font-Names ="verdana" ForeColor ="Gray" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </telerik:RadWindow>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlTaskList2" runat="server" CssClass="style3" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlTaskList2_Change" ToolTip="Select tasks according to their status. " BackColor="Yellow">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlbymereference" runat="server" CssClass="style3" BackColor="Yellow" ToolTip="#Reference  - Use #Tags to identify the purpose of an activity.">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnView2" runat="server" Text="View/Refresh" CssClass="btnMainpage" ToolTip=""
                                                    OnClick="btnView2_Click" BackColor="#6CA5BC" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNewPing2" runat="server" Text="Update" OnClick="btnNewPing2_Click"
                                                    BackColor="#6CA5BC" Visible="false" CssClass="btnMainpage" ToolTip="Select one or more tasks, and write progress of work in each task . These are known as Tracker entries." />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnMainbulkupdate" runat="server" Text="Bulk Update" CssClass="btnMainpage" BackColor="#6CA5BC" ToolTip="Select one or more tasks, and write progress of work in each task ." OnClick="btnMainbulkupdate_Click" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnTaskDetDir2" runat="server" Text="Export to Excel" CssClass="btnMainpage" Width="120px"
                                                    BackColor="#6CA5BC" Visible="false" OnClick="btnTaskDetDir2_Click" ToolTip="Export the list of tasks to MSExcel." />
                                            </td>
                                            <td>
                                                <asp:Button ID="Button1" runat="server" Text="Add New Task" CssClass="btnMainpage" Width="130px"
                                                    ToolTip="Click here to assign a new activity to yourself or your sub-ordinates." OnClick="Button2_Click" ForeColor="Black" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnbymenewenquiry" runat="server" Text="Add New Enquiry" CssClass="btnMainpage" Width="130px"
                                                    ToolTip="Click here to register new enquiry." OnClick="btnbymenewenquiry_Click" ForeColor="Black" />
                                            </td>
                                            <td>
                                        <asp:Button ID="btnHelp" runat="server" Text="Help" CssClass="btnMainpage" BackColor="#6CA5BC" ToolTip="Click here to show the help of my tasks." OnClick="btnHelp_Click" />
                                    </td>
                                            <td>
                                                <asp:CheckBox ID="chkShowAll" runat="server" ToolTip="If you have the permission, you can view tasks assigned by others also.  This opton is to see the complete list of activities in progress or completed." Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                    Text="View all" />
                                            </td>
                                            
                                            <td>
                                                <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
                                                <asp:Label ID="lblbymecount" runat="server" Text="" Font-Names="Calibri" Font-Bold="true" ForeColor="Green"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblHelp44" Text="Select one or more tasks and click 'Update' button to review/update progress.You can also select a task by clicking the 'Assigned To' name.*Ensure POPUPS are NOT blocked. PING: Click on a # number to request for Progress Update.  A mail goes to the person."
                                        ForeColor="DarkGray" Font-Names="verdana" Font-Bold="true" Font-Size="X-Small"
                                        runat="server" Visible="false"></asp:Label><br />
                                     <asp:Label ID="Label18" runat="server"  Font-Bold="true" Font-Names="verdana" ForeColor="LightGreen" Font-Size="X-Small"
                                Text="Remember to update any activity assigned from the smart phone app."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 80%">
                                    <%--<asp:Label ID="Label13" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Customer names appear in green."></asp:Label><br />--%>
                                    <telerik:RadGrid ID="RdGrd_TaskDetDir2" runat="server" Skin="WebBlue" GridLines="None" AllowFilteringByColumn="true" GroupingSettings-CaseSensitive="false"
                                        AutoGenerateColumns="False" Visible="false" OnItemDataBound="RdGrd_ProjectSel_ItemDataBound2" OnItemCommand="RdGrd_TaskDetDir2_ItemCommand">
                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowSorting ="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>

                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Select & Update" Exportable="false" AllowFiltering="false">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleByMeSelectedState" AutoPostBack="True" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkJSel" runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn DataField="StaffID" HeaderText="Assigned To" UniqueName="StaffID"
                                                    Visible="true" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridTemplateColumn DataField="StaffID" HeaderText="Assigned To" UniqueName="StaffID"
                                                    Visible="true" FilterControlWidth="50px" SortExpression ="StaffID">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnStaffid" ToolTip="Click here to write progress of work in each task .These are known as Tracker entries." runat="server" Text='<%# Eval("StaffID") %>' CommandArgument='<%# Eval("TaskID") + ";" + Eval("CustomerRSN") %>' CommandName="StaffUpdate"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="CustomerStatus" HeaderText="LeadStatus" UniqueName="CustomerStatus"
                                                    Visible="true" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn HeaderText="Name" ItemStyle-Width="10px" FilterControlWidth="50px" DataField="Name" SortExpression ="Name">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkname" runat="server" CommandName="CustomerName" CommandArgument='<%# Eval("CustomerRSN") %>' Text='<%# Eval("Name") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference"
                                                    Visible="true" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn HeaderText="Most recent work progress" DataField="Comments" ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="50px" SortExpression ="Comments">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkcomments" runat="server" CommandName="Activities" CommandArgument='<%# Eval("CustomerRSN") %>' Text='<%# Eval("Comments").ToString().Length > 25? (Eval("Comments") as string).Substring(0,25) + " ..." : Eval("Comments")  %>'
                                                            ToolTip='<%# Eval("Comments") %>'></asp:LinkButton>
                                                        <%--<asp:LinkButton ID="lnkcomments" runat="server" CommandName="Activities" CommandArgument='<%# Eval("CustomerRSN") %>' Text='<%# Eval("Comments") %>'></asp:LinkButton>--%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="#" ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Center" DataField="TaskID" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="50px" SortExpression ="TaskID">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnktaskid" runat="server" CommandName="Pink" CommandArgument='<%# Eval("TaskID") %>' Text='<%# Eval("TaskID") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target" UniqueName="TargetDate"
                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Priority" HeaderText="Priority" UniqueName="Priority"
                                                    Visible="false" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Status" HeaderText="TaskStatus" UniqueName="Status"
                                                    Visible="true" HeaderTooltip="if Hot or Very Hot Show Status in RED" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Tracker" HeaderText="Ct." UniqueName="Tracker"
                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="PriorityDesc" HeaderText="Priority" UniqueName="PriorityDesc"
                                                    Visible="true" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Followupdate" HeaderText="Fwup?" UniqueName="FollowupDate"
                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="AssignedBy" HeaderText="AsgndBy" UniqueName="AssignedBy"
                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="DelegateBy" HeaderText="DlgtBy" UniqueName="DelegateBy"
                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50px">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                        </table>
                        </td>
                </tr>
    </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnNewPing2" />
                        <asp:PostBackTrigger ControlID="btnView2" />
                        <asp:AsyncPostBackTrigger ControlID="ddlTaskList2" EventName="SelectedIndexChanged" />
                        <asp:PostBackTrigger ControlID="btnTaskDetDir2" />

                    </Triggers>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
                    <ProgressTemplate>
                        <div class="modal">
                            <div class="center">
                                <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                                <%--<asp:ImageButton ID="btnUpdateLoad" runat="server" ImageUrl="~/images/Loader.gif" />--%>
                            </div>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <asp:HiddenField ID="HDUserLevel" runat="server" />
                <asp:HiddenField ID="HDUserID" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="HDLoginUser" runat="server" />
                <asp:HiddenField ID="CnfResult" runat="server" />
                <asp:Label ID="Label21" runat="server" Text="Label" Style="display: none"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

