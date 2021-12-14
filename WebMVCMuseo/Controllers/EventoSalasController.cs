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
    public class EventoSalasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: EventoSalas
        public ActionResult Index()
        {
            var eventoSala = db.EventoSala.Include(e => e.Evento).Include(e => e.Sala).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(eventoSala.ToList());
        }

        // GET: EventoSalas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventoSala eventoSala = db.EventoSala.Find(id);
            if (eventoSala == null)
            {
                return HttpNotFound();
            }
            return View(eventoSala);
        }

        // GET: EventoSalas/Create
        public ActionResult Create()
        {
            ViewBag.idEvento = new SelectList(db.Evento, "idEvento", "codigo");
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: EventoSalas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEventoSala,idEvento,idSala,fechaHoraInicio,fechaHoraFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EventoSala eventoSala)
        {
            if (ModelState.IsValid)
            {
                db.EventoSala.Add(eventoSala);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEvento = new SelectList(db.Evento, "idEvento", "codigo", eventoSala.idEvento);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", eventoSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioModifica);
            return View(eventoSala);
        }

        // GET: EventoSalas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventoSala eventoSala = db.EventoSala.Find(id);
            if (eventoSala == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEvento = new SelectList(db.Evento, "idEvento", "codigo", eventoSala.idEvento);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", eventoSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioModifica);
            return View(eventoSala);
        }

        // POST: EventoSalas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEventoSala,idEvento,idSala,fechaHoraInicio,fechaHoraFinal,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EventoSala eventoSala)
        {
            if (ModelState.IsValid)
            {
                db.Entry(eventoSala).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEvento = new SelectList(db.Evento, "idEvento", "codigo", eventoSala.idEvento);
            ViewBag.idSala = new SelectList(db.Sala, "idSala", "nombre", eventoSala.idSala);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", eventoSala.idUsuarioModifica);
            return View(eventoSala);
        }

        // GET: EventoSalas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventoSala eventoSala = db.EventoSala.Find(id);
            if (eventoSala == null)
            {
                return HttpNotFound();
            }
            return View(eventoSala);
        }

        // POST: EventoSalas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EventoSala eventoSala = db.EventoSala.Find(id);
            db.EventoSala.Remove(eventoSala);
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
