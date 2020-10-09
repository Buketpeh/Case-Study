using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace buketapi
{
    public class movie
    {
        public string id { get; set; }
        public int rank { get; set; }
        public string title { get; set; }
        public string fullTitle { get; set; }
        public string year { get; set; }
        public string image { get; set; }
        public string crew { get; set; }
        public double imDbRating { get; set; }
        public int imDbRatingCount { get; set; }

        public bool Published { get; set; }
    }
}
