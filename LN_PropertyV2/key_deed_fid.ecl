Import Data_Services, census_data,ln_property,doxie, ut,fcra;


export Key_Deed_FID(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := LN_PropertyV2.file_deed_building(trim(ln_fares_id) != '');

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);
srtBase 	:= SORT(base_file,ln_fares_id);

/*Future use
//Adding Black Knight additional borrower/lender name information fields
file_in2		:= LN_PropertyV2.File_addl_name_info;
srtAddlFile := SORT(file_in2,ln_fares_id);

//Join to the deed file
jFileIn := JOIN(srtBase, srtAddlFile,
								TRIM(LEFT.ln_fares_id) = TRIM(RIGHT.ln_fares_id),
								TRANSFORM(LN_PropertyV2.layout_key_deed_fid_new, SELF := LEFT; SELF := RIGHT),
								LEFT OUTER);
*/

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::deed.fid';
									
return_file		:= INDEX(srtBase,{ln_fares_id, unsigned6 proc_date := (unsigned)(recording_date[1..6])},
												{srtBase},key_name);
													
return(return_file);		

END;				  




