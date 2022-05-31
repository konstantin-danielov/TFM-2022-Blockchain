// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Pieza {
    enum TipoPieza {
        Jamon,
        Paletilla
    }
    enum TipoProceso {
        Transporte,
        Secado,
        Almacenamiento,
        VentaPieza
    }
    enum TipoOperario {
        Transportista,
        PersonalMatadero,
        PersonalSecadero,
        PersonalAlmacen
    }

    struct Operario {
        string nombre;
        TipoOperario tipoOperario;
    }

    struct Ruta {
        string fechaInicio;
        string fechaFin;
        string[] paradas;
    }

    struct ProcesoPieza {
        Operario operario;
        TipoProceso tipoProceso;
        string observaciones;
        Ruta ruta; // Solo se usa para el tipo Transporte
    }

    uint256 id;
    TipoPieza tipoPieza;
    ProcesoPieza[] public procesoPieza;

    //Funciones
    constructor(uint256 _id, TipoPieza _tipoPieza) {
        id = _id;
        tipoPieza = _tipoPieza;
    }

    function addProcesoToPieza(
        Operario memory _operario,
        TipoProceso _tipoProceso,
        string memory _observaciones,
        string memory _fechaInicio,
        string memory _fechaFin,
        string[] memory _paradas
    ) public {
        Ruta memory ruta;

        if (_tipoProceso == TipoProceso.Transporte) {
            ruta.fechaInicio = _fechaInicio;
            ruta.fechaFin = _fechaFin;
            ruta.paradas = _paradas;
        }
        ProcesoPieza memory proceso;

        proceso.operario = _operario;
        proceso.tipoProceso = _tipoProceso;
        proceso.observaciones = _observaciones;
        proceso.ruta = ruta;

        procesoPieza.push(proceso);
    }
}
