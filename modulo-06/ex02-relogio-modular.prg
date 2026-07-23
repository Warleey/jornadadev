FUNCTION Main()

    LOCAL cHora := ""
    LOCAL nCont := 0

    FOR nCont := 1 TO 30

        cHora := ObterHora()
        cHora := FormatarHora(cHora)
        ExibirHora(cHora)

        Inkey(1)

    NEXT

RETURN NIL


FUNCTION ObterHora()

RETURN Time()


FUNCTION FormatarHora(cHora)

RETURN cHora


FUNCTION ExibirHora(cHora)

    QOut("Hora atual: " + cHora)

RETURN NIL