Import Data_Services, doxie, ut, mdr, standard, PRTE2_Email_Data, autokey, AutoKeyB2;

EXPORT Keys  := MODULE

export key_did(boolean IsFCRA = false) := function
ut.MAC_CLEAR_FIELDS(Files.FCRA_Email_did,FCRA_Email_did_cleared, 'orig_ip');
dsFile := if(isFCRA, FCRA_Email_did_cleared,  Files.File_Key);
	return index(dsFile(did > 0), {did}, {dsFile}, Data_services.Data_location.Prefix('email_data') + if(isFCRA, Constants.key_prefix_fcra, constants.key_prefix) + doxie.Version_SuperKey + '::did');
end;	

dedp_emailAddr := dedup(sort(distribute(Files.File_Key(clean_email <> ''), hash(did)) ,clean_email,did, if(clean_name.lname <> '' and clean_address.prim_range <> '', 1, if(clean_name.lname <>  '',  2, 3)), -date_last_seen, local),clean_email,did,local);
EXPORT key_email_address := index(dedp_emailAddr,{clean_email},{dedp_emailAddr}	,Data_Services.Data_location.Prefix('email_data')+ Constants.key_prefix + doxie.Version_SuperKey+'::email_addresses');


//CREATE AUTOKEYS
/* Base file, which is a slimmed down version of the final layout */
export autokeys(string filedate):= function
		
		AutoKeyB2.MAC_Build (Files.File_AutoKey,clean_name.fname,clean_name.mname,clean_name.lname,
												 best_ssn,
												 best_dob,
												 zero,
												 clean_address.prim_name,
												 clean_address.prim_range,
												 clean_address.st,
												 clean_address.p_city_name,
											   clean_address.zip,
												 clean_address.sec_range,
												 zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,
												 DID,
												 blank,
												 zero,
												 zero,
												 blank,blank,blank,blank,blank,blank,
												 zero,
												 Constants.ak_keyname,
												 Constants.ak_logical(filedate),
												 bld_auto_keys,false,
												 Constants.ak_skipSet,true,Constants.ak_typeStr,
												 true,,,zero); 

	return bld_auto_keys; 				
end;

/*
auto_payload := RECORD
unsigned6 fakeid;
recordof(Files.File_AutoKey);
END;

shared dsPayload := dataset([], auto_payload);
export Key_Payload := index(dsPayload,{fakeid}, {dsPayload},Data_Services.Data_location.Prefix('email_data')+ Constants.autokeyname + doxie.Version_SuperKey + '::payload');
*/

END;