PROCEDURE Main()

    LOCAL cEntrada := ""

    LOCAL nIdade := 0
    LOCAL nDependentes := 0

    LOCAL nPlano := 0
    LOCAL nTotal := 0

    ACCEPT "Digite a idade: " TO cEntrada
    nIdade := Val(cEntrada)

    ACCEPT "Digite o numero de dependentes: " TO cEntrada
    nDependentes := Val(cEntrada)

    IF nIdade <= 25

        nPlano := 180

    ELSEIF nIdade <= 40

        nPlano := 260

    ELSEIF nIdade <= 60

        nPlano := 380

    ELSE

        nPlano := 520

    ENDIF

    nTotal := nPlano + (nDependentes * 90)

    QOut("")
    QOut("Valor do plano: R$ " + Str(nPlano, 8, 2))
    QOut("Dependentes   : " + Str(nDependentes, 3, 0))
    QOut("Valor total   : R$ " + Str(nTotal, 8, 2))

RETURN