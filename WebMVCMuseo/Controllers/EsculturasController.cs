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
    public class EsculturasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Esculturas
        public ActionResult Index()
        {
            var escultura = db.Escultura.Include(e => e.Artista).Include(e => e.CorrienteArtistica).Include(e => e.Pais).Include(e => e.Periodo).Include(e => e.TecnicaEscultura).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(escultura.ToList());
        }

        // GET: Esculturas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Escultura escultura = db.Escultura.Find(id);
            if (escultura == null)
            {
                return HttpNotFound();
            }
            return View(escultura);
        }

        // GET: Esculturas/Create
        public ActionResult Create()
        {
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre");
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre");
            ViewBag.idTecnicaEscultura = new SelectList(db.TecnicaEscultura, "idTecnicaEscultura", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Esculturas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEscultura,nombre,idArtista,idCorrienteArtistica,idTecnicaEscultura,idPais,idPeriodo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Escultura escultura)
        {
            if (ModelState.IsValid)
            {
                db.Escultura.Add(escultura);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", escultura.idArtista);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", escultura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", escultura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", escultura.idPeriodo);
            ViewBag.idTecnicaEscultura = new SelectList(db.TecnicaEscultura, "idTecnicaEscultura", "nombre", escultura.idTecnicaEscultura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioModifica);
            return View(escultura);
        }

        // GET: Esculturas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Escultura escultura = db.Escultura.Find(id);
            if (escultura == null)
            {
                return HttpNotFound();
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", escultura.idArtista);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", escultura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", escultura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", escultura.idPeriodo);
            ViewBag.idTecnicaEscultura = new SelectList(db.TecnicaEscultura, "idTecnicaEscultura", "nombre", escultura.idTecnicaEscultura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioModifica);
            return View(escultura);
        }

        // POST: Esculturas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEscultura,nombre,idArtista,idCorrienteArtistica,idTecnicaEscultura,idPais,idPeriodo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Escultura escultura)
        {
            if (ModelState.IsValid)
            {
                db.Entry(escultura).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", escultura.idArtista);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", escultura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", escultura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", escultura.idPeriodo);
            ViewBag.idTecnicaEscultura = new SelectList(db.TecnicaEscultura, "idTecnicaEscultura", "nombre", escultura.idTecnicaEscultura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", escultura.idUsuarioModifica);
            return View(escultura);
        }

        // GET: Esculturas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Escultura escultura = db.Escultura.Find(id);
            if (escultura == null)
            {
                return HttpNotFound();
            }
            return View(escultura);
        }

        // POST: Esculturas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Escultura escultura = db.Escultura.Find(id);
            db.Escultura.Remove(escultura);
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
