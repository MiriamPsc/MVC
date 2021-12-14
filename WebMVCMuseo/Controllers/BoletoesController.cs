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
    public class BoletoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Boletoes
        public ActionResult Index()
        {
            var boleto = db.Boleto.Include(b => b.Audioguia).Include(b => b.Regalo).Include(b => b.TipoBoleto).Include(b => b.Usuario).Include(b => b.Usuario1);
            return View(boleto.ToList());
        }

        // GET: Boletoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Boleto boleto = db.Boleto.Find(id);
            if (boleto == null)
            {
                return HttpNotFound();
            }
            return View(boleto);
        }

        // GET: Boletoes/Create
        public ActionResult Create()
        {
            ViewBag.idAudioguia = new SelectList(db.Audioguia, "idAudioguia", "codigo");
            ViewBag.idRegalo = new SelectList(db.Regalo, "idRegalo", "nombre");
            ViewBag.idTipoBoleto = new SelectList(db.TipoBoleto, "idTipoBoleto", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Boletoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idBoleto,codigo,precio,fechaCompra,idTipoBoleto,idRegalo,idAudioguia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Boleto boleto)
        {
            if (ModelState.IsValid)
            {
                db.Boleto.Add(boleto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idAudioguia = new SelectList(db.Audioguia, "idAudioguia", "codigo", boleto.idAudioguia);
            ViewBag.idRegalo = new SelectList(db.Regalo, "idRegalo", "nombre", boleto.idRegalo);
            ViewBag.idTipoBoleto = new SelectList(db.TipoBoleto, "idTipoBoleto", "nombre", boleto.idTipoBoleto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioModifica);
            return View(boleto);
        }

        // GET: Boletoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Boleto boleto = db.Boleto.Find(id);
            if (boleto == null)
            {
                return HttpNotFound();
            }
            ViewBag.idAudioguia = new SelectList(db.Audioguia, "idAudioguia", "codigo", boleto.idAudioguia);
            ViewBag.idRegalo = new SelectList(db.Regalo, "idRegalo", "nombre", boleto.idRegalo);
            ViewBag.idTipoBoleto = new SelectList(db.TipoBoleto, "idTipoBoleto", "nombre", boleto.idTipoBoleto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioModifica);
            return View(boleto);
        }

        // POST: Boletoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idBoleto,codigo,precio,fechaCompra,idTipoBoleto,idRegalo,idAudioguia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Boleto boleto)
        {
            if (ModelState.IsValid)
            {
                db.Entry(boleto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idAudioguia = new SelectList(db.Audioguia, "idAudioguia", "codigo", boleto.idAudioguia);
            ViewBag.idRegalo = new SelectList(db.Regalo, "idRegalo", "nombre", boleto.idRegalo);
            ViewBag.idTipoBoleto = new SelectList(db.TipoBoleto, "idTipoBoleto", "nombre", boleto.idTipoBoleto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", boleto.idUsuarioModifica);
            return View(boleto);
        }

        // GET: Boletoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Boleto boleto = db.Boleto.Find(id);
            if (boleto == null)
            {
                return HttpNotFound();
            }
            return View(boleto);
        }

        // POST: Boletoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Boleto boleto = db.Boleto.Find(id);
            db.Boleto.Remove(boleto);
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
