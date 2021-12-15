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
    public class TipoGrupoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: TipoGrupoes
        public ActionResult Index()
        {
            return View(db.TipoGrupo.ToList());
        }

        // GET: TipoGrupoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoGrupo tipoGrupo = db.TipoGrupo.Find(id);
            if (tipoGrupo == null)
            {
                return HttpNotFound();
            }
            return View(tipoGrupo);
        }

        // GET: TipoGrupoes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TipoGrupoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idTipoGrupo,nombre,numeroMaximo,numeroMinimo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoGrupo tipoGrupo)
        {
            if (ModelState.IsValid)
            {
                db.TipoGrupo.Add(tipoGrupo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tipoGrupo);
        }

        // GET: TipoGrupoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoGrupo tipoGrupo = db.TipoGrupo.Find(id);
            if (tipoGrupo == null)
            {
                return HttpNotFound();
            }
            return View(tipoGrupo);
        }

        // POST: TipoGrupoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idTipoGrupo,nombre,numeroMaximo,numeroMinimo,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] TipoGrupo tipoGrupo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tipoGrupo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tipoGrupo);
        }

        // GET: TipoGrupoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TipoGrupo tipoGrupo = db.TipoGrupo.Find(id);
            if (tipoGrupo == null)
            {
                return HttpNotFound();
            }
            return View(tipoGrupo);
        }

        // POST: TipoGrupoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TipoGrupo tipoGrupo = db.TipoGrupo.Find(id);
            db.TipoGrupo.Remove(tipoGrupo);
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
