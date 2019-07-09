<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveApply.aspx.cs" Inherits="LeaveApply" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" Runat="Server">
    <link href="css/element.css" rel="stylesheet" />
    <link href="css/Leavestyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
     <h4 style="padding: 5px; margin-top: -5px;">Edit Leave Details</h4>
        <div class="DivAll">
            <div class="DivLeft">

                <table align="center">
                    <tr>
                        <td style="width: 25%;">Staff Name <span style="color: red;">*</span>
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlStaffid" runat="server" Enabled="false" ToolTip="Select the staff name" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="DdlStaffid_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Leave Type <span style="color: red;">*</span>
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlLeaveType" runat="server" ToolTip="Select the staff leave type" CssClass="ddl"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Leave Start <span style="color: red;">*</span>
                        </td>
                        <td>
                             <table>
                                    <tr >
                                        <td ><asp:TextBox ID="TxtLeaveStart" AutoPostBack="true"  runat="server" Enabled="true" CssClass="TxtBox" ToolTip="Select the leave start date" PlaceHolder="Leave Start Date" OnTextChanged="TxtLeaveStart_TextChanged" onkeypress="CheckType(event);"></asp:TextBox></td>
                                        <td><asp:ImageButton ID="ImgBtnCal" Width="30px" Height="30px"  runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date"/></td>
                                        <td><cc1:CalendarExtender ID="CalLeaveStart" Format="dd-MMM-yyyy ddd" TargetControlID="TxtLeaveStart" PopupButtonID="ImgBtnCal" runat="server"></cc1:CalendarExtender></td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                    <tr>
                        <td>Return Date <span style="color: red;">*</span>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <table>
                                    <tr><td><asp:TextBox ID="TxtReturnDate" AutoPostBack="true" runat="server" Enabled="false" CssClass="TxtBox" ToolTip="Select the return date" PlaceHolder="Return Date" OnTextChanged="TxtReturnDate_TextChanged" onkeypress="CheckType(event);"></asp:TextBox></td>
                                        <td><asp:ImageButton ID="ImgBtnCal1" runat="server" Width="30px" Height="30px" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date"/></td>
                                        <td><cc1:CalendarExtender ID="CalRetDate" Format="dd-MMM-yyyy ddd" PopupButtonID="ImgBtnCal1" TargetControlID="TxtReturnDate" runat="server"></cc1:CalendarExtender></td>
                                    </tr>
                                </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%--  <tr>
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
                   Total No.of Leave(s)<span style="color:red;">*</span>
                </td>
                <td>
                    <asp:TextBox ID="TxtTotDays" runat="server" CssClass="TxtBox" ToolTip="Enter the no.of total days" PlaceHolder="No.of Days"></asp:TextBox>
                </td>
            </tr>--%>
                    <tr>
                        <td>Total No.of Leave(s) <span style="color: red;">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="TxtLeaveDays" Enabled="true" runat="server" CssClass="TxtBox" ToolTip="Enter the no.of leave days" PlaceHolder="No.of Days" onkeypress="CheckDays(event);"></asp:TextBox>
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
                                        <asp:ImageButton ID="ImgBtnSaveTime" Height="30px" Width="30px" runat="server" OnClientClick="return savetime();" ImageUrl="~/Images/savetime2.png" ToolTip="Cilck here for paste reason instead of type" />
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
                            <asp:DropDownList ID="DdlReportTo" runat="server" ToolTip="Choose report head from list" CssClass="ddl"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Status
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlStatus" runat="server" ToolTip="Choose status of leave" CssClass="ddl"></asp:DropDownList>
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
                    <%-- <tr>
                <td>
                   Transaction Type
                </td>
                <td>
                    <asp:DropDownList ID="DdlTxnType" runat="server" ToolTip="Choose leave transaction type" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>--%>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="BtnApply" ToolTip="Click here for apply leave" CssClass="btn" OnClick="BtnApply_Click" runat="server" Text="Save" />
                            <asp:Button ID="BtnCancel" ToolTip="Click here for close the window" CssClass="btn" runat="server" Text="Close" OnClick="BtnCancel_Click" />
                            <asp:Button ID="BtnAdd" Visible="false" ToolTip="Click here for add the leave transaction" CssClass="btn" runat="server" Text="Add" OnClick="BtnAdd_Click" />
                        </td>
                    </tr>
                </table>
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
                            <td class="auto-style1">
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
                    <h4>Holidays</h4>
                    <asp:Label ID="LblHolidays" runat="server" Text=""></asp:Label>
                </div>

                <br />
                <div class="DivLvApp">
                    <h4>Leave Applied</h4>
                    <asp:Label ID="LblLvApp" runat="server" Text=""></asp:Label>
                </div>


            </div>
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
                                        <asp:TextBox ID="txtInfo" runat="server" Width="200px" MaxLength="80"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnSTSave" runat="server" Text="Save" CssClass="btnSmall" OnClick="btnSTSave_Click"
                                            ToolTip="Write a sentence to be added to the PickList and click Save." OnClientClick="return SaveReason();" />
                                        <asp:Button ID="btnSTClear" runat="server" Text="Clear" CssClass="btnSmall" OnClick="btnSTClear_Click" ToolTip="Click to Clear what you have written above." />
                                        <asp:Button ID="btnSTClose" runat="server" Text="Close" CssClass="btnSmall" OnClick="btnSTClose_Click" ToolTip="Clickto return back to previous page." />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">

                                        <asp:GridView ID="gvSaveTime" runat="server" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField HeaderText="PickList" DataField="Reason" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                    HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Calibri"
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
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </telerik:RadWindow>
        </div>
       
        <script type="text/javascript">
            function validate() {
                if (confirm("Are you sure, Do you want apply leave?")) {
                    var staffid = document.getElementById('<%=DdlStaffid.ClientID%>').value;
                    var leavetype = document.getElementById('<%=DdlLeaveType.ClientID%>').value;
                    var leavestart = document.getElementById('<%=TxtLeaveStart.ClientID%>').value;
                    var retdate = document.getElementById('<%=TxtReturnDate.ClientID%>').value;
                    var reportid = document.getElementById('<%=DdlReportTo.ClientID%>').value;
                    var lvDays = document.getElementById('<%=TxtLeaveDays.ClientID%>').value;
                    var reason = document.getElementById('<%=TxtReason.ClientID%>').value;
                    var status = document.getElementById('<%=DdlStatus.ClientID%>').value;

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
                    else {
                        return true;
                    }
                }
                else {
                    return false;
                }
            }
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
                alert("Please select the reason then click add icon!");
            else
                document.getElementById('<%= TxtReason.ClientID%>').value = reason;
            return true;
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
            function CheckDays(e) {
                if (window.event) {
                    if ((e.keyCode < 48 || e.keyCode > 57) & e.keyCode != 8 & e.keyCode != 46) {
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
</asp:Content>

