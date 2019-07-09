<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveAllow.aspx.cs" Inherits="LeaveAllow" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

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
                        <asp:Button ID="BtnViewAll" CssClass="btn" runat="server" Text="View All" OnClick="BtnViewAll_Click" Visible="true" ToolTip="Click here for view all leave transactions" />
                        <asp:Button ID="BtnAppliedByMe" CssClass="btn" runat="server" Text="By Me" OnClick="BtnAppliedByMe_Click" Visible="true" ToolTip="Click here for view the leave transactions which are applied by me" />
                        <asp:Button ID="BtnHolidays" CssClass="btn" runat="server" Text="Holidays" OnClick="BtnHolidays_Click" Visible="true" ToolTip="Click here for holiday details" />
                        <asp:Button ID="BtnLvCredit" CssClass="btn" runat="server" Text="Leave Credit" OnClick="BtnLvCredit_Click" Visible="true" ToolTip="Click here for leave credit details" Style="width: 110px;" />
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

        <div style="padding: 5px;">
            <h3>Leave Credit</h3>
            <table style="width: 100%">
                <tr>
                    <td>
                        <table style="width: 50%;">
                            <tr>
                                <td>For Month<span class="ReqStr"> *</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DdlMonth" runat="server" ToolTip="Choose the month" CssClass="ddl"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Staff Name<span class="ReqStr"> *</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DdlStaffId" runat="server" ToolTip="Choose Staff name" CssClass="ddl"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Transaction Type</td>
                                <td>
                                    <asp:RadioButtonList ID="rblLeaveCorD" runat="server">
                                        <asp:ListItem Selected="True" Text="Credit" Value="CT" />
                                        <asp:ListItem Text="Debit" Value="DT" />
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>Casual Leave
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtCasual" runat="server" CssClass="TxtBox" ToolTip="Enter the casual leave" PlaceHolder="Casual Leave"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Earn Leave
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtEarn" runat="server" CssClass="TxtBox" ToolTip="Enter the earn leave" PlaceHolder="Earn Leave"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Sick Leave
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtSick" runat="server" CssClass="TxtBox" ToolTip="Enter the sick leave" PlaceHolder="Sick Leave"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="BtnSave" ToolTip="Click here for save the leave credit details" CssClass="btn" OnClick="BtnSave_Click" runat="server" Text="Save" />
                                    <asp:Button ID="BtnCancel" ToolTip="Click here for cancel and go to home page" CssClass="btn" OnClick="BtnCancel_Click" runat="server" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    
                </tr>
            </table>

        </div>
        <br />
        <div style="width: 99%; padding: 5px;">

            <table style="width: 50%;">
                <tr>
                    <td>Show Leave balance report for the month of </td>
                    <td>
                        <asp:DropDownList ID="DdlMonthDet" runat="server" CssClass="ddl" Width="150px"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button ID="BtnView" runat="server" Text="View" CssClass="btn" OnClick="BtnView_Click" />
                    </td>
                </tr>
            </table>
            <table style="width:80%">
                <tr>
                     <td>OB - Opening Balance
                                </td>
                                <td>LC - Leave Credit
                                </td>
                                <td>LT - Leave Taken
                                </td>
                                <td>EL - Earn Leave
                                </td>
                                <td>CL - Casual Leave
                                </td>
                                <td>SL - Sick Leave
                                </td>
                                <td>LOP - Loss Of Pay
                                </td>
                </tr>
            </table>
            <table style="width: 98%; table-layout: fixed">
                <tr>
                    <td>
                        <telerik:RadGrid runat="server" ID="RGLeaveCredit" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" Skin="WebBlue"
                            OnItemCommand="RGLeaveCredit_ItemCommand" HeaderStyle-Wrap="true" OnPageIndexChanged="RGLeaveCredit_PageIndexChanged" OnPageSizeChanged="RGLeaveCredit_PageSizeChanged">
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="false" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                                HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" Style="font-family: Verdana;">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <Columns>
                                    <%--<telerik:GridBoundColumn DataField="StaffName" HeaderText="Staff Name" UniqueName="StaffName" SortExpression="StaffName" AllowFiltering="true" AllowSorting="true"
                            FilterControlWidth="100px" />
                        <telerik:GridBoundColumn DataField="Casual" HeaderText="Casual Leave" UniqueName="Casual" SortExpression="Casual" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn DataField="Earn" HeaderText="Earn Leave" UniqueName="Earn" SortExpression="Earn" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn DataField="Sick" HeaderText="Sick Leave" UniqueName="Sick" SortExpression="Sick" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn DataField="Total" HeaderText="Total no.of Leave(s)" UniqueName="Total" SortExpression="Total" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkEdit" runat="server" Text="Edit" CommandName='<%#Eval("StaffId") %>' ToolTip="Click here for update the leave credit details" OnClick="LnkEdit_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                                    <telerik:GridBoundColumn DataField="Month" HeaderText="For Month" UniqueName="Month" SortExpression="Month"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="StaffName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Staff Name" UniqueName="StaffName" SortExpression="StaffName" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="OB_EL" HeaderText="OB_EL" UniqueName="OB_EL" SortExpression="OB_EL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="OB_CL" HeaderText="OB_CL" UniqueName="OB_CL" SortExpression="OB_CL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="OB_SL" HeaderText="OB_SL" UniqueName="OB_SL" SortExpression="OB_SL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LC_EL" HeaderText="LC_EL" UniqueName="LC_EL" SortExpression="LC_EL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LC_CL" HeaderText="LC_CL" UniqueName="LC_CL" SortExpression="LC_CL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LC_SL" HeaderText="LC_SL" UniqueName="LC_SL" SortExpression="LC_SL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LD_EL" HeaderText="LT_EL" UniqueName="LD_EL" SortExpression="LD_EL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LD_CL" HeaderText="LT_CL" UniqueName="LD_CL" SortExpression="LD_CL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LD_SL" HeaderText="LT_SL" UniqueName="LD_SL" SortExpression="LD_SL" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                    <telerik:GridBoundColumn DataField="LOP" HeaderText="LOP" UniqueName="LOP" SortExpression="LOP" AllowFiltering="true" AllowSorting="true"
                                        FilterControlWidth="50px" />
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="2" SaveScrollPosition="true" />
                                <Selecting AllowRowSelect="True" />
                            </ClientSettings>
                        </telerik:RadGrid></td>
                </tr>
            </table>

        </div>
    </div>
    <br />
    <br />
</asp:Content>

