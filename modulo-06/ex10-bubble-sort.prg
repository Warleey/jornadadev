FUNCTION Main()

    LOCAL aNumeros := { 8, 3, 10, 1, 6, 2, 9, 5, 7, 4 }
    LOCAL nCont := 0

    QOut("Numeros antes da ordenacao:")

    FOR nCont := 1 TO Len(aNumeros)

        QOut(LTrim(Str(aNumeros[nCont])))

    NEXT

    BubbleSort(aNumeros)

    QOut("")
    QOut("Numeros depois da ordenacao:")

    FOR nCont := 1 TO Len(aNumeros)

        QOut(LTrim(Str(aNumeros[nCont])))

    NEXT

RETURN NIL


FUNCTION BubbleSort(aVetor)

    LOCAL nI := 0
    LOCAL nJ := 0
    LOCAL nTemporario := 0

    FOR nI := 1 TO Len(aVetor) - 1

        FOR nJ := 1 TO Len(aVetor) - nI

            IF aVetor[nJ] > aVetor[nJ + 1]

                nTemporario := aVetor[nJ]
                aVetor[nJ] := aVetor[nJ + 1]
                aVetor[nJ + 1] := nTemporario

            ENDIF

        NEXT

    NEXT

RETURN NIL