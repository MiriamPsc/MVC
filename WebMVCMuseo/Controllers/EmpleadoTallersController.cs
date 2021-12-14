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
    public class EmpleadoTallersController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: EmpleadoTallers
        public ActionResult Index()
        {
            var empleadoTaller = db.EmpleadoTaller.Include(e => e.Empleado).Include(e => e.Taller).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(empleadoTaller.ToList());
        }

        // GET: EmpleadoTallers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTaller empleadoTaller = db.EmpleadoTaller.Find(id);
            if (empleadoTaller == null)
            {
                return HttpNotFound();
            }
            return View(empleadoTaller);
        }

        // GET: EmpleadoTallers/Create
        public ActionResult Create()
        {
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: EmpleadoTallers/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEmpleadoTaller,idEmpleado,idTaller,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoTaller empleadoTaller)
        {
            if (ModelState.IsValid)
            {
                db.EmpleadoTaller.Add(empleadoTaller);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTaller.idEmpleado);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", empleadoTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioModifica);
            return View(empleadoTaller);
        }

        // GET: EmpleadoTallers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTaller empleadoTaller = db.EmpleadoTaller.Find(id);
            if (empleadoTaller == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTaller.idEmpleado);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", empleadoTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioModifica);
            return View(empleadoTaller);
        }

        // POST: EmpleadoTallers/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEmpleadoTaller,idEmpleado,idTaller,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoTaller empleadoTaller)
        {
            if (ModelState.IsValid)
            {
                db.Entry(empleadoTaller).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTaller.idEmpleado);
            ViewBag.idTaller = new SelectList(db.Taller, "idTaller", "nombre", empleadoTaller.idTaller);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTaller.idUsuarioModifica);
            return View(empleadoTaller);
        }

        // GET: EmpleadoTallers/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTaller empleadoTaller = db.EmpleadoTaller.Find(id);
            if (empleadoTaller == null)
            {
                return HttpNotFound();
            }
            return View(empleadoTaller);
        }

        // POST: EmpleadoTallers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EmpleadoTaller empleadoTaller = db.EmpleadoTaller.Find(id);
            db.EmpleadoTaller.Remove(empleadoTaller);
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
