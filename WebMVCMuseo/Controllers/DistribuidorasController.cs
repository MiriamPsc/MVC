using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebMVCMuseo;

namespace WebMVCMuseo.Controllers
{
    public class DistribuidorasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Distribuidoras
        public ActionResult Index()
        {
            var distribuidora = db.Distribuidora.Include(d => d.Usuario).Include(d => d.Usuario1);
            return View(distribuidora.ToList());
        }

        // GET: Distribuidoras/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Distribuidora distribuidora = db.Distribuidora.Find(id);
            if (distribuidora == null)
            {
                return HttpNotFound();
            }
            return View(distribuidora);
        }

        // GET: Distribuidoras/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Distribuidoras/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idDistribuidora,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Distribuidora distribuidora)
        {
            if (ModelState.IsValid)
            {
                db.Distribuidora.Add(distribuidora);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioModifica);
            return View(distribuidora);
        }

        // GET: Distribuidoras/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Distribuidora distribuidora = db.Distribuidora.Find(id);
            if (distribuidora == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioModifica);
            return View(distribuidora);
        }

        // POST: Distribuidoras/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idDistribuidora,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Distribuidora distribuidora)
        {
            if (ModelState.IsValid)
            {
                db.Entry(distribuidora).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", distribuidora.idUsuarioModifica);
            return View(distribuidora);
        }

        // GET: Distribuidoras/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Distribuidora distribuidora = db.Distribuidora.Find(id);
            if (distribuidora == null)
            {
                return HttpNotFound();
            }
            return View(distribuidora);
        }

        // POST: Distribuidoras/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Distribuidora distribuidora = db.Distribuidora.Find(id);
            db.Distribuidora.Remove(distribuidora);
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
