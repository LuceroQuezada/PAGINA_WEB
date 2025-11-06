package modelo;
public class Horario {
    private int id, idCursoDocente;
    private String dia, horaInicio, horaFin;
    


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCursoDocente() {
        return idCursoDocente;
    }

    public void setIdCursoDocente(int idCursoDocente) {
        this.idCursoDocente = idCursoDocente;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(String horaFin) {
        this.horaFin = horaFin;
    }
}