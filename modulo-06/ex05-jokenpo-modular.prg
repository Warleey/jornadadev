FUNCTION Main()

    LOCAL cJogadaUsuario := ""
    LOCAL cJogadaCPU := ""
    LOCAL cVencedor := ""
    LOCAL cResposta := "S"

    WHILE Upper(cResposta) == "S"

        cJogadaUsuario := ""

        WHILE ! ValidarJogada(cJogadaUsuario)

            QOut("")
            QOut("Escolha uma jogada:")
            QOut("PEDRA")
            QOut("PAPEL")
            QOut("TESOURA")

            ACCEPT "Digite sua jogada: " TO cJogadaUsuario

            cJogadaUsuario := Upper(Trim(cJogadaUsuario))

            IF ! ValidarJogada(cJogadaUsuario)
                QOut("Jogada invalida.")
            ENDIF

        ENDDO

        cJogadaCPU := SortearJogadaCPU()

        cVencedor := DefinirVencedor(cJogadaUsuario, cJogadaCPU)

        QOut("")
        QOut("Sua jogada: " + cJogadaUsuario)
        QOut("Jogada da CPU: " + cJogadaCPU)
        QOut(cVencedor)

        QOut("")
        ACCEPT "Deseja jogar novamente? (S/N): " TO cResposta

        cResposta := Upper(Trim(cResposta))

    ENDDO

    QOut("")
    QOut("Jogo encerrado.")

RETURN NIL


FUNCTION SortearJogadaCPU()

    LOCAL nJogada := HB_RandomInt(1, 3)
    LOCAL cJogada := ""

    DO CASE

    CASE nJogada == 1
        cJogada := "PEDRA"

    CASE nJogada == 2
        cJogada := "PAPEL"

    CASE nJogada == 3
        cJogada := "TESOURA"

    ENDCASE

RETURN cJogada


FUNCTION ValidarJogada(cJogada)

    LOCAL lValida := .F.

    IF cJogada == "PEDRA" .OR. ;
       cJogada == "PAPEL" .OR. ;
       cJogada == "TESOURA"

        lValida := .T.

    ENDIF

RETURN lValida


FUNCTION DefinirVencedor(cJogadaUsuario, cJogadaCPU)

    LOCAL cResultado := ""

    IF cJogadaUsuario == cJogadaCPU

        cResultado := "Empate!"

    ELSEIF cJogadaUsuario == "PEDRA" .AND. ;
           cJogadaCPU == "TESOURA"

        cResultado := "Voce venceu!"

    ELSEIF cJogadaUsuario == "PAPEL" .AND. ;
           cJogadaCPU == "PEDRA"

        cResultado := "Voce venceu!"

    ELSEIF cJogadaUsuario == "TESOURA" .AND. ;
           cJogadaCPU == "PAPEL"

        cResultado := "Voce venceu!"

    ELSE

        cResultado := "A CPU venceu!"

    ENDIF

RETURN cResultado