FUNCTION Main()

    LOCAL aEstoque := {}
    LOCAL cOpcao := ""

    SET PROCEDURE TO estoque_lib.prg

    WHILE cOpcao != "0"

        QOut("")
        QOut("CONTROLE DE ESTOQUE")
        QOut("")
        QOut("1 - Cadastrar produto")
        QOut("2 - Listar produtos")
        QOut("3 - Entrada de estoque")
        QOut("4 - Saida de estoque")
        QOut("5 - Buscar produto")
        QOut("6 - Relatorio do estoque")
        QOut("0 - Sair")
        QOut("")

        ACCEPT "Escolha uma opcao: " TO cOpcao

        DO CASE

        CASE cOpcao == "1"

            CadastrarProduto(aEstoque)

        CASE cOpcao == "2"

            ListarProdutos(aEstoque)

        CASE cOpcao == "3"

            EntradaEstoque(aEstoque)

        CASE cOpcao == "4"

            SaidaEstoque(aEstoque)

        CASE cOpcao == "5"

            BuscarProduto(aEstoque)

        CASE cOpcao == "6"

            RelatorioEstoque(aEstoque)

        CASE cOpcao == "0"

            QOut("")
            QOut("Programa encerrado.")

        OTHERWISE

            QOut("")
            QOut("Opcao invalida.")

        ENDCASE

    ENDDO

RETURN NIL