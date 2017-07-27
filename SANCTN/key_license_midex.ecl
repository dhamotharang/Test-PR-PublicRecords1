Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices;

//Filter out records with blank cln_license_number
//f_sanctn_license := SANCTN.file_base_license(license_number != '');
f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');

KeyName 			:= 'thor_data400::key::sanctn::';

layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
	string26 midex_rpt_nbr;
END;

layout_SANCTN_license_key			tLicenseMidex(f_sanctn_license L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																													+ tmp_incident_number +'-' 
																													+ cln_party_number);
		SELF := L;
END;

//include non-NMLS records only
f_sanctn_license_new := project(f_sanctn_license(NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)),
                                tLicenseMidex(LEFT));



EXPORT key_license_midex  := index(f_sanctn_license_new
                                ,{midex_rpt_nbr}
																,{f_sanctn_license_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'license_midex_'+doxie.Version_SuperKey);


