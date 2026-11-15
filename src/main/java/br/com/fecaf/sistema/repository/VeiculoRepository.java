package br.com.fecaf.sistema.repository; // (ou .repository)

import br.com.fecaf.sistema.model.Veiculo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface VeiculoRepository extends JpaRepository<Veiculo, Long> {

    // Consulta customizada para os Filtros
    @Query("SELECT v FROM Veiculo v " +
           "JOIN v.modelo m " +
           "JOIN m.marca ma " +
           "WHERE (:marcaId IS NULL OR ma.id = :marcaId) " +
           "AND (:modeloId IS NULL OR m.id = :modeloId) " +
           "AND (:precoMax IS NULL OR v.preco <= :precoMax) " +
           "AND (:ano IS NULL OR v.ano = :ano) " +
           "AND (:status IS NULL OR v.status = :status)")
    List<Veiculo> filtrarVeiculos(
            @Param("marcaId") Long marcaId,
            @Param("modeloId") Long modeloId,
            @Param("precoMax") BigDecimal precoMax,
            @Param("ano") Integer ano,
            @Param("status") String status
    );

    // --- MÉTODOS DO DASHBOARD ---
    
    // Conta quantos veículos têm um status específico
    long countByStatus(String status);

    // Soma o preço de todos os veículos com status DISPONIVEL
    @Query("SELECT SUM(v.preco) FROM Veiculo v WHERE v.status = 'DISPONIVEL'")
    BigDecimal somarValorTotalEstoque();
}