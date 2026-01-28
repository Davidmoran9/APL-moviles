package com.example.bdd_dto.controller;

import com.example.bdd_dto.dto.*;
import com.example.bdd_dto.service.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/poliza")
@CrossOrigin(origins = "*", maxAge = 3600)
public class PolizaController {

    private final PropietarioService propietarioService;
    private final AutomovilService automovilService;
    private final SeguroService seguroService;

    public PolizaController(PropietarioService propietarioService, AutomovilService automovilService, SeguroService seguroService) {
        this.propietarioService = propietarioService;
        this.automovilService = automovilService;
        this.seguroService = seguroService;
    }

    @PostMapping
    public ResponseEntity<PolizaResponse> crearPoliza(@RequestBody PolizaRequest req) {
        // Crear propietario
        PropietarioDTO propietarioDTO = propietarioService.crear(
                new PropietarioDTO(null, req.getPropietario(), req.getEdadPropietario(), null)
        );

        // Crear auto
        AutomovilDTO autoDTO = new AutomovilDTO(null, req.getModeloAuto(), req.getValorSeguroAuto(),
                req.getAccidentes(), propietarioDTO.getId(), null, null, null);
        autoDTO = automovilService.crear(autoDTO);

        // Obtener seguro
        SeguroDTO seguroDTO = seguroService.obtenerPorAutomovilId(autoDTO.getId());

        // Armar respuesta
        PolizaResponse response = new PolizaResponse(
                propietarioDTO.getNombreCompleto(),
                autoDTO.getModelo(),
                autoDTO.getValor(),
                propietarioDTO.getEdad(),
                autoDTO.getAccidentes(),
                seguroDTO.getCostoTotal()
        );

        return ResponseEntity.ok(response);
    }

    @GetMapping("/usuario")
    public ResponseEntity<?> obtenerPolizaPorNombre(@RequestParam String nombre) {
        try {
            // Buscar propietario por nombre
            PropietarioDTO propietarioDTO = propietarioService.buscarPorNombre(nombre);

            // Obtener auto más reciente del propietario
            Long propietarioId = propietarioDTO.getId();
            AutomovilDTO autoDTO;
            try {
                autoDTO = automovilService.obtenerPorPropietarioId(propietarioId);
            } catch (RuntimeException e) {
                return ResponseEntity.badRequest()
                    .body("El propietario " + propietarioDTO.getNombreCompleto() + " no tiene automóviles registrados");
            }

            // Obtener seguro
            SeguroDTO seguroDTO;
            try {
                seguroDTO = seguroService.obtenerPorAutomovilId(autoDTO.getId());
            } catch (RuntimeException e) {
                return ResponseEntity.badRequest()
                    .body("El automóvil del propietario " + propietarioDTO.getNombreCompleto() + " no tiene seguro registrado");
            }

            // Armar respuesta
            PolizaResponse response = new PolizaResponse(
                    propietarioDTO.getNombreCompleto(),
                    autoDTO.getModelo(),
                    autoDTO.getValor(),
                    propietarioDTO.getEdad(),
                    autoDTO.getAccidentes(),
                    seguroDTO.getCostoTotal()
            );

            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
