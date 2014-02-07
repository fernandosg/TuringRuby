$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '/'))
require 'LecturaTXT'
class Regla
	attr_accessor :estado_conversion, :valor_conversion, :movimiento
	def initialize(estado_conversion,valor_conversion,movimiento)		
		@estado_conversion=estado_conversion
		@valor_conversion=valor_conversion
		@movimiento=movimiento
	end
end

class Condiciones
	attr_accessor :condicion, :regla
	def initialize(condicion,regla)
		@condicion=condicion		
		@regla=regla
	end		
end

class Estados
	attr_accessor :condiciones
	def initialize(estado,condiciones)
		@estado=estado
		@condiciones=condiciones
	end

	def obtener_regla(estado,condicion)
		regla_list=Array.new		
		regla_list<<@condiciones["#{condicion.to_s}"].regla.estado_conversion
		regla_list<<@condiciones["#{condicion.to_s}"].regla.valor_conversion
		regla_list<<@condiciones["#{condicion.to_s}"].regla.movimiento		
		return regla_list
	end
end

class Puntero
	attr_accessor :estado, :regla, :posicion, :condicion, :conversion, :no_definido, :estados

	def initialize(estados)		
		@estados=estados
		@estado, @posicion=0
		@no_definido=false
	end

	def movimiento(posicion,condicion)
		@regla=@estados[estado].obtener_regla(estado,condicion)	
		if @regla[0]!=nil
			@conversion=regla[1]
			cambiar_estado(regla[0])	
		else
			@no_definido=true			
		end
	end

	def checar_movimiento(posicion,avance_o_retroceso)
		if avance_o_retroceso=="R"
			posicion=posicion+1
		else 
			posicion=posicion-1
		end
		#puts "el avance #{posicion}"
		return posicion
	end

	def cambiar_estado(nuevo_estado)
		@estado=nuevo_estado.to_i
	end

	def valido_o_no
		if !@no_definido 
			return "Es valido y el estado final fue #{@estado}"
		else
			return "No es valido y el estado final fue #{@estado}"
		end
	end	
end

class Turing
	attr_accessor :puntero, :posicion
	
	def initialize
		@estados=[]
		@estados=LecturaTXT.leer		
		@puntero=Puntero.new(@estados)		 
	end

	def iniciar(cadena)
		bandera=false
		posicion=0
		cadena="#{cadena}B"
		until bandera==true				
			puts "#{cadena}"
			if puntero.estado<@estados.length and posicion<cadena.length and puntero.no_definido!=true
				puntero.movimiento(posicion,cadena[posicion])	
				cadena[posicion]=puntero.conversion
				posicion=puntero.checar_movimiento(posicion,puntero.regla[2])
			else		
				bandera=true
			end
		end
		puts puntero.valido_o_no
	end
end
