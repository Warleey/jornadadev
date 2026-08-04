// ============================================
// ex06-gravacao-segura.prw
// Exercicio 6 — Gravacao a prova de falhas
// Modulo 9 — Jornada DEV START (TOTVS Paulista)
// ============================================

#include "protheus.ch"

// -----------------------------------------------
// U_STTIP003SALVAR
// Funcao principal de gravacao segura do Contato
// Combina 4 camadas de protecao:
// 1. Transacao (BeginTran/CommitTran/RollBackTran)
// 2. Tratamento de erro (BEGIN SEQUENCE)
// 3. Validacao de negocio (IF + Break)
// 4. Lock de registro (RecLock/MsUnLock)
// -----------------------------------------------
USER FUNCTION STTIP003SALVAR()

    // lOk controla se a gravacao foi bem sucedida
    // Comeca como .T. (verdadeiro) e vira .F. se algo der errado
    LOCAL lOk  := .T.

    // oErro vai receber o objeto de erro caso algo inesperado aconteca
    LOCAL oErro

    // CAMADA 1: Inicia a transacao
    // Tudo que acontecer daqui para frente pode ser desfeito
    // com RollBackTran() se algo der errado
    BeginTran()

    // CAMADA 2: Inicia o bloco de protecao contra erros inesperados
    // Funciona como o try/catch de outras linguagens
    BEGIN SEQUENCE

        // CAMADA 3: Validacao dos campos obrigatorios
        // Se Z1_CLIENTE estiver vazio, avisa e sai do BEGIN SEQUENCE
        IF Empty(M->Z1_CLIENTE)
            MsgAlert("Cliente e obrigatorio!", "Atencao")
            lOk := .F.  // marca que deu erro
            Break()     // pula para o RECOVER
        ENDIF

        // Se Z1_ASSUNTO estiver vazio, avisa e sai do BEGIN SEQUENCE
        IF Empty(M->Z1_ASSUNTO)
            MsgAlert("Assunto e obrigatorio!", "Atencao")
            lOk := .F.  // marca que deu erro
            Break()     // pula para o RECOVER
        ENDIF

        // CAMADA 4: Trava o registro para gravacao
        // Seleciona a area de trabalho da tabela SZ1
        dbSelectArea("SZ1")

        // RecLock trava o registro:
        // .T. = cria um novo registro (inclusao)
        // .F. = trava o registro atual (alteracao)
        IF INCLUI
            RecLock("SZ1", .T.)  // novo registro
        ELSE
            RecLock("SZ1", .F.)  // altera o atual
        ENDIF

        // Grava os valores dos campos na tabela
        SZ1->Z1_CODIGO  := M->Z1_CODIGO
        SZ1->Z1_CLIENTE := M->Z1_CLIENTE
        SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
        SZ1->Z1_DATA    := M->Z1_DATA
        SZ1->Z1_HORA    := M->Z1_HORA

        // MsUnLock salva os dados e libera o lock do registro
        MsUnLock()

    // RECOVER e executado APENAS se ocorrer um erro inesperado
    // oErro recebe o objeto com os detalhes do que aconteceu
    RECOVER WITH oErro

        // Marca que a gravacao falhou
        lOk := .F.

        // Desfaz TUDO que foi feito desde o BeginTran()
        // Garante que nada fica gravado pela metade
        RollBackTran()

        // Mostra uma mensagem clara e amigavel para o usuario
        // O usuario nao precisa ver detalhes tecnicos
        MsgStop("Erro ao salvar o contato. Tente novamente." + ;
                Chr(13) + "Detalhe: " + oErro:Description, "Erro")

        // Registra o erro no log para o desenvolvedor analisar
        // O log fica salvo em arquivo para diagnostico posterior
        U_GRAVARLOG("STTIP003SALVAR", oErro)

        // Retorna .F. imediatamente apos o erro
        RETURN lOk

    END SEQUENCE

    // So chama CommitTran() se tudo deu certo
    // Confirma definitivamente a gravacao no banco
    IF lOk
        CommitTran()
    ENDIF

RETURN lOk