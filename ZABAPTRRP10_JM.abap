*---------------------------------------------------------------------*
*                         INTELLIGENZA                                *
*---------------------------------------------------------------------*
* Cliente....:                                                        *
* Autor......: Jhony Villani                                          *
* Data.......: 17/02/2020                                             *
* Descrição..: Treinamento ABAP - Dados de funcionário                *
* Transação..:                                                        *
* Projeto....: Treinamento ABAP                                       *
*---------------------------------------------------------------------*
* Histórico das modificações                                          *
*---------------------------------------------------------------------*
* Autor :                                                             *
* Observações:                                                        *
*---------------------------------------------------------------------*

REPORT zabaptrrp10_jm.

INCLUDE zabaptrrp10_jm_top. "Declarações Globais
INCLUDE zabaptrrp10_jm_src. "Tela de seleção
INCLUDE zabaptrrp10_jm_eve. "Eventos
INCLUDE zabaptrrp10_jm_for. "Rotinas
INCLUDE zabaptrrp10_jm_c01. "Classe

DATA:
      go_dados TYPE REF TO lcl_dados. "Classe local

START-OF-SELECTION.
  CREATE OBJECT go_dados.

  go_dados->processamento( ).
  go_dados->exibicao( ).