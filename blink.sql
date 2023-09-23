# dblink estension implement funtion trigger 


CREATE OR REPLACE FUNCTION ahorro.pg_actualizaregistros_cero_2()
	RETURNS trigger 
	LANGUAGE plpgsql
	VOLATILE
AS $$	
DECLARE
  hostdb varchar;
  --tipo int4 := 1;
  cuenta_param varchar := new.cuenta; 
  q1 varchar;
  tipo int4 := new.tipo;
  solicitante_id varchar := new.solicitante_id;
  monto float8 := new.monto_original;
  creado_por int4 := new.creado_por;
  fecha_creacion timestamp(0) := new.fecha_creacion;
  return_id int4; 
 
begin	
	hostdb := (select dblink_connect('conecction','hostaddr= port= dbname= user= password='));
	raise notice '%', hostdb;

   -- insert into table (tipo, solicitante_id, cuenta, monto, usuario_creacion, fecha_creacion)
    q1 = 'INSERT INTO tabledestino(tipo, solicitante_id, cuenta, monto, usuario_creacion, fecha_creacion) 
      VALUES ('||tipo||','''||solicitante_id||''','''||cuenta_param||''','''||monto||''','''||creado_por||''','''||fecha_creacion||''') RETURNING id';
     select *  from dblink('cero_conecction', q1)
     AS (id int4) into return_id;
  /*   
	select *  from dblink('conecction', 'select ''1''as tipo, solicitante_id , cuenta, monto_original, creado_por, fecha_creacion from table')
    AS (tipo int4, solicitante_id varchar,cuenta varchar, monto_original float8, creado_por int4, fecha_creacion timestamp(0)) 
    WHERE cuenta LIKE cuenta_param ;
   */
     perform dblink_disconnect('conecction');
     --SELECT dblink_disconnect('conecction');
return new;
END;
$$;

