package modelo;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Grupo {
    private int id;
    private String nombre;
    private String carrera;
    private int numeroGrupo;
    private Timestamp fechaCreacion;
    

    public Grupo() {}
    private List<Usuario> estudiantes = new ArrayList<>();

public List<Usuario> getEstudiantes() {
    return estudiantes;
}

public void setEstudiantes(List<Usuario> estudiantes) {
    this.estudiantes = estudiantes;
}
    
    public Grupo(String nombre, String carrera, int numeroGrupo) {
        this.nombre = nombre;
        this.carrera = carrera;
        this.numeroGrupo = numeroGrupo;
    }
    
    // Getters y Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getCarrera() {
        return carrera;
    }
    
    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }
    
    public int getNumeroGrupo() {
        return numeroGrupo;
    }
    
    public void setNumeroGrupo(int numeroGrupo) {
        this.numeroGrupo = numeroGrupo;
    }
    
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    @Override
    public String toString() {
        return "Grupo{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", carrera='" + carrera + '\'' +
                ", numeroGrupo=" + numeroGrupo +
                ", fechaCreacion=" + fechaCreacion +
                '}';
    }
}