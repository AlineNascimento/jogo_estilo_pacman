require_relative 'ui'
require_relative 'heroi'

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

def encontra_jogador(mapa)
    caractere_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caractere_do_heroi
        if coluna_do_heroi 
            jogador = Heroi.new
            jogador.linha = linha
            jogador.coluna = coluna_do_heroi
            return jogador
        end
    end
    nil
end


def posicoes_validas_a_partir_de mapa, novo_mapa, posicao
    posicoes = []
    abaixo = [posicao[0] + 1,posicao[1]]
    
    if (posicao_valida? mapa, abaixo) && (posicao_valida? novo_mapa, abaixo)
        posicoes << abaixo
    end
    acima = [posicao[0] - 1, posicao[1]]
    if (posicao_valida? mapa, acima) && (posicao_valida? novo_mapa, acima)
        posicoes << acima
    end
    direita = [posicao[0], posicao[1] + 1]
    if (posicao_valida? mapa, direita) && (posicao_valida? novo_mapa, direita)
        posicoes << direita
    end
    esquerda = [posicao[0], posicao[1] - 1]
    if (posicao_valida? mapa, esquerda) && (posicao_valida? novo_mapa, esquerda)
        posicoes << esquerda
    end
    posicoes
end

def move_fantasma mapa, novo_mapa, linha, coluna
    posicoes = posicoes_validas_a_partir_de mapa, novo_mapa, [linha, coluna]
    return if posicoes.empty?

    aleatoria = rand posicoes.size
    posicao = posicoes[aleatoria]
    mapa[linha][coluna] = " "
   novo_mapa[posicao[0]][posicao[1]] = "F"
end

def move_fantasmas mapa
    caractere_do_fantasma = "F" 
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        # .chars transforma um string num array de caracteres
        linha_atual.chars.each_with_index do |caractere_atual, coluna| 
        eh_fantasma = caractere_atual == caractere_do_fantasma
            if eh_fantasma
                move_fantasma mapa, novo_mapa, linha, coluna
            end
        end
    end
    novo_mapa
end

def copia_mapa(mapa)
   novo_mapa = mapa.join("\n").tr("F", " ").split "\n" 
end

def jogador_perdeu? mapa
    perdeu = !encontra_jogador(mapa)
end

def joga(nome)
    mapa =  le_mapa 2

    while true
        desenha mapa
        direcao = pede_movimento
        heroi = encontra_jogador mapa
        nova_posicao = heroi.calcula_nova_posicao direcao
        if !posicao_valida? mapa, nova_posicao.to_array
            next
        end


        heroi.remova_do mapa
        nova_posicao.coloca_no mapa
       
        mapa = move_fantasmas mapa
        if jogador_perdeu? mapa
            game_over
            break
        end
    end
end


def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end