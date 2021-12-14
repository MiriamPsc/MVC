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
    public class ExhibicionObjetoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionObjetoes
        public ActionResult Index()
        {
            var exhibicionObjeto = db.ExhibicionObjeto.Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionObjeto.ToList());
        }

        // GET: ExhibicionObjetoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionObjeto exhibicionObjeto = db.ExhibicionObjeto.Find(id);
            if (exhibicionObjeto == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionObjeto);
        }

        // GET: ExhibicionObjetoes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionObjetoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionObjeto,idExhibicion,idObjeto,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionObjeto exhibicionObjeto)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionObjeto.Add(exhibicionObjeto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioModifica);
            return View(exhibicionObjeto);
        }

        // GET: ExhibicionObjetoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionObjeto exhibicionObjeto = db.ExhibicionObjeto.Find(id);
            if (exhibicionObjeto == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioModifica);
            return View(exhibicionObjeto);
        }

        // POST: ExhibicionObjetoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionObjeto,idExhibicion,idObjeto,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionObjeto exhibicionObjeto)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionObjeto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionObjeto.idUsuarioModifica);
            return View(exhibicionObjeto);
        }

        // GET: ExhibicionObjetoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionObjeto exhibicionObjeto = db.ExhibicionObjeto.Find(id);
            if (exhibicionObjeto == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionObjeto);
        }

        // POST: ExhibicionObjetoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionObjeto exhibicionObjeto = db.ExhibicionObjeto.Find(id);
            db.ExhibicionObjeto.Remove(exhibicionObjeto);
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
