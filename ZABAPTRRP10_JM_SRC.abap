*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP10_JM_SRC
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
SELECT-OPTIONS: s_pernr FOR pa0001-pernr no INTERVALS OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.