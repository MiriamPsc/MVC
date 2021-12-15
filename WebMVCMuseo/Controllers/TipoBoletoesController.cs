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
    public class TipoBoletoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoBoletoes
        public ActionResult Index()
        {
            var tipoBoleto = db.TipoBoleto.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tipoBoleto.ToList());
        }

        // GET: TipoBoletoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoBoleto tipoBoleto = db.TipoBoleto.Find(id);
            if (tipoBoleto == null)
            {
                return HttpNotFound();
            }
            return View(tipoBoleto);
        }

        // GET: TipoBoletoes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TipoBoletoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoBoleto,nombre,descripcion,vigencia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoBoleto tipoBoleto)
        {
            if (ModelState.IsValid)
            {
                db.TipoBoleto.Add(tipoBoleto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioModifica);
            return View(tipoBoleto);
        }

        // GET: TipoBoletoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoBoleto tipoBoleto = db.TipoBoleto.Find(id);
            if (tipoBoleto == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioModifica);
            return View(tipoBoleto);
        }

        // POST: TipoBoletoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoBoleto,nombre,descripcion,vigencia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoBoleto tipoBoleto)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoBoleto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tipoBoleto.idUsuarioModifica);
            return View(tipoBoleto);
        }

        // GET: TipoBoletoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoBoleto tipoBoleto = db.TipoBoleto.Find(id);
            if (tipoBoleto == null)
            {
                return HttpNotFound();
            }
            return View(tipoBoleto);
        }

        // POST: TipoBoletoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoBoleto tipoBoleto = db.TipoBoleto.Find(id);
            db.TipoBoleto.Remove(tipoBoleto);
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
