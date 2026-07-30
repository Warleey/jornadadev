# Exercício 04 – Campo customizado na SA1

## Objetivo

Criar um campo customizado na tabela **SA1 (Cadastro de Clientes)** utilizando o Configurador do Protheus e validar sua utilização no SmartClient.

---

# 1. Criação do campo

No módulo **Configurador (SIGACFG)** foi acessado o seguinte caminho:

> Base de Dados → Dicionário → Bases de Dados → Empresa Teste → Dicionário de Dados → SA1 → Campos

Foi incluído um novo campo personalizado com as seguintes características:

| Campo | Valor |
|--------|-------|
| Campo | A1_XAPELID |
| Tipo | C |
| Tamanho | 30 |
| Título | Apelido |
| Descrição | Apelido do Cliente |
| Contexto | Real |

Após salvar, o novo campo passou a fazer parte da estrutura da tabela SA1.

### Print do Configurador

![Campo A1_XAPELID no Configurador](evidencias\tabela-sa-configurada.png)

---

# 2. Validação no SmartClient

Após a criação do campo, foi aberto o módulo **SIGAMDI** e acessado o cadastro de clientes.

O novo campo **Apelido** apareceu normalmente na tela do sistema, comprovando que a customização foi reconhecida pelo Protheus.

Foi realizado um teste preenchendo o campo para confirmar seu funcionamento.

### Print do SmartClient

![Campo Apelido no SmartClient](evidencias\tabela-sa-validacao.png)

---

# Conclusão

O campo customizado **A1_XAPELID** foi criado com sucesso na tabela SA1 através do Configurador.

Após a criação, foi possível visualizar e utilizar o campo normalmente no SmartClient, confirmando que a customização foi aplicada corretamente.