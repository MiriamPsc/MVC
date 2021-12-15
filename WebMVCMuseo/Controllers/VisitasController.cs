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
    public class VisitasController : Controller
    {
        private MuseoEntities db = new MuseoEntities();

        // GET: Visitas
        public ActionResult Index()
        {
            var visita = db.Visita.Include(v => v.Boleto).Include(v => v.Empleado).Include(v => v.Grupo).Include(v => v.Usuario).Include(v => v.Usuario1).Include(v => v.Visita2).Include(v => v.Visitante);
            return View(visita.ToList());
        }

        // GET: Visitas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Visita visita = db.Visita.Find(id);
            if (visita == null)
            {
                return HttpNotFound();
            }
            return View(visita);
        }

        // GET: Visitas/Create
        public ActionResult Create()
        {
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo");
            ViewBag.idGuia = new SelectList(db.Empleado, "idEmpleado", "numero");
            ViewBag.idGrupo = new SelectList(db.Grupo, "idGrupo", "codigo");
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre");
            ViewBag.idTipoVisita = new SelectList(db.Visita, "idVisita", "codigo");
            ViewBag.idVisitante = new SelectList(db.Visitante, "idVisitante", "nombre");
            return View();
        }

        // POST: Visitas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idVisita,codigo,fecha,idTipoVisita,idVisitante,idBoleto,idGrupo,idGuia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Visita visita)
        {
            if (ModelState.IsValid)
            {
                db.Visita.Add(visita);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", visita.idBoleto);
            ViewBag.idGuia = new SelectList(db.Empleado, "idEmpleado", "numero", visita.idGuia);
            ViewBag.idGrupo = new SelectList(db.Grupo, "idGrupo", "codigo", visita.idGrupo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioModifica);
            ViewBag.idTipoVisita = new SelectList(db.Visita, "idVisita", "codigo", visita.idTipoVisita);
            ViewBag.idVisitante = new SelectList(db.Visitante, "idVisitante", "nombre", visita.idVisitante);
            return View(visita);
        }

        // GET: Visitas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Visita visita = db.Visita.Find(id);
            if (visita == null)
            {
                return HttpNotFound();
            }
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", visita.idBoleto);
            ViewBag.idGuia = new SelectList(db.Empleado, "idEmpleado", "numero", visita.idGuia);
            ViewBag.idGrupo = new SelectList(db.Grupo, "idGrupo", "codigo", visita.idGrupo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioModifica);
            ViewBag.idTipoVisita = new SelectList(db.Visita, "idVisita", "codigo", visita.idTipoVisita);
            ViewBag.idVisitante = new SelectList(db.Visitante, "idVisitante", "nombre", visita.idVisitante);
            return View(visita);
        }

        // POST: Visitas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idVisita,codigo,fecha,idTipoVisita,idVisitante,idBoleto,idGrupo,idGuia,estatus,idUsuarioCrea,fechaCrea,idUsuarioModifica,fechaModifica")] Visita visita)
        {
            if (ModelState.IsValid)
            {
                db.Entry(visita).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idBoleto = new SelectList(db.Boleto, "idBoleto", "codigo", visita.idBoleto);
            ViewBag.idGuia = new SelectList(db.Empleado, "idEmpleado", "numero", visita.idGuia);
            ViewBag.idGrupo = new SelectList(db.Grupo, "idGrupo", "codigo", visita.idGrupo);
            ViewBag.idUsuarioCrea = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioCrea);
            ViewBag.idUsuarioModifica = new SelectList(db.Usuario, "idUsuario", "nombre", visita.idUsuarioModifica);
            ViewBag.idTipoVisita = new SelectList(db.Visita, "idVisita", "codigo", visita.idTipoVisita);
            ViewBag.idVisitante = new SelectList(db.Visitante, "idVisitante", "nombre", visita.idVisitante);
            return View(visita);
        }

        // GET: Visitas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Visita visita = db.Visita.Find(id);
            if (visita == null)
            {
                return HttpNotFound();
            }
            return View(visita);
        }

        // POST: Visitas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Visita visita = db.Visita.Find(id);
            db.Visita.Remove(visita);
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
