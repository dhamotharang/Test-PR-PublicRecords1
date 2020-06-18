import doxie, ut, PRTE2_Infutor_CID, Data_services;

EXPORT Keys := MODULE
   
   //DID and FCRA DID Keys
   export key_did(STRING FILEDATE) := FUNCTION;
          key_infutorcid_did := index(files.key_did(filedate), {did}, {files.key_did(filedate)}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::did');
   return key_infutorcid_did;
   end;

   export fcra_Key_did(STRING FILEDATE) := FUNCTION
          fcra_key_infutorcid_did := index(files.key_did(filedate), {did}, {files.key_did(filedate)}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::did');
   return fcra_key_infutorcid_did;
   end;   
   
   //Phone and FCRA Phone Keys
   export Key_Phone(STRING FILEDATE) := FUNCTION
          key_infutorcid_phone := index(files.key_phone(filedate), {Phone}, {files.key_phone(filedate)}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::phone');
   return Key_infutorcid_phone;
   end;
   
   export fcra_Key_Phone(STRING FILEDATE) := FUNCTION   
          fcra_key_infutorcid_phone := index(files.key_phone(filedate), {Phone}, {files.key_phone(filedate)}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::phone');
   return fcra_Key_infutorcid_phone;
   end;
   
END;
