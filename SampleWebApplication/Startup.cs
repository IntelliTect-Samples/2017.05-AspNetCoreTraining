using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace SampleWebApplication
{
    public class Startup
    {
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

           // T Method<T>(Task parameter) { return parameter; }

            app.Run(async (context) =>
            {
                if (context.Request.Path == "/test")
                {
                    // Don't use var unless the data type is very explicit!!
                    var message = $"This is a test of the emergency broadcast system.";
                    if (context.Request.Query.TryGetValue("name",
                        out Microsoft.Extensions.Primitives.StringValues stringValues))
                    {
                        message = $"{stringValues.FirstOrDefault()}: {message}";
                    }
                    await context.Response.WriteAsync(message);
                }
                else
                {
                    await context.Response.WriteAsync("Hello World!");
                }
                
            });
        }
    }
}
