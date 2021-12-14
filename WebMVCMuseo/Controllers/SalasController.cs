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
    public class SalasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Salas
        public ActionResult Index()
        {
            var sala = db.Sala.Include(s => s.TipoSala).Include(s => s.Ubicacion).Include(s => s.Usuario).Include(s => s.Usuario1);
            return View(sala.ToList());
        }

        // GET: Salas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sala sala = db.Sala.Find(id);
            if (sala == null)
            {
                return HttpNotFound();
            }
            return View(sala);
        }

        // GET: Salas/Create
        public ActionResult Create()
        {
            ViewBag.idTipoSala = new SelectList(db.TipoSala, "idTipoSala", "nombre");
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Salas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idSala,nombre,codigo,idUbicacion,idTipoSala,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Sala sala)
        {
            if (ModelState.IsValid)
            {
                db.Sala.Add(sala);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoSala = new SelectList(db.TipoSala, "idTipoSala", "nombre", sala.idTipoSala);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", sala.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioModifica);
            return View(sala);
        }

        // GET: Salas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sala sala = db.Sala.Find(id);
            if (sala == null)
            {
                return HttpNotFound();
            }
            ViewBag.idTipoSala = new SelectList(db.TipoSala, "idTipoSala", "nombre", sala.idTipoSala);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", sala.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioModifica);
            return View(sala);
        }

        // POST: Salas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idSala,nombre,codigo,idUbicacion,idTipoSala,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Sala sala)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sala).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTipoSala = new SelectList(db.TipoSala, "idTipoSala", "nombre", sala.idTipoSala);
            ViewBag.idUbicacion = new SelectList(db.Ubicacion, "idUbicacion", "nombre", sala.idUbicacion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", sala.idUsuarioModifica);
            return View(sala);
        }

        // GET: Salas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sala sala = db.Sala.Find(id);
            if (sala == null)
            {
                return HttpNotFound();
            }
            return View(sala);
        }

        // POST: Salas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Sala sala = db.Sala.Find(id);
            db.Sala.Remove(sala);
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
