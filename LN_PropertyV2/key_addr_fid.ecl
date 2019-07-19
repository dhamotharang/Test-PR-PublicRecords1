Import Data_Services, doxie, ln_property, ut, fcra, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_addr_fid(boolean IsFCRA = false) := vault.LN_PropertyV2.key_addr_fid(isFCRA);

#ELSE

export key_addr_fid(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := ln_propertyv2.key_addr_fid_prep(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA, file_in(ln_fares_id[1] != 'R'), file_in);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::addr_search.fid';
									
return_file		:= INDEX(base_file,{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,string1 source_code_2 := source_code[2],LN_owner,owner,nofares_owner, string1 source_code_1 := source_code[1]},
											{ln_fares_id, lname, fname, name_suffix},key_name);
													
return(return_file); 		

END;																	
		
#END;
