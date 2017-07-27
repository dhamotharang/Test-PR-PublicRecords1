/*
	property ownership keys
*/

Import Data_Services, doxie,ut;

// prefix := ut.foreign_prod+'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey;
prefix 				:= 'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey;
KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

export key_ownership := module

	f := LN_PropertyV2.mod_ownership.file_fipsAPN;
	fn := Data_services.Data_location.Prefix('Property') + prefix + '::ownership_fipsAPN';
	export fipsAPN := index(f, {fips_code, unformatted_apn}, {f}, fn);

	f := LN_PropertyV2.mod_ownership.file_rawaid;
	fn := Data_services.Data_location.Prefix('Property') + prefix + '::ownership_rawaid';
	export rawaid := index(f, {rawaid}, {f}, fn);

	export addr(boolean IsFCRA = false) := function
	f := LN_PropertyV2.mod_ownership.file_addr;
	fn := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::ownership_addr';
	return_file		:= index(f, {prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5}, {f}, fn);
  return(return_file);		
	END;				 
	
	export did(boolean IsFCRA = false) := function
	f := LN_PropertyV2.mod_ownership.file_did;
	fn := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::ownership_did';
	return_file		:= index(f, {did, current}, {f}, fn);
  return(return_file);		
	END;				 

	f := LN_PropertyV2.mod_ownership.file_bdid;
	fn := Data_services.Data_location.Prefix('Property') + prefix + '::ownership_bdid';
	export bdid := index(f, {bdid, current}, {f}, fn);

end;

	   