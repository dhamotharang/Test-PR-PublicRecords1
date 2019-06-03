IMPORT dx_Email, Data_Services;

EXPORT Ids := MODULE


  EXPORT mac_byLexID(ds_in, d_field, _data_env=Data_Services.data_env.iNonFCRA, left_outer=FALSE) := FUNCTIONMACRO

   IMPORT Data_Services;
   
    LOCAL BOOLEAN is_FCRA := _data_env = Data_Services.data_env.iFCRA;
    
    LOCAL out_rec := RECORD(RECORDOF(ds_in))
      dx_Email.layouts.i_DID.email_rec_key;
    END;
    
    LOCAL ids_from_lexid := 
                          JOIN(ds_in, dx_Email.Key_Did(is_FCRA), 
                            KEYED((UNSIGNED)LEFT.d_field = RIGHT.DID), 
                            TRANSFORM(out_rec,
                              SELF.email_rec_key := RIGHT.email_rec_key,                                
                              SELF := LEFT),
                          #IF (left_outer) 
                            LEFT OUTER,            
                          #END
                          LIMIT(10000, SKIP));  // as of 5/1/19 only 9 lexids in index have above 10K recs in index with largest being 50590 recs, 65 LexIds have above 5K recs

    RETURN ids_from_lexid;                                           
  ENDMACRO;          

  EXPORT mac_byEmail(ds_in, d_field, left_outer=FALSE) := FUNCTIONMACRO
  
  IMPORT STD;   
    LOCAL out_rec := RECORD(RECORDOF(ds_in))
      dx_Email.layouts.i_DID.email_rec_key;
    END;

    LOCAL ds_prpd := PROJECT(ds_in, TRANSFORM(RECORDOF(ds_in), 
                            SELF.d_field := STD.Str.ToUpperCase(TRIM(LEFT.d_field, ALL)), SELF:=LEFT));
    
    LOCAL email_ids := JOIN(ds_prpd,dx_Email.Key_Email_Address(), 
                          KEYED(LEFT.d_field = RIGHT.clean_email), 
                          TRANSFORM(out_rec,
                              SELF.email_rec_key := RIGHT.email_rec_key,                                
                              SELF := LEFT),
                          #IF (left_outer) 
                            LEFT OUTER,            
                          #END
                          LIMIT(2000, SKIP));  // as of 5/1/19  50 email addresses with above 2k recs in index appear to be either fake or role addresses (like none@none.com or admin@domainassetholdings.com                                                                                                                                                                           

    RETURN email_ids;                                           
  ENDMACRO;  
  

END;
