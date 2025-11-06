package modelo;

public class UsuarioConRol extends Usuario {

    private String nombreRol;

    public UsuarioConRol() {
        super();
    }

    public UsuarioConRol(Usuario usuario, String nombreRol) {
        this.setId(usuario.getId());
        this.setCorreo(usuario.getCorreo());
        this.setPassword(usuario.getPassword());
        this.setNombre(usuario.getNombre());
        this.setApellido(usuario.getApellido());
        this.setIdRol(usuario.getIdRol());
        this.nombreRol = nombreRol;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }

    public String getRol() {
        return nombreRol;
    }

    public void setRol(String rol) {
        this.nombreRol = rol;
    }
}
