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
    public class TallersController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Tallers
        public ActionResult Index()
        {
            var taller = db.Taller.Include(t => t.TipoTaller).Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(taller.ToList());
        }

        // GET: Tallers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Taller taller = db.Taller.Find(id);
            if (taller == null)
            {
                return HttpNotFound();
            }
            return View(taller);
        }

        // GET: Tallers/Create
        public ActionResult Create()
        {
            ViewBag.idTipoTaller = new SelectList(db.TipoTaller, "idTipoTaller", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Tallers/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTaller,nombre,descripcion,fechaInicio,fechaFinal,idTipoTaller,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Taller taller)
        {
            if (ModelState.IsValid)
            {
                db.Taller.Add(taller);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoTaller = new SelectList(db.TipoTaller, "idTipoTaller", "nombre", taller.idTipoTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioModifica);
            return View(taller);
        }

        // GET: Tallers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Taller taller = db.Taller.Find(id);
            if (taller == null)
            {
                return HttpNotFound();
            }
            ViewBag.idTipoTaller = new SelectList(db.TipoTaller, "idTipoTaller", "nombre", taller.idTipoTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioModifica);
            return View(taller);
        }

        // POST: Tallers/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTaller,nombre,descripcion,fechaInicio,fechaFinal,idTipoTaller,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Taller taller)
        {
            if (ModelState.IsValid)
            {
                db.Entry(taller).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTipoTaller = new SelectList(db.TipoTaller, "idTipoTaller", "nombre", taller.idTipoTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", taller.idUsuarioModifica);
            return View(taller);
        }

        // GET: Tallers/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Taller taller = db.Taller.Find(id);
            if (taller == null)
            {
                return HttpNotFound();
            }
            return View(taller);
        }

        // POST: Tallers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Taller taller = db.Taller.Find(id);
            db.Taller.Remove(taller);
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
