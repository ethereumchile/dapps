var abi = [{"constant":true,"inputs":[],"name":"contadorMensajes","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"mensajes","outputs":[{"name":"emisor","type":"address"},{"name":"mensaje","type":"string"},{"name":"fechaPublicacion","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"creador","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"mensaje","type":"string"}],"name":"escribirMensaje","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
var addressContrato = "0x5ae44cc11fcb91b209a2848b0f3bdcf1a870d2d9";
var contrato = web3.eth.contract(abi);
var funciones = contrato.at(addressContrato);
var contadorMensajes = 0;
$(document).ready(function(){
	if (typeof web3 !== 'undefined') {
		web3 = new Web3(web3.currentProvider);
	} else {
		web3 = new Web3(new Web3.providers.HttpProvider("https://rinkeby.infura.io"));
	}
})
function escribirMensaje(){

	var mensaje = $("input[name=mensaje").val();
	if(mensaje.length > 0){

		funciones.escribirMensaje(mensaje, function(error, respuesta){

			if(error)	throw error;
			alert("Mensaje enviado!!")

		})

	}
	$("input[name=mensaje").val('');
}

function leerMensajes(){

	jQuery("#contenido").html('');
	funciones.contadorMensajes(function(error, respuesta){

		if(error)	throw error;
		contadorMensajes = respuesta.c[0];

	})
	for(var i = 0; i < contadorMensajes; i++){
		funciones.mensajes(i, function(error, respuesta){

			if(error)	throw error;
			var emisor = respuesta[0];
			var mensaje = respuesta[1].replace("<", "");
			mensaje = mensaje.replace(">", "");
			var fechaPublicacion = respuesta[2];

			jQuery("<b>Emisor</b>: "+emisor+"<br /><b>Mensaje</b>: "+mensaje+"<br /><b>Fecha</b>: "+ts2date(fechaPublicacion)+"<hr/>").appendTo("#contenido")


		})
	}
}
function ts2date(ts){

	var a = new Date(ts * 1000);
	var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
	var year = a.getFullYear();
	var month = months[a.getMonth()];
	var date = a.getDate();
	var hour = a.getHours();
	var min = a.getMinutes();
	var sec = a.getSeconds();
	var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
	return time;

}
window.setInterval("leerMensajes()", 2000);
