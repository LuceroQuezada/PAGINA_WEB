package modelo;

public class Preinscripcion {

    private int id;
    private String nombres, apellidos, correo, dni,
            telefono, direccion, colegio, carrera, estado;

private int intentos;

    

    public Preinscripcion() {
    }

    public Preinscripcion(String nombres, String apellidos, String correo, String dni,
            String telefono, String direccion, String colegio, String carrera) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.dni = dni;
        this.telefono = telefono;
        this.direccion = direccion;
        this.colegio = colegio;
        this.carrera = carrera;
        this.estado = "pendiente";
    }

    public Preinscripcion(int intentos) {
        this.intentos = intentos;
    }

    public int getIntentos() {
        return intentos;
    }

    public void setIntentos(int intentos) {
        this.intentos = intentos;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getColegio() {
        return colegio;
    }

    public void setColegio(String colegio) {
        this.colegio = colegio;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
