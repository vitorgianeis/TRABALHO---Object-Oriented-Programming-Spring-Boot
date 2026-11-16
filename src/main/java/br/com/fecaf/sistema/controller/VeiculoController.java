package br.com.fecaf.sistema.controller;

import br.com.fecaf.sistema.model.Veiculo;
import br.com.fecaf.sistema.services.VeiculoService;
import br.com.fecaf.sistema.repository.VeiculoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//
// temos a camada REST. 
// O VeiculoController é responsável por receber as requisições HTTP (GET, POST, PUT, DELETE) do nosso Frontend, processar os dados em formato JSON e devolver as respostas."
@RestController
@RequestMapping("/api/veiculos")
@CrossOrigin(origins = "*")
public class VeiculoController {

    @Autowired
    private VeiculoService veiculoService;

    @Autowired
    private VeiculoRepository veiculoRepository; // Necessário para o Dashboard

    //cadastar um veiculo
    @PostMapping
    public Veiculo cadastrar(@RequestBody Veiculo veiculo) {
        return veiculoService.salvar(veiculo);
    }
    //listar veiculos
    @GetMapping
    public List<Veiculo> filtrar(
            @RequestParam(required = false) Long marcaId,
            @RequestParam(required = false) Long modeloId,
            @RequestParam(required = false) BigDecimal precoMax,
            @RequestParam(required = false) Integer ano,
            @RequestParam(required = false) String status) {
        return veiculoService.filtrar(marcaId, modeloId, precoMax, ano, status);
    }

    //alterar os dados do veiculo
    @PutMapping("/{id}")
    public ResponseEntity<Veiculo> atualizar(@PathVariable Long id, @RequestBody Veiculo dadosAtualizados) {
        try {
            Veiculo veiculoAtualizado = veiculoService.atualizar(id, dadosAtualizados);
            return ResponseEntity.ok(veiculoAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    //excluir ou remover do estoque
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletar(@PathVariable Long id) {
        try {
             // ABSTRAÇÃO: O Controller não sabe o que acontece aqui dentro.
            // Ele apenas delega a responsabilidade para o Service
            veiculoService.deletar(id);
            return ResponseEntity.ok("Veículo removido com sucesso!");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // --- ENDPOINT DO DASHBOARD ---
    @GetMapping("/dashboard")
    public ResponseEntity<Map<String, Object>> obterDashboard() {
        long totalVeiculos = veiculoRepository.count(); 
        long disponiveis = veiculoRepository.countByStatus("DISPONIVEL");
        BigDecimal valorTotal = veiculoRepository.somarValorTotalEstoque();

        if (valorTotal == null) {
            valorTotal = BigDecimal.ZERO;
        }

        Map<String, Object> resumo = new HashMap<>();
        resumo.put("totalVeiculos", totalVeiculos);
        resumo.put("disponiveis", disponiveis);
        resumo.put("valorTotal", valorTotal);

        return ResponseEntity.ok(resumo);
    }
}