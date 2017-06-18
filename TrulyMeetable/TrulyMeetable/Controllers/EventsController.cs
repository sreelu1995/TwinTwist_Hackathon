using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TrulyMeetable.Controllers
{
    public class EventsController : Controller
    {
        //
        // GET: /Events/
        public ActionResult Create()
        {
            return View();
        
        }
        public ActionResult All()
        {
            return View();
        }
	}
}