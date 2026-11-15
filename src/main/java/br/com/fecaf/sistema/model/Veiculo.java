package br.com.fecaf.sistema.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "veiculo", indexes = {
    @Index(name = "idx_veiculo_status", columnList = "status"),
    @Index(name = "idx_veiculo_ano", columnList = "ano")
})
public class Veiculo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne // Muitos veículos para um modelo
    @JoinColumn(name = "modelo_id", nullable = false, 
                foreignKey = @ForeignKey(name = "fk_veiculo_modelo"))
    private Modelo modelo;

    @Column(nullable = false)
    private Integer ano;

    @Column(nullable = false, length = 40)
    private String cor;

    @Column(nullable = false, precision = 12, scale = 2)
    private BigDecimal preco;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal quilometragem;

    @Column(nullable = false, length = 20)
    private String status = "DISPONIVEL";

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Modelo getModelo() { return modelo; }
    public void setModelo(Modelo modelo) { this.modelo = modelo; }
    public Integer getAno() { return ano; }
    public void setAno(Integer ano) { this.ano = ano; }
    public String getCor() { return cor; }
    public void setCor(String cor) { this.cor = cor; }
    public BigDecimal getPreco() { return preco; }
    public void setPreco(BigDecimal preco) { this.preco = preco; }
    public BigDecimal getQuilometragem() { return quilometragem; }
    public void setQuilometragem(BigDecimal quilometragem) { this.quilometragem = quilometragem; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }



    @Column(name = "foto_url")
    private String fotoUrl;

    public String getFotoUrl() { return fotoUrl; }
    public void setFotoUrl(String fotoUrl) { this.fotoUrl = fotoUrl; }
}
