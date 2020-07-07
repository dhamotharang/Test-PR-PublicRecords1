/*
  A set of macros to append databridge information to a dataset.
*/

EXPORT Append := MODULE 

  EXPORT byDid(ds_in, id_field, recs_per_did = 1, left_outer=FALSE) := FUNCTIONMACRO
  
    LOCAL out_rec := 
      RECORD(RECORDOF(ds_in))
      dx_DataBridge.Layout_Keybase databridge_data;
    END;
		
    LOCAL bridge_payload := JOIN(ds_in, dx_DataBridge.Key_DID, 
                              KEYED(LEFT.id_field = RIGHT.did), 
                              TRANSFORM(out_rec,
                                 SELF.databridge_data := RIGHT,
                                 SELF := LEFT),
                              #IF (left_outer) 
                                LEFT OUTER,            
                              #END
                              KEEP(recs_per_did),LIMIT(0));

    RETURN bridge_payload;
		
   ENDMACRO;
END;
