package br.com.fecaf.sistema.controller;

import br.com.fecaf.sistema.model.Marca;
import br.com.fecaf.sistema.services.MarcaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/marcas")
@CrossOrigin(origins = "*")
public class MarcaController {

    @Autowired
    private MarcaService marcaService;

    // Cadastrar Marca (POST)
    @PostMapping
    public ResponseEntity<Marca> cadastrar(@RequestBody Marca marca) {
        Marca novaMarca = marcaService.salvar(marca);
        return ResponseEntity.ok(novaMarca);
    }

    // Listar todas as Marcas (GET)
    @GetMapping
    public ResponseEntity<List<Marca>> listar() {
        List<Marca> marcas = marcaService.listarTodas();
        return ResponseEntity.ok(marcas);
    }
}