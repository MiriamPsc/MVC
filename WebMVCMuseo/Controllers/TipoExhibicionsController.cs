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
    public class TipoExhibicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoExhibicions
        public ActionResult Index()
        {
            var tipoExhibicion = db.TipoExhibicion.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoExhibicion.ToList());
        }

        // GET: TipoExhibicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoExhibicion tipoExhibicion = db.TipoExhibicion.Find(id);
            if (tipoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(tipoExhibicion);
        }

        // GET: TipoExhibicions/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoExhibicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoExhibicion,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoExhibicion tipoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.TipoExhibicion.Add(tipoExhibicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioModifica);
            return View(tipoExhibicion);
        }

        // GET: TipoExhibicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoExhibicion tipoExhibicion = db.TipoExhibicion.Find(id);
            if (tipoExhibicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioModifica);
            return View(tipoExhibicion);
        }

        // POST: TipoExhibicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoExhibicion,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoExhibicion tipoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoExhibicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoExhibicion.idUsuarioModifica);
            return View(tipoExhibicion);
        }

        // GET: TipoExhibicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoExhibicion tipoExhibicion = db.TipoExhibicion.Find(id);
            if (tipoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(tipoExhibicion);
        }

        // POST: TipoExhibicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoExhibicion tipoExhibicion = db.TipoExhibicion.Find(id);
            db.TipoExhibicion.Remove(tipoExhibicion);
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
