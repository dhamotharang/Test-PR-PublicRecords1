IMPORT Data_Services, doxie, Prte2, PRTE2_Targus, Targus;

EXPORT Keys := MODULE

export AddressKey := index(files.Targus_AddressKey,
                          {prim_name, zip, prim_range, sec_range, predir, suffix}, {files.Targus_AddressKey},
                           Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + 
                           doxie.Version_SuperKey + '::address');

export DIDKey := index(files.Targus_DIDKey,
                      {did}, {files.Targus_DIDKey},
                       Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + 
                       doxie.Version_SuperKey + '::did');                       
                       
export PhoneKey := index(files.Targus_PhoneKey,
                        {p7,p3,st},{files.Targus_PhoneKey}, 
                         Data_Services.Data_location.Prefix('DEFAULT') + constants.key_prefix + 
                         doxie.Version_SuperKey + '::p7.p3.st');
  
END;  