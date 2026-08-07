# Autoavaliação — TCC Harbour/ADVPL

**Aluno:** Warley  
**Repositório:** https://github.com/Warleey/jornadadev  
**Data de entrega:** 07/08/2025
---

## ✅ Núcleo Mínimo

| Item | Status | Observação |
|------|--------|------------|
| Tabela ZZ1 definida no dicionário | ✅ Feito | Arquivo sx3990.csv |
| STTZZ1.PRW com mBrowse | ✅ Feito | Arquivo fontes/STTZZ1.PRW |
| Validações da ZZ1 | ✅ Feito | ZZ1_FORNEC, ZZ1_VALCER, ZZ1_TOLERA |
| BEGIN SEQUENCE na gravação | ✅ Feito | Funções ZZ1Grava e ZZ1Del |

---

## 📋 Critérios de Avaliação

| Critério | Peso | Status | Onde está |
|----------|------|--------|-----------|
| Dicionário (tabelas, índices, SX3) | 20% | ✅ Feito | Dados-e-Dicionario/ |
| Rotinas funcionais (mBrowse, legendas, filtros) | 20% | ✅ Feito | fontes/STTZZ1.PRW e STTZZ2.PRW |
| Validações de dados | 15% | ✅ Feito | Funções ZZ1Ok e ZZ2Ok |
| Gatilhos automáticos | 10% | ✅ Feito | sx7990.csv |
| Tratamento de erros (BEGIN SEQUENCE) | 10% | ✅ Feito | ZZ1Grava, ZZ1Del, ZZ2Grava, ZZ2Del |
| Biblioteca de funções (STTZZLIB) | 10% | ✅ Feito | fontes/STTZZLIB.PRW |
| Menu no SIGACOM | 5% | ✅ Feito | Descrito no README.md |
| Documentação | 10% | ✅ Feito | README.md |

---

## ⭐ Diferenciais Implementados

| Diferencial | Status | Onde está |
|-------------|--------|-----------|
| Cabeçalho de documentação nos fontes | ✅ Feito | Todos os arquivos .PRW |
| Comentários em todas as funções | ✅ Feito | Todos os arquivos .PRW |
| Zero duplicação de código | ✅ Feito | Funções centralizadas na STTZZLIB.PRW |
| Legenda ZZ2 com % não conforme vs tolerância | ✅ Feito | Função _VerificaTol em STTZZ2.PRW |
| Impedir exclusão de ZZ1 com ZZ2 vinculada | ✅ Feito | Função ZZ1Del em STTZZ1.PRW |

---

## 📁 Arquivos Entregues

### Dados-e-Dicionario/
| Arquivo | Descrição |
|---------|-----------|
| sx2990.csv | Dicionário de tabelas (ZZ1 e ZZ2) |
| sx3990.csv | Dicionário de campos (ZZ1 e ZZ2) |
| six990.csv | Dicionário de índices |
| sx7990.csv | Dicionário de gatilhos |
| sxb990.csv | Dicionário de consultas F3 |
| zz1990.csv | Dados de exemplo da ZZ1 |
| zz2990.csv | Dados de exemplo da ZZ2 |
| converte-dicionario.prg | Utilitário DBF para CSV |

### fontes/
| Arquivo | Descrição |
|---------|-----------|
| STTZZ1.PRW | Rotina mBrowse da ZZ1 com legendas e botão Ocorrências |
| STTZZ2.PRW | Rotina mBrowse da ZZ2 com legendas e versão filtrada |
| STTZZLIB.PRW | Biblioteca de funções comuns |

---

## ⚠️ Observações

- Ambiente Protheus **não disponível** para execução
- Dicionário entregue como **CSV** conforme orientação da rubrica
- Fontes `.PRW` escritos e comentados conforme orientação da rubrica
- Prints das telas **não disponíveis** por ausência do ambiente
- Pasta `evidencias/` criada conforme estrutura exigida