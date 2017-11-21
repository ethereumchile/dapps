pragma solidity ^0.4.18;

contract dAuction {

    address public creador;
    uint public mejorOferta = 0;
    uint public fechaTerminoSubasta = block.timestamp + 1 week;
    uint public contadorOfertas = 0;
    address public ultimoOferente;
    
    struct Oferta {

        address oferente;
        uint valorOferta;
        uint fechaOferta;

    }
    
    mapping(uint => Oferta) public historialOfertas;
    
    function dAuction () public {

        creador = msg.sender;

    }
    
    function () public payable {

        address oferente = msg.sender;
        uint valorOferta = msg.value;

        if(oferente != ultimoOferente && valorOferta > mejorOferta && block.timestamp < fechaTerminoSubasta) {

            contadorOfertas++;
            Oferta memory ofertaTmp;
            ofertaTmp.oferente = oferente;
            ofertaTmp.valorOferta = valorOferta;
            ofertaTmp.fechaOferta = block.timestamp;
            historialOfertas[contadorOfertas] = ofertaTmp;
            address ultimoOferenteTmp = ultimoOferente;
            uint mejorOfertaTmp = mejorOferta;
            ultimoOferente = oferente;
            mejorOferta = valorOferta;
            ultimoOferenteTmp.transfer(mejorOfertaTmp);

        } else {

            revert();

        }

    }
    
    function retirarGanancia() public{
 
        if(block.timestamp >= fechaTerminoSubasta && msg.sender == creador){
            
            creador.transfer(this.balance);

        }
 
    }

}
