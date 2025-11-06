package modelo;

import java.sql.Timestamp;

public class MaterialCurso {

    private int id;
    private int idUsuario;      
    private Integer idCurso;    
    private Integer idSeccion;  
    private String titulo;
    private String descripcion;
    private String archivo;      
    private String tipo;        
    private Timestamp fechaSubida;

    private String cursoNombre;
    private String usuarioNombres;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Integer getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(Integer idCurso) {
        this.idCurso = idCurso;
    }

    public Integer getIdSeccion() {
        return idSeccion;
    }

    public void setIdSeccion(Integer idSeccion) {
        this.idSeccion = idSeccion;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Timestamp getFechaSubida() {
        return fechaSubida;
    }

    public void setFechaSubida(Timestamp fechaSubida) {
        this.fechaSubida = fechaSubida;
    }

    public String getCursoNombre() {
        return cursoNombre;
    }

    public void setCursoNombre(String cursoNombre) {
        this.cursoNombre = cursoNombre;
    }

    public String getUsuarioNombres() {
        return usuarioNombres;
    }

    public void setUsuarioNombres(String usuarioNombres) {
        this.usuarioNombres = usuarioNombres;
    }

    public String getNombreOriginal() {
        if (archivo != null && archivo.contains("_")) {
            return archivo.substring(archivo.indexOf("_") + 1);
        }
        return archivo;
    }

    public String getIcono() {
        switch (tipo) {
            case "PDF":
                return "fas fa-file-pdf text-danger";
            case "DOC":
                return "fas fa-file-word text-primary";
            case "IMG":
                return "fas fa-file-image text-success";
            case "VIDEO":
                return "fas fa-file-video text-warning";
            case "ZIP":
                return "fas fa-file-archive text-secondary";
            default:
                return "fas fa-file text-muted";
        }
    }
}
