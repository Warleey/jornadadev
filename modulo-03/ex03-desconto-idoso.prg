PROCEDURE Main()

    LOCAL cNome     := ""
    LOCAL cEntrada  := ""
    LOCAL dNasc     := CToD("")

    LOCAL nPreco    := 0
    LOCAL nIdade    := 0
    LOCAL nDesconto := 0
    LOCAL nTotal    := 0

    SET DATE FORMAT TO "DD/MM/YYYY"

    ACCEPT "Nome do cliente: " TO cNome

    ACCEPT "Data de nascimento (DD/MM/YYYY): " TO cEntrada
    dNasc := CToD(cEntrada)

    ACCEPT "Preco do produto: " TO cEntrada
    nPreco := Val(cEntrada)

    nIdade := Int((Date() - dNasc) / 365)

    IF nIdade > 60
        nDesconto := nPreco * 0.125
    ENDIF

    nTotal := nPreco - nDesconto

    QOut("")
    QOut("=============================")
    QOut("       RESUMO DA COMPRA       ")
    QOut("=============================")
    QOut("Cliente : " + cNome)
    QOut("Idade   : " + Str(nIdade, 3, 0) + " anos")
    QOut("Preco   : R$ " + Str(nPreco, 10, 2))
    QOut("Desconto: R$ " + Str(nDesconto, 10, 2))
    QOut("Total   : R$ " + Str(nTotal, 10, 2))
    QOut("=============================")

RETURN NIL