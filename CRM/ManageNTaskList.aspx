<%@ Page Language="C#" AutoEventWireup="true" Trace="false" ViewStateMode="Enabled" CodeFile="ManageNTaskList.aspx.cs" Inherits="ManageNTaskList"  MasterPageFile="~/MasterPage.master" EnableEventValidation="false" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">  

    <script type="text/javascript" src="js/Disablebackbtn.js"></script> 
    <script type="text/javascript" src="js/ManageTask.js"></script>
    <script type="text/javascript" src="js/Validations.js"></script>

    <script type="text/javascript">
        TaskLIst();
    </script>
   
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>   

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
            summ += Email();
            summ += Name();
            summ += Designation();
            summ += UserID();
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
        function Designation() {
            var Name = document.getElementById('<%=txtcontDesignation.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Designation" + "\n";
            }
            else {
                return "";
            }
        }
        function UserID() {
            var Name = document.getElementById('<%=txtcontdepartment.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Department" + "\n";
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

        function Email() {
            var Name = document.getElementById('<%=txtcontemailid.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "Please Enter Email ID" + "\n";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Email ID" + "\n";
            }
        }
    </script>

     <style type="text/css">
         .preference .rwWindowContent {
             background-color: Green !important;
         }

         .availability .rwWindowContent {
             background-color: darkblue !important;
         }
     </style>
    <script type="text/javascript">
        //window.onload = ConfirmClick();
        function ConfirmClick() {
            document.getElementById('<%=wsgetLatestbtn.ClientID%>').click();
        }
    </script>
    <title>BinCRM</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
    </telerik:RadWindowManager>   
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="JQuery/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="JQuery/jquery.autocomplete.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function NavigateDir(X, Z) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (600 + 5);
            iMyHeight = (window.screen.height / 2) - (250 + 35);
            var Y = 'AddTaskTracker.aspx?TTID=' + X + '&UserID=' + Z;
            var win = window.open(Y, "Window2", "status=no,height=570,width=850,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
            win.focus();
        }

        function NavigateDir2() {
            var iMyWidth;
            var iMyHeight;
            var taskid = document.getElementById('<%=Label21.ClientID %>').innerText;
            iMyWidth = (window.screen.width / 2) - (450 + 50);
            iMyHeight = (window.screen.height / 2) - (285 + 30);
            var Y = 'AddTaskTracker.aspx';
            var win = window.open(Y, "Window2", "status=no,height=630,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }

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
        function NavigateNewEnquiry(getlatestbtn) {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 10);
            iMyHeight = (window.screen.height / 2) - (240 + 25);
            var X = window.document.getElementById('<%= HDLoginUser.ClientID %>').value;
            var Y = 'AddNewEnquiry.aspx?ctrlID=' + getlatestbtn + '&UserID=' + X;
            var win = window.open(Y, "Window2", "status=no,height=530,width=800,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,closed=no");
            win.focus();
        }         
    </script>
    <script type="text/javascript">
        function HideLabel() {
            var seconds = 30;
            setTimeout(function () {
                document.getElementById("<%=lblLoginDays.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    
    <table>
        <tr align="right" style="display:none;width:100%;" >
             <marquee direction="left" runat="server" style="width: 1285px; margin-left: 0px; height: 20px; margin-bottom: 0px;">
               <strong>
                    <asp:Label ID="lblLoginDays" runat="server" Font-Size="Medium" ForeColor="DarkGreen" Font-Names="Verdana" Visible="false"></asp:Label>
               </strong></marquee>
            </tr>
    </table>   
    <div id="main">       
        <br />
        <table style="width: 100%">
            <tr>
                <td align="left">
                    <table style="width: 100%">
                        <tr>                          
                            <td>                                
                                 <asp:Button ID="wsgetLatestbtn" runat="server" Text="WS Get Latest" onclick="wsgetLatestbtn_Click" CssClass="hidden"  CausesValidation="false" />
                            </td>
                            <td>
                                <asp:Button ID="btnNewBiz" runat="server" Text="View Point" CssClass="btnMainpage"
                                    ToolTip="Click here to open View Point Owners Dashboard."
                                    OnClick="btnNewBiz_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btnBusinessDashboard" runat="server" Text="InfoGraphics" CssClass="btnMainpage"
                                    ToolTip="Click here to open business dashboard." OnClick="btnBusinessDashboard_Click" Width ="150px"  />                               
                            </td>                         
                             <td>
                                <asp:Button ID="btnAssesPerform" runat="server" Text="Assess Performance" CssClass="btnMainpage"
                                    ToolTip="Click here to submit or assess performance."  Width ="150px" OnClick="btnAssesPerform_Click" Visible ="true" />
                            </td>
                            <td>
                                <asp:Button ID="btnROL" runat="server" Text="ROL" CssClass="btnMainpage"
                                    ToolTip="Recognitions/Likes/Observations."  Width ="100px" OnClick="btnROL_Click"  />
                            </td>                           
                            <td>
                                <asp:Button ID="btnAdmin" runat="server" Text="Settings" CssClass="btnMainpage"
                                    ToolTip="Click here to open admin module." OnClick="btnAdmin_Click" />
                            </td>                          

                            <td>                             
                                 <asp:Button ID="btnReports" runat="server" Text="Reports" CssClass="btnMainpage"
                                    ToolTip="Click here to open Reports." OnClick="btnReports_Click" />
                            </td>

                            <td style="width: 1500px; text-align: right">
                                <div style="margin-left: 0px">
                                    <asp:Button ID="btnExit" Text="Sign Out" runat="server" OnClick="btnExit_Click" CssClass="btnMainpage"
                                        ToolTip=" Click here to exit from the present session. Make sure you have saved your work." />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr align="right">
                <td style="text-align: right">
                    <asp:Label ID="lbloncomingfollowupstatus" runat="server" Font-Size="X-Small"  Font-Names="Verdana" ></asp:Label><br />
                    <asp:Label ID="lbloverdurefollowupstatus" runat="server" Font-Size="X-Small"  Font-Names="Verdana"></asp:Label><br />
                    <asp:Label ID="lbloverduetaskstatus" runat="server" Font-Size="X-Small" Font-Names="Verdana"></asp:Label>
                    <br />
                    <asp:Label ID="lblLikeandrecog" runat="server" Font-Size="X-Small" Font-Names="Verdana" ForeColor="DarkGray"></asp:Label>
                </td>
            </tr>
            <%--<tr align="right" style="display:none;width:100%;" >
             <marquee direction="left" runat="server" style="width: 1285px; margin-left: 0px; height: 20px; margin-bottom: 0px;">
               <strong>
                    <asp:Label ID="lblLoginDays" runat="server" Font-Size="Medium" ForeColor="DarkGreen" Font-Names="Verdana" Visible="false"></asp:Label>
               </strong>
             </marquee>
            </tr>--%>
        </table>

        <table style="width:100%">
            <tr>
                <td id="tdTab" style="width: 1200px; vertical-align: top;" visible="true" runat="server">
                    <asp:UpdatePanel ID="uptab" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>                                       
                                    </td>
                                </tr>
                                <%--Campaign Master--%>
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
                                <%--Reference Master--%>
                                <tr>
                                    <td>                                            
                                        <telerik:RadWindow ID="rwReference" Width="550" Height="600" VisibleOnPageLoad="false"
                                            runat="server" Style="z-index:7001" modal="true" >
                                            <ContentTemplate>
                                                
                                               <asp:UpdatePanel ID="upReference" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                    <ContentTemplate>

                                                        

                                                        <div style="float: left">
                                                            <div style="float: left">
                                                               
                                                                
                                                            </div>
                                                            <div style="float: left">
                                                                
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
                                <%--Status Help Popup--%>
                                <tr>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td>                                            
                                        <telerik:RadWindow ID="rwGraph" Width="800" Height="430" VisibleOnPageLoad="false" Title ="Sales Pipeline and Work Progress Summary"
                                            runat="server" Style="z-index:7001" modal="true" >
                                            <ContentTemplate>
                                                
                                             <table style ="width:100% ">
                                                 <tr>
                                                     <td>
                                                          <asp:Chart ID="cEnquiries" runat="server" Height="150px" Width="250px" >
                                        
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                  
                                     <asp:Chart ID="cQuotations" runat="server" Height="150px" Width="250px"  >
                                        
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>

                                     <asp:Chart ID="cQuotationsValue" runat="server" Height="150px" Width="250px" >
                                        
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                                     </td>
                                                 </tr>

                                                 <tr align ="center">
                                                     <td>
                                                           <asp:Chart ID="cWorkProgressSummary" runat="server" Height="200px" Width="300px"  >
                                         <Series>
                                            <asp:Series Name="WorkProgressSummary" YValuesPerPoint="1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                                     </td>
                                                 </tr>
                                             </table>
                                                   
                                            </ContentTemplate>

                                                   
                                            
                                        </telerik:RadWindow>                                                             
                                    </td>
                                </tr>


                                <%--Welcome Popup--%>
                               <tr>
                                    <td>
                                       <telerik:RadWindow ID="rwwelcome" Width="700" Height="320" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnReferenceHelp.ClientID  %>" Modal ="true" >
                                            <ContentTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <table>
                                                             <%--   <tr align ="center">
                                                                    <td >
                                                            <asp:Label ID="Welcome" runat="server" Text="" Font-Names ="Verdana" Font-Size ="Small"></asp:Label><br />
                                                           </td>
                                                                         </tr>--%>
                                                                 <tr>
                                                                    <td>
                                                                    <asp:Label ID="Label51" runat="server" Text="Congratulations! You are just a few steps away from starting to use the software." Font-Names ="Verdana" Font-Size ="Small" ForeColor ="White" ></asp:Label><br />
                                                            </td>
                                                                         </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label52" runat="server" Text="A brief profile of your organisation is already added for you." ForeColor ="White" Font-Names ="Verdana" Font-Size ="Small"></asp:Label><br />
                                                                        </td>
                                                                         </tr>
                                                                <tr>
                                                                    <td>
                                                            <asp:Label ID="Label53" runat="server" Text="Complete the profile first." Font-Names ="Verdana" Font-Size ="Small" ForeColor ="White"></asp:Label><br />
                                                                        </td>
                                                                         </tr>
                                                                 <tr>
                                                                    <td>
                                                            <asp:Label ID="Label54" runat="server" Text="One user is added for you, with which you have just signed-in." ForeColor ="White" Font-Names ="Verdana" Font-Size ="Small"></asp:Label>
                                                                    </td>
                                                                         </tr>
                                                                <tr>
                                                                    <td>
                                                                         <asp:Label ID="Label55" runat="server" Text="Add more users and their profiles." Font-Names ="Verdana" ForeColor ="White"  Font-Size ="Small"></asp:Label>
                                                                        
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label56" runat="server" Text="Continue by adding the profiles of your active customers."  ForeColor ="White" Font-Names ="Verdana"  Font-Size ="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label57" runat="server" Text="A standard list of #Reference Codes are already added for you. Delete whatever is not needed. Add more specific #Reference codes if needed." ForeColor ="White" Font-Names ="Verdana" Font-Size ="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label58" runat="server" Text="Once you have added the Users and active customers and have setup the #Reference codes , you are ready to go." ForeColor ="White" Font-Names ="Verdana"  Font-Size ="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label59" runat="server" Text="(This message appears on one of these two conditions: You are the only user or  you have only one profile added.)" ForeColor ="White" Font-Names ="Verdana"  Font-Size ="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table> 
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </telerik:RadWindow>
                                    </td>
                                </tr>
                                <%--Reference Help Popup--%>
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
                                <%--Customer Profile Popup--%>
                                <tr>
                                    <td>
                                        <telerik:RadWindow ID="rwCustomerProfile" VisibleOnPageLoad="false" Width="900" Height="350"
                                            runat="server" Modal="true">
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
                                                        <%--<tr style="border: 1px solid black;">
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblcpstatus" runat="server" Text="Status" Width="100px" CssClass="style2"
                                                                    ForeColor="DarkGray" Font-Bold="true" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                            <td style="border: 1px solid black;">
                                                                <asp:Label ID="lblscpstatus" runat="server" Text="" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size ="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>--%>
                                                       
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
                                                                <asp:Button ID="btnCPClose" runat="server" Text="Close" CssClass="Button" Width="100px"
                                                                    OnClick="btnCPClose_Click" ToolTip="Click to close customer status history." />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style ="width:60%; float:left">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label16" runat="server" Text="Contacts within the Company" CssClass="style2" ForeColor="DarkGreen"
                                                                    Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                 <asp:GridView ID="gvrwcontacts" runat="server" EmptyDataText="No Records has been added."
                                                                                    AutoGenerateColumns="false" CssClass="GridViewStyle" Font-Names ="verdana" Font-Size ="X-Small"
                                                                                    DataKeyNames="RSN">
                                                                     <HeaderStyle Font-Bold="false" />
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Designation" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="EmailID" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmailID" runat="server" Text='<%# Eval("EmailID") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="PhoneNo" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                           
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="MobileNo" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Department" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Location" ItemStyle-Width="150" HeaderStyle-Font-Bold="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            
                                                                                        </asp:TemplateField>
                                                                                       
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblcpinprogress"  runat="server" Font-Names="verdana"  Font-Size="X-Small" ForeColor="Black" BackColor="Yellow" Text="No of activities inprogress now"></asp:Label>
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
                                          <telerik:RadWindow ID="rwBusinessDashboard" Width ="700" Height ="450"  OpenerElementID="<%# btnBusinessDashboard.ClientID  %>" VisibleOnPageLoad ="false" runat ="server" Modal ="true"  >
                                            <ContentTemplate>
                                                <div>
                                                    <table >
                                                        <tr>
                                                            <td align ="center" colspan ="3">
                                                                <asp:Label ID="Label32" runat="Server" Text="Business Dashboard" Font-Bold="true" ForeColor ="DarkOliveGreen" Font-Names="Verdana" Font-Size="Medium" ></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label33" runat="Server" Text="From:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                                <telerik:RadDatePicker ID="dtpbdfrom" runat="server" Culture="English (United Kingdom)"
                                                                    Width="100px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                        CssClass="style2" Font-Names="verdana">
                                                                    </Calendar>
                                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                        Font-Names="verdana" ReadOnly="true">
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label34" runat="Server" Text="To:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                                <telerik:RadDatePicker ID="dtpbdto" runat="server" Culture="English (United Kingdom)"
                                                                    Width="100px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                        CssClass="style2" Font-Names="verdana">
                                                                    </Calendar>
                                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                        Font-Names="verdana" ReadOnly="true">
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label35" runat="Server" Text="Executive:" Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                                 <asp:DropDownList ID="ddlbdstaff" runat="server" Width="125px" CssClass="style3" ToolTip="">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <br />
                                                                <asp:Button ID="btnbdshow" runat="server" Text="Show" CssClass="btnSmallMainpage" Width="60px" ToolTip="Click to search business dashbord details against dates and executives." OnClick ="btnbdshow_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table style ="border-collapse:collapse" >
                                                        
                                                        <tr style ="background-color:#5B74A8 " >
                                                           <td class ="tborder">
                                                                 <asp:Label ID="Label30" runat="Server" Text="" Font-Bold="false" Font-Names="Verdana"
                                                        Font-Size="Smaller" ForeColor ="White" ></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label24" runat="Server" Text="Count" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"  ForeColor ="White"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label9" runat="Server" Text="Rs."  Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"  ForeColor ="White"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label12" runat="Server" Text="Hot Leads" ForeColor="DarkBlue"
                                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblhlcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblhlvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label13" runat="Server" Text="Warm" ForeColor="DarkBlue"
                                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblwcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblwvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label17" runat="Server" Text="Quotaions" ForeColor="DarkBlue"
                                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblqcount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblqvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label22" runat="Server" Text="Enquiries" ForeColor="DarkBlue"
                                                        Font-Bold="false" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblecount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                <asp:Label ID="lblevalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table style ="border-collapse:collapse" >
                                                        <tr style ="background-color:#5B74A8 ">
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label25" runat="Server" Text="" Font-Bold="false" Font-Names="Verdana"
                                                        Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                       
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label26" runat="Server" Text="Count" ForeColor="White" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="Label27" runat="Server" Text="Value" ForeColor="White" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label28" runat="Server" Text="New Orders" Font-Bold="false" ForeColor="DarkBlue" Font-Names="Verdana"
                                                        Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                       
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lblnocount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lblnovalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label29" runat="Server" Text="Existing customers" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Verdana"
                                                        Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                       
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lbleccount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lblecvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td class ="tborder">
                                                                <asp:Label ID="Label31" runat="Server" Text="New Customers" ForeColor="DarkBlue" Font-Bold="false" Font-Names="Verdana"
                                                        Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                       
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lblnccount" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                            <td class ="tborder">
                                                                 <asp:Label ID="lblncvalue" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="false"
                                                        Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table >
                                                        <tr>
                                                            <td>
                                                                 <asp:GridView ID="gvOrderBook" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                                                PageSize="10" Font-Names="Calibri" Font-Size="X-Small"  ForeColor="DarkBlue">
                                                                                <Columns>
                                                                                  
                                                                                    <asp:BoundField HeaderText="Reference" DataField="Reference" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    <asp:BoundField HeaderText="Count" DataField="Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    
                                                                                    <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                    
                                                                                </Columns>
                                                                            </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table >
                                                        <tr>
                                                            <td >
                                                                 <asp:GridView ID="gvCategorySummary" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                                                                                PageSize="10" Font-Names="Calibri" Font-Size="X-Small"  ForeColor="DarkBlue">
                                                                                <Columns>
                                                                                  
                                                                                    <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    <asp:BoundField HeaderText="Warm" DataField="Warm" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="80px" />
                                                                                    
                                                                                    <asp:BoundField HeaderText="Value" DataField="WarmValue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                    <asp:BoundField HeaderText="Hot" DataField="Hot" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                    <asp:BoundField HeaderText="Value" DataField="Hotvalue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                    <asp:BoundField HeaderText="Orders" DataField="Orders" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
                                                                                        HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana" HeaderStyle-HorizontalAlign="Left"
                                                                                        ItemStyle-Width="300px" />
                                                                                    <asp:BoundField HeaderText="Value" DataField="OrdersValue" ReadOnly="true" HeaderStyle-BackColor="#5B74A8" ItemStyle-Font-Size="X-Small"
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
                                <%--Customer contacts popup start--%>
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
                                       <%-- <telerik:RadWindowManager ID="rwmMain" runat="server"></telerik:RadWindowManager>
                                         <telerik:RadWindow ID="rwServicedetails" runat="server" Width="950px" Height="400px" Title ="Services" VisibleOnPageLoad="true" Modal="true"  OpenerElementID="<%# btnAddService.ClientID  %>">  --%>                                         
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
                                                                            <asp:DropDownList ID="ddlrwservice" runat="server" ToolTip="Select a service which you provide for this customer." Font-Names="Verdana"></asp:DropDownList>
                                                                        </td>
                                                                       <td>
                                                                             <asp:Label ID="Label41" runat="server" CssClass="style2" Font-Size="Small"
                                                                                 Font-Bold="false" Font-Names="Verdana" Text="From Date"></asp:Label>
                                                                             <br />
                                                                              <telerik:RadDatePicker ID="RadDateserfrom" runat="server" Culture="English (United Kingdom)" AutoPostBack="false"
                                                            Width="70px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Optional.If you know the start date of the service for the customer enter it here else leave it blance.">
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
                                                            Width="70px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true" ToolTip="Optional.If you know the end date of the service for the customer enter it here else leave it blance.">
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
                                                                        <td></td>
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
                                                                                                <asp:Label ID="lblReference" runat="server" Text='<%# Eval("Reference") %>'></asp:Label>
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
                                <%--Change Status Popup--%>
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
                                                                <%--<telerik:RadDatePicker ID="dtpchangestatusfollowupdate" runat="server" Culture="English (United Kingdom)"
                                                                    CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="true">
                                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                        CssClass="style2" Font-Names="verdana" >
                                                                    </Calendar>
                                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                        Font-Names="verdana" ReadOnly="true">
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>--%>
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
                                       <telerik:RadWindow ID="rwROL" VisibleOnPageLoad="false" Width="1000" Height="500"  runat="server" Modal="true" Font-Names="Verdana">
                             <ContentTemplate>
                               <div align="center" style="width:100%;">
                               <div style="width:50%;float:left;">
                               <table cellpadding="10px" style="text-align:center">                                                                      
                                <tr>
                                    <td colspan="2" style="text-align: center;font-size:smaller;">
                                        <asp:Label ID="Label36" runat="server" Font-Size="Small" Text="Are you happy with the work done by your colleague?" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        <br />
                                         <asp:Label ID="Label38" runat="server" Font-Size="Small" Text="Did you ‘Observe’ some flaw in the work done by your sub-ordinate?" ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                        <br />
                                         <asp:Label ID="Label39" runat="server" Font-Size="Small" Text="You can give your feedback here." ForeColor="DarkBlue" Font-Names="Verdana" CssClass="style3"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="width:50%;">
                                    <td align="right" style="width:25%;">
                                        <asp:Label ID="lblStaffID" runat="Server" Text="For" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                    </td>
                                    <td align="left" style="width:25%;">
                                        <asp:DropDownList ID="ddlStaffID" runat="server" Width="150px" ToolTip="Select the User/Colleague name." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="width:50%;">
                                    <td align="right" style="width:25%;">
                                        <asp:Label ID="lblROLTYPE" runat="Server" Text="Type" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                    </td>
                                    <td align="left" style="width:25%;">
                                        <asp:DropDownList ID="ddlROLTYPE"  runat="server" Width="150px" ToolTip="Please see below for description." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="Recognition" Value="Recognition"></asp:ListItem>
                                            <asp:ListItem Text="Like" Value="Like"></asp:ListItem>
                                            <asp:ListItem Text ="UCanDoBetter" Value ="UCanDoBetter"></asp:ListItem>
                                            <asp:ListItem Text="Observation" Value="Observation"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="width:50%;">
                                    <td align="left" style="width:27%;">
                                        <asp:Label ID="lblROLMessage" runat="Server" Text="Enter your comments" ForeColor=" Black " Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                    </td>
                                    <td align="left" style="width:23%;">
                                        <asp:TextBox ID="ROLMessage" runat="Server" MaxLength="200" ToolTip="Please enter a descriptive comment – What you liked or What you wish to point out." ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>                               
                                <tr style="width:50%;">
                                    <td></td>
                                    <td align="left">
                                        <asp:Button ID="btnROLSave" runat="Server" Text="Save" Font-Size="Small"
                                            ToolTip="Click here to save the details" ForeColor="White"
                                            CssClass="btnAdminSave" Width="74px" Height="26px"
                                            OnClientClick="javascript:return ConfirmMsg()" OnClick="btnROLSave_Click" />

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
                                   <br />
                             <asp:Label ID="lbltotalRecognition" runat="server" Text="" ForeColor="DarkBlue"></asp:Label>     
                          </div>
                         <div style="font-family:Verdana;font-size:x-small;width:40%;float:left;">
                             <br />
                             <br />
                             <br />
                             <br />
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
                                        Text ="Why do we need this feature?  By using this option, every good performance gets duly noticed and at the same time weaknesses are also pointed out politely. 
                                         Fosters a team spirit and a good work environment."></asp:Label>
                                        </td>                                   
                                    </tr>
                                </table>
                            </div>
                      </div>
                   <div style="width:50%">
                    <table style="width:50%;">  
                             
                        <tr align="center">    
                                       
                                <asp:GridView ID="gvROL" runat="server" Font-Names="Calibri" Font-Size="Small"                                    
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
                           </tr>                       
                        </table>
                           </div>         
                                 </ContentTemplate>
                          </telerik:RadWindow>
                                    </td>
                                </tr>
                            </table>
                             <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" 
                                Skin="Office2007" BackColor="#5C90C4" AutoPostBack="true" TabIndex="1"
                                BorderStyle="None" BorderWidth="1px" OnTabClick="RadTabStrip1_TabClick">
                                <Tabs>                                
                                    <telerik:RadTab runat="server" Text="My Tasks" PageViewID="PageView3" Font-Size="15px" SelectedIndex="1" Selected="true"
                                        Font-Names="Verdana" ForeColor="Black" Font-Bold="true" ToolTip=" View and manage tasks (activities/work) assigned to you.">
                                    </telerik:RadTab>
                                    <telerik:RadTab runat="server" Text="By Me" PageViewID="PageView4" Font-Size="15px" SelectedIndex="2"
                                        Font-Names="Verdana" ForeColor="Black" Font-Bold="true" ToolTip="Tasks delegated By me and assigned by me">
                                    </telerik:RadTab>                                  
                                    <telerik:RadTab runat="server" Text="Customers" PageViewID="PageView8" Font-Size="15px" SelectedIndex="3"
                                        Font-Names="Verdana" ForeColor="Black" Font-Bold="true" ToolTip="Add a new lead/prospect/customer/vendor & manage their profile.">
                                    </telerik:RadTab>                             
                                </Tabs>
                            </telerik:RadTabStrip>
                                       <telerik:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%"
                                Visible="true" BorderColor="LightGray" BorderStyle="Ridge" BorderWidth="1">                               
                               
                                <telerik:RadPageView ID="PageView3" runat="server" ForeColor="Black" Selected="true">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="ddlTaskList1" runat="server" CssClass="style3" AutoPostBack="true"
                                                                Skin="Windows7" OnSelectedIndexChanged="ddlTaskList1_Change" ToolTip="Select tasks according to their status." BackColor ="Yellow" >
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlMyTasksReference" runat="server" CssClass="style3" Skin="Windows7" ToolTip="#Reference  - Use #Tags to identify the purpose of an activity." BackColor ="Yellow" ></asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="dtpTaskDate1" runat="server" Culture="English (United Kingdom)"
                                                                Width="160px" CssClass="style2" Font-Names="verdana" ReadOnly="true" Visible="false">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                    CssClass="style2" Font-Names="verdana">
                                                                </Calendar>
                                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="style2"
                                                                    Font-Names="verdana" ReadOnly="true">
                                                                </DateInput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                        <td>
                                                           <%-- <asp:Button ID="btnView1" runat="server" Text="View/Refresh" CssClass="btnMainpage" ToolTip="Click to View your tasks/activities"
                                                                OnClick="btnView1_Click" BackColor="#6CA5BC"  />--%>
                                                            <asp:Button ID="btnMyTasks"  BackColor="#6CA5BC" runat="server" Text="View/Refresh" CssClass="btnMainpage" ToolTip="Click to View your tasks/activities" OnClick="btnMyTasks_Click" />
                                                                 
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnNewPing1" runat="server" Text="Update" OnClick="btnNewPing1_Click"
                                                                BackColor="#6CA5BC" Visible="false" CssClass="btnMainpage" ToolTip="Select one or more tasks, and write progress of work in each task . These are known as Tracker entries." />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnTaskDetDir1" runat="server" Text="Export to Excel" CssClass="btnMainpage" Width="120px"
                                                                BackColor="#6CA5BC" Visible="false" OnClick="btnTaskDetDir1_Click" ToolTip="Export the list of tasks to MSExcel." />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="Button2" runat="server" Text="Add New Task" CssClass="btnMainpage" Width="130px"
                                     ToolTip="Click here to assign a new activity to yourself or your sub-ordinates." OnClick="Button2_Click" ForeColor ="Black" />
                                                        </td>
                                                        <td>
                                                             <asp:Button ID="btnnewenquiry" runat="server" Text="Add New Enquiry" CssClass="btnMainpage" Width="130px"
                                     ToolTip="Click here to register new enquiry." OnClick="btnnewenquiry_Click" ForeColor ="Black" />
                                                        </td>
                                                        <td align ="right">
                                                           <%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                                                            <asp:Label ID="lblmytaskscount" runat="server" Text="" Font-Names ="Calibri" Font-Bold ="true" ForeColor ="Green"></asp:Label>
                                                        </td>
                                                        <%--<td>
                                                            <asp:Button ID="lnkClearChk1" runat="server" Text="Deselect All" CssClass="btnMainpage"
                                                                BackColor="#6CA5BC" Visible="false" OnClick="ClearGrid1" ToolTip="Click to DeSelectAll selected tasks." />
                                                        </td>--%>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblHelp11" Font-Bold="true" Text="Select one or more tasks and click 'Update' button.Click View to refresh screen to review/update progress. PING: Click on a # number to request for Progress Update.  A mail goes to the person."
                                                    ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Small" runat="server"></asp:Label><br />
                                                <asp:Label ID="Label10" runat="server" BackColor="Yellow" Font-Bold="true" Font-Names="calibri" ForeColor="DarkGray" Font-Size="Small"
                                                    Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 80%">
                                                <table>
                                                    <tr>
                                                        <td align="left" style="width: 93%">
                                                            <asp:Label ID="Label4" runat="server" ForeColor="DarkGreen" Font-Names="Calibri"
                                                                Font-Size="Large" Visible="false"></asp:Label>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button ID="Button7" runat="server" Text="Update" CssClass="Button" Visible="false"
                                                                OnClientClick="Navigate2()" />
                                                        </td>
                                                    </tr>
                                                </table>                                                 
                                                <%--<asp:Label ID="Label12" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Customer names appear in green."></asp:Label><br />--%>
                                                <telerik:RadGrid ID="RdGrd_TaskDetDir1" runat="server" Skin="WebBlue" GridLines="None" AllowFilteringByColumn ="true" GroupingSettings-CaseSensitive="false"
                                                    AutoGenerateColumns="False"  OnItemDataBound="RdGrd_ProjectSel_ItemDataBound1"  OnItemCommand="RdGrd_TaskDetDir1_ItemCommand" AllowSorting="true">
                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true"   >
                                                        <PagerStyle Mode="NextPrevAndNumeric" />
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderText="Select & Update" ItemStyle-Width="10px" Exportable="false" AllowFiltering ="false">
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleSelectedState" AutoPostBack="True" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkJSel" runat="server" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="StaffID"  HeaderText="AssignedTo" UniqueName="StaffID"
                                                                Visible="true" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridBoundColumn DataField="CustomerStatus" HeaderText="LeadStatus" UniqueName="CustomerStatus"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                             <telerik:GridTemplateColumn  HeaderText="Name"  ItemStyle-Width="10px"  FilterControlWidth ="50px" DataField ="Name" AllowFiltering ="true" >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnkname" runat="server" CommandName ="CustomerName" CommandArgument ='<%# Eval("CustomerRSN") %>' Text ='<%# Eval("Name") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                           <%-- <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridBoundColumn DataField="Mobile" HeaderText="MobileNo" UniqueName="Mobile" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                           <%-- <telerik:GridBoundColumn DataField="Comments" HeaderText=" Most recent work progress" UniqueName="Task"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>--%>
                                                              <telerik:GridTemplateColumn DataField="Comments" HeaderText="Most recent work progress" ItemStyle-Width="10px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px" AllowFiltering ="true"  >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnkcomments" runat="server" CommandName ="Activities" CommandArgument ='<%# Eval("CustomerRSN") %>' Text ='<%# Eval("Comments") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="#" ItemStyle-Width="10px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px" DataField ="TaskID" AllowFiltering ="true"  >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnktaskid" runat="server" CommandName ="Pink" CommandArgument ='<%# Eval("TaskID") %>' Text ='<%# Eval("TaskID") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target" UniqueName="TargetDate"   HtmlEncode="false" DataFormatString="{0:dd-MMM-yyyy}"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <%-- <telerik:GridBoundColumn DataField="TaskType" HeaderText="Task Type" UniqueName="TaskType"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridBoundColumn DataField="Priority" HeaderText="Priority" UniqueName="Priority"
                                                                Visible="false"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Status" HeaderText="TaskStatus" UniqueName="Status"
                                                                Visible="true" HeaderTooltip="if Hot or Very Hot Show Status in RED"  FilterControlWidth ="50px"  >
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Tracker" HeaderText="Ct." UniqueName="Tracker"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  FilterControlWidth ="30px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Followupdate" HeaderText="Fwup?" UniqueName="FollowupDate"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="PriorityDesc" HeaderText="Priority" UniqueName="PriorityDesc"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="AssignedBy" HeaderText="AsgndBy" UniqueName="AssignedBy"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="DelegateBy" HeaderText="DlgtBy" UniqueName="DelegateBy"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>


                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                              
                                            </td>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="PageView4" runat="server" ForeColor="Black">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="ddlTaskList2" runat="server" CssClass="style3" AutoPostBack="true"
                                                                OnSelectedIndexChanged="ddlTaskList2_Change" ToolTip="Select tasks according to their status. "  BackColor ="Yellow" >
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlbymereference" runat="server" CssClass="style3" BackColor ="Yellow" ToolTip ="#Reference  - Use #Tags to identify the purpose of an activity." >
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnView2" runat="server" Text="View/Refresh" CssClass="btnMainpage" ToolTip=""
                                                                OnClick="btnView2_Click" BackColor="#6CA5BC" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnNewPing2" runat="server" Text="Update" OnClick="btnNewPing2_Click"
                                                                BackColor="#6CA5BC" Visible="false" CssClass="btnMainpage" ToolTip="Select one or more tasks, and write progress of work in each task . These are known as Tracker entries." />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnTaskDetDir2" runat="server" Text="Export to Excel" CssClass="btnMainpage" Width="120px"
                                                                BackColor="#6CA5BC" Visible="false" OnClick="btnTaskDetDir2_Click" ToolTip="Export the list of tasks to MSExcel." />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="Button1" runat="server" Text="Add New Task" CssClass="btnMainpage" Width="130px"
                                     ToolTip="Click here to assign a new activity to yourself or your sub-ordinates." OnClick="Button2_Click" ForeColor ="Black"  />
                                                        </td>
                                                        <td>
                                                             <asp:Button ID="btnbymenewenquiry" runat="server" Text="Add New Enquiry" CssClass="btnMainpage" Width="130px"
                                       ToolTip="Click here to register new enquiry." OnClick="btnbymenewenquiry_Click" ForeColor ="Black" />
                                                        </td>
                                                        <%--<td>
                                                            <asp:Button ID="lnkClearChk2" runat="server" Text="Deselect All" CssClass="btnMainpage"
                                                                BackColor="#6CA5BC" Visible="false" OnClick="ClearGrid2" ToolTip="Click to DeSelectAll selected tasks." />
                                                        </td>--%>
                                                        <td>
                                                            <asp:CheckBox ID="chkShowAll" runat="server" ToolTip="If you have the permission, you can view tasks assigned by others also.  This opton is to see the complete list of activities in progress or completed." Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                                Text="View all" />
                                                        </td>
                                                         <td>
                                                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                           
                                                            <asp:Label ID="lblbymecount" runat="server" Text="" Font-Names ="Calibri" Font-Bold ="true" ForeColor ="Green"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblHelp44" Text="Select one or more tasks and click 'Update' button to review/update progress.Click View/Refresh button to refresh the screen.*Ensure POPUPS are NOT blocked. PING: Click on a # number to request for Progress Update.  A mail goes to the person."
                                                    ForeColor="DarkGray" Font-Names="Calibri" Font-Bold="true" Font-Size="Small"
                                                    runat="server" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 80%">
                                                <%--<asp:Label ID="Label13" runat="server" Font-Size="Smaller" Font-Names="Verdana" Text="Customer names appear in green."></asp:Label><br />--%>
                                                <telerik:RadGrid ID="RdGrd_TaskDetDir2" runat="server" Skin="WebBlue" GridLines="None" AllowFilteringByColumn ="true" GroupingSettings-CaseSensitive="false"
                                                    AutoGenerateColumns="False" Visible="false" OnItemDataBound="RdGrd_ProjectSel_ItemDataBound2" OnItemCommand="RdGrd_TaskDetDir2_ItemCommand">
                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                        <PagerStyle Mode="NextPrevAndNumeric" />
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </ExpandCollapseColumn>

                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderText="Select & Update" Exportable="false" AllowFiltering ="false" >
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleByMeSelectedState" AutoPostBack="True" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkJSel" runat="server" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="StaffID" HeaderText="Assigned To" UniqueName="StaffID"
                                                                Visible="true" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="CustomerStatus" HeaderText="LeadStatus" UniqueName="CustomerStatus"
                                                                Visible="true"  FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            
                                                            <telerik:GridTemplateColumn HeaderText="Name" ItemStyle-Width="10px" FilterControlWidth ="50px" DataField ="Name" >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnkname" runat="server" CommandName ="CustomerName" CommandArgument ='<%# Eval("CustomerRSN") %>' Text ='<%# Eval("Name") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            
                                                            <%--<telerik:GridBoundColumn DataField="Name" HeaderText="Name" Uni
                                                                queName="Name"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>--%>
                                                            
                                                            <telerik:GridBoundColumn DataField="Reference" HeaderText="#Reference" UniqueName="Reference"
                                                                Visible="true" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            
                                                            
                                                           <%-- <telerik:GridBoundColumn DataField="Comments" HeaderText="Most recent work progress" UniqueName="Task"
                                                                Visible="true" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>--%>

                                                            <telerik:GridTemplateColumn HeaderText="Most recent work progress" DataField="Comments" ItemStyle-Width="10px" ItemStyle-HorizontalAlign ="Center" HeaderStyle-HorizontalAlign ="Center" FilterControlWidth ="50px" >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnkcomments" runat="server" CommandName ="Activities" CommandArgument ='<%# Eval("CustomerRSN") %>' Text ='<%# Eval("Comments") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                             
                                                            <telerik:GridTemplateColumn HeaderText="#" ItemStyle-Width="10px" ItemStyle-HorizontalAlign ="Center" DataField ="TaskID" HeaderStyle-HorizontalAlign ="Center" FilterControlWidth ="50px" >
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="lnktaskid" runat="server" CommandName ="Pink" CommandArgument ='<%# Eval("TaskID") %>' Text ='<%# Eval("TaskID") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target" UniqueName="TargetDate"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <%--<telerik:GridBoundColumn DataField="TaskType" HeaderText="Task Type" UniqueName="TaskType"
                                                                Visible="true">
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridBoundColumn DataField="Priority" HeaderText="Priority" UniqueName="Priority"
                                                                Visible="false" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Status" HeaderText="TaskStatus" UniqueName="Status"
                                                                Visible="true" HeaderTooltip="if Hot or Very Hot Show Status in RED" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Tracker" HeaderText="Ct." UniqueName="Tracker"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="PriorityDesc" HeaderText="Priority" UniqueName="PriorityDesc"
                                                                Visible="true" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="Followupdate" HeaderText="Fwup?" UniqueName="FollowupDate"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="AssignedBy" HeaderText="AsgndBy" UniqueName="AssignedBy"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="DelegateBy" HeaderText="DlgtBy" UniqueName="DelegateBy"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth ="50px">
                                                            </telerik:GridBoundColumn>

                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                    </table>
                                </telerik:RadPageView>                                                         
                                <telerik:RadPageView ID="PageView8" runat="server" ForeColor="Black">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <div style="float: left">
                                                    <div style="float: left">
                                                        <table cellpadding="3px">


                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTitle" runat="server" Text="Mr./Mrs.:" CssClass="style3" Width="120"></asp:Label>
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
                                                                    <asp:Button ID="btnChangeStatus" runat="server" Text="Update" CssClass="btnSmallMainpage" CausesValidation ="false"
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
                                                                    <asp:GridView ID="gvProspectDetails" runat="server" AutoGenerateColumns="false" OnRowCommand="gvProspectDetails_RowCommand" Width="500px"
                                                                        AllowPaging="true" PageSize="20" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" CssClass="gridview_borders"
                                                                        OnPageIndexChanging="gvProsepctDetails_PageIndexChanging" DataKeyNames="RSN" ToolTip=""
                                                                        OnRowDataBound="gvProspectDetails_RowDataBound" OnRowCreated="gvProspectDetails_RowCreated">
                                                                        <Columns>

                                                                            <asp:TemplateField HeaderText="View" HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="30px" HeaderStyle-Width="30px">
                                                                                <ItemStyle CssClass="gridview_borders" />
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/Images/Edit.png" AlternateText="Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                                                        CommandName="Select" />
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
                                </telerik:RadPageView>

                            </telerik:RadMultiPage>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RadTabStrip1" EventName="TabClick" />                         
                            <%--<asp:AsyncPostBackTrigger ControlID="btnView1" EventName="Click" />--%>
                            <asp:AsyncPostBackTrigger ControlID="btnMyTasks" EventName="Click" />
                            <asp:PostBackTrigger ControlID="btnNewPing1" />
                            <asp:PostBackTrigger ControlID="btnNewPing2" />
                            <asp:PostBackTrigger ControlID="btnView2" />
                            <asp:AsyncPostBackTrigger ControlID="ddlTaskList1" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddlTaskList2" EventName="SelectedIndexChanged" />
                            <asp:PostBackTrigger ControlID="gvProspectDetails" />
                            <asp:AsyncPostBackTrigger ControlID ="btnstatushelp" EventName ="Click" />                            
                            <asp:AsyncPostBackTrigger ControlID="btnChangeStatus" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnAddNew" EventName="Click" />
                            <asp:PostBackTrigger ControlID="btnSearchMobileNo" />
                            <asp:PostBackTrigger ControlID="btnCSave" />
                            <asp:PostBackTrigger ControlID="btnCUpate" />
                            <asp:PostBackTrigger ControlID="btnGoogleMap" />                         
                            <asp:PostBackTrigger ControlID="btnTaskDetDir2" />
                            <asp:PostBackTrigger ControlID="btnTaskDetDir1" />                     
                            <asp:PostBackTrigger ControlID ="btnBusinessDashboard" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="uptab" runat="server">
                        <ProgressTemplate>
                            <div class="modal">
                                <div class="center">
                                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                                    <%--<asp:ImageButton ID="btnUpdateLoad" runat="server" ImageUrl="~/images/Loader.gif" />--%>
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
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
                </td>
            </tr>
        </table>
    </div>
     <asp:Button ID="btnSaveHidden" runat="server" Text="Save Hidden" OnClick="btnSaveHidden_Click"
        Style="display: none;" />
    <asp:Button ID="btnCancelHidden" runat="server" Text="Cancel Hidden" Style="display: none;"
        OnClick="btnCancelHidden_Click" />
    <asp:Label ID="Label21" runat="server" Text="Label" style="display:none"></asp:Label>
    <asp:HiddenField ID="CnfResult" runat="server" />
</asp:Content>
   