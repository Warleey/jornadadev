PROCEDURE Main()

    LOCAL cEntrada := ""
    LOCAL nValor := 0

    ACCEPT "Digite um valor inteiro: " TO cEntrada
    nValor := Val(cEntrada)

    WHILE nValor > 0

        QOut("Dobro do valor: " + LTrim(Str(nValor * 2)))

        ACCEPT "Digite outro valor inteiro: " TO cEntrada
        nValor := Val(cEntrada)

    ENDDO

    QOut("")
    QOut("Programa encerrado.")

RETURN NIL