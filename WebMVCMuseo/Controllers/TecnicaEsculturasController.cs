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
    public class TecnicaEsculturasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TecnicaEsculturas
        public ActionResult Index()
        {
            var tecnicaEscultura = db.TecnicaEscultura.Include(t => t.Usuario).Include(t => t.Usuario1);
            return View(tecnicaEscultura.ToList());
        }

        // GET: TecnicaEsculturas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaEscultura tecnicaEscultura = db.TecnicaEscultura.Find(id);
            if (tecnicaEscultura == null)
            {
                return HttpNotFound();
            }
            return View(tecnicaEscultura);
        }

        // GET: TecnicaEsculturas/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: TecnicaEsculturas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTecnicaEscultura,nombre,descripcion,material,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TecnicaEscultura tecnicaEscultura)
        {
            if (ModelState.IsValid)
            {
                db.TecnicaEscultura.Add(tecnicaEscultura);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioModifica);
            return View(tecnicaEscultura);
        }

        // GET: TecnicaEsculturas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaEscultura tecnicaEscultura = db.TecnicaEscultura.Find(id);
            if (tecnicaEscultura == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioModifica);
            return View(tecnicaEscultura);
        }

        // POST: TecnicaEsculturas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTecnicaEscultura,nombre,descripcion,material,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TecnicaEscultura tecnicaEscultura)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tecnicaEscultura).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", tecnicaEscultura.idUsuarioModifica);
            return View(tecnicaEscultura);
        }

        // GET: TecnicaEsculturas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicaEscultura tecnicaEscultura = db.TecnicaEscultura.Find(id);
            if (tecnicaEscultura == null)
            {
                return HttpNotFound();
            }
            return View(tecnicaEscultura);
        }

        // POST: TecnicaEsculturas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TecnicaEscultura tecnicaEscultura = db.TecnicaEscultura.Find(id);
            db.TecnicaEscultura.Remove(tecnicaEscultura);
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
