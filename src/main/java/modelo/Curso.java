package modelo;

public class Curso {

    private int id;
    private String nombre;
    private String carrera;

    public Curso() {
    }

    public Curso(int id, String nombre, String carrera) {
        this.id = id;
        this.nombre = nombre;
        this.carrera = carrera;
    }

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
}
