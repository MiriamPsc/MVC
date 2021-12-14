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
    public class EmpleadoExhibicionsController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: EmpleadoExhibicions
        public ActionResult Index()
        {
            var empleadoExhibicion = db.EmpleadoExhibicion.Include(e => e.Empleado).Include(e => e.Exhibicion).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(empleadoExhibicion.ToList());
        }

        // GET: EmpleadoExhibicions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoExhibicion empleadoExhibicion = db.EmpleadoExhibicion.Find(id);
            if (empleadoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(empleadoExhibicion);
        }

        // GET: EmpleadoExhibicions/Create
        public ActionResult Create()
        {
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: EmpleadoExhibicions/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEmpleadoExhibicion,idEmpleado,idExhibicion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoExhibicion empleadoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.EmpleadoExhibicion.Add(empleadoExhibicion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoExhibicion.idEmpleado);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", empleadoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioModifica);
            return View(empleadoExhibicion);
        }

        // GET: EmpleadoExhibicions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoExhibicion empleadoExhibicion = db.EmpleadoExhibicion.Find(id);
            if (empleadoExhibicion == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoExhibicion.idEmpleado);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", empleadoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioModifica);
            return View(empleadoExhibicion);
        }

        // POST: EmpleadoExhibicions/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEmpleadoExhibicion,idEmpleado,idExhibicion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoExhibicion empleadoExhibicion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(empleadoExhibicion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoExhibicion.idEmpleado);
            ViewBag.idExhibicion = new SelectList(db.Exhibicion, "idExhibicion", "nombre", empleadoExhibicion.idExhibicion);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoExhibicion.idUsuarioModifica);
            return View(empleadoExhibicion);
        }

        // GET: EmpleadoExhibicions/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoExhibicion empleadoExhibicion = db.EmpleadoExhibicion.Find(id);
            if (empleadoExhibicion == null)
            {
                return HttpNotFound();
            }
            return View(empleadoExhibicion);
        }

        // POST: EmpleadoExhibicions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EmpleadoExhibicion empleadoExhibicion = db.EmpleadoExhibicion.Find(id);
            db.EmpleadoExhibicion.Remove(empleadoExhibicion);
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
