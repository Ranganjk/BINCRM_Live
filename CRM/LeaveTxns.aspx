<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveTxns.aspx.cs" Inherits="LeaveTxns" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="css/element.css" rel="stylesheet" />
    <link href="css/Leavestyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <div>
        <div>
            <table style="width: 100%">

                <tr>
                    <td align="left" style="width: 80%;">

                        <asp:Button ID="BtnViewAll" CssClass="btn" runat="server" Text="View All" OnClick="BtnViewAll_Click" Visible="false" ToolTip="Click here for view all leave transactions" />
                        <asp:Button ID="BtnAppliedByMe" CssClass="btn" runat="server" Text="By Me" OnClick="BtnAppliedByMe_Click" Visible="false" ToolTip="Click here for view the leave transactions which are applied by me" />

                        <asp:Button ID="BtnHolidays" CssClass="btn" runat="server" Text="Holidays" OnClick="BtnHolidays_Click" Visible="false" ToolTip="Click here for holiday details" />
                        <asp:Button ID="BtnLvCredit" CssClass="btn" runat="server" Text="Leave Credit" OnClick="BtnLvCredit_Click" Visible="false" ToolTip="Click here for leave credit details" Style="width: 110px;" />
                        <asp:Button ID="BtnBack" CssClass="btn" runat="server" Text="Back" OnClick="BtnBack_Click" Visible="true" ToolTip="Click here to go to back" />

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
        <h4 style="margin-top: -5px;">
            <asp:Label ID="LblHeader" runat="server" Text="Leave Transaction Details"></asp:Label></h4>
        <%--<telerik:RadGrid runat=server ID="RGAssignMe" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" Skin="WebBlue"
                        OnItemCommand="RGAssignMe_ItemCommand" OnPageIndexChanged="RGAssignMe_PageIndexChanged" OnPageSizeChanged="RGAssignMe_PageSizeChanged">
                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" style="font-family:Verdana;">
                            <PagerStyle Mode="NextPrevAndNumeric" />--%>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="From Date"></asp:Label>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="TxtFrmDate" runat="server" CssClass="TxtBox" ToolTip="Select the leave from date" PlaceHolder="From Date" OnTextChanged="TxtFrmDate_TextChanged" AutoPostBack="true" ></asp:TextBox></td>
                            <td>
                                <asp:ImageButton ID="ImgBtnCal" Width="30px" Height="30px" runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date" /></td>
                            <td>
                                <cc1:calendarextender id="CalLeaveFrmDate" format="dd-MMM-yyyy ddd" targetcontrolid="TxtFrmDate" popupbuttonid="ImgBtnCal" runat="server"></cc1:calendarextender>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="To Date"></asp:Label>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="TxtToDate" runat="server" CssClass="TxtBox" ToolTip="Select the leave to date" PlaceHolder="To Date" ></asp:TextBox></td>
                            <td>
                                <asp:ImageButton ID="ImgBtnCal1" Width="30px" Height="30px" runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date" /></td>
                            <td>
                                <cc1:calendarextender id="CalLeaveToDate" format="dd-MMM-yyyy ddd" targetcontrolid="TxtToDate" popupbuttonid="ImgBtnCal1" runat="server"></cc1:calendarextender>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <asp:Button ID="BtnView" runat="server" Text="View" ToolTip="Click here for view the leave details" CssClass="btn" OnClick="BtnView_Click" OnClientClick="return checkDate();" />
                </td>
            </tr>
        </table>
        <telerik:RadGrid ID="RGTxns" runat="server" AutoGenerateColumns="false" GridLines="Vertical" Skin="WebBlue" OnItemCommand="RGTxns_ItemCommand" OnPageIndexChanged="RGTxns_PageIndexChanged" OnPageSizeChanged="RGTxns_PageSizeChanged">
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView NoMasterRecordsText="No Record Found!" FilterItemStyle-Width="50px" Style="font-family: Verdana;" ShowFooter="true" AllowPaging="true" AllowSorting="true" AllowFilteringByColumn="true">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                <NoRecordsTemplate>
                    No Record Found
                </NoRecordsTemplate>
                <Columns>
                    <telerik:GridBoundColumn DataField="LeaveId" HeaderText="Leave Id" UniqueName="LeaveId" SortExpression="LeaveId"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <telerik:GridBoundColumn DataField="StaffName" HeaderText="Staff Name" UniqueName="StaffName" SortExpression="StaffName" />
                    <telerik:GridBoundColumn DataField="LeaveType" HeaderText="Leave Type" UniqueName="LeaveType" SortExpression="LeaveType" />
                    <telerik:GridBoundColumn DataField="LeaveStart" HeaderText="Start Date" UniqueName="LeaveStart" SortExpression="LeaveStart"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <telerik:GridBoundColumn DataField="ReturnDate" HeaderText="Return Date" UniqueName="ReturnDate" SortExpression="ReturnDate"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <telerik:GridBoundColumn DataField="LeaveDays" HeaderText="Total No.of Leave(s)" UniqueName="LeaveDays" SortExpression="LeaveDays"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status" SortExpression="Status" />
                    <telerik:GridBoundColumn DataField="Reason" HeaderText="Reason" UniqueName="Reason" SortExpression="Reason" />
                    <%--<telerik:GridBoundColumn DataField="ApprovedBy" HeaderText="Approved By" UniqueName="ApprovedBy" SortExpression="ApprovedBy" />
                    <telerik:GridBoundColumn DataField="ApprovedDate" HeaderText="Approved On" UniqueName="ApprovedDate" SortExpression="ApprovedDate" />--%>
                    <telerik:GridBoundColumn DataField="TxnType" HeaderText="Txn Type" UniqueName="TxnType" SortExpression="TxnType" />
                    <telerik:GridTemplateColumn AllowFiltering="false">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="LnkTxnView" ToolTip="Click here for view the leave transaction" CommandName='<%# Eval("RSN") %>' CommandArgument='<%# Eval("TxnType") %>' OnClick="LnkTxnView_Click">View</asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="LnkTxnEdit" ToolTip="Click here for edit the leave transaction" CommandName='<%# Eval("LeaveId") %>'
                                 CommandArgument='<%#Eval("Status") %>' OnClick="LnkTxnEdit_Click" ValidationGroup='<%# Eval("StaffID") %>'>Edit</asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="LnkDelete" Visible="false">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="LnkTxnDelete" ToolTip="Click here for delete the leave transaction" OnClick="LnkTxnDelete_Click" CommandName='<%# Eval("RSN") %>' CommandArgument='<%# Eval("TxnType") %>' OnClientClick="return delConfirm();">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

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
                            <asp:Label ID="Label15" runat="server" Text="Applied On"></asp:Label>
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

    </div>
    <br />
    <br />
    <script type="text/javascript">
        function delConfirm() {
            if (confirm("Are you sure, Do you want delete?"))
                return true;
            else
                return false;
        }
        function checkDate()
        {
            var frmDate = document.getElementById('<%= TxtFrmDate.ClientID%>').value;
            var toDate = document.getElementById('<%= TxtToDate.ClientID%>').value;
            if (frmDate == "") {
                alert("Please select the from date!");
                return false;
            }
            else if (toDate == "")
            {
                alert("Please select the to date!");
                return false;
            }
            else
                return true;
        }
    </script>
</asp:Content>

