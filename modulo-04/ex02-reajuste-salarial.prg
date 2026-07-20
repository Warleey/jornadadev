PROCEDURE Main()

    LOCAL cEntrada := ""

    LOCAL nSalario := 0
    LOCAL nReajuste := 0
    LOCAL nNovoSalario := 0

    ACCEPT "Digite o salario atual: R$ " TO cEntrada
    nSalario := Val(cEntrada)

    IF nSalario < 1000

        nReajuste := 0.15

    ELSEIF nSalario <= 2000

        nReajuste := 0.12

    ELSEIF nSalario <= 4000

        nReajuste := 0.08

    ELSE

        nReajuste := 0.05

    ENDIF

    nNovoSalario := nSalario + (nSalario * nReajuste)

    QOut("")
    QOut("Salario atual : R$ " + Str(nSalario, 10, 2))
    QOut("Reajuste      : " + Str(nReajuste * 100, 5, 0) + "%")
    QOut("Novo salario  : R$ " + Str(nNovoSalario, 10, 2))

RETURN