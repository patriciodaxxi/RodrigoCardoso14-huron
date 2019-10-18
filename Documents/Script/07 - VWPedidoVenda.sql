/******************************************************************************/

/******************************************************************************/
/****     Following SET SQL DIALECT is just for the Database Comparer      ****/
/******************************************************************************/
SET SQL DIALECT 3;



/******************************************************************************/
/****                                Views                                 ****/
/******************************************************************************/


/* View: VWPEDIDOVENDA */
CREATE OR ALTER VIEW VWPEDIDOVENDA(
    ID,
    IDCLIENTE,
    RAZAOSOCIAL,
    VALORTOTAL,
    CREATEDAT,
    UPDATEDAT)
AS
select
    pv.id, pv.idcliente, c.razaosocial, pv.valortotal, pv.createdat, pv.updatedat
from pedidovenda pv
inner join cliente c on c.id = pv.idcliente
order by pv.id
;




/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
