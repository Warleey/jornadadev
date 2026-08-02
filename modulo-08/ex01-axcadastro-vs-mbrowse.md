# Exercício 01 – AxCadastro × mBrowse

## a. Quando você usaria AxCadastro e quando usaria mBrowse? Dê um exemplo de cada.

Eu usaria o **AxCadastro** quando precisasse criar rapidamente um cadastro simples, sem muitas personalizações na tela. Um exemplo seria um cadastro básico de pets, com as opções de incluir, alterar, excluir, visualizar e pesquisar.

Já o **mBrowse** seria utilizado quando o sistema precisasse de uma tela mais personalizada e com mais recursos. Um exemplo seria um cadastro de pets que mostrasse linhas coloridas, filtros específicos e colunas escolhidas de acordo com a necessidade do usuário.

---

## b. Cite três coisas que o mBrowse faz e o AxCadastro não faz.

O **mBrowse** permite utilizar legendas coloridas nas linhas, aplicar filtros mais completos e definir colunas personalizadas na tela. Esses recursos oferecem maior controle sobre a aparência e o funcionamento da listagem.

---

## c. Na configuração de legendas (aColors), por que a regra ".T." deve ficar por último?

As regras do `aColors` são verificadas de cima para baixo, e a primeira condição verdadeira define a cor da linha. Como `".T."` significa uma condição sempre verdadeira, ela deve ficar por último para funcionar como a cor padrão dos registros que não atenderam às regras anteriores.

---

## d. Qual a diferença entre um campo Virtual (X3_RELACAO) e um gatilho (SX7) para preencher o nome do cliente?

O campo **Virtual** calcula e apresenta o nome do cliente quando a informação é exibida, mas esse valor não é gravado fisicamente no banco de dados.

Já o **gatilho SX7** executa uma regra quando o usuário preenche ou sai de determinado campo. Ele pode preencher outro campo automaticamente durante a digitação e, caso o campo de destino seja Real, o valor pode ser gravado no banco de dados.