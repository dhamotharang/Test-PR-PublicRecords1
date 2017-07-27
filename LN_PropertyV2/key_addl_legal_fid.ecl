Import Data_Services, doxie, ln_property, ut, fcra;

export key_addl_legal_fid(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := LN_PropertyV2.File_addl_legal(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::addllegal.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id},{base_file},key_name);
													
return(return_file); 		

END;				   
																		

