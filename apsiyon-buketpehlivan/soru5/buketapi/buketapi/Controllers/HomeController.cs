using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RestSharp;

namespace buketapi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        [HttpGet("veriler")]
        public string Veriler()
        {


            var client = new RestClient("https://imdb-api.com/en/API/Top250Movies/k_j20xzao2");
            //var client = new RestClient("https://imdb-api.com/API/Search/k_j20xzao2/" + movieName);
            var request = new RestRequest(Method.GET);
            //request.AddHeader("authorization", "apikey 5dnuknePQ24jHlYyyHRfh3:2NnzUn3RAdx9c6au2WiZ8g");
            request.AddHeader("content-type", "application/json");
            IRestResponse response = client.Execute(request);

            // Ramê yaz content'i

            return response.Content;
        }

    }
}

