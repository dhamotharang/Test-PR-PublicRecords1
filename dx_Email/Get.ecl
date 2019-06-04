IMPORT Doxie, dx_Email, Data_Services;

EXPORT Get (ds_in, id_field, mod_access, _data_env = Data_Services.data_env.iNonFCRA, out_rec = 'dx_Email.layouts.i_Payload') := FUNCTIONMACRO
  
    LOCAL email_payload := PROJECT(dx_Email.Append(ds_in, id_field, mod_access, _data_env, FALSE), 
                           TRANSFORM(out_rec,
                             SELF := LEFT._email_data, 
                             SELF := LEFT));
    RETURN email_payload;                                           
ENDMACRO;  
