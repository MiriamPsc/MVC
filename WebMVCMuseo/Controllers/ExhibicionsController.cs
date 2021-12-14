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
    public class ExhibicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Exhibicions
        public ActionResult Index()
        {
            var exhibicion = db.Exhibicion.Include(e => e.DirectorDeExhibicionExterno).Include(e => e.Empleado).Include(e => e.TipoExhibicion).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(exhibicion.ToList());
        }

        // GET: Exhibicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Exhibicion exhibicion = db.Exhibicion.Find(id);
            if (exhibicion == null)
            {
                return HttpNotFound();
            }
            return View(exhibicion);
        }

        // GET: Exhibicions/Create
        public ActionResult Create()
        {
            ViewBag.idDirectorDeExhibicionExterno = new SelectList(db.DirectorDeExhibicionExterno, "idDirectorDeExhibicionExterno", "nombre");
            ViewBag.idDirectorDeExhibicion = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idTipoExhibicion = new SelectList(db.TipoExhibicion, "idTipoExhibicion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Exhibicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idExhibicion,nombre,descripcion,fechaInicio,fechaFinal,idTipoExhibicion,idDirectorDeExhibicion,idDirectorDeExhibicionExterno,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Exhibicion exhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Exhibicion.Add(exhibicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idDirectorDeExhibicionExterno = new SelectList(db.DirectorDeExhibicionExterno, "idDirectorDeExhibicionExterno", "nombre", exhibicion.idDirectorDeExhibicionExterno);
            ViewBag.idDirectorDeExhibicion = new SelectList(db.Empleado, "idEmpleado", "numero", exhibicion.idDirectorDeExhibicion);
            ViewBag.idTipoExhibicion = new SelectList(db.TipoExhibicion, "idTipoExhibicion", "nombre", exhibicion.idTipoExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioModifica);
            return View(exhibicion);
        }

        // GET: Exhibicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Exhibicion exhibicion = db.Exhibicion.Find(id);
            if (exhibicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idDirectorDeExhibicionExterno = new SelectList(db.DirectorDeExhibicionExterno, "idDirectorDeExhibicionExterno", "nombre", exhibicion.idDirectorDeExhibicionExterno);
            ViewBag.idDirectorDeExhibicion = new SelectList(db.Empleado, "idEmpleado", "numero", exhibicion.idDirectorDeExhibicion);
            ViewBag.idTipoExhibicion = new SelectList(db.TipoExhibicion, "idTipoExhibicion", "nombre", exhibicion.idTipoExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioModifica);
            return View(exhibicion);
        }

        // POST: Exhibicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idExhibicion,nombre,descripcion,fechaInicio,fechaFinal,idTipoExhibicion,idDirectorDeExhibicion,idDirectorDeExhibicionExterno,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Exhibicion exhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exhibicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idDirectorDeExhibicionExterno = new SelectList(db.DirectorDeExhibicionExterno, "idDirectorDeExhibicionExterno", "nombre", exhibicion.idDirectorDeExhibicionExterno);
            ViewBag.idDirectorDeExhibicion = new SelectList(db.Empleado, "idEmpleado", "numero", exhibicion.idDirectorDeExhibicion);
            ViewBag.idTipoExhibicion = new SelectList(db.TipoExhibicion, "idTipoExhibicion", "nombre", exhibicion.idTipoExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", exhibicion.idUsuarioModifica);
            return View(exhibicion);
        }

        // GET: Exhibicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Exhibicion exhibicion = db.Exhibicion.Find(id);
            if (exhibicion == null)
            {
                return HttpNotFound();
            }
            return View(exhibicion);
        }

        // POST: Exhibicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Exhibicion exhibicion = db.Exhibicion.Find(id);
            db.Exhibicion.Remove(exhibicion);
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
