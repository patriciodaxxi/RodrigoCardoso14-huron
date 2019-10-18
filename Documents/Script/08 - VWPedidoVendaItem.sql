/******************************************************************************/

/******************************************************************************/
/****     Following SET SQL DIALECT is just for the Database Comparer      ****/
/******************************************************************************/
SET SQL DIALECT 3;



/******************************************************************************/
/****                                Views                                 ****/
/******************************************************************************/


/* View: VWPEDIDOVENDAITEM */
CREATE OR ALTER VIEW VWPEDIDOVENDAITEM(
    ID,
    IDPEDIDOVENDA,
    IDPRODUTO,
    DESCRICAO,
    VALORVENDA,
    QUANTIDADE,
    VALORTOTAL,
    SEQUENCIA)
AS
select PVI.ID, PVI.IDPEDIDOVENDA, PVI.IDPRODUTO, p.descricao, PVI.VALORVENDA, PVI.QUANTIDADE, PVI.VALORTOTAL, pvi.sequencia
from PEDIDOVENDAITEM PVI  
inner join produto p on p.id = pvi.idproduto
order by Sequencia
;




/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
