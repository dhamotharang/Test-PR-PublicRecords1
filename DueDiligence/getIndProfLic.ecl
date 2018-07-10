IMPORT BIPv2, prof_licenseV2, risk_indicators, Prof_License_Mari, STD;

/*
  This module is used by both Business and Person products.

	Following Keys being used:
			Prof_licenseV2.Key_Proflic_Did
			Prof_License_Mari.key_did
*/

EXPORT getIndProfLic(DATASET(DueDiligence.LayoutsInternal.RelatedParty) indiv) := FUNCTION


	licenseRaw := JOIN(indiv, prof_licenseV2.Key_Proflic_Did(),
											TRIM(RIGHT.prolic_key)!= DueDiligence.Constants.EMPTY AND
											KEYED(RIGHT.did = LEFT.party.did),
											TRANSFORM({UNSIGNED4 uniqueID, DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout -did, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																	SELF.did := LEFT.party.did;
                                  SELF := LEFT;
																	SELF := RIGHT;
																	SELF := [];),
											ATMOST(RIGHT.did = LEFT.party.did, DueDiligence.Constants.MAX_ATMOST_1000));
											
	projectLicense := PROJECT(licenseRaw, TRANSFORM(DueDiligence.LayoutsInternal.PartyLicenses,
																										
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
																										convertExpiration := (UNSIGNED4)LEFT.expiration_date;
																										current := MAP(convertExpiration = DueDiligence.Constants.NUMERIC_ZERO => TRUE,
																																		histDate <= convertExpiration => TRUE,
																																		FALSE);
																										
																										SELF.license.licenseType := licenseType;
																										SELF.license.licenseCategory := professionCat;
																										SELF.license.status := LEFT.status;
																										SELF.license.lawAcct := category = DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING;
																										SELF.license.realEstate := category = DueDiligence.Constants.PROF_LIC_REAL_ESTATE;
																										SELF.license.medical := category = DueDiligence.Constants.PROF_LIC_MEDICAL;
																										SELF.license.blastPilot := category = DueDiligence.Constants.PROF_LIC_BLAST_PILOT;
																										SELF.license.other := category = DueDiligence.Constants.PROF_LIC_OTHER;
																										SELF.license.expirationDate := (UNSIGNED4)LEFT.expiration_date;
																										SELF.license.dateFirstSeen := (UNSIGNED4)LEFT.date_first_seen;
																										SELF.license.dateLastSeen := (UNSIGNED4)LEFT.date_last_seen;
																										SELF.license.isActive := current;
																										SELF.license.licenseNumber := LEFT.license_number;
																										SELF.license.issueDate := (UNSIGNED4)LEFT.issue_date;
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
	
	projectMariLicense := PROJECT(mariLicenseRaw, TRANSFORM(DueDiligence.LayoutsInternal.PartyLicenses,
																														
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
																														convertExpiration := (UNSIGNED4)LEFT.expire_dte;
																														current := MAP(convertExpiration = DueDiligence.Constants.NUMERIC_ZERO => TRUE,
																																						histDate <= convertExpiration => TRUE,
																																						FALSE);
																																						
																														SELF.license.licenseType := licenseType;
																														SELF.license.licenseCategory := professionCat;
																														SELF.license.status := LEFT.std_status_desc;
																														SELF.license.lawAcct := category = DueDiligence.Constants.PROF_LIC_LAW_ACCOUNTING;
																														SELF.license.realEstate := category = DueDiligence.Constants.PROF_LIC_REAL_ESTATE;
																														SELF.license.medical := category = DueDiligence.Constants.PROF_LIC_MEDICAL;
																														SELF.license.blastPilot := category = DueDiligence.Constants.PROF_LIC_BLAST_PILOT;
																														SELF.license.other := category = DueDiligence.Constants.PROF_LIC_OTHER;
																														SELF.license.expirationDate := (UNSIGNED4)LEFT.expire_dte;
																														SELF.license.dateFirstSeen := (UNSIGNED4)IF(LEFT.date_first_seen = DueDiligence.Constants.EMPTY, LEFT.date_vendor_first_reported, LEFT.date_first_seen);
																														SELF.license.dateLastSeen := (UNSIGNED4)LEFT.date_last_seen;
																														SELF.license.issueDate := (UNSIGNED4)LEFT.orig_issue_dte;
																														SELF.license.isActive := current;
																														SELF.license.licenseNumber := LEFT.license_nbr;
																														SELF.ultID := LEFT.parentUltID;
																														SELF.orgID := LEFT.parentOrgID;
																														SELF.seleID := LEFT.parentSeleID;
																														SELF.did := LEFT.s_did;
																														SELF := LEFT;
																														SELF := [];));
																												
																												
																												
	allLicenses := projectLicense + projectMariLicense;		
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	allLicenseDateClean:= DueDiligence.Common.CleanDatasetDateFields(allLicenses, 'license.dateFirstSeen');
	
	// Filter out records after our history date.
	allLicenseFilt := DueDiligence.Common.FilterRecordsSingleDate(allLicenseDateClean, license.dateFirstSeen);
	
	sortLicenses := SORT(allLicenseFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, license.licenseNumber, license.dateFirstSeen);
	rollupLicenses := ROLLUP(sortLicenses,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID AND
														LEFT.did = RIGHT.did AND
														LEFT.license.licenseNumber = RIGHT.license.licenseNumber,
														TRANSFORM(RECORDOF(LEFT),
																				SELF.license.dateFirstSeen := IF(LEFT.license.dateFirstSeen = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.license.dateFirstSeen, LEFT.license.dateFirstSeen);
																				
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
	
	
	projectLic := PROJECT(rollupLicenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, BOOLEAN activeLA,
																												BOOLEAN activeFRE, BOOLEAN activeMed, BOOLEAN activeBP, BOOLEAN inactiveLA, BOOLEAN inactiveFRE,
																												BOOLEAN inactiveMed, BOOLEAN inactiveBP, DATASET(DueDiligence.Layouts.RelatedParty) party},
																									
																									SELF.party := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.RelatedParty,
																																												SELF.licenses := PROJECT(LEFT.license, TRANSFORM(DueDiligence.Layouts.Licenses,
																																																																					SELF := LEFT;
																																																																					SELF := [];));
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





	// OUTPUT(indiv, NAMED('indiv'));
	// OUTPUT(licenseRaw, NAMED('licenseRaw'));
	// OUTPUT(projectLicense, NAMED('projectLicense'));
	
	// OUTPUT(mariLicenseRaw, NAMED('mariLicenseRaw'));
	// OUTPUT(projectMariLicense, NAMED('projectMariLicense'));
	
	// OUTPUT(allLicenses, NAMED('allLicenses'));
	// OUTPUT(allLicenseDateClean, NAMED('allLicenseDateClean'));
	// OUTPUT(allLicenseFilt, NAMED('allLicenseFilt'));
	
	// OUTPUT(sortLicenses, NAMED('sortLicenses'));
	// OUTPUT(rollupLicenses, NAMED('rollupLicenses'));
	
	// OUTPUT(projectLic, NAMED('projectLic'));
	// OUTPUT(rollLicense, NAMED('rollLicense'));
	



return rollLicense;

end;