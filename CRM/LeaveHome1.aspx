<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveHome1.aspx.cs" Inherits="LeaveHome1" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">

    <script src="//code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>

    <link href="css/element.css" rel="stylesheet" />
    <link href="css/Leavestyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">


    <script type="text/javascript">
        $(document).ready(function () {
            $('#Tab1').fadeIn(function () {
                $('#DivUser').appendTo('#leaveAdmin');
                $("#DivUser").show();
            });
        });
        </script>
    <script type="text/javascript">

        function SaveReason() {
            var reason = document.getElementById("<%# txtInfo.ClientID%>").value;
            if (reason == "") {
                alert("Enter the reason then click save!")
                return false;
            }
            else
                return true;
        }
        function savetime() {
            var reason = document.getElementById('<%= DdlExistReason.ClientID%>').value;
            if (reason == "")
                alert("Please select the reason then click the icon!");
            else
                document.getElementById('<%= TxtReason.ClientID%>').value = reason;
        }
        function validate() {
            if (confirm("Are you sure, Do you want to save?")) {
                var staffid = document.getElementById('<%=DdlStaffid.ClientID%>').value;
                var leavetype = document.getElementById('<%=DdlLeaveType.ClientID%>').value;
                var leavestart = document.getElementById('<%=TxtLeaveStart.ClientID%>').value;
                var retdate = document.getElementById('<%=TxtReturnDate.ClientID%>').value;
                <%--var endDate = document.getElementById('<%=TxtLeaveEndDate.ClientID%>').value;--%>
                var reportid = document.getElementById('<%=DdlReportTo.ClientID%>').value;
                var lvDays = document.getElementById('<%=TxtLeaveDays.ClientID%>').value;
               <%-- var totDays = document.getElementById('<%=TxtTotDays.ClientID%>').value;--%>
                var reason = document.getElementById('<%=TxtReason.ClientID%>').value;
                var status = document.getElementById('<%=DdlStatus.ClientID%>').value;
                var Userid = document.getElementById('<%=hfUserId.ClientID %>').value;
                var cl = document.getElementById('<%= LblCasualLeave.ClientID%>').value;
                var el = document.getElementById('<%= LblEarnLeave.ClientID%>').value;
                var sl = document.getElementById('<%= LblSickLeave.ClientID%>').value;

                if (staffid == 0) {
                    alert("Please select the staff name");
                    return false;
                }
                else if (leavetype == 0) {
                    alert("Please select the leave type");
                    return false;
                }
                else if (leavestart == "") {
                    alert("Please select the leave date");
                    return false;
                }
                else if (retdate == "") {
                    alert("Please select the return date");
                    return false;
                }
                    //else if (retdate == "") {
                    //    alert("Please select the leave end date");
                    //    return false;
                    //}
                else if ((lvDays == "") || (lvDays == "0")) {
                    alert("Please enter the no.of leave days");
                    return false;
                }
                    //else if ((totDays == "") || (totDays == "0")) {
                    //    alert("Please enter the no.of total days");
                    //    return false;
                    //}
                else if (reportid == 0) {
                    alert("Please select the report head");
                    return false;
                }
                else if (reason == "") {
                    alert("Please enter the reason");
                    return false;
                }
                else if (status == 0) {
                    alert("Please select the status");
                    return false;
                }
                //else if (Userid == staffid) {
                //    alert("You are not able to Approve/Cancel/Reject the leave itself");
                //    return false;
                //}
                //else if (leavetype == "CL") {
                //    if (cl >= lvDays) {
                //        alert("No.of casual leave are less than the no.of leave days. So you are not able to apply casual leave");
                //        return false;
                //    }
                //}
                //else if (leavetype == "EL") {
                //    if (el >= lvDays) {
                //        alert("No.of earn leave are less than the no.of leave days. So you are not able to apply earn leave");
                //        return false;
                //    }
                //}
                //else if (leavetype == "SL") {
                //    if (sl >= lvDays) {
                //        alert("No.of sick leave are less than the no.of leave days. So you are not able to apply sick leave");
                //        return false;
                //    }
                //}
                else {
                    return true;
                }
            }
            else {
                return false;
            }
        }

       <%-- function validate1() {
            if (confirm("Are you sure, Do you want apply leave?")) {
                var staffid = document.getElementById('<%=DdlStaffid1.ClientID%>').value;
               var leavetype = document.getElementById('<%=DdlLeaveType1.ClientID%>').value;
                var leavestart = document.getElementById('<%=TxtLeaveStart1.ClientID%>').value;
                var retdate = document.getElementById('<%=TxtReturnDate1.ClientID%>').value;
                var endDate = document.getElementById('<%=TxtLeaveEndDate1.ClientID%>').value;
                var reportid = document.getElementById('<%=DdlReportTo1.ClientID%>').value;
                var lvDays = document.getElementById('<%=TxtLeaveDays1.ClientID%>').value;
                var totDays = document.getElementById('<%=TxtTotDays1.ClientID%>').value;
                var reason = document.getElementById('<%=TxtReason1.ClientID%>').value;
                var status = document.getElementById('<%=DdlStatus1.ClientID%>').value;

                if (staffid == 0) {
                    alert("Please select the staff name");
                    return false;
                }
                else if (staffid == 0) {
                    alert("Please select the leave type");
                    return false;
                }
                else if (leavestart == "") {
                    alert("Please select the leave date");
                    return false;
                }
                else if (retdate == "") {
                    alert("Please select the return date");
                    return false;
                }
                else if (retdate == "") {
                    alert("Please select the leave end date");
                    return false;
                }
                else if ((lvDays == "") || (lvDays == "0")) {
                    alert("Please enter the no.of leave days");
                    return false;
                }
                else if ((totDays == "") || (totDays == "0")) {
                    alert("Please enter the no.of total days");
                    return false;
                }
                else if (reportid == 0) {
                    alert("Please select the report head");
                    return false;
                }
                else if (reason == "") {
                    alert("Please enter the reason");
                    return false;
                }
                else if (status == 0) {
                    alert("Please select the status");
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                return false;
            }
        }--%>

        function cnfmDel() {
            if (confirm("Are you sure, Do you want delete?"))
                return true;
            else
                return false;
        }
        function cnfmSignout() {
            if (confirm("Are you sure, Do you want Sign out?"))
                return true;
            else
                return false;
        }
        function CheckType(e) {

            if (window.event) // IE 
            {
                event.returnValue = false;
                return false;
            }
            else { // Fire Fox
                e.preventDefault();
                return false;

            }
        }
        function CheckDays(e)
        {
            if (window.event) {
                if ((e.keyCode < 48 || e.keyCode > 57) & e.keyCode != 8 & e.keyCode!=46) {
                    event.returnValue = false;
                    return false;

                }
            }
            else { // Fire Fox
                if ((e.which < 48 || e.which > 57) & e.which != 8 & e.keyCode != 46) {
                    e.preventDefault();
                    return false;

                }
            }
        }
    </script>
    <div>
        <%--<cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></cc1:ToolkitScriptManager>--%>
        <%--<p style="direction:rtl">
            <asp:Button ID="BtnSignout" CssClass="btn" runat="server" Text="Sign Out" OnClientClick="return cnfmSignout();" OnClick="BtnSignout_Click" ToolTip="Click here for exit from the system"/>
            <asp:Button ID="BtnTxns" CssClass="btn" runat="server" Text="Leave Txn" OnClick="BtnTxns_Click" Tooltip="Click here for view leave transaction" />
            <asp:Button ID="BtnLeaveApply" CssClass="btn" runat="server" Text="Leave Apply" OnClientClick="OpenLeaveApp();" Tooltip="Click here for apply leave" />
            </p>--%>
        <div>
            <table style="width: 100%">

                <tr>
                    <td align="left" style="width: 80%;">
                        <asp:Button ID="BtnViewAll" CssClass="btn" runat="server" Text="View All" OnClick="BtnViewAll_Click" Visible="false" ToolTip="Click here for view all leave transactions" />
                        <asp:Button ID="BtnAppliedByMe" CssClass="btn" runat="server" Text="By Me" OnClick="BtnAppliedByMe_Click" Visible="false" ToolTip="Click here for view the leave transactions which are applied by me" />
                        <asp:Button ID="BtnHolidays" CssClass="btn" runat="server" Text="Holidays" OnClick="BtnHolidays_Click" Visible="false" ToolTip="Click here for holiday details" />
                        <asp:Button ID="BtnLvCredit" CssClass="btn" runat="server" Text="Leave Credit" OnClick="BtnLvCredit_Click" Visible="false" ToolTip="Click here for leave credit details" Style="width: 110px;" />

                    </td>
                    <td align="right" style="width: 5%;">
                        <asp:ImageButton ID="ImageButton2" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png" ToolTip="Click here to return back to home" />
                    </td>
                    <td style="width: 2%;" align="right" valign="middle">
                        <asp:Label ID="lblHome" Height="10px" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server" />
                    </td>
                    <td style="width: 3%;" align="right">
                        <asp:ImageButton ID="ImageButton1" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                    </td>
                    <td style="width: 5%;" align="left" valign="middle">
                        <asp:Label ID="lbSignOut" Height="10px" Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                    </td>
                </tr>
            </table>
        </div>

        <div id="DivByMeUser" runat="server">


            <div id="DivUser" style="visibility: visible;">
                <%-- <p style="direction:rtl">
            <asp:Button ID="BtnLeaveTxns" CssClass="btn" runat="server" Text="Applied By Me" OnClick="BtnLeaveTxns_Click" Tooltip="Click here for view leave transaction" />
            </p>--%>
                <div class="DivLeft">
                    <h3>Apply Leave</h3>
                    <table align="center" style="width: 98%;">

                        <tr>
                            <td style="width: 25%;">Staff Name <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DdlStaffid" runat="server" AutoPostBack="true" ToolTip="Select the staff name" CssClass="ddl" OnSelectedIndexChanged="DdlStaffid_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Leave Type <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DdlLeaveType" runat="server" ToolTip="Select the leave type" CssClass="ddl"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Leave Start <span style="color: red;">*</span>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="TxtLeaveStart" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave start date" PlaceHolder="Leave Start Date" onkeypress="CheckType(event);" OnTextChanged="TxtLeaveStart_TextChanged"></asp:TextBox></td>
                                        <td>
                                            <asp:ImageButton ID="ImgBtnCal" Width="30px" Height="30px" runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date" /></td>
                                        <%--<td><cc1:CalendarExtender ID="CalLeaveStart" Format="dd-MMM-yyyy" TargetControlID="TxtLeaveStart" PopupButtonID="ImgBtnCal" runat="server"></cc1:CalendarExtender></td>--%>
                                        <td>
                                            <cc1:CalendarExtender ID="CalLeaveStart" Format="dd-MMM-yyyy ddd" TargetControlID="TxtLeaveStart" PopupButtonID="ImgBtnCal" runat="server"></cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                </table>

                            </td>
                        </tr>
                        <tr>
                            <td>Return Date <span style="color: red;">*</span>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="TxtReturnDate" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the return date" PlaceHolder="Return Date" onkeypress="CheckType(event);" OnTextChanged="TxtReturnDate_TextChanged"></asp:TextBox></td>
                                        <td>
                                            <asp:ImageButton ID="ImgBtnCal1" runat="server" Width="30px" Height="30px" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date" /></td>
                                        <td>
                                            <cc1:CalendarExtender ID="CalRetDate" Format="dd-MMM-yyyy ddd" PopupButtonID="ImgBtnCal1" TargetControlID="TxtReturnDate" runat="server"></cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <%-- <tr>
                <td>
                    Leave End Date <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtLeaveEndDate" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave end date" PlaceHolder="Return Date" OnTextChanged="TxtReturnDate_TextChanged"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender1" Format="dd-MMM-yyyy" PopupButtonID="TxtLeaveEndDate" TargetControlID="TxtLeaveEndDate" runat="server"></asp:CalendarExtender>
                </td>
            </tr>--%>
                        <%-- <tr>
                <td>
                    Total Days <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtTotDays" runat="server" CssClass="TxtBox" ToolTip="Enter the no.of total days" PlaceHolder="No.of Days"></asp:TextBox>
                </td>
            </tr>--%>
                        <tr>
                            <td>Total no.of Leave(s) <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtLeaveDays" runat="server" Enabled="true" CssClass="TxtBox" ToolTip="Enter the total no.of leave(s)" PlaceHolder="Total no.of Leave(s)"
                                   onkeypress="CheckDays(event);" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Reason <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtReason" runat="server" CssClass="TxtBox" Width="300px" ToolTip="Enter the purpose for leave" PlaceHolder="Purpose for leave" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="DdlExistReason" CssClass="ddl" ToolTip="Select the reason instead of type" runat="server"></asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="ImgBtnSaveTime" Height="30px" Width="30px" runat="server" OnClientClick="savetime();" ImageUrl="~/Images/savetime2.png" ToolTip="Cilck here for paste reason instead of type" />
                                        </td>
                                        <td>
                                            <asp:Button ID="BtnSaveTime" runat="server" CssClass="btn" Text="SaveTime" OnClick="BtnSaveTime_Click" ToolTip="Click here for save the reason for future use" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>Submit To <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DdlReportTo" runat="server" ToolTip="Select report head from list" CssClass="ddl"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Status <span style="color: red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="DdlStatus" runat="server" ToolTip="Select status of leave" CssClass="ddl"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Remarks
                            </td>
                            <td>
                                <asp:TextBox ID="TxtRemarks" ToolTip="Enter the remarks, if any" TextMode="MultiLine" PlaceHolder="Remarks, If any"
                                    CssClass="TxtBox" runat="server" Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                    <asp:Button ID="BtnApply" ToolTip="Click here for apply leave" CssClass="btn" OnClientClick="return validate();" OnClick="BtnApply_Click" runat="server" Text="Apply" />
                                <%--<asp:Button ID="BtnCancel" ToolTip="Click here for cancel the leave apply" CssClass="btn" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />--%>
                            </td>
                        </tr>
                    </table>
                    <telerik:RadWindow ID="rwSaveTime" VisibleOnPageLoad="false" Width="300px" runat="server">
                        <ContentTemplate>
                            <asp:UpdatePanel ID="upSaveTime" runat="server">
                                <ContentTemplate>
                                    <table cellpadding="3">
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblInfo" runat="server" Text="Add to PickList to SaveTime" ForeColor="Blue" Font-Bold="true" Width="160px" CssClass="style2" Font-Names="Calibri"></asp:Label>

                                            </td>
                                        </tr>
                                        <tr>

                                            <td align="center">
                                                <asp:TextBox ID="txtInfo" runat="server" class="TxtBox" ToolTip="Enter the reason for add to PickList"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="center">
                                                <asp:Button ID="btnSTSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSTSave_Click"
                                                    ToolTip="Write a sentence to be added to the PickList and click Save." OnClientClick="return SaveReason();" Style="width: auto" />
                                                <asp:Button ID="btnSTClear" runat="server" Text="Clear" CssClass="btn" Style="width: auto;" OnClick="btnSTClear_Click" ToolTip="Click to Clear what you have written above." />
                                                <asp:Button ID="btnSTClose" runat="server" Text="Close" CssClass="btn" Style="width: auto;" OnClick="btnSTClose_Click" ToolTip="Clickto return back to previous page." />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">

                                                <asp:GridView ID="gvSaveTime" runat="server" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="PickList" DataField="Reason" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Verdana"
                                                            ItemStyle-Width="200px" ItemStyle-ForeColor="Black" HeaderStyle-HorizontalAlign="left" />
                                                    </Columns>
                                                </asp:GridView>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnSTSave" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSTClear" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSTClose" EventName="Click" />
                                    <%-- <asp:AsyncPostBackTrigger ControlID="btnSaveTime" EventName="Click" />--%>
                                </Triggers>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </telerik:RadWindow>

                </div>

                <div class="DivRight">
                    <div class="DivLeave">
                        <h4>No.of Leaves Available for
                            <asp:Label ID="LblStaffname" runat="server" Text=""></asp:Label></h4>
                        <table style="margin-top: -10px;">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Casual Leave"></asp:Label>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="LblCasualLeave" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Earn Leave"></asp:Label>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="LblEarnLeave" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Sick Leave"></asp:Label>
                                </td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="LblSickLeave" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />

                    <div class="DivHolidays">
                        <h4>Holidays (except sunday)</h4>
                        <asp:Label ID="LblHolidays" runat="server" Text=""></asp:Label>
                    </div>
                    <br />
                    <div class="DivLvApp">
                        <h4>Leave Applied</h4>
                        <asp:Label ID="LblLvApp" runat="server" Text=""></asp:Label>
                    </div>

                </div>
            </div>
        </div>


        <div id="divAdmin" runat="server">
            <telerik:RadTabStrip runat="server" ID="TabLeave" MultiPageID="RadMultiPage1" SelectedIndex="0"
                BackColor="#5C90C4" BorderStyle="None" BorderWidth="2px">
                <Tabs>
                    <telerik:RadTab runat="server" Text="To Be Approved" PageViewID="PageView1" Font-Size="13px" id="Tab1"
                        Font-Names="Verdana" ForeColor="Black" Font-Bold="true" ToolTip="Leave is reporting to you" border="1px">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Apply Leave" PageViewID="PageView2" Font-Size="12px" id="Tab2"
                        Font-Names="Verdana" ForeColor="Black" Font-Bold="true" ToolTip="Click here for apply leave">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                <telerik:RadPageView runat="server" ID="PageView1" Selected="true">
                    <br />
                    <telerik:RadGrid runat="server" ID="RGAssignMe" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" Skin="WebBlue"
                        OnItemCommand="RGAssignMe_ItemCommand" OnPageIndexChanged="RGAssignMe_PageIndexChanged" OnPageSizeChanged="RGAssignMe_PageSizeChanged" ShowFooter="false">
                        <GroupingSettings CaseSensitive="false" />
                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" Style="font-family: Verdana;">
                            <PagerStyle Mode="NextPrevAndNumeric" />
                            <Columns>
                                <telerik:GridBoundColumn Display="false" DataField="RSN" />
                                <telerik:GridBoundColumn DataField="StaffName" HeaderText="Staff Name" UniqueName="StaffName" SortExpression="StaffName" AllowFiltering="true" AllowSorting="true" />
                                <telerik:GridBoundColumn DataField="LeaveType" HeaderText="Leave Type" UniqueName="LeaveType" SortExpression="LeaveType" AllowFiltering="true" AllowSorting="true" />
                                <telerik:GridBoundColumn DataField="LeaveStart" HeaderText="Leave Start" UniqueName="LeaveStart" SortExpression="LeaveStart" AllowFiltering="true" AllowSorting="true"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <telerik:GridBoundColumn DataField="ReturnDate" HeaderText="Return Date" UniqueName="ReturnDate" SortExpression="ReturnDate" AllowFiltering="true" AllowSorting="true"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <telerik:GridBoundColumn DataField="LeaveDays" HeaderText="No.of Days" UniqueName="NoofDays" SortExpression="NoofDays" AllowFiltering="true" AllowSorting="true"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <telerik:GridBoundColumn DataField="Reason" HeaderText="Reason" UniqueName="Reason" SortExpression="Reason" AllowFiltering="true" AllowSorting="true" />
                                <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status" SortExpression="Status" AllowFiltering="true" AllowSorting="true" />
                                <%--<telerik:GridBoundColumn DataField="TxnType" HeaderText="Txn Type" UniqueName="TxnType" SortExpression="TxnType" AllowFiltering="true" AllowSorting="true"/>--%>
                                <telerik:GridBoundColumn DataField="C_Date" HeaderText="Apply On" UniqueName="C_Date" SortExpression="C_Date" AllowFiltering="true" AllowSorting="true"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <telerik:GridBoundColumn DataField="C_ID" HeaderText="Apply By" UniqueName="C_ID" SortExpression="C_ID" AllowFiltering="true" AllowSorting="true" />
                                <telerik:GridTemplateColumn AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkView" runat="server" Text="View" CommandName='<%#Eval("RSN")%>' ToolTip="Click here for view the leave details" OnClick="LnkView_Click" />
                                        <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkUpdate" runat="server" Text="Update" CommandName='<%#Eval("RSN")%>' CommandArgument='<%# Eval("StaffId") %>' ToolTip="Click here for update the leave" OnClick="LnkUpdate_Click" />
                                        <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%-- <telerik:GridTemplateColumn AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StaffId") %>' CommandName='<%#Eval("RSN") %>' ToolTip="Click here for delete the leave" OnClick="LnkDelete_Click" OnClientClick="return cnfmDel();"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="PageView2">
                    <br />
                    <div id="leaveAdmin">
                    </div>
                    <%--<div class="DivAll">
            <div class="DivLeft">
                <div class="DivLeave">
                    No.of Leaves Available for <asp:Label ID="LblStaffName1" runat="server" Text=""></asp:Label>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label" runat="server" Text="Casual Leave"></asp:Label>
                            </td>
                            <td>:</td>
                             <td>
                                <asp:Label ID="LblCasualLeave1" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <asp:Label ID="Label7" runat="server" Text="Earn Leave"></asp:Label>
                            </td>
                            <td>:</td>
                             <td>
                                <asp:Label ID="LblEarnLeave1" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <td class="auto-style1">
                                <asp:Label ID="Label9" runat="server" Text="Sick Leave"></asp:Label>
                            </td>
                            <td>:</td>
                             <td>
                                <asp:Label ID="LblSickLeave1" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                       
                    </table>
                </div>
                <br />
                
                <div class="DivHolidays">
                    <asp:Label ID="LblHolidays1" runat="server" Text=""></asp:Label>
                </div>
                     
            </div>

            <div class="DivRight">
                <h3>Leave Apply</h3>
         <table style="width:90%;">
             
            <tr>
                <td>
                    Staff Name <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:DropDownList ID="DdlStaffid1" runat="server" ToolTip="Select the staff name" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Leave Type <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:DropDownList ID="DdlLeaveType1" runat="server" ToolTip="Select the staff leave type" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Leave Start <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtLeaveStart1" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave start date" PlaceHolder="Leave Start Date" OnTextChanged="TxtLeaveStart_TextChanged"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender2"  Format="dd-MMM-yyyy" TargetControlID="TxtLeaveStart1" PopupButtonID="TxtLeaveStart1" runat="server"></asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Return Date <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtReturnDate1" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the return date" PlaceHolder="Return Date" OnTextChanged="TxtReturnDate_TextChanged"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender3" Format="dd-MMM-yyyy" PopupButtonID="TxtReturnDate1" TargetControlID="TxtReturnDate1" runat="server"></asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Leave End Date <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtLeaveEndDate1" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave end date" PlaceHolder="Return Date" OnTextChanged="TxtReturnDate_TextChanged"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender4" Format="dd-MMM-yyyy" PopupButtonID="TxtLeaveEndDate1" TargetControlID="TxtLeaveEndDate1" runat="server"></asp:CalendarExtender>
                </td>
            </tr>
             <tr>
                <td>
                    Total Days <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtTotDays1" runat="server" CssClass="TxtBox" ToolTip="Enter the no.of total days" PlaceHolder="No.of Days"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Leave Days <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtLeaveDays1" runat="server" CssClass="TxtBox" ToolTip="Enter the no.of leave days" PlaceHolder="No.of Days"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Reason <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtReason1" runat="server" CssClass="TxtBox" ToolTip="Enter the purpose for leave" PlaceHolder="Purpose for leave" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                   Submit To <span style="color:red;">*</span>
                </td>
                <td>
                    <asp:DropDownList ID="DdlReportTo1" runat="server" ToolTip="Choose report head from list" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                   Status
                </td>
                <td>
                    <asp:DropDownList ID="DdlStatus1" runat="server" ToolTip="Choose status of leave" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="BtnApply1" ToolTip="Click here for apply leave" CssClass="btn" OnClientClick="return validate1();" OnClick="BtnApply_Click" runat="server" Text="Apply" />
                    <asp:Button ID="BtnCancel1" ToolTip="Click here for cancel the leave apply" CssClass="btn" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />
                </td>
            </tr>
        </table>
    </div>
        </div>--%>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
        <%--<div id="divUser" runat="server">
            <telerik:RadGrid runat="server" ID="RGByMeLeave" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" OnItemCommand="RGByMeLeave_ItemCommand"
                OnPageIndexChanged="RGByMeLeave_PageIndexChanged" OnPageSizeChanged="RGByMeLeave_PageSizeChanged" Skin="WebBlue">
                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" Style="font-family:Verdana;">
                            <PagerStyle Mode="NextPrevAndNumeric" />
                            <Columns>
                                <telerik:GridBoundColumn Display="false" DataField="RSN" />
                                <telerik:GridBoundColumn DataField="StaffId" HeaderText="Staff Id" UniqueName="StaffId" SortExpression="StaffId" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="LeaveType" HeaderText="Leave Type" UniqueName="LeaveType" SortExpression="LeaveType" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="LeaveStart" HeaderText="Leave Start" UniqueName="LeaveStart" SortExpression="LeaveStart" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="ReturnDate" HeaderText="Return Date" UniqueName="ReturnDate" SortExpression="ReturnDate" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="NoofDays" HeaderText="No.of Days" UniqueName="NoofDays" SortExpression="NoofDays" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="Reason" HeaderText="Reason" UniqueName="Reason" SortExpression="Reason" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status" SortExpression="Status" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="C_Date" HeaderText="Apply On" UniqueName="C_Date" SortExpression="C_Date" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="C_ID" HeaderText="Apply By" UniqueName="C_ID" SortExpression="C_ID" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridTemplateColumn AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkEdit" runat="server" Text="Edit" CommandName='<%#Eval("RSN") %>' ToolTip="Click here for edit the leave" OnClick="LnkEdit_Click" />
                                        <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
        <%--</ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering ="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkDelete" runat="server" Text="Delete" CommandName='<%#Eval("RSN") %>' ToolTip="Click here for delete the leave" OnClick="LnkDelete_Click" OnClientClick="return cnfmDel();"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
            </telerik:RadGrid>
                </div>--%>
        <div id="divCeo" runat="server">
            <telerik:RadGrid runat="server" ID="RGAll" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" OnItemCommand="RGAll_ItemCommand"
                OnPageIndexChanged="RGAll_PageIndexChanged" Skin="WebBlue" ShowFooter="false">
                <GroupingSettings CaseSensitive="false" />
                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" Style="font-family: Verdana;">
                    <PagerStyle Mode="NextPrevAndNumeric" />
                    <Columns>
                        <telerik:GridBoundColumn Display="false" DataField="RSN" />
                        <telerik:GridBoundColumn DataField="StaffName" HeaderText="Staff Name" UniqueName="StaffName" SortExpression="StaffName" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="LeaveId" HeaderText="Leave Id" UniqueName="LeaveId" SortExpression="LeaveId" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="40px" />
                        <telerik:GridBoundColumn DataField="LeaveType" HeaderText="Leave Type" UniqueName="LeaveType" SortExpression="LeaveType" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="LeaveStart" HeaderText="Leave Start" UniqueName="LeaveStart" SortExpression="LeaveStart" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn DataField="ReturnDate" HeaderText="Return Date" UniqueName="ReturnDate" SortExpression="ReturnDate" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn DataField="LeaveDays" HeaderText="No.of Days" UniqueName="NoofDays" SortExpression="NoofDays" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="30px" />
                        <telerik:GridBoundColumn DataField="Reason" HeaderText="Reason" UniqueName="Reason" SortExpression="Reason" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status" SortExpression="Status" AllowFiltering="true" AllowSorting="true" />
                        <%--<telerik:GridBoundColumn DataField="C_Date" HeaderText="Apply On" UniqueName="C_Date" SortExpression="C_Date" AllowFiltering="true" AllowSorting="true"/>
                                <telerik:GridBoundColumn DataField="C_ID" HeaderText="Apply By" UniqueName="C_ID" SortExpression="C_ID" AllowFiltering="true" AllowSorting="true"/>--%>
                        <telerik:GridBoundColumn DataField="TxnType" HeaderText="Txn Type" UniqueName="TxnType" SortExpression="TxnType" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkCeoView" runat="server" Text="View" CommandName='<%#Eval("RSN")%>' ToolTip="Click here for view the leave details" OnClick="LnkCeoView_Click" />
                                <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkCeoUpdate" runat="server" Text="Update" CommandName='<%#Eval("RSN")%>' CommandArgument='<%# Eval("StaffId") %>' ToolTip="Click here for update the leave" OnClick="LnkCeoUpdate_Click" />
                                <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <%--<telerik:GridBoundColumn DataField="ReportTo" HeaderText="Submit To" UniqueName="ReportTo" SortExpression="ReportTo" AllowFiltering="true" AllowSorting="true"/>--%>
                        <%--  <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkUpdate" runat="server" Text="Update" CommandName='<%#Eval("RSN") %>' ToolTip="Click here for approve or reject the leave" OnClick="LnkUpdate_Click" />
                                <%--<a href="LeaveApprove.aspx?RSN=<%# Eval("RSN") %>" target="new window" id="LnkReport">
                                <asp:Label ID="Label1" runat="server" Tooltip="Click here for approve or reject the leave">Edit</asp:Label></a>--%>
                        <%-- </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                        <%-- <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkDelete" runat="server" Text="Delete" CommandName='<%#Eval("RSN") %>' ToolTip="Click here for delete the leave" OnClick="LnkDelete_Click" OnClientClick="return cnfmDel();"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:HiddenField ID="HFDiv" runat="server" />
        </div>
        <telerik:RadWindow ID="rwView" runat="server" VisibleOnPageLoad="false" Width="400px" Height="400px">
            <ContentTemplate>
                <h3 style="font-family: Verdana; font-size: 14px; color: #000000;">View leave details</h3>
                <table style="font-family: Verdana; font-size: 12px; color: #000000;">
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Staff Name"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblStaff" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Leave Type"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblLeaveType" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label12" runat="server" Text="Txn Type"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblTxnType" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Leave Start"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblLeaveStart" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label7" runat="server" Text="Return Date"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblRetDate" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label8" runat="server" Text="Total no.of Leave(s)"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblLeaveDays" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Text="Reason"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblReason" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label10" runat="server" Text="Status"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblStatus" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label11" runat="server" Text="Applied By"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblAppliedBy" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label15" runat="server" Text="Apply On"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblApplyOn" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="Approved By"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblApprovedBy" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label16" runat="server" Text="Approved On"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblApprovedOn" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label17" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="LblRemarks" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </telerik:RadWindow>
        <asp:HiddenField ID="hfAppID" runat="server" />
        <asp:HiddenField ID="hfUserId" runat="server" />
    </div>
    <br />
    <br />


</asp:Content>
