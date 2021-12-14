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
    public class PinturasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Pinturas
        public ActionResult Index()
        {
            var pintura = db.Pintura.Include(p => p.Artista).Include(p => p.Clasificacion).Include(p => p.CorrienteArtistica).Include(p => p.Pais).Include(p => p.Periodo).Include(p => p.TecnicaPintura).Include(p => p.Usuario).Include(p => p.Usuario1);
            return View(pintura.ToList());
        }

        // GET: Pinturas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pintura pintura = db.Pintura.Find(id);
            if (pintura == null)
            {
                return HttpNotFound();
            }
            return View(pintura);
        }

        // GET: Pinturas/Create
        public ActionResult Create()
        {
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre");
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre");
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre");
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre");
            ViewBag.idTecnicaPintura = new SelectList(db.TecnicaPintura, "idTecnicaPintura", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Pinturas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idPintura,nombre,idArtista,idClasificacion,idTecnicaPintura,idCorrienteArtistica,idPais,idPeriodo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Pintura pintura)
        {
            if (ModelState.IsValid)
            {
                db.Pintura.Add(pintura);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", pintura.idArtista);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pintura.idClasificacion);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", pintura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pintura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", pintura.idPeriodo);
            ViewBag.idTecnicaPintura = new SelectList(db.TecnicaPintura, "idTecnicaPintura", "nombre", pintura.idTecnicaPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioModifica);
            return View(pintura);
        }

        // GET: Pinturas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pintura pintura = db.Pintura.Find(id);
            if (pintura == null)
            {
                return HttpNotFound();
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", pintura.idArtista);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pintura.idClasificacion);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", pintura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pintura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", pintura.idPeriodo);
            ViewBag.idTecnicaPintura = new SelectList(db.TecnicaPintura, "idTecnicaPintura", "nombre", pintura.idTecnicaPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioModifica);
            return View(pintura);
        }

        // POST: Pinturas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idPintura,nombre,idArtista,idClasificacion,idTecnicaPintura,idCorrienteArtistica,idPais,idPeriodo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Pintura pintura)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pintura).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idArtista = new SelectList(db.Artista, "idArtista", "nombre", pintura.idArtista);
            ViewBag.idClasificacion = new SelectList(db.Clasificacion, "idClasificacion", "nombre", pintura.idClasificacion);
            ViewBag.idCorrienteArtistica = new SelectList(db.CorrienteArtistica, "idCorrienteArtistica", "nombre", pintura.idCorrienteArtistica);
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", pintura.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", pintura.idPeriodo);
            ViewBag.idTecnicaPintura = new SelectList(db.TecnicaPintura, "idTecnicaPintura", "nombre", pintura.idTecnicaPintura);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", pintura.idUsuarioModifica);
            return View(pintura);
        }

        // GET: Pinturas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pintura pintura = db.Pintura.Find(id);
            if (pintura == null)
            {
                return HttpNotFound();
            }
            return View(pintura);
        }

        // POST: Pinturas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pintura pintura = db.Pintura.Find(id);
            db.Pintura.Remove(pintura);
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
