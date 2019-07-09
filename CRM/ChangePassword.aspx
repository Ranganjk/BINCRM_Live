<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bin CRM</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .water
        {
            color: gray;
            font-size: 12px;
        }
        .greytxt
        {
            color: gray;
            font-size: 16px;
            font-family: Calibri;
        }
        .border
        {
            border: 1px solid orange;
        }
        .error
        {
            color: Red;
        }
        .button_home
        {
            border: 1px solid #1e242d;
            -webkit-box-shadow: #FEFFFF 1px 1px 1px 1px;
            -moz-box-shadow: #FEFFFF 1px 1px 1px 1px;
            box-shadow: #FEFFFF 1px 1px 1px 1px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            height: 25px;
            text-decoration: none;
            display: inline-block;
            color: gray;
            background-color: #FEFFFF;
            cursor: pointer;
        }
    </style>

    <script type='text/javascript'>


        function checkPass() {

            var pass1 = document.getElementById('password');
            var pass2 = document.getElementById('txtConfirmPwd');

            var message = document.getElementById('confirmMessage');

            var goodColor = "#66cc66";
            var badColor = "#ff6666";

            if (pass1.value == pass2.value) {
                document.getElementById("error").innerHTML = "this is invalid name ";
            } else {
                document.getElementById("error").innerHTML = "this is invalid name ";
            }
        }

        function NavigateDir2() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (250 + 50);
            iMyHeight = (window.screen.height / 2) - (225 + 25);
            var Y = 'ChangePassword.aspx';
            var win = window.open(Y, "Window2", "status=no,height=500,width=600,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
   <div>
        <asp:Panel ID="pnlViewProblem" CssClass="pnlBorder" runat="server">
            <div class="divCellHeaderMod">
                <h3 style="color: Gray; font-family:Verdana" align="center">Change your Password</h3>
            </div>
            <div class="divPanel">               
                    <asp:Label ForeColor="Red" ID="lblError" Visible="false" runat="server" Text="">No Section found for this Activity</asp:Label>
                    <table style="padding-top: 15px">
                        <tr>
                            <td>
                                <table>
                        <tr height="35px">
                            
                            <td width="180px" align="left">
                                <asp:Label ID="Label3" CssClass="greytxt" ForeColor="#1A3253" runat="server">User ID
                                </asp:Label>
                                <asp:Label ID="Label9" ForeColor="#FF3300" runat="server">*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCPUserID" runat="server" ToolTip ="Enter your User ID.">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr height="35px">
                            
                            <td width="180px" align="left">
                                <asp:Label ID="Label2" CssClass="greytxt" ForeColor="#1A3253" runat="server">Current Password
                                </asp:Label>
                                <asp:Label ID="Label5" ForeColor="#FF3300" runat="server">*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCurrentPwd" MaxLength="20" TextMode="Password" runat="server" ToolTip ="Enter the Current password.Max 8 characters">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr height="35px">
                           
                            <td width="180px" align="left">
                                <asp:Label ID="Label4" CssClass="greytxt" ForeColor="#112b4d" runat="server">New Password
                                </asp:Label>
                                <asp:Label ID="Label8" ForeColor="#FF3300" runat="server">*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassword" MaxLength="20" TextMode="Password" runat="server" ToolTip="Set your new password. Maximum of eight alphanumeric characters.">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr height="35px">
                           
                            <td width="180px" align="left">
                                <asp:Label ID="Label6" CssClass="greytxt" ForeColor="#112b4d" runat="server">Confirm Password
                                </asp:Label>
                                <asp:Label ID="Label7" ForeColor="#FF3300" runat="server">*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfirmPwd" MaxLength="20" TextMode="Password" runat="server" ToolTip ="Re-Enter the new password.  Both must match.">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr  height="35px">
                           
                            <td colspan ="3" align="center" >
                                <asp:Button ID="btnUpd" ToolTip="Click Here To Change The Password" Text="CHANGE"
                                    runat="server" OnClick="btnUpd_Click" CssClass="button32"   />
                                <asp:Button ID="btnClose" ToolTip="Exit From Change Password" Text="CLOSE" runat="server"
                                    OnClick="btnClose_Click" CssClass="button32" />
                                <%-- OnClientClick="return OnSubmit();"
                                            OnClick="btnUpd_Click"--%>
                            </td>
                        </tr>
                                    </table>
                                </td>
                            <td valign ="top">
                                <asp:Label  ForeColor ="Black" Font-Bold ="false" Font-Names ="verdana" Font-Size="XX-Small"   ID="Label1" runat="server" Text="If you are signing in for the first time,  you must change your default Password (which is same as your User ID) here."></asp:Label><br />
                                <asp:Label  ForeColor ="Black" Font-Names ="verdana" Font-Size="XX-Small"  ID="Label10" runat="server" Text="Assign a new password here, which will be known only for you."></asp:Label><br />
                                <asp:Label  ForeColor ="Black" Font-Names ="verdana" Font-Size="XX-Small"  ID="Label11" runat="server" Text=" In case you have forgotten your password, ask your Administrator to RESET it as the Default."></asp:Label><br />
                                <asp:Label  ForeColor ="Black" Font-Names ="verdana" Font-Size="XX-Small"  ID="Label12" runat="server" Text="Never share your Password with any one."></asp:Label><br />
                                <asp:Label  ForeColor ="Black" Font-Names ="verdana" Font-Size="XX-Small"  ID="Label13" runat="server" Text="In BinCRM,  neither the User ID nor Password is Case Sensitive."></asp:Label><br />
                                <asp:Label  ForeColor ="Black" Font-Names ="verdana" Font-Size="XX-Small"  ID="Label14" runat="server" Text="Both can be a maximum of eight alpha numeric characters."></asp:Label>
                            </td>
                         </tr>
                    </table>
               
            </div>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
