/*
  A set of macros to append database usa information to a dataset.
*/

EXPORT Append := MODULE 

  EXPORT byDid(ds_in, id_field, recs_per_did = 1, left_outer=FALSE) := FUNCTIONMACRO
  
    LOCAL out_rec := 
      RECORD(RECORDOF(ds_in))
      dx_Database_USA.Layout_Keybase dbusa_data;
    END;
		
    LOCAL dbusa_payload := JOIN(ds_in, dx_Database_USA.Key_Did, 
                              KEYED(LEFT.id_field = RIGHT.did), 
                              TRANSFORM(out_rec,
                                 SELF.dbusa_data := RIGHT,
                                 SELF := LEFT),
                              #IF (left_outer) 
                                LEFT OUTER,            
                              #END
                              KEEP(recs_per_did),LIMIT(0));

    RETURN dbusa_payload;
		
   ENDMACRO;
END;
