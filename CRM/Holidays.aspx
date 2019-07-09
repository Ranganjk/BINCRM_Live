<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Holidays.aspx.cs" Inherits="Holidays" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="css/element.css" rel="stylesheet" />
    <link href="css/Leavestyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <div class="DivAll">

        <div>
            <table style ="width:100%">
                 
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

        <div class="DivContent1">
            <h3>Holidays</h3>
            <table>
                <tr>
                    <td>Holiday Date<span class="ReqStr"> *</span>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtHDate" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Select the holiday date" PlaceHolder="Holiday Date"></asp:TextBox>
                        <asp:CalendarExtender ID="CalFromDate" Format="dd-MMM-yyyy" TargetControlID="TxtHDate" PopupButtonID="TxtHDate" runat="server"></asp:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>Holiday Type<span class="ReqStr"> *</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="DdlHType" runat="server" ToolTip="Choose holiday type" CssClass="ddl"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Holiday Name
                    </td>
                    <td>
                        <asp:TextBox ID="TxtHName" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Enter the holiday name" PlaceHolder="Holiday Name"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Holiday Status<span class="ReqStr"> *</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="DdlHStatus" runat="server" ToolTip="Choose holiday status" CssClass="ddl"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Remarks
                    </td>
                    <td>
                        <asp:TextBox ID="TxtRemarks" AutoPostBack="true" runat="server" CssClass="TxtBox" ToolTip="Enter the remarks, If any" PlaceHolder="Remarks, If any" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="BtnSave" ToolTip="Click here for save the holiday" CssClass="btn" OnClick="BtnSave_Click" runat="server" Text="Save" OnClientClick="return cnfmSave();" />
                        <asp:Button ID="BtnCancel" ToolTip="Click here for cancel and go to home page" CssClass="btn" OnClick="BtnCancel_Click" runat="server" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="DivContent2">
            <telerik:RadGrid runat="server" ID="RGHolidays" AutoGenerateColumns="False" Visible="True" GridLines="Vertical" Skin="WebBlue"
                OnItemCommand="RGHolidays_ItemCommand" OnPageIndexChanged="RGHolidays_PageIndexChanged" OnPageSizeChanged="RGHolidays_PageSizeChanged"
                Style="width: 100%; margin-top: 10px;" ShowFooter="false">
                <GroupingSettings CaseSensitive="false" />
                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true"
                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterItemStyle-Width="50px" Style="font-family: Verdana;">
                    <PagerStyle Mode="NextPrevAndNumeric" />

                    <Columns>
                        <telerik:GridBoundColumn Display="false" DataField="RSN" />
                        <telerik:GridBoundColumn DataField="HolidayDate" HeaderText="Holiday Date" UniqueName="HolidayDate" SortExpression="HolidayDate" AllowFiltering="true" AllowSorting="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="100px" />
                        <telerik:GridBoundColumn DataField="HolidayType" HeaderText="Holiday Type" UniqueName="HolidayType" SortExpression="HolidayType" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="HolidayName" HeaderText="Holiday Name" UniqueName="HolidayName" SortExpression="HolidayName" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="HolidayStatus" HeaderText="Holiday Status" UniqueName="HolidayStatus" SortExpression="HolidayStatus" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridBoundColumn DataField="Remarks" HeaderText="Remarks" UniqueName="Remarks" SortExpression="Remarks" AllowFiltering="true" AllowSorting="true" />
                        <telerik:GridTemplateColumn AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LnkDelete" runat="server" Text="Delete" CommandName='<%#Eval("RSN") %>' ToolTip="Click here for delete the holiday" OnClick="LnkDelete_Click" OnClientClick="return cnfmDel();"></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <br />
    <br />
    <script type="text/javascript">
        function cnfmDel() {
            if (confirm("Are you sure, Do you want delete?"))
                return true;
            else
                return false;
        }
        function cnfmSave() {
            if (confirm("Are you sure, Do you want save?")) {
                var hdate = document.getElementById('<%= TxtHDate.ClientID%>').value;
                var htype = document.getElementById('<%= DdlHType.ClientID%>').value;
                var hstatus = document.getElementById('<%= DdlHStatus.ClientID%>').value;
                if (hdate == "") {
                    alert("Please enter the holiday date!");
                    return false;
                }
                else if (htype == "Please Select") {
                    alert("Please select the holiday type!");
                    return false;
                }
                else if (hstatus == "Please Select") {
                    alert("Please select the holiday status!");
                    return false;
                }
                else
                    return true;
            }
            else
                return false;
        }
    </script>
</asp:Content>
