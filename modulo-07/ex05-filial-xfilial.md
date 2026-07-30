# Exercício 05 – A1_FILIAL e xFilial()

## a. Por que existe o campo A1_FILIAL na tabela SA1 (e por que toda tabela do Protheus, incluindo a ZA1, precisa de um campo de filial)?

O campo **A1_FILIAL** identifica a qual filial cada registro pertence. Isso permite que empresas com várias filiais utilizem a mesma tabela sem misturar os dados entre elas. Da mesma forma, a tabela **ZA1** também precisa desse campo para que cada cadastro de pet fique vinculado à filial correta.

---

## b. O que a função xFilial() tem a ver com isso? O que aconteceria se um programa escrevesse a filial "na mão" em vez de usar xFilial()?

A função **xFilial()** retorna a filial correta para a tabela que está sendo utilizada no momento. Assim, o sistema grava e consulta os dados na filial adequada.

Se um programa escrevesse a filial manualmente, poderia utilizar um código incorreto ou diferente da filial atual, causando gravação de dados na filial errada, consultas inconsistentes e problemas em ambientes com mais de uma filial.