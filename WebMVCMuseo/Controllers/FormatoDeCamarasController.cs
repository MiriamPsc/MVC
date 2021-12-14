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
    public class FormatoDeCamarasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: FormatoDeCamaras
        public ActionResult Index()
        {
            var formatoDeCamara = db.FormatoDeCamara.Include(f => f.Usuario).Include(f => f.Usuario1);
            return View(formatoDeCamara.ToList());
        }

        // GET: FormatoDeCamaras/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FormatoDeCamara formatoDeCamara = db.FormatoDeCamara.Find(id);
            if (formatoDeCamara == null)
            {
                return HttpNotFound();
            }
            return View(formatoDeCamara);
        }

        // GET: FormatoDeCamaras/Create
        public ActionResult Create()
        {
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: FormatoDeCamaras/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idFormatoDeCamara,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] FormatoDeCamara formatoDeCamara)
        {
            if (ModelState.IsValid)
            {
                db.FormatoDeCamara.Add(formatoDeCamara);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioModifica);
            return View(formatoDeCamara);
        }

        // GET: FormatoDeCamaras/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FormatoDeCamara formatoDeCamara = db.FormatoDeCamara.Find(id);
            if (formatoDeCamara == null)
            {
                return HttpNotFound();
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioModifica);
            return View(formatoDeCamara);
        }

        // POST: FormatoDeCamaras/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idFormatoDeCamara,nombre,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] FormatoDeCamara formatoDeCamara)
        {
            if (ModelState.IsValid)
            {
                db.Entry(formatoDeCamara).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", formatoDeCamara.idUsuarioModifica);
            return View(formatoDeCamara);
        }

        // GET: FormatoDeCamaras/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FormatoDeCamara formatoDeCamara = db.FormatoDeCamara.Find(id);
            if (formatoDeCamara == null)
            {
                return HttpNotFound();
            }
            return View(formatoDeCamara);
        }

        // POST: FormatoDeCamaras/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            FormatoDeCamara formatoDeCamara = db.FormatoDeCamara.Find(id);
            db.FormatoDeCamara.Remove(formatoDeCamara);
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
