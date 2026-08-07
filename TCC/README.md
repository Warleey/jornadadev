# Sistema de Controle de Não Conformidades — ISO 9001
### Indústria XYZ  
**Curso:** Harbour/ADVPL
**Autor:** Warley  
**Módulo:** SIGACOM — Compras  

---

## 📋 Descrição do Sistema

A **Indústria XYZ** precisa monitorar as não conformidades na entrada de
materiais dos seus fornecedores para se manter em conformidade com o
processo de certificação **ISO 9001**.

O sistema permite:
- Cadastrar e controlar os **certificados de qualidade** por fornecedor
- Registrar as **ocorrências de não conformidade** em cada entrega
- Alertar sobre certificados **vencidos** ou **próximos do vencimento**
- Calcular automaticamente o **percentual de não conformidade** por entrega
- Bloquear entregas que ultrapassem a **tolerância** cadastrada

---

## 🗂️ Estrutura do Repositório

```

TCC/
├── README.md
├── Dados-e-Dicionario/
│ ├── sx2990.csv ← Dicionário de Tabelas
│ ├── sx3990.csv ← Dicionário de Campos (ZZ1 + ZZ2)
│ ├── six990.csv ← Dicionário de Índices
│ ├── sx7990.csv ← Dicionário de Gatilhos
│ ├── sxb990.csv ← Dicionário de Consultas F3
│ ├── zz1990.csv ← Dados de exemplo ZZ1
│ ├── zz2990.csv ← Dados de exemplo ZZ2
│ └── converte-dicionario.prg ← Utilitário DBF para CSV
├── fontes/
│ ├── STTZZ1.PRW ← Rotina mBrowse da ZZ1
│ ├── STTZZ2.PRW ← Rotina mBrowse da ZZ2
│ └── STTZZLIB.PRW ← Biblioteca de funções comuns
├── evidencias/
│ └── README.md ← Ambiente Protheus não disponível
└── AUTOAVALIACAO.md

```

---

## 📊 Tabelas

### ZZ1 — Controle de Fornecimento
> Acesso: Compartilhado | Módulo: SIGACOM

| Campo | Título | Tipo | Tam | Dec | Contexto |
|-------|--------|------|-----|-----|----------|
| ZZ1_FILIAL | Filial | C | 2 | 0 | Real |
| ZZ1_CODIGO | Código | C | 6 | 0 | Real |
| ZZ1_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real |
| ZZ1_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real |
| ZZ1_NOMEFO | Nome Fornecedor | C | 40 | 0 | Virtual |
| ZZ1_CERTIF | Dados Certificado | C | 256 | 0 | Real |
| ZZ1_VALCER | Val. Certificado | D | 8 | 0 | Real |
| ZZ1_TOLERA | Tolerância (%) | N | 5 | 2 | Real |
| ZZ1_TOTOK | Qtd. Conforme | N | 12 | 2 | Real |
| ZZ1_TOTNOK | Qtd. Não Conforme | N | 12 | 2 | Real |

**Índices ZZ1:**
| Ordem | Expressão | Descrição |
|-------|-----------|-----------|
| 1 | ZZ1_FILIAL + ZZ1_CODIGO | Chave primária |
| 2 | ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO | Por fornecedor |
| 3 | ZZ1_FILIAL + DTOS(ZZ1_VALCER) | Por validade do certificado |

---

### ZZ2 — Ocorrências do Fornecedor
> Acesso: Compartilhado | Módulo: SIGACOM

| Campo | Título | Tipo | Tam | Dec | Contexto |
|-------|--------|------|-----|-----|----------|
| ZZ2_FILIAL | Filial | C | 2 | 0 | Real |
| ZZ2_CONFOR | Controle (→ZZ1) | C | 6 | 0 | Real |
| ZZ2_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real |
| ZZ2_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real |
| ZZ2_NOMEFO | Nome Fornecedor | C | 40 | 0 | Virtual |
| ZZ2_DATA | Data Ocorrência | D | 8 | 0 | Real |
| ZZ2_HORA | Hora | C | 5 | 0 | Real |
| ZZ2_CODPRO | Produto | C | 15 | 0 | Real |
| ZZ2_QTDOK | Qtde. Conforme | N | 12 | 0 | Real |
| ZZ2_QTDNOK | Qtde. Não Conforme | N | 12 | 0 | Real |
| ZZ2_VLRUNI | Valor Unitário | N | 12 | 2 | Real |
| ZZ2_TOTOK | R$ Conforme | N | 12 | 2 | Virtual |
| ZZ2_TOTNOK | R$ Não Conforme | N | 12 | 2 | Virtual |

**Índices ZZ2:**
| Ordem | Expressão | Descrição |
|-------|-----------|-----------|
| 1 | ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA | Chave primária |
| 2 | ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA) | Por fornecedor e data |
| 3 | ZZ2_FILIAL + DTOS(ZZ2_DATA) | Por data |

---

## ✅ Validações

### Na ZZ1:
| Campo | Regra | Mensagem |
|-------|-------|----------|
| ZZ1_FORNEC | Deve existir na SA2 | Fornecedor não cadastrado no sistema |
| ZZ1_VALCER | Não pode ser inferior à data atual | Validade não pode ser inferior à data atual |
| ZZ1_TOLERA | Deve estar entre 0 e 100 | Tolerância deve estar entre 0 e 100% |

### Na ZZ2:
| Campo | Regra | Mensagem |
|-------|-------|----------|
| ZZ2_CONFOR | Deve existir na ZZ1 | Código de controle não encontrado na ZZ1 |
| ZZ2_CODPRO | Deve existir na SB1 | Produto não cadastrado no sistema |
| ZZ2_DATA | Não pode ser futura | Data da ocorrência não pode ser futura |
| ZZ2_QTDOK | Não pode ser negativa | Quantidades não podem ser negativas |
| ZZ2_VLRUNI | Deve ser maior que zero | Valor unitário deve ser maior que zero |

---

## ⚡ Gatilhos (SX7)

### Na ZZ1:
| Campo Origem | Campo Destino | Regra |
|-------------|---------------|-------|
| ZZ1_FORNEC | ZZ1_NOMEFO | Busca nome do fornecedor na SA2 |

### Na ZZ2:
| Campo Origem | Campo Destino | Regra |
|-------------|---------------|-------|
| ZZ2_CONFOR | ZZ2_FORNEC | Busca código do fornecedor na ZZ1 |
| ZZ2_CONFOR | ZZ2_LOJAFO | Busca loja do fornecedor na ZZ1 |
| ZZ2_CONFOR | ZZ2_NOMEFO | Busca nome do fornecedor na SA2 |
| ZZ2_DATA | ZZ2_DATA | Preenche com data do sistema na inclusão |
| ZZ2_HORA | ZZ2_HORA | Preenche com hora do sistema na inclusão |

---

## 📁 Rotinas

### STTZZ1.PRW — Controle de Fornecimento
- mBrowse da tabela ZZ1
- **Legendas:**
  - 🔴 Vermelho: certificado vencido
  - 🟡 Amarelo: vence em 30 dias
  - 🟢 Verde: certificado ok
- **Botão "Ocorrências":** abre a ZZ2 filtrada pelo controle selecionado
- **Exclusão protegida:** impede excluir ZZ1 se houver ZZ2 vinculada

### STTZZ2.PRW — Ocorrências do Fornecedor
- mBrowse da tabela ZZ2
- **Legendas:**
  - 🔴 Vermelho: % não conforme acima da tolerância do ZZ1
  - 🟢 Verde: dentro da tolerância
- **Versão filtrada:** `STTZZ2FLT` chamada pelo botão da STTZZ1

### STTZZLIB.PRW — Biblioteca de Funções Comuns
| Função | Descrição |
|--------|-----------|
| `NomeFornecedor(cFornec, cLoja)` | Retorna nome do fornecedor via SA2 |
| `NomeProduto(cCodPro)` | Retorna descrição do produto via SB1 |
| `PercNaoConforme(nOk, nNok)` | Calcula percentual de não conformidade |
| `CertificadoVencendo(dValCer)` | Verifica se vence em 30 dias |
| `GravarLogTCC(cFuncao, oErro)` | Grava log de erros em arquivo texto |

---

## 🗺️ Menu SIGACOM

```

Cadastros
└── Controle ISO 9001
├── Controle de Fornecimento (ZZ1) → USER FUNCTION STTZZ1
└── Ocorrências de Fornecedores (ZZ2) → USER FUNCTION STTZZ2

```
---

## 🚀 Instruções de Instalação

### Com ambiente Protheus:
1. Copie os arquivos `.DBF` da pasta `Dados-e-Dicionario/` para o servidor
2. Importe o dicionário pelo **Configurador do Protheus**
3. Compile os fontes no **DevStudio** nesta ordem:
   - `STTZZLIB.PRW` — compilar primeiro
   - `STTZZ1.PRW`
   - `STTZZ2.PRW`
4. Configure o menu no **SIGACOM** conforme descrito acima
5. Cadastre fornecedores na **SA2** e produtos na **SB1** para teste

### Sem ambiente Protheus:
1. Os CSVs da pasta `Dados-e-Dicionario/` representam o dicionário
2. Os fontes `.PRW` da pasta `fontes/` estão escritos e comentados
3. Para gerar os CSVs a partir dos DBFs, use o `converte-dicionario.prg`:
```bash
hbmk2 converte-dicionario.prg
converte-dicionario.exe
````

---

## 🔒 Tratamento de Erros

Todas as operações de banco de dados utilizam **`BEGIN SEQUENCE`**:

- Mensagem amigável exibida ao usuário
- Log técnico gravado via **`GravarLogTCC()`**
- Registro desbloqueado automaticamente em caso de erro

---

## 🔗 Relacionamento entre Tabelas



```
SA2 (Fornecedores) ←──── ZZ1 (Controle de Fornecimento)
                                      ↑
SB1 (Produtos) ←──── ZZ2 (Ocorrências do Fornecedor)