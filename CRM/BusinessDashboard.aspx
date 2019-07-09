<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BusinessDashboard.aspx.cs" Inherits="BusinessDashboard" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" ValidateRequest="false" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <title>Business Dashboard</title>
    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />

    <style type="text/css">
        a:visited {
            color: #000066;
        }
        myclass, a.myclass:visited {
            color: #FF0000;
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

         }
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">

    <div style="width: 50%;">
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Width="900" Height="500">
            <Windows>
                <telerik:RadWindow ID="RadWindow2" runat="server">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    <table style="width: 100%;">
        <tr style="width: 100%;">
            <td align="right" style="width: 78%;"></td>
            <td align="right" style="width: 12%;" valign="middle">
                <asp:ImageButton ID="Button1" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
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
            <td align="left" valign="middle" style="width: 3%;">
                <asp:LinkButton ID="lblHome" Height="10px" Font-Underline="false" PostBackUrl="~/Home.aspx" ToolTip="Click here to return back to home" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
            </td>
            <td align="right" style="width: 2%;">
                <asp:ImageButton ID="ImageButton1" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
            </td>
            <td align="left" valign="middle" style="width: 5%;">
                <asp:LinkButton ID="lbSignOut" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work." Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
            </td>
        </tr>
    </table>
    <div style="margin-left: 10px">
        <table>
            <tr>
                <td valign="top" style="width: 8%; border: black 2px">
                    <table>
                        <tr>
                            <td align="left" colspan="3">
                                <asp:Label ID="Label32" runat="Server" Text="InfoGraphics" Font-Bold="true" ForeColor="DarkOliveGreen" Font-Names="Algerian" Font-Size="Large"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TreeView runat="server" ID="tvBDB" initialexpanddepth="1" OnSelectedNodeChanged="tvBDB_SelectedNodeChanged" ForeColor="#444444" Font-Names="Verdana" Font-Size="0.8em">
                                    <Nodes>
                                        <asp:TreeNode Text="Marketing">
                                            <asp:TreeNode Text="Sales Pipeline"></asp:TreeNode>
                                            <asp:TreeNode Text="Order Book"></asp:TreeNode>
                                            <asp:TreeNode Text="Business Summary"></asp:TreeNode>
                                            <asp:TreeNode Text="Category-wise Summary"></asp:TreeNode>
                                            <asp:TreeNode Text="Active Enquiries"></asp:TreeNode>
                                            <asp:TreeNode Text="Active Quotations"></asp:TreeNode>
                                            <asp:TreeNode Text="Leads Tracker"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="Projects">
                                            <asp:TreeNode Text="In Progress"></asp:TreeNode>
                                            <asp:TreeNode Text="Completed"></asp:TreeNode>
                                            <asp:TreeNode Text="Maintenance"></asp:TreeNode>
                                            <asp:TreeNode Text="Delays"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="General">
                                            <asp:TreeNode Text="Work In Progress"></asp:TreeNode>
                                            <asp:TreeNode Text="Work Completed"></asp:TreeNode>
                                            <asp:TreeNode Text="Work Delays"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="Leads">
                                            <asp:TreeNode Text="Lead Source"></asp:TreeNode>
                                            <asp:TreeNode Text="Lead Status"></asp:TreeNode>
                                            <asp:TreeNode Text="Lead Category"></asp:TreeNode>
                                            <asp:TreeNode Text="Lead Campaign"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="Customers">
                                            <asp:TreeNode Text="Source"></asp:TreeNode>
                                            <asp:TreeNode Text="Campaign"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="Work Progress">
                                            <asp:TreeNode Text="Summary"></asp:TreeNode>
                                            <asp:TreeNode Text="Detailed"></asp:TreeNode>
                                        </asp:TreeNode>
                                    </Nodes>
                                    <NodeStyle Font-Bold="true" />
                                    <HoverNodeStyle CssClass="myclass" />
                                </asp:TreeView>
                            </td>
                        </tr>

                    </table>

                </td>
                <td style="width: 92%; border: black 2px" valign="top">
                    <div id="dvfilter" runat="server">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label33" runat="Server" Text="From:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                    <telerik:RadDatePicker ID="dtpbdfrom" runat="server" Culture="English (United Kingdom)"
                                        Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="style2" Font-Names="verdana">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                            Font-Names="verdana" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                                <td>
                                    <asp:Label ID="Label34" runat="Server" Text="To:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                    <telerik:RadDatePicker ID="dtpbdto" runat="server" Culture="English (United Kingdom)"
                                        Width="130px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="style2" Font-Names="verdana">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                            Font-Names="verdana" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                                <td>
                                    <asp:Label ID="Label35" runat="Server" Text="Executive:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                    <asp:DropDownList ID="ddlbdstaff" runat="server" Width="125px" CssClass="style3" ToolTip="">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <br />
                                    <asp:Button ID="btnbdshow" runat="server" Text="Show" CssClass="btnSmallMainpage" Width="60px" ToolTip="Click to search business dashbord details against dates and executives." OnClick="btnbdshow_Click" />
                                </td>
                                <td>
                                    <br />
                                    <asp:Label ID="Label1" runat="Server" Text="Here you see a summary.For details check the respective reports in the Reports menu." Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small" ForeColor="gray"></asp:Label>
                                </td>

                            </tr>
                        </table>
                    </div>

                    <div id="dvSalesPipeline" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">


                        <%--<table style="border-collapse: collapse; width:100%">
                <td style="text-align:center">
                        <asp:Label ID="Label37" runat="Server" Text="Sales Pipeline" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                    </td>
            </table>--%>

                        <table width="100%">

                            <tr align="center">
                                <td>

                                    <table style="border-collapse: collapse">
                                        <td style="text-align: left">
                                            <asp:Label ID="lblpipelinetitle" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                        </td>
                                    </table>
                                    <table style="border-collapse: collapse">

                                        <tr style="background-color: #5B74A8">
                                            <td class="tborder" style="width: 100px">
                                                <asp:Label ID="Label30" runat="Server" Text="" Font-Bold="false" Font-Names="Verdana"
                                                    Font-Size="Smaller" ForeColor="White"></asp:Label>
                                            </td>
                                            <td class="tborder" style="width: 130px; text-align: center">
                                                <asp:Label ID="Label24" runat="Server" Text="" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller" ForeColor="White"></asp:Label>
                                            </td>
                                            <td class="tborder" style="width: 80px; text-align: center">
                                                <asp:Label ID="Label9" runat="Server" Text="Count" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller" ForeColor="White"></asp:Label>
                                            </td>
                                            <td class="tborder" style="width: 80px; text-align: right">
                                                <asp:Label ID="Label5" runat="Server" Text="Value" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller" ForeColor="White"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label12" runat="Server" Text="Enquiries" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder">
                                                <asp:Label ID="Label6" runat="Server" Text="Leads" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblhlcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblhlvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label13" runat="Server" Text="" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder">
                                                <asp:Label ID="Label7" runat="Server" Text="Customers" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblwcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblwvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder" colspan="2">
                                                <asp:Label ID="Label11" runat="Server" Text="Total" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblplte" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblpltq" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label17" runat="Server" Text="Quotations" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder">
                                                <asp:Label ID="Label8" runat="Server" Text="Leads" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblqcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblqvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label22" runat="Server" Text="" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder">
                                                <asp:Label ID="Label10" runat="Server" Text="Customers" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblecount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblevalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder" colspan="2">
                                                <asp:Label ID="Label14" runat="Server" Text="Total" ForeColor="DarkBlue"
                                                    Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblplqc" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblplqv" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                    <table>
                                        <tr>
                                            <td colspan="3" style="text-align: left">
                                                <asp:Label ID="lblTotalEnquiries" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>

                        </table>

                        <table width="100%">
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="btnPDFSales" Font-Size="Small" runat="server" ForeColor="DarkMagenta" ToolTip="Click here to view a sample chart" Text="Sample Chart" Font-Names="Verdana" OnClick="btnPDFSales_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 100%;">

                                                <%--microsoft chart--%>

                                                <asp:Chart ID="cEnquiries" runat="server" Height="200px" Width="360px"><ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart>


                                                <asp:Chart ID="cQuotations" runat="server" Height="200px" Width="360px">

                                                    <ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart>

                                                <asp:Chart ID="cQuotationsValue" runat="server" Height="200px" Width="360px">

                                                    <ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart>

                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvOrderBook" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label38" runat="Server" Text="Order Book" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr>
                                <td></td>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" Font-Size="Small" runat="server" ForeColor="DarkMagenta" ToolTip="Click here to view a sample chart" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton1_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table style="border-collapse: collapse">
                                        <tr>
                                            <td colspan="3" style="text-align: left">
                                                <asp:Label ID="Label2" runat="Server" Text="Order Book in the given date range." Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #5B74A8">
                                            <td class="tborder" style="width: 230px">
                                                <asp:Label ID="Label25" runat="Server" Text="" Font-Bold="false" Font-Names="Verdana"
                                                    Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="width: 80px; text-align: center">
                                                <asp:Label ID="Label26" runat="Server" Text="Count" ForeColor="White" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="width: 80px; text-align: right">
                                                <asp:Label ID="Label27" runat="Server" Text="Value" ForeColor="White" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label29" runat="Server" Text="From Existing customers" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Verdana"
                                                    Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lbleccount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblecvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label31" runat="Server" Text="From New Customers" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Verdana"
                                                    Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblnccount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblncvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tborder">
                                                <asp:Label ID="Label28" runat="Server" Text="Total" Font-Bold="false" ForeColor="DarkBlue" Font-Names="Verdana"
                                                    Font-Size="Smaller"></asp:Label>
                                            </td>

                                            <td class="tborder" style="text-align: center">
                                                <asp:Label ID="lblnocount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                            <td class="tborder" style="text-align: right">
                                                <asp:Label ID="lblnovalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                    Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td>
                                                <%--<asp:Chart ID="cOrderBook" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                                <asp:Chart ID="cOrderBook" runat="server" Height="200px" Width="360px">

                                                    <ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart>

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                        </table>

                    </div>
                    <div id="dvBusinessSummary" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label39" runat="Server" Text="Business Summary" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr>
                                <td></td>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton2" Font-Size="Small" runat="server" ToolTip="Click here to view a sample chart" ForeColor="DarkMagenta" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton2_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="Label3" runat="Server" Text="Business Summary in the given date range" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvOrderBook" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="230px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>

                                </td>
                                <td style="width: 50%">
                                    <%--<asp:Chart ID="cBusinessSummary" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="500px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cBusinessSummary" runat="server" Height="200px" Width="360px">
                                        <Series>
                                            <asp:Series Name="BusinessSummary" YValuesPerPoint="1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                </td>

                            </tr>

                        </table>
                    </div>
                    <div id="dvCategorywiseSummary" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label40" runat="Server" Text="Category-wise Summary" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%;">
                            <tr align="center">
                                <td align="center">
                                    <asp:GridView ID="gvCategorySummary" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                        PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue">
                                        <Columns>

                                            <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="130px" />
                                            <asp:BoundField HeaderText="Enquiry" DataField="Warm" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                            <asp:BoundField HeaderText="Value" DataField="WarmValue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField HeaderText="Quotation" DataField="Hot" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" />
                                            <asp:BoundField HeaderText="Value" DataField="Hotvalue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                ItemStyle-Width="80px" />
                                            <asp:BoundField HeaderText="Orders" DataField="Orders" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" />
                                            <asp:BoundField HeaderText="Value" DataField="OrdersValue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                ItemStyle-Width="80px" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align: center">
                                    <asp:Label ID="lblcs" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small" ForeColor="gray"></asp:Label>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton3" Font-Size="Small" runat="server" ToolTip="Click here to view a sample chart" ForeColor="DarkMagenta" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton3_Click" />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 50%;">
                                    <asp:Chart ID="cCategorywisesummary" runat="server" Height="400px" Width="500px">
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                    <%--  <asp:Chart ID="cCategorywisesummary" runat="server" Height="200px" Width="500px" >
                                        
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                </td>
                                <td style="width: 50%;">
                                    <asp:Chart ID="cCategorywisesummaryvalue" runat="server" Height="400px" Width="500px">
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                            <tr>
                            </tr>
                        </table>
                    </div>
                    <div id="dvActiveEnquiries" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label54" runat="Server" Text="Active Enquiries" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr>
                                <td></td>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton4" Font-Size="Small" runat="server" ToolTip="Click here to view a sample chart" ForeColor="DarkMagenta" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton4_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblActiveEnquiries" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvActiveEnquiries" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Status" DataField="Type" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="230px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%;">
                                    <asp:Chart ID="cActiveEnquiries" runat="server" Height="300px" Width="500px">
                                        <Series>
                                            <asp:Series Name="ActiveEnquiries" YValuesPerPoint="1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="dvActiveQuotations" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label55" runat="Server" Text="Active Quotations" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td></td>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton5" Font-Size="Small" runat="server" ToolTip="Click here to view a sample chart" ForeColor="DarkMagenta" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton5_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblActiveQuotations" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvActiveQuotations" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Status" DataField="Type" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="230px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%;">
                                    <asp:Chart ID="cActiveQuotations" runat="server" Height="300px" Width="500px">
                                        <Series>
                                            <asp:Series Name="ActiveQuotations" YValuesPerPoint="1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="dvLeadsTrack" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label56" runat="Server" Text="Leads Tracker" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <br />
                        <table style="width: 100%;">
                            <tr align="center">
                                <td style="width: 200px;"></td>
                                <td align="center" style="width: 600px;">
                                    <img src="Images/LeadsTrackNew.JPG" alt="Leads Track" />
                                </td>                              
                            </tr>
                            <tr>
                                <td></td>
                                 <td></td>
                            </tr>
                            <tr style="width:800px;">
                                 <td style="width: 100px;"></td>
                                <td colspan="1" style="width:700px;" align="left">
                                    <asp:GridView ID="gvLeadsTrack" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                        PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                        <Columns>
                                            <asp:BoundField HeaderText="Age" DataField="Type" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="150" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField HeaderText="Enquiry" DataField="0REG" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="120" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField HeaderText="Warm" DataField="1ENQ" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="120" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField HeaderText="Assigned" DataField="3ASE" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="120" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField HeaderText="Hot" DataField="5QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="120" ItemStyle-HorizontalAlign="Center" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <asp:Label ID="Label57" runat="server" ForeColor ="Black" Font-Size ="Smaller" Font-Names="verdana" Text="Note:   Use this information to speed-up the followups for new business."></asp:Label><br />
                                    <asp:Label ID="Label58" runat="server" ForeColor ="Black" Font-Size ="Smaller" Font-Names="verdana" Text="If a ‘Lead’ is in enquiry stage for longer than necessary (Ex: > 30 days) review to decide whether to pursue further or to drop it."></asp:Label>

                                </td>
                            </tr>
                        </table>
                        <br />
                        <div>
                        <table align="center" border="1"  cellpadding="3" cellspacing="3" class="tborder">                                            
                            <tr style="background-color:beige;">
                                 <td>
                                    <asp:Label ID="Label61" runat="Server" Text="Sales Pipeline value " ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLeadsTrackPipeline" runat="Server" Text="Leads" ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>    
                            </tr>
                            <tr style="background-color:lightgray;">
                                <td>
                                    <asp:Label ID="Label63" runat="Server" Text="Most recent 'Lead' was added on " ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLeadsTrackLeadAdd" runat="Server" Text="" ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>                                
                            </tr>
                            <tr style="background-color:beige;">
                                <td>
                                    <asp:Label ID="Label67" runat="Server" Text="Most recent 'Lead' Status update was on " ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLeadsTrackLeadupdate" runat="Server" Text="" ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>                               
                            </tr>
                            <tr style="background-color:lightgray;">
                                <td>
                                    <asp:Label ID="Label71" runat="Server" Text="Most recent #Quote was on " ForeColor="DarkBlue"
                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>

                                <td>
                                    <asp:Label ID="lblLeadsTrackQuoteAdd" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                </td>                               
                            </tr>                         
                        </table>
                        </div>
                    </div>

                    <div id="dvInProgressService" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label4" runat="Server" Text="In Progress" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr style="width: 100%;">
                                <td colspan="2" align="right" style="width: 100%;">
                                    <asp:LinkButton ID="LinkButton6" Font-Size="Small" runat="server" ForeColor="DarkMagenta" ToolTip="Click here to view a sample chart" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton6_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblcinprogress" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvInProgress" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="130px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>

                                </td>
                                <td style="width: 50%">
                                    <%--<asp:Chart ID="cInProgress" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cInProgress" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>

                        </table>

                    </div>
                    <div id="dvCompletedService" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label41" runat="Server" Text="Completed" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td colspan="2" align="right" style="width: 100%;">
                                    <asp:LinkButton ID="LinkButton7" Font-Size="Small" runat="server" ForeColor="DarkMagenta" ToolTip="Click here to view a sample chart" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton7_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="Label15" runat="Server" Text="Completed in the given date range." Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvCompleted" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="130px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%">
                                    <%--<asp:Chart ID="cCompleted" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cCompleted" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>

                        </table>

                    </div>
                    <div id="dvMaintenanceService" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label42" runat="Server" Text="Maintenance" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td colspan="2" align="right" style="width: 100%;">
                                    <asp:LinkButton ID="LinkButton8" Font-Size="Small" runat="server" ForeColor="DarkMagenta" ToolTip="Click here to view a sample chart" Text="Sample Chart" Font-Names="Verdana" OnClick="LinkButton8_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblamcasc" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvamcasc" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="130px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%">
                                    <%-- <asp:Chart ID="cMaintanance" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cMaintanance" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvDelayService" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label43" runat="Server" Text="Delays" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table>
                            <tr>
                                <td style="text-align: left">
                                    <asp:Label ID="Label16" runat="Server" Text="Delays in providing service" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Red"></asp:Label>
                                    &nbsp;
                        <asp:Label ID="Label18" runat="Server" Text="By No.of days" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"></asp:Label>
                                    <asp:DropDownList ID="ddldays" runat="server" OnSelectedIndexChanged="ddldays_SelectedIndexChanged" AutoPostBack="true" ToolTip="Select a day to display delay work.">
                                        <asp:ListItem Text="1" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="-2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="-3"></asp:ListItem>
                                        <asp:ListItem Text="4" Value="-4"></asp:ListItem>
                                        <asp:ListItem Text="5" Value="-5"></asp:ListItem>
                                        <asp:ListItem Text="6" Value="-6"></asp:ListItem>
                                        <asp:ListItem Text="7" Value="-7"></asp:ListItem>
                                        <asp:ListItem Text=">7" Value="8"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvDelays" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                        PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false" DataKeyNames="TaskID">
                                        <Columns>

                                            <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Engineer" DataField="Engineer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField HeaderText="Work" DataField="Work" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="300px" ItemStyle-HorizontalAlign="Left" />

                                            <asp:BoundField HeaderText="Status" DataField="CodeDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                        </table>
                    </div>

                    <div id="dvInProgressGeneral" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label44" runat="Server" Text="Work In Progress" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">

                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="Label19" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvGInProgress" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="gvGInProgress_PageIndexChanging"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="130px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%">
                                    <%-- <asp:Chart ID="cInProgress" runat="server" Height="200px" Palette="None" Width="360px" BorderlineDashStyle = "Solid"  BorderlineWidth ="2" BorderSkin-SkinStyle ="Emboss"  BorderlineColor ="26, 59, 105"  BackColor ="AliceBlue"    >
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>
                                    <asp:Chart ID="cGInProgress" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>


                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvCompletedGeneral" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label45" runat="Server" Text="Work Completed" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">

                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="Label20" runat="Server" Text="Completed in the given date range." Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvGCompleted" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="gvGCompleted_PageIndexChanging"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="130px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 50%">
                                    <%--<asp:Chart ID="cCompleted" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cGCompleted" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="dvMaintenanceGeneral" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label21" runat="Server" Text="Work Delays" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table>

                            <tr>
                                <td>
                                    <asp:GridView ID="gvGMaintenance" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="gvGMaintenance_PageIndexChanging"
                                        PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                        <Columns>

                                            <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="130px" />
                                            <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                            <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Right"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" />

                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <td>
                                    <%--<asp:Chart ID="cMaintanance" runat="server" BackColor="128, 64, 0" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="200px" Palette="None" PaletteCustomColors="64, 0, 64"
                                        Width="360px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="12" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>--%>

                                    <asp:Chart ID="cGMaintenance" runat="server" Height="200px" Width="360px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvDelaysGeneral" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label46" runat="Server" Text="Work Delays" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">



                            <tr>
                                <td style="text-align: left">
                                    <asp:Label ID="Label23" runat="Server" Text="Delays in providing service" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Red"></asp:Label>
                                    &nbsp;
                        <asp:Label ID="Label36" runat="Server" Text="By No.of days" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"></asp:Label>
                                    <asp:DropDownList ID="ddlGdelays" runat="server" OnSelectedIndexChanged="ddlGdelays_SelectedIndexChanged" AutoPostBack="true" ToolTip="Select a day to display delay work.">
                                        <asp:ListItem Text="1" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="-2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="-3"></asp:ListItem>
                                        <asp:ListItem Text="4" Value="-4"></asp:ListItem>
                                        <asp:ListItem Text="5" Value="-5"></asp:ListItem>
                                        <asp:ListItem Text="6" Value="-6"></asp:ListItem>
                                        <asp:ListItem Text="7" Value="-7"></asp:ListItem>
                                        <asp:ListItem Text=">7" Value="8"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvGDelays" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                        PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false" DataKeyNames="TaskID">
                                        <Columns>

                                            <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Engineer" DataField="Engineer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="100px" />
                                            <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField HeaderText="Work" DataField="Work" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                ItemStyle-Width="300px" ItemStyle-HorizontalAlign="Left" />

                                            <asp:BoundField HeaderText="Status" DataField="CodeDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                        </table>


                    </div>

                    <div id="dvLeadSource" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label47" runat="Server" Text="Lead Source" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="float: left; width: 100%; vertical-align: central">

                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvLeadSourceSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                        AllowPaging="false" PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue"
                                                        OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]" Width="548px">
                                                        <FooterStyle HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Lead Source" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Lead Count" DataField="LeadCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Hot" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgLedSrcExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLedSrcExporttoExcel_Click" Style="text-align: right" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>

                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="lbtnLeadSource" Font-Size="Small" Font-Names="Verdana" runat="server" ForeColor="DarkMagenta" Text="Sample Chart" OnClick="lbtnLeadSource_Click" ToolTip="Click here to view a sample chart"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cLeadSource" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvLeadStatus" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label48" runat="Server" Text="Lead Status" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvLeadStatusSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                        AllowPaging="false" PageSize="30" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                        OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]">
                                                        <FooterStyle HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Lead Status" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Count" DataField="StatusCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="%" DataField="percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />

                                                        </Columns>
                                                    </asp:GridView>

                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgLedStatusExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLedStatusExporttoExcel_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                </td>
                                            </tr>

                                        </table>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="lbtnleadsts" Font-Size="Small" Font-Names="Verdana" ForeColor="DarkMagenta" runat="server" Text="Sample Chart" OnClick="lbtnleadsts_Click" ToolTip="Click here to view a sample chart"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cLeadStatus" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvLeadCategory" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label49" runat="Server" Text="Lead Category" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>

                                                    <asp:GridView ID="gvLeadCategorySummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                        AllowPaging="false" PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue"
                                                        OnPageIndexChanging="onLeadSummaryPaging" ToolTip="  A Summary of your customers and leads according to the category in which each one is classified.">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="HotLeads" DataField="HotLeads" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Customers" DataField="Customers" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgLeadCategoryExport" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLeadCategoryExport_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="lbtnleadcategory" Font-Size="Small" Font-Names="Verdana" runat="server" Text="Sample Graph" OnClick="lbtnleadcategory_Click" ToolTip="Click here to view sample graph"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cLeadCategory" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="dvLeadCampaign" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label50" runat="Server" Text="Lead Campaign" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvCampaignSummary" runat="server" AutoGenerateColumns="false" AllowPaging="false"
                                                        PageSize="30" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="onCampaignSummaryPaging"
                                                        ToolTip="Sofar:Includes all Leads\ Qualified[5QLD] Leads only." ShowFooter="true">
                                                        <FooterStyle HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Sofar" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="InLast7days" DataField="InLast7days" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Hot" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgCamSumExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCamSumExporttoExcel_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="lbtnleadcam" Font-Size="Small" Font-Names="Verdana" runat="server" Text="Sample Graph" OnClick="lbtnleadcam_Click" ToolTip="Click here to view sample graph"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cLeadCampaign" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="dvCustomerSource" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label51" runat="Server" Text="Source" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvCLeadSourceSummary" runat="server" AutoGenerateColumns="false"
                                                        AllowPaging="false" PageSize="30" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                        OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Lead Source" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Customers" DataField="Customer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgCLedSrcExporttoExcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCLedSrcExporttoExcel_Click" />
                                                </td>
                                            </tr>
                                        </table>

                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton10" Font-Size="Small" Font-Names="Verdana" runat="server" Text="Sample Graph" OnClick="LinkButton10_Click" ToolTip="Click here to view sample graph for customer source"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cCustomerSource" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="dvCustomerCampaign" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label37" runat="Server" Text="Campaign" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr align="center">
                                <td>
                                    <div style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvCCampaignSummary" runat="server" AutoGenerateColumns="false" AllowPaging="false"
                                                        PageSize="30" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="onCampaignSummaryPaging"
                                                        ToolTip="Sofar:Includes all Leads\ Qualified[5QLD] Leads only.">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Customers" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="InLast7days" DataField="InLast7days" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <asp:ImageButton ID="btnimgCCamSumExporttoExcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCCamSumExporttoExcel_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton9" Font-Size="Small" Font-Names="Verdana" runat="server" Text="Sample Graph" OnClick="LinkButton9_Click" ToolTip="Click here to view sample graph for customer campaign"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Chart ID="cCustomerCampaign" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>

                    <div id="dvWorkProgresssummary" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">

                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label52" runat="Server" Text="Work Progress Summary" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>
                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td align="right" style="width: 100%;">
                                    <asp:LinkButton ID="LinkButton12" Font-Size="Small" runat="server" ToolTip="Click here to open sample graph for work progress summary" Text="Sample Graph" Font-Names="Verdana" OnClick="LinkButton12_Click" />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 50%">
                                    <table>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblcworkprogresssummary" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvWorkProgressSummary" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                    PageSize="30" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue" Font-Bold="false">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="Status" DataField="Type" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="230px" />
                                                        <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="Smaller"
                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" />

                                                    </Columns>
                                                </asp:GridView>
                                            </td>

                                        </tr>
                                    </table>

                                </td>
                                <td style="width: 50%">

                                    <asp:Chart ID="cWorkProgressSummary" runat="server" Height="300px" Width="500px">
                                        <Series>
                                            <asp:Series Name="WorkProgressSummary" YValuesPerPoint="1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                </td>

                            </tr>
                        </table>


                    </div>
                    <div id="dvWorkProgressdetailed" runat="server" style="border-style: solid; border-width: thin; border-color: blue; height: auto; width: 100%; min-height: 600px">
                        <table style="border-collapse: collapse; width: 100%">
                            <td style="text-align: center">
                                <asp:Label ID="Label53" runat="Server" Text="Work Progress Detailed" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkOliveGreen"></asp:Label>
                            </td>
                        </table>

                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <div style="width: 100%">
                                        <table>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblwpstaff" runat="Server" Text="Staff:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlwpstaff" runat="server" Width="125px" CssClass="style3" ToolTip="">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="btnwpstaff" runat="server" Text="Show" CssClass="btnSmallMainpage" Width="60px" ToolTip="Click to here show work details of a selected employee." OnClick="btnwpstaff_Click" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="lblworkprogressdetailed" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvWorkProgressDetailed" runat="server" AutoGenerateColumns="false" AllowPaging="false"
                                                        PageSize="30" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                        ToolTip="">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Name" DataField="StaffName" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="YTS" DataField="YTS" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="YTS" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="WIP" DataField="IP" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                SortExpression="IP" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="HiPri" DataField="Priority" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Priority" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Done7" DataField="Done7" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="Done30" DataField="Done30" ReadOnly="true"
                                                                HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                                <td valign="top">
                                                    <%--<asp:ImageButton ID="ImageButton1" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCCamSumExporttoExcel_Click"  />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton11" Font-Size="Small" runat="server" ToolTip="Click here to open sample graph for work progress detailed summary" Text="Sample Graph" Font-Names="Verdana" OnClick="LinkButton11_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Chart ID="cWorkProgressDetailed" runat="server" Height="400px" Width="700px">

                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                </td>
                            </tr>
                        </table>

                    </div>

                </td>
            </tr>
        </table>


    </div>
</asp:Content>
