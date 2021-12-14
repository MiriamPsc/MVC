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
    public class TecnicaPinturasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TecnicaPinturas
        public ActionResult Index()
        {
            var tecnicaPintura = db.TecnicaPintura.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tecnicaPintura.ToList());
        }

        // GET: TecnicaPinturas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaPintura tecnicaPintura = db.TecnicaPintura.Find(id);
            if (tecnicaPintura == null)
            {
                return HttpNotFound();
            }
            return View(tecnicaPintura);
        }

        // GET: TecnicaPinturas/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TecnicaPinturas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTecnicaPintura,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TecnicaPintura tecnicaPintura)
        {
            if (ModelState.IsValid)
            {
                db.TecnicaPintura.Add(tecnicaPintura);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioModifica);
            return View(tecnicaPintura);
        }

        // GET: TecnicaPinturas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaPintura tecnicaPintura = db.TecnicaPintura.Find(id);
            if (tecnicaPintura == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioModifica);
            return View(tecnicaPintura);
        }

        // POST: TecnicaPinturas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTecnicaPintura,nombre,descripcion,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TecnicaPintura tecnicaPintura)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tecnicaPintura).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaPintura.idUsuarioModifica);
            return View(tecnicaPintura);
        }

        // GET: TecnicaPinturas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaPintura tecnicaPintura = db.TecnicaPintura.Find(id);
            if (tecnicaPintura == null)
            {
                return HttpNotFound();
            }
            return View(tecnicaPintura);
        }

        // POST: TecnicaPinturas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TecnicaPintura tecnicaPintura = db.TecnicaPintura.Find(id);
            db.TecnicaPintura.Remove(tecnicaPintura);
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
