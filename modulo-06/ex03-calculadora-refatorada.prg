FUNCTION Main()

    LOCAL nValor1 := 0
    LOCAL nValor2 := 0
    LOCAL cOperacao := ""
    LOCAL nResultado := 0
    LOCAL lCalculou := .F.

    nValor1 := LerNumero("Digite o primeiro numero: ")
    nValor2 := LerNumero("Digite o segundo numero: ")
    cOperacao := LerOperacao()

    lCalculou := Calcular(nValor1, nValor2, cOperacao, @nResultado)

    MostrarResultado(lCalculou, nResultado)

RETURN NIL


FUNCTION LerNumero(cMensagem)

    LOCAL cEntrada := ""

    ACCEPT cMensagem TO cEntrada

RETURN Val(cEntrada)


FUNCTION LerOperacao()

    LOCAL cOperacao := ""

    QOut("")
    QOut("Escolha uma operacao:")
    QOut("+ para soma")
    QOut("- para subtracao")
    QOut("* para multiplicacao")
    QOut("/ para divisao")
    QOut("^ para potencia")
    QOut("R para raiz quadrada")

    ACCEPT "Digite a operacao: " TO cOperacao

RETURN Upper(cOperacao)


FUNCTION Calcular(nValor1, nValor2, cOperacao, nResultado)

    LOCAL lCalculou := .T.

    DO CASE

    CASE cOperacao == "+"
        nResultado := nValor1 + nValor2

    CASE cOperacao == "-"
        nResultado := nValor1 - nValor2

    CASE cOperacao == "*"
        nResultado := nValor1 * nValor2

    CASE cOperacao == "/"

        IF nValor2 == 0
            lCalculou := .F.
        ELSE
            nResultado := nValor1 / nValor2
        ENDIF

    CASE cOperacao == "^"
        nResultado := nValor1 ^ nValor2

    CASE cOperacao == "R"
        nResultado := Sqrt(nValor1)

    OTHERWISE
        lCalculou := .F.

    ENDCASE

RETURN lCalculou


FUNCTION MostrarResultado(lCalculou, nResultado)

    QOut("")

    IF lCalculou
        QOut("Resultado: " + LTrim(Str(nResultado)))
    ELSE
        QOut("Nao foi possivel realizar o calculo.")
    ENDIF

RETURN NIL