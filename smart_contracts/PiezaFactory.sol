// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./Pieza.sol";

contract PiezaFactory {
    /*
        Proceso para la creacion de un jamon sobre el que queremos hacer el seguimiento:
        ********************************************************************************
            1- Ganadero vende X animales a un matadero.
            2- Transportista recoge los animales desde la granja del ganadero y los lleva al matadero correspondiente   
            3- En el matadero el personal lleva a cabo el sacrifio y despiece de los animales -> Genera las piezas (jamones)
            4- Transportista lleva los jamones a un centro de secado
            5- El personal del centro de secado lleva a cabo el tratamiento
            6- Transportista lleva los jamones desde el centro de secado a almacen de distribuidor
*/
    enum TipoRaza {
        SD,
        Iberico50,
        Iberico75,
        Iberico100,
        Blanco
    }
    /*
        SD -> SD
        Ibericos -> Cebo, Cebo de Campo y Bellota
        Blanco -> Semigraso y Graso 
    */
    enum TipoCalidad {
        SD,
        CeboCampo,
        Cebo,
        Bellota,
        Semigraso,
        Graso
    }
    struct Matanza {
        uint256 loteSacrificio;
        string region;
        string marca;
        TipoRaza raza;
        TipoCalidad calidad;
        string fechaSacrificio;
        Pieza.Operador ganadero;
        Pieza.Operador transportista;
        uint256 cantidadTipo0;
        uint256 cantidadTipo1;
    }

    uint256 idPiezas = 1;
    uint256 idMatanza = 1;

    Matanza[] public matanzas; // Se rellena con todas las matanzas llevadas a cabo
    Pieza[] public piezas; // Se rellenará con las piezas creadas en el proceso tipo Sacrificio.
    mapping(uint256 => uint256) public piezaToMatanza; // Guarda a que matanza pertenece cada pieza

    // Funciones
    function crearMatanza(
        string memory _region,
        string memory _marca,
        TipoRaza _raza,
        TipoCalidad _calidad,
        string memory _fechaSacrificio,
        Pieza.Operador memory _ganadero,
        Pieza.Operador memory _transportista,
        uint256 _cantidadTipo0,
        uint256 _cantidadTipo1
    ) public {
        // Rellenar datos relativos a la matanza
        matanzas.push(
            Matanza(
                idMatanza,
                _region,
                _marca,
                _raza,
                _calidad,
                _fechaSacrificio,
                _ganadero,
                _transportista,
                _cantidadTipo0,
                _cantidadTipo1
            )
        );
        // Crear el numero de piezas indicadas del tipo indicado
        addPiezaToMatanza(idMatanza, _cantidadTipo0, _cantidadTipo1);
        idMatanza += 1; // Aumenta el id de la matanza para que la siguiente no tenga el mismo id
    }

    function addPiezaToMatanza(
        uint256 _idMatanza,
        uint256 _cantidadTipo0,
        uint256 _cantidadTipo1
    ) public {
        // Crear el numero de piezas indicadas del tipo indicado
        if (_cantidadTipo0 != 0) {
            Pieza.TipoPieza tipoNuevaPieza = Pieza.TipoPieza.Jamon;
            for (uint256 i = 0; i < _cantidadTipo0; i++) {
                Pieza nuevaPieza = new Pieza(idPiezas, tipoNuevaPieza);
                piezas.push(nuevaPieza);
                piezaToMatanza[idPiezas] = _idMatanza;
                idPiezas += 1;
            }
        } else if (_cantidadTipo1 != 0) {
            Pieza.TipoPieza tipoNuevaPieza = Pieza.TipoPieza.Paletilla;
            for (uint256 i = 0; i < _cantidadTipo1; i++) {
                Pieza nuevaPieza = new Pieza(idPiezas, tipoNuevaPieza);
                piezas.push(nuevaPieza);
                piezaToMatanza[idPiezas] = _idMatanza;
                idPiezas += 1;
            }
        }
    }

    function trazabilidadPieza(uint256 _idPieza) public {}
}
