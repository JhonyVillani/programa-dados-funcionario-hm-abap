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
    TYPES: BEGIN OF ty_s_saida,
        bukrs     TYPE p0001-bukrs,
        butxt     TYPE t001-butxt,
        werks     TYPE p0001-werks,
        pernr     TYPE p0001-pernr,
        cname     TYPE p0002-cname,
        gbdat     TYPE p0002-gbdat,
        stell     TYPE p0001-stell,
      END OF ty_s_saida.

    TYPES: BEGIN OF ty_s_saida_descricao,
            bukrs TYPE t001-bukrs,
            butxt TYPE t001-butxt,
           END OF ty_s_saida_descricao.

    DATA: gt_t001 TYPE TABLE OF ty_s_saida_descricao.

    DATA: gs_dados_descricao TYPE ty_s_saida_descricao.

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

*   Popula uma tabela com as empresas
    SELECT bukrs
           butxt
     FROM t001
     INTO TABLE gt_t001.

    IF gt_t001 IS NOT INITIAL.
      SORT gt_t001 BY bukrs.
    ENDIF.

*   Macro para banco de dados lógico
    rp_provide_from_last p0001 space pn-begda pn-endda.
    rp_provide_from_last p0002 space pn-begda pn-endda.

    DATA: ls_saida TYPE ty_s_saida.

*   Lê o primeiro registro/linha da tabela populada por bukrs gerada pela função e envia para uma workarea gs_dados_descricao
    READ TABLE gt_t001 INTO gs_dados_descricao WITH KEY bukrs = p0001-bukrs.
    CLEAR ls_saida.

    ls_saida-bukrs = p0001-bukrs.
    ls_saida-butxt = gs_dados_descricao-butxt.
    ls_saida-werks = p0001-werks.
    ls_saida-pernr = p0001-pernr.
    ls_saida-cname = p0002-cname.
    ls_saida-gbdat = p0002-gbdat.
    ls_saida-stell = p0001-stell.

    APPEND ls_saida TO mt_dados. "Grava os dados em uma tabela final e limpa as variáveis na sequência

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