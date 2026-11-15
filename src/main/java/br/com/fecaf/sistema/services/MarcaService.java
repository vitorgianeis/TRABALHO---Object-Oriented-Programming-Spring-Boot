package br.com.fecaf.sistema.services;

import br.com.fecaf.sistema.model.Marca;
import br.com.fecaf.sistema.repository.MarcaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MarcaService {

    @Autowired
    private MarcaRepository marcaRepository;

    public Marca salvar(Marca marca) {
        return marcaRepository.save(marca);
    }

    public List<Marca> listarTodas() {
        return marcaRepository.findAll();
    }
}