using ApplicationCore.ServiceInterfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MovieShopAPI.Controllers
{
    // Attribute routing
    [Route("api/[controller]")]
    public class MoviesController : ControllerBase
    {
        private readonly IMovieService _movieService;
        public MoviesController(IMovieService movieService)
        {
            movieService = _movieService;
        }

        // api/movies/toprevenue
        [Route("toprevenue")]
        [HttpGet]
        public async Task<IActionResult> GetTopRevenueMovies()
        {
            var movies = await _movieService.GetTopRevenueMovies();
            // along with data you also need to return HTTP status code
            if (!movies.Any())
            {
                return NotFound("No Movies Found");
            }
            return Ok(movies);
            // Serialization => object to another type of obejct => C# to JSON
            // C# to XML using XMLSerilizer
            // DeSerialization => JSON to C#
            // .Net Core 3.1 or less = JSON.NET => 3rd party library, icnluded
            // System.Text.JSON =>
        }

        //// api/movies/toprevenue
        //[Route("toprevenue")]
        //[HttpGet]
        //public async Task<IActionResult> GetTopRevenueMovies()
        //{
        //    var movies = await _movieService.GetTopRevenueMovies();
        //    if (!movies.Any())
        //    {
        //        return NotFound("No Movies Found");
        //    }
        //    // 200 ok
        //    return Ok(movies);
        //    // Serialization: object -> object
        //    // .NET Core <= 3.1: JSON.NET
        //}
    }
}
