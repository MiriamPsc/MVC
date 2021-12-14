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
    public class EmpleadoTiendasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: EmpleadoTiendas
        public ActionResult Index()
        {
            var empleadoTienda = db.EmpleadoTienda.Include(e => e.Empleado).Include(e => e.Tienda).Include(e => e.Usuario).Include(e => e.Usuario1);
            return View(empleadoTienda.ToList());
        }

        // GET: EmpleadoTiendas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTienda empleadoTienda = db.EmpleadoTienda.Find(id);
            if (empleadoTienda == null)
            {
                return HttpNotFound();
            }
            return View(empleadoTienda);
        }

        // GET: EmpleadoTiendas/Create
        public ActionResult Create()
        {
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: EmpleadoTiendas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idEmpleadoTienda,idEmpleado,idTienda,fechaHoraEntrada,fechaHoraSalida,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoTienda empleadoTienda)
        {
            if (ModelState.IsValid)
            {
                db.EmpleadoTienda.Add(empleadoTienda);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTienda.idEmpleado);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", empleadoTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioModifica);
            return View(empleadoTienda);
        }

        // GET: EmpleadoTiendas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTienda empleadoTienda = db.EmpleadoTienda.Find(id);
            if (empleadoTienda == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTienda.idEmpleado);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", empleadoTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioModifica);
            return View(empleadoTienda);
        }

        // POST: EmpleadoTiendas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idEmpleadoTienda,idEmpleado,idTienda,fechaHoraEntrada,fechaHoraSalida,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] EmpleadoTienda empleadoTienda)
        {
            if (ModelState.IsValid)
            {
                db.Entry(empleadoTienda).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", empleadoTienda.idEmpleado);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", empleadoTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", empleadoTienda.idUsuarioModifica);
            return View(empleadoTienda);
        }

        // GET: EmpleadoTiendas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpleadoTienda empleadoTienda = db.EmpleadoTienda.Find(id);
            if (empleadoTienda == null)
            {
                return HttpNotFound();
            }
            return View(empleadoTienda);
        }

        // POST: EmpleadoTiendas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EmpleadoTienda empleadoTienda = db.EmpleadoTienda.Find(id);
            db.EmpleadoTienda.Remove(empleadoTienda);
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
