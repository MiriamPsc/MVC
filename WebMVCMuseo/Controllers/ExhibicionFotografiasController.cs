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
    public class ExhibicionFotografiasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionFotografias
        public ActionResult Index()
        {
            var exhibicionFotografia = db.ExhibicionFotografia.Include(e => e.Exhibicion).Include(e => e.Fotografia).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionFotografia.ToList());
        }

        // GET: ExhibicionFotografias/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionFotografia exhibicionFotografia = db.ExhibicionFotografia.Find(id);
            if (exhibicionFotografia == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionFotografia);
        }

        // GET: ExhibicionFotografias/Create
        public ActionResult Create()
        {
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idFotografia = new SelectList(db.Fotografia, "idFotografia", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionFotografias/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionFotografia,idExhibicion,idFotografia,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionFotografia exhibicionFotografia)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionFotografia.Add(exhibicionFotografia);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionFotografia.idExhibicion);
            ViewBag.idFotografia = new SelectList(db.Fotografia, "idFotografia", "nombre", exhibicionFotografia.idFotografia);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioModifica);
            return View(exhibicionFotografia);
        }

        // GET: ExhibicionFotografias/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionFotografia exhibicionFotografia = db.ExhibicionFotografia.Find(id);
            if (exhibicionFotografia == null)
            {
                return HttpNotFound();
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionFotografia.idExhibicion);
            ViewBag.idFotografia = new SelectList(db.Fotografia, "idFotografia", "nombre", exhibicionFotografia.idFotografia);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioModifica);
            return View(exhibicionFotografia);
        }

        // POST: ExhibicionFotografias/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionFotografia,idExhibicion,idFotografia,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionFotografia exhibicionFotografia)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionFotografia).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionFotografia.idExhibicion);
            ViewBag.idFotografia = new SelectList(db.Fotografia, "idFotografia", "nombre", exhibicionFotografia.idFotografia);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionFotografia.idUsuarioModifica);
            return View(exhibicionFotografia);
        }

        // GET: ExhibicionFotografias/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionFotografia exhibicionFotografia = db.ExhibicionFotografia.Find(id);
            if (exhibicionFotografia == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionFotografia);
        }

        // POST: ExhibicionFotografias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionFotografia exhibicionFotografia = db.ExhibicionFotografia.Find(id);
            db.ExhibicionFotografia.Remove(exhibicionFotografia);
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
