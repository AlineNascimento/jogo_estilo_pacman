require_relative 'ui'

def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read arquivo
    mapa = texto.split "\n"
end

def posicao_valida? mapa, posicao
    linhas = mapa.size
    colunas = mapa[0].size
    estorou_linhas = posicao[0] < 0 || posicao[0] >= linhas
    estorou_colunas = posicao[1] < 0 || posicao[1] >= colunas

    if estorou_linhas || estorou_colunas
        return false
    end
    valor_atual = mapa[posicao[0]][posicao[1]]
    if valor_atual == "X" || valor_atual == "F"
        return false
    end
    true
end



def encontra_jogador mapa
    caractere_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caractere_do_heroi
        if coluna_do_heroi != nil
            return [linha, coluna_do_heroi]
        end
    end
end

def calcula_nova_posicao heroi, direcao
      #nao lembro a funcionalidade
    #Array associativo
    movimentos = {
        "W" => [-1,0],
        "S" => [+1,0],
        "D" => [0,+1],
        "A" => [0,-1]
    }
    movimento = movimentos[direcao]
    puts movimento
    heroi[0] += movimento[0]
    puts heroi[0]
    heroi[1] += movimento[1]
    puts heroi[1]
    puts heroi
    heroi
end

def posicoes_validas_a_partir_de mapa, posicao
    posicoes = []
    abaixo = [posicao[0] + 1,posicao[1]]
    if posicao_valida? mapa, abaixo
        posicoes << abaixo
    end
    acima = [posicao[0] - 1, posicao[1]]
    if posicao_valida? mapa, acima
        posicoes << acima
    end
    direita = [posicao[0], posicao[1] + 1]
    if posicao_valida? mapa, direita
        posicoes << direita
    end
    esquerda = [posicao[0], posicao[1] - 1]
    if posicao_valida? mapa, esquerda
        posicoes << esquerda
    end
    posicoes
end

def move_fantasma mapa, linha, coluna
    posicoes = posicoes_validas_a_partir_de mapa, [linha, coluna]
    return if posicoes.empty?
    posicao = posicoes[0]
    mapa[linha][coluna] = " "
    mapa[posicao[0]][posicao[1]] = "F"
end

def move_fantasmas mapa
    caractere_do_fantasma = "F" 
    mapa.each_with_index do |linha_atual, linha|
        # .chars transforma um string num array de caracteres
        linha_atual.chars.each_with_index do |caractere_atual, coluna| 
        eh_fantasma = caractere_atual == caractere_do_fantasma
            if eh_fantasma
                move_fantasma mapa, linha, coluna
            end
        end
    end
end

def copia_mapa(mapa)
   # mapa.join("\n")
    novo_mapa = []
    mapa.each do |linha|
        nova_linha = nova_linha.dup.tr "F", " "
        novo_mapa << nova_linha
    end
    novo_mapa
end

def joga(nome)
    mapa =  le_mapa 2

    while true
        desenha mapa
        direcao = pede_movimento
        heroi = encontra_jogador mapa
        mapa[heroi[0]][heroi[1]] = " "
        nova_posicao = calcula_nova_posicao heroi, direcao
        if !posicao_valida? mapa, nova_posicao
            next
        end

        mapa[heroi[0]][heroi[1]] = "H"

        move_fantasmas mapa
    #jogo aqui
    end
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end