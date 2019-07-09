<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveApprove.aspx.cs" Inherits="LeaveApprove" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" Runat="Server">
     <link href="css/element.css" rel="stylesheet" />
    <link href="css/Leavestyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <script type="text/javascript">
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
        <br />
        <div class="DivAll">
            <div class="DivLeft" style="width:70%;">
                <div class="DivLeaveApp">
                <table Style="font-family:Verdana;font-size:12px;color:#000000;">
                     <tr>
                        <td>
                            <asp:Label ID="Label12" runat="server" Text="From Date"></asp:Label>
                        </td>
                        
                        <td>
                            <table>
                                    <tr>
                                        <td><asp:TextBox ID="TxtFromDate" Enabled="false" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave start date" PlaceHolder="From Date" OnTextChanged="TxtFromDate_TextChanged"
                                            onkeypress="CheckType(event);"></asp:TextBox></td>
                                        <td><asp:ImageButton ID="ImgBtnCal" Width="30px" Height="30px"  runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date"/></td>
                                        <td><cc1:CalendarExtender ID="CalFromDate"  Format="dd-MMM-yyyy" TargetControlID="TxtFromDate" PopupButtonID="ImgBtnCal" runat="server"></cc1:CalendarExtender></td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <asp:Label ID="Label13" runat="server" Text="To Date"></asp:Label>
                        </td>
                        
                        <td>
                            <table>
                                    <tr>
                                        <td><asp:TextBox ID="TxtToDate" Enabled="false" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the leave start date" PlaceHolder="To Date" OnTextChanged="TxtToDate_TextChanged" 
                                            onkeypress="CheckType(event);"></asp:TextBox></td>
                                        <td><asp:ImageButton ID="ImgBtnCal1" Width="30px" Height="30px"  runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date"/></td>
                                        <td><cc1:CalendarExtender ID="CalToDate"  Format="dd-MMM-yyyy" TargetControlID="TxtToDate" PopupButtonID="ImgBtnCal1" runat="server"></cc1:CalendarExtender></td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label18" runat="server" Text="Total no.of Leave(s)"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TxtLeaveDays" Enabled="false" runat="server" CssClass="TxtBox"  onkeypress="CheckDays(event);"></asp:TextBox>
                        </td>
                    </tr>
                    
                     <tr>
                <td>
                   Transaction Type
                </td>
                <td>
                    <asp:DropDownList ID="DdlTxnType" runat="server" ToolTip="Choose leave transaction type" CssClass="ddl"></asp:DropDownList>
                </td>
            </tr>
                       <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="BtnSave" ToolTip="Click here for save leave transaction" CssClass="btn"  OnClick="BtnSubmit_Click" runat="server" Text="Submit" />
                    <asp:Button ID="BtnCancel" ToolTip="Click here for cancel" CssClass="btn" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />
                    
                </td>
            </tr>
                    <tr>
                        <td></td>
                        <td><asp:Button ID="BtnAddMore" ToolTip="Click here for save this leave transaction and add more transactions for this leave" CssClass="btn"  OnClick="BtnAddMore_Click" runat="server" Text="Save & Add More" style="width:205px;"/></td>
                    </tr>
                </table>
                    </div>
                <div class="DivLvDet">
                  <table Style="font-family:Verdana;font-size:12px;color:#000000;">
                      <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Staff Name"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblStaff" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Leave Type"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblLeaveType" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Leave Start"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblLeaveStart" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label7" runat="server" Text="Return Date"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblRetDate" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                      <tr>
                        <td>
                            <asp:Label ID="Label8" runat="server" Text="Total no.of Leave(s)"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblLeaveDays" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                      <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Text="Reason"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblReason" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label10" runat="server" Text="Status"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblStatus" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label11" runat="server" Text="Applied By"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblAppliedBy" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label15" runat="server" Text="Applied On"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblApplyOn" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="Approved By"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblApprovedBy" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label16" runat="server" Text="Approved On"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblApprovedOn" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label17" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="LblRemarks" runat="server" Text="-"></asp:Label>
                        </td>
                    </tr>
                  </table>
            </div>
            </div>
            <div class="DivRight">
                  <div class="DivLeave">
                  <h4>No.of Leaves Available for <asp:Label ID="LblStaffname" runat="server" Text=""></asp:Label></h4>
                    <table style="margin-top:-10px;">
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
                    <h4>Holidays</h4>
                    <asp:Label ID="LblHolidays" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
</asp:Content>

