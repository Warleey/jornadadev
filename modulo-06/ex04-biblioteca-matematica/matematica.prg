FUNCTION FatorialN(nN)

    LOCAL nFatorial := 1
    LOCAL nCont := 0

    FOR nCont := 1 TO nN
        nFatorial := nFatorial * nCont
    NEXT

RETURN nFatorial


FUNCTION EhPrimo(nN)

    LOCAL nCont := 0

    IF nN < 2
        RETURN .F.
    ENDIF

    FOR nCont := 2 TO nN - 1

        IF nN % nCont == 0
            RETURN .F.
        ENDIF

    NEXT

RETURN .T.


FUNCTION MMC(nA, nB)

    LOCAL nMMC := 0

    IF nA > nB
        nMMC := nA
    ELSE
        nMMC := nB
    ENDIF

    DO WHILE .T.

        IF nMMC % nA == 0 .AND. nMMC % nB == 0
            EXIT
        ENDIF

        nMMC++

    ENDDO

RETURN nMMC


FUNCTION MDC(nA, nB)

    LOCAL nMenor := 0
    LOCAL nCont := 0
    LOCAL nMDC := 1

    IF nA < nB
        nMenor := nA
    ELSE
        nMenor := nB
    ENDIF

    FOR nCont := 1 TO nMenor

        IF nA % nCont == 0 .AND. nB % nCont == 0
            nMDC := nCont
        ENDIF

    NEXT

RETURN nMDC