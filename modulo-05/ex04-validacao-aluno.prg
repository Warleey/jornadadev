PROCEDURE Main()

    LOCAL cNome := ""
    LOCAL cDisc := ""
    LOCAL cEntrada := ""
    LOCAL nNota1 := -1
    LOCAL nNota2 := -1
    LOCAL nMedia := 0

    WHILE Len(Trim(cNome)) == 0
        ACCEPT "Digite o nome do aluno: " TO cNome
    ENDDO

    WHILE Len(cDisc) <> 3 .OR. cDisc <> Upper(cDisc)
        ACCEPT "Digite a disciplina (3 letras maiusculas): " TO cDisc
    ENDDO

    WHILE nNota1 < 0 .OR. nNota1 > 10
        ACCEPT "Digite a primeira nota: " TO cEntrada
        nNota1 := Val(cEntrada)
    ENDDO

    WHILE nNota2 < 0 .OR. nNota2 > 10
        ACCEPT "Digite a segunda nota: " TO cEntrada
        nNota2 := Val(cEntrada)
    ENDDO

    nMedia := (nNota1 + nNota2) / 2

    QOut("")
    QOut("Nome: " + cNome)
    QOut("Disciplina: " + cDisc)
    QOut("Nota 1: " + LTrim(Str(nNota1)))
    QOut("Nota 2: " + LTrim(Str(nNota2)))
    QOut("Media: " + LTrim(Str(nMedia, 5, 2)))

RETURN NIL