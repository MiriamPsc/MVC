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
    public class DirectorDeExhibicionExternoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: DirectorDeExhibicionExternoes
        public ActionResult Index()
        {
            var directorDeExhibicionExterno = db.DirectorDeExhibicionExterno.Include(d => d.Usuario).Include(d => d.Usuario1);
            return View(directorDeExhibicionExterno.ToList());
        }

        // GET: DirectorDeExhibicionExternoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DirectorDeExhibicionExterno directorDeExhibicionExterno = db.DirectorDeExhibicionExterno.Find(id);
            if (directorDeExhibicionExterno == null)
            {
                return HttpNotFound();
            }
            return View(directorDeExhibicionExterno);
        }

        // GET: DirectorDeExhibicionExternoes/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: DirectorDeExhibicionExternoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idDirectorDeExhibicionExterno,nombre,apellidoPaterno,apellidoMaterno,ciudad,pais,fechaNacimiento,rfc,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] DirectorDeExhibicionExterno directorDeExhibicionExterno)
        {
            if (ModelState.IsValid)
            {
                db.DirectorDeExhibicionExterno.Add(directorDeExhibicionExterno);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioModifica);
            return View(directorDeExhibicionExterno);
        }

        // GET: DirectorDeExhibicionExternoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DirectorDeExhibicionExterno directorDeExhibicionExterno = db.DirectorDeExhibicionExterno.Find(id);
            if (directorDeExhibicionExterno == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioModifica);
            return View(directorDeExhibicionExterno);
        }

        // POST: DirectorDeExhibicionExternoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idDirectorDeExhibicionExterno,nombre,apellidoPaterno,apellidoMaterno,ciudad,pais,fechaNacimiento,rfc,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] DirectorDeExhibicionExterno directorDeExhibicionExterno)
        {
            if (ModelState.IsValid)
            {
                db.Entry(directorDeExhibicionExterno).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", directorDeExhibicionExterno.idUsuarioModifica);
            return View(directorDeExhibicionExterno);
        }

        // GET: DirectorDeExhibicionExternoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DirectorDeExhibicionExterno directorDeExhibicionExterno = db.DirectorDeExhibicionExterno.Find(id);
            if (directorDeExhibicionExterno == null)
            {
                return HttpNotFound();
            }
            return View(directorDeExhibicionExterno);
        }

        // POST: DirectorDeExhibicionExternoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DirectorDeExhibicionExterno directorDeExhibicionExterno = db.DirectorDeExhibicionExterno.Find(id);
            db.DirectorDeExhibicionExterno.Remove(directorDeExhibicionExterno);
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
