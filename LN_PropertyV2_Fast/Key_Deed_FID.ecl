Import Data_Services, census_data,ln_property,doxie, ut,fcra, LN_PropertyV2;


export Key_Deed_FID(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

file_in0	:= LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2.File_Deed,false);
file_in1	:= LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2_Fast.Files.base.deed_mortg,true);

file_in2	:= if(isFast,file_in1,file_in0);

file_in := file_in2(trim(ln_fares_id) != '');

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
LN_PropertyV2_Fast.FCRA_compliance_MAC(IsFCRA,file_in,file_out);

// DF-21968 Blank out following fields in thor_data400::key::ln_propertyv2::fcra::qa::deed.fid 
ut.MAC_CLEAR_FIELDS(file_out, file_out_cleared, LN_PropertyV2_Fast.Constants.field_to_clear_deed_fid);

base_file := if(IsFCRA,file_out_cleared,file_out);

//base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);


key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::deed.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id, unsigned6 proc_date := (unsigned)(recording_date[1..6])},
												{base_file},key_name);
													
return(return_file);		

END;				  




