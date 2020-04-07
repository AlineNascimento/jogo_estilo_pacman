require_relative 'ui'

def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read arquivo
    mapa = texto.split "\n"
end

def joga(nome)
    mapa =  le_mapa 1
    #jogo aqui
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end