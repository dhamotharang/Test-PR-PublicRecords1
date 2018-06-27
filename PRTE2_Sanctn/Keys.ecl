import doxie_files, doxie,ut,Data_Services, prte2_sanctn,std, sanctn;

EXPORT Keys := module
	
	slim_did := record
		files.sample_party.DID;
		files.sample_party.BATCH_NUMBER;
		files.sample_party.INCIDENT_NUMBER;
		files.sample_party.PARTY_NUMBER;
	end;
	
	tbl_did 		:= table(files.sample_party,slim_did,DID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);
	export did	:= index(tbl_did(did != 0), {did}, {tbl_did}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::did'); 
	
	
	slim_sanctn := record
	files.sample_party.BDID;
	files.sample_party.BATCH_NUMBER;
	files.sample_party.INCIDENT_NUMBER;
	files.sample_party.PARTY_NUMBER;
	end;
	
	tbl_bdid 			:= table(files.sample_party,slim_sanctn ,BDID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);
	export bdid		:= index(tbl_bdid(bdid != 0), {bdid}, {tbl_bdid},
												 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::bdid'); 
																							
																							
  linkids_new := project(files.sample_party, transform(layouts.rKeySanctn__key__sanctn__linkids, self := left, self := []));  																							
	export linkids := index(linkids_new, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {linkids_new}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::linkids'); 
	


	layouts.Party_Midex_Key 	tSANCTN_key(files.sample_party L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr 	:= std.str.CleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
	  self               := L;
END;

	f_sanctn_party_new := project(files.sample_party, tSANCTN_key(LEFT));
	export midex_rpt_nbr := index(f_sanctn_party_new, {midex_rpt_nbr}, {f_sanctn_party_new},
																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::midex_rpt_nbr');


	SANCTN.layout_SANCTN_incident_clean tr(files.sample_incident L) := transform
	self.CASE_NUMBER := std.str.ToUpperCase(L.CASE_NUMBER);
	self := L;
	end;

	f_sanctn 				:= project(files.sample_incident,tr(LEFT));
	 
	slim_casenum := record
   f_sanctn.CASE_NUMBER;
   f_sanctn.BATCH_NUMBER;
   f_sanctn.INCIDENT_NUMBER;
	end;
	
	tbl_casenum 		:= table(f_sanctn,slim_casenum,CASE_NUMBER,BATCH_NUMBER,INCIDENT_NUMBER,few);
	export casenum 	:= index(tbl_casenum, {CASE_NUMBER}, {tbl_casenum}, 
													 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::casenum');


	incident_new 			:= project(files.sample_incident,layouts.Incident_Key);																															
	export incident 	:= index(incident_new, {BATCH_NUMBER,INCIDENT_NUMBER}, {incident_new}, 
														 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::incident');
																																
																																
	f_sanctn_incident_new := project(files.sample_incident, layouts.incident_midex_key);
	export incident_midex := index(f_sanctn_incident_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {f_sanctn_incident_new}, 
																																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::incident_midex');


	layouts.license_midex_key			tLicenseMidex(files.sample_license L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr 	:= StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																													+ tmp_incident_number +'-' 
																													+ cln_party_number);
		SELF := L;
END;
	f_sanctn_license_new := project(files.sample_license(cln_license_number <> '' and (NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE))),  tLicenseMidex(LEFT));
	export license_midex := index(f_sanctn_license_new, {midex_rpt_nbr}, {f_sanctn_license_new}, 
																															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey + '::license_midex');


	f_license_new := project(files.sample_license(cln_license_number <> '' and (NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),nocase))), 
                                TRANSFORM(layouts.License_Key, SELF := LEFT));
	export license_nbr 				:= index(f_license_new, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {f_license_new}, 
																		 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::license_nbr');



layouts.NMLS_ID_Key 	populateMidex(files.sample_license l) := transform
  self.MIDEX_RPT_NBR := TRIM(L.BATCH_NUMBER,LEFT,RIGHT) + '-' +
													 	 ut.rmv_ld_zeros(L.INCIDENT_NUMBER) + '-' +
														 ut.rmv_ld_zeros(L.PARTY_NUMBER);
	SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
	SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
	SELF := L;
	SELF := [];
END;

	f_sanctn_nmls_id := project(files.sample_license(CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), populateMidex(LEFT));
	export nmls_id	 := index(f_sanctn_nmls_id, {nmls_id}, {f_sanctn_nmls_id}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::nmls_id');



layouts.NMLS_MIDEX_KEY		tNMLSLicenseMidex(files.sample_license L) := transform
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

	f_nmls_midex_new 	:= project(files.sample_license(CLN_LICENSE_NUMBER <> '' and REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), tNMLSLicenseMidex(LEFT));
	export nmls_midex	:= index(f_nmls_midex_new, {midex_rpt_nbr}, {f_nmls_midex_new}, 
														 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_midex');
																					
																					
SANCTN.layout_SANCTN_party_clean_orig tParty_key(files.sample_party L) := transform
	 self.BATCH_NUMBER		:= trim(L.BATCH_NUMBER,left,right);
	 self.INCIDENT_NUMBER := trim(L.INCIDENT_NUMBER,left,right);
	 self.PARTY_NUMBER		:= trim(L.PARTY_NUMBER,left,right);
   self            := L;
end;

	f_party_new   := project(files.sample_party, tParty_key(LEFT));
	export party 	:= index(f_party_new, {BATCH_NUMBER,INCIDENT_NUMBER}, {f_party_new}, 
												 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party');


	f_sanctn_rebuttal_new := project(files.sample_rebuttal(party_text <> ''), TRANSFORM(layouts.Rebuttal_Key, SELF := LEFT));
	export rebuttal_text  := index(f_sanctn_rebuttal_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {f_sanctn_rebuttal_new}, 
																																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::rebuttal');
																																
	
layouts.rKeySanctn__key__sanctn__ssn4 	tSSN_key(files.sample_party L) := transform
filterInvalidChar := std.str.filterout(std.str.Touppercase(L.ssn_appended),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-');
self.ssn4 := L.ssn_appended[6..9];
self               := L;
end;
	dsParty 			:= project(files.sample_party, tSSN_key(LEFT));
	export ssn4 	:= index(dsParty, {SSN4}, {dsParty}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::ssn4');

	
  f_sanctn_aka_dba_new := project(files.sample_party_aka_dba, TRANSFORM(layouts.AKA_DBA_Key, SELF := LEFT));	
	export party_aka_dba := index(f_sanctn_aka_dba_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {f_sanctn_aka_dba_new}, 
																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_aka_dba');



end;																													
