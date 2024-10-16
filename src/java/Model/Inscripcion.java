/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author rendo
 */
public class Inscripcion {
    private int id_estudiante;
    private int id_curso;
    private Timestamp fecha;

    public Inscripcion() {
    }

    public Inscripcion(int id_estudiante, int id_curso, Timestamp fecha) {
        this.id_estudiante = id_estudiante;
        this.id_curso = id_curso;
        this.fecha = fecha;
    }

    public int getId_estudiante() {
        return id_estudiante;
    }

    public void setId_estudiante(int id_estudiante) {
        this.id_estudiante = id_estudiante;
    }

    public int getId_curso() {
        return id_curso;
    }

    public void setId_curso(int id_curso) {
        this.id_curso = id_curso;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "Inscripcion{" + "id_estudiante=" + id_estudiante + ", id_curso=" + id_curso + ", fecha=" + fecha + '}';
    }
    
    
    
}
