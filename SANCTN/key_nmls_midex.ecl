Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices;

KeyName 			:= 'thor_data400::key::sanctn::';

//filter out records that have blank clean license number
//f_sanctn_license := SANCTN.file_base_license(license_number != '');
f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');

layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING26 		midex_rpt_nbr;
	STRING20 		NMLS_ID;
	//STRING50 		NMLS_ID_TYPE;

END;

layout_SANCTN_license_key			tNMLSLicenseMidex(f_sanctn_license L) := transform

		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
		SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
		//Blank out the license state if it is NMLS
		SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
		//SELF.NMLS_ID_TYPE := 'NMLS ID';
		SELF := L;
		SELF := [];

END;

f_sanctn_license_new := project(f_sanctn_license(REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)),
                                tNMLSLicenseMidex(LEFT));

EXPORT key_nmls_midex  := index(f_sanctn_license_new
                                ,{midex_rpt_nbr}
																,{f_sanctn_license_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'nmls_midex_'+doxie.Version_SuperKey);
