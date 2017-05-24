using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace SampleWebApplication.Controllers
{
    public class HomeController : Controller
    {
        public HomeController(IOptions<Messages> options)
        {
            Messages = options.Value;
        }

        // GET: /<controller>/
        public IActionResult Index(string name)
        {
            ViewBag.Name = name??"Inigo Montoya";
            return View();
        }

        public Messages Messages { get; set; }

        public IActionResult About()
        {
            ViewBag.AboutMessage = Messages.AboutText;
            return View();
        }
    }
}
