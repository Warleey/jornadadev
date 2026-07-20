FUNCTION Main()

    LOCAL cNome     := "Warley Almeida"
    LOCAL nSalario  := 3500.00
    LOCAL lAtivo    := .T.
    LOCAL dAdmissao := CToD("06/11/2019")  // corrigido aqui!
    LOCAL cDepto    := "Sistemas-TI"

    QOut("Nome: " + cNome)
    QOut("Salario: " + Str(nSalario, 10, 2))
    QOut("Ativo: " + IIf(lAtivo, "Sim", "Nao"))
    QOut("Admissao: " + DToC(dAdmissao))
    QOut("Depto: " + cDepto)

RETURN NIL 