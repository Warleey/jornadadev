PROCEDURE Main()

    LOCAL cEntrada := ""
    LOCAL cOperacao := ""

    LOCAL nValor1 := 0
    LOCAL nValor2 := 0

    ACCEPT "Digite o primeiro valor: " TO cEntrada
    nValor1 := Val(cEntrada)

    ACCEPT "Digite o segundo valor: " TO cEntrada
    nValor2 := Val(cEntrada)

    ACCEPT "Digite a operacao (+, -, *, /, ^, R): " TO cOperacao

    DO CASE

    CASE Upper(cOperacao) == "+"
        QOut("Resultado: " + Str(nValor1 + nValor2, 10, 2))

    CASE Upper(cOperacao) == "-"
        QOut("Resultado: " + Str(nValor1 - nValor2, 10, 2))

    CASE Upper(cOperacao) == "*"
        QOut("Resultado: " + Str(nValor1 * nValor2, 10, 2))

    CASE Upper(cOperacao) == "/"

        IF nValor2 == 0
            QOut("Erro: divisao por zero!")
        ELSE
            QOut("Resultado: " + Str(nValor1 / nValor2, 10, 2))
        ENDIF

    CASE Upper(cOperacao) == "^"
        QOut("Resultado: " + Str(nValor1 ^ nValor2, 10, 2))

    CASE Upper(cOperacao) == "R"
        QOut("Resultado: " + Str(Sqrt(nValor1), 10, 2))

    OTHERWISE
        QOut("Operacao invalida!")

    ENDCASE

RETURN