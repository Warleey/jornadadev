FUNCTION Main()

    LOCAL aValores := {}
    LOCAL cEntrada := ""
    LOCAL nValor := 0
    LOCAL nCont := 0
    LOCAL nSoma := 0
    LOCAL nMedia := 0

    FOR nCont := 1 TO 10

        ACCEPT "Digite um numero: " TO cEntrada

        nValor := Val(cEntrada)

        AADD(aValores, nValor)

        nSoma := nSoma + nValor

    NEXT

    ASORT(aValores)

    nMedia := nSoma / Len(aValores)

    QOut("")
    QOut("Numeros em ordem crescente:")

    FOR nCont := 1 TO Len(aValores)

        QOut(LTrim(Str(aValores[nCont])))

    NEXT

    QOut("")
    QOut("Soma: " + LTrim(Str(nSoma)))
    QOut("Media: " + Str(nMedia, 10, 2))
    QOut("Menor: " + LTrim(Str(aValores[1])))
    QOut("Maior: " + LTrim(Str(aValores[Len(aValores)])))

RETURN NIL