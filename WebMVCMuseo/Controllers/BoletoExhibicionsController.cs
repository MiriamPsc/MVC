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
    public class BoletoExhibicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: BoletoExhibicions
        public ActionResult Index()
        {
            var boletoExhibicion = db.BoletoExhibicion.Include(b => b.Boleto).Include(b => b.Exhibicion).Include(b => b.Usuario).Include(b => b.Usuario1);
            return View(boletoExhibicion.ToList());
        }

        // GET: BoletoExhibicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BoletoExhibicion boletoExhibicion = db.BoletoExhibicion.Find(id);
            if (boletoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(boletoExhibicion);
        }

        // GET: BoletoExhibicions/Create
        public ActionResult Create()
        {
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo");
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: BoletoExhibicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idBoletoExhibicion,idBoleto,idExhibicion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] BoletoExhibicion boletoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.BoletoExhibicion.Add(boletoExhibicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", boletoExhibicion.idBoleto);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", boletoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioModifica);
            return View(boletoExhibicion);
        }

        // GET: BoletoExhibicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BoletoExhibicion boletoExhibicion = db.BoletoExhibicion.Find(id);
            if (boletoExhibicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", boletoExhibicion.idBoleto);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", boletoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioModifica);
            return View(boletoExhibicion);
        }

        // POST: BoletoExhibicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idBoletoExhibicion,idBoleto,idExhibicion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] BoletoExhibicion boletoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(boletoExhibicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", boletoExhibicion.idBoleto);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", boletoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boletoExhibicion.idUsuarioModifica);
            return View(boletoExhibicion);
        }

        // GET: BoletoExhibicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BoletoExhibicion boletoExhibicion = db.BoletoExhibicion.Find(id);
            if (boletoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(boletoExhibicion);
        }

        // POST: BoletoExhibicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            BoletoExhibicion boletoExhibicion = db.BoletoExhibicion.Find(id);
            db.BoletoExhibicion.Remove(boletoExhibicion);
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
