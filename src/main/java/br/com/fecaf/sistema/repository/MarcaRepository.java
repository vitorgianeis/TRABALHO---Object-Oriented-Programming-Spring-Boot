package br.com.fecaf.sistema.repository;

import br.com.fecaf.sistema.model.Marca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MarcaRepository extends JpaRepository<Marca, Long> {
    // O Spring já cria automaticamente: salvar, buscarTodos, buscarPorId, deletar.
}