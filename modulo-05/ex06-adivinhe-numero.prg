PROCEDURE Main()

    LOCAL nNumero := 0
    LOCAL nPalpite := 0
    LOCAL nTentativa := 0
    LOCAL cEntrada := ""

    nNumero := HB_RandomInt(1, 100)

    FOR nTentativa := 1 TO 7

        ACCEPT "Digite um numero entre 1 e 100: " TO cEntrada
        nPalpite := Val(cEntrada)

        IF nPalpite == nNumero

            QOut("Voce acertou!")
            EXIT

        ELSEIF nPalpite < nNumero

            QOut("O numero secreto e maior.")

        ELSE

            QOut("O numero secreto e menor.")

        ENDIF

    NEXT

    IF nPalpite <> nNumero
        QOut("Voce nao acertou.")
    ENDIF

    QOut("O numero secreto era: " + LTrim(Str(nNumero)))

RETURN NIL