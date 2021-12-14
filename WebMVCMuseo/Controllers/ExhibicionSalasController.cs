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
    public class ExhibicionSalasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ExhibicionSalas
        public ActionResult Index()
        {
            var exhibicionSala = db.ExhibicionSala.Include(e => e.Exhibicion).Include(e => e.Sala).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicionSala.ToList());
        }

        // GET: ExhibicionSalas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionSala exhibicionSala = db.ExhibicionSala.Find(id);
            if (exhibicionSala == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionSala);
        }

        // GET: ExhibicionSalas/Create
        public ActionResult Create()
        {
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ExhibicionSalas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicionSala,idExhibicion,idSala,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionSala exhibicionSala)
        {
            if (ModelState.IsValid)
            {
                db.ExhibicionSala.Add(exhibicionSala);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionSala.idExhibicion);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", exhibicionSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioModifica);
            return View(exhibicionSala);
        }

        // GET: ExhibicionSalas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionSala exhibicionSala = db.ExhibicionSala.Find(id);
            if (exhibicionSala == null)
            {
                return HttpNotFound();
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionSala.idExhibicion);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", exhibicionSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioModifica);
            return View(exhibicionSala);
        }

        // POST: ExhibicionSalas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicionSala,idExhibicion,idSala,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ExhibicionSala exhibicionSala)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicionSala).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", exhibicionSala.idExhibicion);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", exhibicionSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicionSala.idUsuarioModifica);
            return View(exhibicionSala);
        }

        // GET: ExhibicionSalas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ExhibicionSala exhibicionSala = db.ExhibicionSala.Find(id);
            if (exhibicionSala == null)
            {
                return HttpNotFound();
            }
            return View(exhibicionSala);
        }

        // POST: ExhibicionSalas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ExhibicionSala exhibicionSala = db.ExhibicionSala.Find(id);
            db.ExhibicionSala.Remove(exhibicionSala);
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
