using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace buketapi.Controllers
{
    public class MovieController : Controller
    {

        #region constants

        const string cacheKey = "movieKey";

        #endregion

        #region fields

        private readonly IMemoryCache _memCache;

        #endregion

        #region ctor

        public MovieController(IMemoryCache memCache)
        {
            _memCache = memCache;
        }

        #endregion

        #region methods

        [HttpGet]
        public ActionResult<IEnumerable<movie>> Get()
        {
            //Movie listemize 2 adet movie set ediyoruz
            List<movie> catList = new List<movie>
                { new movie { id = "tt0111161",rank=1 ,title="The Shawshank Redemption",fullTitle="The Shawshank Redemption (1994)",year="1994",image="https://imdb-api.com/images/original/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_Ratio0.6716_AL_.jpg",crew="Frank Darabont (dir.), Tim Robbins, Morgan Freeman",imDbRating= 9.2 ,imDbRatingCount=2291283, Published = true } };

            //Burada değerin belirtilen key ile cache'de kontrolünü yapıyoruz
            if (!_memCache.TryGetValue(cacheKey, out catList))
            {
                //Burada cache için belirli ayarlamaları yapıyoruz.Cache süresi,önem derecesi gibi
                var cacheExpOptions = new MemoryCacheEntryOptions
                {
                    AbsoluteExpiration = DateTime.Now.AddMinutes(30),
                    Priority = CacheItemPriority.Normal
                };
                //Bu satırda belirlediğimiz key'e göre ve ayarladığımız cache özelliklerine göre kategorilerimizi in-memory olarak cache'liyoruz.
                _memCache.Set(cacheKey, catList, cacheExpOptions);
            }
            return catList;
        }

        
        [HttpGet]
        public ActionResult DeleteCache()
        {
            //Remove ile verilen key'e göre bulunan veriyi siliyoruz
            _memCache.Remove(cacheKey);
            return View();
        }
#endregion
    }
}
