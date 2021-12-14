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
    public class FotografiasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Fotografias
        public ActionResult Index()
        {
            var fotografia = db.Fotografia.Include(f => f.Artista).Include(f => f.Clasificacion).Include(f => f.FormatoDeCamara).Include(f => f.Pais).Include(f => f.Usuario).Include(f => f.Usuario1);
            return View(fotografia.ToList());
        }

        // GET: Fotografias/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Fotografia fotografia = db.Fotografia.Find(id);
            if (fotografia == null)
            {
                return HttpNotFound();
            }
            return View(fotografia);
        }

        // GET: Fotografias/Create
        public ActionResult Create()
        {
            ViewBag.idFotografo = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre");
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre");
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Fotografias/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idFotografia,nombre,idFotografo,idFormatoDeCamara,idClasificacion,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Fotografia fotografia)
        {
            if (ModelState.IsValid)
            {
                db.Fotografia.Add(fotografia);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idFotografo = new SelectList(db.Artista, "idArtista", "nombre", fotografia.idFotografo);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", fotografia.idClasificacion);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", fotografia.idFormatoDeCamara);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", fotografia.idPais);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioModifica);
            return View(fotografia);
        }

        // GET: Fotografias/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Fotografia fotografia = db.Fotografia.Find(id);
            if (fotografia == null)
            {
                return HttpNotFound();
            }
            ViewBag.idFotografo = new SelectList(db.Artista, "idArtista", "nombre", fotografia.idFotografo);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", fotografia.idClasificacion);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", fotografia.idFormatoDeCamara);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", fotografia.idPais);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioModifica);
            return View(fotografia);
        }

        // POST: Fotografias/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idFotografia,nombre,idFotografo,idFormatoDeCamara,idClasificacion,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Fotografia fotografia)
        {
            if (ModelState.IsValid)
            {
                db.Entry(fotografia).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idFotografo = new SelectList(db.Artista, "idArtista", "nombre", fotografia.idFotografo);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", fotografia.idClasificacion);
            ViewBag.idFormatoDeCamara = new SelectList(db.FormatoDeCamara, "idFormatoDeCamara", "nombre", fotografia.idFormatoDeCamara);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", fotografia.idPais);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", fotografia.idUsuarioModifica);
            return View(fotografia);
        }

        // GET: Fotografias/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Fotografia fotografia = db.Fotografia.Find(id);
            if (fotografia == null)
            {
                return HttpNotFound();
            }
            return View(fotografia);
        }

        // POST: Fotografias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Fotografia fotografia = db.Fotografia.Find(id);
            db.Fotografia.Remove(fotografia);
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
