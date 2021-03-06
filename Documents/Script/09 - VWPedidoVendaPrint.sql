CREATE OR ALTER VIEW VWPEDIDOVENDAPRINT(
    ID,
    IDCLIENTE,
    VALORTOTAL,
    CREATEDATPEDIDOVENDA,
    UPDATEDATPEDIDOVENDA,
    RAZAOSOCIAL,
    NOMEFANTASIA,
    CNPJ,
    ENDERECO,
    TELEFONE,
    EMAIL,
    CREATEDATCLIENTE,
    UPDATEDATCLIENTE)
AS
SELECT
    PV.ID, PV.IDCLIENTE, PV.VALORTOTAL, PV.CREATEDAT CREATEDATPedidoVenda, PV.UPDATEDAT UPDATEDATPedidoVenda,
        C.RAZAOSOCIAL,
       C.NOMEFANTASIA, C.CNPJ, C.ENDERECO, C.TELEFONE, C.EMAIL, C.CREATEDAT CREATEDATCliente, C.UPDATEDAT UPDATEDATCliente
FROM PEDIDOVENDA PV
INNER JOIN CLIENTE C ON C.ID = PV.IDCLIENTE
order by pv.id
;