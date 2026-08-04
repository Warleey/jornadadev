// ============================================
// ex06-gravarlog.prw
// Funcao de Log — registra erros em arquivo
// Faz parte da STTIPLIB.PRW na vida real
// ============================================

#include "protheus.ch"

// -----------------------------------------------
// U_GRAVARLOG
// Grava uma linha de log em arquivo texto
// Parametros:
//   cFuncao → nome da funcao onde o erro ocorreu
//   oErro   → objeto de erro com os detalhes
// -----------------------------------------------
USER FUNCTION GRAVARLOG(cFuncao, oErro)

    // Nome do arquivo de log com a data de hoje
    // Ex: \logs\advpl_20250729.log
    LOCAL cArqLog := "\logs\advpl_" + DToS(Date()) + ".log"

    // Handle (identificador) do arquivo
    LOCAL nHandle

    // Linha que sera gravada no log
    LOCAL cLinha

    // Monta a linha com data, hora, funcao e usuario
    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += cFuncao + " | "
    cLinha += cNomUsr + " | "
    cLinha += "Empresa: " + cEmpAnt + " Filial: " + cFilAnt + " | "

    // Se recebeu um objeto de erro, adiciona os detalhes tecnicos
    // Esses detalhes sao para o desenvolvedor, nao para o usuario
    IF oErro != NIL
        cLinha += "ERRO: "    + oErro:Description + " | "
        cLinha += "Funcao: "  + oErro:ProcName    + ":"
        cLinha += cValToChar(oErro:ProcLine)       + " | "
        cLinha += "SubSist: " + oErro:SubSystem    + " | "
        cLinha += "Operacao: "+ oErro:Operation
    ENDIF

    // Tenta abrir o arquivo de log ja existente
    nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)

    // Se o arquivo nao existe ainda, cria um novo
    IF nHandle < 0
        nHandle := FCreate(cArqLog)
    ENDIF

    // Move o cursor para o final do arquivo
    // para nao sobrescrever logs anteriores
    FSeek(nHandle, 0, FS_END)

    // Grava a linha no arquivo
    FWrite(nHandle, cLinha + CRLF)

    // Fecha o arquivo
    FClose(nHandle)

RETURN NIL