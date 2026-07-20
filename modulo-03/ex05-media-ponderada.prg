PROCEDURE Main()

    LOCAL cEntrada := ""

    LOCAL nNota1 := 0
    LOCAL nNota2 := 0
    LOCAL nNota3 := 0
    LOCAL nNota4 := 0
    LOCAL nMedia := 0

    ACCEPT "Digite a primeira nota: " TO cEntrada
    nNota1 := Val(cEntrada)

    ACCEPT "Digite a segunda nota: " TO cEntrada
    nNota2 := Val(cEntrada)

    ACCEPT "Digite a terceira nota: " TO cEntrada
    nNota3 := Val(cEntrada)

    ACCEPT "Digite a quarta nota: " TO cEntrada
    nNota4 := Val(cEntrada)

    nMedia := (nNota1 * 1 + nNota2 * 2 + nNota3 * 3 + nNota4 * 4) / (1 + 2 + 3 + 4)

    QOut("")
    QOut("==========================")
    QOut("   MEDIA PONDERADA")
    QOut("==========================")
    QOut("Media: " + Str(nMedia, 10, 2))
    QOut("==========================")

RETURN NIL