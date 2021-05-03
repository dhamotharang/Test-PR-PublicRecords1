Import Data_Services, doxie, ln_property, ut, fcra, LN_PropertyV2;

export key_addl_legal_fid(boolean IsFCRA = false, boolean isFast = false) := function

keyPreFix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPreFix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPreFix+'::fcra::';

file_in0 	:= LN_PropertyV2.File_addl_legal(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);
file_in1 	:= LN_PropertyV2_Fast.Files.basedelta.addl_legal(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

file_in		:= if(isFast,file_in1, file_in0);

//base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);
LN_PropertyV2_Fast.FCRA_compliance_MAC(IsFCRA,file_in,file_out);
base_file := file_out;

key_name := Constants.keyServerPointer + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::addllegal.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id},{base_file},key_name);
													
return(return_file); 		

END;				   
																		

