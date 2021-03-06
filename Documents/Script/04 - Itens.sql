/******************************************************************************/
/****              Generated by IBExpert 18/10/2019 13:00:41               ****/
/******************************************************************************/

/******************************************************************************/
/****     Following SET SQL DIALECT is just for the Database Comparer      ****/
/******************************************************************************/
SET SQL DIALECT 3;



/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/


CREATE GENERATOR GEN_PEDIDOVENDAITEM_ID;

CREATE TABLE PEDIDOVENDAITEM (
    ID             INTEGER NOT NULL,
    IDPEDIDOVENDA  INTEGER NOT NULL,
    IDPRODUTO      INTEGER NOT NULL,
    VALORVENDA     DECIMAL(15,5) NOT NULL,
    QUANTIDADE     NUMERIC(15,5) NOT NULL,
    VALORTOTAL     NUMERIC(15,5) NOT NULL,
    SEQUENCIA      INTEGER
);




/******************************************************************************/
/****                             Primary Keys                             ****/
/******************************************************************************/

ALTER TABLE PEDIDOVENDAITEM ADD CONSTRAINT PK_PEDIDOVENDAITEM PRIMARY KEY (ID);


/******************************************************************************/
/****                             Foreign Keys                             ****/
/******************************************************************************/

ALTER TABLE PEDIDOVENDAITEM ADD CONSTRAINT FK_PEDIDOVENDAITEM_PEDIDOVENDA FOREIGN KEY (IDPEDIDOVENDA) REFERENCES PEDIDOVENDA (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE PEDIDOVENDAITEM ADD CONSTRAINT FK_PEDIDOVENDAITEM_PRODUTO FOREIGN KEY (IDPRODUTO) REFERENCES PRODUTO (ID) ON UPDATE CASCADE;


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



/* Trigger: PEDIDOVENDAITEM_BI */
CREATE OR ALTER TRIGGER PEDIDOVENDAITEM_BI FOR PEDIDOVENDAITEM
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_pedidovendaitem_id,1);
end
^


SET TERM ; ^



/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
