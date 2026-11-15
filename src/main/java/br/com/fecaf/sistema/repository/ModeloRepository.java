package br.com.fecaf.sistema.repository;

import br.com.fecaf.sistema.model.Modelo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ModeloRepository extends JpaRepository<Modelo, Long> {
    
    // Exemplo de busca personalizada: buscar todos os modelos de uma marca específica
    List<Modelo> findByMarcaId(Long marcaId);
}