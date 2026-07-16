# Exercício 2 — Pseudocódigo

---

## a) Área do Retângulo

```
Início

  Leia Base
  Leia Altura

  Area <- Base * Altura

  Escreva Area

Fim
```

**Explicação**

Primeiro precisamos receber os dados.
Depois fazemos o cálculo.
Por último mostramos o resultado.

Sempre pense:

**Entrada → Processamento → Saída**

---

## b) Número Par ou Ímpar

```
Início

  Leia Numero

  Se Numero % 2 = 0
    Escreva "Par"
  Senão
    Escreva "Ímpar"
  FimSe

Fim
```

**Por que usar %?**

O operador `%` significa o **resto da divisão**.

Exemplo:

- 8 ÷ 2 → resto = 0 → **8 é par**
- 7 ÷ 2 → resto = 1 → **7 é ímpar**

---

## c) Maior entre Três Números

```
Início

  Leia A
  Leia B
  Leia C

  Maior <- A

  Se B > Maior
    Maior <- B
  FimSe

  Se C > Maior
    Maior <- C
  FimSe

  Escreva Maior

Fim
```

**Por que fazer assim?**

Imagine:

- A = 10
- B = 5
- C = 30

Primeiro assumimos: `Maior = A` → ou seja, `Maior = 10`

Depois perguntamos:
- B é maior que 10? **Não.**
- C é maior que 10? **Sim.** → `Maior = 30`

No final sobra apenas o maior número! ✅

Essa técnica é muito usada para encontrar:

- Maior preço
- Maior salário
- Maior nota
- Maior data