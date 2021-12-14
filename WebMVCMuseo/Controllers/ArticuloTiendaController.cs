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
    public class ArticuloTiendaController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: ArticuloTienda
        public ActionResult Index()
        {
            var articuloTienda = db.ArticuloTienda.Include(a => a.Articulo).Include(a => a.Tienda).Include(a => a.Usuario).Include(a => a.Usuario1);
            return View(articuloTienda.ToList());
        }

        // GET: ArticuloTienda/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArticuloTienda articuloTienda = db.ArticuloTienda.Find(id);
            if (articuloTienda == null)
            {
                return HttpNotFound();
            }
            return View(articuloTienda);
        }

        // GET: ArticuloTienda/Create
        public ActionResult Create()
        {
            ViewBag.idArticulo = new SelectList(db.Articulo, "idArticulo", "codigo");
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: ArticuloTienda/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idArticuloTienda,idArticulo,idTienda,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ArticuloTienda articuloTienda)
        {
            if (ModelState.IsValid)
            {
                db.ArticuloTienda.Add(articuloTienda);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idArticulo = new SelectList(db.Articulo, "idArticulo", "codigo", articuloTienda.idArticulo);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", articuloTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioModifica);
            return View(articuloTienda);
        }

        // GET: ArticuloTienda/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArticuloTienda articuloTienda = db.ArticuloTienda.Find(id);
            if (articuloTienda == null)
            {
                return HttpNotFound();
            }
            ViewBag.idArticulo = new SelectList(db.Articulo, "idArticulo", "codigo", articuloTienda.idArticulo);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", articuloTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioModifica);
            return View(articuloTienda);
        }

        // POST: ArticuloTienda/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idArticuloTienda,idArticulo,idTienda,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] ArticuloTienda articuloTienda)
        {
            if (ModelState.IsValid)
            {
                db.Entry(articuloTienda).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idArticulo = new SelectList(db.Articulo, "idArticulo", "codigo", articuloTienda.idArticulo);
            ViewBag.idTienda = new SelectList(db.Tienda, "idTienda", "codigo", articuloTienda.idTienda);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articuloTienda.idUsuarioModifica);
            return View(articuloTienda);
        }

        // GET: ArticuloTienda/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ArticuloTienda articuloTienda = db.ArticuloTienda.Find(id);
            if (articuloTienda == null)
            {
                return HttpNotFound();
            }
            return View(articuloTienda);
        }

        // POST: ArticuloTienda/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ArticuloTienda articuloTienda = db.ArticuloTienda.Find(id);
            db.ArticuloTienda.Remove(articuloTienda);
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
