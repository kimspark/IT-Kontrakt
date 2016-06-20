using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace DeleteMesssage.Models
{
    public class MessageContext : DbContext
    {
        public DbSet<Message> Messages { get; set; }
    }
}