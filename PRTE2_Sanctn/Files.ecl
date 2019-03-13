import prte_csv, data_services, sanctn, ut, std, prte2_sanctn;

EXPORT Files := module

  export incident_in					:= dataset(constants.in_prefix_name + 'incident',	layouts.Incident_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export party_in							:= dataset(constants.in_prefix_name + 'party',	layouts.party_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export party_aka_dba_in			:= dataset(constants.in_prefix_name + 'party_aka_dba',	layouts.Party_AKA_DBA_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'))); 
	export license_in						:= dataset(constants.in_prefix_name + 'license',	layouts.license_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export rebuttal_in					:= dataset(constants.in_prefix_name + 'rebuttal',	layouts.rebuttal_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	export base_incident_ext				:= dataset(constants.base_prefix_name + 'incident', layouts.Incident_ext, thor);
	export base_party_ext						:= dataset(constants.base_prefix_name + 'party', layouts.party_ext, thor);
	export base_license_ext					:= dataset(constants.base_prefix_name + 'license', layouts.license_ext, thor);
	export base_party_aka_dba_ext		:= dataset(constants.base_prefix_name + 'party_aka_dba', layouts.party_aka_dba_ext,thor);
	export base_rebuttal_ext				:= dataset(constants.base_prefix_name + 'rebuttal', layouts.rebuttal_ext,thor);
	
	export base_incident				:= project(base_incident_ext, layouts.INCIDENT_base);
	export base_party						:= project(base_party_ext, layouts.party_base);
	export base_license					:= project(base_license_ext, layouts.LICENSE_base);
	export base_party_aka_dba		:= project(base_party_aka_dba_ext, layouts.party_aka_dba_base);
	export base_rebuttal				:= project(base_rebuttal_ext, layouts.rebuttal_base);

// Key Files	
	export tbl_did 		:= project(base_party,layouts.did_key);
	export tbl_bdid 	:= project(base_party,layouts.bdid_key);
	export linkids_new := project(base_party, transform(layouts.linkids_key, self := left, self := []));  																																																									

layouts.MIDEX_RPT_NBR_Key 	tSANCTN_key(base_party L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr 	:= std.str.CleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
		self               := L;
END;

	export f_sanctn_party_new := project(base_party, tSANCTN_key(LEFT));

//Casenum File	
SANCTN.layout_SANCTN_incident_clean tr(base_incident L) := transform
	self.CASE_NUMBER := std.str.ToUpperCase(L.CASE_NUMBER);
	self := L;
	self := [];
	end;

	f_sanctn 				:= project(base_incident(batch_number <> ''),tr(LEFT));
	 
	export tbl_casenum 		:= dedup(sort(project(f_sanctn,layouts.casenum_key), case_number, batch_number,incident_number), record, all) ;	
	export incident_new 	:= project(base_incident,layouts.Incident_Key);	
	export f_sanctn_incident_new := project(base_incident, layouts.incident_midex_key);		
	
	layouts.license_midex_key			tLicenseMidex(base_license L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr 	:= StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																													+ tmp_incident_number +'-' 
																													+ cln_party_number);
		SELF := L;
END;
	export f_sanctn_license_new := project(base_license(cln_license_number <> '' and (NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE))),  tLicenseMidex(LEFT));
	
	export f_license_new := project(base_license(cln_license_number <> '' and (NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),nocase))), 
                                TRANSFORM(layouts.License_Key, SELF := LEFT));

layouts.NMLS_ID_Key 	populateMidex(base_license l) := transform
  self.MIDEX_RPT_NBR := TRIM(L.BATCH_NUMBER,LEFT,RIGHT) + '-' +
													 	 ut.rmv_ld_zeros(L.INCIDENT_NUMBER) + '-' +
														 ut.rmv_ld_zeros(L.PARTY_NUMBER);
	SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
	SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
	SELF := L;
	SELF := [];
END;

	export f_sanctn_nmls_id := project(base_license(CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), populateMidex(LEFT));
	
	
	layouts.NMLS_MIDEX_KEY		tNMLSLicenseMidex(base_license L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr 	:= StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																											+ tmp_incident_number +'-' 
																											+ cln_party_number);
		SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
		SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
		SELF := L;
		SELF := [];

END;

	export f_nmls_midex_new 	:= project(base_license(CLN_LICENSE_NUMBER <> '' and REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), tNMLSLicenseMidex(LEFT));


SANCTN.layout_SANCTN_party_clean_orig tParty_key(base_party L) := transform
	 self.BATCH_NUMBER		:= trim(L.BATCH_NUMBER,left,right);
	 self.INCIDENT_NUMBER := trim(L.INCIDENT_NUMBER,left,right);
	 self.PARTY_NUMBER		:= trim(L.PARTY_NUMBER,left,right);
   self  := L;
	 self  := [];
end;

	export f_party_new   := project(base_party, tParty_key(LEFT));
  export f_sanctn_rebuttal_new := project(base_rebuttal, TRANSFORM(layouts.Rebuttal_Key, SELF := LEFT));

//ssn4 key
layouts.ssn4_key 	tSSN_key(base_party L) := transform
filterInvalidChar := std.str.filterout(std.str.Touppercase(L.ssn_appended),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-');
self.ssn4 := L.ssn_appended[6..9];
self      := L;
end;
	export dsParty 			:= project(base_party, tSSN_key(LEFT));

// party_aka_dba key	
	export f_sanctn_aka_dba_new := project(base_party_aka_dba, TRANSFORM(layouts.PARTY_AKA_DBA_Key , SELF := LEFT));	

end;																																			
	
	