package br.com.fecaf.sistema.controller;

import br.com.fecaf.sistema.model.Modelo;
import br.com.fecaf.sistema.services.ModeloService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/modelos")
@CrossOrigin(origins = "*")
public class ModeloController {

    @Autowired
    private ModeloService modeloService;

    // Cadastrar Modelo (POST)
    @PostMapping
    public ResponseEntity<Modelo> cadastrar(@RequestBody Modelo modelo) {
        Modelo novoModelo = modeloService.salvar(modelo);
        return ResponseEntity.ok(novoModelo);
    }

    // Listar todos os Modelos (GET)
    @GetMapping
    public ResponseEntity<List<Modelo>> listar() {
        List<Modelo> modelos = modeloService.listarTodos();
        return ResponseEntity.ok(modelos);
    }

    // Listar Modelos por Marca (GET)
    // Exemplo: GET http://localhost:8080/api/modelos/marca/1
    @GetMapping("/marca/{marcaId}")
    public ResponseEntity<List<Modelo>> listarPorMarca(@PathVariable Long marcaId) {
        List<Modelo> modelos = modeloService.listarPorMarca(marcaId);
        return ResponseEntity.ok(modelos);
    }
}