<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Charts.aspx.cs" Inherits="Charts"  MasterPageFile="~/MasterPage.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <title>Charts</title>
    <link href="css/gvCSS.css" rel="stylesheet" />

    <link href="css/btnCSS.css" rel="stylesheet" />

    <link href="css/focusCSS.css" rel="stylesheet" />

    <link href="css/adminCenterPositionCSS.css" rel="stylesheet" />   
     <link href="css/gvCSS.css" rel="stylesheet" />
    <link href="css/btnCSS.css" rel="stylesheet" />
    <link href="css/focusCSS.css" rel="stylesheet" />
    <link href="css/MenuCSS.css" rel="stylesheet" />
    <link href="css/lblCSS.css" rel="stylesheet" />
    <link href="css/ManageTask.css" rel="stylesheet" />  
     
    <style type="text/css">
        .Activity {
            background-color: red !important;
        }

        .style2 {
            text-align: center;
        }

        .style3 {
        }
    </style>


</asp:Content>

<%--//Added by Prakash.M//--%>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="Server">
    <div style="width: 100%">

        <asp:UpdatePanel ID="uptab" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
            <table style="width:100%;">
               <div style="text-align: center">
               <asp:Label ID="Label12" runat="server" Text="Charts" Font-Size="Large" 
                Font-Bold="True" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>                                                                   
                 </div>
                <tr style="width:100%">
                     <td style="width:8%;display:inline">                          
                          <asp:Button ID="Button1" runat="server" Text="Leads" CssClass="level_menu" Width="130" Font-Size="X-Small" OnClick="Button1_Click"/>
                          <asp:Button ID="btnchart" runat="server" CssClass="level_menu" Width="130" Font-Size="X-Small" Text="Customers" OnClick="btnchart_Click"/>                         
                         <asp:Button ID="btnReturn" runat="server" CssClass="level_menu" Width="130" Font-Size="X-Small" Text="Return" OnClick="btnReturn_Click"/>
                     </td>
                    <td style="width:92%;border:black 2px"">
                         <div id="divLeadSummary" runat="server" style="border-style:solid;border-width:thin;border-color:blue">
                             <div style="text-align:center">
                                 <asp:Label ID="lblLeadSummary" Text="Chart Leads" runat="server"  Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                             </div>                                                                                            
                                                    <table>
                                                        <tr>
                                                            <td>  
                                                                 <div style="float: left; width: 551px;">  
                                                               <asp:GridView ID="gvLeadSourceSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                                    AllowPaging="false"  PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                                    OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]" Width="548px">
                                                                   <FooterStyle HorizontalAlign="Center" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR2 Lead Source" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Lead Count" DataField="LeadCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Qualified" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvLeadSourceSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" Width="544px">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Lead Count" DataField="LeadCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="Lead Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Qualified" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                                    </Columns>
                                                                </asp:GridView>                                                                
                                                                </div>                                                               
                                                                 <asp:ImageButton ID="btnimgLedSrcExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLedSrcExporttoExcel_Click" style="text-align: right" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                         </td>
                                                            <td>
                                                                <telerik:RadHtmlChart ID="chartLeadSummary" runat="server" Height="300px" Legend-Appearance-Position="Right" Legend-Appearance-Visible="true" Width="450px">
                                                                    <PlotArea>
                                                                        <Series>
                                                                            <telerik:PieSeries DataFieldY="percentage" ExplodeField="IsExploded" Name="leadsource" NameField="leadsource">
                                                                                <LabelsAppearance DataFormatString="{0}%">
                                                                                </LabelsAppearance>
                                                                                <TooltipsAppearance>
                                                                                    <ClientTemplate>
                                                                                          #=dataItem.leadsource#<br />
                                                                                           #=dataItem.percentage# % 
                                                                                        </ClientTemplate>
                                                                                </TooltipsAppearance>
                                                                            </telerik:PieSeries>
                                                                        </Series>
                                                                        <YAxis Name="leadsource">
                                                                        </YAxis>
                                                                    </PlotArea>
                                                                    <ChartTitle Text="LeadSource">
                                                                    </ChartTitle>
                                                                </telerik:RadHtmlChart>
                                                            </td>
                                                         <td>                                                            
                                                                <div style="float:left">                                                                                                                           
                                                                </div>                                                                                                                                                                           
                                                                <div style ="float:left">                                                              
                                                                </div> 
                                                   </td>
                                                </tr>                                                        
                                                        <tr>                                                         
                                                         <td>
                                                         <div style ="float:left; width: 563px;">                                                           
                                                              
                                                                <asp:GridView ID="gvLeadStatusSummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                                    AllowPaging="false"  PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                                    OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]">
                                                                    <FooterStyle HorizontalAlign="Center" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR2 Lead Status" DataField="Status" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Count" DataField="StatusCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />
                                                                       
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvLeadStatusSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue">
                                                                    <Columns>
                                                                       <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="StatusCount" DataField="StatusCount" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="percentage" DataField="percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="205px" ItemStyle-HorizontalAlign="Center" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                </div>
                                                             <asp:ImageButton ID="btnimgLedStatusExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLedStatusExporttoExcel_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                             </td>
                                                            <td>
                                                                <div style ="float:left">                                                          
                                                                 
                                                                </div>                                                           
                                                                <div style ="float:left">                                                               
                                                                <telerik:RadHtmlChart runat="server" ID="chartleadstatussummary" Height="300px" Width="450px" Legend-Appearance-Visible = "true" Legend-Appearance-Position ="Right" >
                                                                       <PlotArea>
                                                                            <Series>
                                                                                 <telerik:PieSeries DataFieldY="percentage" Name ="status" NameField="status" ExplodeField="IsExploded">
                                                                                      <LabelsAppearance DataFormatString="{0}%">
                                                                                      </LabelsAppearance>
                                                                                      <TooltipsAppearance>
                                                                                        <ClientTemplate>
                                                                                          #=dataItem.status#<br />
                                                                                           #=dataItem.percentage# %
                                                                                        </ClientTemplate> 
                                                                                      </TooltipsAppearance> 
                                                                                 </telerik:PieSeries>
                                                                            </Series>
                                                                            <YAxis>
                                                                            </YAxis>
                                                                       </PlotArea>
                                                                       <ChartTitle Text="Lead Status" >
                                                                      
                                                                       </ChartTitle>
                                                                  </telerik:RadHtmlChart>
                                                                </div>
                                                         </td>
                                                        
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td>
                                                                <div style ="float:left; width: 566px;" >
                                                                
                                                               
                                                               <asp:GridView ID="gvLeadCategorySummary" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                                                        AllowPaging="false" PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                        OnPageIndexChanging="onLeadSummaryPaging" ToolTip="  A Summary of your customers and leads according to the category in which each one is classified.">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Category" DataField="Category" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="HotLeads" DataField="HotLeads" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Customers" DataField="Customers" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Vendors" DataField="Vendors" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Others" DataField="Others" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                        </Columns>
                                                    </asp:GridView>
                                                    <%--Comment By Prakash.M --%>
                                                   <%-- <asp:GridView ID="gvCategorySummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                            <asp:BoundField HeaderText="HotLeads" DataField="HotLeads" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Customers" DataField="Customers" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Vendors" DataField="Vendors" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField HeaderText="Others" DataField="Others" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                        </Columns>
                                                    </asp:GridView>--%>
                                                                </div>
                                                                <asp:ImageButton ID="btnimgLeadCategoryExport" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgLeadCategoryExport_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                                </td>
                                                            <td>
                                                                <div style ="float:left" >                                                               
                                                                </div>
                                                            
                                                                <div style ="float:left">
                                                               
                                                               <telerik:RadHtmlChart runat="server" ID="chartleadcategorysummary" Height="300px" Width="450px" Legend-Appearance-Visible="true" Legend-Appearance-Position="Right">
                                                        <PlotArea>
                                                            <Series>
                                                                <telerik:PieSeries DataFieldY="Total" Name="PROSPECTS" NameField="PROSPECTS" ExplodeField="IsExploded">
                                                                    <LabelsAppearance DataFormatString="{0}">
                                                                    </LabelsAppearance>
                                                                    <TooltipsAppearance>
                                                                        <ClientTemplate>
                                                                                          #=dataItem.PROSPECTS#<br />
                                                                                           #=dataItem.Total# 
                                                                        </ClientTemplate>
                                                                    </TooltipsAppearance>
                                                                </telerik:PieSeries>
                                                            </Series>
                                                            <YAxis>
                                                            </YAxis>
                                                        </PlotArea>
                                                        <ChartTitle Text="Lead Category">
                                                        </ChartTitle>
                                                    </telerik:RadHtmlChart>

                                                                </div>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td>
                                                                <div style ="float:left; width: 556px;">
                                                               
                                                                <asp:GridView ID="gvCampaignSummary" runat="server" AutoGenerateColumns="false" AllowPaging="false" 
                                                                    PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="onCampaignSummaryPaging"
                                                                    ToolTip="Sofar:Includes all Leads\ Qualified[5QLD] Leads only." ShowFooter="true">
                                                                    <FooterStyle HorizontalAlign="Center" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR2 Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Sofar" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Qualified" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvCampaignSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" Width="544px">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Lead Count" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="Lead Count" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#FF9900" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Qualified" DataField="QLD" ReadOnly="true" HeaderStyle-BackColor="#FF9900"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                                            SortExpression="Email" ItemStyle-Font-Names="Verdana" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                                </div>
                                                                <asp:ImageButton ID="btnimgCamSumExporttoExcel" runat="server" ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCamSumExporttoExcel_Click" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." />
                                                            </td>
                                                            <td>
                                                                <div style ="float:left" >
                                                                
                                                                </div>
                                                           
                                                                <div style ="float:left">
                                                               
                                                                <telerik:RadHtmlChart runat="server" ID="chartcampaignsummary" Height="300px" Width="450px" Legend-Appearance-Visible = "true" Legend-Appearance-Position ="Right" >
                                                                       <PlotArea>
                                                                            <Series>
                                                                                 <telerik:PieSeries DataFieldY="percentage" Name ="campaign" NameField="campaign" ExplodeField="IsExploded">
                                                                                      <LabelsAppearance DataFormatString="{0}%">
                                                                                      </LabelsAppearance>
                                                                                      <TooltipsAppearance>
                                                                                        <ClientTemplate>
                                                                                          #=dataItem.campaign#<br />
                                                                                           #=dataItem.percentage# %
                                                                                        </ClientTemplate> 
                                                                                      </TooltipsAppearance> 
                                                                                 </telerik:PieSeries>
                                                                            </Series>
                                                                            <YAxis>
                                                                            </YAxis>
                                                                       </PlotArea>
                                                                       <ChartTitle Text="Campaign" >
                                                                      
                                                                       </ChartTitle>
                                                                  </telerik:RadHtmlChart>
                                                                </div> 
                                                            </td>
                                                        </tr>
                                                       
                                                    </table>
                                                </div>
                        <div id="divMR5" runat="server" style="border-style:solid;border-width:thin;border-color:blue;height:auto;width:100%; min-height:550px">
                                                    <table>
                                                        <tr>
                                                            <td>

                                                                 <div style="text-align: center">
                                                                    <asp:Label ID="Label2" runat="server" Text="Chart Customers" 
                                                                        Font-Bold="true" ForeColor="DarkGreen" CssClass="style2" Font-Names="Verdana"></asp:Label>
                                                                   <br />
                                                                     <br />
                                                                     <br />
                                                                    
                                                                </div>
                                                              <div style ="float:left"> 
                                                               
                                                                <%--<asp:Label ID="lblsmr2reportstime" runat="server" Text="" Width ="150px" CssClass ="style2" ForeColor ="DarkGray" Font-Bold ="true"  Font-Names ="Verdana"></asp:Label><br />--%>
                                                                <asp:GridView ID="gvCLeadSourceSummary" runat="server" AutoGenerateColumns="false"
                                                                    AllowPaging="false"  PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                                    OnPageIndexChanging="onLeadSummaryPaging" ToolTip="Leadcount:All Leads included\Qualified only[5QLD]">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR5 Lead Source" DataField="LeadSource" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Customers" DataField="Customer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvCLeadSourceSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Customers" DataField="Customer" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="Lead Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                </div>
                                                                <div style ="float:left">
                                                               
                                                                     <asp:ImageButton ID="btnimgCLedSrcExporttoExcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCLedSrcExporttoExcel_Click" />
                                                                </div>
                                                                <div style ="float:left">
                                                               
                                                                <telerik:RadHtmlChart runat="server" ID="chartcustomerleadsummary" Height="300px" Width="450px" Legend-Appearance-Visible = "true" Legend-Appearance-Position ="Right" >
                                                                       <PlotArea>
                                                                            <Series>
                                                                                 <telerik:PieSeries DataFieldY="percentage" Name ="leadsource" NameField="leadsource" ExplodeField="IsExploded">
                                                                                      <LabelsAppearance DataFormatString="{0}%">
                                                                                      </LabelsAppearance>
                                                                                      <TooltipsAppearance>
                                                                                        <ClientTemplate>
                                                                                          #=dataItem.leadsource#<br />
                                                                                           #=dataItem.percentage# % 
                                                                                        </ClientTemplate> 
                                                                                      </TooltipsAppearance> 
                                                                                 </telerik:PieSeries>
                                                                                
                                                                            </Series>
                                                                            <YAxis Name ="leadsource" >
                                                                            </YAxis>
                                                                       </PlotArea>
                                                                       <ChartTitle Text="LeadSource Summary" >
                                                                      
                                                                       </ChartTitle>
                                                                  </telerik:RadHtmlChart>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div style ="float:left" >
                                                               
                                                                <asp:GridView ID="gvCCampaignSummary" runat="server" AutoGenerateColumns="false" AllowPaging="false"
                                                                    PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" OnPageIndexChanging="onCampaignSummaryPaging"
                                                                    ToolTip="Sofar:Includes all Leads\ Qualified[5QLD] Leads only.">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR5 Campaign" DataField="Campaign" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Customers" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvCCampaignSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Lead Count" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="Lead Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                </div>
                                                                <div style ="float:left">
                                                                
                                                                     <asp:ImageButton ID="btnimgCCamSumExporttoExcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCCamSumExporttoExcel_Click"  />
                                                                </div>
                                                                 <div style ="float:left">
                                                                
                                                                <telerik:RadHtmlChart runat="server" ID="chartcustomercampaignsummary" Height="300px" Width="450px" Legend-Appearance-Visible = "true" Legend-Appearance-Position ="Right" >
                                                                       <PlotArea>
                                                                            <Series>
                                                                                 <telerik:PieSeries DataFieldY="percentage" Name ="campaign" NameField="campaign" ExplodeField="IsExploded">
                                                                                      <LabelsAppearance DataFormatString="{0}%">
                                                                                      </LabelsAppearance>
                                                                                      <TooltipsAppearance>
                                                                                        <ClientTemplate>
                                                                                          #=dataItem.campaign#<br />
                                                                                           #=dataItem.percentage# %
                                                                                        </ClientTemplate> 
                                                                                      </TooltipsAppearance> 
                                                                                 </telerik:PieSeries>
                                                                            </Series>
                                                                            <YAxis>
                                                                            </YAxis>
                                                                       </PlotArea>
                                                                       <ChartTitle Text="Campaign Summary" >
                                                                      
                                                                       </ChartTitle>
                                                                  </telerik:RadHtmlChart>
                                                                </div>   
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            <div style="float:left" >
                                                            
                                                               
                                                                <asp:GridView ID="gvCReferenceSummary" runat="server" AutoGenerateColumns="false"
                                                                    AllowPaging="false" PageSize="10" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue"
                                                                    OnPageIndexChanging="onReferenceSummaryPaging" ToolTip="Sofar:Includes all Leads\ Qualified[5QLD] Leads only.">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="SMR5 Reference" DataField="ProjectCode" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Customers" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="%" DataField="Percentage" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                        
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvCReferenceSummaryTotal" ShowHeader="false" runat="server" AutoGenerateColumns="false"
                                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue">
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Lead Source" DataField="Total" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left"
                                                                            SortExpression="Name" ItemStyle-Font-Names="Verdana" />
                                                                        <asp:BoundField HeaderText="Lead Count" DataField="Sofar" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="Lead Count" ReadOnly="true" HeaderStyle-BackColor="#5B74A8"
                                                                            HeaderStyle-ForeColor="White" SortExpression="Status" ItemStyle-Font-Names="Verdana"
                                                                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField HeaderText="InLast7days" DataField="InLast7Days" ReadOnly="true"
                                                                            HeaderStyle-BackColor="#5B74A8" HeaderStyle-ForeColor="White" ItemStyle-Width="100px"
                                                                            ItemStyle-HorizontalAlign="Center" SortExpression="Mobile" ItemStyle-Font-Names="Verdana" />
                                                                      
                                                                    </Columns>
                                                                </asp:GridView>
                                                                </div>
                                                                <div style ="float:left">
                                                                
                                                                     <asp:ImageButton ID="btnimgCRefSumExporttoExcel" runat="server" ToolTip="Press here to copy the values shown, into a spreadsheet for further analysis." ImageUrl="~/Images/exceliconsmall2.png" OnClick="btnimgCRefSumExporttoExcel_Click"   />
                                                                </div>
                                                                <div style ="float:left">
                                                                
                                                                <telerik:RadHtmlChart runat="server" ID="chartcustomerreferencesummary" Height="300px" Width="450px" Legend-Appearance-Visible = "true" Legend-Appearance-Position ="Right" >
                                                                       <PlotArea>
                                                                            <Series>
                                                                                 <telerik:PieSeries DataFieldY="percentage" Name ="Reference" NameField="Reference" ExplodeField="IsExploded">
                                                                                      <LabelsAppearance DataFormatString="{0}%">
                                                                                      </LabelsAppearance>
                                                                                      <TooltipsAppearance>
                                                                                        <ClientTemplate>
                                                                                          #=dataItem.Reference#<br />
                                                                                           #=dataItem.percentage# %
                                                                                        </ClientTemplate> 
                                                                                      </TooltipsAppearance> 
                                                                                 </telerik:PieSeries>
                                                                            </Series>
                                                                            <YAxis>
                                                                            </YAxis>
                                                                       </PlotArea>
                                                                       <ChartTitle Text="Reference Summary" >
                                                                      
                                                                       </ChartTitle>
                                                                  </telerik:RadHtmlChart>
                                                                </div>  
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                    </td>
                </tr> 

            </ContentTemplate>
            <Triggers>
                       <asp:PostBackTrigger ControlID ="btnimgLedSrcExporttoExcel" />
                     <asp:PostBackTrigger ControlID ="btnimgLedStatusExporttoExcel" />
                    <asp:PostBackTrigger ControlID ="btnimgLeadCategoryExport" />
                    <asp:PostBackTrigger ControlID ="btnimgCamSumExporttoExcel" />
                   <%-- <asp:PostBackTrigger ControlID ="btnimgRefSumExporttoExcel" />--%>
                    <asp:PostBackTrigger ControlID ="btnimgCLedSrcExporttoExcel" />
                    <asp:PostBackTrigger ControlID ="btnimgCCamSumExporttoExcel" />
                     <asp:PostBackTrigger ControlID ="btnimgCRefSumExporttoExcel" />
            </Triggers>
        </asp:UpdatePanel>

        <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="uptab" runat="server">
            <ProgressTemplate>

                <div class="modal">
                    <div class="center">
                        <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                        <br />
                        <asp:ImageButton ID="btnUpdateLoad" runat="server" ImageUrl="~/images/Loader.gif" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>


    </div>
</asp:Content>


