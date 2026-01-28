package com.example.bdd_dto.service;

import com.example.bdd_dto.dto.PropietarioDTO;
import com.example.bdd_dto.model.Propietario;
import com.example.bdd_dto.repository.PropietarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PropietarioService {
    private final PropietarioRepository propietarioRepository;

    public PropietarioService(PropietarioRepository propietarioRepository) {
        this.propietarioRepository = propietarioRepository;
    }

    public PropietarioDTO crear(PropietarioDTO propietarioDTO) {
        if (propietarioDTO.getEdad() < 18) {
            throw new RuntimeException("El propietario debe ser mayor de edad");
        }

        String[] nombres = propietarioDTO.getNombreCompleto().split(" ");
        Propietario propietario = new Propietario();
        propietario.setNombre(nombres[0]);
        propietario.setApellido(nombres.length > 1 ? nombres[1] : "");
        propietario.setEdad(propietarioDTO.getEdad());

        Propietario guardado = propietarioRepository.save(propietario);
        return convertirADTO(guardado);
    }

    public List<PropietarioDTO> obtenerTodos() {
        return propietarioRepository.findAll().stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
    }

    public PropietarioDTO obtenerPorId(Long id) {
        Propietario propietario = propietarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado"));
        return convertirADTO(propietario);
    }

    public PropietarioDTO actualizar(Long id, PropietarioDTO propietarioDTO) {
        Propietario propietario = propietarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado"));

        String[] nombres = propietarioDTO.getNombreCompleto().split(" ");
        propietario.setNombre(nombres[0]);
        propietario.setApellido(nombres.length > 1 ? nombres[1] : "");
        propietario.setEdad(propietarioDTO.getEdad());

        Propietario actualizado = propietarioRepository.save(propietario);
        return convertirADTO(actualizado);
    }

    public void eliminar(Long id) {
        if (!propietarioRepository.existsById(id)) {
            throw new RuntimeException("Propietario no encontrado");
        }
        propietarioRepository.deleteById(id);
    }

    private PropietarioDTO convertirADTO(Propietario propietario) {
        PropietarioDTO dto = new PropietarioDTO();
        dto.setId(propietario.getId());
        dto.setNombreCompleto(propietario.getNombre() + " " + propietario.getApellido());
        dto.setEdad(propietario.getEdad());

        if (propietario.getAutomoviles() != null) {
            dto.setAutomovilIds(propietario.getAutomoviles().stream()
                    .map(a -> a.getId())
                    .collect(Collectors.toList()));
        }

        return dto;
    }
    public PropietarioDTO buscarPorNombre(String nombreCompleto) {
        // Intentar búsqueda exacta primero
        String[] partes = nombreCompleto.split(" ");
        String nombre = partes[0];
        String apellido = partes.length > 1 ? partes[1] : "";

        Optional<Propietario> propietarioOpt = Optional.empty();

        // 1. Búsqueda exacta por nombre y apellido
        if (!apellido.isEmpty()) {
            propietarioOpt = propietarioRepository.findByNombreAndApellido(nombre, apellido);
        }

        // 2. Si no encuentra, buscar por nombre parcial y tomar el primero
        if (propietarioOpt.isEmpty()) {
            List<Propietario> propietarios = propietarioRepository.findByNombreContainingIgnoreCase(nombreCompleto.trim());
            if (!propietarios.isEmpty()) {
                propietarioOpt = Optional.of(propietarios.get(0));
            }
        }

        // 3. Si no encuentra, buscar por apellido parcial y tomar el primero
        if (propietarioOpt.isEmpty()) {
            List<Propietario> propietarios = propietarioRepository.findByApellidoContainingIgnoreCase(nombreCompleto.trim());
            if (!propietarios.isEmpty()) {
                propietarioOpt = Optional.of(propietarios.get(0));
            }
        }

        Propietario propietario = propietarioOpt
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado con nombre: " + nombreCompleto));

        return convertirADTO(propietario);
    }

}