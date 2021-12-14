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
    public class PeliculasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Peliculas
        public ActionResult Index()
        {
            var pelicula = db.Pelicula.Include(p => p.Artista).Include(p => p.Clasificacion).Include(p => p.Distribuidora).Include(p => p.FormatoDeCamara).Include(p => p.Idioma).Include(p => p.Pais).Include(p => p.Productora).Include(p => p.Usuario).Include(p => p.Usuario1);
            return View(pelicula.ToList());
        }

        // GET: Peliculas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pelicula pelicula = db.Pelicula.Find(id);
            if (pelicula == null)
            {
                return HttpNotFound();
            }
            return View(pelicula);
        }

        // GET: Peliculas/Create
        public ActionResult Create()
        {
            ViewBag.idDirector = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre");
            ViewBag.idDistribuidora = new SelectList(db.Distribuidora, "idDistribuidora", "nombre");
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre");
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre");
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idProductora = new SelectList(db.Productora, "idProductora", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Peliculas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idPelicula,nombre,año,duracion,tipo,idDirector,idFormatoDeCamara,idClasificacion,idIdioma,idPais,idDistribuidora,idProductora,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Pelicula pelicula)
        {
            if (ModelState.IsValid)
            {
                db.Pelicula.Add(pelicula);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idDirector = new SelectList(db.Artista, "idArtista", "nombre", pelicula.idDirector);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pelicula.idClasificacion);
            ViewBag.idDistribuidora = new SelectList(db.Distribuidora, "idDistribuidora", "nombre", pelicula.idDistribuidora);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", pelicula.idFormatoDeCamara);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", pelicula.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pelicula.idPais);
            ViewBag.idProductora = new SelectList(db.Productora, "idProductora", "nombre", pelicula.idProductora);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioModifica);
            return View(pelicula);
        }

        // GET: Peliculas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pelicula pelicula = db.Pelicula.Find(id);
            if (pelicula == null)
            {
                return HttpNotFound();
            }
            ViewBag.idDirector = new SelectList(db.Artista, "idArtista", "nombre", pelicula.idDirector);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pelicula.idClasificacion);
            ViewBag.idDistribuidora = new SelectList(db.Distribuidora, "idDistribuidora", "nombre", pelicula.idDistribuidora);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", pelicula.idFormatoDeCamara);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", pelicula.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pelicula.idPais);
            ViewBag.idProductora = new SelectList(db.Productora, "idProductora", "nombre", pelicula.idProductora);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioModifica);
            return View(pelicula);
        }

        // POST: Peliculas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idPelicula,nombre,año,duracion,tipo,idDirector,idFormatoDeCamara,idClasificacion,idIdioma,idPais,idDistribuidora,idProductora,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Pelicula pelicula)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pelicula).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idDirector = new SelectList(db.Artista, "idArtista", "nombre", pelicula.idDirector);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pelicula.idClasificacion);
            ViewBag.idDistribuidora = new SelectList(db.Distribuidora, "idDistribuidora", "nombre", pelicula.idDistribuidora);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", pelicula.idFormatoDeCamara);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", pelicula.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pelicula.idPais);
            ViewBag.idProductora = new SelectList(db.Productora, "idProductora", "nombre", pelicula.idProductora);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pelicula.idUsuarioModifica);
            return View(pelicula);
        }

        // GET: Peliculas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pelicula pelicula = db.Pelicula.Find(id);
            if (pelicula == null)
            {
                return HttpNotFound();
            }
            return View(pelicula);
        }

        // POST: Peliculas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pelicula pelicula = db.Pelicula.Find(id);
            db.Pelicula.Remove(pelicula);
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
