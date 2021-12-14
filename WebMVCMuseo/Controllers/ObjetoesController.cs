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
    public class ObjetoesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Objetoes
        public ActionResult Index()
        {
            var objeto = db.Objeto.Include(o => o.Pais).Include(o => o.Periodo).Include(o => o.TipoObjeto).Include(o => o.Usuario).Include(o => o.Usuario1);
            return View(objeto.ToList());
        }

        // GET: Objetoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Objeto objeto = db.Objeto.Find(id);
            if (objeto == null)
            {
                return HttpNotFound();
            }
            return View(objeto);
        }

        // GET: Objetoes/Create
        public ActionResult Create()
        {
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre");
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre");
            ViewBag.idTipoObjeto = new SelectList(db.TipoObjeto, "idTipoObjeto", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Objetoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idObjeto,nombre,descripcion,idTipoObjeto,idPeriodo,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Objeto objeto)
        {
            if (ModelState.IsValid)
            {
                db.Objeto.Add(objeto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", objeto.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", objeto.idPeriodo);
            ViewBag.idTipoObjeto = new SelectList(db.TipoObjeto, "idTipoObjeto", "nombre", objeto.idTipoObjeto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioModifica);
            return View(objeto);
        }

        // GET: Objetoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Objeto objeto = db.Objeto.Find(id);
            if (objeto == null)
            {
                return HttpNotFound();
            }
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", objeto.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", objeto.idPeriodo);
            ViewBag.idTipoObjeto = new SelectList(db.TipoObjeto, "idTipoObjeto", "nombre", objeto.idTipoObjeto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioModifica);
            return View(objeto);
        }

        // POST: Objetoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idObjeto,nombre,descripcion,idTipoObjeto,idPeriodo,idPais,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Objeto objeto)
        {
            if (ModelState.IsValid)
            {
                db.Entry(objeto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idPais = new SelectList(db.Pais, "idPais", "nombre", objeto.idPais);
            ViewBag.idPeriodo = new SelectList(db.Periodo, "idPeriodo", "nombre", objeto.idPeriodo);
            ViewBag.idTipoObjeto = new SelectList(db.TipoObjeto, "idTipoObjeto", "nombre", objeto.idTipoObjeto);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", objeto.idUsuarioModifica);
            return View(objeto);
        }

        // GET: Objetoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Objeto objeto = db.Objeto.Find(id);
            if (objeto == null)
            {
                return HttpNotFound();
            }
            return View(objeto);
        }

        // POST: Objetoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Objeto objeto = db.Objeto.Find(id);
            db.Objeto.Remove(objeto);
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
