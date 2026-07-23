FUNCTION Main()

    LOCAL nNumero := 5
    LOCAL nPrimo := 7
    LOCAL nValor1 := 12
    LOCAL nValor2 := 18

    SET PROCEDURE TO matematica.prg

    QOut("Fatorial de " + LTrim(Str(nNumero)) + ": " + ;
        LTrim(Str(FatorialN(nNumero))))

    IF EhPrimo(nPrimo)
        QOut(LTrim(Str(nPrimo)) + " e primo.")
    ELSE
        QOut(LTrim(Str(nPrimo)) + " nao e primo.")
    ENDIF

    QOut("MMC de " + LTrim(Str(nValor1)) + " e " + ;
        LTrim(Str(nValor2)) + ": " + ;
        LTrim(Str(MMC(nValor1, nValor2))))

    QOut("MDC de " + LTrim(Str(nValor1)) + " e " + ;
        LTrim(Str(nValor2)) + ": " + ;
        LTrim(Str(MDC(nValor1, nValor2))))

RETURN NIL