using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Globalization;
using System.Threading;

public partial class MasterPages_default : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-GB");
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("en-GB");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "init", "initialize();setWindowSize();", true);
        if (!IsPostBack)
        {
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        ScriptManager.RegisterStartupScript(Page, GetType(), "disp_confirm", "<script>$(document).ready(function () { $('#save-stage').DataTable({ stateSave: false }); });</script>", false);
    }
}
