<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" MasterPageFile="~/AppTheme/HomeMST.master" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

    <style type="text/css">
        </style>
    <title>Bin CRM</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="viewport" content="width=1040" />
        
    <link href="css/fonts.css" rel="stylesheet" />


    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="css/Popup.css" rel="stylesheet" type="text/css" />
    <link href="css/btnCSS.css" rel="stylesheet" />

    <%--<script src="JQuery/jquery-1.9.1.js" type="text/javascript"></script>  --%> 

    <script src="JQuery/jquery-1.10.3.js" type="text/javascript"></script>

    <%--<script src="JQuery/jquery-ui.js" type="text/javascript"></script>--%>

   <%-- <script src="JQuery/jquery.js" type="text/javascript"></script>--%>

    <%--<script src="js/jquery.min.js" type="text/javascript"></script>--%>

    <script src="js/jquery.dropotron.min.js" type="text/javascript"></script>

    <script src="js/config.js" type="text/javascript"></script>

    <script src="js/skel.min.js" type="text/javascript"></script>

    <script src="js/skel-panels.min.js" type="text/javascript"></script>
     <script type="text/javascript">
         function CallConfirmBox() {
             if (confirm("FIRST SIGN-IN FOR THE DAY.USAGE FEES WILL BE DEDUCTED NOW.CONFIRM?")) {
                 //OK – Do your stuff or call any callback method here..
                 //$.ajax({
                 //    url: 'Login.aspx/checkbalance',
                 //    type: 'get',
                 //    data: '',
                 //    success: function (data) {

                 //    }
                 //})
                 document.getElementById('<%= btnHidden.ClientID %>').click();
                 //PageMethods.checkbalance();
                 // alert("You pressed OK!");
             } else {
                 //CANCEL – Do your stuff or call any callback method here..
                 alert("You pressed Cancel!");
             }
         }
            </script>
    <script type='text/javascript'>
        var overlay = $('<div id="overlay"></div>');
        $(function () {

            $('.close').click(function () {
                $('.popup').hide();
                overlay.appendTo(document.body).remove();
                return false;
            });

            $('.x').click(function () {
                $('.popup').hide({
                    effect: "blind",
                    duration: 1000
                });
                overlay.appendTo(document.body).remove();
                return false;
            });
        });
        function OpenPopup() {
            overlay.show();
            overlay.appendTo(document.body);
            $("#pnlViewProblem").show();
            $("#pnlDocs").hide();
            $('.popup').show({
                effect: "blind",
                duration: 1000
            });
            return false;
        }

        var remConfirmed = false;
        function ShowPopup(obj, message, msgtitle, textOk, textCancel) {
            if (!remConfirmed) {
                $('body').append("<div id=dialog-confirm class=MsgBox style=display: none>");
                $("#dialog-confirm").html(message);
                $(function () {
                    $("#dialog-confirm").dialog({
                        title: msgtitle,
                        resizable: false,
                        modal: true,
                        buttons: [
                    {
                        text: textOk,
                        click: function () { $(this).dialog('close'); remConfirmed = true; if (obj) obj.click(); }
                    },
                    {
                        text: textCancel,
                        click: function () { $(this).dialog('close'); }
                    }
                        ]
                    });
                });
            }
            return remConfirmed;
        }
        function ShowMsgConfirmationUrl(obj, message, msgtitle, textOk, textCancel, url) {
            if (!remConfirmed) {
                $('body').append("<div id=dialog-confirm class=MsgBox style=display: none>");
                $("#dialog-confirm").html(message);
                $(function () {
                    $("#dialog-confirm").dialog({
                        title: msgtitle,
                        resizable: false,
                        modal: true,
                        buttons: [
                    {
                        text: textOk,
                        click: function () { $(this).dialog('close'); remConfirmed = true; if (obj) window.location = url; }
                    },
                    {
                        text: textCancel,
                        click: function () { $(this).dialog('close'); }
                    }
                        ]
                    });
                });
            }
            return remConfirmed;
        }
        function ShowMessage(message, msgtitle) {
            if (!remConfirmed) {
                $('body').append("<div id=dialog-confirm class=MsgBox style=display: none>");
                $("#dialog-confirm").html(message);
                $(function () {
                    $("#dialog-confirm").dialog({
                        title: msgtitle,
                        resizable: false,
                        modal: true,
                        buttons: [
                    {
                        text: "OK",
                        click: function () { $(this).dialog('close'); }
                    }
                        ]
                    });
                });
            }
        }

        function checkPass() {

            var pass1 = document.getElementById('password');
            var pass2 = document.getElementById('txtConfirmPwd');

            var message = document.getElementById('confirmMessage');

            var goodColor = "#66cc66";
            var badColor = "#ff6666";

            if (pass1.value == pass2.value) {

                pass2.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "Passwords Match!"
            } else {

                pass2.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = "Passwords Do Not Match!"
            }
        }

        function NavigateDir2() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (250 + 25);
            iMyHeight = (window.screen.height / 2) - (150 + 15);
            var Y = 'ChangePassword.aspx';
            var win = window.open(Y, "Window2", "status=no,height=350,width=820,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }

    </script>

    <script type="text/javascript">
        function Open() {
            window.radopen("http://bincrm.com/aboutbcrm/GettingStarted.pdf", "RadWindow1");
          }

        function About() {
            window.radopen("http://bincrm.com/aboutbcrm/BiNCRMFeatures_L.pdf", "RadWindow2");
        }
        function Scenarios() {         
            window.radopen("http://bincrm.com/aboutbcrm/Scenarios.pdf", "RadWindow3");
        }

        function RadVideo() {
            window.radopen("http://bincrm.com/aboutbcrm/AboutBiNCRM.wmv", "RadWindow4");
        }

        function NavigateVideo() {

            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (250 + 50);
            iMyHeight = (window.screen.height / 2) - (150 + 25);
            var Y = 'Video.aspx';
            var win = window.open(Y, "Window2", "status=no,height=500,width=600,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();

        }
    </script>


    <%-- <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" type="text/css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-desktop.css" />
    </noscript>--%>


    <style type="text/css">
        .About {
            margin-left: 40px;
            font-family: Verdana;
            font-size: xx-small;
            color: Blue;
            height: 18px;
        }

        .AboutGreen {
            margin-left: 40px;
            font-family: Verdana;
            font-size: xx-small;
            color: Green;
            height: 18px;
        }
    </style>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += UserName();
            summ += password();
            if (summ == "") {
                return true;
            } else {
                alert(summ);
                return false;
            }
        }
        function UserName() {
            var Val = "";
            Val = document.getElementById('<%=txtUserID.ClientID%>').value;
            if (Val == "") {
                return "Please enter UserID" + "\n";
            } else {
                return "";
            }
        }
        function password() {
            var Val = "";
            Val = document.getElementById('<%=txtPlainPassword.ClientID%>').value;
            if (Val == "") {
                return "Please enter Password" + "\n";
            } else {
                return "";
            }
        }
    </script>
    <script type="text/javascript">
        function EmailValidate() {
            var summ = "";
            summ += UserName();
            if (summ == "") {
                return true;
            } else {
                alert(summ);
                return false;
            }
        }
        function UserName() {
            var Val = "";
            var chk = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            Val = document.getElementById('<%=txtMailID.ClientID%>').value;
            if (Val == "") {
                return "Please enter EMail ID";
            } else if (chk.test(Val)) {
                return "";
            } else {
                return "Please enter Valid EMail ID";
            }
        }

    </script>

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

    <asp:UpdatePanel runat ="server" ID="pnlmail">


        <ContentTemplate>

          <script type="text/javascript">
              function confirmStatusCallbackFn(arg) {
                  if (arg) //the user clicked OK
                  {
                      __doPostBack("<%=btnHidden.UniqueID %>", "");
                 //__doPostBack('#btnHidden.UniqueID', "");

             }
             else {
                 alert('USAGE FEES NOT DEDUCTED');
             }
         }
        </script>

           

       <asp:Button ID="btnHidden" UseSubmitBehavior="false" Text="" Style="display: none;" OnClick="btnHidden_Click" runat="server" />

          <telerik:RadWindowManager runat="server" ID="RadWindowManager1" BackColor="Yellow" ForeColor="DarkBlue" >
            
         
          </telerik:RadWindowManager>
    
    <telerik:RadWindowManager runat="server" ID="RadWindowManager5">
        <Windows>
           <%-- <telerik:RadWindow ID="RadWindow3" runat="server" Width="1000" Height="500">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow2" runat="server" Width ="900" Height ="500">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow4" runat="server" Width ="900" Height ="500">
            </telerik:RadWindow>--%>
            <telerik:RadWindow ID="RadWindow1" runat="server" Width ="900" Height ="500">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    
    <telerik:RadWindow ID="rwDownloadMail" Width="620" Height="225" VisibleOnPageLoad="false" Title="Download Mobile App"
        runat="server" Modal="true">        
                <ContentTemplate>

                    <div>
                        <table style ="padding:5px">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" runat="server" Text="You have opted to install the mobile app in your smart phone."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" runat="server" Text="You can use the APP only if you are an authorised user of the software."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" runat="server" Text="It is suggested that you enter the ID configured in your smart phone so that you get the mail directly in your phone."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMobileHead" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" runat="server" Text="Enter your Email ID :"></asp:Label>
                                    <asp:TextBox ID="txtMailID" runat="server" TextMode="SingleLine" MaxLength="240" Font-Names="Verdana" Font-Size="Small" Width="400px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr align="Center">
                                <td >
                                    <asp:Button ID="btnMailSave" runat="server" Text="OK" CssClass="btnAdminSave" Width="74px" Height="26px"
                                        ToolTip="Click here to receive a mail." OnClick="btnMailSave_Click" OnClientClick="return EmailValidate();" />
                                    <asp:Button ID="btnMailCancel" runat="server" Text="Cancel" CssClass="btnAdminSave" Width="74px" Height="26px"
                                        ToolTip="Click here to close the window." OnClick="btnMailCancel_Click" />
                                </td>
                            </tr>

                        </table>

                    </div>
                </ContentTemplate>              

    </telerik:RadWindow>

    <div class="leftcnt">
        <div style="padding: 15px; margin-left: 50px;">


            

            <h4>SIGN IN TO YOUR ACCOUNT</h4>


            <table cellpadding="10px">
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="User ID"></asp:Label>

                    </td>
                    <td>
                        <asp:TextBox ID="txtUserID" Text="" ToolTip="Enter Your User ID. Not case sensitive" runat="server"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtPlainPassword" runat="server" Text="" ToolTip="Enter Your Password. Not case sensitive" TextMode="Password">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSignIn" runat="server" Text="Sign In" OnClick="btnSignIn_Click" OnClientClick="javascript:return Validate()"
                            CssClass="ph-button ph-btn-blue" ToolTip="Use this option from a  Computer and not from a Smart Phone" />

                        &nbsp;&nbsp;&nbsp;
                         <asp:Button ID="btnChangePwd" runat="server" Text="Change Password" OnClick="btnChangePwd_Click"
                             CssClass="ph-button ph-btn-blue" Width="150px" ToolTip="You can change your password. Better done from a computer" />

                    </td>
                </tr>
            </table>


        </div>
        <br />
        <div style="margin-top: 90px;width:100%;height:50%;">
            <nav class="shift">
                <%--<telerik:RadWindowManager ID="RadWindowManager1" runat="server" Width="900" Height="500">
                    <Windows>
                      
                    </Windows>
                </telerik:RadWindowManager>

                <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Width="900" Height="500">
                    <Windows>
                        
                         </Windows>
                </telerik:RadWindowManager>
                   

                <telerik:RadWindowManager ID="RadWindowManager3" runat="server" Width="100%" Height="100%">
                    <Windows>
                        
                    </Windows>
                </telerik:RadWindowManager>
                <telerik:RadWindowManager ID="RadWindowManager4" runat="server" Width="900" Height="500">
                    <Windows>
                      
                    </Windows>
                </telerik:RadWindowManager>--%>

                <ul>
                    <li>
                        <asp:LinkButton ID="lnkGettingStarted" runat="server" OnClick="lnkGettingStarted_Click" ToolTip="Click here to read a PDF document about how to start using the software">Getting Started</asp:LinkButton></li>
                    <li>
                        <asp:LinkButton ID="lnkAbout" runat="server" OnClick="lnkAbout_Click" ToolTip="Click here to read a PDF document about the software">About</asp:LinkButton></li>
                    <%--<li>
                        <asp:LinkButton ID="lnkVideo" runat="server" OnClick="lnkVideo_Click" OnClientClick="RadVideo(); return false;" ToolTip="Click here to watch a video about the software.  Make sure the speakers are ON.">Video</asp:LinkButton></li>--%>
                    <li>
                        <asp:LinkButton ID="lnkScenarios" runat="server" OnClick="lnkScenarios_Click" ToolTip="The software can be used for several purposes.  Click to read a PDF document about the scenarios of application.">Scenarios</asp:LinkButton></li>
                    <li>
                        <asp:LinkButton ID="lnkMobileApp" OnClick="lnkMobileApp_Click" runat="server" OnClientClick="" ToolTip="Click here to install the mobile app in your Android ® Smart Phone.  You can assign work, monitor status of work from anywhere.">MobileApp</asp:LinkButton></li>
                    <%--   <li><a href="#">Nice staff</a></li>--%>
                </ul>
            </nav>
        </div>
    </div>

    
    <div class="rightcnt">
        <div style="padding: 5px; color: #d5d4db; width: 100%; margin-top: 0px;">


            <p style="height: 225px;">

                <%-- <img src="Images/BinCRM-Fevicon.png" width="90" height="75" />--%>
                <img src="Images/BiNCRMImage3.jpg" width="220" height="250" />

            </p>
            <br />

            <p style="font-family: Verdana; font-weight: normal">
                <%--<img src="Images/tick-grey.png" style="margin-bottom:-4px;" width="15" height="15"  />--%>
                Spend LESS time on Status Update Meetings
            </p>
            <p style="font-family: Verdana; font-weight: normal">
                Now you have MORE time for your business growth!
            </p>
            <p style="font-family: Verdana; font-weight: normal">
                Have greater visibility across the organization!
            </p>

            <p style="font-family: Verdana; font-weight: normal">
                Offer prompt and top class customer support!
            </p>
            <p style="font-family: Verdana; font-weight: normal">
                Ensure repeat business due to efficient followups
            </p>
            <p style="font-family: Verdana; font-weight: normal">
                Benefit from a great knowledge base
            </p>
        </div>
    </div>


    <div>
        <div>
            <br />
            <marquee direction="left" runat="server" style="width: 1285px; margin-left: 0px; height: 20px; margin-bottom: 0px;">
                                <strong>
                                    <asp:Label ID="lblmsg" runat="server"  ForeColor="CadetBlue" Font-Names="Verdana" Font-Size="Small"  ></asp:Label>
                                </strong></marquee>
        </div>

        <div>
            <marquee direction="left" runat="server" style="width: 1285px; margin-left: 0px; height: 22px; margin-bottom: 0px;">
                                <strong>
                                    <asp:Label ID="lblcampaignmsg" runat="server"  ForeColor="DarkGreen"  Font-Names="Verdana" Font-Size="15px" ></asp:Label>
                                </strong></marquee>
        </div>
    </div>


            </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnHidden" />
             <asp:PostBackTrigger ControlID="btnSignIn" />
        </Triggers>

        </asp:UpdatePanel>

</asp:Content>
