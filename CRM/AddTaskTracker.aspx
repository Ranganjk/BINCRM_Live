<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTaskTracker.aspx.cs" Inherits="AddTaskTracker" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">  

    <link href="css/btnCSS.css" rel="stylesheet" />
     <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" /> 

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

     <style type="text/css">
         .preference .rwWindowContent {
             background-color: beige !important;
         }

         .availability .rwWindowContent {
             background-color: Yellow !important;
         }
     </style>
    <style type="text/css">
        .Radwindow {
            height: auto;
            width: auto;
            min-height: 450px;
            min-width: 950px;
            background-color: beige;
        }
    </style>

    <title>Bin CRM</title>
</head>
<body onunload="CloseWindow1()"  style ="background-color:beige;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
            

        </telerik:RadWindowManager>

        <script type="text/javascript">
            function confirmCallbackFn(arg) {
                if (arg) //the user clicked OK
                {
                    __doPostBack("<%=HiddenButton.UniqueID %>", "");
                }
                
            }
        </script>

        <script type="text/javascript">
            function confirmStatusCallbackFn(arg) {
                if (arg) //the user clicked OK
                {
                    __doPostBack("<%=HiddenStatusButton.UniqueID %>", "");
                }
            }
        </script>

        <script language="javascript" type="text/javascript">

            function Navigate() {
                var iMyWidth;
                var iMyHeight;
                iMyWidth = (window.screen.width / 2) - (325 + 10);
                iMyHeight = (window.screen.height / 2) - (100 + 35);
                var X = 5;
                var Z = 6;
                var Y = 'CalculateTime.aspx?TTID=' + X + '&UserID=' + Z;
                var win2 = window.open(Y, "Window3", "status=no,height=270,width=600,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
                win2.focus();
            }

            function fun_AllowOnlyAmountAndDot(txt) {
                if (event.keyCode > 47 && event.keyCode < 58 || event.keyCode == 46) {
                    var txtbx = document.getElementById(txt);
                    var amount = document.getElementById(txt).value;
                    var present = 0;
                    var count = 0;

                    if (amount.indexOf(".", present) || amount.indexOf(".", present + 1));
                    {
                        // alert('0');
                    }

                    /*if(amount.length==2)
                    {
                    if(event.keyCode != 46)
                    return false;
                    }*/
                    do {
                        present = amount.indexOf(".", present);
                        if (present != -1) {
                            count++;
                            present++;
                        }
                    }
                    while (present != -1);
                    if (present == -1 && amount.length == 0 && event.keyCode == 46) {
                        event.keyCode = 0;
                        //alert("Wrong position of decimal point not  allowed !!");
                        return false;
                    }

                    if (count >= 1 && event.keyCode == 46) {

                        event.keyCode = 0;
                        //alert("Only one decimal point is allowed !!");
                        return false;
                    }
                    if (count == 1) {
                        var lastdigits = amount.substring(amount.indexOf(".") + 1, amount.length);
                        //                    if (lastdigits.length >= 2) {
                        //                        //alert("Two decimal places only allowed");
                        //                        //event.keyCode = 0;
                        //                        return false;
                        //                    }
                    }
                    return true;
                }
                else {
                    event.keyCode = 0;
                    //alert("Only Numbers with dot allowed !!");
                    return false;
                }

            }

            function CalculateMins() {

                var FHrs = window.document.getElementById('<%= ddlFromHrs.ClientID %>').value;
                var FMins = window.document.getElementById('<%= ddlFromMin.ClientID %>').value;
                var THrs = window.document.getElementById('<%= ddlToHrs.ClientID %>').value;
                var TMins = window.document.getElementById('<%= ddlToMin.ClientID %>').value;

                var TFrom = +(FHrs * 60) + +FMins;
                var TTo = +(THrs * 60) + +TMins;

                var CAmt;

                if (TFrom < TTo) {
                    CAmt = TTo - TFrom;
                    window.document.getElementById("txtTimeSpent").value = CAmt;
                    window.document.getElementById("HFTimeSpent").value = "From-" + FHrs + ":" + FMins + " To-" + THrs + ":" + TMins
                    //     txtTrackerComments           HFTimeSpent

                }
                else if (TFrom == TTo) {

                    window.document.getElementById("txtTimeSpent").value = "0";
                }
                else {
                    alert("Please enter a valid Time");
                    window.document.getElementById("txtTimeSpent").value = "0";
                }
            }

            function ConfirmMsg() {
                var msg = "";
                msg = 'You are about to update the progress of the selected activity. Press OK if you have entered all the details, else press Cancel.';
                var result = confirm(msg, "Check");

                if (result) {
                    document.getElementById('CnfResult').value = "true";
                }
                else {
                    document.getElementById('CnfResult').value = "false";
                }
            }

            function ConfirmMsg2() {

                var comments = document.getElementById('<%=txtTrackerComments.ClientID%>').value;

                var msg = "";

                if (comments != "") {

                    msg = 'There is text in the Progress of work.  Have you saved this entry?';

                    var result = confirm(msg, "Check");

                    if (result) {
                        document.getElementById('CnfResult').value = "true";
                    }
                    else {
                        document.getElementById('CnfResult').value = "false";
                    }
                }
            }
            function NavigateNewTask() {
                var iMyWidth;
                var iMyHeight;
                iMyWidth = (window.screen.width / 2) - (550 + 10);
                iMyHeight = (window.screen.height / 2) - (400 + 25);
                var X = window.document.getElementById('<%= HDTaskID.ClientID %>').value;
                var Y = 'AddDelegateTaskTracker.aspx?TaskID=' + X;
                var win = window.open(Y, "Window2", "status=no,height=650,width=900,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
                win.focus();
            }
        </script>
        <div>

            <asp:HiddenField ID="CnfResult" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td width="830px">
                                <asp:Label ID="lblCaption" runat="server" Text="Progress Update."
                                    Font-Size="Large" ForeColor="#003366" Font-Names="Calibri"></asp:Label>
                                <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click"
                                    ToolTip="" />

                                <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />
                                <asp:Button ID="HiddenStatusButton" Text="" Style="display: none;" OnClick="HiddenStatusButton_Click" runat="server" />

                            </td>
                            <%--<td align="right">
                    <asp:Label ID="lblHelp1" runat="server" Text="Press Close to exit." CssClass="style7"></asp:Label>
                </td>--%>
                            <td>
                                <telerik:RadWindow ID="rwHelp" Width="800" Height="400" VisibleOnPageLoad="false"
                                    runat="server" OpenerElementID="<%# btnHelp.ClientID  %>">
                                    <ContentTemplate>
                                        <table>
                                            <tr>
                                                <td style="font-size: smaller; color: Green; font-weight: bold; font-family: calibri">Add a new task / activity
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Task, Activity, Work , Notes all mean the same in our system.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Task is with reference to a Prospect or a Customer or a Vendor or any one else. 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">A Task is also with reference to a Product or a Service or Work Type.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Here one can assign a new Work or Activity or Task to self or to some one else.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">This could also be a note about some work done and completed.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">The name you choose can be a Prospective Lead  or an existing customer or a Vendor or even your own organisaton.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">The Reference part indicates the purpose (subject)  for which this interaction is. The reference can be with regard to a Product or a Service or an Activity.
                These must have been defined earlier.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Green; font-weight: bold; font-family: calibri">Examples: 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Assigning the task of following up with a customer for Payments
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Assigning the work of calling a new lead (prospective customer) to know more about her requirements
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Recording a followup entry done with a customer for a specific product.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Red; font-weight: bold; font-family: calibri">What happens if you are dealing on multiple references with a customer? 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Record them as individual entries
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Red; font-weight: bold; font-family: calibri">Where do I record further interactions on the same subject for the same customer?
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Blue; font-family: calibri">You have to use the Update option after selecting the Work Entry.
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: smaller; color: Red; font-weight: bold; font-family: calibri">Can  I skip the Customer Name ?
                <tr>
                    <td style="font-size: smaller; color: Blue; font-family: calibri">Ideally no as whatever work being done will be with reference to some customer.
                    </td>
                </tr>
                                                    <tr>
                                                        <td style="font-size: smaller; color: Red; font-weight: bold; font-family: calibri">What is the meaning of Task Status?
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size: smaller; color: Blue; font-family: calibri">A Task or Work Status can be any of the following three:
                <tr>
                    <td style="font-size: smaller; color: Blue; font-family: calibri">Yet to Start -   Work is scheduled and yet to begin.
                    </td>
                </tr>
                                                            <tr>
                                                                <td style="font-size: smaller; color: Blue; font-family: calibri">In Progress – Work is going on and yet to complete.
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: smaller; color: Blue; font-family: calibri">Completed -  Work is now completed.
                                                                </td>
                                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </telerik:RadWindow>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwMobileApp" Width="700" Height="300" Title ="Change #MobileApp reference" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnReferenceHelp.ClientID  %>" Modal="true">
                                <contenttemplate>
                                                <table>

                                                    <tr>
                                                        <td colspan ="2">
                                                            
                                                            <asp:Label ID="Label14" runat="server" Text="This activity has been assigned from the Smart Phone App and hence has a default customer name.  Change the name and assign the #Reference as appropriate, in this screen." Font-Names ="Verdana" Font-Size ="X-Small"></asp:Label>
                                                        </td>
                                                       
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <asp:Label ID="lbl3" runat="server" Text="Customer Name:" ForeColor="Gray" CssClass="style3"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblcurrentcustomer" runat="server" Text="" ForeColor="Gray" CssClass="style3"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblType" runat="server" Text="New Type:" ForeColor="Gray" CssClass="style3"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlType" runat="server" Width="300px" CssClass="style3" ToolTip="Prospect/Customer/Vendor/Other?"
                                                                OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                                                <asp:ListItem Value="PROSPECT" Text="PROSPECT"></asp:ListItem>
                                                                <asp:ListItem Value ="CUSTOMER" Text ="CUSTOMER"></asp:ListItem>
                                                                <asp:ListItem Value ="VENDOR" Text ="VENDOR"></asp:ListItem>    
                                                                <asp:ListItem Value ="OTHER" Text ="OTHER"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                   <tr>
                                                        <td>
                                                          <asp:Label ID="lblCustName" runat="server" Text="New Customer Name:" ForeColor="Gray" CssClass="style3"></asp:Label>

                                                        </td>
                                                        <td>
                                                          <asp:DropDownList ID="ddlCustName" runat="server"  Width="300px" ToolTip="Not able to find the name of the new lead (prospective customer)? May be it is not added to the Profile yet. You can add it here but remember to complete the full profile later.">
                                                         </asp:DropDownList>
                                                       </td>
                                                  </tr>
                                                  <tr>

                            <td>
                                <asp:Label ID="Label16" runat="server" Text="Group" ForeColor="Gray" CssClass="style3"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlReferenceGroup" runat="server" ToolTip="Choose the group in which the # ref resides." AutoPostBack="true" OnSelectedIndexChanged="ddlReferenceGroup_SelectedIndexChanged" Width="200px" CssClass ="style3">
                                    <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                    <asp:ListItem Text="General" Value="General"></asp:ListItem>
                                    <asp:ListItem Text="Projects" Value="Projects"></asp:ListItem>
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>

                            <td>
                                <asp:Label ID="Label17" runat="server" Text="Reference" ForeColor="Gray" CssClass="style3"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlReference" runat="server" ToolTip="Select an appropriate reference code."   Width="200px" CssClass ="style3">
                                </asp:DropDownList>
                               <%-- <asp:Button ID="Button2" runat="server" Text="Help?" CssClass="Button" OnClick="btnReferenceHelp_Click" Width="60px"
                                    ToolTip="" />
                                <br />
                                <asp:Label ID="Label18" runat="server" Text="" Font-Names="Verdana" Font-Size="Small" BackColor="Yellow" ForeColor="Black"></asp:Label>--%>
                            </td>

                        </tr> 

                                                    <tr align ="center">
                                                         <td colspan ="2">
                                                            
                                                            <asp:Button ID="btnMarketing" runat="server" Text="OK" CssClass="Button" OnClick="btnMarketing_Click" ToolTip="" />
                                                            <asp:Button ID="btnProjects" runat="server" Text="Close" CssClass="Button" OnClick="btnProjects_Click" ToolTip="" />
                                                            <%--<asp:Button ID="btnGeneral" runat="server" Text="General" CssClass="Button" OnClick="btnGeneral_Click" ToolTip="" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                            </contenttemplate>
                                    </telerik:RadWindow>
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
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwSaveTime" VisibleOnPageLoad="false" Width="700px" Height="500px" runat="server" ToolTip="Save time by selecting from a list of predefined entries." OpenerElementID="<%# btnSaveTime.ClientID  %>">
                                    <ContentTemplate>
                                        <table cellpadding="3">
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="lblInfo" runat="server" Text="Add to PickList to SaveTime" ForeColor="Green" Font-Bold="true" Width="160px" CssClass="style2" Font-Names="Calibri"  Font-Size="X-Small"></asp:Label>

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
                                </telerik:RadWindow>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="upnlcustomer" runat="server">
                                    <ContentTemplate>
                                         <telerik:RadWindow ID="rwCustomerProfile" VisibleOnPageLoad="false" Font-Names="Verdana" runat="server" Modal="true" CssClass="Radwindow">
                                            <ContentTemplate>
                                                <div style ="width:100%; float:left">
                                                <div style ="width:40%; float:left">
                                                    <table style="border-collapse: collapse; border: 1px solid black;font-family:Verdana;font-size:small">
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Label ID="lblcphead" runat="server" Text="Profile"  CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblcptitle" runat="server" Text="Title" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black; width: 150px">
                                                                <asp:Label ID="lblscptitle" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpname" runat="server" Text="Name" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcategory" runat="server" Text="Category" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcategory" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcomapanyname" runat="server" Text="Main Contact/Company" Width="100px"
                                                                    CssClass="style2" ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcompanyname" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcptype" runat="server" Text="Type" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscptype" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                      
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpdoorno" runat="server" Text="Door No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpdoorno" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstreet" runat="server" Text="Street" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstreet" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcity" runat="server" Text="City" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcity" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcppinzip" runat="server" Text="Pincode" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscppinzip" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstate" runat="server" Text="State" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstate" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpcountry" runat="server" Text="Country" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpcountry" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpphone" runat="server" Text="Phone No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpphone" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpmobile" runat="server" Text="Mobile No" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpmobile" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail" runat="server" Text="EmailID" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpemail2" runat="server" Text="EmailID2" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpemail2" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="false" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>                                                     
                                                        <tr style="border: 1px solid black;">
                                                            <td align="center" colspan="2" style="border: 1px solid black;">
                                                                <asp:Button ID="btnCPClose" runat="server" Text="Close" CssClass="Button" Width="50px" Height="20px"
                                                                    OnClick="btnCPClose_Click" ToolTip="Click to close customer status history." />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style ="width:60%; float:left">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label23" runat="server" Text="Contacts within the Company" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                 <asp:GridView ID="gvrwcontacts" runat="server" EmptyDataText="No Records has been added."
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" Font-Names ="verdana" Font-Size ="X-Small"
                                                                                    DataKeyNames="RSN">
                                                                     <HeaderStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                     <RowStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Designation" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="EmailID" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="PhoneNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="MobileNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Department" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Location" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                       
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                       
                                                    </table>

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label24" runat="server" Text="Services within the Company" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvrwservices" runat="server" EmptyDataText="No Records has been added."
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" Font-Names ="verdana" Font-Size ="X-Small"
                                                                                    DataKeyNames="RSN">
                                                                     <HeaderStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                     <RowStyle Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" />
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Reference") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="FromDate" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                         <asp:TemplateField HeaderText="ToDate" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="ToDate" ItemStyle-Width="150" HeaderStyle-Font-Bold="false"  HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("Value") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Remarks" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                                                            </ItemTemplate>

                                                                                        </asp:TemplateField>
                                                                                        
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td>
                                                                <asp:Label ID="lblcpinprogress"  runat="server" Font-Names="verdana"  Font-Size="X-Small" ForeColor="Black" BackColor="Yellow" Text="No of activities in progress now"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </div>
                                                    </div>
                                            </ContentTemplate>
                                        </telerik:RadWindow>    
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                               
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <asp:Label ID="lblCustomer" ForeColor="DarkBlue" Font-Bold="true" runat="server" CssClass="style4"></asp:Label>                                
                                <%--<asp:Label ID="lblSep" runat="server" Text=" || " ForeColor="Black"></asp:Label>--%>
                                <asp:Label ID="lblTaskID" ForeColor="Black" Font-Bold="true" runat="server" CssClass="style4"></asp:Label>
                                <asp:Label ID="Label7" ForeColor="Gray" runat="server" Text="--Mobile No:" CssClass="style4"></asp:Label>
                                <asp:Label ID="lblMobile" ForeColor="Gray" runat="server" Text="" CssClass="style4"></asp:Label>
                                <asp:Label ID="Label6" ForeColor="Gray" runat="server" Text="--Email ID:" CssClass="style4"></asp:Label>
                                <asp:Label ID="lblEmail" ForeColor="Gray" runat="server" Text="" CssClass="style4"></asp:Label>

                            </td>
                            <td>
                                <asp:HiddenField ID="HDTaskID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                  <asp:Button ID="btnCusProfile" runat="server" Text="Profile" CssClass="Button" OnClick="btnCusProfile_Click"
                                    ToolTip="Click here to view customer profile." />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table>
                        <tr>
                            <td style="width: 650px"> 
                                <table>

                                    <tr>
                                        <td width="200px">
                                            <asp:Label ID="lblTrackerComments" runat="server" Text="Progress of work" Font-Bold="false" Font-Size ="Small" CssClass="style2"></asp:Label>
                                            <asp:Label ID="lblAs" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td width="450px">
                                            <asp:TextBox ID="txtTrackerComments" runat="server" Width="430px" Font-Size="Small"
                                                CssClass="style6" TextMode="MultiLine" MaxLength="2400" ToolTip="Write here notes about the progress of the task in detail. Do not be cryptic. It will save time later"></asp:TextBox><br />
                                            <asp:DropDownList ID="ddlsavetime" runat="server" Width="280px" ToolTip="Select from a standard picklist of frequently used sentences." OnSelectedIndexChanged="ddlsavetime_SelectedIndexChanged" AutoPostBack ="true">
                                            </asp:DropDownList>
                                            <%--<asp:ImageButton ID="btnimgaddsavetime" runat="server" OnClick="btnimgaddsavetime_Click" ImageUrl="~/Images/Actions-edit-add-icon2.png" ToolTip="Select from a standard picklist of frequently used sentences and press the + button." />--%>
                                            <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                                OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td width="150px">
                                            <asp:Label ID="lblFollowupDate" runat="server" Text="Followup on" Font-Size ="Small" Font-Bold="false" CssClass="style2"></asp:Label>
                                        </td>
                                        <td width="450px">
                                            <telerik:RadDatePicker ID="dtpFollowupDate" runat="server" Culture="English (United Kingdom)"
                                                Width="160px" CssClass="style2" Font-Names="verdana">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                    CssClass="style2" Font-Names="verdana">
                                                </Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                    Font-Names="verdana" ToolTip="You can set a followup date and you will be reminded via email. If there is a follow up date, the calendar is also updated for the person.">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="150px"></td>
                                        <td width="450px">
                                            <asp:HiddenField ID="HDAssignTo" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="150px">
                                            <asp:Label ID="Label2" runat="server" Text="Reference" Font-Size ="Small" Font-Bold="false" CssClass="style2"></asp:Label>
                                        </td>
                                        <td width="450px">
                                            <asp:DropDownList ID="ddlTrackOn" runat="server" Width="155px" CssClass="style3"
                                                ToolTip="Select an appropriate reference code." OnSelectedIndexChanged="ddlTrackOn_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnReferenceHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnReferenceHelp_Click" Width="60px"
                                                ToolTip="" />
                                            <br />
                                            <asp:Label ID="lblcrefremarks" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small" BackColor="Yellow" ForeColor="Black"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="150px"></td>
                                        <td width="450px">
                                            <asp:HiddenField ID="HDAssignBy" runat="server" />
                                            <asp:HiddenField ID="HDStatusCode" runat="server" />
                                        </td>
                                    </tr>
                        </tr>
                        <tr>
                            <td width="150px">
                                <asp:Label ID="Label3" runat="server" Text="Value" Font-Size ="Small" Font-Bold="false" CssClass="style2"></asp:Label>
                            </td>
                            <td width="450px">
                                <asp:TextBox ID="txtValue" runat="server" Width="150px" CssClass="style3" MaxLength="11"
                                    onkeypress="return fun_AllowOnlyAmountAndDot(this.id);" ToolTip="Optionally enter a monetary value if this particular work entry is with reference to some costs associated."> </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td width="150px">
                                <br />
                                <asp:Label ID="Label4" runat="server" Font-Size ="Small" Text="Time Spent (In Mins.)" Font-Bold="false" CssClass="style2"></asp:Label>
                            </td>
                            <td width="500px">
                                <table>
                                    <tr>
                                        <td>
                                            <br />
                                            <asp:TextBox ID="txtTimeSpent" runat="server" CssClass="style3" MaxLength="10" onkeypress="return fun_AllowOnlyAmountAndDot(this.id);" ToolTip="Enter time spent in mins. or let the system calculate for you." Width="150px"></asp:TextBox>
                                            <asp:HiddenField ID="HFTimeSpent" runat="server" />
                                        </td>
                                        <td>
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Font-Size ="Small" CssClass="style5" Font-Bold="false" Text="From Hrs"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Font-Size ="Small" CssClass="style5" Font-Bold="false" Text="Hr:"></asp:Label>
                                            <br />
                                            <asp:DropDownList ID="ddlFromHrs" runat="server" ToolTip="Tag the From and To Time only if a value is present in the Time Field. Otherwise don’t tag." Width="40px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label10" runat="server" Font-Size ="Small" CssClass="style5" Text="Mn:"></asp:Label>
                                            <br />
                                            <asp:DropDownList ID="ddlFromMin" runat="server" ToolTip="If the activity is to be billed according to the time spent, use this feature." Width="40px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:Label ID="Label5" runat="server" Font-Size ="Small" CssClass="style5" Font-Bold="false" Text="To Hrs"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label11" runat="server" Font-Size ="Small" CssClass="style5" Font-Bold="false" Text="Hr:"></asp:Label>
                                            <br />
                                            <asp:DropDownList ID="ddlToHrs" runat="server" ToolTip="Tag the From and To Time only if a value is present in the Time Field. Otherwise don’t tag." Width="40px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Font-Size ="Small" CssClass="style5" Font-Bold="false" Text="Mn:"></asp:Label>
                                            <br />
                                            <asp:DropDownList ID="ddlToMin" runat="server" ToolTip="If the activity is to be billed according to the time spent, use this feature." Width="40px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:LinkButton ID="btnTimeSpent" runat="server" CssClass="style2" OnClientClick="CalculateMins()" Font-Bold="false" Text="Calc" ToolTip="If the activity is to be billed according to the time spent, use this feature."></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%--  OnClick="btnCalculate_Click"--%>
                            <td>
                                <%-- <asp:Button ID="btnTimeSpent" runat="server" Text="||" CssClass="Button" OnClick="btnTimeSpent_Click" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="HFTrackID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px">
                                <asp:Label ID="lblStatus" runat="server" Text="Work status" Font-Size ="Small" Font-Bold="false" CssClass="style2"></asp:Label>
                            </td>
                            <td width="450px">
                                <asp:DropDownList ID="ddlStatus" runat="server" Width="155px" CssClass="style3" ToolTip="Set status to Completed if this work is now done. Caution! You cannot undo the action.">
                                </asp:DropDownList>
                                <br />
                                <asp:Label ID="Label13" runat="server" Text="If you mark the status as Completed, you cannot undo it. Hence be sure about it before you update." ForeColor="DarkBlue" Font-Size="X-Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="HDUserId" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px">
                                <asp:Label ID="lbltPriority" Font-Size ="Small" runat="server" Text="Priority" Font-Bold="false" CssClass="style2"></asp:Label>
                            </td>
                            <td width="450px">
                                <asp:DropDownList ID="ddlpriority" runat="server" Width="155px" CssClass="style3" ToolTip="Choose an appropriate priority you wish to set now for this activity">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td width="150px">
                                <asp:Label ID="lblCustStaus" runat="server" Font-Size ="Small" Text="Customer Status" Font-Bold="false" CssClass="style2"></asp:Label>
                                <br />
                                <br />
                            </td>
                            <td width="450px" rowspan="2">
                                <asp:DropDownList ID="ddlCustStatus" runat="server" Width="155px" CssClass="style3"
                                    ToolTip=" A Status change is an important event. To avoid accidental changes, first Click the Check Box.   Status Change can be done only by authorised users.  When you make a Lead as a Customer, cannot UNDO the status change.">
                                </asp:DropDownList><br />
                                <asp:CheckBox ID="chkEditStatus" runat="server" AutoPostBack="true" ToolTip="Set status to Completed if this work is now done." OnCheckedChanged="chkEditStatus_CheckedChanged" Text="Change Status" />
                                <asp:CheckBox ID="chkEditCustomer" runat="server" AutoPostBack="true" ToolTip="By clicking here, you are allowed to mark a Prospect as a Customer.  Caution!  You cannot UNDO the action. This action is possible only for authorised users." Text="Convert as customer" OnCheckedChanged="chkEditCustomer_CheckedChanged" /><br />
                                <asp:Label ID="lblalert" runat="server" Text="Alert:Has the Prospect status also changed?" CssClass="style2" ForeColor="Black" BackColor="Yellow" Font-Size="Small" Width="250px"></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>

                            <td width="150px">
                                <asp:Label ID="Label15" runat="server" Font-Size ="Small" Text="Assigned To" Font-Bold="false" CssClass="style2"></asp:Label>
                                
                            </td>
                            <td width="450px">
                                <asp:DropDownList ID="ddlAssignedTo" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>

                                                    <td>
                                                        <asp:Label ID="Label30" runat="server" Font-Bold ="false" Font-Size ="Small" BackColor ="Yellow" Text="Send Mail to Customer?" CssClass="style2"></asp:Label>
                                                        
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlcmail" runat="server" ToolTip="If you say Yes, a mail will be sent to the customer confirming the request. If you say No, no mail will be sent.">
                                                            <asp:ListItem Text ="No" Value ="N"></asp:ListItem>
                                                            <asp:ListItem Text ="Yes" Value ="Y"></asp:ListItem>
                                                            
                                                        </asp:DropDownList>
                                                    </td>

                                                </tr>
                       
                    </table>
                    </td>
        <td style="width: 400px;">
            <%--<asp:Label ID="lblCCustomer" runat="server" Text="Customer - " CssClass="style5"></asp:Label>--%>
            <%-- <asp:Label ID="lblCCustStatus" runat="server" Text="Customer Status - " CssClass="style5"></asp:Label>
                    <asp:Label ID="lblCustStatus" runat="server" CssClass="style5"></asp:Label>--%>
            <asp:HiddenField ID="HDCustStatus" runat="server" />
            <asp:Label ID="lblCSTaskID" runat="server" Text="Task ID - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblSTaskID" runat="server" CssClass="style5"></asp:Label>
            <br />
            <asp:Label ID="lblCAssignedOn" runat="server" Text="Assigned On - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblAssignedOn" runat="server" CssClass="style5"></asp:Label>
            <br />
            <asp:Label ID="lblCAssignedBy" runat="server" Text="Assigned By - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblAssignedBy" runat="server" CssClass="style5"></asp:Label>
            
          <%--  <br />
            <asp:Label ID="lblCOtherAssignees" runat="server" Text="Other Assignees - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblOtherAssignees" runat="server" CssClass="style5"></asp:Label>--%>
            <br />
           
            <asp:Label ID="lblCAssignedTo" runat="server" Text="Followup Date - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblAssignedTo" runat="server" CssClass="style5"></asp:Label>
             <br />
            <asp:Label ID="lblCTargetDate" runat="server" Text="Target Date - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblTargetDate" runat="server" CssClass="style5"></asp:Label>
            <br />
            <asp:Label ID="lblCStatus" runat="server" Text="Task Status Now - " CssClass="style5" BackColor="Yellow"> </asp:Label>
            <asp:Label ID="lblStatus2" runat="server" CssClass="style5" BackColor="Yellow"></asp:Label>
            <br />
            <asp:Label ID="lblCPriority" runat="server" Text="Priority - " CssClass="style5" BackColor="Yellow"></asp:Label>
            <asp:Label ID="lblPriority" runat="server" CssClass="style5" BackColor="Yellow"></asp:Label>
            <%-- <br />
            <asp:Label ID="lblCComplexity" runat="server" Text="Complexity - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblComplexity" runat="server" CssClass="style5"></asp:Label>
            <br />
            <asp:Label ID="lblCOtherRemarks" runat="server" Text="Other Remarks - " CssClass="style5"></asp:Label>
            <asp:Label ID="lblOtherRemarks" runat="server" CssClass="style5"></asp:Label>--%>
            <br />
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button" Width="50px"
                OnClick="btnSave_Click" OnClientClick="ConfirmMsg()" ToolTip="Click to Save the Work progress." />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="Button" Width="50px"
                OnClick="btnClear_Click" ToolTip="Click to clear the details entered and to re-enter again." />
            <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="Button" Width="50px" OnClientClick="CloseWindow();"
                OnClick="btnClose_Click" ToolTip="Click to return to the Tasks list.  Have you pressed Save?" />
            <asp:Button ID="Button1" runat="server" Text="Next Activity" ForeColor="White" CssClass="Button" Width="80px"
                OnClick="btnSaveNext_Click" OnClientClick="ConfirmMsg2()" ToolTip="'Make sure your current work progress entry is saved first. If you are sure, press OK else press Cancel to return back." />
            <asp:Button ID="btnDelegate" runat="server" Text="Delegate" ForeColor="White" CssClass="Button" Width="70px"
                OnClick="btnDelegate_Click" ToolTip="Click here to Delegate the selected Task to another person" Visible="false" />
            <%-- OnClientClick="javascript:window.close();"--%>
            <br />
            <br />
            <asp:Label ID="lblcustomercount" runat="server" ForeColor="Brown" Text="" Font-Names="verdana" Font-Size="XX-Small"></asp:Label><br />
            <br />
            <asp:Label ID="lblcaution" runat="server" ForeColor="Brown" Text="If this activity is marked Completed, check if other on-going activities are to be updated as well." Font-Names="verdana" Font-Size="X-Small"></asp:Label>
            <br />
            <asp:Label ID="Label9" runat="server" ForeColor="Brown" Text="If you set a followup date, a Calendar Link mail will be sent to the assignee immediately.  A reminder mail will be sent to the assignee, one day before." Font-Names="verdana" Font-Size="X-Small"></asp:Label>
        </td>
                    </tr> </table>
        <br />
                    <table>
                        <tr>
                            <asp:Label ID="lblHelp2" runat="server" ForeColor="DarkBlue" Text="To PRINT: Right click select Print."
                                CssClass="style7"></asp:Label>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadGrid ID="RdGrd_TaskTrack" runat="server" Skin="WebBlue" GridLines="None"
                                    AutoGenerateColumns="False" Height="250px" Width="940px">
                                    <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                    </HeaderContextMenu>
                                    <PagerStyle Height="200px" />
                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                        <PagerStyle Mode="NextPrevAndNumeric" />
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Activity" HeaderText="Task" UniqueName="Activity"
                                                Visible="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EntryDate" HeaderText="Entry Date" UniqueName="EntryDate"
                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TrackOn" HeaderText="Reference" UniqueName="TrackOn"
                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Comments" HeaderText="Work Progress (Latest first)"
                                                UniqueName="Comments" Visible="true">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Value" HeaderText="Value in Rs." UniqueName="Value"
                                                Visible="true" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right">
                                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TimeSpent" HeaderText="Time Spent (In Mins.)"
                                                UniqueName="TimeSpent" Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Followupdate" HeaderText="Followup Date" UniqueName="Followupdate"
                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                    </ClientSettings>
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>

                </ContentTemplate>

                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                    <asp:PostBackTrigger ControlID="btnClose" />
                    <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelegate" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="ddlTrackOn" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="ddlsavetime" EventName ="SelectedIndexChanged" />
                </Triggers>

            </asp:UpdatePanel>

        </div>
    </form>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           