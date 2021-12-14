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
    public class EsculturaExhibicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: EsculturaExhibicions
        public ActionResult Index()
        {
            var esculturaExhibicion = db.EsculturaExhibicion.Include(e => e.Escultura).Include(e => e.Exhibicion).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(esculturaExhibicion.ToList());
        }

        // GET: EsculturaExhibicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EsculturaExhibicion esculturaExhibicion = db.EsculturaExhibicion.Find(id);
            if (esculturaExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(esculturaExhibicion);
        }

        // GET: EsculturaExhibicions/Create
        public ActionResult Create()
        {
            ViewBag.idEscultura = new SelectList(db.Escultura, "idEscultura", "nombre");
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: EsculturaExhibicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEsculturaExhibicion,idEscultura,idExhibicion,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EsculturaExhibicion esculturaExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.EsculturaExhibicion.Add(esculturaExhibicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEscultura = new SelectList(db.Escultura, "idEscultura", "nombre", esculturaExhibicion.idEscultura);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", esculturaExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioModifica);
            return View(esculturaExhibicion);
        }

        // GET: EsculturaExhibicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EsculturaExhibicion esculturaExhibicion = db.EsculturaExhibicion.Find(id);
            if (esculturaExhibicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEscultura = new SelectList(db.Escultura, "idEscultura", "nombre", esculturaExhibicion.idEscultura);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", esculturaExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioModifica);
            return View(esculturaExhibicion);
        }

        // POST: EsculturaExhibicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEsculturaExhibicion,idEscultura,idExhibicion,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EsculturaExhibicion esculturaExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(esculturaExhibicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEscultura = new SelectList(db.Escultura, "idEscultura", "nombre", esculturaExhibicion.idEscultura);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", esculturaExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", esculturaExhibicion.idUsuarioModifica);
            return View(esculturaExhibicion);
        }

        // GET: EsculturaExhibicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EsculturaExhibicion esculturaExhibicion = db.EsculturaExhibicion.Find(id);
            if (esculturaExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(esculturaExhibicion);
        }

        // POST: EsculturaExhibicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EsculturaExhibicion esculturaExhibicion = db.EsculturaExhibicion.Find(id);
            db.EsculturaExhibicion.Remove(esculturaExhibicion);
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
