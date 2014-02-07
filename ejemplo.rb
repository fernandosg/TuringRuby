$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '/'))
require 'turing'
puts "Escribe la cadena"
cadena=gets.chomp
turing=Turing.new
turing.iniciar(cadena)