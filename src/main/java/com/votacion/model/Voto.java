package com.votacion.model;

import java.time.LocalDateTime;

/**
 * Representa un voto emitido en una encuesta.
 */
public class Voto {

    private int id;
    private int encuestaId;
    private String opcion;
    private String nombre;
    private LocalDateTime fecha;

    public Voto() {}

    public Voto(String opcion, String nombre) {
        this.opcion = opcion;
        this.nombre = nombre;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEncuestaId() { return encuestaId; }
    public void setEncuestaId(int encuestaId) { this.encuestaId = encuestaId; }

    public String getOpcion() { return opcion; }
    public void setOpcion(String opcion) { this.opcion = opcion; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
}
