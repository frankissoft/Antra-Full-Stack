using ApplicationCore.Models;
using ApplicationCore.RepositoryInterfaces;
using ApplicationCore.ServiceInterfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Services
{
    public class MovieService : IMovieService
    {
        // Call the MovieRepository class
        private readonly IMovieRepository _movieRepository;
        public MovieService(IMovieRepository movieRepository)
        {
            _movieRepository = movieRepository;
        }

        public async Task<MovieDetailsReponseModel> GetMovieDetails(int id)
        {
            var movie = await _movieRepository.GetByIdAsync(id);
            var movieDetailsModel = new MovieDetailsReponseModel
            {
                Id = movie.Id,
                Title = movie.Title,
                ReleaseDate = movie.ReleaseDate,
                RunTime = movie.RunTime,
                Revenue = movie.Revenue,
                Budget = movie.Budget,
                // TODO
            };

            movieDetailsModel.Casts = new List<CastResponseModel>();
            foreach (var cast in movie.MovieCasts)
            {
                movieDetailsModel.Casts.Add(new CastResponseModel 
                { 
                    Id = cast.CastId, 
                    Name = cast.Cast.Name, 
                    Character = cast.Character 
                    //TODO
                });
            }
            movieDetailsModel.Genres = new List<GenreReponseModel>();
            foreach (var genre in movie.Genres)
            {
                movieDetailsModel.Genres.Add(new GenreReponseModel
                {
                    Id = genre.Id,
                    Name = genre.Name
                });
                //TODO
            }
            return movieDetailsModel;
        }

        public Task<MovieDetailsReponseModel> GetMovieDetails()
        {
            throw new NotImplementedException();
        }

        //public async Task<MovieDetailsReponseModel> GetMovieDetails(int id)
        //{
        //    var movie = await _movieRepository.GetByIdAsync(id);
        //    var movieDetailsModel = new MovieDetailsReponseModel
        //    {
        //        Id = movie.Id,
        //        Title = movie.Title,
        //        // TODO
        //    };

        //    movieDetailsModel.Casts = new List<CastResponseModel>();
        //    foreach (var cast in movie.MovieCasts)
        //    {
        //        movieDetailsModel.Casts.Add(new CastResponseModel { Id = cast.CastId, Name = cast.Cast.Name, Character = cast.Character });
        //    }
        //    movieDetailsModel.Genres = new List<GenreReponseModel>();
        //    foreach (var genre in movie.MovieGenres)
        //    {
        //        //TODO
        //    }
        //    {

        //    }
        //}

        public async Task<List<MovieCardResponseModel>> GetTopRevenueMovies()
        {
            // call repositories and retrieve data from database
            //var movies = new List<MovieCardResponseModel>() {
            //    new MovieCardResponseModel { Id = 1, Title = "Avengers: Infinity War", PosterUrl = "" },
            //    new MovieCardResponseModel { Id = 2, Title = "", PosterUrl = "" },
            //    new MovieCardResponseModel { Id = 3, Title = "", PosterUrl = "" },
            //    new MovieCardResponseModel { Id = 4, Title = "", PosterUrl = "" },
            //};
            //var movies = new List<MovieCardResponseModel>()
            //{
            //              new MovieCardResponseModel {Id = 1, Title = "Avengers: Infinity War"},
            //              new MovieCardResponseModel {Id = 2, Title = "Avatar"},
            //              new MovieCardResponseModel {Id = 3, Title = "Star Wars: The Force Awakens"},
            //              new MovieCardResponseModel {Id = 4, Title = "Titanic"},
            //              new MovieCardResponseModel {Id = 5, Title = "Inception"},
            //              new MovieCardResponseModel {Id = 6, Title = "Avengers: Age of Ultron"},
            //              new MovieCardResponseModel {Id = 7, Title = "Interstellar"},
            //              new MovieCardResponseModel {Id = 8, Title = "Fight Club"},
            //              new MovieCardResponseModel {Id = 9, Title = "The Lord of the Rings: The Fellowship of the Ring" }


            //};

            var movies = await _movieRepository.Get30HighestRevenueMovies();
            var movieCards = new List<MovieCardResponseModel>();
            foreach (var movie in movies)
            {
                movieCards.Add(new MovieCardResponseModel { Id = movie.Id, Title = movie.Title, PosterUrl = movie.PosterUrl });
            }

            return movieCards;
            //return movies;
        }
    }
}
