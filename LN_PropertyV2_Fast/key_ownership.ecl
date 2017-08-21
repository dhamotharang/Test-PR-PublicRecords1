/*
	property ownership keys
*/

Import Data_Services, doxie,ut, LN_PropertyV2_Fast;

keyPrefix := LN_PropertyV2_Fast.FileNames.fullKeyBuildPrefix;

// prefix := ut.foreign_prod+'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey;
prefix 				:= 'thor_data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey;
KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

export key_ownership(boolean isFast) := module

	f := LN_PropertyV2_Fast.mod_ownership(isFast).file_fipsAPN;
	fn := Constants.keyServerPointer + prefix + '::ownership_fipsAPN';
	export fipsAPN := index(f, {fips_code, unformatted_apn}, {f}, fn);

	f := LN_PropertyV2_Fast.mod_ownership(isFast).file_rawaid;
	fn := Constants.keyServerPointer+ prefix + '::ownership_rawaid';
	export rawaid := index(f, {rawaid}, {f}, fn);

	export addr(boolean IsFCRA = false) := function
	f := LN_PropertyV2_Fast.mod_ownership(isFast).file_addr;
	fn := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::ownership_addr';
	return_file		:= index(f, {prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5}, {f}, fn);
  return(return_file);		
	END;				 
	
	export did(boolean IsFCRA = false) := function
	f := LN_PropertyV2_Fast.mod_ownership(isFast).file_did;
	fn := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::ownership_did';
	return_file		:= index(f, {did, current}, {f}, fn);
  return(return_file);		
	END;				 

	f := LN_PropertyV2_Fast.mod_ownership(isFast).file_bdid;
	fn := Constants.keyServerPointer + prefix + '::ownership_bdid';
	export bdid := index(f, {bdid, current}, {f}, fn);

end;