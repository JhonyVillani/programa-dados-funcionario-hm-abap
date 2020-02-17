*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP10_JM_C01
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_dados DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_dados DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_s_saida,
        bukrs     TYPE p0001-bukrs,
        werks     TYPE p0001-werks,
        pernr     TYPE p0001-pernr,
        cname     TYPE p0002-cname,
        gbdat     TYPE p0002-gbdat,
        stell     TYPE p0001-stell,
      END OF ty_s_saida.

    DATA: mt_dados TYPE TABLE OF ty_s_saida.

    DATA: mo_alv TYPE REF TO cl_salv_table.

    METHODS:
       processamento,
       exibicao.

ENDCLASS.                    "lcl_dados DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_dados IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_dados IMPLEMENTATION.
  METHOD processamento.

    DATA: lt_p0001 TYPE TABLE OF p0001,
          lt_p0002 TYPE TABLE OF p0002,
          ls_p0001 TYPE p0001,
          ls_p0002 TYPE p0002,
          ls_saida TYPE ty_s_saida,
          ls_pernr LIKE LINE OF s_pernr.

*   Percorre todas as matrículas selecionadas
    LOOP AT s_pernr INTO ls_pernr.

*     Lê infotipo 0001 - Atribuição Organizacional
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = ls_pernr-low
          infty           = '0001'
          begda           = sy-datum
          endda           = sy-datum
        TABLES
          infty_tab       = lt_p0001
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

*     Lê infotipo 0002 - Atribuição Organizacional
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = ls_pernr-low
          infty           = '0002'
          begda           = sy-datum
          endda           = sy-datum
        TABLES
          infty_tab       = lt_p0002
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

*     Lê o primeiro registro/linha da tabela p0001 gerada pela função e envia para uma workarea
      READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.

*     Lê o primeiro registro/linha da tabela p0002 gerada pela função e envia para uma workarea
      READ TABLE lt_p0002 INTO ls_p0002 INDEX 1.

*     Envia os dados da workarea para uma workarea definida pelo TYPES com campos melhor definidos
      ls_saida-bukrs = ls_p0001-bukrs.
      ls_saida-werks = ls_p0001-werks.
      ls_saida-pernr = ls_p0001-pernr.
      ls_saida-cname = ls_p0002-cname.
      ls_saida-gbdat = ls_p0002-gbdat.
      ls_saida-stell = ls_p0001-stell.

      APPEND ls_saida TO mt_dados. "Grava os dados em uma tabela final e limpa as variáveis na sequência

      CLEAR: lt_p0001, ls_p0001. "limpa registros da estrutura
      CLEAR: lt_p0002, ls_p0002. "limpa registros da estrutura

    ENDLOOP.

  ENDMETHOD.                    "processamento

  METHOD exibicao.

*   Criando o relatório ALV, declarando na classe a variáveis mo_alv referenciando cl_salv_table
*   Chama o método que constrói a saída ALV
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = mo_alv
      CHANGING
        t_table      = mt_dados.

*   Mostra o ALV
    mo_alv->display( ). "Imprime na tela do relatório ALV
  ENDMETHOD.                    "exibicao

ENDCLASS.                    "lcl_dados IMPLEMENTATION