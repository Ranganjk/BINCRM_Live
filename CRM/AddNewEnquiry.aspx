<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewEnquiry.aspx.cs" Inherits="AddNewEnquiry" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />     

    <script language="javascript" type="text/javascript">
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
                var subbuttonid = buttonid.substring(0, 28);
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
            //alert('test');
            window.opener.ConfirmClick();
            window.close();
        }
        function CloseWindow1() {
            //alert('test');
            window.opener.ConfirmClick();
        }
    </script>

    <title>Add New Enquiry</title>
</head>
<body  onunload="CloseWindow1()"  style ="background-color:beige;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager3" runat="server">
        </asp:ScriptManager>

         <telerik:RadWindowManager runat="server" ID="RadWindowManager1"></telerik:RadWindowManager>

        <script type="text/javascript">
            function confirmCallbackFn(arg) {
                if (arg) //the user clicked OK
                {
                    __doPostBack("<%=HiddenButton.UniqueID %>", "");
                }
            }
        </script>
        
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



        <div>
            <asp:HiddenField ID="CnfResult" runat="server" />

            <asp:UpdatePanel ID="upAddNewTask" runat="server" UpdateMode="Always">

                <ContentTemplate>

                    <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />

                    <table style ="width:100% ">
                        <tr>
                            <td align="left" width="65%">
                                <asp:Label ID="lblHeading" runat="server" Text="Register a new enquiry." Font-Size="Large"
                                    ForeColor="#003366" Font-Names="verdana"></asp:Label>
                                <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click"
                                    ToolTip="" />
                                 <asp:Label ID="Label23" runat="server" Text="(A new enquiry number is automatically assigned.)" Font-Size="X-Small"
                                    ForeColor="Gray"  Font-Names="verdana"></asp:Label>

                            </td>
                         
                        </tr>
                    </table>
                    <table style ="width:100% ">
                        <tr>
                            
                            <td>
                                <telerik:RadWindow ID="rwHelp" Width="600" Height="400" VisibleOnPageLoad="false"
                                    runat="server" OpenerElementID="<%# btnHelp.ClientID  %>">
                                    <ContentTemplate>
                                        <table>
                                            <tr>
                                                <td style="font-size:small; color: Green; font-weight: bold; font-family:Verdana">Add a new task / activity
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color:black; font-family: Verdana">Task, Activity, Work , Notes all mean the same in our system.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Task is with reference to a Prospect or a Customer or a Vendor or any one else. 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">A Task is also with reference to a Product or a Service or Work Type.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Here one can assign a new Work or Activity or Task to self or to some one else.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">This could also be a note about some work done and completed.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">The name you choose can be a Prospective Lead  or an existing customer or a Vendor or even your own organisaton.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">The Reference part indicates the purpose (subject)  for which this interaction is. The reference can be with regard to a Product or a Service or an anything General.
                These must have been defined earlier.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: Green; font-weight: bold; font-family: Verdana">Examples: 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Assigning the task of following up with a customer for Payments
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Assigning the work of calling a new lead (prospective customer) to know more about her requirements
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Recording a followup entry done with a customer for a specific product.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color:darkblue; font-weight: bold; font-family: Verdana">What happens if you are dealing on multiple references with a customer? 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">Record them as individual entries
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: darkblue; font-weight: bold; font-family: Verdana">Where do I record further interactions on the same subject for the same customer?
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: black; font-family: Verdana">You have to use the Update option after selecting the Work Entry.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: darkblue; font-weight: bold; font-family: Verdana">Can  I skip the Customer Name ?
                <tr>
                    <td style="font-size: small; color: black; font-family: Verdana">No you cannot.  Any activity is with reference to someone registered as a Customer or a Prospect or a Vendor or Others.
                    </td>
                </tr>
                                                    <tr>
                                                        <td style="font-size: small; color: darkblue; font-weight: bold; font-family: Verdana">What is the meaning of Task Status?
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size: small; color: black; font-family: Verdana">A Task or Work Status can be any of the following three:
                <tr>
                    <td style="font-size: small; color: black; font-family: calibri">Yet to Start - Work is scheduled and yet to begin.
                    </td>
                </tr>
                                                            <tr>
                                                                <td style="font-size: small; color: black; font-family: Verdana">In Progress – Work is going on and yet to complete.
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: small; color: black; font-family: Verdana">Completed -  Work is now completed.
                                                                </td>
                                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </telerik:RadWindow>
                            </td>
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
                    
                    <table style ="width:100%;">                       
                        <tr>                           
                            <td >
                                <asp:Label ID="Label11" runat="server" Text="Type:" CssClass="style2"></asp:Label>

                            </td>
                            <td >
                                <asp:DropDownList ID="ddlType" runat="server"
                                    AutoPostBack="true" Width="300px" ToolTip="If you select  PROSPECT, all LEADS except COLD and DROPPED Leads are displayed.
                                   If you select CUSTOMER, all Customer names are displayed.
                                   If you select COLD LEADS, all Leads in COLD and DROPPED Status are displayed."
                                    OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                    <asp:ListItem Value="CUSTOMER" Text="CUSTOMER"></asp:ListItem>
                                    <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                    <asp:ListItem Value="VENDOR" Text="VENDOR"></asp:ListItem>
                                    <asp:ListItem Value="OTHER" Text="OTHER"></asp:ListItem>
                                    <asp:ListItem Value="COLD LEADS" Text="COLD LEADS"></asp:ListItem>
                                </asp:DropDownList>
                            </td>

                           
                        </tr>
                        <tr>                           
                            <td>
                                <asp:Label ID="lblCustName" runat="server" Text="Name" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCustName" runat="server" OnSelectedIndexChanged ="ddlCustName_SelectedIndexChanged"
                                    AutoPostBack="true" Width="300px" ToolTip="">
                                </asp:DropDownList>
                            </td>                           
                        </tr>
                         <tr>
                            <td>
                                <asp:Label ID="lblcontactname" runat="server" Text="Contact Name" Visible="false" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlContactName" runat="server" Visible="false"
                                    ToolTip="select your contacts name">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Assigned To" CssClass="style2"></asp:Label>
                                <asp:Label ID="lblash1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAssignedTo" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="Group" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlReferenceGroup" runat="server" ToolTip="Choose the group in which the # ref resides." AutoPostBack ="true" OnSelectedIndexChanged ="ddlReferenceGroup_SelectedIndexChanged">
                                    <asp:ListItem Text ="Marketing" Value ="Marketing"></asp:ListItem>
                                    <asp:ListItem Text ="General" Value ="General"></asp:ListItem>
                                    <asp:ListItem Text ="Projects" Value ="Projects"></asp:ListItem>
                                </asp:DropDownList>
                                
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Reference" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrackon" runat="server" ToolTip="Select an appropriate reference code." OnSelectedIndexChanged="ddlTrackon_SelectedIndexChanged" AutoPostBack ="true" >
                                </asp:DropDownList>
                                <asp:Button ID="btnReferenceHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnReferenceHelp_Click" Width="60px"
                                    ToolTip="" />
                                 <br />
                                 <asp:Label ID="lblcrefremarks" runat="server" Text="" Font-Names="Verdana" Font-Size="Small"  BackColor="Yellow" ForeColor="Black"></asp:Label>
                            </td>
                          
                        </tr>
                        <tr>
                            
                            
                            <td>
                               <asp:Label ID="lblCustStatus" runat="server" Text="Status" CssClass="style2" Visible="false"></asp:Label>
                                <asp:Label ID="lblash5" runat="server" Text="*" ForeColor="Red" Visible="false" Width="73px"></asp:Label>
                            </td>
                            <td >
                                
                                <asp:DropDownList ID="ddlCustStatus" runat="server" Visible="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="Enquiry Details" CssClass="style2"></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td >
                                <asp:TextBox ID="txtTaskAssigned" runat="server" TextMode="MultiLine" Rows="4" Columns="40" ToolTip="What is the work to be done with ref to the customer/lead. Write it here.   Use SaveTime to choose standard wordings from a predefined list."></asp:TextBox><br />
                                <asp:DropDownList ID="ddlsavetime" runat="server" Width="280px" ToolTip="Select from a standard picklist of frequently used sentences and press the + button.">
                                </asp:DropDownList>
                                <asp:ImageButton ID="btnimgaddsavetime" runat="server" OnClick="btnimgaddsavetime_Click" ImageUrl="~/Images/Actions-edit-add-icon2.png" ToolTip="Select from a standard picklist of frequently used sentences and press the + button." />
                                <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                    OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." />
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
                            <%--<td>
                                <asp:Button ID="btnNCSave" runat="server" Text="Save" CssClass="Button" OnClick="btnNCSave_Click"
                                    Visible="false" OnClientClick="ConfirmMsg()" />
                                <asp:Button ID="btnNCClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnNCClear_Click"
                                    Visible="false" />
                            </td>--%>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Assigned On" CssClass="style2"></asp:Label>
                                <asp:Label ID="Label19" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="dtpAssignOnDate" runat="server" Culture="English (United Kingdom)"
                                    Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" ToolTip ="The date on which the activity is assigned. Current date is shown by default.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="style2" Font-Names="verdana" Visible="false">
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
                                <asp:Label ID="Label6" runat="server" Text="Assigned By" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAssignedBy" runat="server" ToolTip="Select the person who assigned. Your ID appears by default.">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                           
                            <td>
                                <asp:Label ID="Label7" runat="server" Text="Target Date" CssClass="style2"></asp:Label>
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
                            </td>
                        </tr>
                        <tr>
                           
                            <td>
                                <asp:Label ID="Label9" runat="server" Text="Followup Date" CssClass="style2"></asp:Label>

                            </td>
                            <td>
                                <telerik:RadDatePicker ID="dtpFollowupdate" runat="server" Culture="English (United Kingdom)"
                                    Width="160px" CssClass="style2" ToolTip="Set a date by which you wish a followup  reminder to be  emailed to the assignee on the morning of the followup date. A mail with a Calendar link is also sent to the assignee as soon as this activity is saved."
                                    Font-Names="verdana" ReadOnly="true">
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
                                <asp:Label ID="Label8" runat="server" Text="Additional Remarks" CssClass="style2"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOtherAssignees" runat="server" TextMode="MultiLine" Rows="4"
                                    Columns="40" ToolTip="Write here any addnl.comments or names of other persons involved."></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <asp:Label ID="Label12" runat="server" Text="Priority" CssClass="style2"></asp:Label>
                                <asp:Label ID="Label21" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPriority" runat="server" ToolTip="Set the priority of the activity. Hot or VeryHot are for high priority activities">
                                </asp:DropDownList>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button" OnClick="btnSave_Click"
                                    OnClientClick="return ConfirmMsg()" ToolTip=" Click to Save this new task assigned." />
                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnClear_Click"
                                    ToolTip=" Click to clear the details entered and to re-enter again." />
                                <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="Button" OnClientClick="CloseWindow()"
                                    ToolTip=" Click to return to the Tasks list.  Have you pressed Save?" OnClick="btnClose_Click" />
                            </td>
                        </tr>
                        <tr>

                            <td colspan="2">
                                <asp:Label ID="Label10" runat="server" Text=" The work assigned will be informed to the concerned person, by Email. It will also appear in his/her Tasks List."
                                    CssClass="label2"></asp:Label>
                            </td>
                        </tr>
                            <tr>
                                <td colspan="2">
                                <asp:Label ID="Label22" runat="server" Text="If you set a followup date, a Calendar Link mail will be sent to the assignee immediately.  A reminder mail will be sent to the assignee, one day before."  CssClass="label2"></asp:Label>
                            </td>
                                
                            </tr>
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

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnClose" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSaveTime" EventName="Click" />
                    <asp:PostBackTrigger ControlID ="ddlTrackOn" />
                    <asp:PostBackTrigger ControlID="HiddenButton" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
