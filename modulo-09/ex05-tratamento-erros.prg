FUNCTION Main()

    LOCAL nA := 10
    LOCAL nB := 0
    LOCAL nResultado
    LOCAL oErro

    QOut("INICIO DO PROGRAMA")
    QOut("")

    BEGIN SEQUENCE

        nResultado := nA / nB   // <- Provoca o erro de verdade aqui

        QOut("Resultado: " + Str(nResultado))

    RECOVER USING oErro

        QOut("Erro capturado: " + oErro:Description)

    END SEQUENCE

    QOut("")
    QOut("O programa continua de pe!")
    QOut("FIM DO PROGRAMA")

RETURN NIL