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
    public class CorrienteArtisticasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: CorrienteArtisticas
        public ActionResult Index()
        {
            var corrienteArtistica = db.CorrienteArtistica.Include(c => c.Usuario).Include(c => c.Usuario1);
            return View(corrienteArtistica.ToList());
        }

        // GET: CorrienteArtisticas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CorrienteArtistica corrienteArtistica = db.CorrienteArtistica.Find(id);
            if (corrienteArtistica == null)
            {
                return HttpNotFound();
            }
            return View(corrienteArtistica);
        }

        // GET: CorrienteArtisticas/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: CorrienteArtisticas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idCorrienteArtistica,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] CorrienteArtistica corrienteArtistica)
        {
            if (ModelState.IsValid)
            {
                db.CorrienteArtistica.Add(corrienteArtistica);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioModifica);
            return View(corrienteArtistica);
        }

        // GET: CorrienteArtisticas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CorrienteArtistica corrienteArtistica = db.CorrienteArtistica.Find(id);
            if (corrienteArtistica == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioModifica);
            return View(corrienteArtistica);
        }

        // POST: CorrienteArtisticas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idCorrienteArtistica,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] CorrienteArtistica corrienteArtistica)
        {
            if (ModelState.IsValid)
            {
                db.Entry(corrienteArtistica).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", corrienteArtistica.idUsuarioModifica);
            return View(corrienteArtistica);
        }

        // GET: CorrienteArtisticas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CorrienteArtistica corrienteArtistica = db.CorrienteArtistica.Find(id);
            if (corrienteArtistica == null)
            {
                return HttpNotFound();
            }
            return View(corrienteArtistica);
        }

        // POST: CorrienteArtisticas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CorrienteArtistica corrienteArtistica = db.CorrienteArtistica.Find(id);
            db.CorrienteArtistica.Remove(corrienteArtistica);
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
