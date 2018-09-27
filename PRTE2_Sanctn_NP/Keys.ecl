import doxie_files, doxie,ut,Data_Services, prte2_sanctn_np, _control, PRTE_CSV, std, bipv2;

EXPORT Keys := module
// BDID KEY
export bdid 	:= index(files.tbl_bdid, {bdid}, {files.tbl_bdid}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::bdid');
																																			
// DID KEY																																			
export did 	:= index(files.tbl_did, {did}, {files.tbl_did}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::did');
																																			
// INCIDENT KEY
export incident 	:= index(files.dsIncident, {INCIDENT_NUM}, {files.dsIncident}, 
													 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incident');

// INCIDENTCODE KEY
export incidentcode 	:= index(files.dsIncidentCd , {INCIDENT_NUM}, {files.dsIncidentCd }, 
															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incidentcode');
																																				
// INCIDENT TEXT KEY
export incidenttext 	:= index(files.dsIncidentText, {INCIDENT_NUM}, {files.dsIncidentText}, 
															Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incidenttext');
				
// LICENSE NUMBER KEY				
export license_nbr 	:= index(files.dsLicenseNbr_filter, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {files.dsLicenseNbr_filter}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::license_nbr');
																																			
// LICENSE MIDEX KEY
export license_midex 			:= index(files.dsLicenseNbr_midex, {midex_rpt_nbr}, {files.dsLicenseNbr_midex}, 
																	Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::license_midex');
																																			
// MIDEX RPT NUMBER KEY																																			
export midex_rpt_nbr 			  := index(files.dsPartyMidex, {midex_rpt_nbr}, {files.dsPartyMidex}, 
																		 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::midex_rpt_nbr');
																																			

// NMLS_ID KEY
export nmls_id			 := index(files.dsLicenseNMLS_filter, {NMLS_ID}, {files.dsLicenseNMLS_filter}, 
															Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_id');
																																			

// NMLS MIDEX KEY
export nmls_midex  := index(files.dsNMLS_MIDEX, {MIDEX_RPT_NBR}, {files.dsNMLS_MIDEX}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_midex');

// PARTY KEY
export party 	:= index(files.dsParty, {BATCH,INCIDENT_NUM,PARTY_NUM}, {files.dsParty}, 
											Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party');

// PARTYTEXT KEY																																			
export partytext := index(files.dsPartyText, {BATCH, INCIDENT_NUM, PARTY_NUM}, {files.dsPartyText}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::partytext');
																																			
// SSN4 KEY																																			
export ssn4 		 := index(files.dsPartySSN, {SSN4}, {files.dsPartySSN}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::ssn4');
																																			
// TIN KEY
export tin 			  := index(files.dsPartyTIN, {TIN}, {files.dsPartyTIN}, 
													Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::tin');

// PARTY AKA.DBA EKY																																			
export party_aka_dba 	:= index(files.party_aka_dba_new, {BATCH,INCIDENT_NUM,PARTY_NUM}, {files.party_aka_dba_new}, 
															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_aka_dba');

// INCIDENT LINKID KEY
EXPORT incident_LinkIds := MODULE

	// DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::incident_linkids';
		
	Base := files.base_incident;
	
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;
																															
// PARTY LINKID KEY
EXPORT party_LinkIds := MODULE

	// DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_linkids';
		
	Base := files.base_party;
	
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;
																															
end;;