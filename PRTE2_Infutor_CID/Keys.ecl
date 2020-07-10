import doxie, ut, PRTE2_Infutor_CID, Data_services;

EXPORT Keys := MODULE
   
   export key_did := index(files.key_did, {did}, {files.key_did}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::did');
   export fcra_key_did := index(files.key_did, {did}, {files.key_did}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::did');
   
   export key_phone := index(files.key_phone, {Phone}, {files.key_phone}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::phone');
   export fcra_key_phone := index(files.key_phone, {Phone}, {files.key_phone}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::phone'); 
      
END;
