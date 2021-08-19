using ApplicationCore.Entities;
using ApplicationCore.RepositoryInterfaces;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Repositories
{
    public class MovieRepository : EFRepository<Movie>, IMovieRepository
    {
        public MovieRepository(MovieShopDbContext dbContext) : base(dbContext)
        {

        }
        public async Task<IEnumerable<Movie>> Get30HighestRevenueMovies()
        {
            // get 30 movies from Movie table, ordered by revenue
            // select top 30 from Movies order by revenue;
            // Execute Linq query: ToList(), Count()
            var movies = await _dbContext.Movies.OrderByDescending(m => m.Revenue).Take(30).ToListAsync();

            return movies;
        }

        public override async Task<Movie> GetByIdAsync(int Id)
        {
            // movie -> genre -> cast -> rating
            // Include() ThenInclude()
            // var movie = await _dbContext.Movies.Include("MovieCasts.Cast").Include("MovieGenres.Genre").FirstOrDefaultAsync(m => m.Id == Id);
            //var movie = await _dbContext.Movies
            //                            .Include(m => m.MovieCasts).ThenInclude(mc => mc.Cast).Include(m => m.MovieGenres)
            //                            .ThenInclude(mg => mg.Genre)
            //                            .FirstOrDefaultAsync(m => m.Id == Id);
            var movie = await _dbContext.Movies.Include(m => m.MovieGenres)
                                        .ThenInclude(m => m.Genre).Include(m => m.MovieCasts).ThenInclude(mc => mc.Cast)
                                        .FirstOrDefaultAsync(m => m.Id == Id);
            //var movie = await _dbContext.Movies.Include(m => m.MovieCasts).ThenInclude(mc => mc.Cast).FirstOrDefaultAsync(m => m.Id == Id);
            //var movie = await _dbContext.Movies.Include(m => m.MovieCasts).ThenInclude(m => m.Cast).Include(m => m.Genres)
            //    .FirstOrDefaultAsync(m => m.Id == Id);
            //var movie = await _dbContext.Movies.FirstOrDefaultAsync(m => m.Id == Id);

            if (movie == null)
            {
                throw new Exception($"No movie Found for the id {Id}");
            }

            var movieRating = await _dbContext.Reviews.Where(m => m.MovieId == Id).DefaultIfEmpty()
                .AverageAsync(r => r == null ? 0 : r.Rating);

            movie.Rating = movieRating;
            return movie;

        }
    }
}
