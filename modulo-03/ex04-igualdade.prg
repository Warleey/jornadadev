PROCEDURE Main()

    LOCAL cTextoCompleto := "Harbour"
    LOCAL cTextoParcial  := "Harb"

    LOCAL lResultadoIgual
    LOCAL lResultadoExato

    lResultadoIgual := cTextoCompleto = cTextoParcial
    lResultadoExato := cTextoCompleto == cTextoParcial

    QOut("=============================")
    QOut("       COMPARACAO DE TEXTO    ")
    QOut("=============================")

    QOut('Texto completo: "' + cTextoCompleto + '"')
    QOut('Texto parcial : "' + cTextoParcial + '"')

    QOut("")

    IF lResultadoIgual
        QOut("Resultado usando =  : .T.")
    ELSE
        QOut("Resultado usando =  : .F.")
    ENDIF

    IF lResultadoExato
        QOut("Resultado usando == : .T.")
    ELSE
        QOut("Resultado usando == : .F.")
    ENDIF

    QOut("")
    QOut("O operador = compara o inicio da string.")
    QOut("O operador == exige igualdade exata.")

    QOut("=============================")

RETURN