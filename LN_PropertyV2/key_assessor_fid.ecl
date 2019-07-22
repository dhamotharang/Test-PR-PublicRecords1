Import Data_Services, census_data, ln_property, doxie, ut, fcra;


export Key_Assessor_FID(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := LN_PropertyV2.file_assessment_building(trim(ln_fares_id) != '');

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA,file_in(ln_fares_id[1] !='R'),file_in);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::assessor.fid';
									
return_file		:= INDEX(base_file,
												 {ln_fares_id, unsigned6 proc_date := (unsigned)(IF(recording_date[1..6]!='',
												recording_date[1..6],sale_date[1..6]))},
												{base_file},key_name);
													
return(return_file);		

END;				   
