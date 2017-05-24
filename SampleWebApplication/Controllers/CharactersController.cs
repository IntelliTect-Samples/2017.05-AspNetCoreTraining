using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace SampleWebApplication.Controllers
{
    // NOTE: Base Controller for both Web Controller and Web API are the same type.
    //       Additionally, no Web API route config is required.
    [Route("api/[controller]")]
    public class CharactersController : Controller
    {
        public static string[] Characters { get; } =
            {"Princess Buttercup", "Inigo Montoya", "Vizinni"};

        // GET: api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return Characters;
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return (id >= 0 && id < Characters.Length)? Characters[id] : "Invalid";
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
