PROCEDURE Main()

    LOCAL cEntrada := ""
    LOCAL nMes := 0

    ACCEPT "Digite o numero do mes: " TO cEntrada
    nMes := Val(cEntrada)

    DO CASE

    CASE nMes == 1
        QOut("Janeiro")

    CASE nMes == 2
        QOut("Fevereiro")

    CASE nMes == 3
        QOut("Marco")

    CASE nMes == 4
        QOut("Abril")

    CASE nMes == 5
        QOut("Maio")

    CASE nMes == 6
        QOut("Junho")

    CASE nMes == 7
        QOut("Julho")

    CASE nMes == 8
        QOut("Agosto")

    CASE nMes == 9
        QOut("Setembro")

    CASE nMes == 10
        QOut("Outubro")

    CASE nMes == 11
        QOut("Novembro")

    CASE nMes == 12
        QOut("Dezembro")

    OTHERWISE
        QOut("Mes invalido")

    ENDCASE

RETURN