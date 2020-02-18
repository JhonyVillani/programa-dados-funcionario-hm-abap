*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP10_JM_EVE
*&---------------------------------------------------------------------*

DATA:
      go_dados TYPE REF TO lcl_dados. "Classe local

START-OF-SELECTION.
  CREATE OBJECT go_dados.

GET peras.

  go_dados->processamento( ).

END-OF-SELECTION.

  go_dados->exibicao( ).