<%@ Page Title="Customers" EnableEventValidation="false" ValidateRequest="false" Trace="false" ViewStateMode="Enabled" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Customers.aspx.cs" Inherits="Customers" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" Runat="Server">
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>   
    <script type="text/javascript" src="js/ManageTask.js"></script>
    <script type="text/javascript" src="js/Validations.js"></script>   
    <script type="text/javascript" src="js/Disablebackbtn.js"></script>

    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />

      <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
   </script>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += Phno();
           
            summ += Name();
            
            summ += pwd();
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

        function Name() {
            var Name = document.getElementById('<%=txtcontactname.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Contact Name" + "\n";
            }
            else {
                return "";
            }
        }
       
        function pwd() {
            var Name = document.getElementById('<%=txtcontlocation.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Location" + "\n";
            }
            else {
                return "";
            }
        }

        function Phno() {
            var Name = document.getElementById('<%=txtcontmobileno.ClientID%>').value;
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

        
    </script>
    <script type="text/javascript">
        function NavigateNewTask(getlatestbtn) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);
            var X = window.document.getElementById('<%= HDLoginUser.ClientID %>').value;
            var Y = 'AddNewTask.aspx?ctrlID=' + getlatestbtn + '&UserID=' + X;
            var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
    </script>
    <script type="text/javascript">
        function ConfirmClick() {
            // window.onload.apply();
        }
    </script>
     <script type="text/javascript">
         Customersblock();
    </script>
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
    <style type="text/css">
    .preference .rwWindowContent
    {
        background-color: Green !important;
    }
    .availability .rwWindowContent
    {
        background-color: Yellow !important;
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
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
    </telerik:RadWindowManager> 
    <table style="width:100%;">
        <asp:Button ID="wsgetLatestbtn" runat="server" Text="WS Get Latest" onclick="wsgetLatestbtn_Click" CssClass="hidden"  CausesValidation="false" />
             <table style="width: 100%;">
                        <tr style="width: 100%;">              
                            <td align="center" style="width: 80%;">
                                <asp:Label ID="lblHeading" runat="server" Text="Customers" Font-Size="Large" 
                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label> 
                            </td>
                             <td>
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
                            <td align="right" style="width: 5%;">
                                <%--<asp:Button ID="Button1" Text="Home" runat="server" OnClick="Button1_Click" CssClass="btnMainpage"
                                    ToolTip=" Click here to return back to home." Visible="false" />&nbsp;--%>
                                <asp:ImageButton ID="Button1" OnClick="Button1_Click" runat="server" ImageUrl="~/Images/house_3.png"  ToolTip="Click here to return back to home" />
                               <%-- <asp:Button ID="btnExit" Text="Sign Out" runat="server" OnClick="btnExit_Click" CssClass="btnMainpage"
                                    ToolTip=" Click here to exit from the present session. Make sure you have saved your work." Visible="false"/>--%>     
                                </td>
                            <td style="width:2%;" align="right" valign="middle">
                                <asp:LinkButton ID="lblHome" Height="10px" Font-Underline="false" PostBackUrl="~/Home.aspx" ToolTip="Click here to return back to home" Font-Bold="true" Font-Size="Small" Text="Home" ForeColor="DarkBlue" runat="server"/>
                            </td>
                             <td style="width:3%;" align="right">
                                 <asp:ImageButton ID="btnExit" OnClick="btnExit_Click" runat="server" ImageUrl="~/Images/quit.png" ToolTip="Click here to exit from the present session. Make sure you have saved your work." />
                             </td>
                              <td style="width:5%;" align="left" valign="middle">
                                <asp:LinkButton ID="lbSignOut" Height="10px" Font-Underline="false" PostBackUrl="~/Login.aspx" ToolTip="Click here to exit from the present session. Make sure you have saved your work." Font-Bold="true" Font-Size="Small" Text="Sign Out" ForeColor="DarkBlue" runat="server" />
                            </td>
                        </tr>
                    </table>  
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                       <table>
                    <tr>
                        <td>
                           <telerik:RadWindow ID="rwAddCustomer" runat="server" Width="900px" Height="400px"
                                            OpenerElementID="<%# btnContacts.ClientID  %>" Title ="Contacts">
                                            <ContentTemplate>
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <div style="float: left">
                                                            <div style="float: left">

                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblhcontacts" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="true" Font-Names="Verdana" Font-Size="Medium" Font-Underline="true"></asp:Label><br />
                                                                             <asp:Label ID="Label23" runat="server" Text="(The profile you have selected may be of a company and there may be multiple person whom you will have to contact for different purposes Maintain those details here.)" Font-Size ="X-Small" ForeColor ="Gray" ></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table>
                                                                    <tr>
                                                                        <td colspan="2" style="text-align: left;">
                                                                            
                                                                            <br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblContactName" runat="server" Text="Name"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontactname" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontDesignation" runat="server" Text="Designation"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontDesignation" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontemailid" runat="server" Text="EmailID"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontemailid" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontphoneno" runat="server" Text="PhoneNo"></asp:Label><br />
                                                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontmobileno" runat="server" Text="MobileNo"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontmobileno" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblcontdepartment" runat="server" Text="Department"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontdepartment" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontlocation" runat="server" Text="Location" ToolTip ="Example: Name of the place or City if different form that of the main profile."></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontlocation" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblcontremarks" runat="server" Text="Remarks"></asp:Label><br />
                                                                            <asp:TextBox ID="txtcontremarks" runat="server"></asp:TextBox>

                                                                        </td>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcontsmsallowed" runat="server" Text="SMS" ToolTip ="If Yes SMS text messages can be sent to this person."></asp:Label><br />
                                                                                        <asp:DropDownList ID="ddlcontsms" runat="server">
                                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcontemailallowed" runat="server" Text="Email"  ToolTip ="If Yes EMAIl messages can be sent to this person."></asp:Label><br />
                                                                                        <asp:DropDownList ID="ddlcontemail" runat="server">
                                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td>
                                                                            <br />
                                                                            <asp:Button ID="btnAddContacts" runat="server" Text="Add" CssClass="btnReportpage" OnClientClick="javascript:return Validate()"
                                                                                OnClick="btnAddContacts_Click"  ToolTip="Please click here to add the contacts for the customer."/>
                                                                             <asp:Button ID="btnCloseContacts" runat="server" Text="Close" CssClass="btnReportpage"
                                                                                OnClick="btnCloseContacts_Click"  ToolTip="Please click here to close the contact details."/>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                    </tr>
                                                                </table>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <div style="overflow-x: auto; width: 750px">
                                                                                <asp:GridView ID="gvContacts" runat="server" EmptyDataText="No Records has been added."
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" OnRowEditing="EditCustomer"
                                                                                    OnRowUpdating="UpdateCustomer" OnRowCancelingEdit="CancelEdit" OnRowDataBound="OnsmsemailBound"
                                                                                    DataKeyNames="RSN">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("ContactName") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Designation" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="EmailID" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="PhoneNo" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="MobileNo" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Department" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Location" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtLocation" runat="server" Text='<%# Eval("Location") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="SMS" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblSMS" runat="server" Text='<%# Eval("SMSAllowed") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:Label ID="lbleSMS" runat="server" Text='<%# Eval("SMSAllowed") %>' Visible="false"></asp:Label>
                                                                                                <asp:DropDownList ID="ddlsms" runat="server">
                                                                                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Email" ItemStyle-Width="150">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("EmailAllowed") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:Label ID="lbleEmail" runat="server" Text='<%# Eval("EmailAllowed") %>' Visible="false"></asp:Label>
                                                                                                <asp:DropDownList ID="ddlemail" runat="server">
                                                                                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:CommandField ShowEditButton="True" />
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                                 
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                    </Triggers>
                                                </asp:UpdatePanel>

                                            </ContentTemplate>
                                        </telerik:RadWindow>
                        </td>
                    </tr>
                           <tr>
                               <td>
                            <telerik:RadWindow ID="rwHelp" CssClass ="availability" BackColor="#ffff00" Title="Help" VisibleOnPageLoad="false" Width="900" Height="350" runat="server" Modal="true">
                            <ContentTemplate>
                                <div>
                                     <table>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label4" runat="server" Text="Select the list of customers / leads according to their current status, as described below." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label9" runat="server" Text="Recently added:    Profiles added in last 3 days." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label10" runat="server" Text="Not Yet Hot Leads:   Prospective customers in Enquiry or Assigned or Warm Status." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label12" runat="server" Text="Qualified Leads:  Prospective customers in Hot Status (for ex: a Proposal has been submitted.)" CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label13" runat="server" Text="Customers:  Profiles of those with whom business is being carried out at present." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label16" runat="server" Text="Vendors:  In other words ‘Suppliers of products / services’ ." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label17" runat="server" Text="Others: Any other party with whom interactions take place. Example: Your auditor or lawyer or a government department." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label22" runat="server" Text="Cold Leads:  Those profiles marked as COLD or DROPPED." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label24" runat="server" Text="All prospects & customers:  All profiles of prospects except those in Dropped status and profiles of all customers." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label25" runat="server" Text="Active now:   Profiles with respect to whom, activities are presently in progress." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label26" runat="server" Text="Select one of the Status and press Search." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label27" runat="server" Text="If you wish to look for a specific name or for a mobile number, enter part of the name or the no. In the respective field and press Search." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label28" runat="server" Text="Edit:  Click to Edit the profile" CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label29" runat="server" Text="Diary:   Click to view a diary of all activities carried out for the selected profile." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label30" runat="server" Text="Task:     Click to add a new task (activity) for the selected profile." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <asp:Label ID="Label31" runat="server" Text="Fwup:  Shows the next followup date if present." CssClass="style2" ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                             </td>
                                         </tr>
                                         
                                     </table>
                                </div>
                            </ContentTemplate>    
                            </telerik:RadWindow>
                               </td>
                           </tr>
                    <tr>
                        <td>
                           <telerik:RadWindowManager ID="rwmMain" runat="server" EnableEmbeddedSkins="true" RenderMode="Auto"></telerik:RadWindowManager>                                       
                            <telerik:RadWindow ID="rwServicedetails"  VisibleOnPageLoad="true" CenterIfModal="false" Width="1300" Height="400"  Font-Names="Verdana" EnableEmbeddedBaseStylesheet="true"
                                             runat="server" Modal ="true">                                            
                                                    <ContentTemplate>                                          
                                                        <div style="float: left">
                                                            <div style="float: left">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblserviceName" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="true" Font-Names="Verdana" Font-Size="Medium" Font-Underline="true"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table>
                                                                    <tr>
                                                                        <td>

                                                                <table>
                                                                    <tr>
                                                                        <td colspan="2" style="text-align: left;">
                                                                            
                                                                            <br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label42" runat="server" Text="Service" Font-Names="Verdana" Font-Size="Small"></asp:Label><br />
                                                                            <asp:DropDownList ID="ddlrwservice" runat="server" ToolTip="Select a service which you provide for this customer." Font-Names="Verdana" OnSelectedIndexChanged="ddlrwservice_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                                        </td>
                                                                       
                                                                           <td>
                                                                               <asp:Label ID="Label32" runat="server" Text="Remarks" Font-Names="Verdana" Font-Size="Small"></asp:Label><br />
                                                                               <asp:TextBox ID="txtServiceRemarks" runat="server" ToolTip="Enter here to type of service (or) other remarks ."></asp:TextBox>
                                                                            
                                                                           </td>
                                                                        <td>
                                                                             <asp:Label ID="Label41" runat="server" CssClass="style2" Font-Size="Small"
                                                                                 Font-Bold="false" Font-Names="Verdana" Text="From Date"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="RadDateserfrom" runat="server" Culture="English (United Kingdom)" AutoPostBack="false"
                                                            Width="50px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Optional.If you know the start date of the service for the customer enter it here else leave it blance.">
                                                            <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput1" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                         <td>
                                                                             <asp:Label ID="Label43" runat="server" CssClass="style2" Font-Size="Small"
                                                                                 Font-Bold="false" Font-Names="Verdana" Text="To Date"></asp:Label>
                                                                             <br />
                                                                            <telerik:RadDatePicker ID="RadDateserto" runat="server" Culture="English (United Kingdom)" AutoPostBack="false"
                                                            Width="50px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Optional.If you know the end date of the service for the customer enter it here else leave it blance.">
                                                            <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput2" runat="server" DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                                <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                                         </td>
                                                                        <td>
                                                                            <asp:Label ID="Label40" runat="server" Text="Value " Font-Names="Verdana" Font-Size="Small"></asp:Label><br />
                                                                            <asp:TextBox ID="txtservicevalue" runat="server" ToolTip="Optional. Enter the usual rate charged for this service for this customer, if known, else leave it blank." Width="100px" MaxLength="50" Font-Names="verdana" Font-Size="Small"></asp:TextBox>
                                                                        </td>  
                                                                         <td>
                                                                            <br />
                                                                            <asp:Button ID="btnAddService" runat="server" Text="Add" CssClass="btnReportpage"  Font-Names="Verdana" Width="80px"
                                                                                OnClick="btnAddService_Click" ToolTip="Please click here to add the service details for this customer."/>
                                                                             <asp:Button ID="Button3" runat="server" Text="Close" CssClass="btnReportpage"  Font-Names="Verdana" Width="80px" 
                                                                                OnClick="Button3_Click1"  ToolTip="Click here to close and return to the previous screen."/>
                                                                        </td>                                                                      
                                                                    </tr>                                                                  
                                                                    <tr>
                                                                        <td colspan ="6">
                                                                            <asp:Label ID="lblcrefremarks" runat="server" Text="" Font-Names="Verdana" Font-Size="Small" BackColor="Yellow" ForeColor="Black"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <div style="overflow-x: auto; width: 700px">
                                                                                <asp:GridView ID="gvServiceDetails" runat="server" EmptyDataText="No Records has been added." Visible="true" Width="650px"  OnRowDataBound="gvServiceDetails_RowDataBound"
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" OnRowEditing="gvServiceDetails_RowEditing"
                                                                                    OnRowUpdating="gvServiceDetails_RowUpdating" OnRowCancelingEdit="gvServiceDetails_RowCancelingEdit"
                                                                                    DataKeyNames="RSN">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="ProspectRSN" ItemStyle-Width="50" Visible="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblProspectRSN" runat="server" Text='<%# Eval("ProspectRSN") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:Label ID="txtProspectRSN" runat="server" Text='<%# Eval("ProspectRSN") %>'></asp:Label>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Service" ItemStyle-Width="150" HeaderStyle-HorizontalAlign ="Left">
                                                                                            <ItemTemplate>
                                                                                                <%--<asp:LinkButton ID="lblReference" runat="server" Text='<%# Eval("Reference") %>' ToolTip='<%# Eval("Help") %>'></asp:LinkButton>--%>
                                                                                                <asp:Label ID="lblReference" runat="server" Text='<%# Eval("Reference") %>' ToolTip='<%# Eval("Help") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                
                                                                                                <asp:Label ID="lbltempReference" runat="server" Text='<%# Eval("Reference") %>' Visible = "false" />
                                                                                               <%-- <asp:TextBox ID="txtReference" runat="server" Text='<%# Eval("Reference") %>'></asp:TextBox>--%>
                                                                                                <asp:DropDownList ID="gvddlserreference" runat="server" ToolTip="Select the reference details"></asp:DropDownList>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                         <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="150" HeaderStyle-HorizontalAlign ="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                              <EditItemTemplate>
                                                                                              <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:TextBox>
                                                                                               
                                                                                            </EditItemTemplate>
                                                                                             </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="From Date" ItemStyle-Width="150" ItemStyle-HorizontalAlign ="Center" HeaderStyle-HorizontalAlign ="Center">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblFromDate" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <%--<asp:TextBox ID="txtFromDate" runat="server" Text='<%# Eval("FromDate") %>'></asp:TextBox>--%>
                                                                                                 <telerik:RadDatePicker ID="gvraddateserfrom" runat="server" Culture="English (United Kingdom)" SelectedDate='<%# (Eval("selectfrom")  != null && Eval("selectfrom") is DateTime) ? Convert.ToDateTime(Eval("selectfrom")) : (DateTime?)null  %>'
                                                                                  Width="70px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the From Date.">
                                                                                 <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                  CssClass="style2" Font-Names="verdana">
                                                                                 </Calendar>
                                                                                     <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                                     <DateInput ID="DateInput1" runat="server" DisplayDateFormat="dd-MM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                                         Font-Names="verdana" ReadOnly="true"> 
                                                                                          <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                                                     </DateInput>
                                                                                 </telerik:RadDatePicker>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="To Date" ItemStyle-Width="150" ItemStyle-HorizontalAlign ="Center" HeaderStyle-HorizontalAlign ="Center">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                 <telerik:RadDatePicker ID="gvraddateserto" runat="server" Culture="English (United Kingdom)" SelectedDate='<%# (Eval("selectto") != null && Eval("selectto") is DateTime) ? Convert.ToDateTime(Eval("selectto")) : (DateTime?)null %>'
                                                                                  Width="100px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Select the From Date.">
                                                                                 <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                  CssClass="style2" Font-Names="verdana">
                                                                                 </Calendar>
                                                                                     <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                                     <DateInput ID="DateInput1" runat="server" DisplayDateFormat="dd-MM-yyyy" DateFormat="dd-MM-yyyy" CssClass="style2"
                                                                                         Font-Names="verdana" ReadOnly="true">
                                                                                          <EmptyMessageStyle Resize="None" />
                                                                <ReadOnlyStyle Resize="None" />
                                                                <FocusedStyle Resize="None" />
                                                                <DisabledStyle Resize="None" />
                                                                <InvalidStyle Resize="None" />
                                                                <HoveredStyle Resize="None" />
                                                                <EnabledStyle Resize="None" />
                                                                                     </DateInput>
                                                                                 </telerik:RadDatePicker>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Value" ItemStyle-Width="100" ItemStyle-HorizontalAlign ="Right" HeaderStyle-HorizontalAlign ="Right">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblValue" runat="server" Text='<%# Eval("Value") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="txtValue" runat="server" Text='<%# Eval("Value") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                        </asp:TemplateField>                                                                                        
                                                                                        <asp:CommandField ShowEditButton="True" />
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                                 
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>

                                                                            </td>
                                                                        <td>
                                                                            <asp:Label ID="Label44" runat="Server" Text="In this screen, you can know what are the types of Services being provided by you, for the customer." ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                            <asp:Label ID="Label45" runat="Server" Text="The master list of services is pre-defined in the #Reference master." ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                            <asp:Label ID="Label46" runat="Server" Text="What happens if you provide a Service Not Listed here?" ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                            <asp:Label ID="Label47" runat="Server" Text="You can choose any Service from the #Service Reference, when assigning an activity to your personnel with reference to this customer." ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" F></asp:Label><br />
                                                                            <asp:Label ID="Label48" runat="Server" Text="Filling this screen is optional but will be helpful when billing." ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                            <asp:Label ID="Label49" runat="Server" Text="I don’t find the Service listed here?" ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                            <asp:Label ID="Label50" runat="Server" Text="The Service must be pre-defined first in the master. This can be done only by users in Level 1 or Level 2." ForeColor="Gray" Font-Names="Verdana" Font-Size="Smaller" ></asp:Label><br />
                                                                        </td>
                                                                        </tr>
                                                                    </table>
                                                            </div>
                                                        </div>
                                                                                                               
                                            </ContentTemplate>
                                        </telerik:RadWindow>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <telerik:RadWindow ID="rwChangeStatus" VisibleOnPageLoad="false" Width="700" Height="600" runat="server">
                                            <ContentTemplate>
                                                <div>


                                                    <table style="width:600px">
                                                        <tr style="text-align: center">
                                                            <td colspan="2">
                                                                <asp:Label ID="lblChangeStatusTitle1" runat="server" Text="Prospect Status Change" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblChangeStatusTitle2" runat="server" Text="A Prospect/Lead moves through different statuses in the sales cycle. You can update the status here." CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Names="Verdana" Font-Size="small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblName" runat="server" Text="Name" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCustomerName" runat="server" Text="Name" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <br />
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCurrentStatus" runat="server" Text="Current Status" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCurrentStatusName" runat="server" Text="Current Status" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblNewStatus" runat="server" Text="To be set as" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlNewStatus" runat="server" Width="155px" CssClass="style3" ToolTip="">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblComments" runat="server" Text="Write some comments" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtComments" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                    TextMode="MultiLine" MaxLength="400" ToolTip=""></asp:TextBox>
                                                                 <asp:Button ID="btnSSaveTime" Text="Update" runat="server"  CssClass="Button"
                                                                    BackColor="#6CA5BC" ToolTip="Click to Update the Status." Visible ="false" />
                                                               

                                                            </td>
                                                        </tr>
                                                        <tr style="width:300px">
                                                            <td style="width:150px">
                                                                <asp:Label ID="lblfupdate" runat="server" Text="Set a followup date" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Bold="true" Font-Names="Verdana"></asp:Label>
                                                             </td>
                                                            <td style="width:150px">                                                             
                                                            <telerik:RadDatePicker ID="dtpchangestatusfollowupdate" runat="server" Culture="English (United Kingdom)"
                                                            Width="100px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                                            <Calendar ID="Calendar3" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="style2" Font-Names="verdana">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput3" runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                Font-Names="verdana" ReadOnly="true">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                              
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label37" runat="server" Text="If a followupdate is set, you will be reminded on that date." CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Size ="Small" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: center" colspan="2">
                                                                <asp:Button ID="btnChangeStatusUpdate" Text="Update" OnClientClick="javascript:return ConfirmStatusUpdateMsg()" CausesValidation ="false" runat="server" OnClick="btnChangeStatusUpdate_Click" CssClass="Button"
                                                                    BackColor="#6CA5BC" ToolTip="Click to Update the Status." />
                                                                <asp:Button ID="btnChangeStatusClose" Text="Do Not Update" runat="server" CausesValidation ="false"  OnClick="btnChangeStatusClose_Click" CssClass="Button"
                                                                    BackColor="#6CA5BC" ToolTip="Click to exit without updating the status." />
                                                            </td>
                                                        </tr>

                                                    </table>
                                                    <table style="text-align:center; width:100% " >
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Label ID="lblhead" runat="server" Text="Status Update History" Font-Names="Verdana" Font-Size="Small" CssClass="style2"
                                                                    Font-Bold="true" ForeColor="DarkBlue"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align ="center">
                                                                <asp:GridView ID="gvStatusHistory" runat="server" AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Status" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                        <asp:BoundField HeaderText="On" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                        <asp:BoundField HeaderText="By" DataField="Createdby" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                    </Columns>
                                                                </asp:GridView><br />
                                                                <asp:Label ID="lbllsufstatus" runat="server" Text="" CssClass="style2" ForeColor="DarkGray"
                                                                    Font-Size ="Small" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </telerik:RadWindow>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <telerik:RadWindow ID="rwStatusHelp" Width="500" Height="200" VisibleOnPageLoad="false" Title ="Status codes and their meanings"
                                            runat="server" OpenerElementID="<%# btnstatushelp.ClientID  %>"  Style="z-index:7001" Modal ="true" >
                                        <ContentTemplate>
                                             <div>
                                                 <table>
                                                     <tr>
                                                         <td>
                                                             <asp:GridView ID="gvStatuHelp" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                                                PageSize="10" Font-Names="Calibri" Font-Size="X-Small"  ForeColor="DarkBlue">
                                                                                <Columns>
                                                                                  
                                                                                    <asp:BoundField HeaderText="Description" DataField="StatusDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    <asp:BoundField HeaderText="Code" DataField="StatusCode" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    
                                                                                    <asp:BoundField HeaderText="Remarks" DataField="StatusRemarks" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                </Columns>
                                                                            </asp:GridView>
                                                         </td>
                                                     </tr>
                                                 </table>
                                             </div>
                                        </ContentTemplate>     
                                        </telerik:RadWindow>
                     </td>                                    
                   </tr>
                    <tr>
                                    <td>
                                       <telerik:RadWindow ID="rwReferenceHelp" Width="400" Height="80" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnReferenceHelp.ClientID  %>" Modal ="true" >
                                            <ContentTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrefhelp" runat="server" Text="" Font-Names ="Verdana" Font-Size ="X-Small"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </telerik:RadWindow>
                                    </td>
                                </tr>
                </table>                           
                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <div style="float: left">
                                                    <div style="float: left">
                                                        <table cellpadding="3px">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTitle" runat="server" Text="Biz./Mr. :" CssClass="style3" Width="120"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlTitle" runat="server" Width="305px" CssClass="style3" ToolTip="Select Biz. if you are adding a company name.">
                                                                        <asp:ListItem Value=" " Text=" "></asp:ListItem>
                                                                        <asp:ListItem Value="Mr." Text="Mr."></asp:ListItem>
                                                                        <asp:ListItem Value="Mrs." Text="Mrs."></asp:ListItem>
                                                                        <asp:ListItem Value="Ms." Text="Ms."></asp:ListItem>
                                                                        <asp:ListItem Value="Dr." Text="Dr."></asp:ListItem>
                                                                        <asp:ListItem Value="Col." Text="Col."></asp:ListItem>
                                                                        <asp:ListItem Value="Biz." Text="Biz."></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:Button ID="btnAddNew" runat="server" Text="Clear" CssClass="btnSmallMainpage"
                                                                        Width="60px" OnClick="btnAddNew_Click" ToolTip="" CausesValidation ="false"  />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblCustName" runat="server" Text="Name :" CssClass="style3"></asp:Label>
                                                                    <asp:Label ID="lblAs" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Enter the name of the lead/prospect/customer/vendor etc. Max 40."></asp:TextBox>
                                                                </td>
                                                            </tr>                                                           
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblType" runat="server" Text="Type:" ForeColor="Gray" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlType" runat="server" Width="305px" CssClass="style3" ToolTip="Prospect/Customer/Vendor/Other?"
                                                                        OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                                                        <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                                                        <asp:ListItem Value="CUSTOMER" Text="CUSTOMER"></asp:ListItem>
                                                                        <asp:ListItem Value="VENDOR" Text="VENDOR"></asp:ListItem>
                                                                        <asp:ListItem Value="OTHER" Text="OTHER"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" Text="Status :" CssClass="style3" ForeColor="Gray"></asp:Label>
                                                                    <asp:Button ID="btnstatushelp" runat="server" Text="?" CssClass="btnSmallMainpage"
                                                                        Width="10px" OnClick="btnstatushelp_Click" ToolTip="" />
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlCCustStatus" runat="server" Width="305px" CssClass="style3"
                                                                        ToolTip="" BackColor="DarkBlue" ForeColor="White">
                                                                    </asp:DropDownList>
                                                                    <asp:Button ID="btnChangeStatus" runat="server" Text="Modify" CssClass="btnSmallMainpage" CausesValidation ="false"
                                                                        Width="60px" OnClick="btnChangeStatus_Click" ToolTip=" Click to update status of a prospect and view history of status updates.  Here you can also convert a prospect (lead) as a Customer, but that is allowed only for authorised users." />

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblProspectCompanyName" runat="server" Text="Company/MainContact:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCompanyName" runat="server" Width="300px" Font-Size="Medium"
                                                                        CssClass="style3" TextMode="SingleLine" MaxLength="100" ToolTip="Enter the name of the maincontact person. if you are adding a company's profile. Otherwise, add the name of the organisation where the person is employed. Max 100."></asp:TextBox>
                                                                    <asp:Button ID="btnContacts" runat="server" Text="+Contacts" CssClass="btnSmallMainpage" CausesValidation ="false"
                                                                        Width="60px" ToolTip="Click to add / update names and addresses of various person who can be contacted with reference to the profile." OnClick="btnContacts_Click" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblDoorNo" runat="server" Text="Door No/Street :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtDoorNo" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Enter address line. Max 40."></asp:TextBox>
                                                                    <asp:Button ID="btnservice" runat="server" Text="+Service" CssClass="btnSmallMainpage" CausesValidation ="false"
                                                                        Width="60px" ToolTip="What are the Services provided to this customer? Click here to find out/ to add." OnClick="btnservice_Click" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblStreet" runat="server" Text="Street/Area :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtStreet" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter Street or Area to be able to locate the address in a MAP.   Max 40."></asp:TextBox>
                                                                    <asp:Button ID="btnGoogleMap" runat="server" Text="Map" CssClass="btnSmallMainpage" CausesValidation ="false"
                                                                        Width="60px" OnClick="btnGoogleMap_Click" ToolTip="The address if complete, is displayed in a Map." />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPCity" runat="server" Text="City :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCity" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Type the city name. Max 40."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPostalCode" runat="server" Text="PIN Code :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPostalCode" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="20" ToolTip="Enter postal code. Max 20."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPState" runat="server" Text="State :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtState" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Max 40"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblCountry" runat="server" Text="Country :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlCountry" runat="server" Width="305px" CssClass="style3" ToolTip="Choose OTHERS if the country is not listed and type the country name in the field State above.">
                                                                        <asp:ListItem Text="INDIA" Value="INDIA"></asp:ListItem>
                                                                        <asp:ListItem Text="US" Value="US"></asp:ListItem>
                                                                        <asp:ListItem Text="AUSTRALIA" Value="AUSTRALIA"></asp:ListItem>
                                                                        <asp:ListItem Text="BAHRAIN" Value="BAHRAIN"></asp:ListItem>
                                                                        <asp:ListItem Text="CANADA" Value="CANADA"></asp:ListItem>
                                                                        <asp:ListItem Text="DUBAI" Value="DUBAI"></asp:ListItem>
                                                                        <asp:ListItem Text="FRANCE" Value="FRANCE"></asp:ListItem>
                                                                        <asp:ListItem Text="GERMANY" Value="GERMANY"></asp:ListItem>
                                                                        <asp:ListItem Text="MALAYSIA" Value="MALAYSIA"></asp:ListItem>
                                                                        <asp:ListItem Text="NEWZEALAND" Value="NEWZEALAND"></asp:ListItem>
                                                                        <asp:ListItem Text="OMAN" Value="OMAN"></asp:ListItem>
                                                                        <asp:ListItem Text="QATAR" Value="QATAR"></asp:ListItem>
                                                                        <asp:ListItem Text="SAUDIARABIA" Value="SAUDIARABIA"></asp:ListItem>
                                                                        <asp:ListItem Text="SINGAPORE" Value="SINGAPORE"></asp:ListItem>
                                                                        <asp:ListItem Text="SRILANKA" Value="SRILANKA"></asp:ListItem>
                                                                        <asp:ListItem Text="SWITZERLAND" Value="SWITZERLAND"></asp:ListItem>
                                                                        <asp:ListItem Text="OTHERS" Value="OTHERS"></asp:ListItem>
                                                                        <asp:ListItem Text="U.A.E" Value="U.A.E"></asp:ListItem>
                                                                    </asp:DropDownList>


                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPhoneNo" runat="server" Text="Phone No :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPhoneNo" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="20" ToolTip="Prefix with country code if a foreign no. Max 20."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblMob" runat="server" Text="Mobile No. :" CssClass="style3"></asp:Label>
                                                                    <asp:Label ID="lblmr" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                </td>
                                                                <td rowspan="2">
                                                                    <asp:TextBox ID="txtMob" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Prefix with country code if a foreign no. Max 40."></asp:TextBox>
                                                                    <asp:Button ID="btnSearchMobileNo" runat="server" Text="Check?" CssClass="btnSmallMainpage"
                                                                        Width="60px" ToolTip="Click to check if the Mobile No is already present or not."
                                                                        OnClick="btnSearchMobileNo_Click" />                                                                
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblEml" runat="server" Text="EmailID:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtEml" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter the main email id for correspondence. Max 80."></asp:TextBox>
                                                                    <br />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid EmailID"
                                                                        ControlToValidate="txtEml" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                                                    </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="txtEmamil2" runat="server" Text="EmailID2:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtEml2" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter an alternate EmailID. Max 80."></asp:TextBox>
                                                                    <br />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid EmailID"
                                                                        ControlToValidate="txtEml2" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                                                    </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblGender" runat="server" Text="Gender :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlGender" runat="server" Width="305px" CssClass="style3" ToolTip="Choose unknown">
                                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                                        <asp:ListItem Value="MALE" Text="MALE"></asp:ListItem>
                                                                        <asp:ListItem Value="FEMALE" Text="FEMALE"></asp:ListItem>
                                                                        <asp:ListItem Value="NOTKNOWN" Text="NOTKNOWN"></asp:ListItem>
                                                                        <asp:ListItem Value="NOTVALID" Text="NOTVALID"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblvipimp" runat="server" Text="Category :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlVipImp" runat="server" Width="305px" CssClass="style3" ToolTip="">
                                                                    </asp:DropDownList>
                                                                </td>                                                        
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblLeadSource" runat="server" Text="Lead Source :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlLeadSource" runat="server" Width="305px" CssClass="style3"
                                                                        ToolTip="A New source of lead can be added by the administrator(Level 1 or 2)">
                                                                    </asp:DropDownList>
                                                                    <asp:Button ID="btnNewLeadSource" runat="server" Text="New" CssClass="btnSmallMainpage" CausesValidation ="false"
                                                                        Width="60px" OnClick="btnNewLeadSource_Click" ToolTip="Click to add a new source of lead." />
                                                                    <asp:ImageButton ID="imgAddLeadSource" OnClick="imgAddLeadSource_Click" runat="server" CausesValidation ="false"
                                                                        ToolTip="Add a new source of lead" ImageUrl="~/Images/Actions-edit-add-icon2.png" Visible="false" />

                                                                    <telerik:RadWindow ID="rwLeadSource" Width="400" Height="400" VisibleOnPageLoad="false"
                                                                        runat="server" OpenerElementID="<%# btnNewLeadSource.ClientID  %>">
                                                                        <ContentTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td colspan="2" align="center">
                                                                                        <asp:Label ID="lbllstitle" runat="server" Text="Add a new source of lead" CssClass="style3"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblAddLeadKey" runat="server" Text="LeadSource :" CssClass="style3"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtAddLeadKey" runat="server" Width="200px" Font-Size="Medium" CssClass="style3"
                                                                                            TextMode="SingleLine" MaxLength="40" ToolTip="Enter a new  lead source(Ex:Walkin). Max 40.[LeadKey]"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>

                                                                                <td colspan="2" align="center">
                                                                                    <asp:Button ID="btnLSSave" runat="server" Text="Save" CssClass="Button" Width="50px"
                                                                                        OnClick="btnLSSave_Click" OnClientClick="javascript:return ConfirmMsg()" ToolTip="Click to save the details entered." />
                                                                                    <asp:Button ID="btnLSClear" runat="server" Text="Clear" CssClass="Button" Width="50px"
                                                                                        OnClick="btnLSClear_Click" ToolTip="Click to clear the details entered." />
                                                                                    <asp:Button ID="btnLSClose" runat="server" Text="Close" CssClass="Button" Width="50px"
                                                                                        OnClick="btnLSClose_Click" ToolTip="Click here to return back." />
                                                                                </td>
                                                                                <tr>
                                                                                    <td colspan="2" align="center">
                                                                                        <br />
                                                                                        <asp:GridView ID="gvMLeadSource" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                                                            PageSize="10" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="onLeadSourcePaging">
                                                                                            <Columns>
                                                                                                <asp:BoundField HeaderText="Lead Source" DataField="Leadkey" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                    HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                                                    SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                                                <asp:BoundField HeaderText="Description" DataField="LeadValue" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                    HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                                                    ItemStyle-Width="100px" />
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ContentTemplate>
                                                                    </telerik:RadWindow>
                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblCompaign" runat="server" Text="Campaign :" CssClass="style3"></asp:Label>
                                                                    <br />
                                                                    <br />
                                                                </td>
                                                                <td rowspan ="2">
                                                                    <asp:DropDownList ID="ddlCompaign" runat="server" Width="305px" CssClass="style3"
                                                                        ToolTip="A New Campaign can be added by the administrator">
                                                                    </asp:DropDownList><br />
                                                                    <asp:Label ID="Label20" runat="server" Text="An Email will be sent to this lead when you save the profile. if the EMAIL flag for the selected Campaign is set as Yes"  ForeColor ="Gray" Font-Size ="X-Small"  Font-Names ="Calibri" Width ="320px"></asp:Label>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblBudget" runat="server" Text="Budget :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlBudget" runat="server" Width="305px" CssClass="style3" ToolTip="A New budget value can be added by the administrator.">
                                                                    </asp:DropDownList>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblProjectCode" runat="server" Text="Reference:" CssClass="style3" Visible="False"></asp:Label>
                                                                </td>
                                                                <td>

                                                                    <asp:DropDownList ID="ddlTrackon" runat="server" Width="305px" CssClass="style3" ToolTip="Select an appropriate reference code." Visible="False">
                                                                    </asp:DropDownList>

                                                                    <asp:Button ID="btnReferenceHelp" runat="server" Text="Help?" CausesValidation ="false" CssClass="btnSmallMainpage" OnClick="btnReferenceHelp_Click" Width="60px" Visible="False" />

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblACManager" runat="server" Text="A/C Manager:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlACManager" runat="server" Width="305px" CssClass="style3" ToolTip="Select A/C Manager/SalesExecutive.">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblReq" runat="server" Text="Requirements :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtReq" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="MultiLine" MaxLength="400" ToolTip="Write here the requirements specified by the lead. Max 400."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblNotes" runat="server" Text="Notes :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtNotes" runat="server" Width="300px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="MultiLine" MaxLength="2400" ToolTip="Write a brief note on your interaction with the Lead/Customer. This entry also saved in the Work diary.Max 400."></asp:TextBox>
                                                                    
                                                                     <br />
                                                                <asp:DropDownList ID="ddlsavetime" runat="server" Width ="280px" CssClass="style3" ToolTip="Select from a standard picklist of frequently used sentences and press the + button.">
                                                                </asp:DropDownList>
                                                                <asp:ImageButton ID="btnimgaddsavetime" runat="server" CausesValidation ="false"  OnClick ="btnimgaddsavetime_Click" ImageUrl="~/Images/Actions-edit-add-icon2.png" ToolTip ="Select from a standard picklist of frequently used sentences and press the + button." />
                                                                    <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="btnSmallMainpage" OnClick="btnSaveTime_Click"
                                                                        ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." />

                                                                </td>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>

                                                                        <telerik:RadWindow ID="rwSaveTime" VisibleOnPageLoad="false" Width="280px" runat="server" Height ="250px"
                                                                            OpenerElementID="<%# btnSaveTime.ClientID  %>" Title="Save Time">
                                                                            <ContentTemplate>
                                                                                
                                                                                <table cellpadding ="3">
                                                                                     <tr>
                                                                                         <td align="center" >
                                                                                            <asp:Label ID="lblInfo" runat="server" Text="Add to PickList to SaveTime" ForeColor ="Green" Font-Bold="true"  Width="160px" CssClass="style2" Font-Names ="Calibri"></asp:Label>

                                                                                        </td>
                                                                                     </tr>
                                                                                     <tr>
                                                                                        
                                                                                        <td align ="center">
                                                                                            <asp:TextBox ID="txtInfo" runat="server" Width="200px" MaxLength="80"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                   
                                                                                    <tr>
                                                                                        <td  align="center">
                                                                                            <asp:Button ID="btnSTSave" runat="server" Text="Save" CssClass="Button" OnClick="btnSTSave_Click" OnClientClick="javascript:return ConfirmSave()"
                                                                                                ToolTip="Write a sentence to be added to the PickList and click Save." />
                                                                                            <asp:Button ID="btnSTClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnSTClear_Click" ToolTip="Click to Clear what you have written above." />
                                                                                            <asp:Button ID="btnSTClose" runat="server" Text="Close" CssClass="Button" OnClick="btnSTClose_Click" ToolTip="Click to return back to previous page." />
                                                                                            
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                         <td colspan="2" align="center">
                                                                                             
                                                                                            <asp:GridView ID="gvSaveTime" runat="server" AutoGenerateColumns="false" OnRowCommand="gvSaveTime_RowCommand" CssClass ="gridview_borders">
                                                                                                <Columns>
                                                                                                    <asp:BoundField HeaderText="PickList" DataField="Savetimeentry" ReadOnly="true" HeaderStyle-BackColor="DarkBlue" 
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Calibri"
                                                                                                        ItemStyle-Width="200px" ItemStyle-ForeColor="Black"  HeaderStyle-HorizontalAlign="left" />
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                    </tr>
                                                                                </table>
                                                                               
                                                                                
                                                                            </ContentTemplate>
                                                                        </telerik:RadWindow>

                                                                        <telerik:RadWindow ID="rwSSavetime" VisibleOnPageLoad="false" Width="600px" runat="server"
                                                                            OpenerElementID="<%# btnSSaveTime.ClientID  %>">
                                                                            <ContentTemplate>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td colspan="2" align="center">
                                                                                            <asp:Label ID="Label14" runat="server" Width="350px" Text="Save time by selecting from the list"
                                                                                                CssClass="style2"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="2" align="center">
                                                                                            <asp:GridView ID="gvSSaveTime" runat="server" AutoGenerateColumns="false" >
                                                                                                <Columns>
                                                                                                    <asp:TemplateField HeaderText="Select" HeaderStyle-BackColor="Blue" HeaderStyle-ForeColor="White"
                                                                                                        ItemStyle-HorizontalAlign="Center">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:ImageButton ID="imgSelect" Width="20px" Height="20px" runat="server" ImageUrl="~/Images/Select.ico"
                                                                                                                CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CommandName="Select" />
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:BoundField HeaderText="PickList" DataField="Savetimeentry" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Condra"
                                                                                                        ItemStyle-Width="200px" ItemStyle-ForeColor="Blue" HeaderStyle-HorizontalAlign="left" />
                                                                                                    <asp:BoundField HeaderText="Remarks" DataField="Remarks" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Condra"
                                                                                                        ItemStyle-Width="200px" ItemStyle-ForeColor="Blue" HeaderStyle-HorizontalAlign="left" />
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="Label15" runat="server" Text="Add to PickList to SaveTime :" Width="180px" CssClass="style2"></asp:Label>

                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtpicklist" runat="server" Width="200px" MaxLength="80"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="Label18" runat="server" Text="Remarks :" Width="100px" CssClass="style2"></asp:Label>

                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtsremarks" runat="server" Width="200px" MaxLength="240" TextMode="MultiLine"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="2" align="center">
                                                                                            <asp:Button ID="btnSSTSave" runat="server" Text="Save" CssClass="Button"
                                                                                                ToolTip="Write a sentence to be added to the PickList and click Save." />
                                                                                            <asp:Button ID="btnSSTClear" runat="server" Text="Clear" CssClass="Button"  ToolTip="Clickto return back to previous page." />
                                                                                            <asp:Button ID="btnSSTClose" runat="server" Text="Close" CssClass="Button" ToolTip="Click to Clear what you have written above" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ContentTemplate>
                                                                        </telerik:RadWindow>
                                                                    </td>
                                                                </tr>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lblnotesentry" runat="server" Text="" CssClass="style3" ForeColor="DarkBlue"
                                                                        Font-Names="Calibri" Font-Size="Smaller" Width="400"></asp:Label>
                                                                </td>
                                                            </tr>


                                                        </table>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnCSave" runat="server" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                                        OnClick="btnCSave_Click" OnClientClick="javascript:return ConfirmMsg()" ToolTip="Click to save the profile. If you have written something in Notes field, the same will reflect in the Activities w.r.t the profile." />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCUpate" runat="server" Text="Update" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                                        OnClick="btnCUpdate_Click" OnClientClick="javascript:return ConfirmUpdateMsg()" ToolTip="Click to updated the details entered." />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCClear" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                                        OnClick="btnCClear_Click" ToolTip="Click to clear the details entered." CausesValidation ="false"  />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="A Lead or Prospect is one who has shown an interest in doing business with us."></asp:Label><br />
                                                                    <asp:Label ID="Label2" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="A Customer is one who has signed up for business with us."></asp:Label><br />
                                                                    <asp:Label ID="Label3" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="A Vendor is one from whom we have purchased some produt/service."></asp:Label><br />
                                                                    <asp:Label ID="Label5" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="Others are third parties with whom we have some business association."></asp:Label><br />
                                                                    <asp:Label ID="Label6" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="This screen is for adding/managing their profiles"></asp:Label><br />
                                                                    <asp:Label ID="Label7" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="A STATUS helps us to track the sales cycle for a lead/prospect."></asp:Label><br />
                                                                    <asp:Label ID="Label8" runat="server" Font-Names="Calibri" Font-Size="Small" ForeColor="DarkBlue"
                                                                        Text="The Status can be set only when adding a new profile."></asp:Label><br />

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div style="float: left;">                                                       
                                                       
                                                        <table>
                                                           
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblSearch" runat="server" Text="Select from : " CssClass="style2" Font-Bold="true"></asp:Label>
                                                                    <br />
                                                                    <asp:DropDownList ID="ddlSearchType" runat="server" Width="200px" CssClass="style3" Font-Names="verdana" Font-Size="Small"
                                                                        ToolTip="Search in one of the selected customers/prospect types. (Recent - Show records of all types added in last 3 days. Leads-0REG,1ENQ,3ASE)">
                                                                        <asp:ListItem Text="Recently Added" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Not yet Hot Leads" Value="2"></asp:ListItem>
                                                                        <asp:ListItem Text="Qualified Leads" Value="3"></asp:ListItem>
                                                                        <asp:ListItem Text="Customers" Value="4"></asp:ListItem>
                                                                        <asp:ListItem Text="Vendors" Value="5"></asp:ListItem>
                                                                        <asp:ListItem Text="Others" Value="6"></asp:ListItem>
                                                                        <asp:ListItem Text="Cold Leads" Value="7"></asp:ListItem>
                                                                        <asp:ListItem Text="All Prospects & Customers" Value="8"></asp:ListItem>
                                                                        <asp:ListItem Text="Active Now" Value="9"></asp:ListItem>

                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="server" Text="Name : " CssClass="style2" Font-Bold="true"></asp:Label>
                                                                    <br />
                                                                    <asp:TextBox ID="txtSearchProspect" runat="server" Width="110px" Font-Size="Medium"
                                                                        CssClass="style3" TextMode="SingleLine" ToolTip="Enter part of a name to search from the list below."></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label73" runat="server" Text="Mobile : " CssClass="style2" Font-Bold="true"></asp:Label>
                                                                    <br />
                                                                    <asp:TextBox ID="txtSearchMobile" runat="server" Width="110px" Font-Size="Medium"
                                                                        CssClass="style3" TextMode="SingleLine" ToolTip="Enter part of a mobile no to search from the list below."></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <br />
                                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnSmallMainpage" Width="50px"
                                                                        ToolTip="Click to Search the details." OnClick="btnSearch_Click" />

                                                                    <asp:Button ID="btnSearchClear" runat="server" Text="Clear" CssClass="btnSmallMainpage" Width="40px"
                                                                        ToolTip="Click to show all prospect details." OnClick="btnSearchClear_Click" />    
                                                                    
                                                                    <asp:Button ID="btnHelp" runat="server" Text="Help" CssClass="btnSmallMainpage" Width="40px"
                                                                        ToolTip="Click to show the help of customer details" OnClick="btnHelp_Click" />                                                                 

                                                                     <asp:Label ID="lbltotalcount" runat="server" Text="" ForeColor="Green" Font-Size="Medium"
                                                                        Font-Names="Calibri" Font-Bold="true"></asp:Label>                                                                 
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td td colspan="4" style="text-align:left"">
                                                                    <asp:Label ID="Label19" runat="server" Text="Active Now - Customers for whom presently activities are in progress. Recently Added - Shows profiles added in last 3 days." ForeColor="Gray" Font-Size="X-Small" 
                                                                        Font-Names="Calibri"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td td colspan="4" style="text-align: center">
                                                                    <asp:Label ID="lblnrf" runat="server" Text="No Records Found" ForeColor="Red" Font-Size="Medium"
                                                                        Font-Names="Calibri" Font-Bold="true"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <div style="max-width:500px;min-width:500px;">
                                                                    <asp:GridView ID="gvProspectDetails" HeaderStyle-Width="500px" RowStyle-Width="500px" runat="server" AutoGenerateColumns="false" OnRowCommand="gvProspectDetails_RowCommand" Width="500px"
                                                                        AllowPaging="true" PageSize="20" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" CssClass="gridview_borders"
                                                                        OnPageIndexChanging="gvProsepctDetails_PageIndexChanging" DataKeyNames="RSN" ToolTip="" RowStyle-Wrap="false" HeaderStyle-Wrap="false"
                                                                        OnRowDataBound="gvProspectDetails_RowDataBound" OnRowCreated="gvProspectDetails_RowCreated">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Edit" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="30px" HeaderStyle-Width="30px">
                                                                                <ItemStyle CssClass="gridview_borders" HorizontalAlign ="Center" />
                                                                                <ItemTemplate>
                                                                                   <%-- <asp:ImageButton ID="imgEdit" runat="server" AlternateText="E" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                        CommandName="Select" />--%>
                                                                                    <asp:LinkButton ID="imgEdit" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                        CommandName="Select">E</asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Activities" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="50px" HeaderStyle-Width="50px">
                                                                                <ItemStyle CssClass="gridview_borders" />
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkDiary" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                        Text="Diary" CommandName="Diary" ToolTip="">View </asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="NewTask" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px" HeaderStyle-Width="30px">
                                                                                <ItemStyle CssClass="gridview_borders" />
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkNewTask" runat="server" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                        Text="AddNewTask" CommandName="NewTask" ToolTip="">Add</asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Wrap="true"
                                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="gridview_borders" />
                                                                             <asp:BoundField HeaderText="Contact" DataField="CompanyName" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Width="80px" HeaderStyle-Width="50px"
                                                                                HeaderStyle-ForeColor="White"  ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="true" />
                                                                            <asp:BoundField HeaderText="Status" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Width="80px" HeaderStyle-Width="60px"
                                                                                HeaderStyle-ForeColor="White" Visible="false" ItemStyle-CssClass="gridview_borders" />
                                                                            <asp:BoundField HeaderText="MobileNo" DataField="Mobile" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="gridview_borders" />
                                                                            <asp:TemplateField HeaderText="Status" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White">
                                                                                <ItemStyle CssClass="gridview_borders" />
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblType" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderText="Fwup" DataField="Followupdate" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Wrap="true"
                                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="gridview_borders" />                                                                           
                                                                        </Columns>
                                                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                                                    </asp:GridView>
                                                                        </div>
                                                                    <telerik:RadWindow ID="rwDiary" VisibleOnPageLoad="false" Width="1000" MinHeight="400"  
                                                                        runat="server" EnableShadow ="true" EnableEmbeddedSkins ="false" Modal ="true"  >
                                                                        <ContentTemplate>
                                                                            <div>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td align="left" >
                                                                                          
                                                                                            <asp:Label ID="lbldiaryheadName" runat="server" Text="" CssClass="style2" ForeColor="DarkBlue"
                                                                                                Font-Bold="true" Font-Size="Medium"></asp:Label>
                                                                                          
                                                                                        </td>
                                                                                        <td align ="right">
                                                                                             <asp:Label ID="lbldiarycount" runat="server" Text="" Font-Names ="Calibri" Font-Bold ="true" ForeColor ="Green"></asp:Label>
                                                                                            <asp:Button ID="btnDiaryClose" runat="server" Text="Close" CssClass="Button" Width="50px"
                                                                                                ToolTip="Click to return to Profile page." OnClick="btnDiaryClose_Click" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    
                                                                                    <tr>
                                                                                        <td align="center" colspan ="2">
                                                                                            <asp:GridView ID="gvDiary" runat="server" AutoGenerateColumns="false" OnDataBound="onDataBound" 
                                                                                                AllowPaging="true" PageSize="10" OnPageIndexChanging="OnDiaryPaging">
                                                                                                <Columns>
                                                                                                   <%-- <asp:BoundField HeaderText="#" DataField="TaskID" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />--%>
                                                                                                    
                                                                                                   <asp:TemplateField HeaderText ="#" HeaderStyle-BackColor="DarkBlue" HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small"
                                                                                                       ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" >
                                                                                                   <ItemTemplate>
                                                                                                       <asp:LinkButton ID="lbltaskid" runat ="server" Text ='<%# Eval("TaskID") %>'  ></asp:LinkButton>
                                                                                                  
                                                                                                    </ItemTemplate>
                                                                                                    </asp:TemplateField>


                                                                                                   <asp:BoundField HeaderText="Reference" DataField="TrackOn" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                                                                                        ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Activity" DataField="Comments" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                                                        HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="400px"
                                                                                                        ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" />
                                                                                                    <asp:BoundField HeaderText="Date and Time" DataField="Datestamp" DataFormatString ="{0:dd-MMM-yyyy HH:mm 'Hrs'}" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
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
                                                                                            </asp:GridView><br />
                                                                                           <%-- <asp:Label ID="Label19" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Activity IDs in BLUE are currently in progress."></asp:Label><br />--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                    </telerik:RadWindow>
                                                                </td>
                                                            </tr>
                                                            <caption>
                                                                <br />
                                                                <br />
                                                            </caption>
                                                        </table>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>                
                              
                </ContentTemplate>
                 <Triggers>                      
                           
                            <asp:PostBackTrigger ControlID="gvProspectDetails" />
                            <asp:AsyncPostBackTrigger ControlID ="btnstatushelp" EventName ="Click" />                            
                            <asp:AsyncPostBackTrigger ControlID="btnChangeStatus" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnAddNew" EventName="Click" />
                            <asp:PostBackTrigger ControlID="btnSearchMobileNo" />
                            <asp:PostBackTrigger ControlID="btnCSave" />
                            <asp:PostBackTrigger ControlID="btnCUpate" />
                            <asp:PostBackTrigger ControlID="btnGoogleMap" />                        
                            
                        </Triggers>
            </asp:UpdatePanel>
             <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
            <ProgressTemplate>
                <div class="modal">
                    <div class="center">
                        <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        </tr>
    </table>
      <table>
        <tr>
            <td>
                <asp:HiddenField ID="HDUserLevel" runat="server" />
                <asp:HiddenField ID="HDUserID" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="HDLoginUser" runat="server" />
                <asp:HiddenField ID="CnfResult" runat="server" />
                <asp:Label ID="Label21" runat="server" Text="Label" Style="display: none"></asp:Label>                
            </td>
        </tr>
    </table>
</asp:Content>

