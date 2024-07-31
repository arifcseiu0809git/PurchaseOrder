using BLL.Service;
using BLL.ServiceInterface;
using DAL.Repository;
using DAL.RepositoryInterface;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace PurchaseOrder
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            DependencyInjectionConfig.ConfigureServices();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }

    public static class DependencyInjectionConfig
    {
        public static ServiceProvider ServiceProvider { get; private set; }

        public static void ConfigureServices()
        {
            var serviceCollection = new ServiceCollection();

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString; 

            serviceCollection.AddSingleton<IPurchaseOrderRepository>(provider => new PurchaseOrderRepository(connectionString));
            serviceCollection.AddSingleton<IPurchaseOrderService>(provider => new PurchaseOrderService(provider.GetRequiredService<IPurchaseOrderRepository>(), connectionString));

            ServiceProvider = serviceCollection.BuildServiceProvider();
        }
    }
}