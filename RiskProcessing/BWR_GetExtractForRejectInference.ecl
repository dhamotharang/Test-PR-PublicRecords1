#OPTION('multiplePersistInstances',FALSE);
IMPORT	ut, STD,	Address;

//===========================================================================================================
// Note:  
// Kevin Garrity is the original owner of this code. 
// This code is from “Thorprod” branch  Business_Credit.BWR_GetExtractForRejectInference.   
// It is very difficult to move another branch code into our ScoringQA branch.
// I would send an email to Kevin G making sure there hasn’t been any changes.   
// No changes to this code in the last 2 years (as of May 2019)  
//===========================================================================================================





/**********************************************************************************************************/
// -- pFilename -	Original Raw Filename.  The file is expected to be sprayed to THOR with a 
//								name of '~thor::in::sbfe::'+pFilename
// -- pBIPIDLevel -	Level of granularity to use for BIP IDs. 
//									Possible values: ULTID, ORGID, SELEID, PROXID, POWID 
//									Default: SELEID 
// -- pSBFEContributorNumber - A specific SBFE_Contributor_Number to use for this extract.
// -- pAccountType	-	A pipe delimited "|" string of possible Account Types.  Blank or ANY results in using 
//										All Account Types. Ex. '001|099'
// -- pOpenDateStart	-	date_account_opened should be after this date.  This will be ignored if 
//											invalid or left blank.
// -- pOpenDateEnd	-	date_account_opened should be before this date.  This will be ignored if 
//										invalid or left blank.
// -- pOpenDateDurationMonths	-	This is mutually exclusive of the above dates and will be ignored if
//															pOpenDateStart and pOpenDateEnd are valid.
// -- pPerformanceWindowMonths	-	choose tradelines which have a cycle_end_date within this many months
//																of the date_account_opened.  This field will be ignored if zero.
// -- pTradelineWindowMonthsAfter		-	choose tradelines which have a cycle_end_date that are this many months
//															after the historydate.  This field will be ignored if zero or negative.
// -- pTradelineWindowMonthsPrior	-	choose tradelines which have a cycle_end_date that are this many months
//															before the historydate.  This field will be ignored if zero or negative.
//															allowed.
// -- pBuildBIIPIIFile	-	Build a BII/PII file (requires valid pOpenDateStart and pOpenDateEnd paramerters
// -- pUseOtherEnvironment	-	Allows the user to run from Dataland and still point to Prod input files and Keys
/**********************************************************************************************************/
/******************************* DEFAULT VALUES ***********************************************************/
// pFilename								:=	'';
// pBIPIDLevel							:=	'SELEID'; // Possible values: ULTID, ORGID, SELEID, PROXID, POWID
// pSBFEContributorNumber		:=	'ANY';
// pAccountType							:=	'ANY';
// pOpenDateStart						:=	'';
// pOpenDateEnd							:=	'';
// pOpenDateDurationMonths	:=	0;
// pPerformanceWindowMonths	:=	0;
// pTradelineWindowMonthsAfter	:=	0;
// pTradelineWindowMonthsPrior	:=	0;
// pBuildBIIPIIFile					:=	TRUE;
// pUseOtherEnvironment			:=	FALSE;
/**********************************************************************************************************/
pFilename									:=	'kgarrity::in::usbank_6988_ri_input_test_corrected';
pBIPIDLevel								:=	'SELEID'; // Possible values: ULTID, ORGID, SELEID, PROXID, POWID
pSBFEContributorNumber		:=	'ANY';
pAccountType							:=	'003';
pOpenDateStart						:=	'';
pOpenDateEnd							:=	'';
pOpenDateDurationMonths		:=	0;
pPerformanceWindowMonths	:=	0;
pTradelineWindowMonthsAfter	:=	36;
pTradelineWindowMonthsPrior	:=	6;
pBuildBIIPIIFile					:=	TRUE;
pUseOtherEnvironment			:=	FALSE;
/**********************************************************************************************************/

/************************/
/* Set Build Parameters	*/
/************************/
pBIPIDLevelNumber	:=	CASE(
												ut.CleanSpacesAndUpper(pBIPIDLevel),
												'ULTID'		=>	1,
												'ORGID'		=>	2,
												'SELEID'	=>	3,
												'PROXID'	=>	4,
												'POWID'		=>	5,
												3	//	Default
											);

pBIPIDLevelString	:=	CASE(
												pBIPIDLevelNumber,
												1	=>	'ULT',
												2	=>	'ORG',
												3	=>	'SELE',
												4	=>	'PROX',
												5	=>	'POW',
												'SELE'	//	Default
											);

pBIPIDString	:=	'UltID'+
									IF(pBIPIDLevelNumber>1,',OrgID','')+
									IF(pBIPIDLevelNumber>2,',SeleID','')+
									IF(pBIPIDLevelNumber>3,',ProxID','')+
									IF(pBIPIDLevelNumber>4,',PowID','')
									;
									
sAccountType	:=	IF(ut.CleanSpacesAndUpper(pAccountType)	IN	['','ANY'],
										['001','002','003','004','005','006','099'],
										STD.Str.SplitWords( pAccountType, '|')
									);

bUseDuration	:=	IF(
										ut.ValidDate(pOpenDateStart)	AND	
										ut.ValidDate(pOpenDateEnd)		AND
										pOpenDateStart<pOpenDateEnd,
										FALSE,
										TRUE
									);
									
pFilenameSuffix	:=	'_'+
										pBIPIDLevelString+
										IF(ut.CleanSpacesAndUpper(pSBFEContributorNumber)	NOT IN	['','ANY'],'C','X')+
										IF(ut.CleanSpacesAndUpper(pAccountType)	NOT IN	['','ANY'],'A','X')+
										IF(~bUseDuration,'O',IF(bUseDuration AND pOpenDateDurationMonths>0,'D','X'))+
										IF(pPerformanceWindowMonths>0,'P','X')+
										IF(pTradelineWindowMonthsAfter<>0,'Ta','Xa')+
										IF(pTradelineWindowMonthsPrior<>0,'Tp','Xp');

pInputFilename	:=	'~'+pFilename;
pOutputFilename	:=	'~'+pFilename+pFilenameSuffix;
pBIIPIIOutputFilename	:=	'~'+pFilename+'_BIIPII'+pFilenameSuffix;

IsValidFilename				:=	pFilename<>'';
IsValidBIPIDLevel			:=	ut.CleanSpacesAndUpper(pBIPIDLevel)	IN ['ULTID','ORGID','SELEID','PROXID','POWID'];
IsValidAccountType		:=	STD.Str.FilterOut(ut.CleanSpacesAndUpper(pAccountType),'ANY|01234569')='';
IsValidOpenDateStart	:=	pOpenDateStart=''	OR	ut.ValidDate(pOpenDateStart);
IsValidOpenDateEnd		:=	pOpenDateEnd=''	OR	ut.ValidDate(pOpenDateEnd);

IsValidInput	:=	IsValidFilename				AND
									IsValidBIPIDLevel			AND
									IsValidAccountType		AND
									IsValidOpenDateStart	AND
									IsValidOpenDateEnd										
									;

OUTPUT('Raw Filename: '+IF(IsValidFilename,pFilename,'pFilename INVALID'),NAMED('RawFilename'));
OUTPUT('Input Filename: '+IF(IsValidFilename,pInputFilename,'pFilename INVALID'),NAMED('InputFilename'));
OUTPUT('Output Filename: '+IF(IsValidFilename,pOutputFilename,'pFilename INVALID'),NAMED('OutputFilename'));
OUTPUT('Output BII/PII Filename: '+IF(IsValidFilename,pBIIPIIOutputFilename,'pFilename INVALID'),NAMED('BIIPIIOutputFilename'));
OUTPUT('BIPID Level: '+IF(IsValidBIPIDLevel,pBIPIDLevel,'pBIPIDLevel INVALID'),NAMED('pBIPIDLevel'));
OUTPUT('SBFE Contributor Number: '+pSBFEContributorNumber,NAMED('pSBFEContributorNumber'));
OUTPUT('Account Type: '+IF(IsValidAccountType,pAccountType,'pAccountType INVALID'),NAMED('pAccountType'));
OUTPUT('Start Date: '+IF(IsValidOpenDateStart,pOpenDateStart,'pOpenDateStart INVALID'),NAMED('pOpenDateStart'));
OUTPUT('End Date: '+IF(IsValidOpenDateEnd,pOpenDateEnd,'pOpenDateEnd INVALID'),NAMED('pOpenDateEnd'));
OUTPUT('Duration: '+pOpenDateDurationMonths,NAMED('pOpenDateDurationMonths'));
OUTPUT('Performance Window: '+pPerformanceWindowMonths,NAMED('pPerformanceWindowMonths'));
OUTPUT('Tradeline After Window: '+pTradelineWindowMonthsAfter,NAMED('pTradelineWindowMonthsAfter'));
OUTPUT('Tradeline Prior Window: '+pTradelineWindowMonthsPrior,NAMED('pTradelineWindowMonthsPrior'));

/************************/
/* Declare Build Files	*/
/************************/
kLinkIDs		:=	INDEX(Business_Credit.Key_LinkIds().Key,Business_Credit.Keynames(,pUseOtherEnvironment).LinkIds.QA);
kTradeline	:=	INDEX(Business_Credit.key_tradeline(),Business_Credit.Keynames(,pUseOtherEnvironment).Tradeline.QA);
kBusinessInformation	:=	INDEX(Business_Credit.Key_BusinessInformation(),Business_Credit.Keynames(,pUseOtherEnvironment).BusinessInformation.QA);


/********************/
/* Original Records	*/
/********************/
									
rOriginalLayout	:=	RECORD
	STRING		AccountNumber;
	STRING8		historydate;
	UNSIGNED6	powid;
	UNSIGNED6	proxid;
	UNSIGNED6	seleid;
	UNSIGNED6	orgid;
	UNSIGNED6	ultid;
	STRING30	Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number;
END;
dOriginalRecords	:=	DATASET(pInputFilename,rOriginalLayout,CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')));

OUTPUT(CHOOSEN(SORT(dOriginalRecords,AccountNumber),1000),NAMED('dOriginalRecordsSample'));
OUTPUT(COUNT(dOriginalRecords),NAMED('OriginalRecordsCount'));

/*	Standardize the HistoryDate to an 8 character string.	*/
dOriginalRecordsStandardizedHistoryDate	:=	PROJECT(dOriginalRecords,
																							TRANSFORM(
																								rOriginalLayout,
																								SELF.historydate:=IF(LENGTH(TRIM(LEFT.historydate))=8,LEFT.historydate,LEFT.historydate[1..6]+'01');
																								SELF:=LEFT
																							)
																						);

/****************************************************************/
/* Get SBFE Accounts associated with BIPIDs and Account Numbers	*/
/****************************************************************/
dBIPIDs								:=	dOriginalRecordsStandardizedHistoryDate(ultID>0);
dContributorAccounts	:=	dOriginalRecordsStandardizedHistoryDate(TRIM(Sbfe_Contributor_Number,LEFT,RIGHT)<>'');

rSBFEAccounts	:=	RECORD
	rOriginalLayout;
	STRING3		Account_Type_Reported;
	STRING8		Original_Date_Account_Opened:='';
	BOOLEAN		byContributorAccounts:=FALSE;
END;

dUniqueBIPIDandSBFEAccounts	:=	DEDUP(SORT(DISTRIBUTE(PULL(kLinkIDs)(
																		record_type='AB'
																		AND	account_type_reported IN sAccountType
																		#IF (ut.CleanSpacesAndUpper(pSBFEContributorNumber)	NOT IN	['','ANY'])
																			AND SBFE_Contributor_Number = pSBFEContributorNumber
																		#END
																	),
																	HASH(	#EXPAND(pBIPIDString),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																				#EXPAND(pBIPIDString),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,dt_first_seen,LOCAL),
																				#EXPAND(pBIPIDString),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
/* Accounts by BIPID */
dSBFEBIPAccounts	:=	IF(COUNT(dBIPIDs)>0,
												JOIN(
													DISTRIBUTE(dBIPIDs,HASH(#EXPAND(pBIPIDString))),
													DISTRIBUTE(dUniqueBIPIDandSBFEAccounts,HASH(#EXPAND(pBIPIDString))),
														LEFT.UltID	=	RIGHT.UltID
														#IF (pBIPIDLevelNumber>1)
															AND	LEFT.OrgID	=	RIGHT.OrgID
														#IF (pBIPIDLevelNumber>2)
															AND	LEFT.SeleID	=	RIGHT.SeleID
														#IF (pBIPIDLevelNumber>3)
															AND	LEFT.ProxID	=	RIGHT.ProxID
														#IF (pBIPIDLevelNumber>4)
															AND	LEFT.PowID	=	RIGHT.PowID
														#END	//	OrgID
														#END	//	SeleID
														#END	//	ProxID
														#END	//	PowID
														,
													TRANSFORM(
														rSBFEAccounts,
														SELF.SBFE_Contributor_Number	:=	RIGHT.SBFE_Contributor_Number;
														SELF.Contract_Account_Number	:=	RIGHT.Contract_Account_Number;
														SELF.Account_Type_Reported		:=	RIGHT.Account_Type_Reported;
														SELF													:=	LEFT;
														SELF													:=	RIGHT;
													),
													LEFT OUTER,
													LOCAL
												),
												DATASET([],rSBFEAccounts)
										):PERSIST('~thor_data400::persist::sbfe::dSBFEBIPAccounts');
											
/* Accounts by Contributor Numbers */
dSBFEContributorAccounts	:=	IF(COUNT(dContributorAccounts)>0,
																JOIN(
																	DISTRIBUTE(dContributorAccounts,HASH(SBFE_Contributor_Number,Contract_Account_Number)),
																	DISTRIBUTE(dUniqueBIPIDandSBFEAccounts,HASH(SBFE_Contributor_Number,Contract_Account_Number)),
																				LEFT.SBFE_Contributor_Number	=	RIGHT.SBFE_Contributor_Number
																		AND	LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number
																		,
																	TRANSFORM(
																		rSBFEAccounts,
																		SELF.byContributorAccounts	:=	TRUE;
																		SELF.UltID									:=	RIGHT.UltID;
																		SELF.OrgID									:=	RIGHT.OrgID;
																		SELF.SeleID									:=	RIGHT.SeleID;
																		SELF.ProxID									:=	RIGHT.ProxID;
																		SELF.PowID									:=	RIGHT.PowID;
																		SELF.Account_Type_Reported	:=	RIGHT.Account_Type_Reported;
																		SELF												:=	LEFT;
																		SELF												:=	RIGHT;
																	),
																	LEFT OUTER,
																	LOCAL
																),
																DATASET([],rSBFEAccounts)
															):PERSIST('~thor_data400::persist::sbfe::dSBFEContributorAccounts');

dSBFEAccounts	:=	dSBFEBIPAccounts+dSBFEContributorAccounts;

/**********************************/
/* Set Original Account Open Date	*/
/**********************************/
rOriginalDateAccountOpened	:=	RECORD
	STRING30	Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number;
	STRING3		Account_Type_Reported;
	STRING8		Cycle_End_Date;
	STRING8		Original_Date_Account_Opened;
END;

dOriginalDateAccountOpened	:=	DEDUP(SORT(DISTRIBUTE(
																	PROJECT(PULL(kTradeline)(Date_Account_Opened<>''),
																		TRANSFORM(rOriginalDateAccountOpened,
																			SELF.Original_Date_Account_Opened	:=	LEFT.Date_Account_Opened;
																			SELF	:=	LEFT)),
																	HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																				Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL),
																				Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
																	

/************************************************/
/* Get Tradelines associated with SBFE Accounts */
/************************************************/
dTradelines		:=	JOIN(
										SORT(DISTRIBUTE(PULL(kTradeline
												(
													#IF (ut.CleanSpacesAndUpper(pSBFEContributorNumber)	NOT IN	['','ANY'])
														SBFE_Contributor_Number = pSBFEContributorNumber	AND
													#END
													Account_Type_Reported IN sAccountType
													#IF (pPerformanceWindowMonths>0)
														AND	Cycle_End_Date	>=	date_account_opened
														AND	Cycle_End_Date	<=	ut.Month_Math(date_account_opened,pPerformanceWindow)
													#END
												)
											),
											HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
														Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,date_account_opened,Cycle_End_Date,LOCAL),
										DEDUP(SORT(DISTRIBUTE(dSBFEAccounts(
													UltID>0 
												#IF (pBIPIDLevelNumber>1)
													AND OrgID>0 
												#IF (pBIPIDLevelNumber>2)
													AND SeleID>0
												#IF (pBIPIDLevelNumber>3)
													AND	ProxID>0
												#IF (pBIPIDLevelNumber>4)
													AND	PowID>0
												#END	//	OrgID
												#END	//	SeleID
												#END	//	ProxID
												#END	//	PowID
											),
											HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
														Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,historydate,LOCAL),
														Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
											LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
											LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
											LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported
											#IF (bUseDuration	AND	pOpenDateDurationMonths>0)
												AND	LEFT.date_account_opened	>=	RIGHT.historydate
												AND	LEFT.date_account_opened	<=	ut.Month_Math(RIGHT.historydate,pOpenDateDurationMonths)
											#ELSEIF (~bUseDuration)
												AND	LEFT.date_account_opened	>=	pOpenDateStart
												AND	LEFT.date_account_opened	<=	pOpenDateEnd
											#END
											#IF	(pTradelineWindowMonthsPrior>0	OR	pTradelineWindowMonthsAfter>0)
												#IF	(pTradelineWindowMonthsPrior>0)
													AND	LEFT.Cycle_End_Date						>=	ut.Month_Math(RIGHT.historydate,-pTradelineWindowMonthsPrior)
												#ELSE
													AND	LEFT.Cycle_End_Date						>=	RIGHT.historydate
												#END
												#IF	(pTradelineWindowMonthsAfter>0)
													AND	LEFT.Cycle_End_Date						<=	ut.Month_Math(RIGHT.historydate,pTradelineWindowMonthsAfter)
												#ELSE
													AND	LEFT.Cycle_End_Date						<=	RIGHT.historydate
												#END
											#END
											,
										TRANSFORM(
											RECORDOF(LEFT),
											SELF	:=	LEFT;
										),
										LOCAL
									):PERSIST('~thor_data400::persist::sbfe::dTradelines');
OUTPUT(CHOOSEN(dTradelines,1000),NAMED('dTradelinesSample'));
OUTPUT(COUNT(dTradelines),NAMED('dTradelinesCount'));

/****************************/
/* Put it all back together */
/****************************/

rNewLayout	:=	RECORD
	STRING		AccountNumber;
	UNSIGNED6	UltID;
	UNSIGNED6	OrgID;
	UNSIGNED6	SeleID;
	UNSIGNED6	ProxID;
	UNSIGNED6	PowID;
	STRING30	Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number;
	STRING3		Account_Type_Reported;
	STRING8		historydate;
	STRING8		Original_Date_Account_Opened;
	RECORDOF(kTradeline) AND NOT
		[
			Sbfe_Contributor_Number,
			Contract_Account_Number,
			Account_Type_Reported
		];
END;

dGetOriginalRecords	:=	PROJECT(dOriginalRecords,TRANSFORM(rNewLayout,SELF:=LEFT;SELF:=[]));
OUTPUT(CHOOSEN(SORT(dGetOriginalRecords,accountnumber),1000),NAMED('dGetOriginalRecords'));
dGetSBFEAccounts	:=	JOIN(
												DISTRIBUTE(dGetOriginalRecords,HASH(accountnumber)),
												DISTRIBUTE(dSBFEAccounts,HASH(accountnumber)),
													LEFT.accountnumber	=	RIGHT.accountnumber,
												TRANSFORM(
													RECORDOF(LEFT),
													SELF	:=	RIGHT;
													SELF	:=	LEFT;
													SELF	:=	[];
												),
												LOCAL,
												LEFT OUTER
											);
OUTPUT(CHOOSEN(SORT(dGetSBFEAccounts,accountnumber),1000),NAMED('dGetSBFEAccounts'));
dGetTradelines	:=	JOIN(
											DISTRIBUTE(dTradelines,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
											DISTRIBUTE(dGetSBFEAccounts,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
												LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
												LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
												LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported,
											TRANSFORM(
												RECORDOF(RIGHT),
												SELF.Sbfe_Contributor_Number	:=	RIGHT.Sbfe_Contributor_Number;
												SELF.Contract_Account_Number	:=	RIGHT.Contract_Account_Number;
												SELF.Account_Type_Reported		:=	RIGHT.Account_Type_Reported;
												SELF													:=	LEFT;
												SELF													:=	RIGHT;
											),
											LOCAL,
											RIGHT OUTER
										);
										
dGetOriginalDateAccountOpened	:=	
										JOIN(
											DISTRIBUTE(dOriginalDateAccountOpened,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
											DISTRIBUTE(dGetTradelines,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
												LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
												LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
												LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported
												,
											TRANSFORM(
												RECORDOF(RIGHT),
												SELF.Original_Date_Account_Opened	:=	LEFT.Original_Date_Account_Opened;
												SELF															:=	RIGHT;
											),
											LOCAL,
											RIGHT OUTER
										);
OUTPUT(CHOOSEN(SORT(dGetOriginalDateAccountOpened,accountnumber),4000),NAMED('dGetTradelines'));

dRecordWithTradelines	:=	SORT(DISTRIBUTE(dGetOriginalDateAccountOpened,
														HASH(	sbfe_contributor_number,contract_account_number,account_type_reported,cycle_end_date)),
																	sbfe_contributor_number,contract_account_number,account_type_reported,cycle_end_date,extracted_date,LOCAL);
OUTPUT(CHOOSEN(dRecordWithTradelines,1000),NAMED('dRecordWithTradelinesSample'));
OUTPUT(dRecordWithTradelines,,pOutputFilename,CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);

OUTPUT(TABLE(dRecordWithTradelines,{account_type_reported,COUNT(GROUP)},account_type_reported,FEW),NAMED('AccountTypeTable'));

#IF (pBuildBIIPIIFile)
	/********************/
	/* Get BII and PII	*/
	/********************/
	/*	All Active Records	*/
	dActive			:=	Business_Credit.Files(,pUseOtherEnvironment).Active(active);
	/*	Sort/Distribute our input records	*/
	dActiveDist	:=	SORT(DISTRIBUTE(dActive,
										HASH(	portfolioHeader.Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
													portfolioHeader.Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);

	/*	Prepare all AB Segments for Validation	*/
	rValidateLayout	:=	RECORD
		STRING		AccountNumber									:=	'';
		STRING30	process_date									:=	dActive.process_date;
		STRING30	Sbfe_Contributor_Number				:=	dActive.portfolioHeader.Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number				:=	dActive.Contract_Account_Number;
		STRING3		Account_Type_Reported					:=	dActive.Account_Type_Reported;
		STRING8		Date_Account_Opened						:=	dActive.Date_Account_Opened;
		STRING250	Account_Holder_Business_Name	:=	dActive.Account_Holder_Business_Name;
		STRING8		Cycle_End_Date								:=	dActive.portfolioHeader.Cycle_End_Date;
		STRING8		Extracted_Date								:=	dActive.portfolioHeader.Extracted_Date;
		BOOLEAN		bValidAccountOpenRange				:=	FALSE;
		BOOLEAN		bUniqueAccountOpenDate				:=	FALSE;
		BOOLEAN		bValidAccountOpenCycleEndDate	:=	FALSE;
		BOOLEAN		bValidBusinessName						:=	FALSE;
		BOOLEAN		bValidAddress									:=	FALSE;
	/****************************************************************************************************/
	/*	Requirement Number: 2.1																																					*/
	/*	Requirement: Business Identity / Input Elements																									*/
	/*	If there are multiple addresses reported as of the first cycle date, for example,								*/
	/*	give preference to an address identified as primary.  Else, select the first address reported.	*/
	/*	This approach applies to all identity elements.																									*/
	/****************************************************************************************************/
		Business_Credit.Layouts.AD	address			:=	SORT(dActive.address,-Primary_Address_Indicator)[1];
		Business_Credit.Layouts.PN	phone				:=	SORT(dActive.phone,-Primary_Phone_Indicator)[1];
		Business_Credit.Layouts.TI	taxID				:=	dActive.taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
	/************************************************************************************************/
	/*		001 = Owner																																								*/
	/*		002 = Guarantor																																						*/
	/*		003 = Both Owner and Guarantor																														*/
	/*	Development Comments:																																				*/
	/*	If the person is identified as both the owner and guarantor, then the person should appear	*/
	/*	in both the owner and guarantor section of the return file.																	*/
	/************************************************************************************************/
		DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualOwner			:=	dActive.individualOwner(Guarantor_Owner_Indicator IN ['001','003']);
		DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualGuarantor	:=	dActive.individualOwner(Guarantor_Owner_Indicator IN ['002','003']);
		UNSIGNED6	powid													:=	0;
		UNSIGNED6	proxid												:=	0;
		UNSIGNED6	seleid												:=	0;
		UNSIGNED6	orgid													:=	0;
		UNSIGNED6	ultid													:=	0;
	END;

	dValidateLayout	:=	TABLE(dActiveDist,rValidateLayout):PERSIST('~thor_data400::persist::sbfe::dValidateLayout');
	dGetExtractValidateRecords	:=	JOIN(
																		DISTRIBUTE(dValidateLayout,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,extracted_date,Cycle_End_Date,process_date)),
																		DISTRIBUTE(dRecordWithTradelines,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,extracted_date,Cycle_End_Date,process_date)),
																			LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
																			LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
																			LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
																			LEFT.extracted_date						=	RIGHT.extracted_date					AND
																			LEFT.Cycle_End_Date						=	RIGHT.Cycle_End_Date					AND
																			LEFT.process_date							=	RIGHT.process_date,
																		TRANSFORM(
																			RECORDOF(LEFT),
																			SELF.AccountNumber	:=	RIGHT.AccountNumber;
																			SELF.powid					:=	RIGHT.powid;
																			SELF.proxid					:=	RIGHT.proxid;
																			SELF.seleid					:=	RIGHT.seleid;
																			SELF.orgid					:=	RIGHT.orgid;
																			SELF.ultid					:=	RIGHT.ultid;
																			SELF								:=	LEFT;
																		),
																		LOCAL
																	);

	/* Requirement Number: 1.2	*/
	/* Requirement:  Account selection criteria	*/
	RECORDOF(dGetExtractValidateRecords)	tValidateLayout(dGetExtractValidateRecords	l,	DATASET(RECORDOF(dGetExtractValidateRecords)) allRows)	:=	TRANSFORM
	/******************************************************************************************/
	/*	Requirement Number: 3.2																																*/
	/*	From the first cycle date reported for each account selected in Req. 1.2,							*/
	/*	please create a CSV file that contains (2) years of trade line data for each account.	*/
	/******************************************************************************************/
		SELF.Cycle_End_Date									:=	MIN(allRows,allRows.Cycle_End_Date);
		
		SELF.bValidAccountOpenRange					:=	IF(ut.ValidDate(pOpenDateStart) AND ut.ValidDate(pOpenDateEnd),
																							MIN(allRows,allRows.Date_Account_Opened)	>=	pOpenDateStart	AND
																							MAX(allRows,allRows.Date_Account_Opened)	<=	pOpenDateEnd,
																							TRUE
																						);
	/*	1.	Accounts with no business name or address populated as of the first cycle date.	*/
		SELF.bValidBusinessName							:=	TRIM(l.Account_Holder_Business_Name,LEFT,RIGHT)<>'';
		SELF.bValidAddress									:=	l.address.Segment_Identifier='AD';
	/*	2.	Accounts with more than one account open date.	*/
		SELF.bUniqueAccountOpenDate					:=	COUNT(DEDUP(SORT(allRows,Date_Account_Opened),Date_Account_Opened))=1;
	/*	3.	Accounts with an account open date that occurs after the first cycle date reported for the account.	*/
	/*	4.	Accounts where the account open date occurs more than 18 months prior to the first cycle date.	*/
		SELF.bValidAccountOpenCycleEndDate	:=	MIN(allRows,allRows.Date_Account_Opened) < l.Cycle_End_Date	AND
																						ut.DaysApart(MIN(allRows,allRows.Date_Account_Opened),l.Cycle_End_Date)<549;
		SELF																:=	l;
	END;

	dValidateRecords	:=	ROLLUP(
													GROUP(SORT(DISTRIBUTE(dGetExtractValidateRecords,
														HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL),
																	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
													GROUP,
													tValidateLayout(LEFT,ROWS(LEFT))
												);

	dValidRecords	:=	dValidateRecords(
																			bValidAccountOpenRange	AND
																			bValidBusinessName			AND
																			bValidAddress						AND
																			bUniqueAccountOpenDate	AND
																			bValidAccountOpenCycleEndDate
																		);
																		
	/*	Requirement 1.2	*/
	OUTPUT(COUNT(dValidRecords),NAMED('Account_Selection_Criteria_Count'));
	OUTPUT(CHOOSEN(dValidRecords,1000),NAMED('Account_Selection_Criteria_Sample'));

	/* Requirement Number: 3.1	*/
	/* Requirement:  Input / Header File	*/
	rPreExtractDataLayout	:=	RECORD
		STRING		AccountNumber;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING8		Date_Account_Opened;
		UNSIGNED6	UltID;
		UNSIGNED6	OrgID;
		UNSIGNED6	SELEID;
		UNSIGNED6	ProxID;
		UNSIGNED6	POWID;
		STRING250	Business_Name;
		STRING		Business_Street_Address;
		STRING50	Business_City;
		STRING2		Business_State;
		STRING6		Business_Zip_Code;
		STRING10	Business_Phone;
		STRING9		Business_FEIN;
		UNSIGNED6	Owner_LexID;
		STRING20	Owner_First_Name;
		STRING20	Owner_Last_Name;
		STRING		Owner_Street_Address;
		STRING50	Owner_City;
		STRING2		Owner_State;
		STRING6		Owner_Zip_Code;
		STRING10	Owner_Phone;
		STRING9		Owner_SSN;
		UNSIGNED6	Guarantor_LexID;
		STRING20	Guarantor_First_Name;
		STRING20	Guarantor_Last_Name;
		STRING		Guarantor_Street_Address;
		STRING50	Guarantor_City;
		STRING2		Guarantor_State;
		STRING6		Guarantor_Zip_Code;
		STRING10	Guarantor_Phone;
		STRING9		Guarantor_SSN;
		
		DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualOwner;
		DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualGuarantor;
	END;
													
	dValidRecordsDist	:=	SORT(DISTRIBUTE(dValidRecords,
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																address.Address_Line_1,address.Address_Line_2,address.City,address.State,address.Zip_Code_or_CA_Postal_Code,
																phone.Area_Code,phone.Phone_Number,TaxID.Federal_TaxID_SSN)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																address.Address_Line_1,address.Address_Line_2,address.City,address.State,address.Zip_Code_or_CA_Postal_Code,
																phone.Area_Code,phone.Phone_Number,TaxID.Federal_TaxID_SSN,LOCAL);
													
	dBIPLinkIDsDist		:=	SORT(DISTRIBUTE(kBusinessInformation(record_type='AB'),
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																Original_Address_Line_1,Original_Address_Line_2,Original_City,Original_State,Original_Zip_Code_or_CA_Postal_Code,
																Original_Area_Code,Original_Phone_Number,Federal_TaxID_SSN)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																Original_Address_Line_1,Original_Address_Line_2,Original_City,Original_State,Original_Zip_Code_or_CA_Postal_Code,
																Original_Area_Code,Original_Phone_Number,Federal_TaxID_SSN,LOCAL);

	rPreExtractDataLayout	tGetBIPIds(dValidRecordsDist	l,	dBIPLinkIDsDist	r)	:=	TRANSFORM
	/* Requirement Number: 2.1	*/
		SELF.AccountNumber						:=	l.AccountNumber;
		SELF.Sbfe_Contributor_Number	:=	IF(r.Sbfe_Contributor_Number<>'',r.Sbfe_Contributor_Number,l.Sbfe_Contributor_Number);
		SELF.Contract_Account_Number	:=	IF(r.Contract_Account_Number<>'',r.Contract_Account_Number,l.Contract_Account_Number);
		SELF.Account_Type_Reported		:=	IF(r.Account_Type_Reported<>'',r.Account_Type_Reported,l.Account_Type_Reported);
		SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
		SELF.UltID										:=	r.UltID;
		SELF.OrgID										:=	r.OrgID;
		SELF.SELEID										:=	r.SELEID;
		SELF.ProxID										:=	r.ProxID;
		SELF.POWID										:=	r.POWID;
		SELF.Business_Name						:=	IF(r.Clean_Account_Holder_Business_Name<>'',r.Clean_Account_Holder_Business_Name,l.Account_Holder_Business_Name);
		SELF.Business_Street_Address	:=	IF(r.Sbfe_Contributor_Number<>'',
																				Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																				l.address.Address_Line_1+l.address.Address_Line_2);
		SELF.Business_City						:=	IF(r.v_city_name<>'',r.v_city_name,l.address.City);
		SELF.Business_State						:=	IF(r.st<>'',r.st,l.address.State);
		SELF.Business_Zip_Code				:=	IF(r.zip<>'',r.zip,l.address.Zip_Code_or_CA_Postal_Code);
		SELF.Business_Phone						:=	IF(r.Phone_Number<>'',r.Phone_Number,TRIM(l.phone.Area_Code+l.phone.Phone_Number,LEFT,RIGHT));
		SELF.Business_FEIN						:=	IF(r.Federal_TaxID_SSN<>'',r.Federal_TaxID_SSN,l.TaxID.Federal_TaxID_SSN);

		SELF.individualOwner					:=	l.individualOwner;
		SELF.individualGuarantor			:=	l.individualGuarantor;
		SELF													:=	[];
	END;

	dGetBIPIds	:=	JOIN(
										dValidRecordsDist,
										dBIPLinkIDsDist,
											LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
											LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
											LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
											LEFT.address.Address_Line_1		=	RIGHT.Original_Address_Line_1	AND
											LEFT.address.Address_Line_2		=	RIGHT.Original_Address_Line_2	AND
											LEFT.address.City							=	RIGHT.Original_City						AND
											LEFT.address.State						=	RIGHT.Original_State					AND
											LEFT.address.Zip_Code_or_CA_Postal_Code	=	RIGHT.Original_Zip_Code_or_CA_Postal_Code	AND
											LEFT.phone.Area_Code					=	RIGHT.Original_Area_Code			AND
											LEFT.phone.Phone_Number				=	RIGHT.Original_Phone_Number		AND
											LEFT.TaxID.Federal_TaxID_SSN	=	RIGHT.Federal_TaxID_SSN,
										tGetBIPIds(LEFT,RIGHT),
										LEFT OUTER,
										KEEP(1),
										LOCAL
									);

	/* Requirement 1.2	*/
	OUTPUT(COUNT(DEDUP(SORT(DISTRIBUTE(dGetBIPIds,HASH(SELEID)),SELEID,LOCAL),SELEID,LOCAL)),NAMED('Unique_SeleID_Count'));

	/* Requirement Number: 2.2	*/
	/* Requirement:  Owner Selection	*/
	rPreExtractDataLayout	tGetIndividual(rPreExtractDataLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		SELF.Owner_First_Name			:=	L.individualOwner[cnt].Original_fname;
		SELF.Owner_Last_Name			:=	L.individualOwner[cnt].Original_lname;
		addr											:=	SORT(L.individualOwner[cnt].address,-Primary_Address_Indicator)[1];
		phone											:=	SORT(L.individualOwner[cnt].phone,-Primary_Phone_Indicator)[1];
		taxID											:=	L.individualOwner[cnt].taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
		SELF.Owner_Street_Address	:=	TRIM(addr.Address_Line_1+addr.Address_Line_2,LEFT,RIGHT);
		SELF.Owner_City						:=	addr.City;
		SELF.Owner_State					:=	addr.State;
		SELF.Owner_Zip_Code				:=	addr.Zip_Code_or_CA_Postal_Code;
		SELF.Owner_Phone					:=	phone.Area_Code+phone.Phone_Number;
		SELF.Owner_SSN						:=	taxID.Federal_TaxID_SSN;
		SELF.individualOwner			:=	[];
		SELF.individualGuarantor	:=	[];
		SELF											:=	L;
		SELF											:=	[];
	END;
	dIndividual	:=	NORMALIZE(dGetBIPIds(COUNT(individualOwner)>0),COUNT(LEFT.individualOwner),tGetIndividual(LEFT,COUNTER));

	dIndividualDist	:=	SORT(DISTRIBUTE(dIndividual,
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
																Owner_First_Name,Owner_Last_Name)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
																Owner_First_Name,Owner_Last_Name,LOCAL);

	OUTPUT(CHOOSEN(dIndividualDist,1000),NAMED('dIndividualDist'));
													
	dLexIDDist			:=	SORT(DISTRIBUTE(kBusinessInformation(record_type='IS'),
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Clean_Account_Holder_Business_Name,
																original_fname,original_lname)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Clean_Account_Holder_Business_Name,
	/* Requirement Number: 2.2	*/
	/* Requirement:  Owner Selection	*/
	/* 2.	Give preference to owners with a LexID populated.	*/
																original_fname,original_lname,-did,LOCAL);

	rPreExtractDataLayout	tGetIndividualOwnerIds(dIndividualDist	l,	dLexIDDist	r)	:=	TRANSFORM
	/* Requirement Number: 2.3	*/
	/* Requirement:  Owner Identity / Input Elements	*/
		SELF.AccountNumber						:=	l.AccountNumber;
		SELF.Sbfe_Contributor_Number	:=	l.Sbfe_Contributor_Number;
		SELF.Contract_Account_Number	:=	l.Contract_Account_Number;
		SELF.Account_Type_Reported		:=	l.Account_Type_Reported;
		SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
		SELF.UltID										:=	l.UltID;
		SELF.OrgID										:=	l.OrgID;
		SELF.SELEID										:=	l.SELEID;
		SELF.ProxID										:=	l.ProxID;
		SELF.POWID										:=	l.POWID;
		SELF.Business_Name						:=	l.Business_Name;
		SELF.Business_Street_Address	:=	l.Business_Street_Address;
		SELF.Business_City						:=	l.Business_City;
		SELF.Business_State						:=	l.Business_State;
		SELF.Business_Zip_Code				:=	l.Business_Zip_Code;
		SELF.Business_Phone						:=	l.Business_Phone;
		SELF.Business_FEIN						:=	l.Business_FEIN;
		
		SELF.Owner_LexID							:=	r.did;
		SELF.Owner_First_Name					:=	IF(r.clean_fname<>'',r.clean_fname,l.Owner_First_Name);
		SELF.Owner_Last_Name					:=	IF(r.clean_lname<>'',r.clean_lname,l.Owner_Last_Name);
		SELF.Owner_Street_Address			:=	IF(r.did>0,
																				Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																				l.Owner_Street_Address);
		SELF.Owner_City								:=	IF(r.did>0,r.v_city_name,l.Owner_City);
		SELF.Owner_State							:=	IF(r.did>0,r.st,l.Owner_State);
		SELF.Owner_Zip_Code						:=	IF(r.did>0,r.zip,l.Owner_Zip_Code);
		SELF.Owner_Phone							:=	IF(r.did>0,r.Phone_Number,l.Owner_Phone);
		SELF.Owner_SSN								:=	IF(r.did>0,r.Federal_TaxID_SSN,l.Owner_SSN);

		SELF													:=	[];
	END;

	dGetIndividualOwnerIds	:=	JOIN(
																dIndividualDist,
																dLexIDDist,
																	LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
																	LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
																	LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
																	LEFT.UltID										=	RIGHT.UltID										AND
																	LEFT.OrgID										=	RIGHT.OrgID										AND
																	LEFT.SELEID										=	RIGHT.SELEID									AND
																	LEFT.ProxID										=	RIGHT.ProxID									AND
																	LEFT.POWID										=	RIGHT.POWID										AND
																	LEFT.Business_Name						=	RIGHT.Clean_Account_Holder_Business_Name	AND
																	LEFT.Owner_First_Name					=	RIGHT.original_fname					AND
																	LEFT.Owner_Last_Name					=	RIGHT.original_lname,
																tGetIndividualOwnerIds(LEFT,RIGHT),
																LEFT OUTER,
																LOCAL
															);

	/* Requirement Number: 2.4	*/
	/* Requirement:  Guarantor Selection	*/

	rPreExtractDataLayout	tGetGuarantor(rPreExtractDataLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		SELF.Guarantor_First_Name			:=	L.individualGuarantor[cnt].Original_fname;
		SELF.Guarantor_Last_Name			:=	L.individualGuarantor[cnt].Original_lname;
		addr													:=	SORT(L.individualGuarantor[cnt].address,-Primary_Address_Indicator)[1];
		phone													:=	SORT(L.individualGuarantor[cnt].phone,-Primary_Phone_Indicator)[1];
		taxID													:=	L.individualGuarantor[cnt].taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
		SELF.Guarantor_Street_Address	:=	TRIM(addr.Address_Line_1+addr.Address_Line_2,LEFT,RIGHT);
		SELF.Guarantor_City						:=	addr.City;
		SELF.Guarantor_State					:=	addr.State;
		SELF.Guarantor_Zip_Code				:=	addr.Zip_Code_or_CA_Postal_Code;
		SELF.Guarantor_Phone					:=	phone.Area_Code+phone.Phone_Number;
		SELF.Guarantor_SSN						:=	taxID.Federal_TaxID_SSN;
		SELF.individualOwner					:=	[];
		SELF.individualGuarantor			:=	[];
		SELF													:=	L;
		SELF													:=	[];
	END;

	dGuarantor	:=	NORMALIZE(dGetBIPIds(COUNT(individualGuarantor)>0),COUNT(LEFT.individualGuarantor),tGetGuarantor(LEFT,COUNTER));
	dGuarantorDist	:=	SORT(DISTRIBUTE(dGuarantor,
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
																Guarantor_First_Name,Guarantor_Last_Name)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
																UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
																Guarantor_First_Name,Guarantor_Last_Name,LOCAL);
	OUTPUT(CHOOSEN(dGuarantorDist,1000),NAMED('dGuarantorDist'));
													
	rPreExtractDataLayout	tGetIndividualGuarantorIds(dGuarantorDist	l,	dLexIDDist	r)	:=	TRANSFORM
	/* Requirement Number: 2.5	*/
	/* Requirement:  Guarantor Identity / Input Elements	*/
		SELF.AccountNumber						:=	l.AccountNumber;
		SELF.Sbfe_Contributor_Number	:=	l.Sbfe_Contributor_Number;
		SELF.Contract_Account_Number	:=	l.Contract_Account_Number;
		SELF.Account_Type_Reported		:=	l.Account_Type_Reported;
		SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
		SELF.UltID										:=	l.UltID;
		SELF.OrgID										:=	l.OrgID;
		SELF.SELEID										:=	l.SELEID;
		SELF.ProxID										:=	l.ProxID;
		SELF.POWID										:=	l.POWID;
		SELF.Business_Name						:=	l.Business_Name;
		SELF.Business_Street_Address	:=	l.Business_Street_Address;
		SELF.Business_City						:=	l.Business_City;
		SELF.Business_State						:=	l.Business_State;
		SELF.Business_Zip_Code				:=	l.Business_Zip_Code;
		SELF.Business_Phone						:=	l.Business_Phone;
		SELF.Business_FEIN						:=	l.Business_FEIN;
		
		SELF.Guarantor_LexID					:=	r.did;
		SELF.Guarantor_First_Name			:=	IF(r.clean_fname<>'',r.clean_fname,l.Guarantor_First_Name);
		SELF.Guarantor_Last_Name			:=	IF(r.clean_lname<>'',r.clean_lname,l.Guarantor_Last_Name);
		SELF.Guarantor_Street_Address	:=	IF(r.did>0,
																				Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																				l.Guarantor_Street_Address);
		SELF.Guarantor_City						:=	IF(r.did>0,r.v_city_name,l.Guarantor_City);
		SELF.Guarantor_State					:=	IF(r.did>0,r.st,l.Guarantor_State);
		SELF.Guarantor_Zip_Code				:=	IF(r.did>0,r.zip,l.Guarantor_Zip_Code);
		SELF.Guarantor_Phone					:=	IF(r.did>0,r.Phone_Number,l.Guarantor_Phone);
		SELF.Guarantor_SSN						:=	IF(r.did>0,r.Federal_TaxID_SSN,l.Guarantor_SSN);

		SELF													:=	[];
	END;

	dGetGuarantorOwnerIds	:=	JOIN(
																dGuarantorDist,
																dLexIDDist,
																	LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
																	LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
																	LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
																	LEFT.UltID										=	RIGHT.UltID										AND
																	LEFT.OrgID										=	RIGHT.OrgID										AND
																	LEFT.SELEID										=	RIGHT.SELEID									AND
																	LEFT.ProxID										=	RIGHT.ProxID									AND
																	LEFT.POWID										=	RIGHT.POWID										AND
																	LEFT.Business_Name						=	RIGHT.Clean_Account_Holder_Business_Name	AND
																	LEFT.Guarantor_First_Name			=	RIGHT.original_fname					AND
																	LEFT.Guarantor_Last_Name			=	RIGHT.original_lname,
																tGetIndividualGuarantorIds(LEFT,RIGHT),
																LEFT OUTER,
																LOCAL
															);

	rPreExtractDataLayout	tRollupIds(rPreExtractDataLayout	L,	rPreExtractDataLayout	R)	:=	TRANSFORM
		SELF.AccountNumber						:=	l.AccountNumber;
		SELF.Sbfe_Contributor_Number	:=	L.Sbfe_Contributor_Number;
		SELF.Contract_Account_Number	:=	L.Contract_Account_Number;
		SELF.Account_Type_Reported		:=	L.Account_Type_Reported;
		SELF.Date_Account_Opened			:=	L.Date_Account_Opened;
		SELF.UltID										:=	L.UltID;
		SELF.OrgID										:=	L.OrgID;
		SELF.SELEID										:=	L.SELEID;
		SELF.ProxID										:=	L.ProxID;
		SELF.POWID										:=	L.POWID;
		SELF.Business_Name						:=	L.Business_Name;
		SELF.Business_Street_Address	:=	L.Business_Street_Address;
		SELF.Business_City						:=	L.Business_City;
		SELF.Business_State						:=	L.Business_State;
		SELF.Business_Zip_Code				:=	L.Business_Zip_Code;
		SELF.Business_Phone						:=	L.Business_Phone;
		SELF.Business_FEIN						:=	L.Business_FEIN;
		SELF.Owner_LexID							:=	IF(L.Owner_LexID>0,L.Owner_LexID,R.Owner_LexID);
		SELF.Owner_First_Name					:=	IF(L.Owner_LexID>0,L.Owner_First_Name,R.Owner_First_Name);
		SELF.Owner_Last_Name					:=	IF(L.Owner_LexID>0,L.Owner_Last_Name,R.Owner_Last_Name);
		SELF.Owner_Street_Address			:=	IF(L.Owner_LexID>0,L.Owner_Street_Address,R.Owner_Street_Address);
		SELF.Owner_City								:=	IF(L.Owner_LexID>0,L.Owner_City,R.Owner_City);
		SELF.Owner_State							:=	IF(L.Owner_LexID>0,L.Owner_State,R.Owner_State);
		SELF.Owner_Zip_Code						:=	IF(L.Owner_LexID>0,L.Owner_Zip_Code,R.Owner_Zip_Code);
		SELF.Owner_Phone							:=	IF(L.Owner_LexID>0,L.Owner_Phone,R.Owner_Phone);
		SELF.Owner_SSN								:=	IF(L.Owner_LexID>0,L.Owner_SSN,R.Owner_SSN);
		SELF.Guarantor_LexID					:=	IF(L.Guarantor_LexID>0,L.Guarantor_LexID,R.Guarantor_LexID);
		SELF.Guarantor_First_Name			:=	IF(L.Guarantor_LexID>0,L.Guarantor_First_Name,R.Guarantor_First_Name);
		SELF.Guarantor_Last_Name			:=	IF(L.Guarantor_LexID>0,L.Guarantor_Last_Name,R.Guarantor_Last_Name);
		SELF.Guarantor_Street_Address	:=	IF(L.Guarantor_LexID>0,L.Guarantor_Street_Address,R.Guarantor_Street_Address);
		SELF.Guarantor_City						:=	IF(L.Guarantor_LexID>0,L.Guarantor_City,R.Guarantor_City);
		SELF.Guarantor_State					:=	IF(L.Guarantor_LexID>0,L.Guarantor_State,R.Guarantor_State);
		SELF.Guarantor_Zip_Code				:=	IF(L.Guarantor_LexID>0,L.Guarantor_Zip_Code,R.Guarantor_Zip_Code);
		SELF.Guarantor_Phone					:=	IF(L.Guarantor_LexID>0,L.Guarantor_Phone,R.Guarantor_Phone);
		SELF.Guarantor_SSN						:=	IF(L.Guarantor_LexID>0,L.Guarantor_SSN,R.Guarantor_SSN);
		SELF.individualOwner					:=	[];
		SELF.individualGuarantor			:=	[];
		SELF													:=	[];
	END;
												
	dIdsDist	:=	SORT(DISTRIBUTE(dGetBIPIds+dGetIndividualOwnerIds+dGetGuarantorOwnerIds,
									HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
												UltID,OrgID,SELEID,ProxID,POWID,Business_Name)),
												Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
												UltID,OrgID,SELEID,ProxID,POWID,Business_Name,-Owner_LexID,-Guarantor_LexID,LOCAL);

	dRollupIds	:=	ROLLUP(	dIdsDist,
														LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
														LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
														LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
														LEFT.UltID										=	RIGHT.UltID										AND
														LEFT.OrgID										=	RIGHT.OrgID										AND
														LEFT.SELEID										=	RIGHT.SELEID									AND
														LEFT.ProxID										=	RIGHT.ProxID									AND
														LEFT.POWID										=	RIGHT.POWID										AND
														LEFT.Business_Name						=	RIGHT.Business_Name,
													tRollupIds(LEFT,RIGHT),
													LOCAL
												);
												
	OUTPUT(COUNT(dRollupIds),NAMED('Rollup_Sample_Count'));
	OUTPUT(CHOOSEN(dRollupIds,1000),NAMED('Rollup_Sample'));

	/* Requirement Number: 3.1	*/
	/* Requirement:  Input / Header File	*/
	rExtractDataLayout	:=	RECORD
		rPreExtractDataLayout	AND NOT
		[
			individualOwner,
			individualGuarantor
		];
	END;

	dBIIPIIExtractData			:=	PROJECT(dRollupIds,TRANSFORM(RECORDOF(rExtractDataLayout),SELF:=LEFT));
	dBIIPIIExtractDataSort	:=	SORT(DISTRIBUTE(dBIIPIIExtractData,HASH(AccountNumber,Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),AccountNumber,Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
	OUTPUT(dBIIPIIExtractDataSort,,pBIIPIIOutputFilename,CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);
#END	//	(pBuildBIIPIIFile)
