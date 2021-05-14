Import Data_Services, census_data,ln_property,doxie, ut,fcra, LN_PropertyV2;


export Key_Deed_FID(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

file_in0	:= LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2.File_Deed,false);
file_in1	:= LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2_Fast.Files.basedelta.deed_mortg,true);

file_in2	:= if(isFast,file_in1,file_in0);

srtFile_in2	:= SORT(file_in2,ln_fares_id)(trim(ln_fares_id) != '');

/*Future Use
//Adding Black Knight additional borrower/lender name information fields
file_in3	:= LN_PropertyV2.File_addl_name_info;
file_in4	:= LN_PropertyV2_Fast.Files.base.addl_name_info;

file_in5	:= IF(isFast,file_in4,file_in3);

srtFile_in5	:= SORT(file_in5,ln_fares_id)(trim(ln_fares_id) != '');

//Join to the deed file
jFileIn := JOIN(srtFile_in2, srtFile_in5,
								TRIM(LEFT.ln_fares_id) = TRIM(RIGHT.ln_fares_id),
								TRANSFORM(LN_PropertyV2.layout_key_deed_fid_new, SELF := LEFT; SELF := RIGHT),
								LEFT OUTER);

file_in := jFileIn(trim(ln_fares_id) != '');
*/

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
LN_PropertyV2_Fast.FCRA_compliance_MAC(IsFCRA,srtFile_in2,file_out);

// DF-21968 Blank out following fields in thor_data400::key::ln_propertyv2::fcra::qa::deed.fid 
ut.MAC_CLEAR_FIELDS(file_out, file_out_cleared, LN_PropertyV2_Fast.Constants.field_to_clear_deed_fid);

base_file := if(IsFCRA,file_out_cleared,file_out);

//base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);


key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::deed.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id, unsigned6 proc_date := (unsigned)(recording_date[1..6])},
												{base_file},key_name);
													
return(return_file);		

END;				  




