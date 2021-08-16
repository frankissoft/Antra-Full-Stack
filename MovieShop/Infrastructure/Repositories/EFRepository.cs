﻿using ApplicationCore.RepositoryInterfaces;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Repositories
{
    public class EFRepository<T> : IAsyncRepository<T> where T : class
    {
        protected readonly MovieShopDbContext _dbContext;

        public EFRepository(MovieShopDbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public Task<T> AddAsync(T entity)
        {
            throw new NotImplementedException();
        }

        public Task<T> DeleteAsync(T entity)
        {
            throw new NotImplementedException();
        }

        public virtual async Task<T> GetByIdAsync(int id)
        {
            var entity = await _dbContext.Set<T>().FindAsync(id);
            return entity;
        }

        public virtual async Task<int> GetCountAsync(Expression<Func<T, bool>> filter = null)
        {
            var data = await _dbContext.Set<T>().Where(filter).CountAsync();
            return data;
        }

        public virtual async Task<bool> GetExistsAsync(Expression<Func<T, bool>> filter = null)
        {
            var data = await _dbContext.Set<T>().Where(filter).AnyAsync();
            return data;
        }

        public virtual async Task<IEnumerable<T>> ListAllAsync()
        {
            var data = await _dbContext.Set<T>().ToListAsync();
            return data;
        }

        public virtual async Task<IEnumerable<T>> ListAsync(Expression<Func<T, bool>> filter)
        {
            var data = await _dbContext.Set<T>().Where(filter).ToListAsync();
            return data;
        }

        public Task<T> UpdateAsync(T enitity)
        {
            throw new NotImplementedException();
        }
    }
}
