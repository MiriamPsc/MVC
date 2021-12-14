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
    public class ArtistaEscuelasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ArtistaEscuelas
        public ActionResult Index()
        {
            var artistaEscuela = db.ArtistaEscuela.Include(a => a.Artista).Include(a => a.Escuela);
            return View(artistaEscuela.ToList());
        }

        // GET: ArtistaEscuelas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArtistaEscuela artistaEscuela = db.ArtistaEscuela.Find(id);
            if (artistaEscuela == null)
            {
                return HttpNotFound();
            }
            return View(artistaEscuela);
        }

        // GET: ArtistaEscuelas/Create
        public ActionResult Create()
        {
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idEscuela = new SelectList(db.Escuela, "idEscuela", "nombre");
            return View();
        }

        // POST: ArtistaEscuelas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idArtistaEscuela,idArtista,idEscuela,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ArtistaEscuela artistaEscuela)
        {
            if (ModelState.IsValid)
            {
                db.ArtistaEscuela.Add(artistaEscuela);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", artistaEscuela.idArtista);
            ViewBag.idEscuela = new SelectList(db.Escuela, "idEscuela", "nombre", artistaEscuela.idEscuela);
            return View(artistaEscuela);
        }

        // GET: ArtistaEscuelas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArtistaEscuela artistaEscuela = db.ArtistaEscuela.Find(id);
            if (artistaEscuela == null)
            {
                return HttpNotFound();
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", artistaEscuela.idArtista);
            ViewBag.idEscuela = new SelectList(db.Escuela, "idEscuela", "nombre", artistaEscuela.idEscuela);
            return View(artistaEscuela);
        }

        // POST: ArtistaEscuelas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idArtistaEscuela,idArtista,idEscuela,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ArtistaEscuela artistaEscuela)
        {
            if (ModelState.IsValid)
            {
                db.Entry(artistaEscuela).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", artistaEscuela.idArtista);
            ViewBag.idEscuela = new SelectList(db.Escuela, "idEscuela", "nombre", artistaEscuela.idEscuela);
            return View(artistaEscuela);
        }

        // GET: ArtistaEscuelas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArtistaEscuela artistaEscuela = db.ArtistaEscuela.Find(id);
            if (artistaEscuela == null)
            {
                return HttpNotFound();
            }
            return View(artistaEscuela);
        }

        // POST: ArtistaEscuelas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ArtistaEscuela artistaEscuela = db.ArtistaEscuela.Find(id);
            db.ArtistaEscuela.Remove(artistaEscuela);
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
