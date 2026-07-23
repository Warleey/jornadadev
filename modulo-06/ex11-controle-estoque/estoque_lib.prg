FUNCTION CadastrarProduto(aEstoque)

    LOCAL cCodigo := ""
    LOCAL cNome := ""
    LOCAL cEntrada := ""
    LOCAL nPreco := 0
    LOCAL nQuantidade := -1
    LOCAL nPosicao := 0
    LOCAL lCodigoExiste := .F.

    QOut("")
    QOut("CADASTRO DE PRODUTO")
    QOut("")

    WHILE Len(AllTrim(cCodigo)) == 0 .OR. lCodigoExiste == .T.

        lCodigoExiste := .F.

        ACCEPT "Digite o codigo do produto: " TO cCodigo

        IF Len(AllTrim(cCodigo)) == 0

            QOut("O codigo do produto nao pode ficar vazio.")

        ELSE

            FOR nPosicao := 1 TO Len(aEstoque)

                IF Upper(AllTrim(aEstoque[nPosicao][1])) == Upper(AllTrim(cCodigo))
                    lCodigoExiste := .T.
                ENDIF

            NEXT

            IF lCodigoExiste == .T.
                QOut("Ja existe um produto com esse codigo.")
            ENDIF

        ENDIF

    ENDDO

    WHILE Len(AllTrim(cNome)) == 0

        ACCEPT "Digite o nome do produto: " TO cNome

        IF Len(AllTrim(cNome)) == 0
            QOut("O nome do produto nao pode ficar vazio.")
        ENDIF

    ENDDO

    WHILE nQuantidade < 0

        ACCEPT "Digite a quantidade inicial: " TO cEntrada

        nQuantidade := Val(cEntrada)

        IF nQuantidade < 0
            QOut("A quantidade nao pode ser negativa.")
        ENDIF

    ENDDO

    WHILE nPreco <= 0

        ACCEPT "Digite o preco do produto: " TO cEntrada

        nPreco := Val(cEntrada)

        IF nPreco <= 0
            QOut("Digite um preco maior que zero.")
        ENDIF

    ENDDO

    AADD(aEstoque, { cCodigo, cNome, nQuantidade, nPreco })

    QOut("")
    QOut("Produto cadastrado com sucesso.")

RETURN NIL


FUNCTION ListarProdutos(aEstoque)

    LOCAL nPosicao := 0

    QOut("")
    QOut("LISTA DE PRODUTOS")
    QOut("")

    IF Len(aEstoque) == 0

        QOut("Nenhum produto cadastrado.")

    ELSE

        FOR nPosicao := 1 TO Len(aEstoque)

            QOut("Codigo: " + aEstoque[nPosicao][1])
            QOut("Produto: " + aEstoque[nPosicao][2])
            QOut("Quantidade: " + Str(aEstoque[nPosicao][3]))
            QOut("Preco: R$ " + Str(aEstoque[nPosicao][4], 10, 2))
            QOut("")

        NEXT

    ENDIF

RETURN NIL


FUNCTION EntradaEstoque(aEstoque)

    LOCAL cCodigo := ""
    LOCAL cEntrada := ""
    LOCAL nQuantidade := 0
    LOCAL nPosicao := 0
    LOCAL nProdutoEncontrado := 0

    QOut("")
    QOut("ENTRADA DE ESTOQUE")
    QOut("")

    IF Len(aEstoque) == 0

        QOut("Nenhum produto cadastrado.")

    ELSE

        ACCEPT "Digite o codigo do produto: " TO cCodigo

        FOR nPosicao := 1 TO Len(aEstoque)

            IF Upper(AllTrim(aEstoque[nPosicao][1])) == Upper(AllTrim(cCodigo))
                nProdutoEncontrado := nPosicao
            ENDIF

        NEXT

        IF nProdutoEncontrado == 0

            QOut("")
            QOut("Produto nao encontrado.")

        ELSE

            QOut("")
            QOut("Produto: " + aEstoque[nProdutoEncontrado][2])
            QOut("Quantidade atual: " + Str(aEstoque[nProdutoEncontrado][3]))
            QOut("")

            WHILE nQuantidade <= 0

                ACCEPT "Digite a quantidade de entrada: " TO cEntrada

                nQuantidade := Val(cEntrada)

                IF nQuantidade <= 0
                    QOut("Digite uma quantidade maior que zero.")
                ENDIF

            ENDDO

            aEstoque[nProdutoEncontrado][3] := ;
                aEstoque[nProdutoEncontrado][3] + nQuantidade

            QOut("")
            QOut("Entrada de estoque realizada com sucesso.")
            QOut("Nova quantidade: " + ;
                Str(aEstoque[nProdutoEncontrado][3]))

        ENDIF

    ENDIF

RETURN NIL


FUNCTION SaidaEstoque(aEstoque)

    LOCAL cCodigo := ""
    LOCAL cEntrada := ""
    LOCAL nQuantidade := 0
    LOCAL nPosicao := 0
    LOCAL nProdutoEncontrado := 0

    QOut("")
    QOut("SAIDA DE ESTOQUE")
    QOut("")

    IF Len(aEstoque) == 0

        QOut("Nenhum produto cadastrado.")

    ELSE

        ACCEPT "Digite o codigo do produto: " TO cCodigo

        FOR nPosicao := 1 TO Len(aEstoque)

            IF Upper(AllTrim(aEstoque[nPosicao][1])) == Upper(AllTrim(cCodigo))
                nProdutoEncontrado := nPosicao
            ENDIF

        NEXT

        IF nProdutoEncontrado == 0

            QOut("")
            QOut("Produto nao encontrado.")

        ELSE

            QOut("")
            QOut("Produto: " + aEstoque[nProdutoEncontrado][2])
            QOut("Quantidade atual: " + Str(aEstoque[nProdutoEncontrado][3]))
            QOut("")

            WHILE nQuantidade <= 0 .OR. ;
                  nQuantidade > aEstoque[nProdutoEncontrado][3]

                ACCEPT "Digite a quantidade de saida: " TO cEntrada

                nQuantidade := Val(cEntrada)

                IF nQuantidade <= 0

                    QOut("Digite uma quantidade maior que zero.")

                ELSEIF nQuantidade > aEstoque[nProdutoEncontrado][3]

                    QOut("Quantidade maior que o estoque disponivel.")

                ENDIF

            ENDDO

            aEstoque[nProdutoEncontrado][3] := ;
                aEstoque[nProdutoEncontrado][3] - nQuantidade

            QOut("")
            QOut("Saida de estoque realizada com sucesso.")
            QOut("Nova quantidade: " + ;
                Str(aEstoque[nProdutoEncontrado][3]))

        ENDIF

    ENDIF

RETURN NIL


FUNCTION BuscarProduto(aEstoque)

    LOCAL cCodigo := ""
    LOCAL nPosicao := 0
    LOCAL nProdutoEncontrado := 0

    QOut("")
    QOut("BUSCAR PRODUTO")
    QOut("")

    IF Len(aEstoque) == 0

        QOut("Nenhum produto cadastrado.")

    ELSE

        ACCEPT "Digite o codigo do produto: " TO cCodigo

        FOR nPosicao := 1 TO Len(aEstoque)

            IF Upper(AllTrim(aEstoque[nPosicao][1])) == Upper(AllTrim(cCodigo))
                nProdutoEncontrado := nPosicao
            ENDIF

        NEXT

        IF nProdutoEncontrado == 0

            QOut("")
            QOut("Produto nao encontrado.")

        ELSE

            QOut("")
            QOut("PRODUTO ENCONTRADO")
            QOut("")
            QOut("Codigo: " + aEstoque[nProdutoEncontrado][1])
            QOut("Produto: " + aEstoque[nProdutoEncontrado][2])
            QOut("Quantidade: " + ;
                Str(aEstoque[nProdutoEncontrado][3]))
            QOut("Preco: R$ " + ;
                Str(aEstoque[nProdutoEncontrado][4], 10, 2))

        ENDIF

    ENDIF

RETURN NIL


FUNCTION RelatorioEstoque(aEstoque)

    LOCAL nPosicao := 0
    LOCAL nTotalProdutos := 0
    LOCAL nTotalUnidades := 0
    LOCAL nValorProduto := 0
    LOCAL nValorTotal := 0

    QOut("")
    QOut("RELATORIO DO ESTOQUE")
    QOut("")

    IF Len(aEstoque) == 0

        QOut("Nenhum produto cadastrado.")

    ELSE

        nTotalProdutos := Len(aEstoque)

        FOR nPosicao := 1 TO Len(aEstoque)

            nValorProduto := ;
                aEstoque[nPosicao][3] * aEstoque[nPosicao][4]

            nTotalUnidades := ;
                nTotalUnidades + aEstoque[nPosicao][3]

            nValorTotal := nValorTotal + nValorProduto

            QOut("Codigo: " + aEstoque[nPosicao][1])
            QOut("Produto: " + aEstoque[nPosicao][2])
            QOut("Quantidade: " + ;
                Str(aEstoque[nPosicao][3]))
            QOut("Preco unitario: R$ " + ;
                Str(aEstoque[nPosicao][4], 10, 2))
            QOut("Valor em estoque: R$ " + ;
                Str(nValorProduto, 10, 2))
            QOut("")

        NEXT

        QOut("--------------------------------")
        QOut("Total de produtos cadastrados: " + ;
            Str(nTotalProdutos))
        QOut("Total de unidades em estoque: " + ;
            Str(nTotalUnidades))
        QOut("Valor total do estoque: R$ " + ;
            Str(nValorTotal, 10, 2))
        QOut("--------------------------------")

    ENDIF

RETURN NIL