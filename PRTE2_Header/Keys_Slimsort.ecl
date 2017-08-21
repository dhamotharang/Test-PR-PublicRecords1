IMPORT  doxie,mdr,Header_SlimSort;

EXPORT keys_slimsort := MODULE

	EXPORT key_did_ssn_glb := INDEX(Header_SlimSort.key_prep_did_ssn, '~prte::key::did_ssn_glb_'+doxie.Version_SuperKey);
	EXPORT key_did_ssn_nonglb_nonutil := INDEX(Header_SlimSort.key_prep_did_ssn_Nonglb_NonUtil,'~prte::key::did_ssn_nonglb_nonutil_'+doxie.Version_SuperKey);
	EXPORT key_did_ssn_nonglb := INDEX(Header_SlimSort.key_prep_did_ssn_NonGLB, '~prte::key::did_ssn_nonglb_'+doxie.Version_SuperKey);
	EXPORT key_did_ssn_nonutil := INDEX(Header_SlimSort.key_prep_did_ssn_nonUtil, '~prte::key::did_ssn_nonutil_'+doxie.Version_SuperKey);
	EXPORT key_headerssn4_zip_yob_fi := INDEX(Header_SlimSort.key_ssn4_numerics,'~prte::key::header::ssn4_zip_yob_fi_'+doxie.Version_SuperKey);
	EXPORT key_hhid := INDEX(Header_SlimSort.Key_Household, '~prte::key::hhid_'+doxie.Version_SuperKey);

END;
