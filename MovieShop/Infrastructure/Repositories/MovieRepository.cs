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
    }
}
