pragma solidity ^0.4.18;

contract dMessenger {
	
	address public creador;
	uint public contadorMensajes = 0;
	struct Mensaje {
	    address emisor;
	    string mensaje;
	    uint fechaPublicacion;
	}
	mapping(uint => Mensaje) public mensajes;
	
	function dMessenger () public {

		creador = msg.sender;

	}
	
	function escribirMensaje(string mensaje) public payable {

	    uint monto = msg.value;
	    if(monto == 13378 szabo) { // 13378 szabo == 0.013378 ether
            
            mensajes[contadorMensajes].emisor = msg.sender;
            mensajes[contadorMensajes].mensaje = mensaje;
            mensajes[contadorMensajes].fechaPublicacion = block.timestamp;
            contadorMensajes++;
            msg.sender.transfer(msg.value);

	    } else {

	        revert();

	    }

	}
	

}
