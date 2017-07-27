Import Data_Services, doxie_files, doxie,ut;

KeyName 			:= 'thor_data400::key::sanctn::';

//include standard type description and license number. Standard type description are different for various NMLS licenses.
layout_SANCTN_nmls_id_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING20 		NMLS_ID;
	//STRING50 		NMLS_ID_TYPE;
	STRING26 		MIDEX_RPT_NBR;
END;

f_sanctn_license := SANCTN.file_base_license(CLN_LICENSE_NUMBER<>'');

//Populate Midex and NMLS_ID fields
layout_SANCTN_nmls_id_key populateMidex(SANCTN.layout_SANCTN_license_clean l) := transform
  self.MIDEX_RPT_NBR := TRIM(L.BATCH_NUMBER,LEFT,RIGHT) + '-' +
	              ut.rmv_ld_zeros(L.INCIDENT_NUMBER) + '-' +
								ut.rmv_ld_zeros(L.PARTY_NUMBER);
	SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
	//Blank out the license state if it is NMLS
	SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
	//SELF.NMLS_ID_TYPE := 'NMLS ID';
	SELF := L;
	SELF := [];
END;

f_sanctn_nmls_id := project(f_sanctn_license(REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), 
                            populateMidex(LEFT));

export key_nmls_id := index(f_sanctn_nmls_id
													 ,{NMLS_ID}
													 ,{f_sanctn_nmls_id}
													 ,Data_Services.Data_location.Prefix('sanctn')+KeyName+'nmls_id_'+doxie.Version_SuperKey);
