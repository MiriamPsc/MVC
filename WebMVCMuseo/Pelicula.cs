//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebMVCMuseo
{
    using System;
    using System.Collections.Generic;
    
    public partial class Pelicula
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Pelicula()
        {
            this.ExhibicionPelicula = new HashSet<ExhibicionPelicula>();
        }
    
        public int idPelicula { get; set; }
        public string nombre { get; set; }
        public string año { get; set; }
        public int duracion { get; set; }
        public string tipo { get; set; }
        public int idDirector { get; set; }
        public int idFormatoDeCamara { get; set; }
        public int idClasificacion { get; set; }
        public int idIdioma { get; set; }
        public int idPais { get; set; }
        public int idDistribuidora { get; set; }
        public int idProductora { get; set; }
        public Nullable<bool> estatus { get; set; }
        public Nullable<int> idUsuarioCrea { get; set; }
        public Nullable<System.DateTime> fechaCrea { get; set; }
        public Nullable<int> idUsuarioModifica { get; set; }
        public Nullable<System.DateTime> fechaModifica { get; set; }
    
        public virtual Artista Artista { get; set; }
        public virtual Clasificacion Clasificacion { get; set; }
        public virtual Distribuidora Distribuidora { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExhibicionPelicula> ExhibicionPelicula { get; set; }
        public virtual FormatoDeCamara FormatoDeCamara { get; set; }
        public virtual Idioma Idioma { get; set; }
        public virtual Pais Pais { get; set; }
        public virtual Productora Productora { get; set; }
        public virtual Usuario Usuario { get; set; }
        public virtual Usuario Usuario1 { get; set; }
    }
}
