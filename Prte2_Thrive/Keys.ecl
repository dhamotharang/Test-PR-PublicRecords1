IMPORT doxie, tools, ut, PRTE2_Thrive, Data_Services;

EXPORT Keys := module
   
    EXPORT Thrive_did_key := INDEX(files.Thrive_DID (DID != 0), {DID}, {files.Thrive_DID},
                                   Data_Services.Data_location.Prefix('DEFAULT') + constants.key_prefix + doxie.Version_SuperKey + '::DID');
         
  
    ut.MAC_CLEAR_FIELDS(files.Thrive_did (did != 0), did_fcra,  constants.fields_to_clear);
    EXPORT Thrive_fcra_did_key := INDEX(did_fcra, {DID}, {did_fcra}, Data_Services.Data_location.Prefix('DEFAULT') + constants.fcra_key_prefix + doxie.Version_SuperKey + '::DID');
                                    
  
  
  end;