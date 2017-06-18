using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TrulyMeetable.Controllers
{
    public class HomeController : Controller
    {
        public TwinTwistEntities1 db = new TwinTwistEntities1();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {

            return View();
        }

        public ActionResult Contact()
        {

            return View();
        }

        public ActionResult Calendar(DateTime data)
        {

            var query = from c in db.Events
                        where c.DateTime >= data
                        select c;

            return View(data);
        }
    }
}