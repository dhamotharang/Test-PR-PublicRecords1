import doxie, ut, PRTE2_ConsumerStatement, Data_services;

EXPORT Keys := MODULE
   
   //Non_FCRA Keys
   export key_address := index(files.address, {st, p_city_name, v_city_name, zip, prim_range, prim_name, sec_range}, {files.address}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::address');
   export key_phone := index(files.phone, {phone}, {files.phone}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::phone');
   export key_StatementID := index(files.StatementID, {statement_id}, {files.StatementID}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::Statement_ID');
   
   //FCRA Keys
   export key_LexID := index(files.LexID,{lexid}, {files.Lexid}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::LexID');
   export key_SSN := index(files.SSN, {SSN}, {files.SSN}, Constants.FCRA_KEY_PREFIX + doxie.Version_SuperKey + '::SSN');
   
   
END;