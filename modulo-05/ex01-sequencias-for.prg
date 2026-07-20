PROCEDURE Main()

    LOCAL nCont := 0

    QOut("Numeros de 1 a 100")

    FOR nCont := 1 TO 100
        QOut(LTrim(Str(nCont)))
    NEXT

    QOut("")
    QOut("Numeros de -50 a 50")

    FOR nCont := -50 TO 50
        QOut(LTrim(Str(nCont)))
    NEXT

    QOut("")
    QOut("Numeros de 80 a 5")

    FOR nCont := 80 TO 5 STEP -1
        QOut(LTrim(Str(nCont)))
    NEXT

RETURN NIL