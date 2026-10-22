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
}

class Mueble {
	var property cosas

	method guardar(unaCosa) {
		cosas.add(unaCosa)
	}

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