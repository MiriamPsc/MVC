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
    public class TipoObjetoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoObjetoes
        public ActionResult Index()
        {
            var tipoObjeto = db.TipoObjeto.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoObjeto.ToList());
        }

        // GET: TipoObjetoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoObjeto tipoObjeto = db.TipoObjeto.Find(id);
            if (tipoObjeto == null)
            {
                return HttpNotFound();
            }
            return View(tipoObjeto);
        }

        // GET: TipoObjetoes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoObjetoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoObjeto,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoObjeto tipoObjeto)
        {
            if (ModelState.IsValid)
            {
                db.TipoObjeto.Add(tipoObjeto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioModifica);
            return View(tipoObjeto);
        }

        // GET: TipoObjetoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoObjeto tipoObjeto = db.TipoObjeto.Find(id);
            if (tipoObjeto == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioModifica);
            return View(tipoObjeto);
        }

        // POST: TipoObjetoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoObjeto,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoObjeto tipoObjeto)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoObjeto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoObjeto.idUsuarioModifica);
            return View(tipoObjeto);
        }

        // GET: TipoObjetoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoObjeto tipoObjeto = db.TipoObjeto.Find(id);
            if (tipoObjeto == null)
            {
                return HttpNotFound();
            }
            return View(tipoObjeto);
        }

        // POST: TipoObjetoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoObjeto tipoObjeto = db.TipoObjeto.Find(id);
            db.TipoObjeto.Remove(tipoObjeto);
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
