/*
 +----------------------------------------------------------------------------+
 | Programa  : STTZZLIB.PRW                                                   |
 | Descricao : Biblioteca de funcoes comuns do TCC ISO 9001                   |
 | Modulo    : SIGACOM                                                         |
 | Autor     : Warley                                                          |
 | Data      : 2025                                                            |
 +----------------------------------------------------------------------------+
 | Funcoes:                                                                    |
 |   NomeFornecedor   - Retorna nome do fornecedor via SA2                    |
 |   NomeProduto      - Retorna descricao do produto via SB1                  |
 |   PercNaoConforme  - Calcula percentual de nao conformidade                 |
 |   CertificadoVencendo - Verifica se certificado vence em 30 dias           |
 |   GravarLogTCC     - Grava log de erros em arquivo texto                   |
 +----------------------------------------------------------------------------+
*/

#Include "Protheus.ch"

/*
 +----------------------------------------------------------------------------+
 | Funcao    : NomeFornecedor                                                  |
 | Descricao : Retorna o nome do fornecedor buscando na tabela SA2             |
 | Parametros: cFornec - Codigo do fornecedor (C)                              |
 |             cLoja   - Loja do fornecedor   (C)                              |
 | Retorno   : cNome   - Nome do fornecedor   (C)                              |
 +----------------------------------------------------------------------------+
*/
FUNCTION NomeFornecedor(cFornec, cLoja)

    Local cNome := ""

    // Busca o nome do fornecedor na tabela SA2
    // usando o indice 1 (FILIAL + CODIGO + LOJA)
    cNome := POSICIONE("SA2", 1, xFilial("SA2") + cFornec + cLoja, "A2_NOME")

Return(cNome)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : NomeProduto                                                     |
 | Descricao : Retorna a descricao do produto buscando na tabela SB1           |
 | Parametros: cCodPro - Codigo do produto (C)                                 |
 | Retorno   : cDesc   - Descricao do produto (C)                              |
 +----------------------------------------------------------------------------+
*/
FUNCTION NomeProduto(cCodPro)

    Local cDesc := ""

    // Busca a descricao do produto na tabela SB1
    // usando o indice 1 (FILIAL + CODIGO)
    cDesc := POSICIONE("SB1", 1, xFilial("SB1") + cCodPro, "B1_DESC")

Return(cDesc)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : PercNaoConforme                                                 |
 | Descricao : Calcula o percentual de nao conformidade de uma ocorrencia      |
 | Parametros: nOk  - Quantidade conforme     (N)                              |
 |             nNok - Quantidade nao conforme (N)                              |
 | Retorno   : nPerc - Percentual de nao conformidade (N)                      |
 +----------------------------------------------------------------------------+
*/
FUNCTION PercNaoConforme(nOk, nNok)

    Local nPerc := 0

    // Evita divisao por zero quando ambos sao zero
    If (nOk + nNok) > 0
        nPerc := (nNok / (nOk + nNok)) * 100
    EndIf

Return(nPerc)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : CertificadoVencendo                                             |
 | Descricao : Verifica se o certificado vence nos proximos 30 dias            |
 | Parametros: dValCer - Data de validade do certificado (D)                   |
 | Retorno   : lVencendo - .T. se vence em 30 dias, .F. caso contrario (L)    |
 +----------------------------------------------------------------------------+
*/
FUNCTION CertificadoVencendo(dValCer)

    Local lVencendo := .F.

    // Verifica se a data esta entre hoje e 30 dias a frente
    // dValCer >= dDataBase    → ainda nao venceu
    // dValCer <= dDataBase+30 → vence dentro de 30 dias
    If dValCer >= dDataBase .AND. dValCer <= (dDataBase + 30)
        lVencendo := .T.
    EndIf

Return(lVencendo)

/*
 +----------------------------------------------------------------------------+
 | Funcao    : GravarLogTCC                                                    |
 | Descricao : Grava registro de erro em arquivo de log texto                  |
 | Parametros: cFuncao - Nome da funcao onde ocorreu o erro (C)                |
 |             oErro   - Objeto de erro do BEGIN SEQUENCE    (O)               |
 | Retorno   : NIL                                                             |
 +----------------------------------------------------------------------------+
*/
FUNCTION GravarLogTCC(cFuncao, oErro)

    Local cArqLog   := GetTempPath() + "TCC_ERROS.LOG"
    Local nHandle   := 0
    Local cMensagem := ""

    // Monta a linha de log com data, hora, funcao e descricao do erro
    cMensagem := "[" + DTOS(Date()) + " " + Time() + "] " + ;
                 "Funcao: " + cFuncao + " | "            + ;
                 "Erro: "   + oErro:Description          + ;
                 CRLF

    // Tenta abrir o arquivo existente
    nHandle := FOpen(cArqLog, 1)

    // Se nao existir, cria um novo
    If nHandle == -1
        nHandle := FCreate(cArqLog)
    EndIf

    // Grava a mensagem no final do arquivo e fecha
    If nHandle > 0
        FSeek(nHandle, 0, 2)
        FWrite(nHandle, cMensagem)
        FClose(nHandle)
    EndIf

Return(NIL)