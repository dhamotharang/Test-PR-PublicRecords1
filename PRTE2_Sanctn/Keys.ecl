import doxie_files, doxie,ut,Data_Services, prte2_sanctn,std, sanctn, bipv2;

EXPORT Keys := module
	
// DID Key	
	export did	:= index(files.tbl_did(did != 0), {did}, {files.tbl_did}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::did'); 
	
//BDID Key	
	export bdid		:= index(files.tbl_bdid(bdid != 0), {bdid}, {files.tbl_bdid},
												 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::bdid'); 

//MIXES_RPT_NBR Key																							
	export midex_rpt_nbr := index(files.f_sanctn_party_new, {midex_rpt_nbr}, {files.f_sanctn_party_new},
																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::midex_rpt_nbr');

// CASENUM Key
	export casenum 	:= index(files.tbl_casenum(case_number <> ''), {CASE_NUMBER}, {files.tbl_casenum}, 
													 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::casenum');

//Incident Key
	export incident 	:= index(files.incident_new, {BATCH_NUMBER,INCIDENT_NUMBER}, {files.incident_new}, 
														 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::incident');
																																
//Incident_midex Key																																
	export incident_midex := index(files.f_sanctn_incident_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {files.f_sanctn_incident_new}, 
																																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::incident_midex');

// LiCENSE MIDEX key	
	export license_midex := index(files.f_sanctn_license_new, {midex_rpt_nbr}, {files.f_sanctn_license_new}, 
																															 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey + '::license_midex');


// License Key	
	export license_nbr 				:= index(files.f_license_new, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {files.f_license_new}, 
																		 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::license_nbr');


// NMLS KEU
	export nmls_id	 := index(files.f_sanctn_nmls_id, {nmls_id}, {files.f_sanctn_nmls_id}, 
														Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey +'::nmls_id');


//NMLS MIDEX Key
	export nmls_midex	:= index(files.f_nmls_midex_new, {midex_rpt_nbr}, {files.f_nmls_midex_new}, 
														 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::nmls_midex');
																					
// Party key																					
	export party 	:= index(files.f_party_new, {BATCH_NUMBER,INCIDENT_NUMBER}, {files.f_party_new}, 
												 Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party');

// Rebuttal Key	
	export rebuttal_text  := index(files.f_sanctn_rebuttal_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {files.f_sanctn_rebuttal_new}, 
																																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::rebuttal');
																																
// SSN4 Key	
	export ssn4 	:= index(files.dsParty(ssn4 <> ''), {SSN4}, {files.dsParty}, Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::ssn4');

	
// PARTY AKA.DBA Key  
	export party_aka_dba := index(files.f_sanctn_aka_dba_new, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {files.f_sanctn_aka_dba_new}, 
																Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::party_aka_dba');

//Linkid Key
EXPORT LinkIds := MODULE

	// DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('sanctn')+ constants.key_prefix + doxie.Version_SuperKey+'::linkids';
		
	Base := files.linkids_new;
	
		
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


end;																													
