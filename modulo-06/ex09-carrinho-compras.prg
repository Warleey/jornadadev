FUNCTION Main()

    LOCAL aCarrinho := {}
    LOCAL cResposta := "S"

    WHILE Upper(cResposta) == "S"

        AdicionarProduto(aCarrinho)

        ACCEPT "Deseja adicionar outro produto? (S/N): " TO cResposta

    ENDDO

    ExibirCarrinho(aCarrinho)

RETURN NIL


FUNCTION AdicionarProduto(aCarrinho)

    LOCAL cNome := ""
    LOCAL cEntrada := ""
    LOCAL nPreco := 0

    WHILE Len(AllTrim(cNome)) == 0

        ACCEPT "Digite o nome do produto: " TO cNome

        IF Len(AllTrim(cNome)) == 0
            QOut("O nome do produto nao pode ficar vazio.")
        ENDIF

    ENDDO

    WHILE nPreco <= 0

        ACCEPT "Digite o preco do produto: " TO cEntrada

        nPreco := Val(cEntrada)

        IF nPreco <= 0
            QOut("Digite um preco maior que zero.")
        ENDIF

    ENDDO

    AADD(aCarrinho, {cNome, nPreco})

    QOut("Produto adicionado ao carrinho.")
    QOut("")

RETURN NIL


FUNCTION ExibirCarrinho(aCarrinho)

    LOCAL nCont := 0
    LOCAL nTotal := 0

    QOut("")
    QOut("ITENS DO CARRINHO")

    IF Len(aCarrinho) == 0

        QOut("Nenhum produto foi adicionado.")

    ELSE

        FOR nCont := 1 TO Len(aCarrinho)

            QOut("")
            QOut("Produto: " + aCarrinho[nCont][1])
            QOut("Preco: R$ " + Str(aCarrinho[nCont][2], 10, 2))

            nTotal := nTotal + aCarrinho[nCont][2]

        NEXT

        QOut("")
        QOut("Total da compra: R$ " + Str(nTotal, 10, 2))

    ENDIF

RETURN NIL