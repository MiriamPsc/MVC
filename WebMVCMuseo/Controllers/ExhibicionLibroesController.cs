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
    public class ExhibicionLibroesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionLibroes
        public ActionResult Index()
        {
            var exhibicionLibro = db.ExhibicionLibro.Include(e => e.Exhibicion).Include(e => e.Libro).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionLibro.ToList());
        }

        // GET: ExhibicionLibroes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionLibro exhibicionLibro = db.ExhibicionLibro.Find(id);
            if (exhibicionLibro == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionLibro);
        }

        // GET: ExhibicionLibroes/Create
        public ActionResult Create()
        {
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idLibro = new SelectList(db.Libro, "idLibro", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionLibroes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionLibro,idExhibicion,idLibro,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionLibro exhibicionLibro)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionLibro.Add(exhibicionLibro);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionLibro.idExhibicion);
            ViewBag.idLibro = new SelectList(db.Libro, "idLibro", "nombre", exhibicionLibro.idLibro);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioModifica);
            return View(exhibicionLibro);
        }

        // GET: ExhibicionLibroes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionLibro exhibicionLibro = db.ExhibicionLibro.Find(id);
            if (exhibicionLibro == null)
            {
                return HttpNotFound();
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionLibro.idExhibicion);
            ViewBag.idLibro = new SelectList(db.Libro, "idLibro", "nombre", exhibicionLibro.idLibro);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioModifica);
            return View(exhibicionLibro);
        }

        // POST: ExhibicionLibroes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionLibro,idExhibicion,idLibro,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionLibro exhibicionLibro)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionLibro).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionLibro.idExhibicion);
            ViewBag.idLibro = new SelectList(db.Libro, "idLibro", "nombre", exhibicionLibro.idLibro);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionLibro.idUsuarioModifica);
            return View(exhibicionLibro);
        }

        // GET: ExhibicionLibroes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionLibro exhibicionLibro = db.ExhibicionLibro.Find(id);
            if (exhibicionLibro == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionLibro);
        }

        // POST: ExhibicionLibroes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionLibro exhibicionLibro = db.ExhibicionLibro.Find(id);
            db.ExhibicionLibro.Remove(exhibicionLibro);
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
