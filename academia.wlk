/** Reemplazar por la solución del enunciado */
object academiaDeMagia {
	const property muebles = []
	
	method guardarCosa(unaCosa) {
		if (self.sePuedeGuardarEnLaAcademia(unaCosa)) {self.mueblesDondePuedeGuardarse(unaCosa).anyOne().guardar(unaCosa)}
	}

	method sePuedeGuardarEnLaAcademia(unaCosa) {
		return self.noEstaEnLaAcademia(unaCosa) && muebles.any{mueble => mueble.sePuedeGuardar(unaCosa)}
	}

	method muebleDondeEsta(unaCosa) {
		muebles.filter{mueble => mueble.estaGuardada(unaCosa)}
	}

	method noEstaEnLaAcademia(unaCosa) {
		return muebles.all{mueble => mueble.noEstaYaGuardada(unaCosa)}
	}

	method mueblesDondePuedeGuardarse(unaCosa) {
		return if (self.noEstaEnLaAcademia(unaCosa)) {muebles.filter{mueble => mueble.sePuedeGuardar(unaCosa)}}
			else []
	}

	
}

class Cosa {
	const property marca
	const property volumen
	const property esReliquia
	const property esMagica

	method utilidad() {
		return volumen + self.tresSiEsMagica() + self.cincoSiEsReliquia() + marca.loQueAportaLaMarca(self)
	}

	method tresSiEsMagica() {
		return if(esMagica) {3} else {0}
	}

	method cincoSiEsReliquia() {
		return if(esReliquia) {5} else {0}
	}
}

class Marca {
	method loQueAportaLaMarca(unaCosa)
}

class Fenix inherits Marca {
	override method loQueAportaLaMarca(unaCosa) {
		return if (unaCosa.esReliquia()) {3} else {0}
	}
}

class Acme inherits Marca {
	override method loQueAportaLaMarca(unaCosa) {
		return unaCosa.volumen() / 2
	}
}

class Cuchuflito inherits Marca {
	override method loQueAportaLaMarca(unaCosa) {
		return 0
	}
}
class Mueble {
	var property cosas
	

	method guardar(unaCosa) {
		if (self.sePuedeGuardar(unaCosa) && self.noEstaYaGuardada(unaCosa))
		cosas.add(unaCosa)
	}

	method sePuedeGuardar(unaCosa)

	method noEstaYaGuardada(unaCosa) {
		return not cosas.contains(unaCosa)
	}

	method estaGuardada(unaCosa) {
		return cosas.contains(unaCosa)
	}

	method utilidadMueble() {
		return self.utilidadDelContenido() / self.precio()  
	}

	method utilidadDelContenido() {
		return cosas.sum{cosa => cosa.utilidad()} 
	}
	
	method precio()
}

class Armario inherits Mueble {
	const property cantMaxCosas

	override method sePuedeGuardar(unaCosa) {
		return self.cantCosasGuardadas() < cantMaxCosas
	}

	method cantCosasGuardadas() {
		return cosas.count()
	}

	override method precio() {
		return cantMaxCosas * 5
	}


}

class Baul inherits Mueble {
	const property volumenMax

	override method sePuedeGuardar(unaCosa) {
		return not self.volumenTotal() + unaCosa.volumen() > volumenMax
	}

	method volumenTotal() {
		return cosas.sum{cosa => cosa.volumen()}
	}

	override method precio() {
		return volumenMax + 2
	}
}

class Gabinete inherits Mueble{

	const precio
	override method sePuedeGuardar(unaCosa) {
		return unaCosa.esMagica()
	}

	override method precio() {
		return precio
	}

	method sonTodasReliquias() {
		return cosas.all{cosa => cosa.esReliquia()}
	}

	method dosSiSonTodasReliquias() {
		return if (self.sonTodasReliquias()) {2} else {0}
	}

	override method utilidadMueble() {
		return ( self.utilidadDelContenido() / self.precio() ) + self.dosSiSonTodasReliquias() 
	}
}

class BaulMagico inherits Baul {
	override method utilidadMueble() {
		return ( self.utilidadDelContenido() / self.precio() ) + self.dosSiSonTodasReliquias() 
	}
}