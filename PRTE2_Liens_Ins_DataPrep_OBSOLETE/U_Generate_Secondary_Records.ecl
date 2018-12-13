/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_Generate_Secondary_Records

This depends on having Party records looked up by DID, duplicated with a flag in tax_id column
flag must show 1 and 2 record + '!!'+ must describe in [4] either J,L or B position 5 will only be "N" for new non-Experian cases
Those flags will go away prior to loading

Built in assumptions to most the code:
* The Party record and Main record has not already been modified. 
	(I think I protected somewhat for that, but would need testing and probably more protection)
* Coded to take 2 Party records, modify their fields and generate 2nd Main record and modify both to match
	but no logic yet for more than 2 records total.
********************************************************************************************* */
IMPORT ut, PRTE2_Liens_Ins, PRTE2_Common,STD;
#workunit('name', 'Boca PRTE2 Alpha Liens Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// ----- DEV DESPRAY ---------------------------------------------------------
MAIN1 :=	SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_Prod,tmsid);				// Official in PROD
Export_Party		:=	SORT(PRTE2_Liens_Ins.Files.Party_IN_DS,tmsid);	// Special marked version in Dev
// ---------------------------------------------------------------------------
Party1 := Export_Party(STD.Str.StartsWith(tax_id,'1!!B'));
Party2 := Export_Party(STD.Str.StartsWith(tax_id,'1!!J'));
Party3 := Export_Party(STD.Str.StartsWith(tax_id,'1!!L'));
PartySet1 := SET(Party1,tmsid);
PartySet2 := SET(Party2,tmsid);
PartySet3 := SET(Party3,tmsid);
OUTPUT(Party1,NAMED('Party1'));
OUTPUT(Party2,NAMED('Party2'));
OUTPUT(Party3,NAMED('Party3'));
PartySetAll := PartySet1+PartySet2+PartySet3;
MAIN1Part := MAIN1(tmsid not in PartySetAll);
MAIN2a := MAIN1(tmsid IN PartySet1);
MAIN2aa := MAIN1(tmsid IN PartySet1);
MAIN2b := MAIN1(tmsid IN PartySet2);
MAIN2bb := MAIN1(tmsid IN PartySet2);
MAIN2c := MAIN1(tmsid IN PartySet3);
MAIN2cc := MAIN1(tmsid IN PartySet3);
MAIN2a trxMain(Main2a L, STRING code) := TRANSFORM
	SELF.record_code := code;
	SELF := L;
END;
MAIN3a := PROJECT(MAIN2a,trxMain(LEFT,'2!!B'));
MAIN3b := PROJECT(MAIN2b,trxMain(LEFT,'2!!J'));
MAIN3c := PROJECT(MAIN2c,trxMain(LEFT,'2!!L'));
MAIN3aa := PROJECT(MAIN2aa,trxMain(LEFT,'1!!B'));
MAIN3bb := PROJECT(MAIN2bb,trxMain(LEFT,'1!!J'));
MAIN3cc := PROJECT(MAIN2cc,trxMain(LEFT,'1!!L'));
OUTPUT(PartySetAll,NAMED('PartySetAll'));
OUTPUT(MAIN3a,NAMED('MAIN3a'));
OUTPUT(MAIN3aa,NAMED('MAIN3aa'));
MAIN4a := MAIN3a+MAIN3b+MAIN3c;
MAIN4aa := MAIN3aa+MAIN3bb+MAIN3cc;
MAIN4 := MAIN4a+MAIN4aa;
Export_Main := SORT(MAIN1Part+MAIN4,tmsid);

// **********************************************************************************************
STRING NextDate(STRING instr) := FUNCTION
		dateToUse := TRIM(instr,left,right);
		RETURN IF(dateToUse='' OR length(dateToUse)<8, 
								dateToUse,
								ut.month_math(dateToUse,6));
END;
// **********************************************************************************************

PartyNonE := Export_Party(STD.Str.EndsWith(tax_id,'N!'));
PartyNonSet := SET(PartyNonE,tmsid);

Export_Main		trxMainEx(Export_Main L) := TRANSFORM
	// ---------------- preparation work -----------------
	DOIT2			:= STD.Str.StartsWith(L.record_code,'2!!');
	DOIT1			:= STD.Str.StartsWith(L.record_code,'1!!');
	DOIT1or2 := DOIT2 OR DOIT1;
	whichRec := L.record_code[1];		// either 1,2 or ''
	whatDesc := L.record_code[4];		// either J, L, B or ''
	boolean isRelease := L.release_date <>'';
	fixNewRecCd := L.record_code+'N!';
	boolean isNewFlag := DOIT1or2 AND L.tmsid in PartyNonSet;
	newProcessDate 	:= IF(DOIT2,NextDate(L.process_date),L.process_date);
	newOFilingDate 	:= IF(DOIT2,NextDate(L.orig_filing_date),L.orig_filing_date);
	newReleaseDate 	:= IF(DOIT2,NextDate(L.release_date),L.release_date);

	NewDesc1 := Map( whatDesc='J'=>IF(isRelease,'CIVIL JUDGMENT RELEASE','CIVIL JUDGMENT')
									,whatDesc='L'=>IF(isRelease,'STATE TAX LIEN RELEASE','STATE TAX LIEN')
									,whatDesc='B'=>IF(isRelease,'STATE TAX WARRANT RELEASE','STATE TAX WARRANT')	//Both: lien on #1
									,L.filing_type_desc
									);
	NewDesc2 := Map( whatDesc='J'=>IF(isRelease,'SMALL CLAIMS JUDGMENT RELEASE','SMALL CLAIMS JUDGMENT')
									,whatDesc='L'=>IF(isRelease,'FEDERAL TAX LIEN RELEASE','FEDERAL TAX LIEN')
									,whatDesc='B'=>IF(isRelease,'SMALL CLAIMS JUDGMENT RELEASE','SMALL CLAIMS JUDGMENT')	//Both: judgement on #2
									,L.filing_type_desc
									);
	tms1 := STD.Str.SplitWords(L.tmsid,'ICT');
	rms1 := STD.Str.SplitWords(L.rmsid,'ICT');
	suffix := '.TC'+whichRec;
	tms2 := TRIM(tms1[1]+'ICT'+tms1[2][5..])+suffix;
	rms2 := TRIM(rms1[1]+'ICT'+rms1[2][5..])+suffix;
	fn1 := STD.Str.SplitWords(L.filing_number,'ICT');
	fnNew := fn1[1]+'ICT.TC'+whichRec;
	NewAmount :=(STRING) (integer) ((integer)L.amount * .78);
	NewPage :=(STRING) (integer) ((integer)L.filing_page * 1.78);
	// END ---------------- preparation work -----------------
	SELF.record_code				:= IF(isNewFlag, fixNewRecCd, L.record_code);
	SELF.amount 						:= IF(DOIT2,newAmount,L.amount);
	SELF.filing_page 				:= IF(DOIT2,NewPage,L.filing_page);
	SELF.process_date 			:= newProcessDate;  // if not DOIT2, then it is unchanged
	SELF.orig_filing_date 	:= newOFilingDate;  // if not DOIT2, then it is unchanged
	SELF.release_date 			:= newReleaseDate;  // if not DOIT2, then it is unchanged
	SELF.filing_number 			:= IF(DOIT1or2,fnNew,L.filing_number);
	SELF.filing_type_desc 	:= MAP(whichRec='1'=>NewDesc1
																	,whichRec='2'=>NewDesc2
																	,L.filing_type_desc);		// no change if not 1 or 2
	SELF.orig_filing_number	:= IF(DOIT1or2 AND L.orig_filing_number<>'',fnNew,L.orig_filing_number);
	SELF.tmsid := IF(DOIT1or2 AND NOT STD.Str.EndsWith(L.tmsid,suffix),tms2,L.tmsid);
	SELF.rmsid := IF(DOIT1or2 AND NOT STD.Str.EndsWith(L.rmsid,suffix),rms2,L.rmsid);
	SELF := L;
END;

Export_Party 	trxPartEx(Export_Party L) := TRANSFORM
	DOIT2 			:= STD.Str.StartsWith(L.tax_id,'2!!');
	DOIT1			:= STD.Str.StartsWith(L.tax_id,'1!!');
	DOIT1or2 := DOIT2 OR DOIT1;
	whichRec := L.tax_id[1];		// either 1,2 or ''
	tms1 := STD.Str.SplitWords(L.tmsid,'ICT');
	rms1 := STD.Str.SplitWords(L.rmsid,'ICT');
	suffix := '.TC'+whichRec;
	tms2 := TRIM(tms1[1]+'ICT'+tms1[2][5..])+suffix;
	rms2 := TRIM(rms1[1]+'ICT'+rms1[2][5..])+suffix;
	// I pushed a new party file out there with some already modified TMSIDs and added records - so it is double modifying the old ones!!! MUST FIX
	SELF.tmsid := IF(DOIT1or2 AND NOT STD.Str.EndsWith(L.tmsid,suffix),tms2,L.tmsid);
	SELF.rmsid := IF(DOIT1or2 AND NOT STD.Str.EndsWith(L.rmsid,suffix),rms2,L.rmsid);
	SELF := L;
END;
Export_Main2	:= SORT(PROJECT(Export_Main,trxMainEx(LEFT)),tmsid);
Export_Party2	:= SORT(PROJECT(Export_Party,trxPartEx(LEFT)),tmsid);

OUTPUT(COUNT(PartySetAll),NAMED('Cnt_PartySetAll'));
OUTPUT(COUNT(PartyNonE),NAMED('Cnt_PartyNonE'));
OUTPUT(COUNT(MAIN4),NAMED('Cnt_MAIN4'));
OUTPUT(COUNT(Main1Part),NAMED('Cnt_Main1Part'));
OUTPUT(COUNT(MAIN1),NAMED('Cnt_Main_in'));
OUTPUT(COUNT(Export_Main),NAMED('Cnt_Export_Main'));
OUTPUT(COUNT(Export_Main2),NAMED('Cnt_Export_Main2'));
OUTPUT(COUNT(Export_Party2),NAMED('Cnt_Export_Party2'));
OUTPUT(CHOOSEN(Export_Main2,2000),NAMED('Main_Export'));
desprayNameMain	:= 'Liens_Main_Multi_'+dateString+'.csv';
desprayNameParty	:= 'Liens_Party_Multi_'+dateString+'.csv';

LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(Export_Main2, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(Export_Party2, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
