module LecturaTXT
	def LecturaTXT.leer
		intro=""
		estados=[]
		datos=[]
		estado_array=[]
		condiciones={}
		File.open('datos.txt', 'r') do |f1|  
		  i=0
		  while line = f1.gets      
		    sin_salto=""	
		    estado=line.split(";")
		    sin_salto=estado[1].gsub(/\s+/, ' ').strip    
		    datos=sin_salto.split("=>")
		    condicion=datos[0].to_i
		    reglas=datos[1].to_s.split(",")        
		    condiciones["#{datos[0]}"]=Condiciones.new(condicion,Regla.new(reglas[0],reglas[1],reglas[2]))    
		    if datos[0]=="B"
		    	estados[estado[0].to_i]=Estados.new(estado[0].to_i,condiciones)		    	
		    	condiciones={}    	
			end
		    i+=1
		  end  
		end
		return estados
	end
end

