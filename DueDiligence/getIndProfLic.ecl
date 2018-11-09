IMPORT BIPv2, prof_licenseV2, risk_indicators, Prof_License_Mari, STD;

/*
	Following Keys being used:
			Prof_licenseV2.Key_Proflic_Did
			Prof_License_Mari.key_did
*/

EXPORT getIndProfLic(DATASET(DueDiligence.LayoutsInternal.RelatedParty) indiv,
											BOOLEAN includeReportData) := FUNCTION


	licenseRaw := JOIN(indiv, prof_licenseV2.Key_Proflic_Did(),
											TRIM(RIGHT.prolic_key)!= DueDiligence.Constants.EMPTY AND
											KEYED(RIGHT.did = LEFT.party.did),
											TRANSFORM({UNSIGNED4 uniqueID, DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																	SELF := LEFT;
																	SELF := RIGHT;
																	SELF := [];),
											ATMOST(RIGHT.did = LEFT.party.did, DueDiligence.Constants.MAX_ATMOST_1000));
											
	// Filter out records after our history date.
	licenseFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(licenseRaw, date_first_seen);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_dateLastSeen := DueDiligence.Common.CleanDateFields(licenseFiltRecs, date_last_seen);
	clean_expirationDate := DueDiligence.Common.CleanDateFields(clean_dateLastSeen, expiration_date);
	clean_issueDate := DueDiligence.Common.CleanDateFields(clean_expirationDate, issue_date);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	licenseFilt := clean_issueDate;

	projectLicense := PROJECT(licenseFilt, TRANSFORM(DueDiligence.LayoutsInternal.PartyLicences,
																										
																										professionCat := TRIM(LEFT.profession_or_board, LEFT, RIGHT);
																										licenseType := TRIM(LEFT.license_type, LEFT, RIGHT);
																										
																										category := MAP(professionCat IN DueDiligence.Constants.PROF_LIC_COMBO_CATEGORY_FINANCE_OR_REAL_ESTATE AND
																																					licenseType IN DueDiligence.Constants.PROF_LIC_COMBO_TYPE_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																		professionCat IN DueDiligence.Constants.PROF_LIC_COMBO_CATEGORY_MEDICAL AND
																																					licenseType IN DueDiligence.Constants.PROF_LIC_COMBO_TYPE_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																		professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_LAW_OR_ACCOUNTING => DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING,
																																		professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																		professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																		professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_BLAST_PILOT => DueDiligence.Constants.PROF_LIC_BLAST_PILOT,
																																		professionCat = DueDiligence.Constants.EMPTY => MAP(licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_LAW_OR_ACCOUNTING => DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING,
																																																												licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																																												licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																																												licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_BLAST_PILOT => DueDiligence.Constants.PROF_LIC_BLAST_PILOT,
																																																												DueDiligence.Constants.PROF_LIC_OTHER),
																																		DueDiligence.Constants.PROF_LIC_OTHER);
																																		
																										histDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
																										
																										current := MAP(LEFT.expiration_date = 0 => TRUE,
																																		histDate <= LEFT.expiration_date => TRUE,
																																		FALSE);
																										
																										SELF.license.licenseType := licenseType;
																										SELF.license.licenseCategory := professionCat;
																										SELF.license.status := LEFT.status;
																										SELF.license.lawAcct := category = DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING;
																										SELF.license.realEstate := category = DueDiligence.Constants.PROF_LIC_REAL_ESTATE;
																										SELF.license.medical := category = DueDiligence.Constants.PROF_LIC_MEDICAL;
																										SELF.license.blastPilot := category = DueDiligence.Constants.PROF_LIC_BLAST_PILOT;
																										SELF.license.other := category = DueDiligence.Constants.PROF_LIC_OTHER;
																										SELF.license.expirationDate := (UNSIGNED)LEFT.expiration_date;
																										SELF.license.dateFirstSeen := LEFT.date_first_seen;
																										SELF.license.dateLastSeen := LEFT.date_last_seen;
																										SELF.license.isActive := current;
																										SELF.license.licenseNumber := LEFT.license_number;
																										SELF.license.issueDate := LEFT.issue_date;
																										SELF := LEFT;
																										SELF := [];));



	mariLicenseRaw := JOIN(indiv, Prof_License_Mari.key_did(),
													KEYED(LEFT.party.did = RIGHT.s_did) AND
													RIGHT.std_source_upd NOT IN risk_indicators.iid_constants.restricted_Mari_vendor_set,
													TRANSFORM({UNSIGNED4 seq, UNSIGNED6 parentUltID, UNSIGNED6 parentOrgID, UNSIGNED6 parentSeleID, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																			SELF.parentUltID := LEFT.ultID;
																			SELF.parentOrgID := LEFT.orgID;
																			SELF.parentSeleID := LEFT.seleID;
																			SELF := LEFT;
																			SELF := RIGHT;
																			SELF := [];),
													ATMOST(LEFT.party.did = RIGHT.s_did, DueDiligence.Constants.MAX_ATMOST_1000));

	
	// Filter out records after our history date.
	mariLicenseFiltRecs := DueDiligence.Common.FilterRecords(mariLicenseRaw, date_first_seen, date_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_mariDateLastSeen := DueDiligence.Common.CleanDateFields(mariLicenseFiltRecs, date_last_seen);
	clean_mariExpirationDate := DueDiligence.Common.CleanDateFields(clean_mariDateLastSeen, expire_dte);
	clean_mariIssueDate := DueDiligence.Common.CleanDateFields(clean_mariExpirationDate, orig_issue_dte);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	mariLicenseFilt := clean_mariIssueDate;
	
	projectMariLicense := PROJECT(mariLicenseFilt, TRANSFORM(DueDiligence.LayoutsInternal.PartyLicences,
																														
																														professionCat := TRIM(LEFT.std_prof_desc, LEFT, RIGHT);
																														licenseType := TRIM(LEFT.std_license_desc, LEFT, RIGHT);
																														
																														category := MAP(TRIM(LEFT.std_prof_desc, LEFT, RIGHT) IN DueDiligence.Constants.PROF_LIC_CATEGORY_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_COMBO_CATEGORY_FINANCE_OR_REAL_ESTATE AND
																																									licenseType IN DueDiligence.Constants.PROF_LIC_COMBO_TYPE_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_COMBO_CATEGORY_MEDICAL AND
																																									licenseType IN DueDiligence.Constants.PROF_LIC_COMBO_TYPE_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_LAW_OR_ACCOUNTING => DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																						professionCat IN DueDiligence.Constants.PROF_LIC_CATEGORY_BLAST_PILOT => DueDiligence.Constants.PROF_LIC_BLAST_PILOT,
																																						professionCat = DueDiligence.Constants.EMPTY => MAP(licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_LAW_OR_ACCOUNTING => DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING,
																																																																licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_FINANCE_OR_REAL_ESTATE => DueDiligence.Constants.PROF_LIC_REAL_ESTATE,
																																																																licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_MEDICAL => DueDiligence.Constants.PROF_LIC_MEDICAL,
																																																																licenseType IN DueDiligence.Constants.PROF_LIC_BLANK_CATEGORY_BLAST_PILOT => DueDiligence.Constants.PROF_LIC_BLAST_PILOT,
																																																																DueDiligence.Constants.PROF_LIC_OTHER),
																																						DueDiligence.Constants.PROF_LIC_OTHER);
																																						
																														histDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
																														
																														current := MAP(LEFT.expire_dte = 0 => TRUE,
																																						histDate <= LEFT.expire_dte => TRUE,
																																						FALSE);
																																						
																														SELF.license.licenseType := licenseType;
																														SELF.license.licenseCategory := professionCat;
																														SELF.license.status := LEFT.std_status_desc;
																														SELF.license.lawAcct := category = DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING;
																														SELF.license.realEstate := category = DueDiligence.Constants.PROF_LIC_REAL_ESTATE;
																														SELF.license.medical := category = DueDiligence.Constants.PROF_LIC_MEDICAL;
																														SELF.license.blastPilot := category = DueDiligence.Constants.PROF_LIC_BLAST_PILOT;
																														SELF.license.other := category = DueDiligence.Constants.PROF_LIC_OTHER;
																														SELF.license.expirationDate := (UNSIGNED)LEFT.expire_dte;
																														SELF.license.dateFirstSeen := LEFT.date_first_seen;
																														SELF.license.dateLastSeen := LEFT.date_last_seen;
																														SELF.license.issueDate := LEFT.orig_issue_dte;
																														SELF.license.isActive := current;
																														SELF.license.licenseNumber := LEFT.license_nbr;
																														SELF.ultID := LEFT.parentUltID;
																														SELF.orgID := LEFT.parentOrgID;
																														SELF.seleID := LEFT.parentSeleID;
																														SELF.did := LEFT.s_did;
																														SELF := LEFT;
																														SELF := [];));
																												
																												
																												
	allLicenses := projectLicense + projectMariLicense;		
	
	sortLicenses := SORT(allLicenses, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, license.licenseNumber, license.dateFirstSeen);
	rollupLicenses := ROLLUP(sortLicenses,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID AND
														LEFT.did = RIGHT.did AND
														LEFT.license.licenseNumber = RIGHT.license.licenseNumber,
														TRANSFORM(RECORDOF(LEFT),
																				SELF.license.dateFirstSeen := IF(LEFT.license.dateFirstSeen = 0, RIGHT.license.dateFirstSeen, LEFT.license.dateFirstSeen);
																				// SELF.license.issueDate := 
																				
																				leftOrRight := IF(LEFT.license.dateLastSeen < RIGHT.license.dateLastSeen, RIGHT, LEFT);
																				
																				SELF.license.dateLastSeen := leftOrRight.license.dateLastSeen;
																				SELF.license.licenseType := leftOrRight.license.licenseType;
																				SELF.license.licenseCategory := leftOrRight.license.licenseCategory;
																				SELF.license.status := leftOrRight.license.status;
																				SELF.license.lawAcct := leftOrRight.license.lawAcct;
																				SELF.license.realEstate := leftOrRight.license.realEstate;
																				SELF.license.medical := leftOrRight.license.medical;
																				SELF.license.blastPilot := leftOrRight.license.blastPilot;
																				SELF.license.other := leftOrRight.license.other;
																				SELF.license.expirationDate := leftOrRight.license.expirationDate;
																				SELF.license.isActive := leftOrRight.license.isActive;																				
																				SELF := LEFT;));
	
	
	projectLic := PROJECT(rollupLicenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED6 did, BOOLEAN activeLA,
																												BOOLEAN activeFRE, BOOLEAN activeMed, BOOLEAN activeBP, BOOLEAN inactiveLA, BOOLEAN inactiveFRE,
																												BOOLEAN inactiveMed, BOOLEAN inactiveBP, DATASET(DueDiligence.Layouts.RelatedParty) party},
																									
																									SELF.party := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.RelatedParty,
																																												SELF.licenses := LEFT.license;
																																												SELF := LEFT;
																																												SELF := [];));
																									SELF.activeLA := LEFT.license.isActive AND LEFT.license.lawAcct;
																									SELF.activeFRE := LEFT.license.isActive AND LEFT.license.realEstate;
																									SELF.activeMed := LEFT.license.isActive AND LEFT.license.medical;
																									SELF.activeBP := LEFT.license.isActive AND LEFT.license.blastPilot;
																									SELF.inactiveLA := LEFT.license.isActive = FALSE AND LEFT.license.lawAcct;
																									SELF.inactiveFRE := LEFT.license.isActive = FALSE AND LEFT.license.realEstate;
																									SELF.inactiveMed := LEFT.license.isActive = FALSE AND LEFT.license.medical;
																									SELF.inactiveBP := LEFT.license.isActive = FALSE AND LEFT.license.blastPilot; 
																									SELF := LEFT;
																									SELF := [];));
																									
	sortProjectLic := SORT(projectLic, seq,	#EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);																							
																									
	rollLicense := ROLLUP(sortProjectLic, 
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID AND
												LEFT.did = RIGHT.did,
												TRANSFORM({RECORDOF(LEFT)},
																	SELF.party := LEFT.party + RIGHT.party;
																	SELF.activeLA := LEFT.activeLA OR RIGHT.activeLA;
																	SELF.activeFRE := LEFT.activeFRE OR RIGHT.activeFRE;
																	SELF.activeMed := LEFT.activeMed OR RIGHT.activeMed;
																	SELF.activeBP := LEFT.activeBP OR RIGHT.activeBP;
																	SELF.inactiveLA := LEFT.inactiveLA OR RIGHT.inactiveLA;
																	SELF.inactiveFRE := LEFT.inactiveFRE OR RIGHT.inactiveFRE;
																	SELF.inactiveMed := LEFT.inactiveMed OR RIGHT.inactiveMed;
																	SELF.inactiveBP := LEFT.inactiveBP OR RIGHT.inactiveBP;
																	SELF := LEFT;));





	// OUTPUT(licenseRaw, NAMED('licenseRaw'));
	// OUTPUT(licenseFiltRecs, NAMED('licenseFiltRecs'));
	// OUTPUT(projectLicense, NAMED('projectLicense'));
	
	// OUTPUT(mariLicenseRaw, NAMED('mariLicenseRaw'));
	// OUTPUT(mariLicenseFiltRecs, NAMED('mariLicenseFiltRecs'));
	// OUTPUT(mariLicenseFilt, NAMED('mariLicenseFilt'));
	// OUTPUT(projectMariLicense, NAMED('projectMariLicense'));
	
	// OUTPUT(allLicenses, NAMED('allLicenses'));
	// OUTPUT(sortLicenses, NAMED('sortLicenses'));
	// OUTPUT(rollupLicenses, NAMED('rollupLicenses'));
	// OUTPUT(dedupLicenses, NAMED('dedupLicenses'));
	
	// OUTPUT(projectLic, NAMED('projectLic'));
	// OUTPUT(rollLicense, NAMED('rollLicense'));
	



return rollLicense;

end;