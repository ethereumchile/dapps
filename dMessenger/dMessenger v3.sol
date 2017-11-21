pragma solidity ^0.4.18;

contract dMessenger {
	
	address public creador;
	uint public contadorMensajes = 0;

	struct Mensaje {
	
		address emisor;
		string mensaje;
		uint fechaPublicacion;

	}
	
	mapping(address => bool) private participantes;
	mapping(uint => Mensaje) public mensajes;
	
	function dMessenger () public {

		creador = msg.sender;
		participantes[0x98664d1d2de462601196674260ae0a3d19f1cf90] = true;
		participantes[0x785c5cAC1A72255F41821ECa69Dc77138a54D230] = true;

	}
	
	function escribirMensaje(string mensaje) public {

		if(participantes[msg.sender]) {

			mensajes[contadorMensajes].emisor = msg.sender;
			mensajes[contadorMensajes].mensaje = mensaje;
			mensajes[contadorMensajes].fechaPublicacion = block.timestamp;
			contadorMensajes++;

		} else {

			revert();

		}

	}

}
