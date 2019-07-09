<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Diary.aspx.cs" Inherits="Diary" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Diary</title>

      <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

     <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/adminCenterPositionCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" /> 
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager3" runat="server" EnablePartialRendering ="true" >
    </asp:ScriptManager>
        
          <script language="javascript" type="text/javascript">
         function ConfirmMsg() {
             var msg = "";
             msg = 'Do you want to Save?';
             var result = confirm(msg, "Check");

             if (result) {
                 document.getElementById('CnfResult').value = "true";
             }
             else {
                 document.getElementById('CnfResult').value = "false";
             }

         }

     </script>
        
    <div>
        <table width ="100%">
        
         <tr>
                <td align="right">
                    <asp:Button ID="btnDiaryClose" runat="server" Text="Close" CssClass="Button" Width="50px" OnClientClick="javascript:window.close();"
                        ToolTip="Click here to close diary." />
                </td>
           
        </tr>
        </table>
        </div>
        <div style ="margin-left:10px" >
        <table>
            <tr>
                <td align="left" style ="margin-left:10px"   >
                    <asp:Label ID="lbldiaryhead" runat="server" Text="Consolidated Diary of all interactions"
                        CssClass="style2" ForeColor="DarkBlue" Font-Bold="true" Width="1000px" Font-Names ="verdana"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style ="margin-left:10px" >
                    <asp:Label ID="lbldiaryheadName" runat="server" Text="" CssClass="style2" ForeColor="DarkBlue"
                        Font-Bold="true" Font-Size="Medium" Font-Names ="verdana"></asp:Label>
                    <asp:Label ID="lbldiaryheadType" runat="server" Text="" CssClass="style2" ForeColor="DarkGray" Font-Size="Small" Font-Names ="verdana"></asp:Label>
                    <asp:Label ID="lbldiaryheadStatus" runat="server" Text="" CssClass="style2" ForeColor="DarkGray"
                        Font-Size="Small" Font-Names ="verdana"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:GridView ID="gvDiary" runat="server" AutoGenerateColumns="false" OnDataBound="onDataBound"
                        AllowPaging="true" PageSize="20" OnPageIndexChanging="OnDiaryPaging" 
                        Font-Names ="Verdana" onrowcommand="gvDiary_RowCommand" DataKeyNames ="TaskID" >
                        <Columns>
                        
                            <asp:TemplateField HeaderText="#" HeaderStyle-BackColor="#5B74A8" SortExpression="RSN" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnktaskid" runat="server" Text ='<%# Eval("TaskID") %>' Width="100px" Font-Underline ="false" CommandName ="Select"  CommandArgument='<%#((GridViewRow)Container).RowIndex%>'></asp:LinkButton>
                                                <%--<asp:Label ID="lbltaskid" runat="server" Text='<%# Eval("TaskID") %>' Width="100px"></asp:Label>--%>
                                            </ItemTemplate>
                                            
                            </asp:TemplateField>                
                            <%--<asp:BoundField HeaderText="#" DataField="TaskID" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />--%>
                            <asp:BoundField HeaderText="Reference" DataField="TrackOn" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="100px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="Work Progress[Ascending order]" DataField="Comments" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="300px"
                                ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="Date" DataField="Datestamp" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="200px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="By" DataField="Userid" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="30px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="Value" DataField="Value" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="Timespent" DataField="Timespent" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />
                            <asp:BoundField HeaderText="Followupdate" DataField="Followupdate" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Width="10px"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Blue" />

                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
           
        </table>

    </div>
    <div  id ="dvAP" style ="margin-left:10px"   runat ="server" >
                    <br />
                    <table>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblapmsg" runat="server" Text="" Font-Names="Verdana"
                                    ForeColor="DarkBlue"></asp:Label>
                               
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:GridView ID="gvMoreinfo" runat="server" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="#333333" CssClass="gridview_borders" AutoGenerateColumns="False" DataKeyNames="RSN"
                                   CellPadding="4" GridLines="Both">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Group" HeaderStyle-BackColor="#E87502" SortExpression="Group"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblgroup" runat="server" Text='<%# Eval("MoreInfoGroup") %>' Width="50px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Key" HeaderStyle-BackColor="#E87502" SortExpression="MoreInfoKey"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblkey" runat="server" Text='<%# Eval("MoreInfoKey") %>' Width="50px"></asp:Label>
                                               <%-- <asp:LinkButton ID="lnkKey" runat="server" Width="60px" Font-Names="Verdana" Text='<%# Eval("MoreInfoKey") %>'
                                                    CommandName="Keys" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'></asp:LinkButton>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name" HeaderStyle-BackColor="#E87502" SortExpression="Name"
                                            HeaderStyle-ForeColor="White" Visible="false">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblname" runat="server" Text='<%# Eval("Customer") %>' Width="175px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="KeyDescription" HeaderStyle-BackColor="#E87502" SortExpression="moreinfodesc"
                                            HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                            <ItemTemplate>
                                                <%--<asp:Label ID="lbldescription" runat="server" Text='<%# Eval("moreinfodesc") %>' Width="250px"></asp:Label>--%>
                                                <asp:LinkButton ID="lnkdescription" runat="server" Width="250px" Font-Names="Verdana" Font-Underline ="false" 
                                                    Text='<%# Eval("moreinfodesc") %>' CommandName="description" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" HeaderStyle-BackColor="#E87502" SortExpression="Text"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbltext" runat="server" Text='<%# Eval("MoreInfoText") %>' Width="150px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Response" HeaderStyle-BackColor="#E87502" SortExpression="Response"
                                            HeaderStyle-ForeColor="White" Visible="false">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblresponse" runat="server" Text='<%# Eval("Response") %>' Width="150px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Count" HeaderStyle-BackColor="#E87502" SortExpression="MoreInfoInteger"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblcount" runat="server" Text='<%# Eval("MoreInfoInteger") %>' Width="100px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date" HeaderStyle-BackColor="#E87502" SortExpression="Date"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" runat="server" Text='<%# Eval("MoreInfoDate") %>' Width="80px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Value" HeaderStyle-BackColor="#E87502" SortExpression="MoreInfoValue"
                                            HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblvalue" runat="server" Text='<%# Eval("MoreInfoValue") %>' Width="100px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="EntryBy" HeaderStyle-BackColor="#E87502" SortExpression="CreatedBy"
                                            Visible="false" HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedby" runat="server" Text='<%# Eval("CreatedBy") %>' Width="50px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="EntryOn" HeaderStyle-BackColor="#E87502" SortExpression="CreatedOn"
                                            Visible="false" HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedon" runat="server" Text='<%# Eval("CreatedOn") %>' Width="50px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UpdateBy" HeaderStyle-BackColor="#E87502" SortExpression="ModifiedBy"
                                            Visible="false" HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblmodifiedby" runat="server" Text='<%# Eval("ModifiedBy") %>' Width="50px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UpdatedOn" HeaderStyle-BackColor="#E87502" SortExpression="ModifiedOn"
                                            Visible="false" HeaderStyle-ForeColor="White">
                                            <HeaderStyle BackColor="#E87502" ForeColor="White" />
                                            <ItemStyle BorderColor="#5B74A8" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblmodifiedon" runat="server" Text='<%# Eval("ModifiedOn") %>' Width="50px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                </asp:GridView>
                                <br />
                                <asp:Label ID="lblchelp" runat="Server" Text="" ForeColor="Gray" Font-Bold="false"
                                    Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
    </form>
</body>
</html>
