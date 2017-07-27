import ut, header;
#workunit('name', 'Slimsorts');

//****** Build Base Files
ut.MAC_SF_BuildProcess(header_slimsort.name_dob_dayob,'~thor_data400::BASE::HSS_Name_Dayob',out_dayob,2)
ut.MAC_SF_BuildProcess(header_slimsort.name_ssn,'~thor_data400::BASE::HSS_Name_SSN',out_ssn,2)
ut.MAC_SF_BuildProcess(header_slimsort.name_address,'~thor_data400::BASE::HSS_Name_Address',out_addr,2)
ut.MAC_SF_BuildProcess(header_slimsort.name_phone,'~thor_data400::BASE::HSS_Name_phone',out_phone,2)
ut.MAC_SF_BuildProcess(header_slimsort.name_zip_age_ssn4,'~thor_data400::BASE::HSS_Name_Zip_Age_Ssn4',out_fuzzy,2)
out_did_ssn := header_slimsort.did_ssn;
ut.MAC_SF_BuildProcess(header_slimsort.hss_household,'~thor_data400::BASE::HSS_household',out_household,2)

base_files := parallel(
	out_dayob,
	out_ssn,
	out_addr,
	out_phone,
	out_Fuzzy,
	out_did_ssn,
	out_household
);


export Proc_Make_Name_xxx := base_files;