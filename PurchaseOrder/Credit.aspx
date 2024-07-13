<%@ Page Language="C#" MasterPageFile="~/MasterPages/default.master" AutoEventWireup="true" CodeFile="Credit.aspx.cs" Inherits="Credit" Title="RF Credit" %>

<%--<%@ Register Src="UserControl/datetimePicker/WebUserControl.ascx" TagName="WebUserControl"
    TagPrefix="uc2" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <uc2:webusercontrol ID="WebUserControl1" runat="server" />
    <script type="text/javascript">
        function refreshWindow() {
            ModifyLeftpanel();

            document.getElementById('<%= btnRefresh.ClientID %>').click();


        }
    </script>

    <asp:UpdatePanel ID="lstpanel" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-12 col-md-12 col-lg-12">
                    <div class="card col-12 col-md-12 col-lg-12">
                        <div class="card-header">
                            <div class="col-md-9">
                                <h4>
                                    <asp:SiteMapPath ID="SiteMapPath1" runat="server" SkinID="NavigationSkinID"></asp:SiteMapPath>
                                </h4>
                            </div>
                            <div class="col-md-3">
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="Content">
                                <%--                        <div class="form-group row">
                            <asp:Label runat="server" Text="Last Updated Events" class="col-sm-4 col-form-label"> </asp:Label>
                        </div>--%>
                                <div class="form-group row">
                                    <asp:Label runat="server" Text="RF Date" class="col-sm-3 col-form-label"> </asp:Label>
                                    <div class="col-sm-3">
                                        <asp:TextBox ID="txtDateFrom" type="date" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <asp:Label runat="server" Text="To" class="col-sm-1 col-form-label"> </asp:Label>
                                    <div class="col-sm-3">
                                        <asp:TextBox ID="txtTo" type="date" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-10">
                                        <asp:Button ID="btnRefresh" runat="server" Style="display: none" OnClick="btnRefresh_Click" />
                                        <asp:Button ID="btnShow" runat="server" Text="Show" CssClass="btn btn-info pull-right" OnClientClick="return refreshWindow();"
                                            OnClick="btnRefresh_Click" />
                                    </div>
                                </div>
                                <br />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="TblList" runat="server">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="ListViewStyle">
                                <asp:ListView ID="lvRFMaster" runat="server"  DataSourceID="LinqDataSource1" EnableViewState="false" >
                                    <LayoutTemplate>
                                        <table class="table table-striped table-bordered table-hover dataTable no-footer" id="save-stage" style="width: 100%;" role="grid" aria-describedby="save-stage_info">
                                            <thead>
                                                <tr>
                                                    <th>#
                                                    </th>
                                                    <th>RF Code
                                                    </th>
                                                    <th>RF Date
                                                    </th>
                                                    <th>RF RAISER
                                                    </th>
                                                    <th>Amount
                                                    </th>
                                                    <th>Credit
                                                    </th>
                                                    <th>Preview
                                                    </th>
                                                    <th>Preview 
                                                    </th>
                                                    <th>Preview
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr id="itemPlaceholder" runat="server" />
                                            </tbody>
                                        </table>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center">
                                                <%# Container.DataItemIndex +1  %>
                                            </td>
                                            <td style="text-align: center">
                                                <%# Eval("RFCODE")%>&nbsp;
                                            </td>
                                            <td style="text-align: center">
                                                <%#Eval("RFDATE","{0:dd-MM-yyyy}")%>&nbsp;
                                            </td>
                                            <td>
                                                <%#Eval("RAISERNAME")%>&nbsp;
                                            </td>

                                            <td style="text-align: right">
                                                <%#Eval("RFTotal", "{0:#,#.00#}")%>&nbsp;
                                            </td>
                                            <td style="text-align: center">
                                                <span class='Visible<%#GetGenerateStatus(Eval("CREDITSTATUS")) %>'>

                                                    <a type="button" href="creditadd.aspx?RFId=<%#Eval("RFID")%>&processFromRF=1&mode=add&TB_iframe=true&height=470"
                                                        class="thickbox" title="Credit Add">Credit</a>
                                                </span>

                                                <span class='Visible<%#GetPreviewStatus(Eval("CREDITSTATUS")) %>'>
                                                    <a type="button" href="creditadd.aspx?Id=<%#Eval("CREDITSTATUS")%>TB_iframe=true&height=470"
                                                        class="thickbox" title="Credit Edit">Edit</a>
                                                </span>
                                                &nbsp;
                                            </td>
                                            <td style="text-align: center">

                                                <span class='Visible<%#GetPreviewStatus(Eval("INVOICESTATUS")) %>'>
                                                    <a type="button" href="rptInvoice.aspx?InvoiceID=<%#Eval("INVOICESTATUS")%>TB_iframe=true&height=530"
                                                        class="thickbox" title="Invoice">Invoice</a>
                                                </span>
                                                &nbsp;
                                            </td>
                                            <td style="text-align: center">
                                                <span class="Visible">
                                                    <a type="button" href="rptRF.aspx?RFID=<%#Eval("RFID")%>TB_iframe=true&height=530"
                                                        class="thickbox" title="RF">RF</a>
                                                </span>
                                            </td>
                                            <td style="text-align: center">
                                                <span class='Visible<%#GetPreviewStatus(Eval("INVOICESTATUS")) %>'>
                                                    <a type="button" href="rptMoneyReceipt.aspx?CreditId=<%#Eval("CREDITSTATUS")%>TB_iframe=true&height=530"
                                                        class="thickbox" title="Invoice">Credit Note</a>
                                                </span>&nbsp;
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:ListView>
                                <asp:LinqDataSource ID="LinqDataSource1" runat="server" AutoSort="False"
                                    ContextTypeName="UserInfoPaging" OnSelecting="LinqDataSource1_Selecting"
                                    TableName="users"
                                    AutoPage="False">
                                </asp:LinqDataSource>
                            </div>
                            <%--<div class="footer" style="display: none">
                                <asp:Label ID="lblResults" CssClass="gridResults" runat="server" Text="Label"></asp:Label>
                                <div class="pager">
                                    <asp:DataPager ID="pager" runat="server" PagedControlID="lvRFMaster" PageSize="20">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonCssClass="PagerButton" ShowFirstPageButton="true"
                                                ShowPreviousPageButton="true" ShowNextPageButton="false" ButtonType="Image" FirstPageImageUrl="~/App_Themes/WhiteOrange/images/first.gif"
                                                RenderDisabledButtonsAsLabels="true" FirstPageText="" PreviousPageText="" PreviousPageImageUrl="~/App_Themes/WhiteOrange/images/prev.gif" />
                                            <asp:NumericPagerField ButtonCount="5" CurrentPageLabelCssClass="pagerCurrent" NumericButtonCssClass="pagerNumeric" />
                                            <asp:NextPreviousPagerField ButtonCssClass="PagerButton" ShowLastPageButton="true"
                                                ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonType="Image" NextPageImageUrl="~/App_Themes/WhiteOrange/images/next.gif"
                                                LastPageImageUrl="~/App_Themes/WhiteOrange/images/last.gif" LastPageText="" NextPageText=""
                                                RenderDisabledButtonsAsLabels="true" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
