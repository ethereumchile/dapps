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

	function escribirMensaje(string mensaje) public {

		mensajes[contadorMensajes].emisor = msg.sender;
		mensajes[contadorMensajes].mensaje = mensaje;
		mensajes[contadorMensajes].fechaPublicacion = block.timestamp;
		contadorMensajes++;

	}

}
