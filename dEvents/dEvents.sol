pragma solidity ^0.4.18;
/*
Autor: Javier Guajardo.
Website: https://ethereumchile.cl
Twitter: @ethereumchile
*/
contract dEvents {
	
	address public creadorEvento; // msg.sender u otro
	uint public valorEntradas = 10 finney; // 0.01 ETH
	uint public numeroEntradas = 9999; // 9999 entradas disponibles.
	uint public fechaTermino = 1512623041; // fecha  jueves, 7 de diciembre de 2017 2:04:01 GMT-03:00 en timestamp
	uint public contadorEntradas = 1337; // El ID de la primera entrada será el 1337
	string public nombreEvento = "3era junta EthereumChile"; // nombre del evento
	
	struct Entrada { // La estructura de cada entrada
		address addressComprador; // cuenta ethereum del comprador
		bytes32 rut; // rut comprador
		uint entradasCompradas; // cuantas entradas compró
	}
	
	mapping(uint => Entrada) public entradas;
	
	function dEvents () public {
	
		creadorEvento = msg.sender; // el creador del evento es quién publica el contrato.
 
	}
	function comprarEntrada(uint numeroEntradasComprar, bytes32 rut) public payable { 

		if(msg.value != (numeroEntradasComprar * valorEntradas) || numeroEntradas == 0 || numeroEntradasComprar == 0 || rut[0] == 0)

			revert();

		entradas[contadorEntradas].addressComprador = msg.sender; // address;
		entradas[contadorEntradas].entradasCompradas = numeroEntradasComprar; // uint;
		entradas[contadorEntradas].rut = rut; // bytes32;
		numeroEntradas = numeroEntradas - numeroEntradasComprar;
		contadorEntradas++;
		creadorEvento.transfer(msg.value);

	}
	function verEntrada(uint id) public constant returns (bytes32, uint) {

		return (entradas[id].rut, entradas[id].entradasCompradas);

	}

}
