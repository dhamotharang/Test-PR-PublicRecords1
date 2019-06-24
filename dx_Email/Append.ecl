IMPORT Data_Services;

EXPORT Append (ds_in, id_field, mod_access, _data_env = Data_Services.data_env.iNonFCRA, left_outer=FALSE) := FUNCTIONMACRO
  
    IMPORT Data_Services, Suppress, doxie;
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

    #IF (left_outer) 
      ds_email_data_flagged := Suppress.MAC_FlagSuppressedSource(email_payload, mod_access, _email_data.did, _email_data.global_sid);
      ds_email_data_suppressed := PROJECT(ds_email_data_flagged, TRANSFORM( out_rec, SELF._email_data:= IF(~LEFT.is_suppressed,LEFT._email_data), SELF:= LEFT));
    #ELSE
      ds_email_data_suppressed := Suppress.MAC_SuppressSource(email_payload, mod_access, _email_data.did, _email_data.global_sid);
    #END
    ds_email_suppressed_slim := PROJECT(ds_email_data_suppressed, TRANSFORM( dx_Email.layouts.i_Payload, SELF:= LEFT._email_data)); 
    
    doxie.compliance.logSoldToSources(ds_email_suppressed_slim, mod_access);
    RETURN ds_email_data_suppressed;
ENDMACRO;
