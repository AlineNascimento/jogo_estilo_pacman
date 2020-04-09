class Heroi
# colocando atributos na classe, sendo que eles podem ser lidos e escritos, ou seja: alterados
    attr_accessor :linha, :coluna

    def calcula_nova_posicao(direcao)
        novo_heroi = dup
        #Array associativo
        movimentos = {
            "W" => [-1,0],
            "S" => [+1,0],
            "D" => [0,+1], 
            "A" => [0,-1]
        }
        movimento = movimentos[direcao]
        novo_heroi.linha += movimento[0]
        novo_heroi.coluna += movimento[1]
        novo_heroi
    end

    def to_array
        return [@linha,@coluna]
    end

    def remova_do mapa
        mapa[@linha][@coluna] = " "
    end

    def coloca_no mapa
        mapa[@linha][@coluna] = "H"
    end

end



