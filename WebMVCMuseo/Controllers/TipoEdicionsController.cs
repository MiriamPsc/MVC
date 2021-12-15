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
    public class TipoEdicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoEdicions
        public ActionResult Index()
        {
            var tipoEdicion = db.TipoEdicion.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoEdicion.ToList());
        }

        // GET: TipoEdicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEdicion tipoEdicion = db.TipoEdicion.Find(id);
            if (tipoEdicion == null)
            {
                return HttpNotFound();
            }
            return View(tipoEdicion);
        }

        // GET: TipoEdicions/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoEdicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoEdicion,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoEdicion tipoEdicion)
        {
            if (ModelState.IsValid)
            {
                db.TipoEdicion.Add(tipoEdicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioModifica);
            return View(tipoEdicion);
        }

        // GET: TipoEdicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEdicion tipoEdicion = db.TipoEdicion.Find(id);
            if (tipoEdicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioModifica);
            return View(tipoEdicion);
        }

        // POST: TipoEdicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoEdicion,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoEdicion tipoEdicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoEdicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEdicion.idUsuarioModifica);
            return View(tipoEdicion);
        }

        // GET: TipoEdicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEdicion tipoEdicion = db.TipoEdicion.Find(id);
            if (tipoEdicion == null)
            {
                return HttpNotFound();
            }
            return View(tipoEdicion);
        }

        // POST: TipoEdicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoEdicion tipoEdicion = db.TipoEdicion.Find(id);
            db.TipoEdicion.Remove(tipoEdicion);
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
