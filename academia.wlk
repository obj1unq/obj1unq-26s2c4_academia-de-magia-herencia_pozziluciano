/** Reemplazar por la solución del enunciado */
object academiaDeMagia {
	const property muebles = []
	
	method sePuedeGuardarEnLaAcademia(unaCosa) {
		self.noEstaEnLaAcademia(unaCosa) && muebles.any{mueble => mueble.sePuedeGuardar(unaCosa)}
	}

	method muebleDondeEsta(unaCosa) {
		muebles.filter{mueble => mueble.estaGuardada(unaCosa)}
	}

	method noEstaEnLaAcademia(unaCosa) {
		return muebles.all{mueble => mueble.noEstaYaGuardada(unaCosa)}
	}

	


class Cosa {
	const property marca
	const property volumen
	const property esReliquia
	const property esMagica
}

class Mueble {
	var property cosas

	method sePuedeGuardar(unaCosa)

	method noEstaYaGuardada(unaCosa) {
		return not cosas.contains(unaCosa)
	}

	method estaGuardada(unaCosa) {
		return cosas.contains(unaCosa)
	}
	
}

class Armario inherits Mueble {
	const property cantMaxCosas

	override method sePuedeGuardar(unaCosa) {
		return self.cantCosasGuardadas() < cantMaxCosas
	}

	method cantCosasGuardadas() {
		return cosas.count()
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
}

class Gabinete inherits Mueble{
	override method sePuedeGuardar(unaCosa) {
		return unaCosa.esMagica()
	}
}