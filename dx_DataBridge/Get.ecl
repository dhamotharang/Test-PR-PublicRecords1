/*
  A set of macros to get databridge information.
*/

EXPORT Get := MODULE
   
	 EXPORT byDid (ds_in, id_field, recs_per_did = 1) := FUNCTIONMACRO
  
      LOCAL bridge_payload := JOIN(ds_in, dx_DataBridge.Key_DID, 
                                   KEYED(LEFT.id_field = RIGHT.did), 
                                   TRANSFORM(RIGHT),
                                   KEEP(recs_per_did),LIMIT(0));

      RETURN bridge_payload;
		
   ENDMACRO;                                
END;  
