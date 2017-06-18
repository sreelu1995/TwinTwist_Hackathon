using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TrulyMeetable;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using TrulyMeetable.Models;

namespace TrulyMeetable.Controllers
{
    public class EventOperController : Controller
    {
        private TwinTwistEntities1 db = new TwinTwistEntities1();

        // GET: /EventOper/
        public ActionResult Index()
        {
            return View(db.Events.ToList());
        }
        //Intrests

        [HttpGet]

        public ActionResult FindFriends([Bind(Include = "UserName,Interest")] UserInterest @urinterest)
        {
            String a = @urinterest.Interest;
            var query = from c in db.UserInterests
                        where c.Interest == a
                        select c;

            return View(query.ToList());
          
        }
        public ActionResult Wall()
        {
            return View();
        }

        // POST: /EventOper/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Wall([Bind(Include = "UserName,Interest")] UserInterest @urinterest)
        {
                db.UserInterests.Add(@urinterest);
                 //var user = await UserManager.FindAsync(model.UserName, model.Password);
                db.SaveChanges();
                return RedirectToAction("FindFriends", @urinterest);

        }
        //Dummy
        public ActionResult Dummy()
        {
            return View(db.Events.ToList());
        }

        // GET: /EventOper/Details/5
        public ActionResult Details(int? id)
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
            return View(@event);
        }


        // GET: /EventOper/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /EventOper/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="EventId,EventName,Location,DateTime,Topic,Description,Contacts,Likes")] Event @event)
        {
            if (ModelState.IsValid)
            {
                @event.Likes = 0;
                db.Events.Add(@event);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(@event);
        }

        // GET: /EventOper/Edit/5
        public ActionResult Edit(int? id)
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
            return View(@event);
        }

        // POST: /EventOper/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="EventId,EventName,Location,DateTime,Topic,Description,Contacts,Likes")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(@event);
        }

        //Add likes
        public ActionResult Like(int? id)
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
                return RedirectToAction("Index");
            }
            return View(@event);

        }

      /*  public ActionResult Follow(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserFollow @ufollow;
            UserInterest @urintrest = db.UserInterests.Find(id);
            ///extract user and then follow him
            if (@urintrest == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                db.Events.Add
                //db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(@urintrest);

        }*/

        // GET: /EventOper/Delete/5
        public ActionResult Delete(int? id)
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
            return View(@event);
        }

        // POST: /EventOper/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Event @event = db.Events.Find(id);
            db.Events.Remove(@event);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
