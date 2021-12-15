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
    public class TipoTallersController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoTallers
        public ActionResult Index()
        {
            var tipoTaller = db.TipoTaller.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoTaller.ToList());
        }

        // GET: TipoTallers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTaller tipoTaller = db.TipoTaller.Find(id);
            if (tipoTaller == null)
            {
                return HttpNotFound();
            }
            return View(tipoTaller);
        }

        // GET: TipoTallers/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoTallers/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoTaller,nombre,modalidad,numeroMaximo,numeroMinimo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoTaller tipoTaller)
        {
            if (ModelState.IsValid)
            {
                db.TipoTaller.Add(tipoTaller);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioModifica);
            return View(tipoTaller);
        }

        // GET: TipoTallers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTaller tipoTaller = db.TipoTaller.Find(id);
            if (tipoTaller == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioModifica);
            return View(tipoTaller);
        }

        // POST: TipoTallers/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoTaller,nombre,modalidad,numeroMaximo,numeroMinimo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoTaller tipoTaller)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoTaller).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoTaller.idUsuarioModifica);
            return View(tipoTaller);
        }

        // GET: TipoTallers/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoTaller tipoTaller = db.TipoTaller.Find(id);
            if (tipoTaller == null)
            {
                return HttpNotFound();
            }
            return View(tipoTaller);
        }

        // POST: TipoTallers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoTaller tipoTaller = db.TipoTaller.Find(id);
            db.TipoTaller.Remove(tipoTaller);
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
