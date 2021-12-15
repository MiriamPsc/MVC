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
    public class TipoTiendasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoTiendas
        public ActionResult Index()
        {
            var tipoTienda = db.TipoTienda.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoTienda.ToList());
        }

        // GET: TipoTiendas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTienda tipoTienda = db.TipoTienda.Find(id);
            if (tipoTienda == null)
            {
                return HttpNotFound();
            }
            return View(tipoTienda);
        }

        // GET: TipoTiendas/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoTiendas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoTienda,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoTienda tipoTienda)
        {
            if (ModelState.IsValid)
            {
                db.TipoTienda.Add(tipoTienda);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioModifica);
            return View(tipoTienda);
        }

        // GET: TipoTiendas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTienda tipoTienda = db.TipoTienda.Find(id);
            if (tipoTienda == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioModifica);
            return View(tipoTienda);
        }

        // POST: TipoTiendas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoTienda,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoTienda tipoTienda)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoTienda).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTienda.idUsuarioModifica);
            return View(tipoTienda);
        }

        // GET: TipoTiendas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTienda tipoTienda = db.TipoTienda.Find(id);
            if (tipoTienda == null)
            {
                return HttpNotFound();
            }
            return View(tipoTienda);
        }

        // POST: TipoTiendas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoTienda tipoTienda = db.TipoTienda.Find(id);
            db.TipoTienda.Remove(tipoTienda);
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
