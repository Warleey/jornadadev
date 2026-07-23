FUNCTION Main()

    LOCAL aAlunos := {}
    LOCAL cEntrada := ""
    LOCAL cNome := ""
    LOCAL nQuantidade := 0
    LOCAL nNota1 := 0
    LOCAL nNota2 := 0
    LOCAL nNota3 := 0
    LOCAL nNota4 := 0
    LOCAL nMedia := 0
    LOCAL nCont := 0

    ACCEPT "Digite a quantidade de alunos: " TO cEntrada

    nQuantidade := Val(cEntrada)

    FOR nCont := 1 TO nQuantidade

        QOut("")
        QOut("Aluno " + LTrim(Str(nCont)))

        ACCEPT "Digite o nome: " TO cNome

        ACCEPT "Digite a primeira nota: " TO cEntrada
        nNota1 := Val(cEntrada)

        ACCEPT "Digite a segunda nota: " TO cEntrada
        nNota2 := Val(cEntrada)

        ACCEPT "Digite a terceira nota: " TO cEntrada
        nNota3 := Val(cEntrada)

        ACCEPT "Digite a quarta nota: " TO cEntrada
        nNota4 := Val(cEntrada)

        AADD(aAlunos, { ;
            cNome, ;
            nNota1, ;
            nNota2, ;
            nNota3, ;
            nNota4 ;
        })

    NEXT

    QOut("")
    QOut("ALUNOS APROVADOS")

    FOR nCont := 1 TO Len(aAlunos)

        nMedia := (aAlunos[nCont][2] + ;
                   aAlunos[nCont][3] + ;
                   aAlunos[nCont][4] + ;
                   aAlunos[nCont][5]) / 4

        IF nMedia >= 7

            QOut("")
            QOut("Nome: " + aAlunos[nCont][1])
            QOut("Media: " + Str(nMedia, 10, 2))

        ENDIF

    NEXT

    QOut("")
    QOut("ALUNOS REPROVADOS")

    FOR nCont := 1 TO Len(aAlunos)

        nMedia := (aAlunos[nCont][2] + ;
                   aAlunos[nCont][3] + ;
                   aAlunos[nCont][4] + ;
                   aAlunos[nCont][5]) / 4

        IF nMedia < 7

            QOut("")
            QOut("Nome: " + aAlunos[nCont][1])
            QOut("Media: " + Str(nMedia, 10, 2))

        ENDIF

    NEXT

RETURN NIL