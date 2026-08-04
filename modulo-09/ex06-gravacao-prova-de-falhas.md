# Exercício 6 — Gravação à Prova de Falhas

---

## O que é este exercício?

Este exercício implementa uma gravação segura de registros no Protheus,
combinando 4 camadas de proteção para garantir que nenhum dado
fique gravado pela metade em caso de erro.

---

## As 4 Camadas de Proteção

| Camada | Recurso | O que faz |
|--------|---------|-----------|
| 1 | `BeginTran()` | Abre a transação — "tudo ou nada" |
| 2 | `BEGIN SEQUENCE` | Captura erros inesperados |
| 3 | `IF + Break()` | Valida campos obrigatórios |
| 4 | `RecLock / MsUnLock` | Trava e libera o registro |

---

## Fluxo da Gravação

```
Início
  │
  ├── BeginTran() → abre a transação
  │
  ├── BEGIN SEQUENCE
  │     ├── Z1_CLIENTE vazio? → Break() → vai para o RECOVER
  │     ├── Z1_ASSUNTO vazio? → Break() → vai para o RECOVER
  │     ├── RecLock → trava o registro
  │     ├── Grava os campos na tabela SZ1
  │     └── MsUnLock → salva e libera
  │
  ├── RECOVER WITH oErro (só entra aqui se der erro)
  │     ├── lOk := .F.
  │     ├── RollBackTran() → desfaz tudo
  │     ├── MsgStop() → mensagem amigável ao usuário
  │     └── U_GRAVARLOG() → grava log técnico
  │
  └── IF lOk → CommitTran() → confirma a gravação
```

---

## Arquivos entregues

### `ex06-gravacao-segura.prw`
Contém a função `U_STTIP003SALVAR()` responsável pela gravação
segura do contato na tabela SZ1.

### `ex06-gravarlog.prw`
Contém a função `U_GRAVARLOG()` responsável por registrar os
erros em um arquivo de log para diagnóstico posterior.

---

## Explicação de cada parte

### BeginTran() e CommitTran() / RollBackTran()

```advpl
BeginTran()   // abre a transacao
...
CommitTran()  // confirma tudo se deu certo
RollBackTran() // desfaz tudo se deu errado
```

Garante o princípio **"tudo ou nada"**:
- Se tudo deu certo → `CommitTran()` confirma a gravação
- Se algo deu errado → `RollBackTran()` desfaz tudo

> Sem isso, um erro no meio da gravação deixaria dados
> incompletos no banco.

---

### BEGIN SEQUENCE / RECOVER WITH oErro

```advpl
BEGIN SEQUENCE
    // codigo que pode gerar erro inesperado
RECOVER WITH oErro
    // executado apenas se ocorrer erro
END SEQUENCE
```

Funciona como o **try/catch** de outras linguagens.
Captura erros inesperados como:
- Banco de dados inacessível
- Registro travado por outro usuário
- Queda de rede

---

### Validação com IF + Break()

```advpl
IF Empty(M->Z1_CLIENTE)
    MsgAlert("Cliente e obrigatorio!", "Atencao")
    lOk := .F.
    Break()  // pula para o RECOVER
ENDIF
```

Valida os campos obrigatórios **antes** de tentar gravar.
O `Break()` força a saída para o `RECOVER` sem gerar
um erro real — é uma saída controlada.

> **Importante:** Validação de dados é diferente de
> tratamento de erro!
> - Validação (esperado) → `IF + Break()`
> - Erro inesperado (banco, rede) → `BEGIN SEQUENCE`

---

### RecLock e MsUnLock

```advpl
RecLock("SZ1", .T.)  // .T. = novo registro (inclusao)
RecLock("SZ1", .F.)  // .F. = registro atual (alteracao)
...
MsUnLock()           // salva e libera o lock
```

Garante que **dois usuários não editem o mesmo registro**
ao mesmo tempo:
- `RecLock` trava o registro
- `MsUnLock` salva e libera

---

### U_GRAVARLOG()

```advpl
U_GRAVARLOG("STTIP003SALVAR", oErro)
```

Grava um arquivo de log com:
- Data e hora do erro
- Função onde ocorreu
- Usuário logado
- Empresa e filial
- Descrição técnica do erro

> O usuário vê uma **mensagem amigável**.
> O desenvolvedor vê os **detalhes técnicos no log**.

---

## Diferença entre Sem e Com tratamento

| Sem tratamento | Com tratamento |
|----------------|----------------|
| Trava com mensagem técnica | Mensagem clara e amigável |
| Dados gravados pela metade | RollBack automático |
| Difícil diagnosticar | Log técnico detalhado |
| Usuário perdido | Sistema continua funcionando |

---

## Boas práticas aplicadas

1. **IF para o esperado** → validação de campos vazios
2. **BEGIN SEQUENCE para o inesperado** → erro de banco/rede
3. **Toda transação faz RollBack no erro** → nada pela metade
4. **Mensagem amigável ao usuário** → detalhe técnico no log
5. **Nunca engolir erro em silêncio** → sempre gravar o log

> 💡 Um `RECOVER` vazio é uma bomba-relógio:
> no mínimo, grave o log!

---

## Observação sobre a entrega

Este código foi escrito e documentado no VSCode.
Por não ter o ambiente Protheus disponível para rodar
os exercícios bônus (Ex 1 ao 4) que criam a estrutura
necessária (tabelas SZ1/SZ2, rotinas base), o código
é entregue comentado conforme orientação do professor:

> *"Sem ambiente? Entrega o código comentado;
> sem print, sem problema."*