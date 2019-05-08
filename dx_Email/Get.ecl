IMPORT Doxie, dx_Email, Data_Services;

EXPORT Get := MODULE

  EXPORT mac_payload(ds_in, d_field, _data_env = Data_Services.data_env.iNonFCRA, left_outer=FALSE, output_layout = '') := FUNCTIONMACRO
  
    IMPORT Data_Services;
    LOCAL BOOLEAN is_FCRA := _data_env = Data_Services.data_env.iFCRA;
    
    LOCAL out_rec := 
    #IF(#TEXT(output_layout) != '')
      RECORD(output_layout)
    #ELSE
      RECORD(RECORDOF(ds_in))
      dx_Email.layouts.i_Payload _email_data;
    #END
    END;
    LOCAL email_payload := JOIN(ds_in, dx_Email.Key_email_payload(is_FCRA), 
                          KEYED(LEFT.d_field = RIGHT.email_rec_key), 
                         TRANSFORM(out_rec,
                          #IF(#TEXT(output_layout) != '')
                             SELF := RIGHT, 
                          #ELSE
                             SELF._email_data := RIGHT,
                          #END
                             SELF := LEFT),
                          #IF (left_outer) 
                            LEFT OUTER,            
                          #END
                          KEEP(1),LIMIT(0));
    RETURN email_payload;                                           
  ENDMACRO;  
  
  EXPORT mac_byLexid( ds_in, did_field, data_env = Data_Services.data_env.iNonFCRA, out_layout='dx_Email.Layouts.i_Payload') := FUNCTIONMACRO

    IMPORT Doxie, dx_Email;
   
	  LOCAL ds_slim := PROJECT(ds_in, TRANSFORM(Doxie.layout_references, SELF.did := (UNSIGNED)LEFT.did_field));

    LOCAL _all_email_ids := dx_Email.Ids.mac_byLexID(ds_slim, DID, data_env);
    LOCAL _all_payload := dx_Email.Get.mac_Payload(_all_email_ids, email_rec_key, data_env, FALSE, out_layout);

    RETURN _all_payload;

  ENDMACRO;

  EXPORT mac_byLexidBatch(ds_in, did_field, data_env = Data_Services.data_env.iNonFCRA, out_layout='dx_Email.Layouts.i_Payload') := FUNCTIONMACRO

    LOCAL _email_payload := dx_Email.Get.mac_byLexid(ds_in,did_field,data_env);  // returns results in dx_Email.Layouts.i_Payload by default
    // restore accountNo etc.
    LOCAL _all_recs := JOIN(ds_in, _email_payload, (UNSIGNED) LEFT.did_field = RIGHT.DID,
                           TRANSFORM(out_layout, SELF:=RIGHT, SELF:=LEFT, SELF:=[]));
    RETURN _all_recs;
  ENDMACRO;
/*
  EXPORT byLexid(DATASET(Doxie.layout_references) did_ds, UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := FUNCTION
     RETURN mac_byLexid(did_ds, DID, data_env, dx_Email.Layouts.i_Payload);
  END;

*/
END;