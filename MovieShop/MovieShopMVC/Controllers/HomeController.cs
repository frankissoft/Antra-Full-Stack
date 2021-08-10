using Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using MovieShopMVC.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace MovieShopMVC.Controllers
{
    public class HomeController : Controller
    {
        // private readonly ILogger<HomeController> _logger;

        // public HomeController(ILogger<HomeController> logger)
        private MovieService _movieService;
        public HomeController()
        {
            // _logger = logger;
            _movieService = new MovieService();
        }

        public IActionResult Index()
        {
            // get popular movies and diplay on the view
            var movies = _movieService.GetTopRevenueMovies();
            // 2 ways to pass data from controller to view
            // 1) Strongly typed models***
            // 2) ViewBag
            // 3) ViewData
            // localhost:5000/movies/details/2
            ViewBag.PageTitle = "Top Revenue Movies";
            ViewData["TotalMovies"] = movies.Count();
            return View(movies);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
