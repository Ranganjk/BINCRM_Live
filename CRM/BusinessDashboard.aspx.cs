using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Globalization;
using PMS;
using System.Drawing;
using System.Security.Cryptography;
using System.IO;
using System.Data.Common;
using System.Text;
using System.Net;
using Telerik.Charting;
using System.Web.Services;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.Collections;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing.Drawing2D;


public partial class BusinessDashboard : System.Web.UI.Page
{

    SQLProcs sqlobj = new SQLProcs();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["UserID"] == null)
            {
                Session.Abandon();

                Response.Redirect("Login.aspx");
            }
            RadWindow2.VisibleOnPageLoad = true;
            RadWindow2.Visible = false;

            if (!Page.IsPostBack)
            {

                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Info Graphics", DateTime.Now);

                LoadStaffManager();
                LoadDefault();
                LoadServiceDefault();
                LoadGeneralDefault();

                // chart loading

                dvSalesPipeline.Visible = false;
                dvOrderBook.Visible = false;
                dvCategorywiseSummary.Visible = false;
                dvBusinessSummary.Visible = false;
                dvInProgressGeneral.Visible = false;
                dvCompletedGeneral.Visible = false;
                dvMaintenanceGeneral.Visible = false;
                dvDelaysGeneral.Visible = false;
                dvInProgressService.Visible = false;
                dvCompletedService.Visible = false;
                dvMaintenanceService.Visible = false;
                dvDelayService.Visible = false;
                dvLeadSource.Visible = false;
                dvLeadStatus.Visible = false;
                dvLeadCategory.Visible = false;
                dvLeadCampaign.Visible = false;
                dvCustomerSource.Visible = false;
                dvCustomerCampaign.Visible = false;
                dvWorkProgresssummary.Visible = false;
                dvWorkProgressdetailed.Visible = false;
                dvActiveEnquiries.Visible = false;
                dvActiveQuotations.Visible = false;
                dvLeadsTrack.Visible = false;

                dvfilter.Visible = false;

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadDefault()
    {
        try
        {

            DateTime now = DateTime.Now;
            DateTime startDate = new DateTime(now.Year, now.Month, 1);
            DateTime endDate = DateTime.Now;

            dtpbdfrom.SelectedDate = startDate;
            dtpbdto.SelectedDate = endDate;

            LoadStaffManager();

            //lblpipelinetitle.Text = "Sales Pipeline as of " + now.ToString(@"dd/MM/yyyy hh:mm:ss tt", new CultureInfo("en-US"));  
            lblpipelinetitle.Text = "Sales Pipeline as of " + now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));

            DataSet dsbizdb = sqlobj.SQLExecuteDataset("SP_NewBusinessDashboard",
                 new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = startDate.ToShortDateString() },
                 new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = endDate.ToShortDateString() },
                 new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = null }
                 );

            if (dsbizdb.Tables[0].Rows.Count > 0)
            {
                //lblhlcount.Text = "150";
                lblhlcount.Text = dsbizdb.Tables[0].Rows[0]["LeadsEnquiry"].ToString();
                lblhlvalue.Text = dsbizdb.Tables[0].Rows[0]["value"].ToString();
            }

            if (dsbizdb.Tables[1].Rows.Count > 0)
            {
                //lblwcount.Text = "130";
                lblwcount.Text = dsbizdb.Tables[1].Rows[0]["CustomersEnquiry"].ToString();
                lblwvalue.Text = dsbizdb.Tables[1].Rows[0]["value"].ToString();
            }

            lblplte.Text = (Convert.ToDouble(lblhlcount.Text) + Convert.ToDouble(lblwcount.Text)).ToString("0");
            lblpltq.Text = (Convert.ToDouble(lblhlvalue.Text) + Convert.ToDouble(lblwvalue.Text)).ToString("0.00");

            if (dsbizdb.Tables[2].Rows.Count > 0)
            {
                //lblqcount.Text = "74";
                //lblqvalue.Text = "1000";
                lblqcount.Text = dsbizdb.Tables[2].Rows[0]["LeadsQuote"].ToString();
                lblqvalue.Text = dsbizdb.Tables[2].Rows[0]["Value"].ToString();
            }
            if (dsbizdb.Tables[3].Rows.Count > 0)
            {
                //lblecount.Text = "60";
                //lblevalue.Text = "260";
                lblecount.Text = dsbizdb.Tables[3].Rows[0]["CustomersQuote"].ToString();
                lblevalue.Text = dsbizdb.Tables[3].Rows[0]["value"].ToString();
            }

            lblplqc.Text = (Convert.ToDouble(lblqcount.Text) + Convert.ToDouble(lblecount.Text)).ToString("0");
            lblplqv.Text = (Convert.ToDouble(lblqvalue.Text) + Convert.ToDouble(lblevalue.Text)).ToString("0.00");

            if (dsbizdb.Tables[4].Rows.Count > 0)
            {
                lblnocount.Text = dsbizdb.Tables[4].Rows[0]["newordersCount"].ToString();
                lblnovalue.Text = dsbizdb.Tables[4].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[5].Rows.Count > 0)
            {
                lbleccount.Text = dsbizdb.Tables[5].Rows[0]["existingcustomerCount"].ToString();
                lblecvalue.Text = dsbizdb.Tables[5].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[6].Rows.Count > 0)
            {

                lblnccount.Text = dsbizdb.Tables[6].Rows[0]["newcustomerCount"].ToString();
                lblncvalue.Text = dsbizdb.Tables[6].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[7].Rows.Count > 0)
            {

                gvOrderBook.DataSource = dsbizdb.Tables[7];
                gvOrderBook.DataBind();
            }
            if (dsbizdb.Tables[8].Rows.Count > 0)
            {

                gvCategorySummary.DataSource = dsbizdb.Tables[8];
                gvCategorySummary.DataBind();
            }

            if (dsbizdb.Tables[8].Rows.Count > 0)
            {

                gvCategorySummary.DataSource = dsbizdb.Tables[8];
                gvCategorySummary.DataBind();
            }

            if (dsbizdb.Tables[9].Rows.Count > 0)
            {
                //gvCategorySummary.DataSource = dsbizdb.Tables[8];
                //gvCategorySummary.DataBind();
                lblTotalEnquiries.Text = " How many enquiries are there in the given date range?: " + dsbizdb.Tables[9].Rows[0]["TotalEnquiries"].ToString();
            }
            lblcs.Text = "Enquiries and quotations as of " + now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US")) + " and Orders in the given date range";
            dsbizdb.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadServiceDefault()
    {
        try
        {
            DateTime now = DateTime.Now;
            DateTime startDate = new DateTime(now.Year, now.Month, 1);
            DateTime endDate = DateTime.Now;

            dtpbdfrom.SelectedDate = startDate;
            dtpbdto.SelectedDate = endDate;

            LoadStaffManager();

            lblcinprogress.Text = "InProgress as of  " + now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));
            lblamcasc.Text = "As of given date range  ";

            DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_NewServiceDashboard",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
              new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
              );
            if (dsserdb.Tables[0].Rows.Count > 0)
            {
                ////Sample Datatable
                //DataTable dt = new DataTable();
                //dt.Columns.Add("reference");
                //dt.Columns.Add("count");
                //dt.Columns.Add("value", typeof(int));
                //dt.Rows.Add("#asc", "17", 1245.00);
                //dt.Rows.Add("#complaint", "37", 2245.00);
                //dt.Rows.Add("#service", "21", 3145.00);
                //dt.Rows.Add("#amc", "7", 1045.00);
                //dt.Rows.Add("#excise", "42", 450.00);
                //dt.AcceptChanges();

               // gvInProgress.DataSource = dt;

                gvInProgress.DataSource = dsserdb.Tables[0];
                gvInProgress.DataBind();
            }

            if (dsserdb.Tables[1].Rows.Count > 0)
            {
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Reference");
                //dt.Columns.Add("Count");
                //dt.Columns.Add("Value", typeof(int));
                //dt.Rows.Add("#ASC", "37", 1245.00);
                //dt.Rows.Add("#Complaint", "52", 2245.00);
                //dt.Rows.Add("#Service", "31", 345.00);
                //dt.Rows.Add("#AMC", "37", 1045.00);
                //dt.Rows.Add("#Excise", "42", 3450.00);
                //dt.AcceptChanges();
                //gvCompleted.DataSource = dt;

                gvCompleted.DataSource = dsserdb.Tables[1];
                gvCompleted.DataBind();
            }
            if (dsserdb.Tables[2].Rows.Count > 0)
            {
                gvDelays.DataSource = dsserdb.Tables[2];
                gvDelays.DataBind();
            }
            if (dsserdb.Tables[3].Rows.Count > 0)
            {
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Reference");
                //dt.Columns.Add("Count");
                //dt.Columns.Add("Value", typeof(int));
                //dt.Rows.Add("#AMCRnwd", "97", 1245.00);
                //dt.Rows.Add("#AMCSigned", "52", 2245.00);
                //dt.Rows.Add("#ASCRnwd", "31", 345.00);
                //dt.Rows.Add("#ASCSigned", "87", 1045.00);
                //dt.Rows.Add("#Cancelled", "62", 3450.00);
                //dt.AcceptChanges();

                //gvamcasc.DataSource = dt;
                gvamcasc.DataSource = dsserdb.Tables[3];
                gvamcasc.DataBind();
            }

            dsserdb.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadGeneralDefault()
    {
        try
        {
            DateTime now = DateTime.Now;
            DateTime startDate = new DateTime(now.Year, now.Month, 1);
            DateTime endDate = DateTime.Now;

            dtpbdfrom.SelectedDate = startDate;
            dtpbdto.SelectedDate = endDate;

            LoadStaffManager();

            lblcinprogress.Text = "InProgress as of  " + now.ToString(@"dd/MM/yyyy hh:mm:ss tt", new CultureInfo("en-US"));
            lblamcasc.Text = "As of given date range  ";

            DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_NewGeneralDashboard",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
              new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
              );
            if (dsserdb.Tables[0].Rows.Count > 0)
            {
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Reference");
                //dt.Columns.Add("Count");
                //dt.Columns.Add("Value", typeof(int));
                //dt.Rows.Add("#Feedback", "97", 1245.00);
                //dt.Rows.Add("#Followup", "52", 2245.00);
                //dt.Rows.Add("#Internal", "31", 345.00);
                //dt.Rows.Add("#MobileApp", "87", 1045.00);
                //dt.Rows.Add("#Others", "62", 3450.00);
                //dt.AcceptChanges();

                //gvGInProgress.DataSource = dt;

                gvGInProgress.DataSource = dsserdb.Tables[0];
                gvGInProgress.DataBind();
            }

            if (dsserdb.Tables[1].Rows.Count > 0)
            {
                gvGCompleted.DataSource = dsserdb.Tables[1];
                gvGCompleted.DataBind();
            }
            if (dsserdb.Tables[2].Rows.Count > 0)
            {
                gvGDelays.DataSource = dsserdb.Tables[2];
                gvGDelays.DataBind();
            }
            if (dsserdb.Tables[3].Rows.Count > 0)
            {
                gvGMaintenance.DataSource = dsserdb.Tables[3];
                gvGMaintenance.DataBind();
            }

            dsserdb.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void BindEnquiriesChart()
    {
        DataSet dsbcenquiries = sqlobj.SQLExecuteDataset("SP_BarchartEnquiries",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
            );


        List<string> colorList = new List<string>();
        colorList.Add("Orange");
        colorList.Add("Green");
        colorList.Add("Red");
        colorList.Add("Yellow");
        colorList.Add("Purple");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");



        DataTable dtbc = dsbcenquiries.Tables[0];

        Legend celegneds = new Legend("Enquiries");
        Series cqseries = new Series("Enquiries");


        //storing total rows count to loop on each Record
        string[] XPointMember = new string[dtbc.Rows.Count];
        int[] YPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtbc.Rows.Count; count++)
        {

            cqseries.Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
            cqseries.Points[count].Color = Color.FromName(colorList[count]);

            //storing Values for X axis
            //XPointMember[count] = dtbc.Rows[count]["Type"].ToString();
            //storing values for Y Axis
            //YPointMember[count] = Convert.ToInt32(dtbc.Rows[count]["Count"]);

        }

        //binding chart control
        // cQuotations.Series[0].Points.DataBindXY(XPointMember, YPointMember);

        //Setting width of line
        //cQuotations.Series[0].BorderWidth = 10;
        //setting Chart type 
        //cQuotations.Series[0].ChartType = SeriesChartType.Column;



        cqseries.ChartType = SeriesChartType.Pie;


        cEnquiries.Legends.Add(celegneds);
        cEnquiries.Series.Add(cqseries);

        cEnquiries.Series["Enquiries"].IsVisibleInLegend = true;
        cEnquiries.Series["Enquiries"].IsValueShownAsLabel = true;
        cEnquiries.Series["Enquiries"].ToolTip = "#VALX  - #VALY";



        cEnquiries.Legends["Enquiries"].LegendStyle = LegendStyle.Table;
        cEnquiries.Legends["Enquiries"].TableStyle = LegendTableStyle.Wide;
        cEnquiries.Legends["Enquiries"].Docking = Docking.Bottom;

        cEnquiries.BackColor = Color.AliceBlue;
        cEnquiries.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

        cEnquiries.Titles.Add("Enquiries");

        dsbcenquiries.Dispose();


    }

    private void BindQuotationsChart()
    {
        DataSet dsbcenquiries = sqlobj.SQLExecuteDataset("SP_BarChartQuotations",
          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
          );


        // color list

        List<string> colorList = new List<string>();
        colorList.Add("Orange");
        colorList.Add("Green");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("Purple");
        colorList.Add("Red");
        colorList.Add("Yellow");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");



        // Count

        DataTable dtbc = dsbcenquiries.Tables[0];

        Legend celegneds = new Legend("Quotation");
        Series cqseries = new Series("Quotation");

        //storing total rows count to loop on each Record
        string[] XPointMember = new string[dtbc.Rows.Count];
        int[] YPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtbc.Rows.Count; count++)
        {

            cqseries.Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
            cqseries.Points[count].Color = Color.FromName(colorList[count]);

        }



        cqseries.ChartType = SeriesChartType.Pie;



        cQuotations.Legends.Add(celegneds);
        cQuotations.Series.Add(cqseries);



        cQuotations.Series["Quotation"].IsValueShownAsLabel = true;
        cQuotations.Series["Quotation"].ToolTip = "#VALX  - #VALY";

        //cQuotations.Legends["Quotaion"].CellColumns.Add(new LegendCellColumn("Name", LegendCellColumnType.Text, "#LEGENDTEXT"));

        //cQuotations.Legends["Quotation"].DockedToChartArea = "Default";
        //cQuotations.Series["Quotation"].IsVisibleInLegend = true;



        // cQuotations.Legends["Quotation"].LegendStyle = LegendStyle.Table;
        // cQuotations.Legends["Quotation"].TableStyle = LegendTableStyle.Wide;
        //cQuotations.Legends["Quotation"].Docking = Docking.Bottom;

        cQuotations.Legends["Quotation"].LegendStyle = LegendStyle.Table;
        cQuotations.Legends["Quotation"].TableStyle = LegendTableStyle.Wide;
        cQuotations.Legends["Quotation"].Docking = Docking.Bottom;


        cQuotations.BackColor = Color.AliceBlue;
        cQuotations.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


        cQuotations.Titles.Add("Quotations - Count");



        // Value


        DataTable dtqv = dsbcenquiries.Tables[0];

        Legend cqvlegneds = new Legend("QuotationValue");
        Series cqvseries = new Series("QuotationValue");

        //storing total rows count to loop on each Record
        string[] XqvPointMember = new string[dtbc.Rows.Count];
        int[] YqvPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtqv.Rows.Count; count++)
        {

            cqvseries.Points.AddXY(dtqv.Rows[count]["Type"].ToString(), Convert.ToInt32(dtqv.Rows[count]["value"]));
            cqvseries.Points[count].Color = Color.FromName(colorList[count]);

        }



        cqvseries.ChartType = SeriesChartType.Pie;

        cQuotationsValue.Legends.Add(cqvlegneds);
        cQuotationsValue.Series.Add(cqvseries);


        cQuotationsValue.Series["QuotationValue"].IsVisibleInLegend = true;
        cQuotationsValue.Series["QuotationValue"].IsValueShownAsLabel = true;
        cQuotationsValue.Series["QuotationValue"].ToolTip = "#VALX  - #VALY";




        cQuotationsValue.Legends["QuotationValue"].LegendStyle = LegendStyle.Table;
        cQuotationsValue.Legends["QuotationValue"].TableStyle = LegendTableStyle.Wide;
        cQuotationsValue.Legends["QuotationValue"].Docking = Docking.Bottom;

        cQuotationsValue.BackColor = Color.AliceBlue;
        cQuotationsValue.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

        cQuotationsValue.Titles.Add("Quotations - Value");


        dsbcenquiries.Dispose();

    }
    private void BindOrderBookChart()
    {

        DataSet dsOrderBook = sqlobj.SQLExecuteDataset("SP_BarChartOrderBook",
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
                );


        // color list

        List<string> colorList = new List<string>();
        colorList.Add("Green");
        colorList.Add("Orange");
        colorList.Add("Red");
        colorList.Add("Yellow");
        colorList.Add("Purple");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");

        if(dsOrderBook != null)
        {
            DataTable dtbc = dsOrderBook.Tables[0];


            Legend celegneds = new Legend("OrderBook");
            Series cobseries = new Series("OrderBook");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {

                cobseries.Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
                cobseries.Points[count].Color = Color.FromName(colorList[count]);
                //storing Values for X axis
                //XPointMember[count] = dtbc.Rows[count]["Type"].ToString();
                //storing values for Y Axis
                //YPointMember[count] = Convert.ToInt32(dtbc.Rows[count]["Count"]);

            }

            //binding chart control
            //cOrderBook.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Setting width of line
            //cOrderBook.Series[0].BorderWidth = 10;
            //setting Chart type 
            //cOrderBook.Series[0].ChartType = SeriesChartType.Column;

            cobseries.ChartType = SeriesChartType.Pie;

            cOrderBook.Legends.Add(celegneds);
            cOrderBook.Series.Add(cobseries);

            //cOrderBook.Series["OrderBook"].IsVisibleInLegend = true;
            //cOrderBook.Series["OrderBook"].IsValueShownAsLabel = true;
            cOrderBook.Series["OrderBook"].ToolTip = "#VALX  - #VALY";

            cOrderBook.Legends["OrderBook"].LegendStyle = LegendStyle.Table;
            cOrderBook.Legends["OrderBook"].TableStyle = LegendTableStyle.Wide;
            cOrderBook.Legends["OrderBook"].Docking = Docking.Bottom;


            cOrderBook.BackColor = Color.AliceBlue;
            cOrderBook.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

            cOrderBook.Titles.Add("OrderBook");
        }
        


    }
    private void BindBusinessSummaryChart()
    {
        DataSet dsOrderBook = sqlobj.SQLExecuteDataset("SP_BarChartBusinessSummary",
               new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
               new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
               );



        // color list

        List<string> colorList = new List<string>();
        colorList.Add("Red");
        colorList.Add("Green");
        colorList.Add("Yellow");
        colorList.Add("Purple");
        colorList.Add("Orange");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");



        DataTable dtbc = dsOrderBook.Tables[0];

        Legend celegneds = new Legend("BusinessSummary");
        //Series cbsseries = new Series("BusinessSummary");

        //storing total rows count to loop on each Record
        string[] XPointMember = new string[dtbc.Rows.Count];
        int[] YPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtbc.Rows.Count; count++)
        {


            cBusinessSummary.Series["BusinessSummary"].Points.AddXY(dtbc.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
            cBusinessSummary.Series["BusinessSummary"].Points[count].Color = Color.FromName(colorList[count]);
            //storing Values for X axis
            //XPointMember[count] = dtbc.Rows[count]["Reference"].ToString();
            //storing values for Y Axis
            //YPointMember[count] = Convert.ToInt32(dtbc.Rows[count]["Count"]);

        }

        //binding chart control
        //cBusinessSummary.Series[0].Points.DataBindXY(XPointMember, YPointMember);

        //Setting width of line
        //cBusinessSummary.Series[0].BorderWidth = 10;
        //setting Chart type 
        //cBusinessSummary.Series[0].ChartType = SeriesChartType.Column;

        cBusinessSummary.Series["BusinessSummary"].ChartType = SeriesChartType.Column;



        cBusinessSummary.Legends.Add(celegneds);
        //cBusinessSummary.Series.Add(cbsseries);




        cBusinessSummary.Series["BusinessSummary"].IsVisibleInLegend = true;
        cBusinessSummary.Series["BusinessSummary"].IsValueShownAsLabel = true;
        cBusinessSummary.Series["BusinessSummary"].ToolTip = "#VALX  - #VALY";

        cBusinessSummary.Legends["BusinessSummary"].LegendStyle = LegendStyle.Table;
        cBusinessSummary.Legends["BusinessSummary"].TableStyle = LegendTableStyle.Wide;
        cBusinessSummary.Legends["BusinessSummary"].Docking = Docking.Bottom;

        cBusinessSummary.Series[0].YValuesPerPoint = 1;

        cBusinessSummary.BackColor = Color.AliceBlue;
        cBusinessSummary.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

        cBusinessSummary.Titles.Add("Business Summary");
    }

    private void BindCategorywiseChart()
    {
        try
        {
            DataSet dsbccategrowise = sqlobj.SQLExecuteDataset("SP_BarchartCategorywise",
               new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
               new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
               );

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            //Sample Data
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Category");
            //dt.Columns.Add("Warm");
            //dt.Columns.Add("Hot");
            //dt.Columns.Add("Orders");
            //dt.Columns.Add("WarmValue", typeof(int));
            //dt.Columns.Add("HotValue", typeof(int));
            //dt.Columns.Add("OrdersValue", typeof(int));
            //dt.Rows.Add("Consultant", "35", "43", "23", 500.00, 1000.000, 1234.00);
            //dt.Rows.Add("Govt.Org", "44", "23", "65", 366.00, 10000.00, 4500.00);
            //dt.Rows.Add("New Sector", "12", "67", "43", 100.00, 400.00, 300.00);
            //dt.Rows.Add("OEM", "15", "45", "34", 166.00, 2560.00, 2100.00);
            //dt.Rows.Add("PublicSector", "5", "12", "23", 136.00, 2560.00, 2100.00);
            //dt.Rows.Add("Pvt.Sector", "45", "32", "56", 166.00, 1560.00, 100.00);
            //dt.Rows.Add("Software Co.", "55", "21", "76", 136.00, 560.00, 2100.00);
            //dt.AcceptChanges();
            // Count

            DataTable dtbc = dsbccategrowise.Tables[0];
            //DataTable dtbc = dt;


            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("Enquiry");
            Legend cqlegends = new Legend("Quotation");
            Legend colegends = new Legend("Order");
            Series ceseries = new Series("Enquiry");
            Series cqseries = new Series("Quotation");
            Series coseries = new Series("Order");



            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {


                ceseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Warm"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Hot"]));
                coseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Orders"]));



                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;


            }




            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;
            cqseries.ChartType = SeriesChartType.Column;





            cCategorywisesummary.Series.Add(ceseries);
            cCategorywisesummary.Series.Add(cqseries);
            cCategorywisesummary.Series.Add(coseries);


            cCategorywisesummary.Legends.Add(celegends);
            cCategorywisesummary.Legends.Add(cqlegends);
            cCategorywisesummary.Legends.Add(colegends);



            cCategorywisesummary.Series["Enquiry"].YValuesPerPoint = 1;
            cCategorywisesummary.Series["Quotation"].YValuesPerPoint = 1;
            cCategorywisesummary.Series["Order"].YValuesPerPoint = 1;

            cCategorywisesummary.Series["Enquiry"].IsVisibleInLegend = true;
            cCategorywisesummary.Series["Enquiry"].IsValueShownAsLabel = true;
            cCategorywisesummary.Series["Enquiry"].ToolTip = "#VALX  - Enquiry - #VALY";

            cCategorywisesummary.Series["Quotation"].IsVisibleInLegend = true;
            cCategorywisesummary.Series["Quotation"].IsValueShownAsLabel = true;
            cCategorywisesummary.Series["Quotation"].ToolTip = "#VALX  - Quotation - #VALY";

            cCategorywisesummary.Series["Order"].IsVisibleInLegend = true;
            cCategorywisesummary.Series["Order"].IsValueShownAsLabel = true;
            cCategorywisesummary.Series["Order"].ToolTip = "#VALX  - Order - #VALY";




            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;




            cCategorywisesummary.BackColor = Color.AliceBlue;
            cCategorywisesummary.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


            cCategorywisesummary.Titles.Add("Category-wise Summary - Count");



            // Value



            //Legend celegneds = new Legend("Quotation");
            Legend cevlegends = new Legend("Enquiry");
            Legend cqvlegends = new Legend("Quotation");
            Legend covlegends = new Legend("Order");
            Series cevseries = new Series("Enquiry");
            Series cqvseries = new Series("Quotation");
            Series covseries = new Series("Order");

            cevseries.YValuesPerPoint = 1;
            cqvseries.YValuesPerPoint = 1;
            covseries.YValuesPerPoint = 1;



            for (int count = 0; count < dtbc.Rows.Count; count++)
            {


                cevseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["WarmValue"]));
                cqvseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["HotValue"]));
                covseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["OrdersValue"]));

                //covseries.Points[count].Color = Color.Blue;
                //cqvseries.Points[count].Color = Color.Brown;
                //cevseries.Points[count].Color = Color.Teal;


            }



            cqvseries.ChartType = SeriesChartType.Column;
            cevseries.ChartType = SeriesChartType.Column;
            cqvseries.ChartType = SeriesChartType.Column;



            cCategorywisesummaryvalue.Series.Add(cevseries);
            cCategorywisesummaryvalue.Series.Add(cqvseries);
            cCategorywisesummaryvalue.Series.Add(covseries);


            cCategorywisesummaryvalue.Legends.Add(cevlegends);
            cCategorywisesummaryvalue.Legends.Add(cqvlegends);
            cCategorywisesummaryvalue.Legends.Add(covlegends);



            cCategorywisesummaryvalue.Series["Enquiry"].YValuesPerPoint = 1;
            cCategorywisesummaryvalue.Series["Quotation"].YValuesPerPoint = 1;
            cCategorywisesummaryvalue.Series["Order"].YValuesPerPoint = 1;

            cCategorywisesummaryvalue.Series["Enquiry"].IsVisibleInLegend = true;
            cCategorywisesummaryvalue.Series["Enquiry"].IsValueShownAsLabel = true;
            cCategorywisesummaryvalue.Series["Enquiry"].ToolTip = "#VALX  - Enquiry - #VALY";

            cCategorywisesummaryvalue.Series["Quotation"].IsVisibleInLegend = true;
            cCategorywisesummaryvalue.Series["Quotation"].IsValueShownAsLabel = true;
            cCategorywisesummaryvalue.Series["Quotation"].ToolTip = "#VALX  - Quotation - #VALY";

            cCategorywisesummaryvalue.Series["Order"].IsVisibleInLegend = true;
            cCategorywisesummaryvalue.Series["Order"].IsValueShownAsLabel = true;
            cCategorywisesummaryvalue.Series["Order"].ToolTip = "#VALX  - Order - #VALY";


            cevlegends.LegendStyle = LegendStyle.Table;
            cevlegends.TableStyle = LegendTableStyle.Wide;
            cevlegends.Docking = Docking.Bottom;


            cCategorywisesummaryvalue.BackColor = Color.AliceBlue;
            cCategorywisesummaryvalue.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


            cCategorywisesummaryvalue.Titles.Add("Category-wise Summary - Value");


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadStaffManager()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

        ddlbdstaff.Items.Clear();

        if (dsMasters.Tables[4].Rows.Count > 0)
        {
            ddlbdstaff.DataSource = dsMasters.Tables[4];
            ddlbdstaff.DataValueField = "UserName";
            ddlbdstaff.DataTextField = "StaffName";
            ddlbdstaff.DataBind();


            ddlwpstaff.DataSource = dsMasters.Tables[4];
            ddlwpstaff.DataValueField = "UserName";
            ddlwpstaff.DataTextField = "StaffName";
            ddlwpstaff.DataBind();
        }

        ddlbdstaff.Items.Insert(0, "All");

        ddlwpstaff.Items.Insert(0, "Please Select");

        dsMasters.Dispose();
    }

    protected void btnbdshow_Click(object sender, EventArgs e)
    {
        try
        {
            if (dvSalesPipeline.Visible == true || dvBusinessSummary.Visible == true || dvOrderBook.Visible == true || dvCategorywiseSummary.Visible == true)
            {

                if (Convert.ToDateTime(dtpbdfrom.SelectedDate) > Convert.ToDateTime(dtpbdto.SelectedDate))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and To date');", true);
                    return;
                }
                DataSet dsbizdb = sqlobj.SQLExecuteDataset("SP_NewBusinessDashboard",
                  new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
                  new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
                  );

                if (dsbizdb.Tables[0].Rows.Count > 0)
                {
                    lblhlcount.Text = dsbizdb.Tables[0].Rows[0]["LeadsEnquiry"].ToString();
                    lblhlvalue.Text = dsbizdb.Tables[0].Rows[0]["value"].ToString();
                }

                if (dsbizdb.Tables[1].Rows.Count > 0)
                {
                    lblwcount.Text = dsbizdb.Tables[1].Rows[0]["CustomersEnquiry"].ToString();
                    lblwvalue.Text = dsbizdb.Tables[1].Rows[0]["value"].ToString();
                }
                if (dsbizdb.Tables[2].Rows.Count > 0)
                {
                    lblqcount.Text = dsbizdb.Tables[2].Rows[0]["LeadsQuote"].ToString();
                    lblqvalue.Text = dsbizdb.Tables[2].Rows[0]["Value"].ToString();
                }


                lblplte.Text = Convert.ToString(Convert.ToDouble(lblhlcount.Text) + Convert.ToDouble(lblwcount.Text));
                lblpltq.Text = Convert.ToString(Convert.ToDouble(lblhlvalue.Text) + Convert.ToDouble(lblwvalue.Text));

                if (dsbizdb.Tables[3].Rows.Count > 0)
                {
                    lblecount.Text = dsbizdb.Tables[3].Rows[0]["CustomersQuote"].ToString();
                    lblevalue.Text = dsbizdb.Tables[3].Rows[0]["value"].ToString();
                }

                lblplqc.Text = (Convert.ToDouble(lblqcount.Text) + Convert.ToDouble(lblecount.Text)).ToString("0");
                lblplqv.Text = (Convert.ToDouble(lblqvalue.Text) + Convert.ToDouble(lblevalue.Text)).ToString("0.00");

                if (dsbizdb.Tables[4].Rows.Count > 0)
                {
                    //lblnocount.Text = "60";
                    //lblnovalue.Text = "9200";
                    lblnocount.Text = dsbizdb.Tables[4].Rows[0]["newordersCount"].ToString();
                    lblnovalue.Text = dsbizdb.Tables[4].Rows[0]["value"].ToString();
                }
                if (dsbizdb.Tables[5].Rows.Count > 0)
                {
                    //lbleccount.Text = "40";
                    //lblecvalue.Text = "1200.00";
                    lbleccount.Text = dsbizdb.Tables[5].Rows[0]["existingcustomerCount"].ToString();
                    lblecvalue.Text = dsbizdb.Tables[5].Rows[0]["value"].ToString();
                }
                if (dsbizdb.Tables[6].Rows.Count > 0)
                {
                    //lblnccount.Text = "20";
                    //lblncvalue.Text = "8000.00";
                    lblnccount.Text = dsbizdb.Tables[6].Rows[0]["newcustomerCount"].ToString();
                    lblncvalue.Text = dsbizdb.Tables[6].Rows[0]["value"].ToString();
                }
                if (dsbizdb.Tables[7].Rows.Count > 0)
                {
                    //DataTable dt = new DataTable();
                    //dt.Columns.Add("Reference");
                    //dt.Columns.Add("Count");
                    //dt.Columns.Add("Value", typeof(int));
                    //dt.Rows.Add("#Order", "75", 1000.00);
                    //dt.Rows.Add("#NotFeasible", "165", 4356.00);
                    //dt.Rows.Add("#Lost", "275", 1290.00);
                    //dt.Rows.Add("#Defered", "15", 3421.00);
                    //dt.Rows.Add("#Cncld", "5", 5555.00);
                    //dt.AcceptChanges();

                    //gvOrderBook.DataSource = dt;
                    gvOrderBook.DataSource = dsbizdb.Tables[7];
                    gvOrderBook.DataBind();
                }
                if (dsbizdb.Tables[8].Rows.Count > 0)
                {
                    //DataTable dt = new DataTable();
                    //dt.Columns.Add("Category");
                    //dt.Columns.Add("Warm");
                    //dt.Columns.Add("Hot");
                    //dt.Columns.Add("Orders");
                    //dt.Columns.Add("WarmValue", typeof(int));
                    //dt.Columns.Add("HotValue", typeof(int));
                    //dt.Columns.Add("OrdersValue", typeof(int));
                    //dt.Rows.Add("Consultant", "35", "43", "23", 500.00, 1000.000, 1234.00);
                    //dt.Rows.Add("Govt.Org", "44", "23", "65", 366.00, 10000.00, 4500.00);
                    //dt.Rows.Add("New Sector", "12", "67", "43", 100.00, 400.00, 300.00);
                    //dt.Rows.Add("OEM", "15", "45", "34", 166.00, 2560.00, 2100.00);
                    //dt.Rows.Add("PublicSector", "5", "12", "23", 136.00, 2560.00, 2100.00);
                    //dt.Rows.Add("Pvt.Sector", "45", "32", "56", 166.00, 1560.00, 100.00);
                    //dt.Rows.Add("Software Co.", "55", "21", "76", 136.00, 560.00, 2100.00);
                    //dt.AcceptChanges();
                    //gvCategorySummary.DataSource = dt;

                    gvCategorySummary.DataSource = dsbizdb.Tables[8];
                    gvCategorySummary.DataBind();
                }
                if (dsbizdb.Tables[9].Rows.Count > 0)
                {
                    //gvCategorySummary.DataSource = dsbizdb.Tables[8];
                    //gvCategorySummary.DataBind();
                    lblTotalEnquiries.Text = " No of enquiries in the given date range:" + dsbizdb.Tables[9].Rows[0]["TotalEnquiries"].ToString();
                }

                dsbizdb.Dispose();

                BindEnquiriesChart();
                BindQuotationsChart();
                BindOrderBookChart();
                BindBusinessSummaryChart();
                BindCategorywiseChart();
            }
            else if (dvInProgressService.Visible == true || dvCompletedService.Visible == true || dvMaintenanceService.Visible == true || dvDelayService.Visible == true)
            {
                if (Convert.ToDateTime(dtpbdfrom.SelectedDate) > Convert.ToDateTime(dtpbdto.SelectedDate))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and To date');", true);
                    return;
                }
                DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_NewServiceDashboard",
                  new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
                  new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
                  );

                if (dsserdb.Tables[0].Rows.Count > 0)
                {
                    gvInProgress.DataSource = dsserdb.Tables[0];
                    gvInProgress.DataBind();
                }

                if (dsserdb.Tables[1].Rows.Count > 0)
                {
                    gvCompleted.DataSource = dsserdb.Tables[1];
                    gvCompleted.DataBind();
                }
                if (dsserdb.Tables[2].Rows.Count > 0)
                {
                    gvDelays.DataSource = dsserdb.Tables[2];
                    gvDelays.DataBind();
                }
                if (dsserdb.Tables[3].Rows.Count > 0)
                {
                    gvamcasc.DataSource = dsserdb.Tables[3];
                    gvamcasc.DataBind();
                }
                dsserdb.Dispose();

                LoadBarChart();
            }
            else if (dvInProgressGeneral.Visible == true || dvCompletedGeneral.Visible == true || dvMaintenanceGeneral.Visible == true || dvDelaysGeneral.Visible == true)
            {
                DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_NewGeneralDashboard",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
              new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
              );

                if (dsserdb.Tables[0].Rows.Count > 0)
                {
                    gvGInProgress.DataSource = dsserdb.Tables[0];
                    gvGInProgress.DataBind();
                }

                if (dsserdb.Tables[1].Rows.Count > 0)
                {
                    gvGCompleted.DataSource = dsserdb.Tables[1];
                    gvGCompleted.DataBind();
                }
                if (dsserdb.Tables[2].Rows.Count > 0)
                {
                    gvGDelays.DataSource = dsserdb.Tables[2];
                    gvGDelays.DataBind();
                }
                if (dsserdb.Tables[3].Rows.Count > 0)
                {
                    gvGMaintenance.DataSource = dsserdb.Tables[3];
                    gvGMaintenance.DataBind();
                }
                dsserdb.Dispose();

                LoadGeneralBarChart();
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadBarChart()
    {
        try
        {

            DataSet dsbcservice = sqlobj.SQLExecuteDataset("SP_BarchartService",
             new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
             new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
             );

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            //Sample Datatable
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Reference");
            //dt.Columns.Add("Count");
            //dt.Columns.Add("Value", typeof(int));
            //dt.Rows.Add("#ASC", "17", 1245.00);
            //dt.Rows.Add("#Complaint", "37", 2245.00);
            //dt.Rows.Add("#Service", "21", 3145.00);
            //dt.Rows.Add("#AMC", "7", 1045.00);
            //dt.Rows.Add("#Excise", "42", 450.00);
            //dt.AcceptChanges();

            // InProgress
            //DataTable dtinprogress = dt;
            DataTable dtinprogress = dsbcservice.Tables[0];

            Series cseries = new Series("InProgress");
            cseries.ShadowOffset = 2;
            cseries.YValuesPerPoint = 1;

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtinprogress.Rows.Count];
            int[] YPointMember = new int[dtinprogress.Rows.Count];

            for (int count = 0; count < dtinprogress.Rows.Count; count++)
            {

                cseries.Points.AddXY(dtinprogress.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtinprogress.Rows[count]["Count"].ToString()));

                // cseries.Points[count].Color = Color.FromName(colorList[count]);
                //storing Values for X axis
                //XPointMember[count] = dtinprogress.Rows[count]["Reference"].ToString();
                //storing values for Y Axis
                //YPointMember[count] = Convert.ToInt32(dtinprogress.Rows[count]["Count"]);

            }

            //binding chart control
            //cInProgress.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Setting width of line
            //cInProgress.Series[0].BorderWidth = 10;
            //setting Chart type 
            //cInProgress.Series[0].ChartType = SeriesChartType.Column;
            cseries.ChartType = SeriesChartType.Column;

            cInProgress.Series.Add(cseries);
            cInProgress.BackColor = Color.AliceBlue;
            cInProgress.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cInProgress.Titles.Add("InProgress");


            //Sample Datatable
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Reference");
            //dt.Columns.Add("Count");
            //dt.Columns.Add("Value", typeof(int));
            //dt.Rows.Add("#ASC", "37", 1245.00);
            //dt.Rows.Add("#Complaint", "52", 2245.00);
            //dt.Rows.Add("#Service", "31", 345.00);
            //dt.Rows.Add("#AMC", "37", 1045.00);
            //dt.Rows.Add("#Excise", "42", 3450.00);
            //dt.AcceptChanges();

            // Compeleted
            //DataTable dtcompleted = dt;
            DataTable dtcompleted = dsbcservice.Tables[1];

            Series ccseries = new Series("Completed");
            ccseries.ShadowOffset = 2;

            //storing total rows count to loop on each Record
            string[] XCPointMember = new string[dtcompleted.Rows.Count];
            int[] YCPointMember = new int[dtcompleted.Rows.Count];

            for (int count = 0; count < dtcompleted.Rows.Count; count++)
            {

                ccseries.Points.AddXY(dtcompleted.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtcompleted.Rows[count]["Count"]));
                //ccseries.Points[count].Color = Color.FromName(colorList[count]);

                //storing Values for X axis
                //XCPointMember[count] = dtcompleted.Rows[count]["Reference"].ToString();
                //storing values for Y Axis
                // YCPointMember[count] = Convert.ToInt32(dtcompleted.Rows[count]["Count"]);

            }

            //binding chart control
            //cCompleted.Series[0].Points.DataBindXY(XCPointMember, YCPointMember);

            //Setting width of line
            //cCompleted.Series[0].BorderWidth = 10;
            //setting Chart type 
            //cCompleted.Series[0].ChartType = SeriesChartType.Column;
            ccseries.ChartType = SeriesChartType.Column;
            ccseries.YValuesPerPoint = 1;
            cCompleted.Series.Add(ccseries);
            cCompleted.BackColor = Color.AliceBlue;
            cCompleted.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cCompleted.Titles.Add("Completed");


            //Maintenance
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Reference");
            //dt.Columns.Add("Count");
            //dt.Columns.Add("Value", typeof(int));
            //dt.Rows.Add("#AMCRnwd", "97", 1245.00);
            //dt.Rows.Add("#AMCSigned", "52", 2245.00);
            //dt.Rows.Add("#ASCRnwd", "31", 345.00);
            //dt.Rows.Add("#ASCSigned", "87", 1045.00);
            //dt.Rows.Add("#Cancelled", "62", 3450.00);
            //dt.AcceptChanges();
            //DataTable dtmaintenance = dt;

            DataTable dtmaintenance = dsbcservice.Tables[2];

            Series cmseries = new Series("Maintenance");

            //storing total rows count to loop on each Record
            string[] XMPointMember = new string[dtmaintenance.Rows.Count];
            int[] YMPointMember = new int[dtmaintenance.Rows.Count];

            for (int count = 0; count < dtmaintenance.Rows.Count; count++)
            {

                cmseries.Points.AddXY(dtmaintenance.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtmaintenance.Rows[count]["Count"]));
                //cmseries.Points[count].Color = Color.FromName(colorList[count]);
                //storing Values for X axis
                // XMPointMember[count] = dtmaintenance.Rows[count]["Reference"].ToString();
                //storing values for Y Axis
                //YMPointMember[count] = Convert.ToInt32(dtmaintenance.Rows[count]["Count"]);

            }

            //binding chart control
            //cMaintanance.Series[0].Points.DataBindXY(XMPointMember, YMPointMember);

            //Setting width of line
            //cMaintanance.Series[0].BorderWidth = 10;
            //setting Chart type 
            //cMaintanance.Series[0].ChartType = SeriesChartType.Column;
            cmseries.ChartType = SeriesChartType.Column;
            cMaintanance.Series.Add(cmseries);
            cMaintanance.BackColor = Color.AliceBlue;
            cMaintanance.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cMaintanance.Titles.Add("Maintenance");


            dsbcservice.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadGeneralBarChart()
    {
        try
        {

            DataSet dsbcservice = sqlobj.SQLExecuteDataset("SP_BarChartGeneral",
             new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
             new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
             );


            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");


            // InProgress
            if(dsbcservice != null)
            {
                DataTable dtinprogress = dsbcservice.Tables[0];

                Series cseries = new Series("InProgress");
                cseries.ShadowOffset = 2;

                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtinprogress.Rows.Count];
                int[] YPointMember = new int[dtinprogress.Rows.Count];

                for (int count = 0; count < dtinprogress.Rows.Count; count++)
                {
                    cseries.Points.AddXY(dtinprogress.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtinprogress.Rows[count]["Count"].ToString()));

                    cseries.Points[count].Color = Color.FromName(colorList[count]);
                    ////storing Values for X axis
                    //XPointMember[count] = dtinprogress.Rows[count]["Reference"].ToString();
                    ////storing values for Y Axis
                    //YPointMember[count] = Convert.ToInt32(dtinprogress.Rows[count]["Count"].ToString());

                }

                //binding chart control
                // cInProgress.Series[0].Points.DataBindXY(XPointMember, YPointMember);

                //Setting width of line
                //cInProgress.Series[0].BorderWidth = 10;
                //setting Chart type 
                // cInProgress.Series[0].ChartType = SeriesChartType.Column;

                cseries.ChartType = SeriesChartType.Column;
                cInProgress.Series.Add(cseries);
                cInProgress.BackColor = Color.AliceBlue;
                cInProgress.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
                cInProgress.Titles.Add("InProgress");
             



            // Compeleted

            DataTable dtcompleted = dsbcservice.Tables[1];

            Series ccseries = new Series("Completed");
            ccseries.ShadowOffset = 2;

            //storing total rows count to loop on each Record
            string[] XCPointMember = new string[dtcompleted.Rows.Count];
            int[] YCPointMember = new int[dtcompleted.Rows.Count];

            for (int count = 0; count < dtcompleted.Rows.Count; count++)
            {

                ccseries.Points.AddXY(dtcompleted.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtcompleted.Rows[count]["Count"].ToString()));
                ccseries.Points[count].Color = Color.FromName(colorList[count]);
                //storing Values for X axis
                //XCPointMember[count] = dtcompleted.Rows[count]["Reference"].ToString();
                //storing values for Y Axis
                //YCPointMember[count] = Convert.ToInt32(dtcompleted.Rows[count]["Count"]);

            }

            //binding chart control
            // cCompleted.Series[0].Points.DataBindXY(XCPointMember, YCPointMember);

            //Setting width of line
            // cCompleted.Series[0].BorderWidth = 10;
            //setting Chart type 

            ccseries.ChartType = SeriesChartType.Column;
            cCompleted.Series.Add(ccseries);
            cCompleted.BackColor = Color.AliceBlue;
            cCompleted.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cCompleted.Titles.Add("Completed");


            //Maintenance

            DataTable dtmaintenance = dsbcservice.Tables[2];

            if (dtmaintenance.Rows.Count > 0)
            {

                Series cmSeries = new Series("Maintenance");
                cmSeries.ShadowOffset = 2;

                //storing total rows count to loop on each Record
                string[] XMPointMember = new string[dtmaintenance.Rows.Count];
                int[] YMPointMember = new int[dtmaintenance.Rows.Count];

                for (int count = 0; count < dtmaintenance.Rows.Count; count++)
                {
                    cmSeries.Points.AddXY(dtmaintenance.Rows[count]["Reference"].ToString(), Convert.ToInt32(dtmaintenance.Rows[count]["Count"].ToString()));
                    cmSeries.Points[count].Color = Color.FromName(colorList[count]);
                    //storing Values for X axis
                    //XMPointMember[count] = dtmaintenance.Rows[count]["Reference"].ToString();
                    //storing values for Y Axis
                    //YMPointMember[count] = Convert.ToInt32(dtmaintenance.Rows[count]["Count"]);

                }

                //binding chart control
                //cMaintanance.Series[0].Points.DataBindXY(XMPointMember, YMPointMember);

                //Setting width of line
                //cMaintanance.Series[0].BorderWidth = 10;
                //setting Chart type 
                //cMaintanance.Series[0].ChartType = SeriesChartType.Column;

                cmSeries.ChartType = SeriesChartType.Column;
                cMaintanance.Series.Add(cmSeries);
                cMaintanance.BackColor = Color.AliceBlue;
                cMaintanance.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
                cMaintanance.Titles.Add("Maintenance");

                cMaintanance.Visible = true;
                lblamcasc.Visible = true;
                dsbcservice.Dispose();
            }

            }
            else
            {
                cMaintanance.Visible = false;
                lblamcasc.Visible = false;
            }
           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void tvBDB_SelectedNodeChanged(object sender, EventArgs e)
    {
        string strNode = tvBDB.SelectedNode.Value.ToString();

        if (strNode == "Sales Pipeline")
        {
            dvSalesPipeline.Visible = true;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            BindEnquiriesChart();
            BindQuotationsChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "Order Book")
        {

            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = true;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            BindOrderBookChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "Business Summary")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = true;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            BindBusinessSummaryChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "Category-wise Summary")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = true;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            BindCategorywiseChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "In Progress")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = true;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadBarChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "Completed")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = true;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadBarChart();

            dvfilter.Visible = true;
        }
        else if (strNode == "Maintenance")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = true;
            dvDelayService.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadBarChart();

            dvfilter.Visible = false;
        }
        else if (strNode == "Delays")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = true;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadBarChart();

            dvfilter.Visible = false;
        }
        else if (strNode == "Work In Progress")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = true;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadGeneralBarChart();
        }
        else if (strNode == "Work Completed")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = true;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadGeneralBarChart();
        }

        else if (strNode == "Work Delays")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = true;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvDelayService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadGeneralBarChart();
        }

        else if (strNode == "Lead Source")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = true;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadLeadSourceSummary();

            dvfilter.Visible = false;
        }

        else if (strNode == "Lead Status")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = true;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadLeadStatusSummary();

            dvfilter.Visible = false;
        }
        else if (strNode == "Lead Category")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = true;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadLeadCategorySummary();

            dvfilter.Visible = false;
        }
        else if (strNode == "Lead Campaign")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = true;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadCampaignSummary();

            dvfilter.Visible = false;
        }
        else if (strNode == "Source")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvCustomerSource.Visible = true;
            dvWorkProgresssummary.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            CLoadLeadSourceSummary();

            dvfilter.Visible = false;
        }
        else if (strNode == "Campaign")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = true;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            CLoadCampaignSummary();

            dvfilter.Visible = false;
        }
        else if (strNode == "Summary")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = true;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;


            LoadWorkProgressSummary();
            dvfilter.Visible = false;
        }
        else if (strNode == "Detailed")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = true;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;

            dvfilter.Visible = true;

        }
        else if (strNode == "Active Enquiries")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = true;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadActiveEnquiries();

            dvfilter.Visible = false;
        }
        else if (strNode == "Active Quotations")
        {

            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = true;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = false;

            LoadActiveQuotations();

            dvfilter.Visible = false;
        }
        else if (strNode == "Leads Tracker")
        {
            dvSalesPipeline.Visible = false;
            dvOrderBook.Visible = false;
            dvCategorywiseSummary.Visible = false;
            dvBusinessSummary.Visible = false;
            dvInProgressGeneral.Visible = false;
            dvCompletedGeneral.Visible = false;
            dvMaintenanceGeneral.Visible = false;
            dvDelaysGeneral.Visible = false;
            dvInProgressService.Visible = false;
            dvCompletedService.Visible = false;
            dvMaintenanceService.Visible = false;
            dvLeadSource.Visible = false;
            dvLeadStatus.Visible = false;
            dvLeadCategory.Visible = false;
            dvLeadCampaign.Visible = false;
            dvDelayService.Visible = false;
            dvCustomerSource.Visible = false;
            dvCustomerCampaign.Visible = false;
            dvWorkProgresssummary.Visible = false;
            dvWorkProgressdetailed.Visible = false;
            dvActiveEnquiries.Visible = false;
            dvActiveQuotations.Visible = false;
            dvfilter.Visible = true;
            dvLeadsTrack.Visible = true;

            LoadLeadsTrack();
            LoadLeadsTrackPipeline();

            dvfilter.Visible = false;
        }
    }
    public void LoadLeadsTrackPipeline()
    {
        try
        {
            DataSet dsLeadsTrackPipeline = sqlobj.SQLExecuteDataset("LeadsTracker_Pipeline");
            if(dsLeadsTrackPipeline.Tables[0].Rows.Count > 0)
            {
                lblLeadsTrackPipeline.Text = dsLeadsTrackPipeline.Tables[0].Rows[0][0].ToString();
                //lblleadstrackenquiry.Text = dsLeadsTrackPipeline.Tables[0].Rows[0]["Enquiry"].ToString();
                //lblleadstrackquote.Text = dsLeadsTrackPipeline.Tables[0].Rows[0]["Quote"].ToString();
                lblLeadsTrackLeadAdd.Text = dsLeadsTrackPipeline.Tables[1].Rows[0][0].ToString();
                lblLeadsTrackLeadupdate.Text = dsLeadsTrackPipeline.Tables[2].Rows[0][0].ToString();
                lblLeadsTrackQuoteAdd.Text = dsLeadsTrackPipeline.Tables[3].Rows[0][0].ToString() + " for " + dsLeadsTrackPipeline.Tables[3].Rows[0][1].ToString();
            }
        }
        catch (Exception ex)
        {
           
        }
    }

    private void LoadLeadsTrack()
    {
        try
        {
            DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_LeadsTrack");
            if (dsserdb.Tables[0].Rows.Count > 0)
            {
                gvLeadsTrack.DataSource = dsserdb.Tables[0];
                gvLeadsTrack.DataBind();
            }
            else
            {
                gvLeadsTrack.DataSource = null;
                gvLeadsTrack.DataBind();
            }
            dsserdb.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddldays_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_GetServiceDelays",
             new SqlParameter() { ParameterName = "@Days", SqlDbType = SqlDbType.Int, Value = ddldays.SelectedValue },
             new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = ddldays.SelectedValue }

             );

            if (dsserdb.Tables[0].Rows.Count > 0)
            {
                gvDelays.DataSource = dsserdb.Tables[0];
                gvDelays.DataBind();
            }
            else
            {
                gvDelays.DataSource = null;
                gvDelays.DataBind();
            }

            dsserdb.Dispose();

            LoadBarChart();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void ddlGdelays_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsserdb = sqlobj.SQLExecuteDataset("SP_GetGeneralDelays",
             new SqlParameter() { ParameterName = "@Days", SqlDbType = SqlDbType.Int, Value = ddldays.SelectedValue },
             new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = ddldays.SelectedValue }

             );

            if (dsserdb.Tables[0].Rows.Count > 0)
            {
                gvGDelays.DataSource = dsserdb.Tables[0];
                gvGDelays.DataBind();
            }
            else
            {
                gvGDelays.DataSource = null;
                gvGDelays.DataBind();
            }

            dsserdb.Dispose();

            LoadGeneralBarChart();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageNTaskList.aspx");
    }
    private void LoadCampaignSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCampaignSummary = new DataSet();
        DataSet dsCampaignSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsCampaignSummary = sqlobj.SQLExecuteDataset("SP_CampaignSummary");


        if (dsCampaignSummary.Tables[0].Rows.Count != 0)
        {

            // Grid
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Campaign");
            //dt.Columns.Add("Sofar");
            //dt.Columns.Add("Percentage",typeof(int));
            //dt.Columns.Add("InLast7Days");
            //dt.Columns.Add("QLD");
            //dt.Rows.Add("GST Tax seminar Coming up", "17", 30.00, "10", "20");
            //dt.Rows.Add("Newspaper ad", "27", 40.00, "14", "25");
            //dt.Rows.Add("Testing Campaign", "17", 10.00, "40", "20");
            //dt.Rows.Add("Testing Campaing", "37", 20.00, "48", "20");            
            //dt.AcceptChanges();

            //gvCampaignSummary.DataSource = dt;
            gvCampaignSummary.DataSource = dsCampaignSummary;
            gvCampaignSummary.DataBind();

            gvCampaignSummary.ShowFooter = true;
            gvCampaignSummary.FooterRow.Cells[0].Text = "Total";
            gvCampaignSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvCampaignSummary.FooterRow.Cells[1].Text = dsCampaignSummary.Tables[0].Compute("sum(Sofar)", "").ToString();
            gvCampaignSummary.FooterRow.Cells[3].Text = dsCampaignSummary.Tables[0].Compute("sum(InLast7days)", "").ToString();
            gvCampaignSummary.FooterRow.Cells[4].Text = dsCampaignSummary.Tables[0].Compute("sum(QLD)", "").ToString();


            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            // Count
            //DataTable dtbc = dt;
            DataTable dtbc = dsCampaignSummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("Sofar");
            Legend cqlegends = new Legend("InLast7Days");
            Legend colegends = new Legend("Hot");

            Series ceseries = new Series("Sofar");
            Series cqseries = new Series("InLast7Days");
            Series coseries = new Series("Hot");



            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["Campaign"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Sofar"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["Campaign"].ToString(), Convert.ToInt32(dtbc.Rows[count]["InLast7Days"]));
                coseries.Points.AddXY(dtbc.Rows[count]["Campaign"].ToString(), Convert.ToInt32(dtbc.Rows[count]["QLD"]));

                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;
            }
            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;
            cqseries.ChartType = SeriesChartType.Column;

            cLeadCampaign.Series.Add(ceseries);
            cLeadCampaign.Series.Add(cqseries);
            cLeadCampaign.Series.Add(coseries);


            cLeadCampaign.Legends.Add(celegends);
            cLeadCampaign.Legends.Add(cqlegends);
            cLeadCampaign.Legends.Add(colegends);

            cLeadCampaign.Series["Sofar"].YValuesPerPoint = 1;
            cLeadCampaign.Series["InLast7Days"].YValuesPerPoint = 1;
            cLeadCampaign.Series["Hot"].YValuesPerPoint = 1;

            cLeadCampaign.Series["Sofar"].IsVisibleInLegend = true;
            cLeadCampaign.Series["Sofar"].IsValueShownAsLabel = true;
            cLeadCampaign.Series["Sofar"].ToolTip = "#VALX  - Sofar - #VALY";

            cLeadCampaign.Series["InLast7Days"].IsVisibleInLegend = true;
            cLeadCampaign.Series["InLast7Days"].IsValueShownAsLabel = true;
            cLeadCampaign.Series["InLast7Days"].ToolTip = "#VALX  - InLast7Days - #VALY";

            cLeadCampaign.Series["Hot"].IsVisibleInLegend = true;
            cLeadCampaign.Series["Hot"].IsValueShownAsLabel = true;
            cLeadCampaign.Series["Hot"].ToolTip = "#VALX  - Hot - #VALY";

            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;

            cLeadCampaign.BackColor = Color.AliceBlue;
            cLeadCampaign.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

            cLeadCampaign.Titles.Add("Lead Campaign - Count");
        }
        else
        {
            gvCampaignSummary.DataSource = null;
            gvCampaignSummary.DataBind();
        }

        dsCampaignSummary.Dispose();
    }
    private void LoadLeadCategorySummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadCategorySummary = new DataSet();
        DataSet dsLeadCategorySummaryTotal = new DataSet();
        DataSet dsLeadCategorySummaryGraph = new DataSet();
        dsLeadCategorySummary = sqlobj.SQLExecuteDataset("SP_GetCategoryMain");

        if (dsLeadCategorySummary.Tables[0].Rows.Count != 0)
        {
            // Grid
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Category");
            //dt.Columns.Add("HotLeads");
            //dt.Columns.Add("Customers");
            //dt.Columns.Add("Vendors");
            //dt.Columns.Add("Others");
            //dt.Rows.Add("Govt.Org", "17", "30", "10", "20");
            //dt.Rows.Add("OEM", "27", "40", "14", "25");
            //dt.Rows.Add("PublicSector", "17", "10", "40", "20");
            //dt.Rows.Add("Consultant", "37", "31", "48", "20");
            //dt.Rows.Add("Pvt.Sector", "42", "30", "10", "20");
            //dt.Rows.Add("Software Co.", "42", "10", "10", "20");
            //dt.Rows.Add("New Sector", "42", "70", "10", "20");
            //dt.AcceptChanges();

            //gvLeadCategorySummary.DataSource = dt;
            gvLeadCategorySummary.DataSource = dsLeadCategorySummary;
            gvLeadCategorySummary.DataBind();

            gvLeadCategorySummary.ShowFooter = true;
            gvLeadCategorySummary.FooterRow.Cells[0].Text = "Total";
            gvLeadCategorySummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;

            gvLeadCategorySummary.FooterRow.Cells[1].Text = dsLeadCategorySummary.Tables[0].Compute("sum(HotLeads)", "").ToString();
            gvLeadCategorySummary.FooterRow.Cells[2].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Customers)", "").ToString();

            gvLeadCategorySummary.FooterRow.HorizontalAlign = HorizontalAlign.Center;

            //chartleadcategorysummary.DataSource = dsLeadCategorySummaryGraph;
            //chartleadcategorysummary.DataBind();

            // HighlightColor(gvLeadStatusSummary, 1);

            // Graph

            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            // Count
            //DataTable dtbc =dt;
            DataTable dtbc = dsLeadCategorySummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("HotLeads");
            Legend cqlegends = new Legend("Customers");


            Series ceseries = new Series("HotLeads");
            Series cqseries = new Series("Customers");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["HotLeads"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["Category"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Customers"]));
                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;
            }
            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;

            cLeadCategory.Series.Add(ceseries);
            cLeadCategory.Series.Add(cqseries);

            cLeadCategory.Legends.Add(celegends);
            cLeadCategory.Legends.Add(cqlegends);

            cLeadCategory.Series["HotLeads"].YValuesPerPoint = 1;
            cLeadCategory.Series["Customers"].YValuesPerPoint = 1;

            cLeadCategory.Series["HotLeads"].IsVisibleInLegend = true;
            cLeadCategory.Series["HotLeads"].IsValueShownAsLabel = true;
            cLeadCategory.Series["HotLeads"].ToolTip = "#VALX  - HotLeads - #VALY";

            cLeadCategory.Series["Customers"].IsVisibleInLegend = true;
            cLeadCategory.Series["Customers"].IsValueShownAsLabel = true;
            cLeadCategory.Series["Customers"].ToolTip = "#VALX  - Customers - #VALY";

            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;

            cLeadCategory.BackColor = Color.AliceBlue;
            cLeadCategory.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cLeadCategory.Titles.Add("Lead Category - Count");

        }
        else
        {
            gvLeadCategorySummary.DataSource = null;
            gvLeadCategorySummary.DataBind();
        }

        dsLeadCategorySummary.Dispose();

    }
    private void LoadLeadStatusSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();
        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_LeadStatusSummary");

        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            // Grid
            //DataTable dt = new DataTable();
            //dt.Columns.Add("Status");
            //dt.Columns.Add("statusCount");
            //dt.Columns.Add("Percentage", typeof(int));
            //dt.Rows.Add("Enquiry", "37", 15.00);
            //dt.Rows.Add("Warm", "52", 45.00);
            //dt.Rows.Add("Assigned", "31", 15.00);
            //dt.Rows.Add("Hot", "37", 10.00);
            //dt.Rows.Add("Cold", "42", 5.00);
            //dt.Rows.Add("Dropped", "42", 10.00);
            //dt.AcceptChanges();

            //gvLeadStatusSummary.DataSource = dt;
            gvLeadStatusSummary.DataSource = dsLeadSourceSummary;
            gvLeadStatusSummary.DataBind();

            gvLeadStatusSummary.ShowFooter = true;
            gvLeadStatusSummary.FooterRow.Cells[0].Text = "Total";
            gvLeadStatusSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvLeadStatusSummary.FooterRow.Cells[1].Text = dsLeadSourceSummary.Tables[0].Compute("sum(StatusCount)", "").ToString();

            //gvLeadStatusSummaryTotal.DataSource = dsLeadSourceSummaryTotal;
            //gvLeadStatusSummaryTotal.DataBind();

            //chartleadstatussummary.DataSource = dsLeadSourceSummaryGraph;
            // chartleadstatussummary.DataBind();

            // HighlightColor(gvLeadStatusSummary, 1);

            // Graph

            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            // Count
            //DataTable dtbc = dt;
            DataTable dtbc = dsLeadSourceSummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("StatusCount");
            Series ceseries = new Series("StatusCount");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["Status"].ToString(), Convert.ToInt32(dtbc.Rows[count]["StatusCount"]));

            }

            ceseries.ChartType = SeriesChartType.Column;

            cLeadStatus.Series.Add(ceseries);

            cLeadStatus.Legends.Add(celegends);
            cLeadStatus.Series["StatusCount"].YValuesPerPoint = 1;

            cLeadStatus.Series["StatusCount"].IsVisibleInLegend = true;
            cLeadStatus.Series["StatusCount"].IsValueShownAsLabel = true;
            cLeadStatus.Series["StatusCount"].ToolTip = "#VALX  - StatusCount - #VALY";

            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;

            cLeadStatus.BackColor = Color.AliceBlue;
            cLeadStatus.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cLeadStatus.Titles.Add("Lead Status - Count");
        }
        else
        {
            gvLeadStatusSummary.DataSource = null;
            gvLeadStatusSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }
    private void LoadLeadSourceSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_LeadSummary");

        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            //Sample Datatable
            //DataTable dt = new DataTable();
            //dt.Columns.Add("LeadSource");
            //dt.Columns.Add("LeadCount");
            //dt.Columns.Add("Percentage", typeof(int));
            //dt.Columns.Add("InLast7Days");
            //dt.Columns.Add("QLD");
            //dt.Rows.Add("Consultant", "37",15.00,"16", "25");
            //dt.Rows.Add("CustRef", "52", 45.00,"21","31");
            //dt.Rows.Add("Dealer", "31", 25.00,"52","75");
            //dt.Rows.Add("FriendReferral", "37", 10.00,"17","31");
            //dt.Rows.Add("General", "42", 5.00,"28","35");
            //dt.AcceptChanges();

            // Grid
            //gvLeadSourceSummary.DataSource = dt;
            gvLeadSourceSummary.DataSource = dsLeadSourceSummary;
            gvLeadSourceSummary.DataBind();

            gvLeadSourceSummary.ShowFooter = true;
            gvLeadSourceSummary.FooterRow.Cells[0].Text = "Total";
            gvLeadSourceSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvLeadSourceSummary.FooterRow.Cells[1].Text = dsLeadSourceSummary.Tables[0].Compute("sum(LeadCount)", "").ToString();
            gvLeadSourceSummary.FooterRow.Cells[3].Text = dsLeadSourceSummary.Tables[0].Compute("sum(InLast7Days)", "").ToString();
            gvLeadSourceSummary.FooterRow.Cells[4].Text = dsLeadSourceSummary.Tables[0].Compute("sum(QLD)", "").ToString();


            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");            

            // Compeleted
            //DataTable dtbc = dt;
            // Count

            DataTable dtbc = dsLeadSourceSummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("LeadCount");
            Legend cqlegends = new Legend("InLast7Days");
            Legend colegends = new Legend("Hot");
            Series ceseries = new Series("LeadCount");
            Series cqseries = new Series("InLast7Days");
            Series coseries = new Series("Hot");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["LeadSource"].ToString(), Convert.ToInt32(dtbc.Rows[count]["LeadCount"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["LeadSource"].ToString(), Convert.ToInt32(dtbc.Rows[count]["InLast7Days"]));
                coseries.Points.AddXY(dtbc.Rows[count]["LeadSource"].ToString(), Convert.ToInt32(dtbc.Rows[count]["QLD"]));

                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;
            }

            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;
            cqseries.ChartType = SeriesChartType.Column;

            cLeadSource.Series.Add(ceseries);
            cLeadSource.Series.Add(cqseries);
            cLeadSource.Series.Add(coseries);


            cLeadSource.Legends.Add(celegends);
            cLeadSource.Legends.Add(cqlegends);
            cLeadSource.Legends.Add(colegends);

            cLeadSource.Series["LeadCount"].YValuesPerPoint = 1;
            cLeadSource.Series["InLast7Days"].YValuesPerPoint = 1;
            cLeadSource.Series["Hot"].YValuesPerPoint = 1;

            cLeadSource.Series["LeadCount"].IsVisibleInLegend = true;
            cLeadSource.Series["LeadCount"].IsValueShownAsLabel = true;
            cLeadSource.Series["LeadCount"].ToolTip = "#VALX  - LeadCount - #VALY";

            cLeadSource.Series["InLast7Days"].IsVisibleInLegend = true;
            cLeadSource.Series["InLast7Days"].IsValueShownAsLabel = true;
            cLeadSource.Series["InLast7Days"].ToolTip = "#VALX  - InLast7Days - #VALY";

            cLeadSource.Series["Hot"].IsVisibleInLegend = true;
            cLeadSource.Series["Hot"].IsValueShownAsLabel = true;
            cLeadSource.Series["Hot"].ToolTip = "#VALX  - Hot - #VALY";

            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;

            cLeadSource.BackColor = Color.AliceBlue;
            cLeadSource.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

            cLeadSource.Titles.Add("Lead Source - Count");
        }
        else
        {
            gvLeadSourceSummary.DataSource = null;
            gvLeadSourceSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }
    protected void onLeadSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        // gvLeadSourceSummary.PageIndex = e.NewPageIndex;
        LoadLeadSourceSummary();
    }
    protected void btnimgLedStatusExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadStatusSummary };
        Export("LeadStatusSummary.xls", gvList);
    }
    protected void btnimgLedSrcExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadSourceSummary };
        Export("LeadSourceSummary.xls", gvList);
    }
    protected void btnimgLeadCategoryExport_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadCategorySummary };
        Export("LeadCategorySummary.xls", gvList);
    }
    protected void btnimgCamSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCampaignSummary };
        Export("CampaignSummary.xls", gvList);
    }
    protected void btnimgCLedSrcExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCLeadSourceSummary };
        Export("CustomerLeadSourceSummary.xls", gvList);
    }
    protected void btnimgCCamSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCCampaignSummary };
        Export("CustomerCampaignSummary.xls", gvList);
    }
    protected void onReferenceSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        //gvReferenceSummary.PageIndex = e.NewPageIndex;
        //LoadReferenceSummary();
    }
    protected void btnimgCRefSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        //GridView[] gvList = new GridView[] { gvReferenceSummary, gvReferenceSummaryTotal };
        //Export("CustomerReferenceSummary.xls", gvList);
    }
    protected void onCampaignSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvCampaignSummary.PageIndex = e.NewPageIndex;
        LoadCampaignSummary();
    }
    private static void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {
            Control current = control.Controls[i];
            if (current is LinkButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
            }
            else if (current is ImageButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
            }
            else if (current is HyperLink)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
            }
            else if (current is DropDownList)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
            }
            else if (current is CheckBox)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
            }


            if (current.HasControls())
            {
                PrepareControlForExport(current);
            }
        }
    }
    public void Export(string fileName, GridView[] gvs)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        HttpContext.Current.Response.ContentType = "application/ms-excel";

        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);





        foreach (GridView gv in gvs)
        {

            //   Create a form to contain the grid
            Table table = new Table();
            table.GridLines = gv.GridLines;
            //   add the header row to the table
            if (!(gv.HeaderRow == null))
            {
                PrepareControlForExport(gv.HeaderRow);
                table.Rows.Add(gv.HeaderRow);
            }
            //   add each of the data rows to the table




            foreach (GridViewRow row in gv.Rows)
            {


                PrepareControlForExport(row);
                table.Rows.Add(row);
            }
            //   add the footer row to the table
            if (!(gv.FooterRow == null))
            {
                PrepareControlForExport(gv.FooterRow);
                table.Rows.Add(gv.FooterRow);
            }
            //   render the table into the htmlwriter
            table.RenderControl(htw);
        }
        //   render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString());
        HttpContext.Current.Response.End();
    }


    private void CLoadLeadSourceSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();
        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_CLeadSummary");

        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            // Grid

            //DataTable dt = new DataTable();
            //dt.Columns.Add("leadsource");
            //dt.Columns.Add("customer");
            //dt.Columns.Add("percentage",typeof(int));
            //dt.Columns.Add("InLast7Days");
            //dt.Rows.Add("Consultant","38",29.00,"21");
            //dt.Rows.Add("CustRef", "58", 12.00, "11");
            //dt.Rows.Add("Dealer", "28", 9.00, "34");
            //dt.Rows.Add("FriendReferral", "38", 10.00, "18");
            //dt.Rows.Add("General", "13", 19.00, "15");
            //dt.Rows.Add("JustDial", "31", 10.00, "27");
            //dt.Rows.Add("Website", "45", 6.00, "31");
            //dt.Rows.Add("YellowPages", "30", 5.00, "21");
            //dt.AcceptChanges();
            //gvCLeadSourceSummary.DataSource = dt;

            gvCLeadSourceSummary.DataSource = dsLeadSourceSummary;
            gvCLeadSourceSummary.DataBind();

            gvCLeadSourceSummary.ShowFooter = true;
            gvCLeadSourceSummary.FooterRow.Cells[0].Text = "Total";
            gvCLeadSourceSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvCLeadSourceSummary.FooterRow.Cells[1].Text = dsLeadSourceSummary.Tables[0].Compute("sum(Customer)", "").ToString();
            gvCLeadSourceSummary.FooterRow.Cells[3].Text = dsLeadSourceSummary.Tables[0].Compute("sum(InLast7Days)", "").ToString();
            //HighlightColor(gvCLeadSourceSummary, 2);
            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            // Count         
            
            DataTable dtbc = dsLeadSourceSummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("Customer");
            Legend cqlegends = new Legend("InLast7Days");

            Series ceseries = new Series("Customer");
            Series cqseries = new Series("InLast7Days");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["LeadSource"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Customer"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["LeadSource"].ToString(), Convert.ToInt32(dtbc.Rows[count]["InLast7Days"]));
                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;
            }

            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;

            cCustomerSource.Series.Add(ceseries);
            cCustomerSource.Series.Add(cqseries);

            cCustomerSource.Legends.Add(celegends);
            cCustomerSource.Legends.Add(cqlegends);


            cCustomerSource.Series["Customer"].YValuesPerPoint = 1;
            cCustomerSource.Series["InLast7Days"].YValuesPerPoint = 1;


            cCustomerSource.Series["Customer"].IsVisibleInLegend = true;
            cCustomerSource.Series["Customer"].IsValueShownAsLabel = true;
            cCustomerSource.Series["Customer"].ToolTip = "#VALX  - Customer - #VALY";

            cCustomerSource.Series["InLast7Days"].IsVisibleInLegend = true;
            cCustomerSource.Series["InLast7Days"].IsValueShownAsLabel = true;
            cCustomerSource.Series["InLast7Days"].ToolTip = "#VALX  - InLast7Days - #VALY";

            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;

            cCustomerSource.BackColor = Color.AliceBlue;
            cCustomerSource.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            cCustomerSource.Titles.Add("Customer Source - Count");

        }
        else
        {
            gvCLeadSourceSummary.DataSource = null;
            gvCLeadSourceSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }

    private void CLoadCampaignSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCampaignSummary = new DataSet();
        DataSet dsCampaignSummaryTotal = new DataSet();
        DataSet dsCampaignSummaryGraph = new DataSet();

        dsCampaignSummary = sqlobj.SQLExecuteDataset("SP_CCampaignSummary");


        if (dsCampaignSummary.Tables[0].Rows.Count != 0)
        {
            // Grid

            //DataTable dt = new DataTable();
            //dt.Columns.Add("campaign");
            //dt.Columns.Add("sofar");
            //dt.Columns.Add("percentage", typeof(int));
            //dt.Columns.Add("InLast7Days");
            //dt.Rows.Add("GST Tax Seminar Coming Up", "38", 59.00, "21");
            //dt.Rows.Add("Newspaper ad", "58", 12.00, "11");
            //dt.Rows.Add("Testing Campaign", "28", 19.00, "34");
            //dt.Rows.Add("Testing Campaing", "38", 10.00, "18");           
            //dt.AcceptChanges();
            //gvCCampaignSummary.DataSource = dt;

            gvCCampaignSummary.DataSource = dsCampaignSummary;
            gvCCampaignSummary.DataBind();

            gvCCampaignSummary.ShowFooter = true;
            gvCCampaignSummary.FooterRow.Cells[0].Text = "Total";
            gvCCampaignSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvCCampaignSummary.FooterRow.Cells[1].Text = dsCampaignSummary.Tables[0].Compute("sum(Sofar)", "").ToString();
            gvCCampaignSummary.FooterRow.Cells[3].Text = dsCampaignSummary.Tables[0].Compute("sum(InLast7Days)", "").ToString();

            //HighlightColor(gvCLeadSourceSummary, 2);
            // Graph

            // color list

            List<string> colorList = new List<string>();
            colorList.Add("Blue");
            colorList.Add("Brown");
            colorList.Add("Teal");
            colorList.Add("Purple");
            colorList.Add("Orange");
            colorList.Add("Red");
            colorList.Add("Green");
            colorList.Add("Yellow");
            colorList.Add("SkyBlue");
            colorList.Add("Flusia");
            colorList.Add("Pink");

            // Count
           
            DataTable dtbc = dsCampaignSummary.Tables[0];

            //Legend celegneds = new Legend("Quotation");
            Legend celegends = new Legend("Sofar");
            Legend cqlegends = new Legend("InLast7Days");

            Series ceseries = new Series("Sofar");
            Series cqseries = new Series("InLast7Days");

            //storing total rows count to loop on each Record
            string[] XPointMember = new string[dtbc.Rows.Count];
            int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
            int[] YQuotationPointMember = new int[dtbc.Rows.Count];
            int[] YOrderPointMember = new int[dtbc.Rows.Count];

            for (int count = 0; count < dtbc.Rows.Count; count++)
            {
                ceseries.Points.AddXY(dtbc.Rows[count]["Campaign"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Sofar"]));
                cqseries.Points.AddXY(dtbc.Rows[count]["Campaign"].ToString(), Convert.ToInt32(dtbc.Rows[count]["InLast7Days"]));

                // coseries.Points[count].Color = Color.Blue;
                // cqseries.Points[count].Color = Color.Brown;
                // ceseries.Points[count].Color = Color.Teal;


            }
            cqseries.ChartType = SeriesChartType.Column;
            ceseries.ChartType = SeriesChartType.Column;

            cCustomerCampaign.Series.Add(ceseries);
            cCustomerCampaign.Series.Add(cqseries);

            cCustomerCampaign.Legends.Add(celegends);
            cCustomerCampaign.Legends.Add(cqlegends);

            cCustomerCampaign.Series["Sofar"].YValuesPerPoint = 1;
            cCustomerCampaign.Series["InLast7Days"].YValuesPerPoint = 1;


            cCustomerCampaign.Series["Sofar"].IsVisibleInLegend = true;
            cCustomerCampaign.Series["Sofar"].IsValueShownAsLabel = true;
            cCustomerCampaign.Series["Sofar"].ToolTip = "#VALX  - Customer - #VALY";

            cCustomerCampaign.Series["InLast7Days"].IsVisibleInLegend = true;
            cCustomerCampaign.Series["InLast7Days"].IsValueShownAsLabel = true;
            cCustomerCampaign.Series["InLast7Days"].ToolTip = "#VALX  - InLast7Days - #VALY";





            celegends.LegendStyle = LegendStyle.Table;
            celegends.TableStyle = LegendTableStyle.Wide;
            celegends.Docking = Docking.Bottom;




            cCustomerCampaign.BackColor = Color.AliceBlue;
            cCustomerCampaign.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


            cCustomerCampaign.Titles.Add("Customer Campaign - Count");

        }
        else
        {
            gvCCampaignSummary.DataSource = null;
            gvCCampaignSummary.DataBind();
        }

        dsCampaignSummary.Dispose();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {       
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
    private void LoadWorkProgressSummary()
    {
        try
        {
            DataSet dsworkprogresssummary = sqlobj.SQLExecuteDataset("SP_IGWorkInProgresssummary");
            if (dsworkprogresssummary.Tables[0].Rows.Count > 0)
            {
                lblcworkprogresssummary.Text = "Work Progress as of  " + DateTime.Now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));
                // Grid
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Type");
                //dt.Columns.Add("count");
                //dt.Rows.Add("YTS","33");
                //dt.Rows.Add("WIP", "53");
                //dt.Rows.Add("HiPri", "18");
                //dt.Rows.Add("Done7", "23");
                //dt.Rows.Add("Done30", "73");

                //gvWorkProgressSummary.DataSource = dt;

                gvWorkProgressSummary.DataSource = dsworkprogresssummary;
                gvWorkProgressSummary.DataBind();

                // color list

                List<string> colorList = new List<string>();
                colorList.Add("Red");
                colorList.Add("Green");
                colorList.Add("Yellow");
                colorList.Add("Purple");
                colorList.Add("Orange");
                colorList.Add("Blue");
                colorList.Add("Brown");
                colorList.Add("Teal");
                colorList.Add("SkyBlue");
                colorList.Add("Flusia");
                colorList.Add("Pink");
              
                DataTable dtbc = dsworkprogresssummary.Tables[0];

                Legend celegneds = new Legend("WorkProgressSummary");
                ;

                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtbc.Rows.Count];
                int[] YPointMember = new int[dtbc.Rows.Count];

                for (int count = 0; count < dtbc.Rows.Count; count++)
                {
                    cWorkProgressSummary.Series["WorkProgressSummary"].Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
                    //cWorkProgressSummary.Series["WorkProgressSummary"].Points[count].Color = Color.FromName(colorList[count]);
                }

                cWorkProgressSummary.Series["WorkProgressSummary"].ChartType = SeriesChartType.Column;
                cWorkProgressSummary.Legends.Add(celegneds);

                cWorkProgressSummary.Series["WorkProgressSummary"].IsVisibleInLegend = true;
                cWorkProgressSummary.Series["WorkProgressSummary"].IsValueShownAsLabel = true;
                cWorkProgressSummary.Series["WorkProgressSummary"].ToolTip = "#VALX  - #VALY";

                cWorkProgressSummary.Legends["WorkProgressSummary"].LegendStyle = LegendStyle.Table;
                cWorkProgressSummary.Legends["WorkProgressSummary"].TableStyle = LegendTableStyle.Wide;
                cWorkProgressSummary.Legends["WorkProgressSummary"].Docking = Docking.Bottom;

                cWorkProgressSummary.Series[0].YValuesPerPoint = 1;

                cWorkProgressSummary.BackColor = Color.AliceBlue;
                cWorkProgressSummary.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


                cWorkProgressSummary.Titles.Add("Work Progress Summary");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadWorkProgressDetailed()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsWorkProgressDetailed = new DataSet();

            dsWorkProgressDetailed = sqlobj.SQLExecuteDataset("SP_IGWorkInProgressdetailed",
                 new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NVarChar, Value = ddlwpstaff.SelectedValue });


            if (dsWorkProgressDetailed.Tables[0].Rows.Count != 0)
            {
                lblworkprogressdetailed.Text = "Work progress - detailed as of  " + DateTime.Now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));
                // Grid
                //DataTable dt = new DataTable();
                //dt.Columns.Add("staffname");
                //dt.Columns.Add("YTS");
                //dt.Columns.Add("IP");
                //dt.Columns.Add("Priority");
                //dt.Columns.Add("Done7");
                //dt.Columns.Add("Done30");
                //dt.Rows.Add("Sridhar.N","27","16","12","25","51");
                //dt.AcceptChanges();
                //gvWorkProgressDetailed.DataSource = dt;

                gvWorkProgressDetailed.DataSource = dsWorkProgressDetailed;
                gvWorkProgressDetailed.DataBind();

                // Graph

                // color list

                List<string> colorList = new List<string>();
                colorList.Add("Blue");
                colorList.Add("Brown");
                colorList.Add("Teal");
                colorList.Add("Purple");
                colorList.Add("Orange");
                colorList.Add("Red");
                colorList.Add("Green");
                colorList.Add("Yellow");
                colorList.Add("SkyBlue");
                colorList.Add("Flusia");
                colorList.Add("Pink");


                // Count                
                DataTable dtbc = dsWorkProgressDetailed.Tables[0];

                //Legend celegneds = new Legend("Quotation");
                Legend cytslegends = new Legend("YTS");
                Legend cwpslegends = new Legend("WIP");
                Legend cwhiprilegends = new Legend("HiPri");
                Legend cwdone7legends = new Legend("Done7");
                Legend cwdone30legends = new Legend("Done30");

                Series cytsseries = new Series("YTS");
                Series cwpsseries = new Series("WIP");
                Series cwhipriseries = new Series("HiPri");
                Series cwdone7series = new Series("Done7");
                Series cwdone30series = new Series("Done30");


                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtbc.Rows.Count];
                int[] YEnquiryPointMember = new int[dtbc.Rows.Count];
                int[] YQuotationPointMember = new int[dtbc.Rows.Count];
                int[] YOrderPointMember = new int[dtbc.Rows.Count];

                for (int count = 0; count < dtbc.Rows.Count; count++)
                {

                    cytsseries.Points.AddXY(dtbc.Rows[count]["staffname"].ToString(), Convert.ToInt32(dtbc.Rows[count]["YTS"]));
                    cwpsseries.Points.AddXY(dtbc.Rows[count]["staffname"].ToString(), Convert.ToInt32(dtbc.Rows[count]["IP"]));
                    cwhipriseries.Points.AddXY(dtbc.Rows[count]["staffname"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Priority"]));
                    cwdone7series.Points.AddXY(dtbc.Rows[count]["staffname"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Done7"]));
                    cwdone30series.Points.AddXY(dtbc.Rows[count]["staffname"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Done30"]));

                }

                cytsseries.ChartType = SeriesChartType.Column;
                cwpsseries.ChartType = SeriesChartType.Column;
                cwhipriseries.ChartType = SeriesChartType.Column;
                cwdone7series.ChartType = SeriesChartType.Column;
                cwdone30series.ChartType = SeriesChartType.Column;


                cWorkProgressDetailed.Series.Add(cytsseries);
                cWorkProgressDetailed.Series.Add(cwpsseries);
                cWorkProgressDetailed.Series.Add(cwhipriseries);
                cWorkProgressDetailed.Series.Add(cwdone7series);
                cWorkProgressDetailed.Series.Add(cwdone30series);

                cWorkProgressDetailed.Legends.Add(cytslegends);
                cWorkProgressDetailed.Legends.Add(cwpslegends);
                cWorkProgressDetailed.Legends.Add(cwhiprilegends);
                cWorkProgressDetailed.Legends.Add(cwdone7legends);
                cWorkProgressDetailed.Legends.Add(cwdone30legends);



                cWorkProgressDetailed.Series["YTS"].YValuesPerPoint = 1;
                cWorkProgressDetailed.Series["WIP"].YValuesPerPoint = 1;
                cWorkProgressDetailed.Series["HiPri"].YValuesPerPoint = 1;
                cWorkProgressDetailed.Series["Done7"].YValuesPerPoint = 1;
                cWorkProgressDetailed.Series["Done30"].YValuesPerPoint = 1;


                cWorkProgressDetailed.Series["YTS"].IsVisibleInLegend = true;
                cWorkProgressDetailed.Series["YTS"].IsValueShownAsLabel = true;
                cWorkProgressDetailed.Series["YTS"].ToolTip = "#VALX  - YTS - #VALY";

                cWorkProgressDetailed.Series["WIP"].IsVisibleInLegend = true;
                cWorkProgressDetailed.Series["WIP"].IsValueShownAsLabel = true;
                cWorkProgressDetailed.Series["WIP"].ToolTip = "#VALX  - WIP - #VALY";

                cWorkProgressDetailed.Series["HiPri"].IsVisibleInLegend = true;
                cWorkProgressDetailed.Series["HiPri"].IsValueShownAsLabel = true;
                cWorkProgressDetailed.Series["HiPri"].ToolTip = "#VALX  - HiPri - #VALY";

                cWorkProgressDetailed.Series["Done7"].IsVisibleInLegend = true;
                cWorkProgressDetailed.Series["Done7"].IsValueShownAsLabel = true;
                cWorkProgressDetailed.Series["Done7"].ToolTip = "#VALX  - Done7 - #VALY";

                cWorkProgressDetailed.Series["Done30"].IsVisibleInLegend = true;
                cWorkProgressDetailed.Series["Done30"].IsValueShownAsLabel = true;
                cWorkProgressDetailed.Series["Done30"].ToolTip = "#VALX  - Done30 - #VALY";



                cytslegends.LegendStyle = LegendStyle.Table;
                cytslegends.TableStyle = LegendTableStyle.Wide;
                cytslegends.Docking = Docking.Bottom;


                cWorkProgressDetailed.BackColor = Color.AliceBlue;
                cWorkProgressDetailed.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


                cWorkProgressDetailed.Titles.Add("Work Progress - Detailed");

            }
            else
            {
                gvWorkProgressDetailed.DataSource = null;
                gvWorkProgressDetailed.DataBind();
            }

            dsWorkProgressDetailed.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadActiveEnquiries()
    {
        try
        {
            DataSet dsActiveEnquiries = sqlobj.SQLExecuteDataset("SP_IGActiveEnquiries");

            if (dsActiveEnquiries.Tables[0].Rows.Count > 0)
            {


                lblActiveEnquiries.Text = "Active Enquiries as of  " + DateTime.Now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));

                // Grid

                //Sample Datatable
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Type");
                //dt.Columns.Add("Count");
                //dt.Rows.Add("<7 days", "37");
                //dt.Rows.Add("<= 30 days", "27");
                //dt.Rows.Add(">30 <= 90 days", "15");
                //dt.Rows.Add(">= 90 days", "23");
                //dt.AcceptChanges();

                //gvActiveEnquiries.DataSource = dt;
                gvActiveEnquiries.DataSource = dsActiveEnquiries;
                gvActiveEnquiries.DataBind();



                // color list

                List<string> colorList = new List<string>();
                colorList.Add("Red");
                colorList.Add("Green");
                colorList.Add("Yellow");
                colorList.Add("Purple");
                colorList.Add("Orange");
                colorList.Add("Blue");
                colorList.Add("Brown");
                colorList.Add("Teal");
                colorList.Add("SkyBlue");
                colorList.Add("Flusia");
                colorList.Add("Pink");




                //DataTable dtbc = dt;
               DataTable dtbc = dsActiveEnquiries.Tables[0];

                Legend celegneds = new Legend("ActiveEnquiries");
                ;

                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtbc.Rows.Count];
                int[] YPointMember = new int[dtbc.Rows.Count];

                for (int count = 0; count < dtbc.Rows.Count; count++)
                {
                    cActiveEnquiries.Series["ActiveEnquiries"].Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));            //cWorkProgressSummary.Series["WorkProgressSummary"].Points[count].Color = Color.FromName(colorList[count]);

                }


                cActiveEnquiries.Series["ActiveEnquiries"].ChartType = SeriesChartType.Column;


                cActiveEnquiries.Legends.Add(celegneds);


                cActiveEnquiries.Series["ActiveEnquiries"].IsVisibleInLegend = true;
                cActiveEnquiries.Series["ActiveEnquiries"].IsValueShownAsLabel = true;
                cActiveEnquiries.Series["ActiveEnquiries"].ToolTip = "#VALX  - #VALY";

                cActiveEnquiries.Legends["ActiveEnquiries"].LegendStyle = LegendStyle.Table;
                cActiveEnquiries.Legends["ActiveEnquiries"].TableStyle = LegendTableStyle.Wide;
                cActiveEnquiries.Legends["ActiveEnquiries"].Docking = Docking.Bottom;

                cActiveEnquiries.Series[0].YValuesPerPoint = 1;

                cActiveEnquiries.BackColor = Color.AliceBlue;
                cActiveEnquiries.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

                cActiveEnquiries.Titles.Add("Count of Active Enquiries");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadActiveQuotations()
    {
        try
        {
            DataSet dsActiveQuotations = sqlobj.SQLExecuteDataset("SP_IGActiveQuotations");

            if (dsActiveQuotations.Tables[0].Rows.Count > 0)
            {
                lblActiveQuotations.Text = "Active Quotations as of  " + DateTime.Now.ToString(@"dd-MMM-yyyy HH:mm 'Hrs'", new CultureInfo("en-US"));
                // Grid
                //Sample Datatable
                //DataTable dt = new DataTable();
                //dt.Columns.Add("Type");
                //dt.Columns.Add("Count");
                //dt.Rows.Add("<7 days", "17");
                //dt.Rows.Add("<= 30 days", "22");
                //dt.Rows.Add(">30 <= 90 days", "45");
                //dt.Rows.Add(">= 90 days", "29");
                //dt.AcceptChanges();

               // gvActiveQuotations.DataSource = dt;
                gvActiveQuotations.DataSource = dsActiveQuotations;
                gvActiveQuotations.DataBind();
                // color list

                List<string> colorList = new List<string>();
                colorList.Add("Red");
                colorList.Add("Green");
                colorList.Add("Yellow");
                colorList.Add("Purple");
                colorList.Add("Orange");
                colorList.Add("Blue");
                colorList.Add("Brown");
                colorList.Add("Teal");
                colorList.Add("SkyBlue");
                colorList.Add("Flusia");
                colorList.Add("Pink");

               

                //DataTable dtbc = dt;

                DataTable dtbc = dsActiveQuotations.Tables[0];

                Legend celegneds = new Legend("ActiveQuotations");
                ;

                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtbc.Rows.Count];
                int[] YPointMember = new int[dtbc.Rows.Count];

                for (int count = 0; count < dtbc.Rows.Count; count++)
                {
                    cActiveQuotations.Series["ActiveQuotations"].Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
                    //cWorkProgressSummary.Series["WorkProgressSummary"].Points[count].Color = Color.FromName(colorList[count]);
                }
                cActiveQuotations.Series["ActiveQuotations"].ChartType = SeriesChartType.Column;
                cActiveQuotations.Legends.Add(celegneds);

                cActiveQuotations.Series["ActiveQuotations"].IsVisibleInLegend = true;
                cActiveQuotations.Series["ActiveQuotations"].IsValueShownAsLabel = true;
                cActiveQuotations.Series["ActiveQuotations"].ToolTip = "#VALX  - #VALY";

                cActiveQuotations.Legends["ActiveQuotations"].LegendStyle = LegendStyle.Table;
                cActiveQuotations.Legends["ActiveQuotations"].TableStyle = LegendTableStyle.Wide;
                cActiveQuotations.Legends["ActiveQuotations"].Docking = Docking.Bottom;

                cActiveQuotations.Series[0].YValuesPerPoint = 1;

                cActiveQuotations.BackColor = Color.AliceBlue;
                cActiveQuotations.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

                cActiveQuotations.Titles.Add("Count of Active Quotations");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnwpstaff_Click(object sender, EventArgs e)
    {
        try
        {

            if (ddlwpstaff.SelectedItem.Text != "Please Select")
            {

                LoadWorkProgressDetailed();
            }
            else
            {
                gvWorkProgressDetailed.DataSource = null;
                gvWorkProgressDetailed.DataBind();

                WebMsgBox.Show("Please select staff name");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnPDFSales_Click(object sender, EventArgs e)
    {
        //RadWindow2.NavigateUrl = "~/Graphs/SalesPipeline.pdf";
        //RadWindow2.Visible = true;
        string url = string.Format("PDF.aspx?pdf=SalesPipeline.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        BindEnquiriesChart();
        BindQuotationsChart();
    }
    protected void lbtnLeadSource_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=LeadSource.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadLeadSourceSummary();
    }
    protected void lbtnleadsts_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=LeadStatus.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadLeadStatusSummary();
    }
    protected void lbtnleadcategory_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=LeadCategory.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadLeadCategorySummary();
    }
    protected void lbtnleadcam_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=LeadCampaign.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadCampaignSummary();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=OrderBook.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        BindOrderBookChart();
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=BusinessSummary.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        BindBusinessSummaryChart();
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=CategoryWise.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        BindCategorywiseChart();
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=ActiveEnquiry.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadActiveEnquiries();
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=ActiveQuotation.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadActiveQuotations();
    }
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=PInProgress.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadBarChart();
    }
    protected void LinkButton7_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=PCompleted.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadBarChart();
    }
    protected void LinkButton8_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=PMaintenance.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadBarChart();
    }
    protected void LinkButton9_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=CustCampaign.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        CLoadCampaignSummary();
    }
    protected void LinkButton10_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=CustSource.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        CLoadLeadSourceSummary();
    }
    protected void LinkButton11_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=WorkDetailed.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadWorkProgressDetailed();
    }
    protected void LinkButton12_Click(object sender, EventArgs e)
    {
        string url = string.Format("PDF.aspx?pdf=WorkSummary.pdf");
        string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);
        LoadWorkProgressSummary();
    }
    protected void gvGInProgress_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvGInProgress.PageIndex = e.NewPageIndex;
        LoadGeneralDefault();
    }
    protected void gvGCompleted_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvGCompleted.PageIndex = e.NewPageIndex;
        LoadGeneralDefault();
    }
    protected void gvGMaintenance_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvGMaintenance.PageIndex = e.NewPageIndex;
        LoadGeneralDefault();
    }
}