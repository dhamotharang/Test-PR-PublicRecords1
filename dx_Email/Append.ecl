IMPORT Data_Services;

EXPORT Append (ds_in, id_field, mod_access, _data_env = Data_Services.data_env.iNonFCRA, left_outer=FALSE) := FUNCTIONMACRO
  
    IMPORT Data_Services;
    LOCAL BOOLEAN is_FCRA := _data_env = Data_Services.data_env.iFCRA;
    
    LOCAL out_rec := 
      RECORD(RECORDOF(ds_in))
      dx_Email.layouts.i_Payload _email_data;
    END;
    LOCAL email_payload := JOIN(ds_in, dx_Email.Key_email_payload(is_FCRA), 
                          KEYED(LEFT.id_field = RIGHT.email_rec_key), 
                          TRANSFORM(out_rec,
                             SELF._email_data := RIGHT,
                             SELF := LEFT),
                          #IF (left_outer) 
                            LEFT OUTER,            
                          #END
                          KEEP(1),LIMIT(0));
    RETURN email_payload;                                           
ENDMACRO;  
