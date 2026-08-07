# Evidências — Telas do Sistema

## ⚠️ Ambiente Protheus não disponível

Por não ter acesso ao ambiente Protheus, não foi possível
gerar prints das telas em execução.

## O que seria evidenciado aqui:

### STTZZ1 — Controle de Fornecimento
- Tela do mBrowse da ZZ1 com a lista de controles
- Legenda vermelha para certificados vencidos
- Legenda amarela para certificados vencendo em 30 dias
- Legenda verde para certificados ok
- Botão "Ocorrências" abrindo a ZZ2 filtrada

### STTZZ2 — Ocorrências do Fornecedor
- Tela do mBrowse da ZZ2 com a lista de ocorrências
- Legenda vermelha para ocorrências acima da tolerância
- Legenda verde para ocorrências dentro da tolerância
- Tela filtrada pelo controle ZZ1 selecionado

### Validações
- Mensagem de erro ao informar fornecedor inexistente
- Mensagem de erro ao informar data futura
- Mensagem de erro ao informar tolerância fora do range
- Mensagem de erro ao tentar excluir ZZ1 com ZZ2 vinculada

### BEGIN SEQUENCE
- Mensagem amigável em caso de erro na gravação
- Log de erros gerado em TCC_ERROS.LOG

## 📋 Descrição das telas está no README.md principal