package br.com.fecaf.sistema.model;

import jakarta.persistence.*;

@Entity
@Table(name = "marca", uniqueConstraints = {
    @UniqueConstraint(name = "uk_marca_nome", columnNames = "nome")
})
public class Marca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // Usei Long porque no SQL é BIGINT

    @Column(nullable = false, length = 80)
    private String nome;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
}