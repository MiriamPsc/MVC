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
    public class SalaTallersController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: SalaTallers
        public ActionResult Index()
        {
            var salaTaller = db.SalaTaller.Include(s => s.Sala).Include(s => s.Taller).Include(s => s.Usuario).Include(s => s.Usuario1);
            return View(salaTaller.ToList());
        }

        // GET: SalaTallers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SalaTaller salaTaller = db.SalaTaller.Find(id);
            if (salaTaller == null)
            {
                return HttpNotFound();
            }
            return View(salaTaller);
        }

        // GET: SalaTallers/Create
        public ActionResult Create()
        {
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre");
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: SalaTallers/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idSalaTaller,idSala,idTaller,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] SalaTaller salaTaller)
        {
            if (ModelState.IsValid)
            {
                db.SalaTaller.Add(salaTaller);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", salaTaller.idSala);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", salaTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioModifica);
            return View(salaTaller);
        }

        // GET: SalaTallers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SalaTaller salaTaller = db.SalaTaller.Find(id);
            if (salaTaller == null)
            {
                return HttpNotFound();
            }
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", salaTaller.idSala);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", salaTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioModifica);
            return View(salaTaller);
        }

        // POST: SalaTallers/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idSalaTaller,idSala,idTaller,fechaInicio,fechaFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] SalaTaller salaTaller)
        {
            if (ModelState.IsValid)
            {
                db.Entry(salaTaller).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", salaTaller.idSala);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", salaTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", salaTaller.idUsuarioModifica);
            return View(salaTaller);
        }

        // GET: SalaTallers/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SalaTaller salaTaller = db.SalaTaller.Find(id);
            if (salaTaller == null)
            {
                return HttpNotFound();
            }
            return View(salaTaller);
        }

        // POST: SalaTallers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SalaTaller salaTaller = db.SalaTaller.Find(id);
            db.SalaTaller.Remove(salaTaller);
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
