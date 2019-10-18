/******************************************************************************/

/******************************************************************************/
/****     Following SET SQL DIALECT is just for the Database Comparer      ****/
/******************************************************************************/
SET SQL DIALECT 3;



/******************************************************************************/
/****                                Views                                 ****/
/******************************************************************************/


/* View: VWCLIENTE */
CREATE OR ALTER VIEW VWCLIENTE(
    ID,
    RAZAOSOCIAL,
    NOMEFANTASIA,
    CNPJ,
    ENDERECO,
    TELEFONE,
    EMAIL,
    CREATEDAT,
    UPDATEDAT)
AS
select ID, RAZAOSOCIAL, NOMEFANTASIA, CNPJ, ENDERECO, TELEFONE, EMAIL, CREATEDAT, UPDATEDAT
from CLIENTE C
order by id
;




/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
