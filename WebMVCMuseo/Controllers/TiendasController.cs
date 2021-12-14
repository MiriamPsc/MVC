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
    public class TiendasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Tiendas
        public ActionResult Index()
        {
            var tienda = db.Tienda.Include(t => t.TipoTienda).Include(t => t.Ubicacion).Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tienda.ToList());
        }

        // GET: Tiendas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tienda tienda = db.Tienda.Find(id);
            if (tienda == null)
            {
                return HttpNotFound();
            }
            return View(tienda);
        }

        // GET: Tiendas/Create
        public ActionResult Create()
        {
            ViewBag.idTipoTienda = new SelectList(db.TipoTienda, "idTipoTienda", "nombre");
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Tiendas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTienda,codigo,nombre,idUbicacion,idTipoTienda,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Tienda tienda)
        {
            if (ModelState.IsValid)
            {
                db.Tienda.Add(tienda);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoTienda = new SelectList(db.TipoTienda, "idTipoTienda", "nombre", tienda.idTipoTienda);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", tienda.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioModifica);
            return View(tienda);
        }

        // GET: Tiendas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tienda tienda = db.Tienda.Find(id);
            if (tienda == null)
            {
                return HttpNotFound();
            }
            ViewBag.idTipoTienda = new SelectList(db.TipoTienda, "idTipoTienda", "nombre", tienda.idTipoTienda);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", tienda.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioModifica);
            return View(tienda);
        }

        // POST: Tiendas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTienda,codigo,nombre,idUbicacion,idTipoTienda,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Tienda tienda)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tienda).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTipoTienda = new SelectList(db.TipoTienda, "idTipoTienda", "nombre", tienda.idTipoTienda);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", tienda.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tienda.idUsuarioModifica);
            return View(tienda);
        }

        // GET: Tiendas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tienda tienda = db.Tienda.Find(id);
            if (tienda == null)
            {
                return HttpNotFound();
            }
            return View(tienda);
        }

        // POST: Tiendas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Tienda tienda = db.Tienda.Find(id);
            db.Tienda.Remove(tienda);
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
