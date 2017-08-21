Import Data_Services, census_data, ln_property, doxie, ut, fcra, LN_PropertyV2;


export Key_Assessor_FID(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

file_in0	:= LN_PropertyV2_Fast.CleanAssessment(LN_PropertyV2.File_Assessment,false);
file_in1	:= LN_PropertyV2_Fast.CleanAssessment(LN_PropertyV2_Fast.Files.base.assessment,true);
file_in2	:= if(isFast,file_in1, file_in0);
file_in := file_in2(trim(ln_fares_id) != '');

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
LN_PropertyV2_Fast.FCRA_compliance_MAC(IsFCRA,file_in,file_out);
base_file := file_out;

key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::assessor.fid';
									
return_file		:= INDEX(base_file,
												 {ln_fares_id, unsigned6 proc_date := (unsigned)(IF(recording_date[1..6]!='',
												recording_date[1..6],sale_date[1..6]))},
												{base_file},key_name);
													
return(return_file);		

END;				   
