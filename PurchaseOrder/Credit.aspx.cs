using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Threading;
using System.Globalization;

public partial class Credit : System.Web.UI.Page
{
    protected string sortExpression
    {
        get
        {
            return ViewState["sortExpression"].ToString();
        }
        set
        {
            ViewState["sortExpression"] = value;
        }
    }
    protected SortDirection sortDirection
    {
        get
        {
            return (SortDirection)ViewState["sortDirection"];
        }
        set
        {
            ViewState["sortDirection"] = value;
        }
    }
    protected int rowCount
    {
        get
        {
            return (int)ViewState["rowCount"];
        }
        set
        {
            ViewState["rowCount"] = value;
        }
    }


    protected POS.DAL.RFMain searchInfo
    {
        get
        {
            return (POS.DAL.RFMain)ViewState["searchInfo"];
        }
        set
        {
            ViewState["searchInfo"] = value;
        }
    }





    protected char GetPreviewStatus(Object val)
    {
        if (val == null || val.ToString().Length == 0)
        {
            return 'N';
        }

        return 'Y';

    }
    protected char GetGenerateStatus(Object val)
    {
        if (val == null || val.ToString().Length == 0)
        {
            return 'Y';
        }

        return 'N';

    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (!Permissions.Credit)
            {
                MsgUtility.showNotPermittedMsg(this.Page);
                return;
            }

            sortExpression = "RFCODE";
            sortDirection = SortDirection.Ascending;
            searchInfo = new POS.DAL.RFMain();

            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-GB");
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("en-GB");

            txtTo.Text = txtDateFrom.Text = DateTime.Today.ToString("yyyy-MM-dd");

            rowCount = 0;
            


            btnRefresh_Click(null, null);

        }

    }


    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        searchInfo.RFID = -1;
        try
        {
            searchInfo.STARTRFDATE = Convert.ToDateTime(txtDateFrom.Text.Trim());
        }
        catch { searchInfo.STARTRFDATE = DateTime.MinValue; }
        try
        {
            searchInfo.ENDRFDATE = Convert.ToDateTime(txtTo.Text.Trim());
        }
        catch { searchInfo.ENDRFDATE = DateTime.MinValue; }
        searchInfo.CENTERID = Common.CurrentCenterId;
        searchInfo.PAYMENTTYPE = 2;
        //searchInfo.AdjustmentSTATUS = "N";
        using (RFServices.Service1 service = new RFServices.Service1())
        {
            rowCount = service.RFMasterGetCount(searchInfo);
        }
        
        TblList.Visible = rowCount > 0 ? true : false;
         
    }





    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        POS.DAL.RFMain[] list = new POS.DAL.RFMain[0];
        e.Arguments.RetrieveTotalRowCount = false;

        if (rowCount > 0)
        {
            using (RFServices.Service1 service = new RFServices.Service1())
            {
                list = service.RFMasterGet(searchInfo, 1, int.MaxValue, sortExpression, sortDirection == SortDirection.Ascending ? "ASC" : "DESC").ToArray();
            }
        }
        e.Arguments.TotalRowCount = rowCount;
        e.Result = list;


    }
    protected void lvRFMaster_Sorting(object sender, ListViewSortEventArgs e)
    {
        if (e.SortExpression == sortExpression)
        {
            if (sortDirection == SortDirection.Ascending)
            {
                sortDirection = SortDirection.Descending;
            }
            else
            {
                sortDirection = SortDirection.Ascending;
            }
        }
        else
        {
            sortDirection = SortDirection.Ascending;

        }
        sortExpression = e.SortExpression;


    }

}
