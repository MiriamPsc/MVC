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
    public class ClasificacionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Clasificacions
        public ActionResult Index()
        {
            var clasificacion = db.Clasificacion.Include(c => c.Usuario).Include(c => c.Usuario1);
            return View(clasificacion.ToList());
        }

        // GET: Clasificacions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Clasificacion clasificacion = db.Clasificacion.Find(id);
            if (clasificacion == null)
            {
                return HttpNotFound();
            }
            return View(clasificacion);
        }

        // GET: Clasificacions/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Clasificacions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idClasificacion,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Clasificacion clasificacion)
        {
            if (ModelState.IsValid)
            {
                db.Clasificacion.Add(clasificacion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioModifica);
            return View(clasificacion);
        }

        // GET: Clasificacions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Clasificacion clasificacion = db.Clasificacion.Find(id);
            if (clasificacion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioModifica);
            return View(clasificacion);
        }

        // POST: Clasificacions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idClasificacion,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Clasificacion clasificacion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(clasificacion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", clasificacion.idUsuarioModifica);
            return View(clasificacion);
        }

        // GET: Clasificacions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Clasificacion clasificacion = db.Clasificacion.Find(id);
            if (clasificacion == null)
            {
                return HttpNotFound();
            }
            return View(clasificacion);
        }

        // POST: Clasificacions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Clasificacion clasificacion = db.Clasificacion.Find(id);
            db.Clasificacion.Remove(clasificacion);
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
