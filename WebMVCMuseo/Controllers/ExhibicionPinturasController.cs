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
    public class ExhibicionPinturasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionPinturas
        public ActionResult Index()
        {
            var exhibicionPintura = db.ExhibicionPintura.Include(e => e.Exhibicion).Include(e => e.Pintura).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionPintura.ToList());
        }

        // GET: ExhibicionPinturas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPintura exhibicionPintura = db.ExhibicionPintura.Find(id);
            if (exhibicionPintura == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionPintura);
        }

        // GET: ExhibicionPinturas/Create
        public ActionResult Create()
        {
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idPintura = new SelectList(db.Pintura, "idPintura", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionPinturas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionPintura,idExhibicion,idPintura,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionPintura exhibicionPintura)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionPintura.Add(exhibicionPintura);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPintura.idExhibicion);
            ViewBag.idPintura = new SelectList(db.Pintura, "idPintura", "nombre", exhibicionPintura.idPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioModifica);
            return View(exhibicionPintura);
        }

        // GET: ExhibicionPinturas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPintura exhibicionPintura = db.ExhibicionPintura.Find(id);
            if (exhibicionPintura == null)
            {
                return HttpNotFound();
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPintura.idExhibicion);
            ViewBag.idPintura = new SelectList(db.Pintura, "idPintura", "nombre", exhibicionPintura.idPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioModifica);
            return View(exhibicionPintura);
        }

        // POST: ExhibicionPinturas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionPintura,idExhibicion,idPintura,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionPintura exhibicionPintura)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionPintura).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionPintura.idExhibicion);
            ViewBag.idPintura = new SelectList(db.Pintura, "idPintura", "nombre", exhibicionPintura.idPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionPintura.idUsuarioModifica);
            return View(exhibicionPintura);
        }

        // GET: ExhibicionPinturas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionPintura exhibicionPintura = db.ExhibicionPintura.Find(id);
            if (exhibicionPintura == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionPintura);
        }

        // POST: ExhibicionPinturas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionPintura exhibicionPintura = db.ExhibicionPintura.Find(id);
            db.ExhibicionPintura.Remove(exhibicionPintura);
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
