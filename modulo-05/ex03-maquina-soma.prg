PROCEDURE Main()

    LOCAL cEntrada := ""
    LOCAL nValor := 0
    LOCAL nTotal := 0
    LOCAL nQtd := 0

    ACCEPT "Digite um valor (0 para encerrar): " TO cEntrada
    nValor := Val(cEntrada)

    WHILE nValor <> 0

        nTotal += nValor
        nQtd++

        ACCEPT "Digite outro valor (0 para encerrar): " TO cEntrada
        nValor := Val(cEntrada)

    ENDDO

    QOut("")
    QOut("Soma total: " + LTrim(Str(nTotal)))
    QOut("Quantidade de valores: " + LTrim(Str(nQtd)))

RETURN NIL