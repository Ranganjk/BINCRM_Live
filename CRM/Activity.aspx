<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activity.aspx.cs" Inherits="Activity" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Activity</title>

    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />

    <%-- <script type="text/javascript">
        function NavigateDir2(cusrsn) {
            var iMyWidth;
            var iMyHeight;
            var rsn = 'RSN=' + cusrsn;
            var taskid = document.getElementById('<%# Label21.ClientID %>').innerText;
            iMyWidth = (window.screen.width / 2) - (450 + 50);
            iMyHeight = (window.screen.height / 2) - (285 + 30);
            var Y = 'AddTaskTracker.aspx?' + rsn;
            var win = window.open(Y, "Window2", "status=no,height=630,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }
    </script>--%>

    <script type="text/javascript">
        var clicked = false;
        function CheckBrowser() {
            if (clicked == true) {
                //Browser closed
                alert('first');
                window.opener.HideModalDiv();
            } else {
                //redirected
                clicked = false;
            }
        }
        function bodyUnload() {
            if (clicked == false)//browser is closed
            {
                var par = document.location.search;
                var buttonid = par.substring(par.indexOf('=') + 1, par.length);
                var subbuttonid = buttonid.substring(0, 21);



                self.opener.window.document.getElementById(subbuttonid).click();

                window.opener.status = "Closed";

                window.opener.HideModalDiv();

                window.opener = 'x'

            }
        }

        window.onunload = setclosedstatus();
        // window.onload = setopenstatus();


        function setclosedstatus() {
            //          if (window.onload == true) {
            //              window.opener.status = 'Closed';
            //          }

            window.opener.status = "Open";
            window.opener.HideModalDiv();

        }
        function setopenstatus() {
            window.opener.status = 'Open';
        }

    </script>
    <script type="text/javascript">
        function CloseWindow() {
            window.opener.ConfirmClick();
            //window.opener.DisplayCalendar();
            window.close();
        }
        function CloseWindow1() {
            //alert('test');
            window.opener.ConfirmClick();
            //window.opener.DisplayCalendar();
        }
        function CloseWindow2() {
            window.close();
        }
    </script>

</head>
<body onunload="CloseWindow1()" style="background-color: beige;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager3" runat="server">
        </asp:ScriptManager>
        <script language="javascript" type="text/javascript">
            function ConfirmMsg() {
                var msg = "";
                msg = 'You are about to assign an activity. Confirm.';
                var result = confirm(msg, "Check");

                if (result) {
                    document.getElementById('CnfResult').value = "true";
                    return true;
                }
                else {
                    document.getElementById('CnfResult').value = "false";
                    return false;
                }
            }
        </script>
        <script language="javascript" type="text/javascript">
            function ConfirmMsg2() {
                var msg = "";
                msg = 'You are about to upate an activity. Confirm.';
                var result = confirm(msg, "Check");

                if (result) {
                    document.getElementById('CnfResult').value = "true";
                    return true;
                }
                else {
                    document.getElementById('CnfResult').value = "false";
                    return false;
                }
            }
        </script>
        <div>
            <asp:HiddenField ID="CnfResult" runat="server" />
            <asp:UpdatePanel ID="upAddNewTask" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <asp:Label ID="lblHeading" runat="server" Text="Activities / Requirements - New & Update" Font-Size="Small"
                                    ForeColor="#003366" Font-Names="verdana"></asp:Label>
                                <%-- <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click"
                                    ToolTip="" />
                                --%>
                            </td>

                        </tr>
                    </table>
                    <div style="margin-left: 10px">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:Label ID="Label8" runat="server" Text="Label" Style="display: none"></asp:Label>

                                </td>
                            </tr>
                        </table>
                    </div>


                    <table style="width: 100%" cellpadding="3px">

                        <tr>

                            <td style="width: 50%">


                                <table>

                                    <tr>
                                        <td>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label11" runat="server" Text="For which customer?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="420px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RSN" InputType="Text" MinFilterLength="1"
                                                                EmptyMessage="Choose MobileNo / Name / EmailID " ToolTip="Choose the Mobile No / Name / EmailID to view the customer details" OnEntryAdded="DdlUhid_EntryAdded" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                                <TextSettings SelectionMode="Single" />
                                                            </telerik:RadAutoCompleteBox>
                                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:PMS %>' SelectCommand="select Mobile +', '+Name+', '+ Email + ', ' + convert(nvarchar(10),RSN) as Customer,RSN from prospects order by Name asc"></asp:SqlDataSource>
                                                        </td>
                                                        <td>

                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Button" OnClick="btnSearch_Click" ToolTip="" />
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4">
                                                            <asp:Label ID="Label23" runat="server" Text="Is this for some one new? Check here" Font-Names="verdana" CssClass="style3" ForeColor="Red" Font-Size="Small"></asp:Label>
                                                            <asp:CheckBox ID="chkNew" runat="server" OnCheckedChanged="chkNew_CheckedChanged" Text="" AutoPostBack="true" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <div id="dvCustomerDetails" runat="server" style="border: 1px solid gray">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="lblname" ForeColor="Brown" Font-Size="Small" runat="server" Font-Names="timesnewroman" Text="" CssClass="style3" Width="120"></asp:Label>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>

                                                            <asp:Label ID="lblcmobile" ForeColor="Brown" Font-Size="Small" runat="server" Text="Mobile:" CssClass="style3"></asp:Label>


                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblMobileNo" ForeColor="Brown" Font-Size="Small" runat="server" Text="" CssClass="style3" Width="120"></asp:Label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblcemail" ForeColor="Brown" Font-Size="Small" runat="server" Text="Email:" CssClass="style3"></asp:Label>

                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblEmail" ForeColor="Brown" Font-Size="Small" runat="server" Text="" CssClass="style3" Style="width: 120px; overflow: hidden"></asp:Label>
                                                        </td>

                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblcstreet" ForeColor="Brown" Font-Size="Small" runat="server" Text="Address:" CssClass="style3"></asp:Label>
                                                            <br />
                                                            <br />
                                                        </td>
                                                        <td align="left" style="vertical-align: top;">
                                                            <%--<textarea runat ="server" id="txtAddress" style ="width:120px"></textarea>--%>

                                                            <asp:Label ID="lblDoorNo" ForeColor="Brown" Font-Size="Small" runat="server" Text="" CssClass="style3" Width="350px"></asp:Label><br />
                                                            <%-- <asp:Label ID="lblstreet" ForeColor="Brown" runat="server" Text="" CssClass="style3"></asp:Label><br />
                                                            <asp:Label ID="lblcity" ForeColor="Brown" runat="server" Text="" CssClass="style3"></asp:Label><br />
                                                            <asp:Label ID="lblpostalcode" ForeColor="Brown" runat="server" Text="" CssClass="style3"></asp:Label><br />
                                                            <asp:Label ID="lblsteate" ForeColor="Brown" runat="server" Text="" CssClass="style3"></asp:Label><br />
                                                            <asp:Label ID="lblCountry" ForeColor="Brown" runat="server" Text="" CssClass="style3" Width="120"></asp:Label>--%>
                                                            
                                                        </td>

                                                    </tr>



                                                </table>

                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="dvNewLead" runat="server" style="border: 1px solid gray">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="3px">
                                                                            <tr>
                                                                                <td colspan="2">
                                                                                    <asp:Label ID="Label5" runat="server" Text="Add Name and other details below." CssClass="style3" Font-Size="Small" Font-Underline="true"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblTitle" runat="server" Text="Biz./Mr. :" ForeColor="Gray" Font-Size="Small" CssClass="style3" Width="120"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlTitle" runat="server" Width="250px" CssClass="style3" ToolTip="Select Biz. if you are adding a company name.">
                                                                                        <asp:ListItem Value=" " Text=" "></asp:ListItem>
                                                                                        <asp:ListItem Value="Mr." Text="Mr."></asp:ListItem>
                                                                                        <asp:ListItem Value="Mrs." Text="Mrs."></asp:ListItem>
                                                                                        <asp:ListItem Value="Ms." Text="Ms."></asp:ListItem>
                                                                                        <asp:ListItem Value="Dr." Text="Dr."></asp:ListItem>
                                                                                        <asp:ListItem Value="Col." Text="Col."></asp:ListItem>
                                                                                        <asp:ListItem Value="Biz." Text="Biz."></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="Label24" runat="server" Text="Name :" ForeColor="Gray" Font-Size="Small" CssClass="style3"></asp:Label>
                                                                                    <asp:Label ID="lblAs" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtCustName" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Enter the name of the lead/prospect/customer/vendor etc. Max 40."></asp:TextBox>

                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblType" runat="server" Text="Type:" ForeColor="Gray" Font-Size="Small" CssClass="style3"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlNewLeadType" runat="server" Width="250px" CssClass="style3" ToolTip="Prospect/Customer/Vendor/Other?"
                                                                                        OnSelectedIndexChanged="ddlNewLeadType_SelectedIndexChanged" AutoPostBack="true">
                                                                                        <asp:ListItem Value="CUSTOMER" Text="CUSTOMER"></asp:ListItem>
                                                                                        <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                                                                        <asp:ListItem Value="VENDOR" Text="VENDOR"></asp:ListItem>
                                                                                        <asp:ListItem Value="OTHER" Text="OTHER"></asp:ListItem>

                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <%--<tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblStatus" runat="server" Text="Status :" CssClass="style3" ForeColor="Gray"></asp:Label>
                                                                                    <%--<asp:Button ID="btnstatushelp" runat="server" Text="?" CssClass="btnSmallMainpage"
                                                                Width="10px" OnClick="btnstatushelp_Click" ToolTip="" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlCCustStatus" runat="server" Width="250px" CssClass="style3"
                                                                                        ToolTip="" BackColor="DarkBlue" ForeColor="White">
                                                                                    </asp:DropDownList>

                                                                                </td>
                                                                            </tr>--%>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblProspectCompanyName" runat="server" ForeColor="Gray" Font-Size="Small" Text="Company/MainContact:" CssClass="style3"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtCompanyName" runat="server" Width="250px" Font-Size="Medium"
                                                                                        CssClass="style3" TextMode="SingleLine" MaxLength="100" ToolTip="Enter the name of the maincontact person. if you are adding a company's profile. Otherwise, add the name of the organisation where the person is employed. Max 100."></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblMob" runat="server" Font-Size="Small" ForeColor="Gray" Text="Mobile No. :" CssClass="style3"></asp:Label>
                                                                                    <asp:Label ID="lblmr" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtMob" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                                        TextMode="SingleLine" MaxLength="13" ToolTip="Prefix with country code if a foreign no. Max 13."></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblEml" runat="server" Font-Size="Small" ForeColor="Gray" Text="EmailID:" CssClass="style3"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtEml" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter the main email id for correspondence. Max 80."></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <%--<tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblNotes" runat="server" Text="Notes :" CssClass="style3"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtNotes" runat="server" Width="250px" Height="75" Font-Size="Medium" CssClass="style3"
                                                                                        TextMode="MultiLine" MaxLength="2400" ToolTip="Write a brief note on your interaction with the Lead/Customer. This entry also saved in the Work diary.Max 2400."></asp:TextBox>
                                                                            </tr>--%>
                                                                        </table>

                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadWindow ID="rwReferenceHelp" Width="400" Height="200" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnReferenceHelp.ClientID  %>" Modal="true">
                                                                <ContentTemplate>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblrefhelp" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ContentTemplate>
                                                            </telerik:RadWindow>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Requirement" Font-Bold="false" Font-Size="Small" CssClass="style2"></asp:Label>
                                                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTaskAssigned" runat="server" AutoPostBack="true" TextMode="MultiLine" Rows="4" Columns="40" ToolTip="What is the work to be done with ref to the customer/lead. Write it here.   Use SaveTime to choose standard wordings from a predefined list."></asp:TextBox><br />
                                                        <asp:DropDownList ID="ddlsavetime" OnSelectedIndexChanged="ddlsavetime_SelectedIndexChanged" runat="server" Width="280px" ToolTip="Select from a standard picklist of frequently used sentences and press the + button." AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <%--<asp:ImageButton ID="btnimgaddsavetime" runat="server" OnClick="btnimgaddsavetime_Click" ImageUrl="~/Images/Actions-edit-add-icon2.png" ToolTip="Select from a standard picklist of frequently used sentences and press the + button." />--%>
                                                        <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                                            OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments. Remember whatever you add once is available everywhere in the system." />
                                                        <telerik:RadWindow ID="rwSaveTime" VisibleOnPageLoad="false" Width="300px" runat="server" OpenerElementID="<%# btnSaveTime.ClientID  %>">
                                                            <ContentTemplate>
                                                                <asp:UpdatePanel ID="upSaveTime" runat="server">
                                                                    <ContentTemplate>
                                                                        <table cellpadding="3">
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Label ID="lblInfo" runat="server" Text="Add to PickList to SaveTime" ForeColor="Green" Font-Bold="true" Width="160px" CssClass="style2" Font-Names="Calibri"></asp:Label>

                                                                                </td>
                                                                            </tr>
                                                                            <tr>

                                                                                <td align="center">
                                                                                    <asp:TextBox ID="txtInfo" runat="server" Width="200px" MaxLength="80"></asp:TextBox>
                                                                                </td>
                                                                            </tr>

                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Button ID="btnSTSave" runat="server" Text="Save" CssClass="Button" OnClick="btnSTSave_Click"
                                                                                        ToolTip="Write a sentence to be added to the PickList and click Save." />
                                                                                    <asp:Button ID="btnSTClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnSTClear_Click" ToolTip="Click to Clear what you have written above." />
                                                                                    <asp:Button ID="btnSTClose" runat="server" Text="Close" CssClass="Button" OnClick="btnSTClose_Click" ToolTip="Clickto return back to previous page." />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" align="center">

                                                                                    <asp:GridView ID="gvSaveTime" runat="server" AutoGenerateColumns="false" OnRowCommand="gvSaveTime_RowCommand" CssClass="gridview_borders">
                                                                                        <Columns>
                                                                                            <asp:BoundField HeaderText="PickList" DataField="Savetimeentry" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
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
                                                                        <asp:AsyncPostBackTrigger ControlID="gvSaveTime" EventName="RowCommand" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </ContentTemplate>
                                                        </telerik:RadWindow>
                                                    </td>

                                                </tr>

                                                <%--<tr>

                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Font-Bold ="false" Text="By date" CssClass="style2"></asp:Label>
                                                        <asp:Label ID="Label19" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtpAssignOnDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" ToolTip="The date on which the activity is assigned. Current date is shown by default.">
                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana" Visible="false">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>--%>

                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Font-Bold="false" Font-Size="Small" Text="Target Date" CssClass="style2"></asp:Label>
                                                        <asp:Label ID="Label20" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtpTargetDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="160px" CssClass="style2" ToolTip="Ths is the date by which you wish to see a result.  It is three days from now by default but change it as you wish."
                                                            Font-Names="verdana" ReadOnly="true">
                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                        <asp:Button ID="btnDateAdd" runat="server" Text="+" CssClass="Button" OnClick="btnDateAdd_Click" Width="30px" ToolTip="Click here to increment target date." />
                                                        <asp:Button ID="btnDateMinus" runat="server" Text="-" CssClass="Button" OnClick="btnDateMinus_Click" Width="30px" ToolTip="Click here to decrement target date." />
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label13" runat="server" Font-Bold="false" Font-Size="Small" Text="Group" CssClass="style2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlReferenceGroup" runat="server" ToolTip="Choose the group in which the # ref resides." AutoPostBack="true" OnSelectedIndexChanged="ddlReferenceGroup_SelectedIndexChanged">
                                                            <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                                            <asp:ListItem Text="General" Value="General"></asp:ListItem>
                                                            <asp:ListItem Text="Projects" Value="Projects"></asp:ListItem>
                                                        </asp:DropDownList>

                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Font-Bold="false" Font-Size="Small" Text="Reference" CssClass="style2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlTrackon" runat="server" ToolTip="Select an appropriate reference code." OnSelectedIndexChanged="ddlTrackon_SelectedIndexChanged" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnReferenceHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnReferenceHelp_Click" Width="60px"
                                                            ToolTip="" />
                                                        <br />
                                                        <asp:Label ID="lblcrefremarks" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small" BackColor="Yellow" ForeColor="Black"></asp:Label>
                                                    </td>

                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCheckList" runat="server" Text="CheckList" Font-Bold="false" Font-Size="Small" CssClass="style2" Visible="true"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCheckList" runat="server" ToolTip="Select the activity/task in sequence." OnSelectedIndexChanged="ddlCheckList_SelectedIndexChanged" AutoPostBack="true" Width="600px" Visible="false" Font-Size="Smaller">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>



                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Font-Bold="false" Font-Size="Small" Text="Assigned To" CssClass="style2"></asp:Label>
                                                        <asp:Label ID="lblash1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlAssignedTo" runat="server" Width="150px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCustStatus" Font-Bold="false" runat="server" Font-Size="Small" Text="Status" CssClass="style2" Visible="false"></asp:Label>
                                                        <asp:Label ID="lblash5" runat="server" Text="*" ForeColor="Red" Visible="false" Width="73px"></asp:Label>
                                                    </td>
                                                    <td>

                                                        <asp:DropDownList ID="ddlCustStatus" runat="server" Visible="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Font-Bold="false" Font-Size="Small" Text="Followup Date" CssClass="style2"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtpFollowupdate" runat="server" Culture="English (United Kingdom)" SkipMinMaxDateValidationOnServer="true"
                                                            Width="160px" CssClass="style2" ToolTip="Set a date by which you wish a followup  reminder to be  emailed to the assignee on the morning of the followup date. A mail with a Calendar link is also sent to the assignee as soon as this activity is saved." Font-Names="verdana" ReadOnly="true">
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
                                                        <asp:Label ID="Label6" runat="server" Font-Bold="false" Font-Size="Small" Text="Assigned By" CssClass="style2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlAssignedBy" runat="server" ToolTip="Select the person who assigned. Your ID appears by default.">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>


                                                <%--  <tr>

                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Additional Remarks" CssClass="style2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOtherAssignees" runat="server" TextMode="MultiLine" Rows="4"
                                                            Columns="40" ToolTip="Write here any addnl.comments or names of other persons involved."></asp:TextBox>
                                                    </td>
                                                </tr>--%>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label12" runat="server" Font-Bold="false" Font-Size="Small" Text="Priority" CssClass="style2"></asp:Label>
                                                        <asp:Label ID="Label21" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlPriority" runat="server" ToolTip="Set the priority of the activity. Hot or VeryHot are for high priority activities">
                                                        </asp:DropDownList>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblStatus" runat="server" Text="Work status" Font-Size="Small" Font-Bold="false" CssClass="style2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlStatus" runat="server" Width="155px" CssClass="style3" ToolTip="Set status to Completed if this work is now done. Caution! You cannot undo the action.">
                                                        </asp:DropDownList>
                                                        <br />
                                                        <asp:Label ID="lblshelp" runat="server" Text="If you mark the status as Completed, you cannot undo it. Hence be sure about it before you update." ForeColor="DarkBlue" Font-Size="X-Small"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label30" runat="server" Font-Bold="false" Font-Size="Small" BackColor="Yellow" Text="Send Mail to Customer?" CssClass="style2"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlcmail" runat="server" ToolTip="If you say Yes, a mail will be sent to the customer confirming the request. If you say No, no mail will be sent.">
                                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>

                                                </tr>

                                                <tr>
                                                    <td colspan="2" align="center">
                                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button" OnClick="btnSave_Click"
                                                            OnClientClick="javascript:return ConfirmMsg()" ToolTip=" Click to Save this new task assigned." />
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="Button" OnClick="btnUpdate_Click"
                                                            OnClientClick="javascript:return ConfirmMsg2()" ToolTip=" Click here to Updte the existing activity details." />
                                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnClear_Click"
                                                            ToolTip=" Click to clear the details entered and to re-enter again." />
                                                        <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="Button" OnClientClick="CloseWindow()"
                                                            ToolTip=" Click to return to the Tasks list.  Have you pressed Save?" OnClick="btnClose_Click" />
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td colspan="2">

                                                        <asp:Label ID="Label19" runat="server" ForeColor="DarkBlue" Font-Names="verdana" Text="Click on Ref#  to update the requirement." Font-Size="X-Small"></asp:Label>
                                                        <telerik:RadGrid ID="gvNewActivity" runat="server" Height="350px" Skin="WebBlue" GridLines="None" AllowFilteringByColumn="true"
                                                            AutoGenerateColumns="false" OnItemCommand="gvNewActivity_ItemCommand" OnItemDataBound="gvNewActivity_ItemDataBound">

                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" AllowSorting="true">
                                                                <PagerStyle Mode="NextPrevAndNumeric" />
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>

                                                                <Columns>
                                                                    <telerik:GridTemplateColumn DataField="TaskID" HeaderText="Ref#" UniqueName="TaskID"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="TaskID" AllowFiltering="true" HeaderTooltip="Unique no. for the requirement/activity/task/. Click on the Ref#  of an activity in progress to update the progress of work.">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkRSN" ToolTip="" runat="server" Text='<%# Eval("TaskID") %>' CommandName="Task" CommandArgument='<%# Eval("TaskID") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="Date" AllowFiltering="true" HeaderTooltip="Date when the activity was posted.">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkDate" ToolTip="" runat="server" Text='<%# Eval("Date") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn DataField="Customer" HeaderText="Customer" UniqueName="Customer"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="Customer" AllowFiltering="true" HeaderTooltip="Name of the customer/ Prospective customer">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkCustomer" ToolTip="" runat="server" Text='<%# Eval("Customer") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn DataField="Mobile" HeaderText="MobileNo" UniqueName="Mobile"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="Mobile" AllowFiltering="true" HeaderTooltip="Contact mobile number">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkMobile" ToolTip="" runat="server" Text='<%# Eval("Mobile") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn DataField="Details" HeaderText="Details" UniqueName="Details"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="Details" AllowFiltering="true" HeaderTooltip="Detailed information about the requirement / activity">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkDetails" ToolTip="" runat="server" Text='<%# Eval("Details") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn DataField="status" HeaderText="status" UniqueName="status"
                                                                        Visible="true" FilterControlWidth="50px" SortExpression="status" AllowFiltering="true" HeaderTooltip="Shows the current state of the activity.   Shows all in progress work and those that were completed today.">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkStatus" ToolTip="" runat="server" Text='<%# Eval("status") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                            </ClientSettings>
                                                        </telerik:RadGrid>


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
                                                <%--<tr>
                                                    <td colspan="2">
                                                        <asp:Label ID="Label22" runat="server" Text="If you set a followup date, a Calendar Link mail will be sent to the assignee immediately.  A reminder mail will be sent to the assignee, one day before." CssClass="label2"></asp:Label>
                                                    </td>
                                                </tr>--%>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label14" runat="server" Text="Doc.Upload1" CssClass="style2" Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="UPLDocUpl1" runat="server" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label15" runat="server" Text="Doc.Upload2" CssClass="style2" Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="UPLDocUpl2" runat="server" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label16" runat="server" Text="Doc.Upload3" CssClass="style2" Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="UPLDocUpl3" runat="server" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label17" runat="server" Text="Doc.Upload4" CssClass="style2" Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="UPLDocUpl4" runat="server" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="Label18" runat="server" Text="Doc.Upload5" CssClass="style2" Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="UPLDocUpl5" runat="server" Visible="false" />
                                                    </td>

                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>

                            </td>

                            <%--***********************--%>
                            <td  style="width: 50%; vertical-align: top">
                                <asp:Label ID="Label10" runat="server" Text=" Record a new requirement / activity here.
If it is for an existing customer, first select the customer name.  Other details will be displayed.
If it is for someone new (not existing in the database), mark the check box, enter the name and other important information.
When the requirement is completed, write the completion remarks and update status.
 
You can choose either to send an EMAIL or not to customer."
                                    CssClass="label2"></asp:Label>
                            </td>


                        </tr>


                    </table>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="gvNewActivity" />
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnClose" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSaveTime" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="ddlsavetime" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="DdlUhid" EventName="EntryAdded" />

                </Triggers>
            </asp:UpdatePanel>

        </div>
    </form>
</body>
</html>
