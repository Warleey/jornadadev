FUNCTION Main()

    LOCAL aDias := { ;
        "Domingo", ;
        "Segunda-feira", ;
        "Terca-feira", ;
        "Quarta-feira", ;
        "Quinta-feira", ;
        "Sexta-feira", ;
        "Sabado" ;
    }

    LOCAL cEntrada := ""
    LOCAL nDia := 0

    ACCEPT "Digite um numero de 1 a 7: " TO cEntrada

    nDia := Val(cEntrada)

    IF nDia >= 1 .AND. nDia <= 7

        QOut("Dia da semana: " + aDias[nDia])

    ELSE

        QOut("Numero invalido. Digite um valor entre 1 e 7.")

    ENDIF

RETURN NIL