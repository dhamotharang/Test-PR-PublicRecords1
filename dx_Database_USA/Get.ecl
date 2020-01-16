/*
  A set of macros to get database usa information.
*/

EXPORT Get := MODULE
   
	 EXPORT byDid (ds_in, id_field, recs_per_did = 1) := FUNCTIONMACRO
  
      LOCAL dbusa_payload := JOIN(ds_in, dx_Database_USA.Key_Did, 
                                   KEYED(LEFT.id_field = RIGHT.did), 
                                   TRANSFORM(RIGHT),
                                   KEEP(recs_per_did),LIMIT(0));

      RETURN dbusa_payload;
		
   ENDMACRO;                                
END;  
