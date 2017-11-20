pragma solidity ^0.4.18;

contract dApp {
	
	address creador;
	
	function dApp () {

		creador = msg.sender;

	}

}
