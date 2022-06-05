// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Pieza {
    enum TipoPieza {
        Jamon,
        Paletilla
    }

    struct Operador {
        string nombreOperador;
        string tipoOperador;
    }

    struct Ruta {
        string fechaInicio;
        string fechaFin;
        string[] paradas;
    }

    struct ProcesoPieza {
        Operador Operador;
        string tipoProceso;
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

    function addProceso(
        Operador memory _operador,
        string memory _tipoProceso,
        string memory _observaciones,
        string memory _fechaInicio,
        string memory _fechaFin,
        string[] memory _paradas
    ) public {
        Ruta memory ruta;

        if (compareStrings(_tipoProceso, "Transporte")) {
            ruta.fechaInicio = _fechaInicio;
            ruta.fechaFin = _fechaFin;
            ruta.paradas = _paradas;
        }
        ProcesoPieza memory proceso;

        proceso.Operador = _operador;
        proceso.tipoProceso = _tipoProceso;
        proceso.observaciones = _observaciones;
        proceso.ruta = ruta;

        procesoPieza.push(proceso);
    }

    function compareStrings(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
