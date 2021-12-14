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
    public class ArticuloesController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Articuloes
        public ActionResult Index()
        {
            var articulo = db.Articulo.Include(a => a.Categoria).Include(a => a.Proveedor).Include(a => a.TipoArticulo).Include(a => a.Usuario).Include(a => a.Usuario1);
            return View(articulo.ToList());
        }

        // GET: Articuloes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            return View(articulo);
        }

        // GET: Articuloes/Create
        public ActionResult Create()
        {
            ViewBag.idCategoria = new SelectList(db.Categoria, "idCategoria", "codigo");
            ViewBag.idProveedor = new SelectList(db.Proveedor, "idProveedor", "nombre");
            ViewBag.idTipoArticulo = new SelectList(db.TipoArticulo, "idTipoArticulo", "nombre");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            return View();
        }

        // POST: Articuloes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idArticulo,codigo,nombreArticulo,descripcion,precio,idCategoria,idTipoArticulo,idProveedor,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Articulo articulo)
        {
            if (ModelState.IsValid)
            {
                db.Articulo.Add(articulo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idCategoria = new SelectList(db.Categoria, "idCategoria", "codigo", articulo.idCategoria);
            ViewBag.idProveedor = new SelectList(db.Proveedor, "idProveedor", "nombre", articulo.idProveedor);
            ViewBag.idTipoArticulo = new SelectList(db.TipoArticulo, "idTipoArticulo", "nombre", articulo.idTipoArticulo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioModifica);
            return View(articulo);
        }

        // GET: Articuloes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            ViewBag.idCategoria = new SelectList(db.Categoria, "idCategoria", "codigo", articulo.idCategoria);
            ViewBag.idProveedor = new SelectList(db.Proveedor, "idProveedor", "nombre", articulo.idProveedor);
            ViewBag.idTipoArticulo = new SelectList(db.TipoArticulo, "idTipoArticulo", "nombre", articulo.idTipoArticulo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioModifica);
            return View(articulo);
        }

        // POST: Articuloes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idArticulo,codigo,nombreArticulo,descripcion,precio,idCategoria,idTipoArticulo,idProveedor,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Articulo articulo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(articulo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idCategoria = new SelectList(db.Categoria, "idCategoria", "codigo", articulo.idCategoria);
            ViewBag.idProveedor = new SelectList(db.Proveedor, "idProveedor", "nombre", articulo.idProveedor);
            ViewBag.idTipoArticulo = new SelectList(db.TipoArticulo, "idTipoArticulo", "nombre", articulo.idTipoArticulo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", articulo.idUsuarioModifica);
            return View(articulo);
        }

        // GET: Articuloes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            return View(articulo);
        }

        // POST: Articuloes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Articulo articulo = db.Articulo.Find(id);
            db.Articulo.Remove(articulo);
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
