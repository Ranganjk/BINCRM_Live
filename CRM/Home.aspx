<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" MasterPageFile="~/AppTheme/HomeMST.master" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="viewport" content="width=1040" />

    <link href="css/fonts.css" rel="stylesheet" />

    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="css/Popup.css" rel="stylesheet" type="text/css" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />
    <script type="text/javascript" src="js/ManageTask.js"></script>
    <script type="text/javascript" src="js/Disablebackbtn.js"></script>

    <script type="text/javascript">
        HomeBlock();
    </script>
    <style type="text/css">
        .rcornertxtbox {
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
        }
    </style>
    <style type="text/css">
        .live-tile-button {
            width: 200px;
            height: 100px;
            background: #ffee55;
            border: 1px solid #fff;
        }
    </style>

    <style type="text/css">
        .search {
            background: url(find.png) no-repeat;
            padding-left: 18px;
            border: 1px solid #ccc;
        }

        .Font_Header2 {
            font-family: Verdana;
            font-size: 12px;
            font-weight: normal;
            color: Black;
        }

        .modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 80px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 128px;
                width: 80px;
            }

        .valign {
            vertical-align: bottom;
        }

        .bcolor {
            background-color: beige;
        }
    </style>

    <script type="text/javascript">
        function NavigateNewTask() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);

            var Y = 'AddNewTask.aspx';
            var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
        function NavigateNewEnquiry() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);

            var Y = 'AddNewEnquiry.aspx';
            var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
        function NavigateNewComplaints() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (500 + 10);
            iMyHeight = (window.screen.height / 2) - (300 + 25);

            var Y = 'AddNewComplaints.aspx';
            var win = window.open(Y, "Window2", "status=no,height=620,width=1000,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }
    </script>
    <script type="text/javascript">
        function ConfirmClick() {
            // window.onload.apply();
        }
    </script>
    <script type="text/javascript">
        function Validate() {
            //alert('test');
            var summ = "";
            summ += Name();
            summ += Contact();
            summ += Email();
            if (summ == "") {
                var x = confirm("Do you want to save?");
                if (x)
                    return true;
                else
                    return false;
            } else {
                alert(summ);
                return false;
            }
        }
        function Name() {
            var Name = document.getElementById('<%= txtCustName.ClientID %>').value;
            //var chk = /^[a-zA-Z ]+$/;
            var chk = /^[0-9a-zA-Z ]+$/;
            if (Name == "") {
                return "Please enter name" + "\n";
            } else if (chk.test(Name)) {
                return "";
            } else {
                return "Enter valid name" + "\n";
            }
        }
        function Contact() {
            var Name = document.getElementById('<%= txtMob.ClientID %>').value;
            var chk = /^[+0-9]+$/;
            if (Name == "") {
                return "Please enter mobile number" + "\n";
            } else if (chk.test(Name)) {
                return "";
            } else {
                return "Enter Valid mobile number" + "\n";
            }
        }
        function Email() {
            var Name = document.getElementById('<%= txtEml.ClientID %>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
            if (Name == "") {
                //return "Please enter email id" + "\n";
                return "";
            } else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Enter Valid email Address" + "\n";
            }
        }
    </script>
    <script type="text/javascript">
        function ROlmsg() {
            var summ = "";
            summ += rolcomments();
            if (summ != "") {
                alert(summ);
                return false;
            } else {
                var x = confirm('Do you want to save?');
                if (x)
                    return true;
                else
                    return false;
            }
        }
        function rolcomments() {
            var comm = document.getElementById('<%= ROLMessage.ClientID %>').value;
            if (comm == "") {
                return 'Please enter your comments';
            } else {
                return "";
            }
        }

        function SearchLength() {
            var Len = document.getElementById('<%= txtSearch.ClientID%>').value;
            var chk = /^[a-zA-Z-, ]+(\s{0,1}[a-zA-Z-, ])*$/;
            if (Len == "") {
                alert('Please enter customer name to search');
                document.getElementById('<%= txtSearch.ClientID%>').focus();
                return false;
            } else if (Len.length < 4) {
                alert('Please enter minimum four letters to search');
                document.getElementById('<%= txtSearch.ClientID%>').focus();
                return false;
            } else if (chk.test(Len)) {
                var x = confirm('Do you want to search by customer name?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert('Enter valid customer name to search');
                document.getElementById('<%= txtSearch.ClientID%>').focus();
                return false;
            }
}
function clickButton(e, buttonid) {
    var evt = e ? e : window.event;
    var bt = document.getElementById(ibtnSearch);
    if (bt) {
        if (evt.keyCode == 13) {
            bt.click();
            return false;
        }
    }
}
    </script>
</asp:Content>


<asp:Content ID="cntpage" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Always" ChildrenAsTriggers="true">
        <ContentTemplate>--%>
    <div style="padding: 3px; margin-top: 3px; margin-bottom: 0px;">
        <div style="clear: both;"></div>
        <table style="width: auto; margin: 0 auto;">
            <tr>
                <td>
                    <telerik:RadContentTemplateTile ID="TileMyTasks" ToolTip="View and manage tasks (activities/work) assigned to you." OnClick="TileMyTasks_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbltilemytasks" runat="server" Text="My Tasks" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style ="text-align:center">
                                        <td style ="align-content:center">                                            
                                            <asp:Label ID="lbltilemytaskscount" runat="server" Text="" ForeColor ="White" Font-Names ="verdana"></asp:Label>                                        
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>

                </td>

                <td>
                    <telerik:RadContentTemplateTile ID="TileLeads" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile." Font-Bold="true" Font-Names="verdana" BackColor="#002060" Width="225px" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="ibtnleadssearch">
                                <div style="margin-top: 50px;">
                                    <center>
                                <table>
                                    <tr align="Center">
                                        <td>
                                            <asp:LinkButton ID="Label3" Font-Underline="false" runat="server" Text="Manage Leads" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana" OnClick="Label3_Click"></asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr style="vertical-align:central;">
                                        <td style="vertical-align:central;">
                                            <asp:TextBox ID="txtLeadssearch" CssClass ="rcornertxtbox" Width="175px" Height="20px" runat="server" ToolTip="Enter four or more letters to search leads name"></asp:TextBox>                                             
                                        </td>    
                                        <td style="vertical-align:central;">
                                            <asp:ImageButton ID="ibtnleadssearch" OnClick="ibtnSearch_Click" runat="server" ToolTip="Click here to search the leads details for you have entered." BackColor="#002060" OnClientClick="return SearchLength();" Width="25px" Height="25px" ImageUrl="~/Images/search3.jpg" />
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

              
                <td>
                    <telerik:RadContentTemplateTile ID="TileCustomers" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile." Font-Bold="true" Font-Names="verdana" BackColor="#002060" Width="225px" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="pnlCustomer" runat="server" DefaultButton="ibtnSearch">
                                <div style="margin-top: 50px;">
                                    <center>
                                <table>
                                    
                                    <tr align="Center">
                                        <td>                                            
                                            <asp:LinkButton ID="Label4" runat="server" Text="Manage Customers" ForeColor ="White" Font-Names ="verdana" Font-Underline="false"  Font-Size ="Medium" OnClick="Label3_Click"></asp:LinkButton>                                        
                                        </td>
                                    </tr>
                                    <tr style="vertical-align:central;">
                                        <td style="vertical-align:central;">
                                            <asp:TextBox ID="txtSearch" CssClass ="rcornertxtbox" Width="175px" Height="20px" runat="server" ToolTip="Enter four or more letters to search customer name"></asp:TextBox>                                             
                                        </td>    
                                        <td style="vertical-align:central;">
                                            <asp:ImageButton ID="ibtnSearch" OnClick="ibtnSearch_Click" runat="server" ToolTip="Click here to search the customer details for you have entered." BackColor="#002060" OnClientClick="return SearchLength();" Width="25px" Height="25px" ImageUrl="~/Images/search3.jpg" />
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                <td style="vertical-align:top;">
                    <telerik:RadContentTemplateTile ID="TileInfoGraphics" ToolTip="Click here to open business dashboard." OnClick="TileInfoGraphics_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px"  runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px;vertical-align:top;">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text="InfoGraphics" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                
                <td>
                    <telerik:RadContentTemplateTile ID="appointment" ToolTip="Click to enter a new appointment or to view calendar appointments." OnClick="appointment_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="Blue" Width="225px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label13" runat="server" Text="Appointments" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                             <text style="color:white;">Due :</text>
                                             <asp:Label ID="lblAppDue" runat="server" ForeColor="White"></asp:Label> &nbsp;
                                             <text style="color:white;">Done :</text>
                                             <asp:Label ID="lblAppTotal" ForeColor="White" runat="server"></asp:Label>                                            
                                        </td>                                       
                                    </tr>                                   
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                   <asp:Button ID="btnAppoint" OnClick="btnAppoint_Click" Visible="false" ToolTip="Click to enter a new appointment or to view calendar appointments." runat="server" Text="Appointments" Width="225px" Height ="50px"  BackColor="Blue" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana" Font-Bold="true" />                   

                    <%--<telerik:RadContentTemplateTile ID="TileComplaints"  OnClick="TileComplaints_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="Red" Width="225px" Height ="100px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label13" runat="server" Text="Complaints" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                   
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>

                      <telerik:RadContentTemplateTile ID="TileLeave"  OnClick="TileLeave_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" Height ="50px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label14" runat="server" Text="Leave" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>--%>

                    <%--<telerik:RadIconTile ID ="TileComplaints"  OnClick="TileComplaints_Click" ImageUrl="~/Images/ServiceRequest.ico" BorderColor ="Black" BorderWidth="1px" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="White" Width="225px" runat="server">
                          
                         <Title Text ="Complaints" ></Title>
                    </telerik:RadIconTile>--%>
                </td>
            </tr>
            <tr style="height:150px;">

                  <td>
                    <telerik:RadContentTemplateTile ID="TileByMe" ToolTip="Tasks delegated by me and assigned by me" OnClick="TileByMe_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" Height="130px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text="Assigned by me" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style ="text-align:center">
                                        <td style ="align-content:center">
                                            
                                            <asp:Label ID="lbltilebymecount" runat="server" Text="" ForeColor ="White" Font-Names ="verdana"></asp:Label>
                                        
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>
                
                 <td style="vertical-align:top;">
                    <telerik:RadContentTemplateTile ID="TileNewEnquiry" ToolTip="Click here to register a new enquiry." OnClick="TileNewEnquiry_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" Height="130px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Text="A New Enquiry" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                <td style="vertical-align:top;">
                    <telerik:RadContentTemplateTile ID="TestTileDashboard" BackColor="Beige" Font-Bold="true" Font-Names="verdana" Width="225px" Height="130px" runat="server" BorderWidth="3px" BorderColor="Black">
                        <ContentTemplate>
                            <div style="margin-top: 10px">
                                <center>
                                 <table >
                                 <tr>
                                     <td>
                                         <asp:Label ID="lblMyTasks" runat="server" Text="Label"  Font-Names ="TimesNewRoman" Font-Bold ="false"></asp:Label>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:Label ID="lblByMe" runat="server" Text="Label"  Font-Names ="TimesNewRoman" Font-Bold ="false"></asp:Label>
                                     </td>
                                 </tr>
                             
                                  <tr>
                                     <td>
                                         <asp:Label ID="lbltodyasfollowups" runat="server" Text="" Font-Names="TimesNewRoman" Font-Bold ="false"></asp:Label>
                                     </td>
                                 </tr>
                                      <tr>
                                     <td>
                                         <asp:Label ID="lbloverduefollowups" runat="server" Text="" Font-Names="TimesNewRoman" Font-Bold ="false"></asp:Label>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:Label ID="lbloncomingFollowups" runat="server" Text="" Font-Names="TimesNewRoman" Font-Bold ="false"></asp:Label>
                                     </td>
                                 </tr>
                                 </table>
                                 </center>
                            </div>
                        </ContentTemplate>

                    </telerik:RadContentTemplateTile>
                </td>

                 <td style="vertical-align:top;">
                    <telerik:RadContentTemplateTile ID="TileReports" ToolTip="Click here to open Reports." OnClick="TileReports_Click" AutoPostBack="true" Font-Bold="true" Font-Names="verdana" BackColor="#002060" Width="225px" Height="130px" runat="server" ImageUrl="~/Images/Reports-tile.png">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" Text="Reports" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                <td>
                    <telerik:RadContentTemplateTile ID="TileSettings" ToolTip="Click here to manage users and system parameters." AutoPostBack="true" Font-Bold="true" Font-Names="verdana" OnClick="TileSettings_Click" BackColor="#5F497A" Width="225px" Height="130px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label9" runat="server" Text="Settings" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>
               
                   
            </tr>
            <tr style="height:20px;vertical-align:top;">
                <td colspan="5">
                    <div>
                         <marquee direction="left" runat="server">
                                <strong>
                                    <asp:Label ID="lblmsg" runat="server"  ForeColor="CadetBlue" Font-Names="Verdana" Font-Size="Small" Font-Italic="false"></asp:Label> <br />
                                    <asp:Label ID="lblcampaignmsg" runat="server"  ForeColor="DarkGreen"  Font-Names="Verdana" Font-Size="13px" ></asp:Label>
                                </strong>
                         </marquee>
                    </div>
                </td>
            </tr>
            <tr>
                
                <td>
                    <telerik:RadContentTemplateTile ID="TileNewTask" ToolTip="Click here to assign a new activity to yourself or your sub-ordinates." OnClick="TileNewTask_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text="Assign a new task" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                   
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                <td>
                    <telerik:RadContentTemplateTile ID="TileNewLead" ToolTip="Click here to add a new lead." OnClick="TileNewLead_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Text="A New Lead" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>

                <td style="vertical-align:top;">   
                     <%--<asp:Button ID="btnComplaintss" OnClick ="TileComplaints_Click" ToolTip="Register a Customer Complaint or a Service Request or a Warranty Service here." runat="server" Text="Complaints" Width="225px" Height ="50px" BackColor="Red" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana" Font-Bold ="true" /><br />--%>
                    <telerik:RadContentTemplateTile ID="radiconComplaints" ToolTip="Register a Customer Complaint or a Service Request or a Warranty Service here." OnClick="TileComplaints_Click" Font-Bold="true" Font-Names="verdana" BorderColor="Red" BorderWidth="3px" AutoPostBack="true" BackColor="Beige" Width="225px" Height="130px" runat="server">
                        <ContentTemplate>
                            <div style="margin-top: 25px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label14" runat="server" Text="Customer Care" ForeColor="Black" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                            <br /> <br />
                                            &nbsp;&nbsp;<text style="color:green;font-family:Verdana;font-size:smaller;">Booked Today :</text>&nbsp;
                                            <asp:Label ID="lblCompBT" runat="server"></asp:Label>
                                            <br />
                                            &nbsp;&nbsp;<text style="color:green;font-family:Verdana;font-size:smaller;">Completed Today :</text> &nbsp;
                                            <asp:Label ID="lblCompCT" runat="server"></asp:Label>
                                            <br />
                                            &nbsp;&nbsp;<text style="color:green;font-family:Verdana;font-size:smaller;">Waiting :</text> &nbsp;
                                            <asp:Label ID="lblCompPG" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>
                
                 <td>
                    <telerik:RadContentTemplateTile ID="TileReference" BackColor="#5F497A" Font-Bold="true" Font-Names="verdana" Width="225px" runat="server" OnClick="TileReference_Click" AutoPostBack="true" ToolTip="Click here to manage the #Reference list.  #Reference is used to define the purpose of an activity. Example: #Enquiry,  #Quote, #Order, #AMC, #Followup.">
                        <ContentTemplate>
                            <div style="margin-top: 50px">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label11" runat="server" Text="#Reference List" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>                                   
                                    
                                </table>
                                    </center>
                            </div>
                        </ContentTemplate>
                    </telerik:RadContentTemplateTile>
                </td>            


                
                <td>
                    <asp:Button ID="btnApplyLeave" OnClick="TileLeave_Click" ToolTip="Click here to register a leave." runat="server" Text="Apply Leave" Width="225px" Height ="30px"  BackColor="Blue" ForeColor ="White" Font-Size ="Medium" Font-Names ="verdana" Font-Bold="true" /> <br />     
                    <asp:Button ID="btnAssessPerf" OnClick ="btnAssessPerf_Click" ToolTip="Click here to enter assess performance details." runat="server" Text="Assess Performance" Width="225px" Height ="30px" BackColor="Green" ForeColor ="White" Font-Size ="Medium" Font-Names ="verdana" Font-Bold ="true" /><br />
                    <asp:Button ID="btnRecongnitions" OnClick ="btnRecongnitions_Click" ToolTip="Are you happy with the work done by your colleague. You can give your feedback here." runat="server" Text="Recognition" Width="225px" Height ="30px" BackColor="Green" ForeColor ="White" Font-Size ="Medium" Font-Names ="verdana" Font-Bold ="true" />
                </td>
            </tr>
        </table>
    </div>
    <div runat="server" id="dvRadWindow">
        <table>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>

                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="upnlNewLead" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            <telerik:RadWindowManager ID="rwmgrmain1" runat="server" EnableAjaxSkinRendering="true">
                                <Windows>
                                    <telerik:RadWindow ID="rwNewLead" CssClass="bcolor" Title="Add New Leads" runat="server" Height="500" Width="700" BorderStyle="Solid" Modal="true" VisibleOnPageLoad="true" ToolTip="Add new leads here">
                                        <ContentTemplate>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td align="center">
                                                        <table cellpadding="3px">
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Label ID="lblHeading" runat="server" Text="Add a profile of a new lead(prospective customer)here." Font-Size="Large"
                                                                        Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTitle" runat="server" Text="Biz./Mr. :" CssClass="style3" Width="120"></asp:Label>
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
                                                                    <asp:Label ID="lblCustName" runat="server" Text="Name :" CssClass="style3"></asp:Label>
                                                                    <asp:Label ID="lblAs" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="40" ToolTip="Enter the name of the lead/prospect/customer/vendor etc. Max 40."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblType" runat="server" Text="Type:" ForeColor="Gray" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlType" runat="server" Width="250px" CssClass="style3" ToolTip="Prospect/Customer/Vendor/Other?"
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
                                                                    <asp:DropDownList ID="ddlCCustStatus" runat="server" Width="250px" CssClass="style3"
                                                                        ToolTip="" BackColor="DarkBlue" ForeColor="White">
                                                                    </asp:DropDownList>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblProspectCompanyName" runat="server" Text="Company/MainContact:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCompanyName" runat="server" Width="250px" Font-Size="Medium"
                                                                        CssClass="style3" TextMode="SingleLine" MaxLength="100" ToolTip="Enter the name of the maincontact person. if you are adding a company's profile. Otherwise, add the name of the organisation where the person is employed. Max 100."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblMob" runat="server" Text="Mobile No. :" CssClass="style3"></asp:Label>
                                                                    <asp:Label ID="lblmr" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMob" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="13" ToolTip="Prefix with country code if a foreign no. Max 13."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblEml" runat="server" Text="EmailID:" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtEml" runat="server" Width="250px" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="SingleLine" MaxLength="80" ToolTip="Enter the main email id for correspondence. Max 80."></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblNotes" runat="server" Text="Notes :" CssClass="style3"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtNotes" runat="server" Width="250px" Height="75" Font-Size="Medium" CssClass="style3"
                                                                        TextMode="MultiLine" MaxLength="2400" ToolTip="Write a brief note on your interaction with the Lead/Customer. This entry also saved in the Work diary.Max 2400."></asp:TextBox>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Button ID="btnCSave" runat="server" OnClick="btnCSave_Click" Text="Save" CssClass="btnAdminSave" Width="74px" Height="26px"
                                                                        OnClientClick="javascript:return Validate()" ToolTip="Click to save the profile. If you have written something in Notes field, the same will reflect in the Activities w.r.t the profile." />
                                                                    &nbsp;
                                                                     <asp:Button ID="btnCClear" OnClick="btnCClear_Click" runat="server" Text="Clear" CssClass="btnAdminClear" Width="74px" Height="26px"
                                                                         ToolTip="Click to clear the details entered." CausesValidation="false" />
                                                                    &nbsp;
                                                                     <asp:Button ID="btnCUpate" OnClick="btnCUpate_Click" runat="server" Text="Exit" CssClass="btnAdminExit" Width="74px" Height="26px"
                                                                         ToolTip="Click here to close the screen." />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="text-align: center">
                                                                    <asp:Label ID="Label1" runat="server" Text="Use the 'Customers' Tile to View/Edit the profiles." CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                            </telerik:RadWindowManager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadWindow ID="rwStatusHelp" CssClass="bcolor" Width="500" Height="250" VisibleOnPageLoad="false" Title="Status codes and their meanings"
                        runat="server" OpenerElementID="<%# btnstatushelp.ClientID  %>" Style="z-index: 7001">
                        <ContentTemplate>
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvStatuHelp" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                PageSize="10" Font-Names="Calibri" Font-Size="X-Small" ForeColor="DarkBlue">
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
                    <telerik:RadWindow ID="rwReferenceHelp" CssClass="bcolor" Width="500" Height="250" VisibleOnPageLoad="false" Title="Status codes and their meanings"
                        runat="server" OpenerElementID="<%# btnReferenceHelp.ClientID  %>" Style="z-index: 7001">
                        <ContentTemplate>
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label44" runat="Server" Text="You deal with customers for various purposes." ForeColor="Black" Font-Bold="false" Font-Names="Verdana" Font-Size="X-Small" Width="304px"></asp:Label><br />
                                            <asp:Label ID="Label45" runat="Server" Text="It could be for new business or for attending a repair call or it could be Tax Filing Service a or it could be about a product you sell." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                            <asp:Label ID="Label46" runat="Server" Text="How to distinguish each interaction? Simple. Define each purpose as a #Reference Tag here." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                            <asp:Label ID="Label47" runat="Server" Text="The #Reference tag is then used when an activity is assigned to a user." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                            <asp:Label ID="Label48" runat="Server" Text="If you have a standard set of Services that you provide to a customer, you can define them in the Customer Profile." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                            <asp:Label ID="Label52" runat="Server" Text="The #Reference Codes  #Enquiry, #Quote, #Order, #MobileApp cannot be deleted." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label><br />
                                            <asp:Label ID="Label53" runat="Server" Text="If a #Reference Code is used in some activity, it cannot be deleted." ForeColor="Black" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="false"></asp:Label>
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
                    <asp:UpdatePanel ID="upnlROl" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <telerik:RadWindow ID="rwROL" CssClass="bcolor" RegisterWithScriptManager="true" VisibleOnPageLoad="false" Title="Recognitions" Width="1000" Height="600" runat="server" Modal="true" Font-Names="Verdana" Style="z-index: 7001">
                                <ContentTemplate>
                                    <table style="width: 100%; background-color: beige;">
                                        <tr>
                                            <td style="text-align: center; font-size: smaller;">
                                                <asp:Label ID="Label36" runat="server" Font-Size="Small" Text="Are you happy with the work done by your colleague?" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>

                                            </td>

                                        </tr>
                                        <tr>
                                            <td style="text-align: center; font-size: smaller;">
                                                <asp:Label ID="Label38" runat="server" Font-Size="Small" Text="Did you ‘Observe’ some flaw in the work done by your sub-ordinate?" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center; font-size: smaller;">
                                                <asp:Label ID="Label39" runat="server" Font-Size="Small" Text="You can give your feedback here." ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                    <table>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblStaffID" runat="Server" Text="For" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlStaffID" runat="server" Width="150px" ToolTip="Select the User/Colleague name." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblROLTYPE" runat="Server" Text="Type" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlROLTYPE" runat="server" Width="150px" ToolTip="Please see below for description." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                                                <asp:ListItem Text="Recognition" Value="Recognition"></asp:ListItem>
                                                                <asp:ListItem Text="Like" Value="Like"></asp:ListItem>
                                                                <asp:ListItem Text="UCanDoBetter" Value="UCanDoBetter"></asp:ListItem>
                                                                <asp:ListItem Text="Observation" Value="Observation"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblROLMessage" runat="Server" Text="Enter your comments" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="ROLMessage" runat="Server" BackColor="Beige" MaxLength="200" ToolTip="Please enter a descriptive comment – What you liked or What you wish to point out." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="text-align: center">

                                                        <td colspan="2">
                                                            <asp:Button ID="btnROLSave" runat="Server" Text="Save" Font-Size="Small"
                                                                ToolTip="Click here to save the details" ForeColor="White"
                                                                CssClass="btnAdminSave" Width="74px" Height="26px"
                                                                OnClientClick="return ROlmsg()" OnClick="btnROLSave_Click" />

                                                            <asp:Button ID="btnROLUpdate" runat="Server" Text="Update" Font-Size="Small"
                                                                ToolTip="Click here to save the details" ForeColor="White" OnClientClick="javascript:return ConfirmUpdateMsg()"
                                                                OnClick="btnROLUpdate_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                            <asp:Button ID="btnROLClear" runat="Server" Text="Clear" Font-Size="Small"
                                                                ToolTip=" Click here to clear entered details"
                                                                OnClick="btnROLClear_Click" CssClass="btnAdminClear" Height="26px" Width="74px" />

                                                            <asp:Button ID="btnROLExit" runat="Server" Text="Exit" Font-Size="Small"
                                                                ToolTip="Click here to exit" OnClick="btnROLExit_Click" CssClass="btnAdminExit" Width="74px" Height="26px" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrolmsg1" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                                                Text="Recognition - Your colleague has done an excellent work. Recognise her achievement by writing your good feedback.
                                                          It shall be duly conveyed to the concerned via Email. A mail will also go to all active users in the system, 
                                                          so that every one knows about the good work done."></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrolmsg2" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                                                Text="Like – You are happy with the work done by your colleague or sub-ordinate.  
                                                   Why not POST your Like here.  It shall be duly conveyed to the concerned via Email.
                                                   A mail will also go to all active users in the system,
                                                   so that every one knows about the good work done."></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrolmsg3" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                                                Text="UCanDoBetter - You are not so happy with the work done. Point it out politely. 
                                                         It shall be duly conveyed to the concerned via Email."></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrolmsg4" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                                                Text="Observation - Use this option if you wish to point out some real goof-up by your sub-ordinate. 
                                                        It shall be duly conveyed to the concerned via Email."></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrolmsg5" runat="server" Font-Names="Verdana" Font-Size="X-Small" ForeColor="Black"
                                                                Text="Why do we need this feature?  By using this option, every good performance gets duly noticed and at the same time weaknesses are also pointed out politely. 
                                         Fosters a team spirit and a good work environment."></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </td>
                                        </tr>
                                    </table>


                                    <table>

                                        <tr style="text-align: center">
                                            <td>
                                                <asp:Label ID="lbltotalRecognition" runat="server" Text="" ForeColor="DarkBlue"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvROL" runat="server" Font-Names="verdana" Font-Size="Small" PageSize="10"
                                                    OnPageIndexChanging="gvROL_PageIndexChanging" AutoGenerateColumns="False"
                                                    DataKeyNames="RSN" AllowPaging="True">
                                                    <Columns>

                                                        <asp:BoundField HeaderText="R/L" DataField="ROLTYPE" ReadOnly="true" HeaderStyle-BackColor="Black"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                            <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                            <ItemStyle Font-Names="Verdana" Width="200px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="By" DataField="BY" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                            <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                            <ItemStyle Font-Names="Verdana" Width="200px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="For" DataField="StaffID" ReadOnly="true" HeaderStyle-BackColor="Blue"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                            <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                            <ItemStyle Font-Names="Verdana" Width="200px" />
                                                        </asp:BoundField>

                                                        <asp:BoundField HeaderText="Message" DataField="ROLMessage" ReadOnly="true" HeaderStyle-BackColor="Black"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="600px" ItemStyle-Font-Bold="false"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-Font-Names="Verdana">
                                                            <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Left" />
                                                            <ItemStyle Font-Names="Verdana" Width="600px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="Date" DataField="Date" ReadOnly="true" HeaderStyle-BackColor="Black"
                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" ItemStyle-Font-Bold="false" ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Names="Verdana">
                                                            <HeaderStyle BackColor="Blue" ForeColor="White" HorizontalAlign="Center" />
                                                            <ItemStyle Font-Names="Verdana" Width="200px" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </telerik:RadWindow>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadWindow ID="rwReference" CssClass="bcolor" VisibleOnPageLoad="false" Width="900" Height="600" Title="Reference" runat="server" Modal="true" Font-Names="Verdana">
                        <ContentTemplate>
                            <div>
                                <table style ="width:100% ">
                                    <tr align="right" >
                                        <td>
                                            <asp:Button ID="btnReferenceHelp" runat="server" Text="Help" CssClass="btnSmallMainpage"
                                                                        Width="40px" OnClick="btnReferenceHelp_Click" ToolTip="" />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr style="text-align: center">
                                        <td>
                                            <asp:Label ID="lblReferencehead" runat="server" Text="Reference Codes and Description"
                                                ForeColor="DarkGreen" CssClass="style3" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvMReference" runat="server" AutoGenerateColumns="false" AllowPaging="true" ClientIDMode="Static" EmptyDataText="No Records"
                                                PageSize="11" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                DataKeyNames="RSN" OnPageIndexChanging="gvMReference_PageIndexChanging" Font-Bold="false" AllowSorting="true" OnSorting="gvMReference_Sorting">
                                                <Columns>

                                                    <asp:TemplateField HeaderText="V/E" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/Edit.png" runat="server" AlternateText="Sel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                CommandName="Select" />
                                                        </ItemTemplate>

                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="Group" DataField="TrackonGroup" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="TrackonGroup" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center"
                                                        ItemStyle-Width="80px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                    <asp:BoundField HeaderText="Reference" DataField="TrackonDesc" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="TrackonDesc" ItemStyle-Font-Names="Verdana"
                                                        ItemStyle-Width="90px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                    <asp:BoundField HeaderText="Remarks" DataField="TrackonRemarks" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Left"
                                                        SortExpression="TrackonRemarks" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                    <asp:BoundField HeaderText="Help Text" DataField="Helptext" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Left"
                                                        SortExpression="Helptext" ItemStyle-Font-Names="Verdana" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                    <asp:BoundField HeaderText="Flag" DataField="StatusFlag" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                        HeaderStyle-ForeColor="White" SortExpression="StatusFlag" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center"
                                                        ItemStyle-Width="50px" ItemStyle-Font-Size="Smaller" ItemStyle-Font-Bold="false" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr style="text-align: center">
                                        <td>
                                            <asp:Button ID="btnRefClose" runat="Server" Text="Close" Font-Size="Small"
                                                ToolTip="Click here to close the reference details" OnClick="btnRefClose_Click" CssClass="btnAdminExit" Width="74px" Height="26px" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </telerik:RadWindow>
                </td>
            </tr>
        </table>
    </div>
    <%--  </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="TileReports" />
            <asp:PostBackTrigger ControlID="TileSettings" />
            <asp:PostBackTrigger ControlID="TileNewEnquiry" />
            <asp:PostBackTrigger ControlID="TileNewTask" />
        </Triggers>
    </asp:UpdatePanel>
    
    <asp:UpdateProgress AssociatedUpdatePanelID="upnlMain" runat="server" ID="upnlprogress">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                    <br />
                    <img src="Images/Loader.gif" alt="Please Wait" />
                </div>
            </div>

        </ProgressTemplate>--%>
    <%-- </asp:UpdateProgress>--%>



    <%-- <div style="padding: 0px; margin-top:0px;">        
    <div style="clear:both;"></div>           
      <table style ="width:auto;margin:0 auto;">
            <tr>
                <td>                    
                   <telerik:RadContentTemplateTile ID="TileMyTasks" OnClick="TileMyTasks_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" runat="server"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbltilemytasks" runat="server" Text="My Tasks" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style ="text-align:center">
                                        <td style ="align-content:center">                                            
                                            <asp:Label ID="lbltilemytaskscount" runat="server" Text="" ForeColor ="White" Font-Names ="verdana"></asp:Label>                                        
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>           
                   
                </td>
                <td>
                    <telerik:RadContentTemplateTile ID="TileByMe" OnClick="TileByMe_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" runat="server"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text="Assigned by me" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style ="text-align:center">
                                        <td style ="align-content:center">
                                            
                                            <asp:Label ID="lbltilebymecount" runat="server" Text="" ForeColor ="White" Font-Names ="verdana"></asp:Label>
                                        
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                   
                </td>
                <td>
                    <telerik:RadContentTemplateTile ID="TileCustomers" OnClick="TileCustomers_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" runat="server"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text="New Leads" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            
                                            <asp:Label ID="Label4" runat="server" Text="Customers" ForeColor ="White" Font-Names ="verdana"  Font-Size ="Large"></asp:Label>
                                        
                                        </td>
                                    </tr>
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                   
                </td>
                <td>
                    <telerik:RadContentTemplateTile ID="TileNewTask" OnClick="TileNewTask_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" runat="server"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text="Assign a task" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    </tr>
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                   
                </td>
            </tr>
            <tr>
                <td>
                     <telerik:RadContentTemplateTile ID="TileInfoGraphics" OnClick="TileInfoGraphics_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#002060" Width="225px" runat="server"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text="InfoGraphics" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                   
                </td>
                <td>
                     <telerik:RadContentTemplateTile ID="TileReports" AutoPostBack="true" Font-Bold="true" Font-Names="verdana"  OnClick="TileReports_Click" BackColor="#002060" Width="225px" runat="server" ImageUrl="~/Images/Reports-tile.png"  >
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" Text="Reports" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                 
                </td>
                <td>        
                     <telerik:RadContentTemplateTile ID="TestTileDashboard" BackColor ="White" Font-Bold ="true" Font-Names ="verdana"  Width ="225px" runat ="server" BorderWidth="3px" BorderColor ="Black"  > 
                         <ContentTemplate >
                             <div style ="margin-top:40px">
                                 <center>
                                 <table style="vertical-align:middle;">
                                 <tr>
                                     <td>
                                         <asp:Label ID="lblMyTasks" runat="server" Text="Label"></asp:Label>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:Label ID="lblByMe" runat="server" Text="Label"></asp:Label>
                                     </td>
                                 </tr>
                                 <%--<tr>
                                     <td>
                                         <asp:Label ID="lblhipriority" runat="server" Text="Label"></asp:Label>
                                     </td>
                                 </tr>--%>
    <%-- <tr>
                                     <td>
                                         <asp:Label ID="lbloncomingFollowup" runat="server" Text="Label"></asp:Label>
                                     </td>
                                 </tr>
                                 </table>
                                 </center>
                              </div>
                        </ContentTemplate>
                      
                    </telerik:RadContentTemplateTile>

                </td>
                <td>
                    <telerik:RadContentTemplateTile ID="TileNewEnquiry" OnClick="TileNewEnquiry_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" runat="server">
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Text="A New Enquiry" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>
                </td>
            </tr>
            <tr>
                <td>                    
                     <telerik:RadContentTemplateTile ID="TileSettings" AutoPostBack="true" Font-Bold="true" Font-Names="verdana" OnClick="TileSettings_Click" BackColor="#5F497A" Width="225px" runat="server">
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label9" runat="server" Text="Settings" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>
                    
                </td>
                <td>
                     <telerik:RadContentTemplateTile ID="TileROL" OnClick="TileROL_Click" AutoPostBack="true" BackColor="#5F497A" Font-Bold="true" Font-Names="verdana" Width="225px" runat="server">
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label10" runat="server" Text="Recognitions" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                   
                </td>
                <td>                    
                     <telerik:RadContentTemplateTile ID="TileReference" BackColor="#5F497A" Font-Bold="true" Font-Names="verdana" Width="225px" runat="server"  OnClick="TileReference_Click" AutoPostBack ="true">
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label11" runat="server" Text="#Reference List" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>                    
                </td>
                <td>
                     <telerik:RadContentTemplateTile ID="TileNewLead" OnClick="TileNewLead_Click" Font-Bold="true" Font-Names="verdana" AutoPostBack="true" BackColor="#008000" Width="225px" runat="server">
                       <ContentTemplate>
                            <div style ="margin-top:50px ">
                                <center>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Text="A New Lead" ForeColor ="White" Font-Size ="Large" Font-Names ="verdana"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                </table>
                                    </center>
                            </div>
                       </ContentTemplate>
                   </telerik:RadContentTemplateTile>
                </td>
            </tr>
        </table>            
    </div>--%>
</asp:Content>
