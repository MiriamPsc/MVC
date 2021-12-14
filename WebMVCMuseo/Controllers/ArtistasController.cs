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
    public class ArtistasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Artistas
        public ActionResult Index()
        {
            var artista = db.Artista.Include(a => a.TipoArtista).Include(a => a.Usuario).Include(a => a.Usuario1);
            return View(artista.ToList());
        }

        // GET: Artistas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Artista artista = db.Artista.Find(id);
            if (artista == null)
            {
                return HttpNotFound();
            }
            return View(artista);
        }

        // GET: Artistas/Create
        public ActionResult Create()
        {
            ViewBag.idTipoArtista = new SelectList(db.TipoArtista, "idTipoArtista", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Artistas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idArtista,nombre,apellidoPaterno,apellidoMaterno,ciudad,pais,añoNacimiento,añoMuerte,idTipoArtista,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Artista artista)
        {
            if (ModelState.IsValid)
            {
                db.Artista.Add(artista);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoArtista = new SelectList(db.TipoArtista, "idTipoArtista", "nombre", artista.idTipoArtista);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioModifica);
            return View(artista);
        }

        // GET: Artistas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Artista artista = db.Artista.Find(id);
            if (artista == null)
            {
                return HttpNotFound();
            }
            ViewBag.idTipoArtista = new SelectList(db.TipoArtista, "idTipoArtista", "nombre", artista.idTipoArtista);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioModifica);
            return View(artista);
        }

        // POST: Artistas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idArtista,nombre,apellidoPaterno,apellidoMaterno,ciudad,pais,añoNacimiento,añoMuerte,idTipoArtista,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Artista artista)
        {
            if (ModelState.IsValid)
            {
                db.Entry(artista).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTipoArtista = new SelectList(db.TipoArtista, "idTipoArtista", "nombre", artista.idTipoArtista);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", artista.idUsuarioModifica);
            return View(artista);
        }

        // GET: Artistas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Artista artista = db.Artista.Find(id);
            if (artista == null)
            {
                return HttpNotFound();
            }
            return View(artista);
        }

        // POST: Artistas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Artista artista = db.Artista.Find(id);
            db.Artista.Remove(artista);
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
