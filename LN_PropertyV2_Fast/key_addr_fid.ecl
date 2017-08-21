Import Data_Services, doxie, ln_property, ut, fcra, LN_PropertyV2;

export key_addr_fid(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix := if(isFast, 'property_fast', 'ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

file_in0 	:= ln_propertyv2_Fast.key_addr_fid_prep(isFast);
file_in		:= file_in0(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
LN_PropertyV2_Fast.FCRA_compliance_MAC(IsFCRA,file_in,file_out);
base_file := file_out;
//file_in(ln_fares_id[1] != 'R'), file_in);

key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::addr_search.fid';
									
return_file		:= INDEX(base_file,{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,string1 source_code_2 := source_code[2],LN_owner,owner,nofares_owner, string1 source_code_1 := source_code[1]},
											{ln_fares_id, lname, fname, name_suffix},key_name);
													
return(return_file); 		

END;																	
													
