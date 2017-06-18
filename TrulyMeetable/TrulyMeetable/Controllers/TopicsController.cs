using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Data.Entity;
using TrulyMeetable;
namespace TrulyMeetable.Controllers
{
    public class TopicsController : Controller
    {
        private TwinTwistEntities1 db = new TwinTwistEntities1();

              //
        // GET: /Topics/
        public ActionResult Running()
        {

            var query = from c in db.Events
                        where c.Topic == "Running"
                        select c;

            return View(query.ToList());
          
        }
        public ActionResult RunLike(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                @event.Likes += 1;
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Running");
            }
            return View(@event);

        }
        public ActionResult TechyLike(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                @event.Likes += 1;
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Techy");
            }
            return View(@event);

        }
        public ActionResult TrekLike(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                @event.Likes += 1;
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Trek");
            }
            return View(@event);

        }
        public ActionResult FoodieLike(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                @event.Likes += 1;
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Foodie");
            }
            return View(@event);

        }
        public ActionResult Techy()
        {
            var query = from c in db.Events
                        where c.Topic == "Techy"
                        select c;

            return View(query.ToList());
        }

        public ActionResult Trek()
        {
            var query = from c in db.Events
                        where c.Topic == "Trek"
                        select c;

            return View(query.ToList());
        }

        public ActionResult Foodie()
        {
            var query = from c in db.Events
                        where c.Topic == "Foodie"
                        select c;

            return View(query.ToList());
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