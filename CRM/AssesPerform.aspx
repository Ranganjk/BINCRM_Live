<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="AssesPerform.aspx.cs" EnableSessionState="ReadOnly" Inherits="AssesPerform" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">

   
    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/adminCenterPositionCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />

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
    <script src="Calender/jquery-1.10.2.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
         
        });
        $(function () {
            $("[id*='LinkButton6']").click(function () {
               
            });
            $("[id$='ddlAttendance']").change(function () {
                GetAvg();
            });
        });
        function GetAvg() {
            var att = $("[id$='ddlAttendance']").val();
            alert(att);
            $.ajax({
                url: "AssesPerform.aspx/Average",
                type: "POST",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert(data.d);
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

    </script>

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
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
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
    </style>
    <style type="text/css">
        .rounded_corners {
            border: 1px solid #A1DCF2;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            overflow: hidden;
        }

            .rounded_corners td, .rounded_corners th {
                border: 1px solid #A1DCF2;
                font-family: Arial;
                font-size: 10pt;
                text-align: center;
            }

            .rounded_corners table table td {
                border-style: none;
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
    <style type="text/css">
        .myGridStyle {
            border-collapse: collapse;
        }

            .myGridStyle tr th {
                padding: 2px;
                color: white;
                border: 1px solid black;
            }

            .myGridStyle tr:nth-child(even) {
                /*background-color: #E1FFEF;*/
                background-color: #EFF3FB;
            }

            .myGridStyle tr:nth-child(odd) {
                /*background-color: #00C157;*/
                background-color: AppWorkspace;
            }

            .myGridStyle td {
                border: 1px solid black;
                padding: 4px;
            }

            .myGridStyle tr:last-child td {
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <%-- <asp:ScriptManager ID="smAssess" runat="server"></asp:ScriptManager>--%>
    <script type="text/javascript">
        function validate() {           
            var summ = "";
            summ += Namevalidate();
            //summ += MonthOf();
            summ += StaffRemarks();
            summ += GoodbyAnother();
            summ += Attendance();
            summ += Attitude();
            summ += CustCentric();
            summ += Meeting();
            summ += Communication();
            summ += Quality();
            summ += Learning();
            summ += Participation();
            if (summ != "") {
                alert(summ);
                return false;
            }
            else {
                var rep = document.getElementById('<%= hbtnReporting.ClientID %>').value;
                //alert(rep);
                var x = confirm("Do you want to submit your appraisal to Mr." + rep);
                if (x)
                    return true;
                else
                    return false;
            }
        }

        function Namevalidate() {
             <%--var val = document.getElementById('<%=ddlStaffName.ClientID%>').value;--%>
             var val = document.getElementById('<%= LblStaffName.ClientID %>').value;
             if (val == "") {
                 return "Please select Staff Name" + "\n";
             }
             else {
                 return "";
             }
         }
         function MonthOf() {
             var val = document.getElementById('<%=ddlMonth.ClientID%>').value;
            if (val == "") {
                return "Please select Month Details" + "\n";
            }
            else {
                return "";
            }
        }

        function StaffRemarks() {
            var val = document.getElementById('<%=txtStaffRemarks.ClientID%>').value;
            if (val == "") {
                return "Please Enter Staff Remarks" + "\n";
            }
            else {
                return "";
            }
        }

        function GoodbyAnother() {
            var val = document.getElementById('<%=txtGoodbyAnother.ClientID%>').value;
            if (val == "") {
                return "Enter Good Work Done by Anothers" + "\n";
            }
            else {
                return "";
            }
        }

        function Attendance() {
            var val = document.getElementById('<%=ddlAttendance.ClientID%>').value;
            if (val == "") {
                return "Please Select Attendance" + "\n";
            }
            else {
                return "";
            }
        }

        function Attitude() {
            var val = document.getElementById('<%=ddlAttitude.ClientID%>').value;
            if (val == "") {
                return "Please Select Attitude" + "\n";
            }
            else {
                return "";
            }
        }

        function CustCentric() {
            var val = document.getElementById('<%=ddlcustomercentric.ClientID%>').value;
            if (val == "") {
                return "Please Select Customer Centric" + "\n";
            }
            else {
                return "";
            }
        }

        function Meeting() {
            var val = document.getElementById('<%=ddlMeeting.ClientID%>').value;
            if (val == "") {
                return "Please Select Meeting Deadlines" + "\n";
            }
            else {
                return "";
            }
        }

        function Communication() {
            var val = document.getElementById('<%=ddlCommunication.ClientID%>').value;
            if (val == "") {
                return "Please Select Communication" + "\n";
            }
            else {
                return "";
            }
        }

        function Quality() {
            var val = document.getElementById('<%=ddlQuality.ClientID%>').value;
            if (val == "") {
                return "Please Select Quality" + "\n";
            }
            else {
                return "";
            }
        }

        function Learning() {
            var val = document.getElementById('<%=ddlLearning.ClientID%>').value;
            if (val == "") {
                return "Please Select Learning" + "\n";
            }
            else {
                return "";
            }
        }

        function Participation() {
            var val = document.getElementById('<%=ddlparticipation.ClientID%>').value;
            if (val == "") {
                return "Please Select Participation" + "\n";
            }
            else {
                return "";
            }
        }
    </script>

    <script type="text/javascript">
        function chkconfirm() {
            var x = confirm("Do you want to save the appraisal?");
            if (x)
                return true;
            else
                return false;
        }

        function submitconfirm() {
            var x = confirm("Do you want to submit the appraisal to your appraiser?");
            if (x)
                return true;
            else
                return false;
        }

        function AlertMsg() {
            alert('There are no records to display');
        }
    </script>
    <asp:HiddenField ID="hbtnReporting" runat="server" />
    <asp:UpdatePanel ID="upAssess" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div id="dvContent" runat="server" style="border-style: solid; background-color: beige; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px; min-height: 500px;">
                <table style="width: 100%">
                    <tr style="width: 100%;" align="right">
                        <td align="right" style="width: 84%;">
                            <telerik:RadMenu Font-Names="verdana" Width="110px" ForeColor="Blue" ID="rmenuQuick" runat="server" ShowToggleHandle="false" Skin="Outlook" EnableRoundedCorners="true" EnableShadows="true" ClickToOpen="false" ExpandAnimation-Type="OutBounce" Flow="Vertical" DefaultGroupSettings-Flow="Horizontal">
                                <Items>
                                    <telerik:RadMenuItem Font-Names="Verdana" Text="Quick Links" ExpandMode="ClientSide" ToolTip="Click here to view quick links" Width="110px">
                                        <Items>
                                            <telerik:RadMenuItem Width="75px" Font-Bold="false" Text="MyTasks" NavigateUrl="Mytasks.aspx" ToolTip="View and manage tasks (activities/work) assigned to you."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="55px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="ByMe" NavigateUrl="ByMe.aspx" ToolTip="Tasks delegated by me and assigned by me."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="85px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Customers" NavigateUrl="Customers.aspx" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="90px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Infographics" NavigateUrl="BusinessDashboard.aspx" ToolTip="Click here to open business dashboard."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Reports" NavigateUrl="SMReports.aspx" ToolTip="Click here to open Reports."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="65px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Settings" NavigateUrl="Admin.aspx" ToolTip="Click here to manage users and system parameters."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem  Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Customer Care" ToolTip="Register a Customer Complaint or a Service Request or a Warranty Service here."></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Width="100px" Font-Bold="false" ForeColor="Black" BackColor="Transparent" Text="Appointments" NavigateUrl="Calendar.aspx" ToolTip="Click to enter a new appointment or to view calendar appointments."></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </td>
                        <td align="right" style="width: 5%;">
                            <asp:ImageButton ID="ImageButton2" OnClick="ImageButton2_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
                        </td>
                        <td style="width: 2%;" align="right" valign="middle">
                            <asp:Label ID="lblHome" Height="10px" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
                        </td>
                        <td style="width: 3%;" align="right">
                            <asp:ImageButton ID="ImageButton1" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                        </td>
                        <td style="width: 6%;" align="left" valign="middle">
                            <asp:Label ID="lbSignOut" Height="10px" Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                        </td>
                    </tr>
                </table>
                <table width="100%" align="center">
                    <tr>
                        <td></td>
                        <td align="center" width="100%">
                            <asp:Label ID="Label12" runat="server" Text="Performance Reports" Font-Size="Large"
                                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnBackHome" Visible="false" runat="server" CssClass="buttonClass" Font-Size="Small" Text="Return" ToolTip="Back to Home Page" OnClick="lbtnBackHome_Click" Font-Names="Verdana"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr align="center" style="width: 100%">
                        <td width="15%" align="left">
                            <table>
                                <tr valign="middle">
                                    <td>
                                        <%--CssClass="btnMainpage"--%>
                                        <asp:Button ID="LinkButton6" ToolTip="Click here to submit new appraisal" runat="server" CssClass="btnMainpage" Text="Submit New Appraisal" Font-Names="Verdana" Font-Size="Small" Visible="true" OnClick="LinkButton6_Click" Width="200px"></asp:Button>
                                         <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>                               
                                <tr valign="middle">
                                    <td>
                                        <asp:Button ID="lbtnunsubmit" runat="server" CssClass="btnMainpage" ToolTip="Click here to open previous appraisal details." OnClick="lbtnunsubmit_Click" Text="Previous Appraisals" Font-Names="Verdana" Font-Size="Small" Visible="false" Width="200px"></asp:Button>
                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td width="85%" style="text-align: left">&nbsp;<br />
                            <asp:GridView ID="gvAssesPerform" runat="server" CssClass="rounded_corners" Font-Names="verdana" Font-Size="Small" PageSize="12" Width="75%" AllowPaging="True" ToolTip="Showing Overall Perofrmance Details" AutoGenerateColumns="False" DataKeyNames="RSN" OnPageIndexChanging="gvAssesPerform_PageIndexChanging" HorizontalAlign="Center" OnRowCommand="gvAssesPerform_RowCommand" EnableModelValidation="True" OnRowCreated="gvAssesPerform_RowCreated" OnRowDataBound="gvAssesPerform_RowDataBound">
                                <RowStyle BackColor="#EFF3FB" Font-Names="Verdana" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Verdana" />
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ibtnView" runat="server" CommandArgument='<%# Eval("RSN") %>' Height="25px" Width="25px" CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted" ImageUrl="~/Images/View1.jpg" />
                                            &nbsp;&nbsp;
                                        <asp:ImageButton ID="imgbtnUpdate" ToolTip="Performance yet to be submitted or reviewed.can be edited" CommandName="UpdateS" Enabled='<%# Eval("Flag").ToString() != "S" %>' runat="server" CommandArgument='<%# Eval("RSN") %>' Height="25px" Width="25px" AlternateText='<%# Eval("Flag") %>' />
                                            <%--<asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("RSN") %>' CommandName="View" Font-Names="Verdana" ToolTip="Click Here To View the list of performance assessment submitted">View</asp:LinkButton>--%>
                                        </ItemTemplate>
                                        <ItemStyle VerticalAlign="Middle" Font-Names="Verdana"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Staff Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" ToolTip="staff name" Text='<%# Eval("Display") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="For Month of">
                                        <ItemTemplate>
                                            <asp:Label ID="Label13" runat="server" ToolTip="Showing month and year" Text='<%# Eval("ForMonthOf") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="Label15" runat="server" ToolTip="Average Assessment by You" Text='<%# Eval("Average") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average A" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAvgA" ToolTip="Average Assessment provided by Reporting Head" runat="server" Text='<%# Eval("Average_A") %>'></asp:Label>
                                            <%-- Visible='<%# Eval("Flag").ToString() != "N" %>'--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" Enabled='<%# Eval("Flag").ToString() != "Y" %>' runat="server" ToolTip="Performance yet to be submitted or reviewed.can be edited" CommandArgument='<%# Eval("RSN") %>' CommandName="SEdit" Height="25px" Width="25px" AlternateText='<%# Eval("Flag") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="dvUnSubmitted" runat="server" style="border-style: solid; background-color: beige; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px; min-height: 500px;">
                <table width="100%" runat="server">
                    <tr>
                        <td align="center" colspan="2" width="100%">
                            <asp:Label ID="Label47" runat="server" Text="Performance Reports" Font-Size="Large"
                                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" width="100%">
                            <asp:LinkButton ID="LinkButton8" runat="server" Font-Size="Small" CssClass="buttonClass" Text="Return" ToolTip="Click here to go back appraisals home page" OnClick="LinkButton5_Click" Font-Names="Verdana"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr align="center" style="width: 100%">
                        <td width="100%" style="text-align: left">&nbsp;<br />
                            <asp:GridView ID="gvUserAssess" CssClass="rounded_corners" OnRowDataBound="gvUserAssess_RowDataBound" runat="server" EmptyDataText="No Records Found" Font-Names="verdana" Font-Size="Small" PageSize="15" Width="60%" AllowPaging="True" ToolTip="Showing Overall Perofrmance Details" AutoGenerateColumns="False" DataKeyNames="RSN" OnPageIndexChanging="gvUserAssess_PageIndexChanging" HorizontalAlign="Center" OnRowCommand="gvUnSubmitAssess_RowCommand" EnableModelValidation="True">
                                <RowStyle BackColor="#EFF3FB" Font-Names="Verdana" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Verdana" />
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ibtnView" runat="server" CommandArgument='<%# Eval("RSN") %>' Height="25px" Width="25px" CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted" ImageUrl="~/Images/View1.jpg" />
                                            &nbsp;&nbsp;
                                        <%--<asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("RSN") %>' CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted">View</asp:LinkButton>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Staff Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" ToolTip="staff name" Text='<%# Eval("Display") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="For Month of">
                                        <ItemTemplate>
                                            <asp:Label ID="Label13" runat="server" ToolTip="Showing year and month" Text='<%# Eval("ForMonthOf") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="Label15" runat="server" ToolTip="Average Assessment by You" Text='<%# Eval("Average") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average A" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAvgA" ToolTip="Average Assessment provided by Reporting Head" runat="server" Text='<%# Eval("Average_A") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="dvMenu" runat="server" visible="false" style="border-style: solid; background-color: beige; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px;">
                <telerik:RadTabStrip ID="tabMain" runat="server" MultiPageID="radmulti" SelectedIndex="0" ClickSelectedTab="true" AutoPostBack="true" OnTabClick="tabMain_TabClick" Skin="WebBlue">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Submitted to You" PageViewID="Pageview1" Font-Names="Verdana" Font-Bold="true" Selected="true"></telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Submitted by You" PageViewID="Pageview2" Font-Names="Verdana" Font-Bold="true" SelectedIndex="2"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="radmulti" runat="server" BackColor="Beige">
                    <telerik:RadPageView ID="Pageview1" runat="server" Font-Names="Verdana" Selected="true" Height="500px">
                        <table width="100%" align="center" style="background-color: beige;">
                            <tr>
                                <td align="center" colspan="2" width="100%">
                                    <asp:Label ID="Label43" runat="server" Text="Previous Appraisals" Font-Size="Large"
                                        Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" width="100%">
                                    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="buttonClass" Font-Size="Small" Text="Back to List" ToolTip="Click here to go back appraisals home page" OnClick="LinkButton5_Click" Font-Names="Verdana"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center" style="width: 100%">
                                <td align="right" style="width: 40%">
                                    <asp:Label ID="lblunStaff" runat="server" Text="Staff Name : " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td align="left" style="width: 60%">&nbsp;&nbsp;
                    <telerik:RadDropDownList ID="radstaff" runat="server" OnSelectedIndexChanged="radstaff_SelectedIndexChanged" ToolTip="Select the staff name to search the performance details" AutoPostBack="true"></telerik:RadDropDownList>
                                    &nbsp;&nbsp;
                    <asp:Button ID="btnUnSearch" runat="server" Visible="false" ToolTip="Select the staff name to search the performance details" Text="View" CssClass="Button" OnClick="btnUnSearch_Click" Width="100px" />
                                </td>
                            </tr>
                            <tr align="center" style="width: 100%">
                                <td width="100%" colspan="2" style="text-align: left">&nbsp;<br />
                                    <asp:GridView ID="gvUnSubmitAssess" CssClass="rounded_corners" OnRowDataBound="gvUnSubmitAssess_RowDataBound" runat="server" Font-Names="verdana" EmptyDataText="No Records Found" ShowHeader="true" Font-Size="Small" PageSize="10" Width="60%" AllowPaging="True" ToolTip="Showing Overall Perofrmance Details" AutoGenerateColumns="False" DataKeyNames="RSN" OnPageIndexChanging="gvUnSubmitAssess_PageIndexChanging" HorizontalAlign="Center" OnRowCommand="gvUnSubmitAssess_RowCommand" EnableModelValidation="True">
                                        <RowStyle BackColor="#EFF3FB" Font-Names="Verdana" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Verdana" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ibtnView" runat="server" CommandArgument='<%# Eval("RSN") %>' Height="25px" Width="25px" CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted" ImageUrl="~/Images/View1.jpg" />
                                                    &nbsp;&nbsp;
                                        <%--<asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("RSN") %>' CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted">View</asp:LinkButton>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Staff Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" ToolTip="staff name" Text='<%# Eval("Display") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="For Month of">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" ToolTip="Showing month and year" Text='<%# Eval("ForMonthOf") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Average" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label15" runat="server" ToolTip="Average Assessment by You" Text='<%# Eval("Average") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Average A" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAvgA" ToolTip="Average Assessment provided by Reporting Head" runat="server" Text='<%# Eval("Average_A") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="Pageview2" runat="server" Height="500px">
                        <table width="100%" align="center" style="background-color: beige;">
                            <tr>
                                <td align="center" colspan="2" width="100%">
                                    <asp:Label ID="Label46" runat="server" Text="Previous Appraisals" Font-Size="Large"
                                        Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" width="100%">
                                    <asp:LinkButton ID="LinkButton7" runat="server" Font-Size="Small" CssClass="buttonClass" Text="Back to List" ToolTip="Click here to go back appraisals home page" OnClick="LinkButton5_Click" Font-Names="Verdana"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr align="center" style="width: 100%">
                                <td width="100%" colspan="2" style="text-align: left">&nbsp;<br />
                                    <asp:GridView ID="GridView1" CssClass="rounded_corners" OnRowDataBound="GridView1_RowDataBound" runat="server" EmptyDataText="No Records Found" Font-Names="verdana" Font-Size="Small" PageSize="10" Width="75%" AllowPaging="True" ToolTip="Showing Overall Perofrmance Details" AutoGenerateColumns="False" DataKeyNames="RSN" OnPageIndexChanging="gvUnSubmitAssess_PageIndexChanging" HorizontalAlign="Center" OnRowCommand="gvUnSubmitAssess_RowCommand" EnableModelValidation="True">
                                        <RowStyle BackColor="#EFF3FB" Font-Names="Verdana" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Verdana" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ibtnView" runat="server" CommandArgument='<%# Eval("RSN") %>' Height="25px" Width="25px" CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted" ImageUrl="~/Images/View1.jpg" />
                                                    &nbsp;&nbsp;
                                        <%--<asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("RSN") %>' CommandName="View" ToolTip="Click Here To View the list of performance assessment submitted">View</asp:LinkButton>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Staff Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" ToolTip="staff name" Text='<%# Eval("Display") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="For Month of">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" ToolTip="Showing year and month" Text='<%# Eval("ForMonthOf") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Average" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label15" runat="server" ToolTip="Average Assessment by You" Text='<%# Eval("Average") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Average A" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAvgA" ToolTip="Average Assessment provided by Reporting Head" runat="server" Text='<%# Eval("Average_A") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </div>

            <div id="dvTest" runat="server" style="border-style: solid; background-color: beige; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px; min-height: 500px;">
                <table width="100%">
                    <tr>
                        <td width="10%"></td>
                        <td width="80%" align="right" style="align-content: center">
                            <asp:LinkButton ID="lbtnTestCancel" runat="server" Font-Names="verdana" CssClass="buttonClass" Font-Size="Small" Text="Back to List" ToolTip="Click here to go back appraisals home page" OnClick="lbtnTestCancel_Click"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td width="10%"></td>
                        <td align="left" width="90%">
                            <asp:GridView ID="gvAssesView" CssClass="myGridStyle" GridLines="Vertical" runat="server" Font-Names="verdana" Font-Size="Small" ShowHeader="true" Width="40%" AllowPaging="false" ToolTip="Showing Individual Perofrmance Details" AutoGenerateColumns="true" HorizontalAlign="Center">
                                <%--<RowStyle BackColor="#EFF3FB" Font-Names="Verdana" />                          
                            <AlternatingRowStyle BackColor="White" ForeColor="Black" Font-Names="Verdana" />--%>
                            </asp:GridView>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
            <div align="center" id="dvEdit" runat="server" style="border-style: solid; background-color: beige; min-height: 600px; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px;">
                <table>
                    <tr style="width: 100%;">
                        <td style="font-family: verdana; font-size: medium; width: 50%;">
                            <asp:DetailsView ID="DetailsView1" CssClass="rounded_corners" runat="server" AutoGenerateRows="False" CellPadding="4" RowStyle-Wrap="true" Font-Names="verdana" HeaderStyle-HorizontalAlign="Center" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" EnableModelValidation="True" HeaderText="Assess Performance Details" OnItemCommand="DetailsView1_ItemCommand" HorizontalAlign="Center" ToolTip="Providing Asses Peformance Details" Width="250px">
                                <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" HorizontalAlign="Center" Font-Names="Verdana" Font-Size="Small" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" Width="100%" HorizontalAlign="Left" Font-Names="Verdana" Font-Size="Small" ForeColor="#003399" />
                                <AlternatingRowStyle Width="100%" />
                                <Fields>
                                    <asp:TemplateField HeaderText="RSN">
                                        <ItemTemplate>
                                            <asp:Label ID="Label24" runat="server" Text='<%# Eval("RSN") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="StaffName">
                                        <ItemTemplate>
                                            <asp:Label ID="Label25" runat="server" Text='<%# Eval("StaffName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ForMonthOf">
                                        <ItemTemplate>
                                            <asp:Label ID="Label26" runat="server" Text='<%# Eval("ForMonthOf") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Attendance">
                                        <ItemTemplate>
                                            <asp:Label ID="Label27" runat="server" Text='<%# Eval("Attendance") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Attendance_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlAttendanceA" Width="50px" DefaultMessage="Please Select" ToolTip="Select Attitude Performance" runat="server" SelectedValue='<%# Eval("Attendance_A") %>' SelectedText='<%# Eval("Attendance_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Attitude">
                                        <ItemTemplate>
                                            <asp:Label ID="Label28" runat="server" Text='<%# Eval("Attitude") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Attitude_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlAttitudeA" Width="50px" DefaultMessage="Please Select" ToolTip="Select Attitude Performance" runat="server" SelectedValue='<%# Eval("Attitude_A") %>' SelectedText='<%# Eval("Attitude_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CustomerCentric">
                                        <ItemTemplate>
                                            <asp:Label ID="Label29" runat="server" Text='<%# Eval("CustomerCentric") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CustomerCentric_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlCustomerCentricA" Width="50px" DefaultMessage="Please Select" ToolTip="Select CustomerCentric Performance" runat="server" SelectedValue='<%# Eval("CustomerCentric_A") %>' SelectedText='<%# Eval("CustomerCentric_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MeetingDeadlines">
                                        <ItemTemplate>
                                            <asp:Label ID="Label30" runat="server" Text='<%# Eval("MeetingDeadlines") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MeetingDeadlines_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlMeetingDeadlinesA" Width="50px" DefaultMessage="Please Select" ToolTip="Select MeetingDeadlines Performance" runat="server" SelectedValue='<%# Eval("MeetingDeadlines_A") %>' SelectedText='<%# Eval("MeetingDeadlines_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Communication">
                                        <ItemTemplate>
                                            <asp:Label ID="Label31" runat="server" Text='<%# Eval("Communication") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Communication_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlCommunicationA" Width="50px" DefaultMessage="Please Select" ToolTip="Select Communication Performance" runat="server" SelectedValue='<%# Eval("Communication_A") %>' SelectedText='<%# Eval("Communication_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="QualityOfWork">
                                        <ItemTemplate>
                                            <asp:Label ID="Label32" runat="server" Text='<%# Eval("QualityOfWork") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="QualityOfWork_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlQualityOfWorkA" Width="50px" DefaultMessage="Please Select" ToolTip="Select QualityOfWork Performance" runat="server" SelectedValue='<%# Eval("QualityOfWork_A") %>' SelectedText='<%# Eval("QualityOfWork_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Learning">
                                        <ItemTemplate>
                                            <asp:Label ID="Label33" runat="server" Text='<%# Eval("Learning") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Learning_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlLearningA" Width="50px" DefaultMessage="Please Select" ToolTip="Select Learning Performance" runat="server" SelectedValue='<%# Eval("Learning_A") %>' SelectedText='<%# Eval("Learning_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Participation">
                                        <ItemTemplate>
                                            <asp:Label ID="Label34" runat="server" Text='<%# Eval("Participation") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Participation_A">
                                        <ItemTemplate>
                                            <telerik:RadDropDownList ID="ddlParticipationA" Width="50px" DefaultMessage="Please Select" ToolTip="Select Participation Performance" runat="server" SelectedValue='<%# Eval("Participation_A") %>' SelectedText='<%# Eval("Participation_A") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem runat="server" Text="1" />
                                                    <telerik:DropDownListItem runat="server" Text="2" />
                                                    <telerik:DropDownListItem runat="server" Text="3" />
                                                    <telerik:DropDownListItem runat="server" Text="4" />
                                                    <telerik:DropDownListItem runat="server" Text="5" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="StaffSuggestion" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="TextBox1" runat="server" Enabled="false" Text='<%# Eval("StaffSuggestion") %>' TextMode="MultiLine"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="StaffRemarks" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="txtStaffRemarks" runat="server" Enabled="false" Text='<%# Eval("StaffRemarks") %>' TextMode="MultiLine"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GoodWorkDone" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="txtGoodworkdone" runat="server" Enabled="false" Text='<%# Eval("GoodWorkDone") %>' TextMode="MultiLine"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GoodWorkDoneByAnother" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="txtGoodworkdonebyanother" runat="server" Enabled="false" Text='<%# Eval("Goodworkdonebyanother") %>' TextMode="MultiLine"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="Label35" runat="server" ToolTip="Average by Yourself" Text='<%# Eval("Average") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Average_A" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="Label36" runat="server" Font-Names="Verdana" ToolTip="Average by Reporting head" Text='<%# Eval("Average_A") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="AdminRemarks_A" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <telerik:RadTextBox ID="txtAdminRemarks" Font-Names="Verdana" Width="300px" runat="server" ToolTip="Enter your feedback.Max 480" Height="60px" Text='<%# Eval("AdminRemarks_A") %>' TextMode="MultiLine" MaxLength="480"></telerik:RadTextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="LinkButton1" runat="server" Font-Names="Verdana" ForeColor="Blue" CssClass="btnMainpage" Width="70px" OnClientClick="javascript:return chkconfirm()" Enabled='<%# Eval("Flag").ToString() != "N" %>' Visible='<%# Eval("Flag").ToString() != "N" %>' CausesValidation="False" CommandArgument='<%# Eval("RSN") %>' CommandName="DUpdate" Text="Save" ToolTip="Click here to save your assess performance details and not to be submit your appraiser"></asp:Button>
                                            <asp:Button ID="LinkButton2" runat="server" Font-Names="Verdana" ForeColor="Blue" CssClass="btnMainpage" Width="70px" OnClientClick="javascript:return chkconfirm()" Enabled='<%# Eval("Flag").ToString() == "N" %>' Visible='<%# Eval("Flag").ToString() == "N" %>' CausesValidation="False" CommandArgument='<%# Eval("RSN") %>' CommandName="FUpdate" Text="Save" ToolTip="Click here to save your assess performance details and not to be submit your appraiser"></asp:Button>
                                            <%--<asp:Button ID="LinkButton4" runat="server" ForeColor="Blue" BackColor="Gray" Width="60px" OnClientClick="javascript:return chkconfirm()" Enabled='<%# Eval("Flag").ToString() != "N" %>' Visible='<%# Eval("Flag").ToString() != "N" %>' CausesValidation="False" CommandArgument='<%# Eval("RSN") %>' CommandName="ConfirmUpdate" Text="Submit" ToolTip="Click here to submit your assess performance details to your appraiser"></asp:Button>--%>
                                            <asp:Button ID="LinkButton4" runat="server" Font-Names="Verdana" ForeColor="Blue" CssClass="btnMainpage" Width="70px" OnClientClick="javascript:return submitconfirm()" CausesValidation="False" CommandArgument='<%# Eval("RSN") %>' CommandName="ConfirmUpdate" Text="Submit" ToolTip="Click here to submit your assess performance details to your appraiser"></asp:Button>
                                        </ItemTemplate>
                                        <%-- <ControlStyle CssClass="btnReportpage" Width="50px" /--%>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </td>
                        <td valign="top" rowspan="5" style="width: 40%;">
                            <br />
                            <asp:Label ID="Label50" runat="server" Text="If you click on save the assessment details will only be saved and will not be submitted to the appraisee." Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                            <br />
                            <br />
                            <asp:Label ID="Label51" runat="server" Text="If you click submit the performance assessment will be sent to the appraisee." Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                        </td>
                        <td align="right" valign="top" style="width: 10%;">
                            <asp:LinkButton ID="lbtneditCancel" runat="server" CssClass="buttonClass" Font-Size="Small" Font-Names="verdana" Text="Back to List" ToolTip="Click here to go back appraisals home page." OnClick="lbtneditCancel_Click"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="center">
                            <asp:Button ID="btnTestSubmit" runat="server" Visible="false" OnClientClick="javascript:return submitconfirm()" Text="Submit" CssClass="button_example" OnClick="btnTestSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="dvAdd" runat="server" style="border-style: solid; background-color: beige; border-width: 3px; min-height: 500px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px;">
                <div runat="server" style="text-align: left;">
                </div>
                <table align="center" title="Add Assess Performance Details">
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Label ID="Label1" runat="server" Text="Assess Performance Details" Font-Size="Large"
                                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td align="right">
                            <asp:LinkButton ID="lbtnAddCancel" runat="server" CssClass="buttonClass" Text="Back to List" Font-Names="Verdana" Font-Size="Small" ToolTip="Click here to go back appraisals home page." OnClick="lbtnAddCancel_Click"></asp:LinkButton>
                            <%--<asp:Button ID="btndvAddCancel" runat="server" Text="Back to List" CssClass="btnReportpage" ToolTip="Click Here to Back to List" OnClick="btndvAddCancel_Click" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblName" Font-Names="Verdana" Font-Size="Small" runat="server" Text="Staff Name "></asp:Label>
                            <asp:Label ID="lblNameerror" Font-Names="Verdana" Font-Size="Small" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            :
                        </td>
                        <td>
                            <%--<telerik:RadDropDownList ID="ddlStaffName" Font-Names="Verdana" Font-Size="Small" ToolTip="This is your username" runat="server"></telerik:RadDropDownList>--%>
                            <asp:Label ID="LblStaffName" runat="server" Text="" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label2" runat="server" Font-Names="Verdana" Text="For Month Of " Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label20" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlMonth" Visible="false" Font-Names="Verdana" Font-Size="Small" ToolTip="Month Showing Invalid Means Please Check your System Date" runat="server">
                            </telerik:RadDropDownList>
                            <asp:Label ID="lblMonth" runat="server" Font-Names="Verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblMonthYear" runat="server" Font-Names="Verdana" ForeColor="Gray" Font-Size="Small"></asp:Label>
                            <asp:TextBox ID="txtMonth" runat="server" Font-Names="Verdana" Visible="false"></asp:TextBox>
                        </td>                        
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label3" runat="server" Text="Attendance " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label14" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlAttendance" AutoPostBack="true" OnSelectedIndexChanged="ddlAttendance_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Attendence performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>                       
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label4" runat="server" Text="Attitude " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label23" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlAttitude" AutoPostBack="true" OnSelectedIndexChanged="ddlAttitude_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Attitude performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label5" runat="server" Text="Customer Centric " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label37" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlcustomercentric" AutoPostBack="true" OnSelectedIndexChanged="ddlcustomercentric_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Customer Centric performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label7" runat="server" Text="Meeting Deadlines " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label38" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlMeeting" AutoPostBack="true" OnSelectedIndexChanged="ddlMeeting_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Meeting Deadlines performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label8" runat="server" Text="Communication " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label39" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlCommunication" AutoPostBack="true" OnSelectedIndexChanged="ddlCommunication_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Communication performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label9" runat="server" Text="Quality of Work " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label40" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlQuality" AutoPostBack="true" OnSelectedIndexChanged="ddlQuality_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Quality performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label10" runat="server" Text="Learning " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label41" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlLearning" AutoPostBack="true" OnSelectedIndexChanged="ddlLearning_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Learning performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label11" runat="server" Text="Participation " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label42" runat="server" Font-Names="Verdana" Text="*" ForeColor="Red" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlparticipation" AutoPostBack="true" OnSelectedIndexChanged="ddlparticipation_SelectedIndexChanged" Font-Names="Verdana" Font-Size="Small" ToolTip="Select your Participation performance" runat="server">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Text="1" Value="1" Selected="true" />
                                    <telerik:DropDownListItem runat="server" Text="2" Value="2" />
                                    <telerik:DropDownListItem runat="server" Text="3" Value="3" />
                                    <telerik:DropDownListItem runat="server" Text="4" Value="4" />
                                    <telerik:DropDownListItem runat="server" Text="5" Value="5" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            <asp:Label ID="Label49" runat="server" Text="Average : " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblAssessAvg" runat="server" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller" ForeColor="DarkBlue"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label16" runat="server" Text="Staff Suggestion   " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label45" runat="server" Text="*" ForeColor="Red" Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtStaffSugg" MaxLength="480" runat="server" TextMode="MultiLine" Font-Names="Verdana" Font-Size="Small" ToolTip="Please provide your Suggestions.Max 480." Height="50px" Width="300px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label17" runat="server" Text="Staff Remarks " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label21" runat="server" Text="*" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtStaffRemarks" MaxLength="480" runat="server" Height="50px" Font-Names="Verdana" Font-Size="Small" TextMode="MultiLine" ToolTip="Please Enter Your Remarks.Max 480." Width="300px"></telerik:RadTextBox>
                        </td>                       
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="Label18" runat="server" Text="Good Work Done  " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label44" runat="server" Text="*" ForeColor="Red" Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtGoodWorkDone" MaxLength="480" runat="server" Font-Names="Verdana" Font-Size="Small" TextMode="MultiLine" Height="50px" Width="300px" ToolTip="Please Enter Your Good Work Details done by you.Max 480."></telerik:RadTextBox>
                        </td>
                         <td>
                            <asp:Label ID="lblsavemsg" runat="server" Text="If you click on SAVE button,the edited appraisal details will only be saved.but not submitted to your appraiser." Font-Names="Verdana" Font-Size="Smaller" ForeColor="Gray"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="text-wrap:inherit;">
                            <asp:Label ID="Label19" runat="server" Text="Good Work DoneBy Another " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="Label22" runat="server" Text="*" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            :
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtGoodbyAnother" MaxLength="480" runat="server" Font-Names="Verdana" TextMode="MultiLine" Font-Size="Small" Height="50px" Width="300px" ToolTip="Please provide details of Good Work Done by Another.Max 480."></telerik:RadTextBox>
                        </td>
                         <td>
                            <asp:Label ID="Label48" runat="server" Text="If you click on SUBMIT,the appraisal will be submitted to your appraiser for review.No more changes can be performed." Font-Names="Verdana" Font-Size="Smaller" ForeColor="Gray"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Width="100px" Text="Save" CommandArgument="Add" Font-Names="Verdana" Font-Size="Small" CssClass="btnReportpage" OnClientClick="javascript:return chkconfirm()" OnClick="btnSubmit_Click" ToolTip="Click here to save your performance details and not to be submitted your appraiser" />
                          
                         <asp:Button ID="Button1" runat="server" Width="100px" Text="Submit" Font-Names="Verdana" Font-Size="Small" OnClientClick="javascript:return validate()" CssClass="btnReportpage" OnClick="Button1_Click" ToolTip="Click here to submit your performance details to your appriser" Visible="False" />
                            
                            <asp:Button ID="btnClear" runat="server" Width="80px" Text="Clear" Font-Names="Verdana" Font-Size="Small" CssClass="btnReportpage" OnClick="btnClear_Click" ToolTip="" />
                        </td>
                    </tr>
                </table>

            </div>
            <div align="center" id="dvpreview" runat="server" style="border-style: solid; background-color: beige; min-height: 500px; border-width: 3px; border-color: blue; font-family: Verdana; border-radius: 10px; padding: 10px 20px;">
                <table>
                    <tr>
                        <td>
                            <asp:GridView ID="gvPreview" CssClass="rounded_corners" runat="server" AutoGenerateColumns="true" Width="263px" Font-Names="Verdana" Font-Size="Small">
                                <RowStyle BackColor="#EFF3FB" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Button runat="server" Width="100px" Text="Continue" Font-Names="Verdana" Font-Size="Small" CssClass="btnReportpage" ID="btnPContinue" OnClick="btnPContinue_Click" ToolTip="Click Here To Proceed " />
                            &nbsp;
                 <asp:Button runat="server" Width="100px" Text="Cancel" Font-Names="Verdana" Font-Size="Small" CssClass="btnReportpage" ID="btnpCancel" OnClick="btnpCancel_Click" ToolTip="Click Here to Cancel" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress AssociatedUpdatePanelID="upAssess" ID="upprogress" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Image ID="imgProgress" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
