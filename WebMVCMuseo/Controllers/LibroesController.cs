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
    public class LibroesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Libroes
        public ActionResult Index()
        {
            var libro = db.Libro.Include(l => l.Artista).Include(l => l.Clasificacion).Include(l => l.Editorial).Include(l => l.Idioma).Include(l => l.Pais).Include(l => l.TipoEdicion).Include(l => l.Usuario).Include(l => l.Usuario1);
            return View(libro.ToList());
        }

        // GET: Libroes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Libro libro = db.Libro.Find(id);
            if (libro == null)
            {
                return HttpNotFound();
            }
            return View(libro);
        }

        // GET: Libroes/Create
        public ActionResult Create()
        {
            ViewBag.idAutor = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre");
            ViewBag.idEditorial = new SelectList(db.Editorial, "idEditorial", "nombre");
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre");
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idTipoEdicion = new SelectList(db.TipoEdicion, "idTipoEdicion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Libroes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idLibro,nombre,año,idAutor,idTipoEdicion,idEditorial,idClasificacion,idIdioma,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Libro libro)
        {
            if (ModelState.IsValid)
            {
                db.Libro.Add(libro);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idAutor = new SelectList(db.Artista, "idArtista", "nombre", libro.idAutor);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", libro.idClasificacion);
            ViewBag.idEditorial = new SelectList(db.Editorial, "idEditorial", "nombre", libro.idEditorial);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", libro.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", libro.idPais);
            ViewBag.idTipoEdicion = new SelectList(db.TipoEdicion, "idTipoEdicion", "nombre", libro.idTipoEdicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioModifica);
            return View(libro);
        }

        // GET: Libroes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Libro libro = db.Libro.Find(id);
            if (libro == null)
            {
                return HttpNotFound();
            }
            ViewBag.idAutor = new SelectList(db.Artista, "idArtista", "nombre", libro.idAutor);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", libro.idClasificacion);
            ViewBag.idEditorial = new SelectList(db.Editorial, "idEditorial", "nombre", libro.idEditorial);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", libro.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", libro.idPais);
            ViewBag.idTipoEdicion = new SelectList(db.TipoEdicion, "idTipoEdicion", "nombre", libro.idTipoEdicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioModifica);
            return View(libro);
        }

        // POST: Libroes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idLibro,nombre,año,idAutor,idTipoEdicion,idEditorial,idClasificacion,idIdioma,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Libro libro)
        {
            if (ModelState.IsValid)
            {
                db.Entry(libro).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idAutor = new SelectList(db.Artista, "idArtista", "nombre", libro.idAutor);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", libro.idClasificacion);
            ViewBag.idEditorial = new SelectList(db.Editorial, "idEditorial", "nombre", libro.idEditorial);
            ViewBag.idIdioma = new SelectList(db.Idioma, "idIdioma", "nombre", libro.idIdioma);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", libro.idPais);
            ViewBag.idTipoEdicion = new SelectList(db.TipoEdicion, "idTipoEdicion", "nombre", libro.idTipoEdicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", libro.idUsuarioModifica);
            return View(libro);
        }

        // GET: Libroes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Libro libro = db.Libro.Find(id);
            if (libro == null)
            {
                return HttpNotFound();
            }
            return View(libro);
        }

        // POST: Libroes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Libro libro = db.Libro.Find(id);
            db.Libro.Remove(libro);
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
