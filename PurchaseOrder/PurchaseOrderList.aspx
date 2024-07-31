<%@ Page Title="Purchase Order List" Language="C#" MasterPageFile="~/MasterPages/default.master" AutoEventWireup="true" CodeBehind="PurchaseOrderList.aspx.cs" Inherits="PurchaseOrder.PurchaseOrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        div.dataTables_wrapper div.dataTables_length label {
            font-weight: normal;
            text-align: left;
            white-space: nowrap;
            display: none;
        }

        div.dataTables_wrapper div.dataTables_info {
            padding-top: 0.85em;
            white-space: nowrap;
            display: none;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin: 0;
            white-space: nowrap;
            text-align: right;
            display: none;
        }

        .FirstPrevious {
            text-decoration: none;
            color: black;
            background-color: #a9ddf1;
            border-radius: 3px;
            padding: 7px 12px;
            font-size: 15px;
            font-weight: bold;
             /*border:1px solid #2487ad*/
        }

        .NumberCount {
            text-decoration: none;
            color: black;
            background-color: #a9ddf1;
            border-radius: 3px;
            padding: 7px 12px;
             font-size: 15px;
             font-weight: bold;
           /*border:1px solid #2487ad*/
        }

        .theme-orange a {
            color: black !important;
        }

        .theme-orange a.active {
            color: black !important;
        }

         .pager {
             margin-bottom: 25px !important;
         }
         #creatbtn {
             background-color: #33c7ff !important;
             color: black !important;
             padding: 5px;
             font-weight: bolder;
             font-size: 13px;
         } 

         #pageBanner {
             text-align: center;
             background-color: gray;
             color: black;
             margin-bottom: 25px;
             height: 34px;
             border-radius: 4px;
             padding: 5px;
             font-size: 17px;
             font-weight: bolder;
         }


    </style>
    <asp:UpdatePanel ID="lstpanel" runat="server">
        <ContentTemplate>
            <div class="row" runat="server">
                <div class="col-12 col-md-12 col-lg-12">
                    <div class="card col-12 col-md-12 col-lg-12">
                        <div class="card-body">
                            <div class="Content">
                                <div id="pageBanner">
                                    ORDER LIST
                                </div>
                                <div style="text-align: right; margin-bottom: 10px; ">
                                    <input type="button" id="creatbtn" value="Create Order" alt="PurchaseOrderEntry.aspx?keepThis=false&TB_iframe=true&height=570"
                                        class="thickbox btn btn-info" title="Order Add/Edit" />
                                </div>
                                <div class="ListViewStyle">
                                     <asp:ListView ID="lvUserInfo" runat="server" SkinID="ListviewSkin" OnItemCommand="OnItemCommand" DataSourceID="LinqDataSource1" EnableViewState="false">
                                        <LayoutTemplate>
                                            <table class="table table-striped table-bordered table-hover dataTable no-footer" id="save-stage" style="width: 100%;" role="grid" aria-describedby="save-stage_info">
                                                <thead>
                                                    <tr>
                                                        <th>#
                                                        </th>
                                                        <th>REF. ID 
                                                        </th>
                                                        <th>PO NO
                                                        </th>
                                                        <th>PO DATE 
                                                        </th>
                                                        <th>SUPPLIER</th>
                                                        <th>EX.DATE</th>
                                                        <th>Edit</th>
                                                        <th>Delete</th>
                                                        <th>Export</th>
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
                                                <td>
                                                    <%# Eval("RefID")%>&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("PONumber")%>&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("PODate")%>&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("SupplierName")%>&nbsp;
                                                </td>

                                                <td>
                                                    <%#Eval("ExpectedDate")%>&nbsp;
                                                </td>
                                                <td style="text-align: center">
                                                    <a type="button" href="PurchaseOrderEntry.aspx?id= <%#Eval("PurchaseOrderID")%>&mode=edit&TB_iframe=true&height=570"
                                                        class="thickbox" title="Order Add/Edit">Edit</a>
                                                </td>
                                                <td style="text-align: center">
                                                    <a type="button" href="PurchaseOrderEntry.aspx?id= <%#Eval("PurchaseOrderID")%>&mode=delete&TB_iframe=true&height=570"
                                                        class="thickbox" title="Order Add/Edit">Delete</a>
                                                </td>
                                                <td style="text-align: center">
                                                    <asp:LinkButton CommandName="Export" PostBackUrl="~/PurchaseOrderList.aspx" CommandArgument='<%#Eval("PurchaseOrderID")%>' ID="btnExport" runat="server" BackColor="Silver" Text="Export" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                    <asp:LinqDataSource ID="LinqDataSource1" runat="server" AutoSort="False" ContextTypeName="UserInfoPaging"
                                        OnSelecting="LinqDataSource1_Selecting" TableName="users" AutoPage="False">
                                    </asp:LinqDataSource>

                                    <div class="footer">
                                        <asp:Label ID="lblResults" CssClass="gridResults" runat="server" Text="Label"></asp:Label>
                                        <div class="pager" style="margin: 0; white-space: nowrap; text-align: right;">
                                            <asp:DataPager ID="pager" runat="server" PagedControlID="lvUserInfo"
                                                PageSize="3">
                                                <Fields>
                                                    <asp:NextPreviousPagerField ButtonCssClass="PagerButton FirstPrevious" ShowFirstPageButton="true" ShowPreviousPageButton="true" ShowNextPageButton="false" ButtonType="Button" RenderDisabledButtonsAsLabels="true" FirstPageText="First" PreviousPageText="Previous" />
                                                    <asp:NumericPagerField ButtonCount="5" CurrentPageLabelCssClass="pagerCurrent  NumberCount" NumericButtonCssClass="pagerNumeric FirstPrevious" />
                                                    <asp:NextPreviousPagerField ButtonCssClass="PagerButton FirstPrevious" ShowLastPageButton="true" ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonType="Button" LastPageText="Last" NextPageText="Next" RenderDisabledButtonsAsLabels="true" />
                                                </Fields>
                                            </asp:DataPager>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


