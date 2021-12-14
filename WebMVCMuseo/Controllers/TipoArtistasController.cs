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
    public class TipoArtistasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoArtistas
        public ActionResult Index()
        {
            var tipoArtista = db.TipoArtista.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoArtista.ToList());
        }

        // GET: TipoArtistas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArtista tipoArtista = db.TipoArtista.Find(id);
            if (tipoArtista == null)
            {
                return HttpNotFound();
            }
            return View(tipoArtista);
        }

        // GET: TipoArtistas/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoArtistas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoArtista,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoArtista tipoArtista)
        {
            if (ModelState.IsValid)
            {
                db.TipoArtista.Add(tipoArtista);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioModifica);
            return View(tipoArtista);
        }

        // GET: TipoArtistas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArtista tipoArtista = db.TipoArtista.Find(id);
            if (tipoArtista == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioModifica);
            return View(tipoArtista);
        }

        // POST: TipoArtistas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoArtista,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoArtista tipoArtista)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoArtista).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArtista.idUsuarioModifica);
            return View(tipoArtista);
        }

        // GET: TipoArtistas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArtista tipoArtista = db.TipoArtista.Find(id);
            if (tipoArtista == null)
            {
                return HttpNotFound();
            }
            return View(tipoArtista);
        }

        // POST: TipoArtistas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoArtista tipoArtista = db.TipoArtista.Find(id);
            db.TipoArtista.Remove(tipoArtista);
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
