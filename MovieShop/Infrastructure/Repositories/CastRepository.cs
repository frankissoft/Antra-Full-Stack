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
    public class CastRepository : EFRepository<Cast>, ICastRepository
    {
        public CastRepository(MovieShopDbContext dbContext) : base(dbContext)
        {

        }

        public override async Task<Cast> GetByIdAsync(int Id)
        {
            var cast = await _dbContext.Casts.FirstOrDefaultAsync(c => c.Id == Id);
            if (cast == null)
            {
                throw new Exception($"No cast Found for the id {Id}");
            }
            return cast;
        }
    }
}
