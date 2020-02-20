IMPORT doxie, tools, ut, PRTE2_Thrive, Data_Services;

EXPORT Keys := module
   
     EXPORT Thrive_did_key := INDEX(files.Thrive_DID (DID != 0), {DID}, {files.Thrive_DID},
                                    Data_Services.Data_location.Prefix('DEFAULT') + constants.key_prefix + doxie.Version_SuperKey + '::DID');
         
  end;