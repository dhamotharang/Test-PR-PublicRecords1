﻿#OPTION('multiplePersistInstances',FALSE);
#workunit('name', 'SBFE_Tradeline_Processing_Script');
IMPORT	ut, STD,	Address, Business_Credit, data_services;
/**********************************************************************************************************/
// -- pFilename -	Original Raw Filename.  The file is expected to be sprayed to THOR with a 
//								name of '~thor::in::sbfe::'+pFilename
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
// -- pUseOtherEnvironment	-	Allows the user to run from Dataland and still point to Prod input files and Keys
// -- pEyeball							- Specifies the number of records that will be displayed by output statements. Has no effect on the number
//												  records processed and output in the final CSV file.
/**********************************************************************************************************/
/******************************* DEFAULT VALUES ***********************************************************/
// pFilename								:=	'';
// pSBFEContributorNumber		:=	'ANY';
// pAccountType							:=	'ANY';
// pOpenDateStart						:=	'';
// pOpenDateEnd							:=	'';
// pOpenDateDurationMonths	:=	0;
// pPerformanceWindowMonths	:=	0;
// pTradelineWindowMonthsAfter	:=	0;
// pTradelineWindowMonthsPrior	:=	0;
// pUseOtherEnvironment			:=	FALSE;
// pEyeball									:= 100;
/**********************************************************************************************************/
pFilename									:=	'blptemp::blptemp_jpmc_test_fewrecords.csv'; // This file can have history dates in YYYYMMDD or YYYYMM format.
pSBFEContributorNumber		:=	'ANY';
pAccountType							:=	'ANY';
pOpenDateStart						:=	'';
pOpenDateEnd							:=	'';
pOpenDateDurationMonths		:=	0;
pPerformanceWindowMonths	:=	0;
pTradelineWindowMonthsAfter	:=	0;
pTradelineWindowMonthsPrior	:=	13;
pUseOtherEnvironment			:=	FALSE;
pEyeball										:= 100;
/**********************************************************************************************************/

/************************/
/* Set Build Parameters	*/
/************************/

pBIPIDString	:=	'UltID'+ ',OrgID' + ',SeleID';
									
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
										IF(ut.CleanSpacesAndUpper(pSBFEContributorNumber)	NOT IN	['','ANY'],'C','X')+
										IF(ut.CleanSpacesAndUpper(pAccountType)	NOT IN	['','ANY'],'A','X')+
										IF(~bUseDuration,'O',IF(bUseDuration AND pOpenDateDurationMonths>0,'D','X'))+
										IF(pPerformanceWindowMonths>0,'P','X')+
										IF(pTradelineWindowMonthsAfter<>0,'Ta','Xa')+
										IF(pTradelineWindowMonthsPrior<>0,'Tp','Xp');

pInputFilename	:=	'~'+pFilename;
pOutputFilename	:=	'~'+pFilename+pFilenameSuffix;

/************************/
/* Declare Build Files	*/
/************************/
kLinkIDs		:=	INDEX(Business_Credit.Key_LinkIds().Key,Business_Credit.Keynames(,pUseOtherEnvironment).LinkIds.QA);
kTradeline	:=	INDEX(Business_Credit.key_tradeline(),Business_Credit.Keynames(,pUseOtherEnvironment).Tradeline.QA);
																				
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
dOriginalRecords	:= DATASET(pInputFilename,rOriginalLayout,CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')));

OUTPUT(CHOOSEN(SORT(dOriginalRecords,AccountNumber),pEyeball),NAMED('dOriginalRecordsSample'));
OUTPUT(COUNT(dOriginalRecords),NAMED('OriginalRecordsCount'));

 /*	Standardize the HistoryDate to an 8 character string.	*/
dOriginalRecordsStandardizedHistoryDate	:=	PROJECT(dOriginalRecords,
																							TRANSFORM(
																								rOriginalLayout,
																								SELF.historydate:=IF(LENGTH(TRIM(LEFT.historydate))=8,LEFT.historydate,LEFT.historydate[1..6]+'01');
																								SELF:=LEFT
																							)
																						);

OUTPUT(CHOOSEN(dOriginalRecordsStandardizedHistoryDate, pEyeball), NAMED('dOriginalRecordsStandardizedHistoryDate'));
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

dUniqueBIPIDandSBFEAccounts	:=	SORT(DISTRIBUTE(PULL(kLinkIDs)(
																		account_type_reported IN sAccountType
																		#IF (ut.CleanSpacesAndUpper(pSBFEContributorNumber)	NOT IN	['','ANY'])
																			AND SBFE_Contributor_Number = pSBFEContributorNumber
																		#END
																	),
																	HASH(	#EXPAND(pBIPIDString),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																				#EXPAND(pBIPIDString),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,dt_first_seen,LOCAL);
/* Accounts by BIPID */
dSBFEBIPAccounts	:=	IF(COUNT(dBIPIDs)>0,
												JOIN(
													DISTRIBUTE(dBIPIDs,HASH(#EXPAND(pBIPIDString))),
													DISTRIBUTE(dUniqueBIPIDandSBFEAccounts,HASH(#EXPAND(pBIPIDString))),
														LEFT.UltID	=	RIGHT.UltID
														AND	LEFT.OrgID	=	RIGHT.OrgID
														AND	LEFT.SeleID	=	RIGHT.SeleID
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
										);
											
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
															);

dSBFEAccounts :=	dSBFEBIPAccounts+dSBFEContributorAccounts;

OUTPUT(CHOOSEN(dSBFEAccounts, pEyeball), NAMED('dSBFEAccounts'));
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

dOriginalDateAccountOpened	:=	SORT(DISTRIBUTE(
																	PROJECT(PULL(kTradeline)(Date_Account_Opened<>''),
																		TRANSFORM(rOriginalDateAccountOpened,
																			SELF.Original_Date_Account_Opened	:=	LEFT.Date_Account_Opened;
																			SELF	:=	LEFT)),
																	HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																				Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL);
																	

OUTPUT(CHOOSEN(dOriginalDateAccountOpened, pEyeball), NAMED('dOriginalDateAccountOpened'));
// /************************************************/
// /* Get Tradelines associated with SBFE Accounts */
// /************************************************/

tempTradeline := record
STRING		AccountNumber;
RECORDOF(kTradeline);
STRING historydate;
END;

dTradelines		:=	JOIN(SORT(DISTRIBUTE(PULL(kTradeline
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
												Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,date_account_opened,Cycle_End_Date ,LOCAL),
												SORT(DISTRIBUTE(dSBFEAccounts(
													UltID>0 
													AND OrgID>0 
													AND SeleID>0
												), 
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
												Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,historydate, LOCAL),
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
													AND	LEFT.Cycle_End_Date						>=    IF (RIGHT.historydate[5..6] = '02' AND pTradelineWindowMonthsPrior = 13, (STRING8)(((INTEGER)ut.Month_Math(RIGHT.historydate,-pTradelineWindowMonthsPrior)[1..4]) + 1) + '0101', ut.Month_Math(RIGHT.historydate,-pTradelineWindowMonthsPrior))
												#ELSE
													AND	LEFT.Cycle_End_Date						>=	RIGHT.historydate
												#END
												#IF	(pTradelineWindowMonthsAfter>0)
													AND	LEFT.Cycle_End_Date						<=	ut.Month_Math(RIGHT.historydate,pTradelineWindowMonthsAfter)
												#ELSE
													AND	LEFT.Cycle_End_Date						<	RIGHT.historydate
												#END
											#END
											,
											TRANSFORM(
											tempTradeline,
											SELF.AccountNumber := RIGHT.AccountNumber,
											SELF.historydate := RIGHT.historydate,
											SELF	:=	LEFT;
										)
												);
OUTPUT(CHOOSEN(dTradelines,pEyeball),NAMED('dTradelinesSample'));
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
OUTPUT(CHOOSEN(SORT(dGetOriginalRecords,accountnumber),pEyeball),NAMED('dGetOriginalRecords'));
dGetSBFEAccounts	:=	JOIN(
												DISTRIBUTE(dGetOriginalRecords,HASH(accountnumber)),
												DISTRIBUTE(dSBFEAccounts,HASH(accountnumber)),
													LEFT.accountnumber	=	RIGHT.accountnumber AND
													LEFT.historydate[1..6] = RIGHT.historydate[1..6],
												TRANSFORM(
													RECORDOF(LEFT),
													SELF	:=	RIGHT;
													SELF	:=	LEFT;
													SELF	:=	[];
												),
												LOCAL,
												LEFT OUTER
											);
OUTPUT(CHOOSEN(SORT(dGetSBFEAccounts,accountnumber),pEyeball),NAMED('dGetSBFEAccounts'));
dGetTradelines	:=	JOIN(
											DISTRIBUTE(dTradelines,HASH(AccountNumber, Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
											DISTRIBUTE(dGetSBFEAccounts,HASH(AccountNumber, Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
												LEFT.AccountNumber						=		RIGHT.AccountNumber AND
												LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
												LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
												LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported,
											TRANSFORM(
												RECORDOF(RIGHT),
												SELF.AccountNumber						:= RIGHT.AccountNumber;
												SELF.Sbfe_Contributor_Number	:=	RIGHT.Sbfe_Contributor_Number;
												SELF.Contract_Account_Number	:=	RIGHT.Contract_Account_Number;
												SELF.Account_Type_Reported		:=	RIGHT.Account_Type_Reported;
												SELF													:=	LEFT;
												SELF													:=	RIGHT;
											),
											LOCAL,
											RIGHT OUTER
										)(Cycle_End_Date <> '');
										
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
OUTPUT(CHOOSEN(SORT(dGetOriginalDateAccountOpened,accountnumber),pEyeball),NAMED('dGetTradelines'));

dRecordWithTradelines	:=	SORT(DISTRIBUTE(dGetOriginalDateAccountOpened,
														HASH(	sbfe_contributor_number,contract_account_number,account_type_reported,cycle_end_date)),
																	sbfe_contributor_number,contract_account_number,account_type_reported,cycle_end_date,extracted_date,LOCAL);
																	
TradelineTempDatesLayout := RECORD
STRING oldcycledate;
RECORDOF(dRecordWithTradelines);
END;

TradelineTempDatesLayout getOldCycleDates(dRecordWithTradelines le) := TRANSFORM
	SELF.oldcycledate := le.cycle_end_date;
	SELF.cycle_end_date := le.cycle_end_date[1..6];
	SELF := le;
END;

TradelinesTruncatedHistoryDates	:=	PROJECT(dRecordWithTradelines, getOldCycleDates(LEFT));
																	
dedupRecordWithTradelines := DEDUP(SORT(TradelinesTruncatedHistoryDates, AccountNumber, SBFE_Contributor_Number, Contract_account_number, account_type_reported, cycle_end_date), AccountNumber, SBFE_Contributor_Number, Contract_Account_Number, account_type_reported, cycle_end_date);

FinalRecordWithTradelines := PROJECT(dedupRecordWithTradelines,
																							TRANSFORM(
																								RECORDOF(dRecordWithTradelines),
																								SELF.cycle_end_date:=LEFT.oldcycledate;
																								SELF:=LEFT
																							)
																						);

OUTPUT(CHOOSEN(FinalRecordWithTradelines,pEyeball),NAMED('dRecordWithTradelinesSample'));
OUTPUT(FinalRecordWithTradelines,,pOutputFilename,CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);

OUTPUT(TABLE(FinalRecordWithTradelines,{account_type_reported,COUNT(GROUP)},account_type_reported,FEW),NAMED('AccountTypeTable'));
