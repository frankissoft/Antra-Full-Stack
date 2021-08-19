﻿using ApplicationCore.Entities;
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
    public class UserRepository : EFRepository<User>, IUserRepository
    {
        public UserRepository(MovieShopDbContext dbContext) : base(dbContext)
        {

        }
        public async Task<User> GetUserByEmail(string email)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Email == email);
            return user;
        }

        public async Task<User> GetUserFavoriteById(int id)
        {
            var favorites = await _dbContext.Users.Include(u => u.Favorites).ThenInclude(u => u.Movie).FirstOrDefaultAsync(u => u.Id == id);
            return favorites;
        }

        public async Task<User> GetUserPurchaseById(int id)
        {
            var purchases = await _dbContext.Users.Include(u => u.Purchases).ThenInclude(u => u.Movie).FirstOrDefaultAsync(u => u.Id == id);
            return purchases;
        }
    }
}
