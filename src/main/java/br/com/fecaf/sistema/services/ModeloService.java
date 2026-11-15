package br.com.fecaf.sistema.services;

import br.com.fecaf.sistema.model.Modelo;
import br.com.fecaf.sistema.repository.ModeloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModeloService {

    @Autowired
    private ModeloRepository modeloRepository;

    public Modelo salvar(Modelo modelo) {
        return modeloRepository.save(modelo);
    }

    public List<Modelo> listarTodos() {
        return modeloRepository.findAll();
    }

    public List<Modelo> listarPorMarca(Long marcaId) {
        return modeloRepository.findByMarcaId(marcaId);
    }
}