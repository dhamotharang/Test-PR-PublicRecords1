IMPORT BIPV2, Business_Risk_BIP, MDR, SAM, UT, std;

EXPORT getGovernmentDebarred(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- SAM - Government Debarred Source ----------------
	SAMRaw := SAM.key_linkID.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(SAMRaw, Shell, SAMSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(SAMSeq);
	
	// Filter out records after our history date
	SAMRecs := Business_Risk_BIP.Common.FilterRecords(SAMSeq, ActiveDate, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet);
	
	
	cleanSAM := PROJECT(SAMRecs, TRANSFORM({RECORDOF(LEFT), BOOLEAN GovernmentDebarredHit},
														TermDate := IF(StringLib.StringToLowerCase(LEFT.TerminationDate) = 'indefinite', '99999999', Business_Risk_BIP.Common.checkInvalidDate(LEFT.TerminationDate, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate));
														SELF.TerminationDate := TermDate;
														// If this is a realtime transaction, check that the Termination Date comes in the future (Otherwise this debarred hit has been terminated and shouldn't count)
														SELF.GovernmentDebarredHit := IF(((STRING)LEFT.HistoryDate = Business_Risk_BIP.Constants.NinesDate AND Std.Date.Today() <= (INTEGER)TermDate) OR
														// If this is a historical transaction, check that the Termination Date hasn't already passed 
																											((STRING)LEFT.HistoryDate <> Business_Risk_BIP.Constants.NinesDate AND(INTEGER)(((STRING)LEFT.HistoryDate)[1..6]) <= (INTEGER)(TermDate[1..6])),
																									TRUE, // Gov Debarred
																									FALSE); // Not Gov Debarred
														SELF := LEFT));
	
	rolledSAM := ROLLUP(SORT(cleanSAM, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT), SELF.GovernmentDebarredHit := LEFT.GovernmentDebarredHit OR RIGHT.GovernmentDebarredHit; SELF := LEFT));
	
	withSAM := JOIN(Shell, rolledSAM, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Public_Record.GovernmentDebarred := (STRING)(INTEGER)RIGHT.GovernmentDebarredHit;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	withErrorCodes := JOIN(withSAM, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeGovernmentDebarred := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(SAMRaw, 100), NAMED('Sample_SAMRaw'));
	// OUTPUT(CHOOSEN(SAM, 100), NAMED('Sample_SAM'));
	
	RETURN withErrorCodes;
END;