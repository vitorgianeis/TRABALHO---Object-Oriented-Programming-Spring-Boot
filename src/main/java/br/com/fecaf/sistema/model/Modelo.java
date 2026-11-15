package br.com.fecaf.sistema.model;

import jakarta.persistence.*;

@Entity
@Table(name = "modelo", uniqueConstraints = {
    @UniqueConstraint(name = "uk_modelo_marca_nome", columnNames = {"marca_id", "nome"})
})
public class Modelo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 80)
    private String nome;

    @ManyToOne // Muitos modelos para uma marca
    @JoinColumn(name = "marca_id", nullable = false, 
                foreignKey = @ForeignKey(name = "fk_modelo_marca"))
    private Marca marca;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public Marca getMarca() { return marca; }
    public void setMarca(Marca marca) { this.marca = marca; }
}