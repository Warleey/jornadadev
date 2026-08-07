/*
 +----------------------------------------------------------------------------+
 | Programa  : STTZZ2.PRW                                                     |
 | Descricao : Manutencao das Ocorrencias do Fornecedor - ZZ2                 |
 | Modulo    : SIGACOM                                                         |
 | Autor     : Warley                                                          |
 | Data      : 2025                                                            |
 +----------------------------------------------------------------------------+
 | Tabelas utilizadas:                                                         |
 |   ZZ2 - Ocorrencias do Fornecedor                                           |
 |   ZZ1 - Controle de Fornecimento                                            |
 |   SA2 - Cadastro de Fornecedores                                            |
 |   SB1 - Cadastro de Produtos                                                |
 +----------------------------------------------------------------------------+
 | Funcoes:                                                                    |
 |   STTZZ2       - Funcao principal, abre o mBrowse sem filtro               |
 |   STTZZ2FLT    - Versao filtrada, chamada pelo botao da STTZZ1             |
 |   ZZ2Ok        - Validacoes dos campos                                     |
 |   ZZ2Grava     - Gravacao do registro com BEGIN SEQUENCE                   |
 |   ZZ2Del       - Exclusao do registro                                      |
 |   _VerificaTol - Verifica se ocorrencia esta acima da tolerancia           |
 +----------------------------------------------------------------------------+
*/

#Include "Protheus.ch"
#Include "rwmake.ch"

/*
 +----------------------------------------------------------------------------+
 | Funcao    : STTZZ2                                                          |
 | Descricao : Abre o mBrowse completo da ZZ2 sem filtro                      |
 |             Com legendas de conformidade vs tolerancia                      |
 | Retorno   : NIL                                                             |
 +----------------------------------------------------------------------------+
*/
USER FUNCTION STTZZ2()

    Local aRotinas := {}
    Local aCores   := {}

    // --- Define as rotinas do mBrowse ---
    aRotinas := { ;
        {"Incluir",    "INCLUI",    0, "ZZ2Ok()"}, ;
        {"Alterar",    "ALTERA",    0, "ZZ2Ok()"}, ;
        {"Excluir",    "EXCLUI",    0, "ZZ2Del()"}, ;
        {"Visualizar", "VISUALIZA", 0, ""}           ;
    }

    // --- Define as legendas de cores ---
    // Vermelho: percentual de nao conformidade acima da tolerancia do ZZ1
    // Verde:    dentro da tolerancia
    aCores := { ;
        {"Acima da Tolerancia",  {|| _VerificaTol()},  "\BMP\CSTP.BMP",  1}, ;
        {"Dentro da Tolerancia", {|| !_VerificaTol()}, "\BMP\CSTOK.BMP", 2}  ;
    }

    // --- Abre o mBrowse sem filtro ---
    mBrowse( ;
        3,        ;  // Linha inicial
        0,        ;  // Coluna inicial
        22,       ;  // Linha final
        79,       ;  // Coluna final
        "ZZ2",    ;  // Alias da tabela
        "",       ;  // Sem filtro
        "",       ;  // Titulo
        aRotinas, ;  // Rotinas
        "",       ;  // Campos para exibir
        1,        ;  // Ordem inicial
        "",       ;  // Chave inicial
        "",       ;  // String de pesquisa
        {},       ;  // Sem botoes customizados
        "",       ;  // Parametros adicionais
        "",       ;  // Sem cabecalho
        "",       ;  // Sem rodape
        aCores    ;  // Legendas de cores
    )

Return(NIL)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : STTZZ2FLT                                                       |
 | Descricao : Versao filtrada do mBrowse ZZ2                                  |
 |             Chamada pelo botao Ocorrencias da STTZZ1                       |
 | Parametros: cCodigoZZ1 - Codigo do controle ZZ1 selecionado (C)            |
 | Retorno   : NIL                                                             |
 +----------------------------------------------------------------------------+
*/
USER FUNCTION STTZZ2FLT(cCodigoZZ1)

    Local aRotinas := {}
    Local aCores   := {}
    Local cFiltro  := ""

    // --- Define as rotinas do mBrowse ---
    aRotinas := { ;
        {"Incluir",    "INCLUI",    0, "ZZ2Ok()"}, ;
        {"Alterar",    "ALTERA",    0, "ZZ2Ok()"}, ;
        {"Excluir",    "EXCLUI",    0, "ZZ2Del()"}, ;
        {"Visualizar", "VISUALIZA", 0, ""}           ;
    }

    // --- Define as legendas de cores ---
    aCores := { ;
        {"Acima da Tolerancia",  {|| _VerificaTol()},  "\BMP\CSTP.BMP",  1}, ;
        {"Dentro da Tolerancia", {|| !_VerificaTol()}, "\BMP\CSTOK.BMP", 2}  ;
    }

    // --- Monta o filtro para exibir apenas ocorrencias do controle selecionado ---
    cFiltro := "ZZ2->ZZ2_FILIAL == xFilial('ZZ2') .AND. " + ;
               "ZZ2->ZZ2_CONFOR == '" + cCodigoZZ1 + "'"

    // --- Abre o mBrowse com filtro ---
    mBrowse( ;
        3,        ;  // Linha inicial
        0,        ;  // Coluna inicial
        22,       ;  // Linha final
        79,       ;  // Coluna final
        "ZZ2",    ;  // Alias da tabela
        cFiltro,  ;  // Filtro pelo codigo ZZ1
        "",       ;  // Titulo
        aRotinas, ;  // Rotinas
        "",       ;  // Campos para exibir
        1,        ;  // Ordem inicial
        "",       ;  // Chave inicial
        "",       ;  // String de pesquisa
        {},       ;  // Sem botoes customizados
        "",       ;  // Parametros adicionais
        "",       ;  // Sem cabecalho
        "",       ;  // Sem rodape
        aCores    ;  // Legendas de cores
    )

Return(NIL)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ2Ok                                                           |
 | Descricao : Validacoes obrigatorias dos campos da ZZ2                       |
 |             Executada na inclusao e alteracao                               |
 | Retorno   : lRet - .T. se valido, .F. se invalido (L)                      |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ2Ok()

    Local lRet := .T.

    // --- Validacao 1: Controle ZZ1 deve existir ---
    If !ExistCpo("ZZ1", xFilial("ZZ1") + M->ZZ2_CONFOR, 1)
        MsgAlert("Codigo de controle " + M->ZZ2_CONFOR + ;
                 " nao encontrado na ZZ1!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 2: Produto deve existir na SB1 ---
    If lRet .AND. !ExistCpo("SB1", xFilial("SB1") + M->ZZ2_CODPRO, 1)
        MsgAlert("Produto " + M->ZZ2_CODPRO + ;
                 " nao cadastrado no sistema!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 3: Data nao pode ser futura ---
    If lRet .AND. M->ZZ2_DATA > dDataBase
        MsgAlert("A data da ocorrencia nao pode ser futura!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 4: Quantidades nao podem ser negativas ---
    If lRet .AND. (M->ZZ2_QTDOK < 0 .OR. M->ZZ2_QTDNOK < 0)
        MsgAlert("As quantidades nao podem ser negativas!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 5: Valor unitario nao pode ser zero ou negativo ---
    If lRet .AND. M->ZZ2_VLRUNI <= 0
        MsgAlert("O valor unitario deve ser maior que zero!", "Atencao")
        lRet := .F.
    EndIf

Return(lRet)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ2Grava                                                        |
 | Descricao : Grava o registro da ZZ2 com tratamento de erros                 |
 |             Usa BEGIN SEQUENCE para proteger a gravacao                     |
 | Retorno   : lRet - .T. se gravou, .F. se erro (L)                          |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ2Grava()

    Local lRet := .T.
    Local oErro

    BEGIN SEQUENCE

        // Trava o registro para gravacao
        RecLock("ZZ2", .T.)

        // Grava os campos no registro
        ZZ2->ZZ2_FILIAL  := xFilial("ZZ2")
        ZZ2->ZZ2_CONFOR  := M->ZZ2_CONFOR
        ZZ2->ZZ2_FORNEC  := M->ZZ2_FORNEC
        ZZ2->ZZ2_LOJAFO  := M->ZZ2_LOJAFO
        ZZ2->ZZ2_DATA    := M->ZZ2_DATA
        ZZ2->ZZ2_HORA    := M->ZZ2_HORA
        ZZ2->ZZ2_CODPRO  := M->ZZ2_CODPRO
        ZZ2->ZZ2_QTDOK   := M->ZZ2_QTDOK
        ZZ2->ZZ2_QTDNOK  := M->ZZ2_QTDNOK
        ZZ2->ZZ2_VLRUNI  := M->ZZ2_VLRUNI

        // Libera o registro apos gravacao
        MsUnLock()

    RECOVER USING oErro

        // Libera o registro em caso de erro
        MsUnLock()

        // Exibe mensagem amigavel ao usuario
        MsgAlert("Erro ao gravar a ocorrencia!" + CRLF + ;
                 "Detalhe: " + oErro:Description, "Erro")

        // Grava log tecnico do erro
        GravarLogTCC("ZZ2Grava", oErro)

        lRet := .F.

    END SEQUENCE

Return(lRet)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ2Del                                                          |
 | Descricao : Exclui registro da ZZ2 com tratamento de erros                  |
 | Retorno   : lRet - .T. se excluiu, .F. se erro (L)                         |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ2Del()

    Local lRet := .T.
    Local oErro

    BEGIN SEQUENCE

        // Trava e exclui o registro
        RecLock("ZZ2", .F.)
        DbDelete()
        MsUnLock()

    RECOVER USING oErro

        // Libera o registro em caso de erro
        MsUnLock()

        // Exibe mensagem amigavel ao usuario
        MsgAlert("Erro ao excluir a ocorrencia!" + CRLF + ;
                 "Detalhe: " + oErro:Description, "Erro")

        // Grava log tecnico do erro
        GravarLogTCC("ZZ2Del", oErro)

        lRet := .F.

    END SEQUENCE

Return(lRet)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : _VerificaTol                                                    |
 | Descricao : Verifica se a ocorrencia atual esta acima da tolerancia do ZZ1  |
 |             Usada pelas legendas do mBrowse                                 |
 | Retorno   : lAcima - .T. se acima da tolerancia (L)                        |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION _VerificaTol()

    Local nPercNC := 0
    Local nTolera := 0
    Local lAcima  := .F.

    // Calcula o percentual de nao conformidade desta ocorrencia
    nPercNC := PercNaoConforme(ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK)

    // Busca a tolerancia cadastrada no ZZ1 vinculado a esta ocorrencia
    nTolera := POSICIONE("ZZ1", 1, xFilial("ZZ1") + ZZ2->ZZ2_CONFOR, "ZZ1_TOLERA")

    // Compara o percentual com a tolerancia
    lAcima := (nPercNC > nTolera)

Return(lAcima)