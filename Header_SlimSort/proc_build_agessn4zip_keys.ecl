import ut;

pre := if (fileservices.getsuperfilesubcount('~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4_BUILDING') > 0,
		output('Nothing added to NAZS4 BUILDING superfile.'),
		fileservices.addsuperfile('~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4_BUILDING','~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4',0,true));

ut.MAC_SK_BuildProcess(key_prep_nazs4_age,'~thor_data400::key::key_nazs4_age_','~thor_data400::key::key_nazs4_age',age,2)
ut.MAC_SK_BuildProcess(key_prep_nazs4_ssn4,'~thor_data400::key::key_nazs4_ssn4_','~thor_data400::key::key_nazs4_ssn4',ssn4,2)
ut.MAC_SK_BuildProcess(key_prep_nazs4_zip,'~thor_data400::key::key_nazs4_zip_','~thor_data400::key::key_nazs4_zip',zip,2)

post := sequential(
		fileservices.clearsuperfile('~thor_data400::base::hss_name_zip_age_ssn4_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::hss_name_zip_age_ssn4_BUILT','~thor_Data400::base::hss_name_zip_age_ssn4_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_data400::base::hss_name_zip_age_ssn4_BUILDING')
	);
		


export proc_build_agessn4zip_keys := if (fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_zip_age_SSN4',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_zip_age_ssn4_BUILT',1),
		output('NAZS4 Base = BUILT.  Nothing done.'),
		sequential(pre,age,ssn4,zip,post));
		