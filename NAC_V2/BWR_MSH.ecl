 import	NAC, lib_FileServices, lib_StringLib, lib_ThorLib, Ut;

#workunit('Name', 'NAC MSH Build');
#workunit('priority','high');
#workunit('priority',11);

// ------------------------------------------------------------------------------------------------
string		gLandingZoneServer		:=	'edata10.br.seisint.com'					:	stored('LandingZoneServer');
string		gLandingZonePathBase	:=	'/data_build_4/nac'								:	stored('LandingZonePathBase');
string		gTargetThor						:=	'thor400_30'											:	stored('TargetThor');
string		gThorFilenameBase			:=	'nac::for_msh::';

// ------------------------------------------------------------------------------------------------
string		gCurrentDateTime			:=	ut.GetTimeDate()	: global, independent;
string8		gCurrentDate					:=	gCurrentDateTime[1..4] + gCurrentDateTime[6..7] + gCurrentDateTime[9..10];
string6		gCurrentTime					:=	gCurrentDateTime[11..16];


STRING AlertRecipients := MOD_InternalEmailsList.fn_GetInternalRecipients('Preprocess Error','');



// ------------------------------------------------------------------------------------------------
gMRR	:=
module
	export	string		SuperNameIn					:=	'mrr';
	export	string		SuperNameUsing			:=	'mrr_using';
	export						fClearSuperFileIn		:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	sequential(
																													lib_FileServices.FileServices.StartSuperFileTransaction(),
																													fClearSuperFileUsing,
																													lib_FileServices.FileServices.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																													lib_FileServices.FileServices.FinishSuperFileTransaction()
																												);
end;
gDBC	:=
module
	export	string		SuperNameIn					:=	'dbc';
	export	string		SuperNameUsing			:=	'dbc_using';
	export						fClearSuperFileIn		:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	sequential(
																													lib_FileServices.FileServices.StartSuperFileTransaction(),
																													fClearSuperFileUsing,
																													lib_FileServices.FileServices.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																													lib_FileServices.FileServices.FinishSuperFileTransaction()
																												);
end;
gSSE	:=
module
	export	string		SuperNameIn					:=	'sse';
	export	string		SuperNameUsing			:=	'sse_using';
	export						fClearSuperFileIn		:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameIn);
	export						fClearSuperFileUsing:=	lib_FileServices.fileservices.ClearSuperFile('~' + gThorFilenameBase + SuperNameUsing);
	export						fMoveInToUsing			:=	sequential(
																													lib_FileServices.FileServices.StartSuperFileTransaction(),
																													fClearSuperFileUsing,
																													lib_FileServices.FileServices.SwapSuperFile('~' + gThorFilenameBase + SuperNameIn, '~' + gThorFilenameBase + SuperNameUsing),
																													lib_FileServices.FileServices.FinishSuperFileTransaction()
																												);
end;
/////////////////////////////////////////
string15	gDateTimeStamp		:=	gCurrentDate + '_' + gCurrentTime;

/////////////////////////////////////////
dMRR	:=	dataset('~' + gThorFilenameBase + gMRR.SuperNameUsing,	NAC.Layouts.MRR, thor, opt);
dDBC	:=	dataset('~' + gThorFilenameBase + gDBC.SuperNameUsing,	NAC.Layouts.DBC, thor, opt);
dSSE	:=	dataset('~' + gThorFilenameBase + gSSE.SuperNameUsing,	NAC.Layouts.SSE, thor, opt);

/////////////////////////////////////////
dDBCSuperList	:=	global(nothor(lib_FileServices.FileServices.SuperFileContents('~' + gThorFilenameBase + gDBC.SuperNameUsing))
											 + nothor(lib_FileServices.FileServices.SuperFileContents('~' + gThorFilenameBase + gDBC.SuperNameIn))
												 ,few
												);
dDBCSuperSort	:=	sort(dDBCSuperList, -name);
string15	gDBCDateTimeStamp	:=	if(count(dDBCSuperSort) <> 0, dDBCSuperSort[1].Name[22..36], '');

/////////////////////////////////////////
NAC.Layouts.MSH	tDBCtoMSH(dDBC pInput)	:=
transform
	self.ActivitySource							:=	gDBCDateTimeStamp;
	self.DrupalUserState						:=	pInput.BenefitState;
	self.MatchCodes									:=	if(pInput.MatchCodes = 'L', '', pInput.MatchCodes);
	self.DrupalUserLoginID					:=	'';
	self.ESPTransactionID						:=	'';
	self.MRFRecordNumber						:=	'';
	self.DrupalTransactionID				:=	'';
	self.QueryStatus								:=	'';
	self.QueryStatusMessage					:=	'';
	self.DrupalUserIP								:=	'';
	self.EndUserName								:=	'';
	self.EndUserIP									:=	'';
	self.SearchFullName							:=	'';
	self.SearchSuffix								:=	'';
	self.TwelveMonthHistory					:=	'';
	self.IncludeTwelveMonthHistory	:=	'';
	self.LF													:=	'\n';
	self														:=	pInput;
end;

NAC.Layouts.MSH	tMRRtoMSH(dMRR pInput, boolean pIsBucket3 = false)	:=
transform
	self.ActivityType								:=	if(pIsBucket3,
																			 if(pInput.BatchFileName[1..2] <> pInput.CaseState and pInput.CaseState <> '', 
																					'3', 
																					skip
																				 ),
																			 '2'
																			);
	self.MRFRecordNumber						:=	pInput.BatchRecordNumber;
	self.ESPTransactionID						:=	pInput.BatchJobID;
	self.DrupalUserState						:=	pInput.BatchFileName[1..2];
	self.DrupalUserLoginID					:=	'';
	self.DrupalUserIP								:=	'';
	self.EndUserName								:=	'';
	self.EndUserIP									:=	'';
	self.ActivitySource							:=	pInput.BatchFileName;
	self.DrupalTransactionID				:=	pInput.RequestRecordID;
	self.LF													:=	'\n';
	self														:=	pInput;
end;

NAC.Layouts.MSH	tSSEtoMSH(dSSE pInput, boolean pIsBucket3 = false)	:=
transform
	self.ActivityType								:=	if(pIsBucket3,
																			 if(pInput.MSHRecipientState <> pInput.CaseState and pInput.CaseState <> '', 
																					'3', 
																					skip
																				 ),
																			 '1'
																			);
	self.DrupalUserState						:=	pInput.MSHRecipientState;
	self.ActivitySource							:=	'';
	self.MRFRecordNumber						:=	'';
	self.LF													:=	'\n';
	self														:=	pInput;
end;

dBucket1			:=	project(dSSE, tSSEtoMSH(left, false));
dBucket2			:=	project(dMRR, tMRRtoMSH(left, false));
dBucket3			:=	project(dMRR, tMRRtoMSH(left, true))
							+		project(dSSE, tSSEtoMSH(left, true));
dBucket4Prep	:=	project(dDBC, tDBCtoMSH(left));

dDedupBucket5	:=	dedup(NAC.MSH_Bucket_5_Data, SourceState, SourceClientID, TargetState, TargetClientID, all);

NAC.Layouts.MSH	tToBucket5(dBucket4Prep pBucket4, dDedupBucket5 pBucket5Pairs)	:=
transform
	self.ActivityType	:=	if(pBucket5Pairs.TargetClientID <> '', '5', pBucket4.ActivityType);
	self							:=	pBucket4;
end;
dBucket4			:=	join(dBucket4Prep, dDedupBucket5,
											 left.DrupalUserState = right.SourceState
									 and left.CaseState = right.TargetState
									 and left.SearchClientId = right.SourceClientID
									 and left.ClientID = right.TargetClientID,
											 tToBucket5(left, right),
											 left outer,
											 lookup
											);

dMSH			:=	sort(dBucket1 + dBucket2 + dBucket3 + dBucket4, ActivityType, MRFRecordNumber, SequenceNumber);

dMSHAllButBucket3	:=	dMSH(ActivityType <> '3');
dMSHBucket3				:=	dMSH(ActivityType = '3');

dMSH_AL						:=	dMSHAllButBucket3(DrupalUserState = 'AL')	+	dMSHBucket3(CaseState = 'AL');
dMSH_FL						:=	dMSHAllButBucket3(DrupalUserState = 'FL')	+	dMSHBucket3(CaseState = 'FL');
dMSH_GA						:=	dMSHAllButBucket3(DrupalUserState = 'GA')	+	dMSHBucket3(CaseState = 'GA');
dMSH_LA						:=	dMSHAllButBucket3(DrupalUserState = 'LA')	+	dMSHBucket3(CaseState = 'LA');
dMSH_MS						:=	dMSHAllButBucket3(DrupalUserState = 'MS')	+	dMSHBucket3(CaseState = 'MS');

zGo	:=	sequential(
											parallel(
																gMRR.fMoveInToUsing,
																gDBC.fMoveInToUsing,
																gSSE.fMoveInToUsing,
															 );
											parallel(
																output(dMSH_AL, , '~' + gThorFilenameBase + 'al_msh_' + gDateTimeStamp + '.dat', compressed),
																output(dMSH_FL, , '~' + gThorFilenameBase + 'fl_msh_' + gDateTimeStamp + '.dat', compressed),
																output(dMSH_GA, , '~' + gThorFilenameBase + 'ga_msh_' + gDateTimeStamp + '.dat', compressed),
																output(dMSH_LA, , '~' + gThorFilenameBase + 'la_msh_' + gDateTimeStamp + '.dat', compressed),
																output(dMSH_MS, , '~' + gThorFilenameBase + 'ms_msh_' + gDateTimeStamp + '.dat', compressed)
															 ),
											parallel(
																lib_FileServices.FileServices.Despray('~' + gThorFilenameBase + 'al_msh_' + gDateTimeStamp + '.dat', gLandingZoneServer, gLandingZonePathBase + '/msh/AL_MSH_' + gDateTimeStamp + '.dat'),
																lib_FileServices.FileServices.Despray('~' + gThorFilenameBase + 'fl_msh_' + gDateTimeStamp + '.dat', gLandingZoneServer, gLandingZonePathBase + '/msh/FL_MSH_' + gDateTimeStamp + '.dat'),
																lib_FileServices.FileServices.Despray('~' + gThorFilenameBase + 'ga_msh_' + gDateTimeStamp + '.dat', gLandingZoneServer, gLandingZonePathBase + '/msh/GA_MSH_' + gDateTimeStamp + '.dat'),
																lib_FileServices.FileServices.Despray('~' + gThorFilenameBase + 'la_msh_' + gDateTimeStamp + '.dat', gLandingZoneServer, gLandingZonePathBase + '/msh/LA_MSH_' + gDateTimeStamp + '.dat'),
																lib_FileServices.FileServices.Despray('~' + gThorFilenameBase + 'ms_msh_' + gDateTimeStamp + '.dat', gLandingZoneServer, gLandingZonePathBase + '/msh/MS_MSH_' + gDateTimeStamp + '.dat')
															 ),
											parallel(
																gMRR.fClearSuperFileUsing,
																gDBC.fClearSuperFileUsing,
																gSSE.fClearSuperFileUsing,
																output(gCurrentDate, named('CurrentDate')),
																output(gCurrentTime, named('CurrentTime')),
																output(count(dMSH(ActivityType='1')), named('ActivityType_1')),
																output(count(dMSH(ActivityType='2')), named('ActivityType_2')),
																output(count(dMSH(ActivityType='3')), named('ActivityType_3')),
																output(count(dMSH(ActivityType='4')), named('ActivityType_4'))
															 )
									 );
/////////////////////////////////////////

zGo	: when(cron('0 7 * * *')), failure(lib_FileServices.FileServices.SendEmail(AlertRecipients, 'New MSH Failed', 'New MSH Failed'));
zGo	:	when(event('NAC MSH Go Now', '*')), failure(lib_FileServices.FileServices.SendEmail(AlertRecipients, 'New MSH Failed', 'New MSH Failed'));