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
    public class AudioguiasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Audioguias
        public ActionResult Index()
        {
            var audioguia = db.Audioguia.Include(a => a.Empleado).Include(a => a.Usuario).Include(a => a.Usuario1);
            return View(audioguia.ToList());
        }

        // GET: Audioguias/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Audioguia audioguia = db.Audioguia.Find(id);
            if (audioguia == null)
            {
                return HttpNotFound();
            }
            return View(audioguia);
        }

        // GET: Audioguias/Create
        public ActionResult Create()
        {
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Audioguias/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idAudioguia,codigo,idioma,estatus,idEmpleado,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Audioguia audioguia)
        {
            if (ModelState.IsValid)
            {
                db.Audioguia.Add(audioguia);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", audioguia.idEmpleado);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioModifica);
            return View(audioguia);
        }

        // GET: Audioguias/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Audioguia audioguia = db.Audioguia.Find(id);
            if (audioguia == null)
            {
                return HttpNotFound();
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", audioguia.idEmpleado);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioModifica);
            return View(audioguia);
        }

        // POST: Audioguias/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idAudioguia,codigo,idioma,estatus,idEmpleado,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Audioguia audioguia)
        {
            if (ModelState.IsValid)
            {
                db.Entry(audioguia).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idEmpleado = new SelectList(db.Empleado, "idEmpleado", "numero", audioguia.idEmpleado);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", audioguia.idUsuarioModifica);
            return View(audioguia);
        }

        // GET: Audioguias/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Audioguia audioguia = db.Audioguia.Find(id);
            if (audioguia == null)
            {
                return HttpNotFound();
            }
            return View(audioguia);
        }

        // POST: Audioguias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Audioguia audioguia = db.Audioguia.Find(id);
            db.Audioguia.Remove(audioguia);
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
