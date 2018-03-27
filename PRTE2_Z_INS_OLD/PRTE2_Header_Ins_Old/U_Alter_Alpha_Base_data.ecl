// PRTE2_Header_Ins.U_Alter_Alpha_Base_data
// Despray the DEV Header Info base file but alter the data just before the despray.

IMPORT PRTE2_Header_Ins, ut, PRTE2_Common,PRTE2_Common_DevOnly;
#workunit('name', 'Boca CT Header Alter');

xdate	:= ut.GetDate;

CSV_NAME := 'BHDR_Alpha_Base_Altered_'+xdate+'.csv';
Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
TmpFN := '~prct::TEMP::ct::alpharetta::PeopleHeader_Base';
lzFilePathGatewayFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;
// MIN() and MAX(DSH,phone);
// 1005550100 - 1045559020

//NOTE: IF WORRIED before running again - determine the new MAX() and insert it into this line.
// PhoneGenerator := PRTE2_Common_DevOnly.Fake_Phones('1045559020');
// OTHERWISE - We'll just do it programatically.
STRING lastPhone := MAX(Alpha_Base_DS,phone);
PhoneGenerator := PRTE2_Common.Fake_Phones(lastPhone);
//TODO ??? At some point we might run into dups between PhonesPlus and BHDR ???  RESEARCH THIS

Alpha_Base_DS XForm (Alpha_Base_DS L, Alpha_Base_DS R, CNT) := TRANSFORM
	// we had to do iterate where L=previous record so the prev phone assigned becomes the seed for getNextNumber
	SELF.phone					:= IF(R.phone ='', PhoneGenerator.String10NextPhone(L.phone), R.phone );
	SELF.rid						:= IF(R.rid < R.did, R.did, R.rid);
	SELF.hhid						:= IF(R.hhid < R.did, R.did, R.hhid);
	SELF := R;
END;

NEXTDS := ITERATE(Alpha_Base_DS,XForm(LEFT,RIGHT,COUNTER));
EXPORT_DS := SORT(NEXTDS,did);
TEST_DS := NEXTDS;
DsprayIt := PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);
writeIt := OUTPUT(EXPORT_DS,,TmpFN,overwrite);

// For the most part despraying the data is just fine, since re-spraying back in helps double check the validity
// SEQUENTIAL(DsprayIt);
// SEQUENTIAL(DsprayIt, writeIt);
OUTPUT(TEST_DS(did > 888809050090));
OUTPUT(COUNT(Alpha_Base_DS));
OUTPUT(COUNT(TEST_DS));
// OUTPUT(MAX(Alpha_Base_DS,phone));