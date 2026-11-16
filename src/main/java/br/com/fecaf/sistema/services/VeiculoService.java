package br.com.fecaf.sistema.services; 

import br.com.fecaf.sistema.model.Veiculo;
import br.com.fecaf.sistema.repository.VeiculoRepository; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

//fica a camada de regras de negócio. 
// É aqui que o sistema valida se um carro pode ou não ser excluído, por exemplo."
@Service
public class VeiculoService {

    @Autowired
    private VeiculoRepository veiculoRepository;

    // Cadastrar
    public Veiculo salvar(Veiculo veiculo) {
        return veiculoRepository.save(veiculo);
    }

    // Consulta com Filtro
    public List<Veiculo> filtrar(Long marcaId, Long modeloId, BigDecimal precoMax, Integer ano, String status) {
        return veiculoRepository.filtrarVeiculos(marcaId, modeloId, precoMax, ano, status);
    }

    // Atualização de Informações (Regra de Negócio)
    public Veiculo atualizar(Long id, Veiculo dadosAtualizados) {
        Veiculo veiculo = veiculoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Veículo não encontrado com o ID: " + id));

        if (dadosAtualizados.getPreco() != null) {
            veiculo.setPreco(dadosAtualizados.getPreco());
        }
        if (dadosAtualizados.getQuilometragem() != null) {
            veiculo.setQuilometragem(dadosAtualizados.getQuilometragem());
        }
        if (dadosAtualizados.getStatus() != null) {
            veiculo.setStatus(dadosAtualizados.getStatus());
        }

        return veiculoRepository.save(veiculo);
    }

    // Remoção com Regra de Negócio (Só deleta se estiver VENDIDO ou DESCONTINUADO)
    public void deletar(Long id) {
        // 1. Busca o veículo no banco
        Veiculo veiculo = veiculoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Veículo não encontrado para exclusão."));

        // 2. Verifica a regra: Não pode deletar se estiver no estoque (DISPONIVEL ou RESERVADO)
        if ("DISPONIVEL".equalsIgnoreCase(veiculo.getStatus()) || "RESERVADO".equalsIgnoreCase(veiculo.getStatus())) {
            throw new RuntimeException("Não é possível excluir um veículo no estoque. Altere para VENDIDO ou DESCONTINUADO primeiro.");
        }

        // 3. Se passou pela regra (ou seja, está VENDIDO ou DESCONTINUADO), deleta
        veiculoRepository.deleteById(id);
    }
}