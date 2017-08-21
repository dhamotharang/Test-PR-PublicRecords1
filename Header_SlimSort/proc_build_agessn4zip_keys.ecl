import ut,RoxieKeyBuild;

export proc_build_agessn4zip_keys(string filedate) := function

pre := if (fileservices.getsuperfilesubcount('~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4_BUILDING') > 0,
		output('Nothing added to NAZS4 BUILDING superfile.'),
		fileservices.addsuperfile('~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4_BUILDING','~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4',0,true));

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_nazs4_age,'~thor_data400::key::key_nazs4_age_','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_age',age);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_nazs4_ssn4,'~thor_data400::key::key_nazs4_ssn4_','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_ssn4',ssn4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_nazs4_zip,'~thor_data400::key::key_nazs4_zip_','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_zip',zip);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::key_nazs4_age','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_age',mv_age);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::key_nazs4_ssn4','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_ssn4',mv_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::key_nazs4_zip','~thor_data400::key::header_slimsort::'+filedate+'::nazs4_zip',mv_zip);

post := sequential(
		fileservices.clearsuperfile('~thor_data400::base::hss_name_zip_age_ssn4_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::hss_name_zip_age_ssn4_BUILT','~thor_Data400::base::hss_name_zip_age_ssn4_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_data400::base::hss_name_zip_age_ssn4_BUILDING')
	);
		


return if (fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_zip_age_SSN4',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_zip_age_ssn4_BUILT',1),
		output('NAZS4 Base = BUILT.  Nothing done.'),
		sequential(pre,parallel(age,ssn4,zip),parallel(mv_age,mv_ssn,mv_zip),post));
end;
		