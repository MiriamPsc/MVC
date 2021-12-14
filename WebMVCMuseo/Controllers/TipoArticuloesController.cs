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
    public class TipoArticuloesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoArticuloes
        public ActionResult Index()
        {
            var tipoArticulo = db.TipoArticulo.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoArticulo.ToList());
        }

        // GET: TipoArticuloes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArticulo tipoArticulo = db.TipoArticulo.Find(id);
            if (tipoArticulo == null)
            {
                return HttpNotFound();
            }
            return View(tipoArticulo);
        }

        // GET: TipoArticuloes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoArticuloes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoArticulo,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoArticulo tipoArticulo)
        {
            if (ModelState.IsValid)
            {
                db.TipoArticulo.Add(tipoArticulo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioModifica);
            return View(tipoArticulo);
        }

        // GET: TipoArticuloes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArticulo tipoArticulo = db.TipoArticulo.Find(id);
            if (tipoArticulo == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioModifica);
            return View(tipoArticulo);
        }

        // POST: TipoArticuloes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoArticulo,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoArticulo tipoArticulo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoArticulo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoArticulo.idUsuarioModifica);
            return View(tipoArticulo);
        }

        // GET: TipoArticuloes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoArticulo tipoArticulo = db.TipoArticulo.Find(id);
            if (tipoArticulo == null)
            {
                return HttpNotFound();
            }
            return View(tipoArticulo);
        }

        // POST: TipoArticuloes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoArticulo tipoArticulo = db.TipoArticulo.Find(id);
            db.TipoArticulo.Remove(tipoArticulo);
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
