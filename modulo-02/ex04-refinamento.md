# Exercício 4 — Refinamento Sucessivo

---

## Nível 1 — Visão Geral

1. Registrar os itens da compra
2. Calcular o subtotal
3. Aplicar desconto se o cliente tiver cartão fidelidade
4. Mostrar o total a pagar

---

## Nível 2 — Detalhamento

### Passo 1: Registrar os itens da compra

- Leia o nome do item
- Leia o preço do item
- Leia a quantidade do item
- Calcule o valor do item → `valorItem <- preco * quantidade`
- Some ao subtotal → `subtotal <- subtotal + valorItem`
- Repita até não haver mais itens

### Passo 2: Calcular o subtotal

- Some o valor de todos os itens registrados
- `subtotal <- soma de todos os valorItem`
- Escreva "Subtotal: ", subtotal

### Passo 3: Aplicar desconto

- Leia se o cliente tem cartão fidelidade (S/N)
- Se **Sim:**
  - `desconto <- subtotal * 0,05`
  - `total <- subtotal - desconto`
  - Escreva "Desconto aplicado: ", desconto
- Se **Não:**
  - `total <- subtotal`
  - Escreva "Sem desconto."

### Passo 4: Mostrar o total a pagar

- Escreva "Total a pagar: ", total
- Fim.