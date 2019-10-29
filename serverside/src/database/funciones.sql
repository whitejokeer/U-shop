CREATE OR REPLACE FUNCTION ver_registro() 
RETURNS trigger 
AS 
$$
DECLARE
BEGIN
    
    If NOT Exists
        (Select 1 From usuarios Where correo = New.correo)
    THEN
        RETURN NEW;
    Else
        RAISE EXCEPTION 'Correo ya registrado';
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificacion
BEFORE INSERT
ON usuarios
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE ver_registro();


