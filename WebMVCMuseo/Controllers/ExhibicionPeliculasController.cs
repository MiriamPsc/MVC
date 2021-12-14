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
    public class ExhibicionPeliculasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionPeliculas
        public ActionResult Index()
        {
            var exhibicionPelicula = db.ExhibicionPelicula.Include(e => e.Exhibicion).Include(e => e.Pelicula).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionPelicula.ToList());
        }

        // GET: ExhibicionPeliculas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPelicula exhibicionPelicula = db.ExhibicionPelicula.Find(id);
            if (exhibicionPelicula == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionPelicula);
        }

        // GET: ExhibicionPeliculas/Create
        public ActionResult Create()
        {
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idPelicula = new SelectList(db.Pelicula, "idPelicula", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionPeliculas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionPelicula,idExhibicion,idPelicula,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionPelicula exhibicionPelicula)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionPelicula.Add(exhibicionPelicula);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPelicula.idExhibicion);
            ViewBag.idPelicula = new SelectList(db.Pelicula, "idPelicula", "nombre", exhibicionPelicula.idPelicula);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioModifica);
            return View(exhibicionPelicula);
        }

        // GET: ExhibicionPeliculas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPelicula exhibicionPelicula = db.ExhibicionPelicula.Find(id);
            if (exhibicionPelicula == null)
            {
                return HttpNotFound();
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPelicula.idExhibicion);
            ViewBag.idPelicula = new SelectList(db.Pelicula, "idPelicula", "nombre", exhibicionPelicula.idPelicula);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioModifica);
            return View(exhibicionPelicula);
        }

        // POST: ExhibicionPeliculas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionPelicula,idExhibicion,idPelicula,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionPelicula exhibicionPelicula)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionPelicula).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPelicula.idExhibicion);
            ViewBag.idPelicula = new SelectList(db.Pelicula, "idPelicula", "nombre", exhibicionPelicula.idPelicula);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPelicula.idUsuarioModifica);
            return View(exhibicionPelicula);
        }

        // GET: ExhibicionPeliculas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPelicula exhibicionPelicula = db.ExhibicionPelicula.Find(id);
            if (exhibicionPelicula == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionPelicula);
        }

        // POST: ExhibicionPeliculas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionPelicula exhibicionPelicula = db.ExhibicionPelicula.Find(id);
            db.ExhibicionPelicula.Remove(exhibicionPelicula);
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
