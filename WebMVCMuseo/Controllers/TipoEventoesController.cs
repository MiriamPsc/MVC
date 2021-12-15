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
    public class TipoEventoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoEventoes
        public ActionResult Index()
        {
            var tipoEvento = db.TipoEvento.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoEvento.ToList());
        }

        // GET: TipoEventoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEvento tipoEvento = db.TipoEvento.Find(id);
            if (tipoEvento == null)
            {
                return HttpNotFound();
            }
            return View(tipoEvento);
        }

        // GET: TipoEventoes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoEventoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoEvento,nombre,descripcion,organizador,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoEvento tipoEvento)
        {
            if (ModelState.IsValid)
            {
                db.TipoEvento.Add(tipoEvento);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioModifica);
            return View(tipoEvento);
        }

        // GET: TipoEventoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEvento tipoEvento = db.TipoEvento.Find(id);
            if (tipoEvento == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioModifica);
            return View(tipoEvento);
        }

        // POST: TipoEventoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoEvento,nombre,descripcion,organizador,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoEvento tipoEvento)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoEvento).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoEvento.idUsuarioModifica);
            return View(tipoEvento);
        }

        // GET: TipoEventoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoEvento tipoEvento = db.TipoEvento.Find(id);
            if (tipoEvento == null)
            {
                return HttpNotFound();
            }
            return View(tipoEvento);
        }

        // POST: TipoEventoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoEvento tipoEvento = db.TipoEvento.Find(id);
            db.TipoEvento.Remove(tipoEvento);
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
