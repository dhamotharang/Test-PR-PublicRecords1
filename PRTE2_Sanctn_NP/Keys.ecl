// import	_control, PRTE_CSV, prte2_sanctn_np
import doxie_files, doxie,ut,Data_Services, prte2_sanctn_np, _control, PRTE_CSV, std;

EXPORT Keys := module
// BDID KEY
	slim_bdid := record
		files.sample_party.BDID;
		files.sample_party.BATCH;
		files.sample_party.INCIDENT_NUM;
		files.sample_party.PARTY_NUM;
	end;
tbl_bdid 			:= table(files.sample_party(BDID != 0),slim_bdid,BDID,BATCH,INCIDENT_NUM,PARTY_NUM,few);	
export bdid 	:= index(tbl_bdid, {bdid}, {tbl_bdid}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::bdid');
																																			
// DID KEY																																			
	slim_did := record
		files.sample_party.DID;	
		files.sample_party.BATCH;
		files.sample_party.INCIDENT_NUM;
		files.sample_party.PARTY_NUM;
	end;
tbl_did 		:= table(files.sample_party(did != 0),slim_did,DID,BATCH,INCIDENT_NUM,PARTY_NUM,few);																																			
export did 	:= index(tbl_did, {did}, {tbl_did}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::did');
																																			
// INCIDENT KEY
dsIncident 				:= project(files.sample_incident,transform(layouts.Incident_Base,self:=left));
dsIncident_dedup  := DEDUP(dsIncident,RECORD);	
export incident 	:= index(dsIncident_dedup, {INCIDENT_NUM}, {dsIncident_dedup}, 
													 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incident');

// INCIDENTCODE KEY
dsIncidentCd 					:= project(files.sample_incidentcode,transform(layouts.IncidentCode_Base,self:=left));																																				
export incidentcode 	:= index(dsIncidentCd , {INCIDENT_NUM}, {dsIncidentCd }, 
															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incidentcode');
																																				
// INCIDENT TEXT KEY
dsIncidentText 				:= project(files.sample_incidenttext,transform(layouts.IncidentText_Key,self:=left));
export incidenttext 	:= index(dsIncidentText, {INCIDENT_NUM}, {dsIncidentText}, 
															Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incidenttext');
				
// LICENSE NUMBER KEY				
layouts.License_Key 	xformStateCD(files.sample_incidentcode L)  := TRANSFORM
		self.PARTY_NUM					:= L.NUMBER;
		self.LICENSE_NBR				:= trim(L.CODE_VALUE);
		filterInvalidChar 			:= STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE			:= if(L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.LICENSE_TYPE				:= if(L.STD_TYPE_DESC != '', ut.CleanSpacesAndUpper(L.STD_TYPE_DESC),L.CODE_TYPE);
		self.CLN_LICENSE_NUMBER	:= L.CLN_LICENSE_NUMBER;
		self := L;
END;          

dsLicenseNbr := project(files.sample_incidentcode(trim(FIELD_NAME) = 'LICENSECODE' AND CLN_LICENSE_NUMBER<>'' and (NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE))),xformStateCD(left));	
dsLicenseNbr_dedup := dedup(dsLicenseNbr,RECORD);
dsLicenseNbr_filter := dsLicenseNbr_dedup(CLN_LICENSE_NUMBER != '');
export license_nbr 	:= index(dsLicenseNbr_filter, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {dsLicenseNbr_filter}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::license_nbr');
																																			
// LICENSE MIDEX KEY
layouts.License_Midex_Key 	xformCODES(files.sample_incidentcode L)  := TRANSFORM
		self.BATCH								:= L.BATCH;
		self.DBCODE								:= L.DBCODE;
		self.INCIDENT_NUM				  := L.INCIDENT_NUM;
		self.PARTY_NUM						:= L.NUMBER;
		self.FIELD_NAME						:= L.FIELD_NAME;  	// LICENSECODE OR PROFESSIONCODE
		self.LICENSE_TYPE					:= L.CODE_TYPE;
		self.CODE_VALUE						:= L.CODE_VALUE;
		
		filterInvalidChar := STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE				:= if(L.FIELD_NAME = 'LICENSECODE' AND L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.STD_TYPE_DESC				:= L.STD_TYPE_DESC;
		self.CLN_LICENSE_NUMBER		:= L.CLN_LICENSE_NUMBER;
		selF.OTHER_DESC						:= L.OTHER_DESC;
		
		tmp_incident_number := ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number := ut.rmv_ld_zeros(L.NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr := STD.Str.CleanSpaces(trim(L.BATCH)+'-'
																							+ tmp_incident_number +'-' 
																							+ cln_party_number);
		self := L;
END;          
	
dsLicenseNbr_midex 				:= project(files.sample_incidentcode(trim(FIELD_NAME) != 'INTERNALCODE' AND CLN_LICENSE_NUMBER <>'' and  (NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE))),xformCODES(left));	
dsLicenseNbr_midex_dedup 	:= dedup(dsLicenseNbr_midex,RECORD);
export license_midex 			:= index(dsLicenseNbr_midex_dedup, {midex_rpt_nbr}, {dsLicenseNbr_midex_dedup}, 
																	Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::license_midex');
																																			
// MIDEX RPT NUMBER KEY																																			
dsPartyMidex := project(files.sample_party,transform(layouts.Party_Midex_Key,
																											self.party_key := (string)left.party_key;
																											temp_party_nbr := if(trim(left.PARTY_NUM) = '000','0',left.PARTY_NUM); 
																											self.midex_rpt_nbr := std.str.CleanSpaces(trim(left.BATCH) + '-'
																																																+ trim(left.INCIDENT_NUM) + '-' 
																																																+ trim(temp_party_nbr));
																											self:=left));																																			
export midex_rpt_nbr 			  := index(dsPartyMidex, {midex_rpt_nbr}, {dsPartyMidex}, 
																		 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::midex_rpt_nbr');
																																			

// NMLS_ID KEY
layouts.NMLS_ID_key populateNMLSId(files.sample_incidentcode L)  := TRANSFORM
		SELF.NMLS_ID				  := L.CLN_LICENSE_NUMBER;
		self.PARTY_NUM			  := L.NUMBER;
		filterInvalidChar 	  := STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE		:= if(L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.LICENSE_TYPE			:= if(L.CODE_TYPE != '', L.CODE_TYPE, ut.CleanSpacesAndUpper(L.STD_TYPE_DESC));
		tmp_incident_number 	:= ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number 			:= ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number 			:= if(trim(tmp_party_number) = '0','',tmp_party_number);
	  self.MIDEX_RPT_NBR 		:= STD.Str.CleanSpaces(trim(L.BATCH)+'-' 
																								+ tmp_incident_number +'-' 
																								+ cln_party_number);
		self := L;
		SELF := [];
END;          
	

dsLicenseNMLS := project(files.sample_incidentcode(trim(FIELD_NAME) = 'LICENSECODE' AND CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS',CODE_TYPE,NOCASE)),populateNMLSId(left));	
dsLicenseNMLS_dedup := dedup(dsLicenseNMLS ,RECORD);
dsLicenseNMLS_filter := dsLicenseNMLS_dedup(NMLS_ID != '');
export nmls_id			 := index(dsLicenseNMLS_filter, {NMLS_ID}, {dsLicenseNMLS_filter}, 
															Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_id');
																																			

// NMLS MIDEX KEY
layouts.NMLS_MIDEX_Key 	xCODES(files.sample_incidentcode L)  := TRANSFORM
		self.BATCH					:= L.BATCH;
		self.DBCODE					:= L.DBCODE;
		self.INCIDENT_NUM		:= L.INCIDENT_NUM;
		self.PARTY_NUM			:= L.NUMBER;
		self.FIELD_NAME			:= L.FIELD_NAME;  	// LICENSECODE OR PROFESSIONCODE
		self.LICENSE_TYPE		:= L.CODE_TYPE;
		self.CODE_VALUE			:= L.CODE_VALUE;
		
		filterInvalidChar := std.str.filter(std.str.touppercase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE	:= if(L.FIELD_NAME = 'LICENSECODE' AND L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.STD_TYPE_DESC	:= L.STD_TYPE_DESC;
		self.NMLS_ID				:= L.CLN_LICENSE_NUMBER;
		selF.OTHER_DESC			:= L.OTHER_DESC;
		
		tmp_incident_number := ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
	  self.midex_rpt_nbr 	:= std.str.CleanSpaces(trim(L.BATCH)+'-' 
																							+ tmp_incident_number +'-' 
																							+ cln_party_number);
		SELF := L;
		SELF := [];
END;          
	
dsNMLS_MIDEX := project(files.sample_incidentcode(trim(FIELD_NAME) != 'INTERNALCODE' AND CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS',CODE_TYPE,NOCASE)),xCODES(left));	
dsNMLS_MIDEX_dedup := dedup(dsNMLS_MIDEX ,RECORD);
export nmls_midex  := index(dsNMLS_MIDEX_dedup, {MIDEX_RPT_NBR}, {dsNMLS_MIDEX_dedup}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_midex');

// PARTY KEY
dsParty := project(files.sample_party,transform(layouts.Party_Key,
																								self.BATCH 				:= trim(left.BATCH,left,right);
																								self.INCIDENT_NUM	:= trim(left.INCIDENT_NUM,left,right);
																								self.PARTY_NUM		:= trim(left.PARTY_NUM,left,right);
																								self:=left));
export party 	:= index(dsParty, {BATCH,INCIDENT_NUM,PARTY_NUM}, {dsParty}, 
											Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party');

// PARTYTEXT KEY																																			
export partytext := index(files.sample_partytext, {BATCH, INCIDENT_NUM, PARTY_NUM}, {files.sample_partytext}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::partytext');
																																			
// SSN4 KEY																																			
dsPartySSN := project(files.sample_party(SSN != ''),transform(layouts.SSN4_key,
																															self.ssn4 := LEFT.ssn[6..9];	
																															self      := LEFT;
																															self      :=[]
																															));
dsPartySSN_dedup := dedup(dsPartySSN,RECORD);
export ssn4 		 := index(dsPartySSN_dedup, {SSN4}, {dsPartySSN_dedup}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::ssn4');
																																			
// TIN KEY
dsPartyTIN 				:= project(files.sample_party(TIN != ''),transform(layouts.TIN_Key, self:=left));
dsPartyTIN_dedup 	:= dedup(dsPartyTIN,RECORD);
export tin 			  := index(dsPartyTIN_dedup, {TIN}, {dsPartyTIN_dedup}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::tin');

// PARTY AKA.DBA EKY																																			
party_aka_dba_new 		:= project(files.sample_party_aka_dba, TRANSFORM(layouts.PARTY_AKA_DBA_Key, SELF := LEFT));																																			
export party_aka_dba 	:= index(party_aka_dba_new, {BATCH,INCIDENT_NUM,PARTY_NUM}, {party_aka_dba_new}, 
															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_aka_dba');

// INCIDENT LINKID KEY
ds_linkid_incident				:= project(files.sample_incident, transform(layouts.rKeySanctn__key__sanctn__np__linkids_incident, self := left, self := []));
export linkids_incident 	:= index(ds_linkid_incident, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, 
																	{ds_linkid_incident}, 
																	Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incident_linkids');
																															
// PARTY LINKID KEY																															
dsPartyLinkid 				:= project(files.sample_party, transform(layouts.rKeySanctn__key__sanctn__np__linkids_party, self := left, self := []));																															
export linkids_party 	:= index(dsPartyLinkid , 
															{ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, 
															{dsPartyLinkid }, 
															Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_linkids');


end;