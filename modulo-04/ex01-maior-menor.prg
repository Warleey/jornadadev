PROCEDURE Main()

    LOCAL cEntrada := ""
    LOCAL nValor1 := 0
    LOCAL nValor2 := 0

    ACCEPT "Digite o primeiro valor: " TO cEntrada
    nValor1 := Val(cEntrada)

    ACCEPT "Digite o segundo valor: " TO cEntrada
    nValor2 := Val(cEntrada)

    IF nValor1 == nValor2

        QOut("Os valores sao iguais.")

    ELSEIF nValor1 > nValor2

        QOut("Maior valor: " + Str(nValor1, 6, 2))
        QOut("Menor valor: " + Str(nValor2, 6, 2))

    ELSE

        QOut("Maior valor: " + Str(nValor2, 6, 2))
        QOut("Menor valor: " + Str(nValor1, 6, 2))

    ENDIF

RETURN NIL