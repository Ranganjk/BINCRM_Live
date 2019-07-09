<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <script type="text/javascript" src="js/Disablebackbtn.js"></script>
    <script type="text/javascript">
        Admin();
    </script>
    <title>Admin</title>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/quicksearch.js"></script>

    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/adminCenterPositionCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />

    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += Phno();
            summ += Email();
            summ += ID();
            summ += Name();
            //summ += Designation();
            summ += UserID();
            //summ += pwd();
            if (summ == "") {
                var msg = "";
                msg = 'Do you want to Save?';
                var result = confirm(msg, "Check");
                if (result) {
                    document.getElementById('Content_CnfResult').value = "true";
                    return true;
                }
                else {
                    document.getElementById('Content_CnfResult').value = "false";
                    return false;
                }

            }
            else {
                alert(summ);
                return false;
            }

        }
        function ID() {
            var Name = document.getElementById('<%=txtStaffID.ClientID%>').value;
            if (Name == "") {
                return "Please Enter ID" + "\n";
            }
            else {
                return "";
            }
        }
        function Name() {
            var Name = document.getElementById('<%=txtStaffName.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Staff Name" + "\n";
            }
            else {
                return "";
            }
        }
        function Designation() {
            var Name = document.getElementById('<%=txtStaffDesignation.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Designation" + "\n";
            }
            else {
                return "";
            }
        }
        function UserID() {
            var Name = document.getElementById('<%=txtStaffUserName.ClientID%>').value;
            if (Name == "") {
                return "Please Enter User Name" + "\n";
            }
            else {
                return "";
            }
        }
        function pwd() {
            var Name = document.getElementById('<%=txtPassword.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Password" + "\n";
            }
            else {
                return "";
            }
        }

        function Phno() {
            var Name = document.getElementById('<%=txtStaffPhone.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/
            if (Name == "") {
                return "Please Enter Mobile No" + "\n";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Mobile No" + "\n";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=txtStaffEmail.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "Please Enter Email ID" + "\n";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Email ID" + "\n";
            }
        }

        function allowOnlyNumber(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            width: 84px;
        }

        .auto-style2 {
            width: 120px;
        }

        .style3 {
            color: black;
            font-family: Verdana;
            font-size: 9;
        }
    </style>

    <style type="text/css">
        .buttonClass {
            padding: 2px 15px;
            text-decoration: none;
            border: solid 1px black;
            background-color: lightgray;
        }

            .buttonClass:hover {
                border: solid 1px Black;
                background-color: #ffffff;
            }
    </style>

    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            $(document).ready(function () {
                $('.search_textbox').each(function (i) {
                    $(this).quicksearch("[id$='PhasesTempGrid'] tr:not(:has(th))", {
                        'testQuery': function (query, txt, row) {
                            return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                        }
                    });
                });

            });
        });
    </script>
    <script type="text/javascript">
        function GetRecords() {
            document.getElementById('Button2').click();
        }
    </script>
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

        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <div>
        <table style="width: 100%">
            <tr style="width: 100%;">
                <td align="center" style="width: 80%;">
                    <asp:Label ID="Label2" runat="server" Text="Settings" Font-Size="Large"
                        Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                </td>
                <td>
                    <telerik:RadMenu Font-Names="verdana" Width="110px" OnClientItemClicking="onClicking" ForeColor="Blue" ID="rmenuQuick" runat="server" ShowToggleHandle="false" Skin="Outlook" EnableRoundedCorners="true" EnableShadows="true" ClickToOpen="false" ExpandAnimation-Type="OutBounce" Flow="Vertical" DefaultGroupSettings-Flow="Horizontal">
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
                <td align="right" style="width: 5%;">
                    <asp:ImageButton ID="ImageButton2" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
                </td>
                <td style="width: 2%;" align="right" valign="middle">
                    <asp:LinkButton ID="Label69" Font-Underline="false" PostBackUrl="~/Home.aspx" Height="10px" Font-Bold="true" ToolTip="Click here to return back to home" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
                </td>
                <td style="width: 3%;" align="right">
                    <asp:ImageButton ID="ImageButton3" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                </td>
                <td style="width: 5%;" align="left" valign="middle">
                    <asp:LinkButton ID="Label79" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work." Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <telerik:RadMenu ID="rmAdminMenu" runat="server" Skin="" OnItemClick="rmAdminMenu_ItemClick">
                        <CollapseAnimation Type="OutQuint" Duration="200" />
                        <Items>
                            <telerik:RadMenuItem runat="server" Text="About" ToolTip="Shows the license information" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep0" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Scrolling Banner" ToolTip="Scrolling message on the login screen" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep1" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Campaign" ToolTip="" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep2" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Reference" ToolTip="" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep3" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Check List" ToolTip="Create check list for each type of reference" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep11" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="KeyLookUp" ToolTip="Define key,text and description." CssClass="level_menu" Visible="false">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="LeadCategory" ToolTip="" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep4" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Inform All" ToolTip="Broadcast a message to all users" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep5" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Holiday" ToolTip="Holiday settings" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep6" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Login Audit" ToolTip="View audit trail of system usage" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep7" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="User Management" ToolTip="Create new users" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep8" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="Upload" ToolTip="Upload bulk customer details from excel" Visible="true" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep9" IsSeparator="True">
                            </telerik:RadMenuItem>
                            <%--Add by Prakash 09-09-2015 --%>
                            <telerik:RadMenuItem runat="server" Text="Mails" ToolTip="Click here to view mail names and descriptions." Visible="true" CssClass="level_menu">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="sep10" IsSeparator="True">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
            </tr>
        </table>

    </div>
    <div class="main" style="background-color: beige;">
        <div class="admin_cnt" style="background-color: beige;">
            <asp:UpdatePanel ID="upAdmin" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <script language="javascript" type="text/javascript">
                        function ConfirmMsg() {
                            var msg = "";
                            msg = 'Do you want to Save?';
                            var result = confirm(msg, "Check");
                            if (result) {
                                document.getElementById('Content_CnfResult').value = "true";
                                return true;
                            }
                            else {
                                document.getElementById('Content_CnfResult').value = "false";
                                return false;
                            }
                        }
                        function ConfirmUpdateMsg() {
                            var msg = "";
                            msg = 'Do you want to Update?';
                            var result = confirm(msg, "Check");

                            if (result) {
                                document.getElementById('Content_CnfResult').value = "true";
                                return true;
                            }
                            else {
                                document.getElementById('Content_CnfResult').value = "false";
                                return false;
                            }
                        }

                        function ConfirmDeleteMsg() {
                            var msg = "";
                            msg = 'Do you want to Delete?';
                            var result = confirm(msg, "Check");

                            if (result) {
                                document.getElementById('Content_CnfResult').value = "true";
                                return true;
                            }
                            else {
                                document.getElementById('Content_CnfResult').value = "false";
                                return false;
                            }

                        }
                    </script>

                    <script type="text/javascript">
                        function confirmCallbackFn(arg) {
                            if (arg) //the user clicked OK
                            {
                                __doPostBack("<%=HiddenButton.UniqueID %>", "");
                            }
                        }
                    </script>

                    <telerik:RadWindowManager runat="server" ID="RadWindowManager1"></telerik:RadWindowManager>

                    <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />

                    <asp:HiddenField ID="CnfResult" runat="server" />
                    <asp:GridView ID="gvTest" runat="server" Visible="false"></asp:GridView>

                    <asp:MultiView ID="mvAdmin" runat="server" ActiveViewIndex="0">
                        <asp:View ID="vwCompanyName" runat="server">
                            <table cellpadding="7px">
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 200px;">
                                            <asp:Label ID="lblProjectHead" runat="server" Text="About- License Information" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCompanyName" runat="Server" Width="120px" Text="Licensed for" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="CompanyName" runat="Server" MaxLength="50" Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium" ToolTip="This is the name of the organisation for whom the software is installed."></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUserContact" runat="Server" Text="Contact Person" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="UserContact" runat="Server" MaxLength="80" ToolTip="The name of the main contact person[Super User] in the Licensee Organisation." Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbldefaultcontact" runat="Server" Text="Sign-In ID" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtdefaultconta" runat="Server" MaxLength="8" ToolTip="Set the Sign-In ID for the super user whose name is mentioned above.ML8" Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblContactMobile" runat="Server" Text="Mobile No" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ContactMobile" runat="Server" MaxLength="13" ToolTip="The contact number of the organisation" Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblFromEmailId" runat="Server" Text="EmailID" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="FromEmailId" runat="Server" MaxLength="80" Width="310px" ToolTip="All mails sent from the Software have this ID as the FROM ID. Do not change it as that may affect the mails." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRemarks" runat="Server" Text="URL" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td rowspan="2">
                                                    <asp:TextBox ID="Remarks" runat="Server" MaxLength="240" ToolTip="This is the URL for accessing the Software" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium" Width="310px" Height="20px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProductName" runat="Server" Text="Product" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ProductName" runat="Server" MaxLength="40" ToolTip="This is the name of the Software as desired by the Licensee.  A default name is provided." Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProductByLine" runat="Server" Text="By-Line" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ProductByLine" runat="Server" MaxLength="120" ToolTip="A short text highlighting the benefit of the software." Width="310px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblVersionNumber" runat="Server" Text="Version No." ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="VersionNumber" runat="Server" MaxLength="8" Width="310px" ToolTip="Latest release number." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblLastEnqNo" runat="Server" Text="Last Enquiry No" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLastEnqNo" runat="Server" MaxLength="8" Width="310px" ToolTip="Shows the number of the most recent Sales Enquiry registered. This field is useful if the user wishes to have the automatic no. allotments." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblLastQuoteNo" runat="Server" Text="Last Quote No" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLastQuoteNo" runat="Server" MaxLength="8" Width="310px" ToolTip="Shows the number of the most recent Sales Quotation submitted. This field is useful if the user wishes to have the automatic no. allotments." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblLastOrderNo" runat="Server" Text="Last Order No" ForeColor=" Black " Font-Names="Verdana" Font-Size="small" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLastOrderNo" runat="Server" MaxLength="8" Width="310px" ToolTip="Shows the number of the most recent Order booked. This field is useful if the user wishes to have the automatic no. allotments." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center">

                                                    <asp:Button ID="btnAdminSave" runat="Server" Width="100px" Text="Save"
                                                        ToolTip="Click here to update the details" ForeColor="White"
                                                        CssClass="btnAdminSave" Font-Names=" Verdana" Font-Size="Medium"
                                                        OnClick="btnAdminSave_Click" OnClientClick="return ConfirmMsg()" />

                                                    <asp:Button ID="btnAdminUpdate" runat="Server" Width="100px" Text="Update"
                                                        ToolTip="Click here to update the details" ForeColor="White"
                                                        Font-Names=" Verdana" Font-Size="Medium" CssClass="btnAdminSave"
                                                        OnClick="btnAdminUpdate_Click" OnClientClick="return ConfirmUpdateMsg()" />

                                                    <asp:Button ID="btnAdminExit" runat="Server" Text="Exit"
                                                        ToolTip="Click here to return to Home Page" OnClick="btnAdminExit_Click" CssClass="btnAdminExit" Width="74px" Height="26px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="Label33" runat="Server" Width="400px" Text="This is the About Screen giving the name of the organisation for whom the software has been installed." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label50" runat="Server" Width="400px" Text="The information is only for viewing and cannot be modified here." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label51" runat="Server" Width="400px" Text="More information about the organisation can be updated in the customer profile where a record is already present." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label54" runat="Server" Width="400px" Text="The Mail ID is used for sending mails from the system." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label55" runat="Server" Width="400px" Text="The name of the contact person is also mentioned in the Contacts tab of the profile." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label56" runat="Server" Width="400px" Text="The Last Enquiry Number field gets incremented every time the #Enquiry reference tag is used for registering a new enquiry." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label57" runat="Server" Width="400px" Text="The URL refers to the link to be used to access the software." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label58" runat="Server" Width="400px" Text="The Mobile App customised to the licensee, uses the Organisation name when accepting mobile based work assignments. The Mobile App uses the #Reference tag #MobileApp by default." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label59" runat="Server" Width="400px" Text="While it is not recommended, the licensee can use their choice of name for the software." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label60" runat="Server" Width="400px" Text="The version number indicates the version which is installed. When lodging any support ticket be sure to mention the version number." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label61" runat="Server" Width="400px" Text="A default user in level 1 is created for the ID typed in the Sign-In Id field." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                        <asp:Label ID="Label62" runat="Server" Width="400px" Text="This screen is visible only to Level 1 or Level 2 users and can be edited only the Level 1 Super User, using a special ID and PIN." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>

                                    </td>
                                </tr>



                            </table>

                        </asp:View>

                        <asp:View ID="vwCampaign" runat="server">
                            <table>
                                <tr>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label21" runat="server" Text="Sales Campaign Master" Font-Names="verdana" Font-Bold="true"
                                            ForeColor="DarkBlue" CssClass="style3"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCampaignvalue" runat="server" Text="Campaign:" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label40" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddCampaignvalue" runat="server" Width="200px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Brief name of the campaign. Max 80.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label74" runat="server" Text="PreWorkStartsOn" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label75" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="rdtpcamstartson" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Enter the date from which preparation for this campaign starts">
                                                        <Calendar ID="Calendar5" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput5" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label22" runat="server" Text="From" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label24" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>

                                                <td>
                                                    <telerik:RadDatePicker ID="rdtpcamstartdate" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="When does the campaign start">
                                                        <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput1" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label26" runat="server" Text="Until" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label28" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="rdtpcamenddate" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="When does the campaign end">
                                                        <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput2" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label76" runat="server" Text="PostWorkEndsOn" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label77" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>

                                                <td>
                                                    <telerik:RadDatePicker ID="rdtpcamendson" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Enter the date upto which you expect enquires w.r.t campaign to come in.">
                                                        <Calendar ID="Calendar6" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput6" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label78" runat="server" Text="Responsibility:" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCamResponsibility" runat="server" Width="155px" CssClass="style3" ToolTip="Who is the person responsible for the campaign">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label30" runat="server" Width="150px" Text="More Info:" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCampaigninfo" runat="server" Width="350px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="240" ToolTip="Any descriptive information. Max 240.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label32" runat="server" Text="CampaignStatus:" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCampaignStatus" runat="server" Width="155px" CssClass="style3" ToolTip="Is it Open or Close or a Routine one">
                                                        <asp:ListItem Value="Open" Text="Open"></asp:ListItem>
                                                        <asp:ListItem Value="Close" Text="Close"></asp:ListItem>

                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label34" runat="server" Text="Send an Email?" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlsendanemail" runat="server" Width="155px" CssClass="style3" ToolTip="Send Email to leads Yes\No?">
                                                        <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                        <asp:ListItem Value="0" Text="No"></asp:ListItem>

                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label36" runat="server" Text="Email Subject Line:" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtemailsubjectline" runat="server" Width="350px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter the email subject. Max 80.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label38" runat="server" Text="Email Body" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtemailbody" runat="server" Width="350px" Height="200px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="2400" ToolTip="Enter the email body. Max 2400." Font-Names="Calibri">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:Button ID="btnCamSave" runat="server" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClientClick="return ConfirmMsg()" ToolTip="Click to save the details entered." OnClick="btnCamSave_Click" />
                                                    <asp:Button ID="btnCamUpdate" runat="server" Text="Update" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        ToolTip="Click to save the details entered." OnClick="btnCamUpdate_Click" OnClientClick="return ConfirmUpdateMsg()" />
                                                    <asp:Button ID="btnCamClear" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                        ToolTip="Click to clear the details entered." OnClick="btnCamClear_Click" />
                                                    <asp:Button ID="btnCamClose" runat="server" Text="Close" CssClass="btnAdminExit" Width="74px" Height="26px"
                                                        ToolTip="Click here to close this screen and return to previous menu." OnClick="btnCamClose_Click" />
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                    <td valign="top">
                                        <asp:GridView ID="gvMCampaign" runat="server" AutoGenerateColumns="false" AllowPaging="true" PageSize="10" Font-Names="Verdana" Width="160px"
                                            Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="gvMCampaign_PageIndexChanging" DataKeyNames="RSN" OnRowCommand="gvMCampaign_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="V/E" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Sel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                            CommandName="Select" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Campaign" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Small"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcamvalue" Width="130px" runat="server" Text='<%# Eval("Campaignvalue") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Small"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label35" Width="160px" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <asp:Label ID="Label37" runat="Server" Width="280px" Text="In order to promote a product or a service, one can conduct a sales campaign for a predetermined duration. Each campaign does have a budget and whether the money was worth it can be studied by defining the campaign here. Ofcourse if a prospect is registered, the campaign due to which the lead has come about, must also be recorded.
										One can set up standard Email messages to be sent to the Prospect, when the Prospect’s profile is linked to the Campaign."
                                            ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>

                        <asp:View ID="vwReference" runat="server">
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="text-align: center" colspan="2">
                                                    <asp:Label ID="lblReferencehead" runat="server" Text="Reference Codes and Description"
                                                        ForeColor="DarkGreen" CssClass="style3" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label27" runat="server" Text="Group :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRefGroup" runat="server" Width="310px" ToolTip="Use Business for sales related activities & references. Use Service for service related activities & references. Use General for any other."
                                                        ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                                        <asp:ListItem Text="General" Value="General"></asp:ListItem>
                                                        <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                                        <asp:ListItem Text="Projects" Value="Projects"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReference" runat="server" Text="#Reference :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label84" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtReference" runat="server" Width="200px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="30" ToolTip="A Reference code (MAX 10) char for the work being assigned. Always start a reference code with a #.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label31" runat="server" Text="Remarks :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRefRemakrs" runat="server" Width="350px" Height="40px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="40" ToolTip="Whatever you write here will appear as a prompt message. Max 40." Font-Names="Verdana">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label23" runat="server" Text="HelpText :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRefHelp" runat="server" Width="350px" Height="80px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="240" ToolTip="Whatever you write here will appear as a help message. Max 240." Font-Names="Verdana">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label29" runat="server" Text="FinalStatusFlag :" CssClass="style3" Width="150px" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlFinalStatusFlag" runat="server" Width="310px" ToolTip="If set to Yes the activity where this reference is used, will be automatically marked as completed." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:Button ID="btnRefSave" runat="server" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnRefSave_Click" OnClientClick="javascript:return ConfirmMsg()" ToolTip="Click to save the details entered." />
                                                    <asp:Button ID="btnRefUpdate" runat="server" Text="Update" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnRefUpdate_Click" OnClientClick="return ConfirmUpdateMsg()" ToolTip="Click to Update the details entered." />
                                                    <asp:Button ID="btnRefDelete" runat="server" Text="Delete" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnRefDelete_Click" OnClientClick="return ConfirmDeleteMsg()" ToolTip="Click to Delete the selected details." />
                                                    <asp:Button ID="btnRefClear" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                        OnClick="btnRefClear_Click" ToolTip="Click to clear the details entered." />
                                                    <asp:Button ID="btnRefClose" runat="server" Text="Close" CssClass="btnAdminExit" Width="74px" Height="26px"
                                                        OnClick="btnRefClose_Click" ToolTip="Click here to return back." />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Search :</td>
                                                <td colspan="1" align="left">
                                                    <%--onkeyup="__doPostBack(this.name,'OnKeyUp');"--%>
                                                    <asp:TextBox ID="SearchBox" onkeyup="__doPostBack(this.name,'OnKeyUp');" runat="server" ClientIDMode="AutoID"></asp:TextBox>
                                                </td>
                                                <td align="center">
                                                    <asp:ImageButton ID="btnimgmr1exporttoexcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="ExportToExcel" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:UpdatePanel ID="upnltest" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                        <ContentTemplate>
                                                            <div>
                                                                <asp:GridView ID="gvMReference" runat="server" AutoGenerateColumns="false" AllowPaging="true" ClientIDMode="Static" EmptyDataText="No Records"
                                                                    PageSize="10" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" OnRowCommand="gvMReference_RowCommand" Width="500px"
                                                                    DataKeyNames="RSN" OnPageIndexChanging="gvMReference_PageIndexChanging" Font-Bold="false" AllowSorting="true" OnSorting="gvMReference_Sorting" OnDataBound="gvMReference_DataBound">
                                                                    <Columns>

                                                                        <asp:TemplateField HeaderText="V/E" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Sel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                    CommandName="Select" />
                                                                            </ItemTemplate>

                                                                        </asp:TemplateField>
                                                                        <asp:BoundField HeaderText="Group" DataField="TrackonGroup" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="TrackonGroup" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center"
                                                                            ItemStyle-Width="80px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                                        <%--<asp:BoundField HeaderText="Reference" DataField="TrackonDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                    HeaderStyle-ForeColor="White" SortExpression="TrackonDesc" ItemStyle-Font-Names="Verdana"
                                                                    ItemStyle-Width="90px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />--%>
                                                                        <asp:BoundField HeaderText="Reference" DataField="TrackonDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="TrackonDesc" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="90px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                                        <asp:BoundField HeaderText="Remarks" DataField="TrackonRemarks" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="TrackonRemarks" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                                        <asp:BoundField HeaderText="Help Text" DataField="Helptext" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Helptext" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                                        <asp:BoundField HeaderText="Flag" DataField="StatusFlag" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="StatusFlag" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center"
                                                                            ItemStyle-Width="50px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    </div>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="Label44" runat="Server" Text="You deal with customers for various purposes." ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" Width="304px"></asp:Label><br />
                                        <asp:Label ID="Label45" runat="Server" Text="It could be for new business or for attending a repair call or it could be Tax Filing Service a or it could be about a product you sell." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                        <asp:Label ID="Label46" runat="Server" Text="How to distinguish each interaction? Simple. Define each purpose as a #Reference Tag here." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                        <asp:Label ID="Label47" runat="Server" Text="The #Reference tag is then used when an activity is assigned to a user." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                        <asp:Label ID="Label48" runat="Server" Text="If you have a standard set of Services that you provide to a customer, you can define them in the Customer Profile." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                        <asp:Label ID="Label52" runat="Server" Text="The #Reference Codes  #Enquiry, #Quote, #Order, #MobileApp cannot be deleted." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                        <asp:Label ID="Label53" runat="Server" Text="If a #Reference Code is used in some activity, it cannot be deleted." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label>

                                    </td>
                                </tr>
                            </table>
                        </asp:View>

                        <asp:View ID="vwKeyLookUP" runat="server">
                            <table>
                                <tr>
                                    <td colspan="2" style="text-align: center;">
                                        <asp:Label ID="Label15" runat="Server" Text="Additional Particulars Key LookUp" ForeColor="DarkOliveGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblmoreinfolkupgroup" runat="Server" Text="Group" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlmoreinfolkupgroup" runat="server" Width="310px" ToolTip="Choose BIZ - If this key belongs to Sales; MTCE - For keys referring to customer service and repairs, OTHR-For other miscellaneous keys."
                                            ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"
                                            AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlmoreinfolkupgroup_SelectedIndexChanged">
                                            <asp:ListItem Text="BIZ" Value="BIZ"></asp:ListItem>
                                            <asp:ListItem Text="MTCE" Value="MTCE"></asp:ListItem>
                                            <asp:ListItem Text="OTHR" Value="OTHR"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMoreInfoSequence" runat="Server" Text="Sequence" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMoreInfoSequence" runat="Server" MaxLength="20" Width="310px" ToolTip="Enter a Unique Sequence no that will be tagged in the Additional Particulars Grid." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMoreInfoKey" runat="Server" Text="Key" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMoreInfoKey" runat="Server" MaxLength="20" Width="310px" ToolTip="Enter a Unique key Word that will be tagged in the Additional Particulars Grid. This keyword is used in various reports." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:Label ID="lblMoreInfoDesc" runat="Server" Text="Description" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                        <br />
                                    </td>
                                    <td rowspan="2">
                                        <asp:TextBox ID="txtMoreInfoDesc" runat="Server" MaxLength="240" ToolTip="Enter text describing the key. Ex: Group is BIZ, QTNO is the KEY and 'Quotation Number' is the description." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbldropdownvalues" runat="Server" Text="Dropdown Values" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                        <br />
                                    </td>
                                    <td rowspan="2">
                                        <asp:TextBox ID="txtdropdownvalues" runat="Server" MaxLength="240" ToolTip="Enter dropdown values seperated by comma." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblhelptext" runat="Server" Text="Help Text" ForeColor="Black" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                        <br />
                                    </td>
                                    <td rowspan="2">
                                        <asp:TextBox ID="txthelptext" runat="Server" MaxLength="240" ToolTip="Enter help text details." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center">
                                        <asp:Button ID="btnSave" runat="Server" Width="100px" Text="Save" ToolTip="Click here to save the details" CssClass="btnAdminSave" OnClick="btnSave_Click" OnClientClick="return ConfirmMsg()" />
                                        <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Click here to save the details" CssClass="btnAdminSave" OnClick="btnUpdate_Click" OnClientClick="return ConfirmUpdateMsg()" />
                                        <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to clear entered details" CssClass="btnAdminClear" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" runat="Server" Width="100px" Text="Exit" ToolTip="Click here to exit" CssClass="btnAdminExit" OnClick="btnReturn_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center">
                                        <asp:GridView ID="gvmoreinfoLkUp" runat="server" AllowPaging="true" PageSize="20"
                                            Font-Names="Verdana" Font-Size="Smaller" Font-Bold="false" ForeColor="DarkBlue " OnRowCommand="gvmoreinfoLkUp_RowCommand"
                                            OnPageIndexChanging="gvmoreinfoLkUp_PageIndexChanging " AutoGenerateColumns="false" DataKeyNames="RSN">
                                            <Columns>
                                                <asp:TemplateField HeaderText=" V/E " HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor=" White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" AlternateText=" Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CommandName="Select" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Group" DataField="MoreInfoGroup" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" />
                                                <asp:BoundField HeaderText="Key" DataField="MoreInfoKey" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" />
                                                <asp:BoundField HeaderText="Sequence" DataField="MoreInfosequence" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-HorizontalAlign="Left"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" />
                                                <asp:BoundField HeaderText="Description" DataField="MoreInfoDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-HorizontalAlign="Left"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="240px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" />
                                                <asp:BoundField HeaderText="DValues" DataField="Dvalues" ItemStyle-Width="240px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-HorizontalAlign="Left"
                                                    HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-Wrap="true" />

                                                <%-- <asp:BoundField HeaderText="Dropdown Values" DataField="DValues" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-HorizontalAlign="Left"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="150px"  ItemStyle-Wrap ="true"  HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" />    --%>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="vwBroadcastMessage" runat="server">
                            <table cellpadding="10px" style="width: 870px;">
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 190px;">
                                            <asp:Label ID="Label70" runat="server" Text="Scrolling Banner Message" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="width: 870px;">
                                    <td style="width: 570px;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label71" runat="Server" Text="Enter a new message" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label72" runat="server" Font-Names="verdana" Font-Size="XX-Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td rowspan="2">
                                                    <asp:TextBox ID="Broadcastmessage" runat="Server" MaxLength="240" ToolTip="Whatever you type here will appear as a scrolling message in the Sign-In screen.ML240." BackColor="Beige" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Width="340px" Height="70px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td align="center">
                                                    <asp:Button ID="btnBcmSave" runat="Server" Text="Save" ToolTip="Click here to save the details" Font-Size="Small"
                                                        OnClick="btnBcmSave_Click" OnClientClick="return ConfirmMsg()" CssClass="btnAdminSave" Width="74px" Height="26px" />

                                                    <asp:Button ID="Button1" runat="Server" Text="Clear" ToolTip=" Click here to clear entered details" Font-Size="Small"
                                                        OnClick="btnBcmClear_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                    <asp:Button ID="btnBcmExit" runat="Server" Text="Exit" Font-Size="Small"
                                                        ToolTip="Click here to exit" OnClick="btnBcmExit_Click" CssClass="btnAdminExit" Width="74px" Height="26px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="center">
                                                    <br />
                                                    <asp:Label ID="Label19" runat="Server" Text="The latest message will scroll in the Sign-In screen." ForeColor="Gray" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:GridView ID="gvbroadcastmsg" runat="server" AllowPagin="true" PageSize="10"
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="Blue" OnRowCommand="gvbroadcastmsg_RowCommand " ToolTip="Latest message will scroll."
                                                        OnPageIndexChanging="gvbroadcastmsg_PageIndexChanging " AutoGenerateColumns="false" DataKeyNames="RSN" AllowPaging="True">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Scrolling Message[Latest on top]" DataField="Broadcastmessage" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="600px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />
                                                            <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="240px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                    <td valign="top" align="left" style="width: 300px;">
                                        <asp:Label ID="Label73" Font-Bold="false" runat="Server" Text="Have a happy news to share with all?Type the message here and it will scroll on the Sign-In Screen of the users.  The message will remain until replaced by a new message." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                    </td>

                                </tr>

                            </table>
                            <br />

                        </asp:View>

                        <asp:View ID="vwInformall" runat="server">
                            <table cellpadding="10px">
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 190px;">
                                            <asp:Label ID="Label1" runat="server" Text="Inform all users via EMail" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblInformAllMessage" runat="Server" Text="Broadcast Message" ForeColor="Black" Font-Names="Verdana" Font-Size="small"></asp:Label>
                                                </td>
                                                <td rowspan="2">
                                                    <asp:TextBox ID="InformAllMessage" runat="Server" MaxLength="240" ToolTip="To Broadcast a message to all users.ML240." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" TextMode="Multiline" BackColor="Beige" Width="400px" Height="70px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td align="center">
                                                    <asp:Button ID="btnIASave" runat="Server" Text="Save"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnIASave_Click" OnClientClick="return ConfirmMsg()" />

                                                    <asp:Button ID="btnIAUpdate" runat="Server" Text="Update"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        OnClientClick="return ConfirmUpdateMsg()" OnClick="btnIAUpdate_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                    <asp:Button ID="btnIAClear" runat="Server" Text="Clear"
                                                        ToolTip=" Click here to clear entered details"
                                                        OnClick="btnIAClear_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                    <asp:Button ID="btnIAExit" runat="Server" Text="Exit"
                                                        ToolTip="Click here to exit" ForeColor="White" OnClick="btnIAExit_Click" CssClass="btnAdminExit" Width="74px" Height="26px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <br />
                                                    <br />
                                                    <asp:GridView ID="gvinformall" runat="server" AllowPagin="true" Width="500px"
                                                        Font-Names="Verdana" Font-Size=" Small" ForeColor="Blue " OnRowCommand="gvinformall_RowCommand "
                                                        OnPageIndexChanging="gvinformall_PageIndexChanging " AutoGenerateColumns="false" DataKeyNames="RSN" AllowPaging="True">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Message" DataField="InformAllMessage" ReadOnly="true" HeaderStyle-BackColor="Blue" ItemStyle-Font-Bold="false"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="400px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />
                                                            <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="Blue" ItemStyle-Font-Bold="false" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="240px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="Label41" runat="Server" Width="247px" Text="How to broadcast an important message to all active users of the software. Write it here and press Save. All active users will be informed via EMAIL.   Example: 'New version of Software launched'." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>
                                    </td>

                                </tr>

                            </table>
                            <br />


                        </asp:View>

                        <asp:View ID="vwHoliday" runat="server">

                            <table cellpadding="10px">
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 190px;">
                                            <asp:Label ID="Label20" runat="server" Text="Holiday Settings" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label80" runat="server" Text="Holiday Date" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label82" runat="server" Text="*" ForeColor="Red" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpHdate" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the holiday date. This will appear in the Appointments calender.">
                                                        <Calendar ID="Calendar3" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput3" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblhdescritption" runat="Server" Text="Description" ForeColor="Black" Font-Names="Verdana" Font-Size="small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txthdescription" runat="Server" MaxLength="240" ToolTip="Enter a description.ML240." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium" TextMode="Multiline" BackColor="Beige" Width="400px" Height="70px"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>

                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnHSave" runat="Server" Text="Save"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnHSave_Click" OnClientClick="return ConfirmMsg()" />

                                                    <asp:Button ID="btnHUpdate" runat="Server" Text="Update"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        OnClientClick="return ConfirmUpdateMsg()" OnClick="btnHUpdate_Click"
                                                        CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                    <asp:Button ID="btnHClear" runat="Server" Text="Clear"
                                                        ToolTip=" Click here to clear entered details"
                                                        OnClick="btnHClear_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                    <asp:Button ID="btnHExit" runat="Server" Text="Exit"
                                                        ToolTip="Click here to exit" ForeColor="White" OnClick="btnHExit_Click"
                                                        CssClass="btnAdminExit" Width="74px" Height="26px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <br />
                                                    <br />
                                                    <asp:GridView ID="gvHoliday" runat="server" AllowPagin="true" Width="500px"
                                                        Font-Names="Verdana" Font-Size=" Small" ForeColor="Blue " OnRowCommand="gvHoliday_RowCommand"
                                                        OnPageIndexChanging="gvHoliday_PageIndexChanging" AutoGenerateColumns="false" DataKeyNames="RSN" AllowPaging="True">
                                                        <Columns>

                                                            <asp:TemplateField HeaderText="V/E" HeaderStyle-BackColor="Blue" HeaderStyle-ForeColor="White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Sel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                        CommandName="Select" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="Blue" ItemStyle-Font-Bold="false" DataFormatString="{0:dd-MMM-yyyy}"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="240px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />
                                                            <asp:BoundField HeaderText="Description" DataField="Description" ReadOnly="true" HeaderStyle-BackColor="Blue" ItemStyle-Font-Bold="false"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="400px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" ItemStyle-ForeColor="Black" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="Label81" runat="Server" Width="247px" Text="" ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="False"></asp:Label>
                                    </td>

                                </tr>

                            </table>


                        </asp:View>



                        <asp:View ID="vwLoginAudit" runat="server">
                            <table>
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 130px;">
                                            <asp:Label ID="Label10" runat="server" Text="Audit Trail" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>

                                    <td>

                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvLoginAudit" runat="server" AllowPagin="true" PageSize="20"
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="Blue " OnRowCommand="gvLoginAudit_RowCommand "
                                                        OnPageIndexChanging="gvLoginAudit_PageIndexChanging "
                                                        AutoGenerateColumns="false" DataKeyNames="RSN" AllowPaging="True">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText=" V/E " HeaderStyle-BackColor="Blue" HeaderStyle-ForeColor=" White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgEdit" runat="server" AlternateText="View" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CommandName="View" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="Blue" ForeColor="White" />
                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Staff" DataField="StaffID" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="10px" ItemStyle-Font-Bold="false" ItemStyle-ForeColor="Black"
                                                                HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                                <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                                <ItemStyle Font-Names="Verdana" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Action" DataField="Action" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="12px" ItemStyle-Font-Bold="false" ItemStyle-ForeColor="Black"
                                                                HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                                <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                                <ItemStyle Font-Names="Verdana" Width="100px" />
                                                            </asp:BoundField>

                                                            <asp:TemplateField HeaderText="Date" HeaderStyle-BackColor="Blue" HeaderStyle-ForeColor=" White" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label43" runat="server" Width="200px" Text='<%# Eval("Date") %>' Font-Names="Verdana" ForeColor="Black" Font-Bold="false"></asp:Label>
                                                                </ItemTemplate>

                                                            </asp:TemplateField>

                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>



                                    <td valign="top">
                                        <asp:Label ID="Label42" runat="Server" Width="400px" Text="Displays the IDs of those who signed in to the system. Also has the date stamp. Helps to monitor the usage for proper capacity management and to determine the usefulness of the software." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadWindow ID="rwLoginAudit" Width="250" Height="300" VisibleOnPageLoad="false"
                                            runat="server">
                                            <ContentTemplate>
                                                <div>

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="Server" Text="Staff:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblstaff" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="Server" Text="Action:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAction" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="Server" Text="Date:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDate" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label5" runat="Server" Text="Browser:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblBrowser" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label7" runat="Server" Text="Device:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDevice" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label9" runat="Server" Text="IPAddress:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblipaddress" runat="Server" Text="" ForeColor="Green" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </telerik:RadWindow>
                                    </td>

                                </tr>
                            </table>
                        </asp:View>

                        <asp:View ID="vwLeadCategory" runat="server">
                            <table>
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 150px;">
                                            <asp:Label ID="Label16" runat="server" Text="Lead Category" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="width: 403px">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblcleadcategorycode" runat="Server" Text="Code" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label86" runat="server" Font-Names="verdana" Font-Size="X-Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLeadCategoryCode" runat="Server" MaxLength="2" Width="310px" ToolTip="Enter the category code. ML2" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblcleadcategory" runat="Server" Text="Category" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label87" runat="server" Font-Names="verdana" Font-Size="X-Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtleadcategory" runat="Server" MaxLength="20" Width="310px" ToolTip="Enter the category name. ML20." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style2"></td>
                                                <td align="center">
                                                    <asp:Button ID="btnLCSave" runat="Server" Text="Save"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClientClick="return ConfirmMsg()" OnClick="btnLCSave_Click" />

                                                    <asp:Button ID="btnLCUpdate" runat="Server" Text="Update"
                                                        ToolTip="Click here to save the details" ForeColor="White"
                                                        OnClientClick="return ConfirmUpdateMsg()" CssClass="btnAdminClear" Height="26px" Width="74px" OnClick="btnLCUpdate_Click" />

                                                    <asp:Button ID="btnLCClear" runat="Server" Text="Clear"
                                                        ToolTip=" Click here to clear entered details"
                                                        CssClass="btnAdminClear" Height="26px" Width="74px" OnClick="btnLCClear_Click" />

                                                    <asp:Button ID="btnLCExit" runat="Server" Text="Exit"
                                                        ToolTip="Click here to exit" ForeColor="White" CssClass="btnAdminExit" Width="74px" Height="26px" OnClick="btnLCExit_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <br />
                                                    <br />
                                                    <asp:GridView ID="gvLeadCategory" runat="server" AllowPagin="true"
                                                        Font-Names="Calibri" Font-Size="Small"
                                                        AutoGenerateColumns="False" Width="300px"
                                                        DataKeyNames="RSN" AllowPaging="True" OnRowCommand="gvLeadCategory_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText=" V/E " HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor=" White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CommandName="Select" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Code" DataField="CatCode" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="50px" ItemStyle-Font-Bold="false"
                                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center" />
                                                                <ItemStyle Font-Names="Verdana" ForeColor="#5B74A8" Width="50px" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false"
                                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center" />
                                                                <ItemStyle Font-Names="Verdana" ForeColor="#5B74A8" HorizontalAlign="Center" Width="200px" />
                                                            </asp:BoundField>

                                                            <asp:BoundField HeaderText="Created By" DataField="CreatedBy" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-Font-Bold="false"
                                                                HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana" Visible="false">
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Left" />
                                                                <ItemStyle Font-Names="Verdana" ForeColor="#5B74A8" Width="100px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Created On" DataField="CreatedOn" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false" ItemStyle-HorizontalAlign="Center"
                                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana" Visible="false">
                                                                <HeaderStyle BackColor="#5B74A8" ForeColor="White" HorizontalAlign="Center" />
                                                                <ItemStyle Font-Names="Verdana" ForeColor="#5B74A8" Width="100px" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="Label39" runat="Server" Width="450px" Text="You can define different categories of customers and prospects here and assign an appropriate category to a customer when the profile is created.  Example:  If the Customer is say Railways,  assign to the category – Government.  If the Customer is say,  A University, assign to category – Education and so on.  You can create as many categories as needed.   Benefits:  It will be easy to assign proper expertise to manage all customers falling in one category. It will be possible to determine business gained / lost / potential from each category. It will be possible to focus your sales campaigns as per the needs of a category." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label>
                                    </td>
                                </tr>

                            </table>

                        </asp:View>

                        <asp:View ID="vwUserManagement" runat="server">
                            <table>
                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 130px;">
                                            <asp:Label ID="Label14" runat="server" Text="User Management" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <asp:ImageButton ID="imgbtnExportExcel" runat="server" ToolTip="Click here to export employee user list in excel." ImageUrl="~/Images/exceliconsmall2.png" OnClick="imgbtnExportExcel_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="left">
                                        <table style="width: 100%; float: left; text-align: left;">

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="ID :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmsid" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffID" runat="server" Width="250px" Font-Size="Medium" CssClass="style3" Enabled="false"
                                                        TextMode="SingleLine" MaxLength="4" ToolTip="Enter unique ID No. Max 4 Numeric.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffName" runat="server" Text="Name :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmsn" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffName" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="40" ToolTip="User Name. Max 40.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffEmail" runat="server" Text="Email :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmse" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffEmail" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="160" ToolTip="Enter the correct Email id of the user to send all communications from the system.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffPhone" runat="server" Text="Phone :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmsp" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffPhone" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="13" ToolTip="Enter Contact Number  (Landline or Mobile)  of the user.ML13">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblJoiningdate" runat="server" Text="Joining date :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmjd" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpAssignOnDate" runat="server" Culture="English (United Kingdom)" ToolTip="Enter date when this user joined the organisation."
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" MinDate="01/01/1980">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Text="Birth date :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label25" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpBirthday" runat="server" Culture="English (United Kingdom)" ToolTip="Enter a valid birthday date as officially recorded for the user. This helps in sending birthday greetings on the right occasion."
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" MinDate="01/01/1950">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label83" runat="server" Text="Wedding date :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpWeddingday" runat="server" Culture="English (United Kingdom)" ToolTip="Enter a valid wedding anniversary date as officially recorded for the user.This helps in sending birthday greetings on the right occasion."
                                                        Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" MinDate="01/01/1950">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="style2" Font-Names="verdana">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                            Font-Names="verdana" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDesignation" runat="server" Text="Designation :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <%--<asp:Label ID="lblmdesig" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffDesignation" runat="server" Width="250px" Font-Size="Medium"
                                                        CssClass="style3" TextMode="SingleLine" MaxLength="160" ToolTip="Enter the designation of the user if present.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReportingHead" runat="server" Text="Reporting head :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmrh" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlReportinghead" runat="server" Width="155px" CssClass="style3"
                                                        ToolTip="Select the person to whom this user is reporting presently. Remember to update the same when the reporting hierarchy changes.">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUserName" runat="server" Text="UserID :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmun" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffUserName" runat="server" Width="250px" Font-Size="Medium"
                                                        CssClass="style3" TextMode="SingleLine" MaxLength="8" ToolTip="Unique ID for signingIn. Must be 4 to 8 characters.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="txtSPassword" runat="server" Text="Password :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <%--  <asp:Label ID="lblmp" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPassword" TextMode="Password" OnTextChanged="txtPassword_TextChanged" AutoPostBack="true" Enabled="false" runat="server" Width="250px" Font-Size="Medium" CssClass="style3" ToolTip="Blank out the field if you wish to RESET the password.The User ID is set as the password by default. The user is forced to change it on first sign-in." MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUserLevel" runat="server" Text="User Level :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUserLevel" runat="server" Width="155px" CssClass="style3"
                                                        ToolTip="Select the access level of the user according to his/her hierarchy and responsibilities">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="btnHelp" runat="server" Text="?" CssClass="Button" OnClick="btnHelp_Click"
                                                        ToolTip="Click here to see user level help" />

                                                    <telerik:RadWindow ID="rwHelp" Width="600" Height="190" VisibleOnPageLoad="false"
                                                        runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Modal="true" Title="User Level Help">
                                                        <ContentTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label63" runat="server" Text="1Manager  is the super user or administrator in Level 1." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label><br />
                                                                        <asp:Label ID="Label64" runat="server" Text="2CoOrdinator is the one who co-ordinates work across the departments and among the staff and is in Level 2." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label><br />
                                                                        <asp:Label ID="Label65" runat="server" Text="3Department Head (Level 3) ensures the activities within his department, are going on well." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label><br />
                                                                        <asp:Label ID="Label66" runat="server" Text="4User is the level (Level 4)  assigned to all other regular users of the system." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label><br />
                                                                        <asp:Label ID="Label67" runat="server" Text="Level 1 has access to all the functions of the software. Level 2 has access to most functions." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label><br />
                                                                        <asp:Label ID="Label68" runat="server" Text=" Level 3 and Level 4 have access to customer profiles and work assigned to them." ForeColor="Gray" Font-Size="X-Small" Font-Names="Verdana" Width="600px"></asp:Label>
                                                                    </td>
                                                                </tr>

                                                            </table>

                                                        </ContentTemplate>
                                                    </telerik:RadWindow>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUserStatus" runat="server" Text="User Status :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblmus" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUserStatus" runat="server" Width="155px" CssClass="style3"
                                                        ToolTip="Active means the user is currently active.  Inactive means the user can no longer access the system.">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbladdline1" runat="server" Text="Door No:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffAddLine1" runat="server" Width="250px" Font-Size="Medium"
                                                        CssClass="style3" TextMode="SingleLine" MaxLength="80" ToolTip="Enter the residential address of the user in this field and the fields below.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbladline2" runat="server" Text="Street/Area:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffaddline2" runat="server" Width="250px" Font-Size="Medium"
                                                        CssClass="style3" TextMode="SingleLine" MaxLength="160" ToolTip="Enter the residential address of the user (Ex: Location where the user resides)/City: Enter the name of the city/town where the user resides.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffCity" runat="server" Text="City :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffCity" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="160" ToolTip="Enter the name of the city/town where the user resides.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffState" runat="server" Text="State :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffState" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="160" ToolTip="Enter the State or Province of the residence.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStaffPostalCode" runat="server" Text="PIN /ZIP Code :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Width="140px"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtStaffPostalCode" runat="server" Width="250px" Font-Size="Medium"
                                                        CssClass="style3" TextMode="SingleLine" MaxLength="160" ToolTip="Enter the Postal code if present.">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label17" runat="server" Text="LS_UF :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Width="140px"></asp:Label>
                                                    <br />
                                                    <br />
                                                    <br />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddllsuf" runat="server" Width="155px" CssClass="style3"
                                                        ToolTip="Can the user convert a lead as a customer?">
                                                        <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label ID="Label18" runat="server" Text="LS_UF (Lead Status Update Flag:   Lead Status Update Flag. All users can update the Prospect (Lead) status within the Sales Cycle. However, the user is permitted to convert a Lead as a customer only if the LSUF Flag is set to Yes. Lead Statuses are Enquiry, Warm, Assigned to a SalesExec, Hot Lead, Cold Lead, Dropped.  This flag is not applicable to customers, vendors and others)." ForeColor="Gray" Font-Names="Verdana" Font-Size="XX-Small" Width="300px"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:Button ID="btnSSave" runat="server" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnSSave_Click" OnClientClick="javascript:return Validate()" ToolTip="By clicking here, you will be adding a new user record or updating an existing user record.  Make sure you have entered the details correctly. If you have cleared the password field, the user id will be set as the default password." />
                                                    <asp:Button ID="btnSUpdate" runat="server" Text="Update" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnSUpdate_Click" OnClientClick="ConfirmUpdateMsg()" ToolTip="Click to update the details selected." />
                                                    <asp:Button ID="btnSClear" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                        OnClick="btnSClear_Click" ToolTip="Click to clear the details entered." />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top" align="left">

                                        <asp:GridView ID="gvStaffDetails" runat="server" AutoGenerateColumns="false" Width="380px"
                                            OnRowCommand="gvStaffDetails_RowCommand" HeaderStyle-ForeColor="White" Font-Size="Small" Font-Bold="false" PageSize="10" AllowPaging="true" OnPageIndexChanging="gvStaffDetails_PageIndexChanging">
                                            <Columns>
                                                <%--<asp:CommandField ButtonType ="Image" SelectImageUrl ="~/Images/edit-notes.png" ShowSelectButton ="true"   /> --%>
                                                <asp:TemplateField HeaderStyle-BackColor="#5B74A8">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgEdit" runat="server"
                                                            CommandArgument="<%#((GridViewRow)Container).RowIndex%>"
                                                            ImageUrl="~/Images/Edit.png" CommandName="Select" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="StaffID" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="ID" ItemStyle-Font-Names="Verdana"
                                                    ItemStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue"
                                                    ItemStyle-Width="60px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" />
                                                <asp:BoundField DataField="StaffName" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Name" ItemStyle-Font-Names="Verdana" ItemStyle-Wrap="true"
                                                    ItemStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue"
                                                    ItemStyle-Width="80px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" />
                                                <asp:BoundField DataField="UserName" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="UserID" ItemStyle-Font-Names="Verdana"
                                                    ItemStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue"
                                                    ItemStyle-Width="85px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" />
                                                <asp:BoundField DataField="UserLevelName" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Level" ItemStyle-Font-Names="Verdana"
                                                    ItemStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue"
                                                    ItemStyle-Width="80px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" />
                                                <asp:BoundField DataField="LastAccess" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    HeaderText="Last Access" ItemStyle-Font-Names="Verdana" DataFormatString="{0:dd-MMM-yyyy HH:mm 'Hrs'}"
                                                    ItemStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue" ItemStyle-Wrap="true"
                                                    ItemStyle-Width="100px" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" />
                                            </Columns>
                                        </asp:GridView>



                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="vwUpload" runat="server">
                            <table>
                                <tr>
                                    <td>

                                        <table>
                                            <tr>
                                                <td style="text-align: center">
                                                    <asp:Label ID="Label11" runat="server" Text="Upload" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:FileUpload ID="FLuploadProspect" runat="server" Width="300px" ToolTip="Click here to choose the customer/prospect list excel file." />
                                                    <%-- <asp:AjaxFileUpload ID="FLuploadProspect" runat="server" />--%>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnUploadProspect" runat="server" Class="btn btn-info" Text="Upload" ToolTip="Click here to upload customer/prospect list into database." OnClick="btnUploadProspect_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>

                            </table>
                        </asp:View>

                        <asp:View ID="vwMails" runat="server">
                            <table width="800px">
                                <tr>
                                    <td colspan="2" style="text-align: center;">
                                        <asp:Label ID="Label3" runat="server" Text="Mails" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                    </td>
                                </tr>
                                <td colspan="2" style="text-align: left;">
                                    <asp:Label ID="Label49" runat="server" Text="The following mails are generated from the software. Press Send button to get a sample mail to your email id." ForeColor="Black" Font-Size="X-Small" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                </td>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvMails" runat="server" PageSize="15" Width="700px" OnPageIndexChanging="gvMails_PageIndexChanging"
                                            Font-Names="Verdana" Font-Size=" Small" ForeColor="Blue" OnRowCommand="gvMails_RowCommand"
                                            AutoGenerateColumns="false" DataKeyNames="RSN" AllowPaging="True">
                                            <Columns>
                                                <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="Blue" HeaderStyle-Width="200px"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="10px" ItemStyle-Font-Bold="false" ItemStyle-ForeColor="Black"
                                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                    <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                    <ItemStyle Font-Names="Verdana" Width="100px" />
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="Description" HeaderStyle-Width="500px" DataField="Description" SortExpression="Description" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="12px" ItemStyle-Font-Bold="false" ItemStyle-ForeColor="Black"
                                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                    <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                    <ItemStyle Font-Names="Verdana" Width="100px" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="" HeaderStyle-BackColor="Blue" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="10px" ItemStyle-Font-Bold="false" ItemStyle-ForeColor="Black"
                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="gvMailsSendBtn" ForeColor="Blue" CssClass="buttonClass" ToolTip="Click here to receive sample mail." Font-Names="Verdana" Font-Size="Small" Text="Send" runat="server" CommandName="Mails" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>

                        <asp:View ID="vwCheckList" runat="server">
                            <table>

                                <tr>
                                    <td colspan="2" style="text-align: justify">
                                        <div style="margin-left: 200px;">
                                            <asp:Label ID="lblCLhead" runat="server" Text="Check List"
                                                ForeColor="DarkGreen" CssClass="style3" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <table>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCLRefCode" runat="server" Text="Reference Code :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblCLRRefCode" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlCLRefCode" runat="server" Width="155px" CssClass="style3"
                                                        ToolTip="Select reference code to add the check list">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCLActSeq" runat="server" Text="Activity SeqNo :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblCLRActSeq" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCLActSeq" runat="server" Width="100px" Font-Size="Small" CssClass="style3"
                                                        TextMode="SingleLine" MaxLength="2" ToolTip="Helps to sequence the activities" onkeypress="return allowOnlyNumber(event);">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCLActivity" runat="server" Text="Activity :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblCLRActivity" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="Red" Text="*"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCLActivity" runat="server" Width="350px" Height="40px" Font-Size="Small" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="240" ToolTip="Enter the activity/task in sequence order" Font-Names="Verdana">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCLRemarks" runat="server" Text="Remarks :" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCLRemarks" runat="server" Width="350px" Height="80px" Font-Size="Small" CssClass="style3"
                                                        TextMode="MultiLine" MaxLength="520" ToolTip="Enter any narration." Font-Names="Verdana">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:Button ID="btnCLSave" runat="server" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnCLSave_Click" OnClientClick="javascript:return ConfirmMsg()" ToolTip="Click to save the details entered." />
                                                    <asp:Button ID="btnCLUpdate" runat="server" Text="Update" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                        OnClick="btnCLUpdate_Click" OnClientClick="return ConfirmUpdateMsg()" ToolTip="Click to Update the details entered." />
                                                    <asp:Button ID="btnCLClear" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                        OnClick="btnCLClear_Click" ToolTip="Click to clear the details entered." />
                                                    <asp:Button ID="btnCLClose" runat="server" Text="Close" CssClass="btnAdminExit" Width="74px" Height="26px"
                                                        OnClick="btnRefClose_Click" ToolTip="Click here to return back." />
                                                </td>
                                            </tr>


                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td valign="top">
                                        <asp:UpdatePanel ID="upnlCL" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                            <ContentTemplate>
                                                <div>
                                                    <asp:GridView ID="gvCheckList" runat="server" AutoGenerateColumns="false" AllowPaging="true" ClientIDMode="Static" EmptyDataText="No Records"
                                                        PageSize="10" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Width="500px"
                                                        DataKeyNames="CLRSN" Font-Bold="false" AllowSorting="false" OnRowCommand="gvCheckList_RowCommand" OnPageIndexChanging="gvCheckList_PageIndexChanging" OnSorting="gvCheckList_Sorting" OnDataBound="gvCheckList_DataBound">
                                                        <%--<asp:GridView ID="gvCheckList" runat="server" AutoGenerateColumns="false" AllowPaging="true" ClientIDMode="Static" EmptyDataText="No Records"--%>
                                                        <%--PageSize="10" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" OnRowCommand="gvMReference_RowCommand" Width="500px"--%>
                                                        <%--DataKeyNames="RSN" OnPageIndexChanging="gvMReference_PageIndexChanging" Font-Bold="false" AllowSorting="true" OnSorting="gvMReference_Sorting" OnDataBound="gvMReference_DataBound">--%>
                                                        <Columns>

                                                            <asp:TemplateField HeaderText=" " HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Sel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                        CommandName="Select" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>


                                                            <asp:BoundField HeaderText="Ref.Code" DataField="CLRefCode" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Helptext" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                            <asp:BoundField HeaderText="Seq.No" DataField="CLSeqNo" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="TrackonGroup" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center"
                                                                ItemStyle-Width="80px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                            <asp:BoundField HeaderText="Activity" DataField="CLActivity" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="TrackonDesc" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                ItemStyle-Width="300px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                            <asp:BoundField HeaderText="Remarks" DataField="CLRemarks" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="500px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="TrackonRemarks" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>


                    </asp:MultiView>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnAdminUpdate" />
                    <asp:PostBackTrigger ControlID="btnAdminExit" />
                    <asp:PostBackTrigger ControlID="btnBcmSave" />
                    <asp:PostBackTrigger ControlID="btnIASave" />
                    <asp:PostBackTrigger ControlID="btnIAUpdate" />
                    <asp:PostBackTrigger ControlID="btnSSave" />
                    <asp:PostBackTrigger ControlID="btnSUpdate" />
                    <asp:PostBackTrigger ControlID="btnUploadProspect" />
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnLCSave" />
                    <asp:PostBackTrigger ControlID="btnLCUpdate" />
                    <asp:PostBackTrigger ControlID="btnCamSave" />
                    <asp:PostBackTrigger ControlID="btnCamUpdate" />
                    <asp:PostBackTrigger ControlID="btnCamClear" />
                    <asp:PostBackTrigger ControlID="btnCamClose" />
                    <asp:AsyncPostBackTrigger ControlID="gvMCampaign" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="gvMCampaign" EventName="PageIndexChanging" />
                    <asp:PostBackTrigger ControlID="btnRefSave" />
                    <asp:PostBackTrigger ControlID="btnRefUpdate" />
                    <asp:PostBackTrigger ControlID="btnRefDelete" />
                    <asp:AsyncPostBackTrigger ControlID="btnRefClear" EventName="Click" />
                    <asp:PostBackTrigger ControlID="btnRefClose" />
                    <asp:PostBackTrigger ControlID="gvMReference" />
                    <asp:PostBackTrigger ControlID="gvMails" />
                    <asp:PostBackTrigger ControlID="HiddenButton" />
                    <asp:PostBackTrigger ControlID="btnimgmr1exporttoexcel" />
                    <asp:AsyncPostBackTrigger ControlID="SearchBox" />
                    <asp:PostBackTrigger ControlID="btnHSave" />
                    <asp:PostBackTrigger ControlID="btnHUpdate" />
                    <asp:PostBackTrigger ControlID="btnHClear" />
                    <asp:PostBackTrigger ControlID="btnHExit" />
                    <asp:PostBackTrigger ControlID="gvHoliday" />

                    <asp:PostBackTrigger ControlID="btnCLSave" />
                    <asp:PostBackTrigger ControlID="btnCLUpdate" />
                    <asp:PostBackTrigger ControlID="btnCLClear" />

                    <asp:PostBackTrigger ControlID="imgbtnExportExcel"/>

                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

