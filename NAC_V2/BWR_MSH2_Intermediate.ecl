import	NAC_V2, Ut, Std;

#workunit('Name', 'NAC2 MSH2 Intermediate Build');
#workunit('priority','high');
#workunit('priority',11);

// ------------------------------------------------------------------------------------------------
// string		gLandingZoneServerPPA		:=	'uspr-edata10.risk.regn.net'					:	stored('LandingZoneServerPPA');
// string		gLandingZoneServerNAC		:=	'uspr-edata11.risk.regn.net'					:	stored('LandingZoneServerNAC');
// string		gLandingZonePathPPA			:=	'/data/rin_ppa'												:	stored('LandingZonePathPPA');
// string		gLandingZonePathNAC			:=	'/data/hds_180/nac2/'									:	stored('LandingZonePathNAC');
string		gTargetThor							:=	'thor400_44'													:	stored('TargetThor');
string		gThorFilenameBase				:=	'nac::nac2::for_msh2::';
string		gRecordTimeCutoff				:=	'04:00:00';	//GMT difference during DST
string		gMSH2IntermediateBase		:=	gThorFilenameBase	+ 'msh2_intermediate_';
string		gMSX2IntermediateBase		:=	gThorFilenameBase	+ 'msx2_intermediate_';
string		gMSH2IntermediateSuper	:=	gThorFilenameBase	+ 'msh2_intermediate';
string		gMSX2IntermediateSuper	:=	gThorFilenameBase	+ 'msx2_intermediate';

// ------------------------------------------------------------------------------------------------
// 2019-11-14 05:16:16
// 2019-11-14 03:00:02
// NOTE that the ESP filename will have the date of extract, containing the previous day's data, so we will need to get to yesterday from the date in the filename
string8		fExtracteFileDate(string	pESPLogExtractFileName)	:=	regexfind('([0-9]{8})\\.txt$', pESPLogExtractFileName, 1);

string19	fLowSQLDateRange(string8	pESPExtractDate)	:=
function
	unsigned4		lExtractDate	:=	(unsigned4)pESPExtractDate;
	unsigned4		lRecordDate		:=	Std.Date.AdjustDate(lExtractDate, 0, 0, -1);
	string19		lReturnValue	:=	Std.Date.DateToString(lRecordDate, '%Y-%m-%d') + ' ' + gRecordTimeCutoff;
	return			lReturnValue;
end;
string19	fHighSQLDateRange(string8	pESPExtractDate)	:=
function
	unsigned4		lExtractDate	:=	(unsigned4)pESPExtractDate;
	string19		lReturnValue	:=	Std.Date.DateToString(lExtractDate, '%Y-%m-%d') + ' ' + gRecordTimeCutoff;
	return			lReturnValue;
end;

// ------------------------------------------------------------------------------------------------
string8		gCurrentDate					:=	intformat(Std.Date.CurrentDate(true), 8, 1) : global, independent;
string6		gCurrentTime					:=	intformat(Std.Date.CurrentTime(true), 6, 1) : global, independent;
string15	gDateTimeStamp				:=	gCurrentDate + '_' + gCurrentTime;

// ------------------------------------------------------------------------------------------------
// NAC1 files for crossover ingest (bucket 3)
gMRR	:=
module
	export	string		SuperNameIn					:=	'mrr';
	export	string		SuperNameUsing			:=	'mrr_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;
gSSE	:=
module
	export	string		SuperNameIn					:=	'sse';
	export	string		SuperNameUsing			:=	'sse_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;

// ------------------------------------------------------------------------------------------------
gMRR2	:=
module
	export	string		SuperNameIn					:=	'mrr2';
	export	string		SuperNameUsing			:=	'mrr2_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;
gMRX2	:=
module
	export	string		SuperNameIn					:=	'mrx2';
	export	string		SuperNameUsing			:=	'mrx2_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;
gDBC2	:=
module
	export	string		SuperNameIn					:=	'nac::out::newcollisions2';	// Special naming for now
	export	string		SuperNameUsing			:=	'dbc2_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + SuperNameIn);	// Special naming for now
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;
gLog2	:=
module
	export	string		SuperNameIn					:=	'log_nac2_transaction_log';
	export	string		SuperNameUsing			:=	'log_nac2_transaction_log_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;
gLog2Online	:=
module
	export	string		SuperNameIn					:=	'log_nac2_transaction_log_online';
	export	string		SuperNameUsing			:=	'log_nac2_transaction_log_online_using';
	export						fClearSuperFileIn		:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	Std.File.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	ordered(
																										Std.File.StartSuperFileTransaction(),
																										fClearSuperFileUsing,
																										Std.File.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																										Std.File.FinishSuperFileTransaction()
																									 );
end;

/////////////////////////////////////////

dSSEBucket3			:=	NAC_V2.MSH2_NAC1_Support.SSEBucket3();
dMRRBucket3			:=	NAC_V2.MSH2_NAC1_Support.MRRBucket3();
dMRR2						:=	dataset('~' + gThorFilenameBase + gMRR2.SuperNameUsing,	NAC_v2.Layouts.MRR2, thor, opt);
dMRX2						:=	dataset('~' + gThorFilenameBase + gMRR2.SuperNameUsing,	NAC_V2.Layouts.MRX2, thor, opt);
dDBC2						:=	dataset('~' + gThorFilenameBase + gDBC2.SuperNameUsing,	NAC_V2.Layout_Collisions2.Layout_Collisions, thor, opt);
dLog2						:=	dataset('~' + gThorFilenameBase + gLog2.SuperNameUsing,	NAC_V2.ESP_Logs_Layouts.TransactionLogDelimited, csv(terminator('|\n'), quote([]), separator('|\t|')), opt);
dLog2Online			:=	dataset('~' + gThorFilenameBase + gLog2Online.SuperNameUsing,	NAC_V2.ESP_Logs_Layouts.TransactionLogOnlineRaw, csv(terminator('|\n'), quote([]), separator('|\t|')), opt);
dLogs2Combined	:=	NAC_V2.ESP_Logs_Helpers.fTransactionLogsCombinedFiltered(NAC_V2.ESP_Logs_Helpers.fLogsCombined(NAC_V2.ESP_Logs_Helpers.fTransactionLogFixed(dLog2), NAC_V2.ESP_Logs_Helpers.fTransactionLogOnlineParsed(dLog2Online)));

/////////////////////////////////////////
string1	fAllPositiveNegativeToYN(string1 pValue)	:=	if(Std.Str.ToUpperCase(pValue) in ['1', 'Y'],
																												 'Y',
																												 if(Std.Str.ToUpperCase(pValue) in ['0', 'N'],
																														'N',
																														pValue
																													 )
																												);

/////////////////////////////////////////
NAC_V2.Layouts.MSX2PlusInternal	tMSX2FromMRX2(dMRX2 pInput)	:=
transform
	self.TargetNACGroupID							:=	Std.Str.ToUpperCase(pInput.BatchFileName[6..9]);		// Internal
	self.SourceState									:=	Std.Str.ToUpperCase(pInput.BatchFileName[6..7]);		// Internal
	self.ServiceName									:=	'';																									// Internal
	self.ActivitySource								:=	pInput.BatchFileName;
	self.NACTransactionID							:=	pInput.BatchJobID;
	self.NACUserID										:=	'';
	self.NACUserIP										:=	'';
	self.EndUserID										:=	'';
	self.EndUserIP										:=	'';
	self.IncludeEligibilityHistory		:=	fAllPositiveNegativeToYN(pInput.IncludeEligibilityHistory);
	self.IncludeInterstateAllPrograms	:=	fAllPositiveNegativeToYN(pInput.IncludeInterstateAllPrograms);
  self 															:=	pInput;
end;
dMSX2FromMRX2	:=	project(dMRX2, tMSX2FromMRX2(left));

NAC_V2.Layouts.MSH2PlusInternal	tMSH2FromMRR2(dMRR2 pInput)	:=
transform
	self.TargetNACGroupID							:=	Std.Str.ToUpperCase(pInput.BatchFileName[6..9]);		// Internal
	self.SourceState									:=	Std.Str.ToUpperCase(pInput.BatchFileName[6..7]);		// Internal
	self.ServiceName									:=	'';																									// Internal
	self.ActivitySource								:=	pInput.BatchFileName;
	self.NACTransactionID							:=	pInput.BatchJobID;
	self.RequestRecordID							:=	'';
	self.NACUserID										:=	'';
	self.NACUserIP										:=	'';
	self.EndUserID										:=	'';
	self.EndUserIP										:=	'';
	self.IncludeEligibilityHistory		:=	fAllPositiveNegativeToYN(pInput.IncludeEligibilityHistory);
	self.IncludeInterstateAllPrograms	:=	fAllPositiveNegativeToYN(pInput.IncludeInterstateAllPrograms);
	self.CaseState										:=	pInput.CaseProgramState;
  self 															:=	pInput;
end;
dMSH2FromMRR2	:=	project(dMRR2, tMSH2FromMRR2(left));

/////////////////////////////////////////
NAC_V2.Layouts.MSH2PlusInternal	tMSH2_3_FromMRR2(dMSH2FromMRR2 pInput)	:=
transform
	self.ActivityType			:=	'3';
	self.TargetNACGroupID	:=	pInput.CaseNACGroupID;
  self 									:=	pInput;
end;
dMSH2_3_FromMRR2	:=	project(dMSH2FromMRR2(TargetNACGroupID <> CaseNACGroupID), tMSH2_3_FromMRR2(left));

/////////////////////////////////////////
NAC_V2.Layouts.MSH2PlusInternal	tMSH2FromDBC2(dDBC2 pInput)	:=
transform
	self.TargetNACGroupID								:=	Std.Str.ToUpperCase(pInput.SearchGroupID);		// Internal
	self.SourceState										:=	Std.Str.ToUpperCase(pInput.BenefitState);			// Internal
	self.ServiceName										:=	'';																						// Internal
	self.ActivitySource									:=	pInput.BuildVersion;
	self.NACTransactionID								:=	'';
	self.BatchRecordNumber							:=	'0000000000';
	self.RequestRecordID								:=	'';
	self.NACUserID											:=	'';
	self.NACUserIP											:=	'';
	self.EndUserID											:=	'';
	self.EndUserIP											:=	'';
	self.QueryStatus										:=	'';
	self.QueryStatusMessage							:=	'';
	self.SearchProgramCode							:=	pInput.SearchBenefitType;
	self.SearchRangeType								:=	pInput.SearchRangeType;
	self.SearchEligibilityStart					:=	pInput.SearchStartDate;
	self.SearchEligibilityEnd						:=	pInput.SearchEndDate;
	self.SearchFullName									:=	'';		//	Actual data does not have Full Name
	self.IncludeEligibilityHistory			:=	'Y';
	self.IncludeInterstateAllPrograms		:=	'Y';
	self.CaseNACGroupID									:=	pInput.CaseGroupID;
	self.CaseProgramCode								:=	pInput.CaseBenefitType;
	self.CaseRegionCode									:=	pInput.RegionCode;
	self.PhysicalAddressCategory				:=	pInput.AddressPhysicalCategory;
	self.PhysicalAddressStreet1					:=	pInput.CasePhysicalStreet1;
	self.PhysicalAddressStreet2					:=	pInput.CasePhysicalStreet2;
	self.PhysicalAddressCity						:=	pInput.CasePhysicalCity;
	self.PhysicalAddressState						:=	pInput.CasePhysicalState;
	self.PhysicalAddressZip							:=	pInput.CasePhysicalZip;
	self.MailAddressCategory						:=	pInput.AddressMailCategory;
	self.MailAddressStreet1							:=	pInput.CaseMailStreet1;
	self.MailAddressStreet2							:=	pInput.CaseMailStreet2;
	self.MailAddressCity								:=	pInput.CaseMailCity;
	self.MailAddressState								:=	pInput.CaseMailState;
	self.MailAddressZip									:=	pInput.CaseMailZip;
	self.ClientHoHIndicator							:=	pInput.HoHIndicator;
	self.ClientHoHRelationshipIndicator	:=	pInput.RelationshipIndicator;
	self.ClientABAWDIndicator						:=	pInput.ABAWDIndicator;
	self.ClientCertificateID						:=	pInput.ClientCertificateType;
	self.ClientEligibilityPeriodStart		:=	pInput.ClientEligibilityStartDate;
	self.ClientEligibilityPeriodEnd			:=	pInput.ClientEligibilityEndDate;
	self.SequenceNumber									:=	'0001';
	self																:=	pInput;
end;
dMSH2FromDBC2	:=	project(dDBC2, tMSH2FromDBC2(left));

/////////////////////////////////////////
dHitsFromLog2							:=	NAC_V2.ESP_Logs_To_MSH2_MSX2_Intermediate(dLogs2Combined).dIntermediateHitFlattenedRolled;
dMissesFromLog2						:=	NAC_V2.ESP_Logs_To_MSH2_MSX2_Intermediate(dLogs2Combined).dIntermediateMissFlattened;

/////////////////////////////////////////
dMSH2PlusInternalFromLog2	:=	NAC_V2.ESP_Logs_Intermediate_To_MSH2_MSX2.fMSH2InternalFromHitsFlattened(dHitsFromLog2);
dMSX2PlusInternalFromLog2	:=	NAC_V2.ESP_Logs_Intermediate_To_MSH2_MSX2.fMSX2InternalFromMissesFlattened(dMissesFromLog2);

/////////////////////////////////////////
NAC_V2.Layouts.MSH2PlusInternal	tMSH2Bucket3FromLog2(dMSH2PlusInternalFromLog2 pInput)	:=
transform
	self.ActivityType										:=	'3';
	self.TargetNACGroupID								:=	Std.Str.ToUpperCase(pInput.CaseNACGroupID);			// Internal
	self																:=	pInput;
end;
dMSH2PlusInternalBucket3FromLog2	:=	project(dMSH2PlusInternalFromLog2(TargetNACGroupID <> CaseNACGroupID), tMSH2Bucket3FromLog2(left));

/////////////////////////////////////////
dExceptions						:=	NAC_V2.Files2.dsExceptionRecords(UpdateType = 'U');	// Ensure only non-deleted ones
dExceptionsSameGroup	:=	dExceptions(SourceGroupID = MatchedGroupID);
recordof(dExceptionsSameGroup) tFlipExceptionsSameGroup(dExceptionsSameGroup pInput)	:=
transform
	self.SourceGroupID				:=	pInput.MatchedGroupID;
	self.SourceProgramState		:=	pInput.MatchedState;
	self.SourceProgramCode		:=	pInput.MatchedProgramCode;
	self.SourceClientID				:=	pInput.MatchedClientID;
	self.MatchedGroupID				:=	pInput.SourceGroupID;
	self.MatchedState					:=	pInput.SourceProgramState;
	self.MatchedProgramCode		:=	pInput.SourceProgramCode;
	self.MatchedClientID			:=	pInput.SourceClientID;
	self											:=	pInput;
end;
dFlipExceptionsSameGroup	:=	project(dExceptionsSameGroup, tFlipExceptionsSameGroup(left));
dExceptionsCombined				:=	dExceptions + dExceptionsSameGroup + dFlipExceptionsSameGroup;
dExceptionsDist						:=	distribute(dExceptionsCombined, hash(SourceGroupID, SourceProgramState, SourceProgramCode, SourceClientID));
dExceptionsSort						:=	sort(dExceptionsDist, SourceGroupID, SourceProgramState, SourceProgramCode, SourceClientID, MatchedGroupID, MatchedState, MatchedProgramCode, MatchedClientID, local);
dExceptionsDedup					:=	dedup(dExceptionsSort, SourceGroupID, SourceProgramState, SourceProgramCode, SourceClientID, MatchedGroupID, MatchedState, MatchedProgramCode, MatchedClientID, local);

/////////////////////////////////////////
NAC_V2.Layouts.MSH2PlusInternal	tAddExceptionsToBucket4(dMSH2FromDBC2 pDBC2, dExceptionsDedup pExceptions)	:=
transform
	self.ExceptionReasonCode	:=	pExceptions.ReasonCode;
	self.ExceptionComments		:=	pExceptions.Comments;
	self											:=	pDBC2;
end;
dDBC2WithExceptions	:=	join(dMSH2FromDBC2, dExceptionsDedup,
														 left.TargetNACGroupID = right.SourceGroupID
												 and left.SourceState = right.SourceProgramState
												 and left.SearchProgramCode = right.SourceProgramCode
												 and left.SearchClientID = right.SourceClientID
												 and left.CaseNACGroupID = right.MatchedGroupID
												 and left.CaseState = right.MatchedState
												 and left.CaseProgramCode = right.MatchedProgramCode
												 and left.ClientID = right.MatchedClientID,
														 tAddExceptionsToBucket4(left, right),
														 lookup,
														 left outer
														);

/////////////////////////////////////////
dMSH2PlusInternalIntermediate	:=	dMSH2PlusInternalFromLog2					// Bucket 1
															+		dMSH2FromMRR2											// Bucket 2 
															+		dMSH2PlusInternalBucket3FromLog2	// Bucket 3 from Bucket 1
															+		dMSH2_3_FromMRR2									// Bucket 3 from Bucket 2
															+		dSSEBucket3												// Bucket 3 from Bucket 1 NAC1
															+		dMRRBucket3												// Bucket 3 from Bucket 1 NAC1
															+		dDBC2WithExceptions								// Bucket 4 with exception data
															;

dMSX2PlusInternalIntermediate	:=	dMSX2PlusInternalFromLog2					// Bucket 1
															+		dMSX2FromMRX2											// Bucket 2 
															;

zGo	:=	sequential(
										parallel(
															gMRR2.fMoveInToUsing,
															gMRX2.fMoveInToUsing,
															gDBC2.fMoveInToUsing,
															gSSE.fMoveInToUsing,
															gMRR.fMoveInToUsing,
															gLog2.fMoveInToUsing,
															gLog2Online.fMoveInToUsing
														 ),
										parallel(
															output(gDateTimeStamp, named('DateTimeStamp')),
															output(dMSH2PlusInternalIntermediate, , '~' + gMSH2IntermediateBase + gDateTimeStamp, compressed),
															output(dMSX2PlusInternalIntermediate, , '~' + gMSX2IntermediateBase + gDateTimeStamp, compressed)
														 ),
										parallel(
															gMRR2.fClearSuperFileUsing,
															gMRX2.fClearSuperFileUsing,
															gDBC2.fClearSuperFileUsing,
															gSSE.fClearSuperFileUsing,
															gMRR.fClearSuperFileUsing,
															gLog2.fClearSuperFileUsing,
															gLog2Online.fClearSuperFileUsing
														 ),
										parallel(
															Std.File.AddSuperFile('~' + gMSH2IntermediateSuper, '~' + gMSH2IntermediateBase + gDateTimeStamp),
															Std.File.AddSuperFile('~' + gMSX2IntermediateSuper, '~' + gMSX2IntermediateBase + gDateTimeStamp)
														 )
									 );

/////////////////////////////////////////
zGo	:	when(event('NAC2Event: MSH2 Intermediate Go Now', '*')), failure(STD.System.Email.SendEmail('tony.kirk@lexisnexisrisk.com', 'NAC2 MSH2 Intermediate Failed', 'NAC2 MSH2 Intermediate Failed'));
zGo	: when(cron('0 10 * * *')), failure(STD.System.Email.SendEmail('tony.kirk@lexisnexis.com', 'NAC2 MSH2 Intermediate Failed', 'NAC2 MSH2 Intermediate Failed'));
