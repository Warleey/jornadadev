/*
 +----------------------------------------------------------------------------+
 | Programa  : STTZZ1.PRW                                                     |
 | Descricao : Manutencao do Controle de Fornecimento - ZZ1                   |
 | Modulo    : SIGACOM                                                         |
 | Autor     : Warley                                                          |
 | Data      : 2025                                                            |
 +----------------------------------------------------------------------------+
 | Tabelas utilizadas:                                                         |
 |   ZZ1 - Controle de Fornecimento                                            |
 |   SA2 - Cadastro de Fornecedores                                            |
 +----------------------------------------------------------------------------+
 | Funcoes:                                                                    |
 |   STTZZ1    - Funcao principal, abre o mBrowse                             |
 |   ZZ1Ok     - Validacoes dos campos                                        |
 |   ZZ1Grava  - Gravacao do registro com BEGIN SEQUENCE                      |
 |   ZZ1Del    - Exclusao do registro com validacao de ZZ2 vinculada          |
 +----------------------------------------------------------------------------+
*/

#Include "Protheus.ch"
#Include "rwmake.ch"

/*
 +----------------------------------------------------------------------------+
 | Funcao    : STTZZ1                                                          |
 | Descricao : Abre o mBrowse da ZZ1 com legendas de validade do certificado  |
 |             e botao para abrir ocorrencias da ZZ2                           |
 | Retorno   : NIL                                                             |
 +----------------------------------------------------------------------------+
*/
USER FUNCTION STTZZ1()

    Local aRotinas  := {}
    Local aButtons  := {}
    Local aCores    := {}

    // --- Define as rotinas do mBrowse ---
    aRotinas := { ;
        {"Incluir",    "INCLUI",    0, "ZZ1Ok()"}, ;
        {"Alterar",    "ALTERA",    0, "ZZ1Ok()"}, ;
        {"Excluir",    "EXCLUI",    0, "ZZ1Del()"}, ;
        {"Visualizar", "VISUALIZA", 0, ""}          ;
    }

    // --- Define as legendas de cores ---
    // Vermelho: certificado vencido
    // Amarelo:  vence em 30 dias
    // Verde:    certificado ok
    aCores := { ;
        {"Certificado Vencido",  {|| ZZ1->ZZ1_VALCER < dDataBase},              "\BMP\CSTP.BMP",  1}, ;
        {"Vence em 30 dias",     {|| CertificadoVencendo(ZZ1->ZZ1_VALCER)},     "\BMP\CSTL.BMP",  2}, ;
        {"Certificado OK",       {|| ZZ1->ZZ1_VALCER > (dDataBase + 30)},       "\BMP\CSTOK.BMP", 3}  ;
    }

    // --- Define o botao customizado Ocorrencias ---
    // Ao clicar, abre a ZZ2 filtrada pelo codigo do ZZ1 selecionado
    AADD(aButtons, { ;
        "Ocorrencias", ;
        {|| U_STTZZ2FLT(ZZ1->ZZ1_CODIGO)}, ;
        "" ;
    })

    // --- Abre o mBrowse ---
    mBrowse( ;
        3,          ;  // Linha inicial
        0,          ;  // Coluna inicial
        22,         ;  // Linha final
        79,         ;  // Coluna final
        "ZZ1",      ;  // Alias da tabela
        "",         ;  // Filtro (sem filtro aqui)
        "",         ;  // Titulo
        aRotinas,   ;  // Rotinas
        "",         ;  // Campos para exibir
        1,          ;  // Ordem inicial
        "",         ;  // Chave inicial
        "",         ;  // String de pesquisa
        aButtons,   ;  // Botoes customizados
        "",         ;  // Parametros adicionais
        "",         ;  // Sem cabecalho
        "",         ;  // Sem rodape
        aCores      ;  // Legendas de cores
    )

Return(NIL)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ1Ok                                                           |
 | Descricao : Validacoes obrigatorias dos campos da ZZ1                       |
 |             Executada na inclusao e alteracao                               |
 | Retorno   : lRet - .T. se valido, .F. se invalido (L)                      |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ1Ok()

    Local lRet := .T.

    // --- Validacao 1: Fornecedor deve existir na SA2 ---
    If !ExistCpo("SA2", xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, 1)
        MsgAlert("Fornecedor " + M->ZZ1_FORNEC + " nao cadastrado no sistema!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 2: Validade do certificado nao pode ser inferior a data atual ---
    If lRet .AND. M->ZZ1_VALCER < dDataBase
        MsgAlert("A validade do certificado nao pode ser inferior a data atual!", "Atencao")
        lRet := .F.
    EndIf

    // --- Validacao 3: Tolerancia deve estar entre 0 e 100 ---
    If lRet .AND. (M->ZZ1_TOLERA < 0 .OR. M->ZZ1_TOLERA > 100)
        MsgAlert("A tolerancia deve estar entre 0 e 100%!", "Atencao")
        lRet := .F.
    EndIf

Return(lRet)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ1Grava                                                        |
 | Descricao : Grava o registro da ZZ1 com tratamento de erros                 |
 |             Usa BEGIN SEQUENCE para proteger a gravacao                     |
 | Retorno   : lRet - .T. se gravou, .F. se erro (L)                          |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ1Grava()

    Local lRet := .T.
    Local oErro

    BEGIN SEQUENCE

        // Trava o registro para gravacao
        RecLock("ZZ1", .T.)

        // Grava os campos no registro
        ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
        ZZ1->ZZ1_CODIGO := M->ZZ1_CODIGO
        ZZ1->ZZ1_FORNEC := M->ZZ1_FORNEC
        ZZ1->ZZ1_LOJAFO := M->ZZ1_LOJAFO
        ZZ1->ZZ1_CERTIF := M->ZZ1_CERTIF
        ZZ1->ZZ1_VALCER := M->ZZ1_VALCER
        ZZ1->ZZ1_TOLERA := M->ZZ1_TOLERA
        ZZ1->ZZ1_TOTOK  := M->ZZ1_TOTOK
        ZZ1->ZZ1_TOTNOK := M->ZZ1_TOTNOK

        // Libera o registro apos gravacao
        MsUnLock()

    RECOVER USING oErro

        // Libera o registro em caso de erro
        MsUnLock()

        // Exibe mensagem amigavel ao usuario
        MsgAlert("Erro ao gravar o registro!" + CRLF + ;
                 "Detalhe: " + oErro:Description, "Erro")

        // Grava log tecnico do erro
        GravarLogTCC("ZZ1Grava", oErro)

        lRet := .F.

    END SEQUENCE

Return(lRet)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : ZZ1Del                                                          |
 | Descricao : Exclui registro da ZZ1                                          |
 |             Impede exclusao se houver ZZ2 vinculada (diferencial)           |
 | Retorno   : lRet - .T. se excluiu, .F. se bloqueado ou erro (L)            |
 +----------------------------------------------------------------------------+
*/
STATIC FUNCTION ZZ1Del()

    Local lRet    := .T.
    Local oErro
    Local cCodigo := ZZ1->ZZ1_CODIGO

    // --- Verifica se existe ZZ2 vinculada a este controle ---
    // Se existir, bloqueia a exclusao (integridade referencial)
    If ExistCpo("ZZ2", xFilial("ZZ2") + cCodigo, 1)
        MsgAlert("Nao e possivel excluir!" + CRLF + ;
                 "Existem ocorrencias vinculadas a este controle.", "Atencao")
        lRet := .F.
    EndIf

    // --- Se nao houver vinculo, realiza a exclusao ---
    If lRet
        BEGIN SEQUENCE

            // Trava e exclui o registro
            RecLock("ZZ1", .F.)
            DbDelete()
            MsUnLock()

        RECOVER USING oErro

            // Libera o registro em caso de erro
            MsUnLock()

            // Exibe mensagem amigavel ao usuario
            MsgAlert("Erro ao excluir o registro!" + CRLF + ;
                     "Detalhe: " + oErro:Description, "Erro")

            // Grava log tecnico do erro
            GravarLogTCC("ZZ1Del", oErro)

            lRet := .F.

        END SEQUENCE
    EndIf

Return(lRet)