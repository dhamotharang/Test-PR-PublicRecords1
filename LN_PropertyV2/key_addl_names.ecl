Import Data_Services, doxie, ln_property, ut,fcra;

export key_addl_names(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := ln_propertyv2.file_ln_deed_addlnames(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

// filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::addlnames.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id},{base_file},key_name);
													
return(return_file);		

END;				 
