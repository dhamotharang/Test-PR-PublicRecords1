// ----------------------------------------------------------------------------------------------
// PRTE2_Header_Ins.U_Fix_DUP_Boca_DIDs
// Initial Creation of MHDR records from IHDR was done on fname+mname+lname because we had trouble
// getting a reasoable number of matches when joining on parts of the addresses.
// IHDR addresses tended to have little typo changes all over the place.
//
// THEN we find DUP BocaDID records and find that Nancy had 1191 IHDR records that she copied,
//  Left the name the same, altered SSN, DID and addresss - THEREFORE we created DUPS
// This is an effort to fix that.
// ----------------------------------------------------------------------------------------------
// W20150725-220807

IMPORT PRTE2_Header_Ins, ut, PRTE2_Common, PRTE2_X_DataCleanse;
#workunit('name', 'Boca CT Header Alter DIDs');

xdate	:= ut.GetDate;
CSV_NAME := 'BHDR_Alpha_Base_DID_FIX_'+xdate+'.csv';

Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_PROD;
TMP_ERR_FIXALL 	:= PRTE2_X_Ins_DataCleanse.Files_Alpha.TMP_DID_ERR_MHDR_SF_DS;
TMP_ERR_FIXDEDUP 	:= DEDUP(SORT(TMP_ERR_FIXALL,did),did);
TMP_ERR_FIX := TMP_ERR_FIXALL(s_did <> did);
DID_SET := SET(TMP_ERR_FIX,did);
FIX_DS := Alpha_Base_DS(did in DID_SET);
FIX_DS trXferFromFix(TMP_ERR_FIXALL L) := TRANSFORM
	SELF.rid := L.s_did;
	SELF := L;
END;
FIX_DS trXferWITHFix(TMP_ERR_FIXALL L) := TRANSFORM
	SELF.did 		:= L.s_did;
	SELF.s_did 	:= L.s_did;
	SELF.hhid 	:= L.s_did;
	SELF.uid 		:= L.s_did;
	SELF.rid		:= L.s_did;
	SELF.prim_range	:= L.fb_house_num;
	SELF.predir			:= '';
	SELF.postdir		:= '';
	SELF.prim_name	:= L.fb_street;
	SELF.suffix			:= L.fb_stsfx;
	SELF.unit_desig	:= L.fb_unit_name;
	SELF.sec_range	:= L.fb_unit_no;
	SELF.city_name	:= L.fb_city;
	SELF.st					:= L.fb_state;
	SELF.zip				:= L.fb_zip[1..5];
	SELF.zip4				:= L.fb_zip[6..9];
	SELF := L;
END;
KEEP_DS1 := Alpha_Base_DS(did not in DID_SET);
KEEP_DS2 := PROJECT(TMP_ERR_FIXALL(s_did=did), trXferFromFix(LEFT));
KEEP_DS3 := PROJECT(TMP_ERR_FIX, trXferWITHFix(LEFT));
OUTPUT(COUNT(Alpha_Base_DS),NAMED('Alpha_Base_DS'));
OUTPUT(COUNT(KEEP_DS1),NAMED('KEEP_DS1'));
OUTPUT(COUNT(KEEP_DS2),NAMED('KEEP_DS2'));
OUTPUT(COUNT(KEEP_DS3),NAMED('KEEP_DS3'));
OUTPUT(TMP_ERR_FIX,NAMED('TMP_ERR_FIX_OUT'),all);
OUTPUT(KEEP_DS2,NAMED('KEEP_DS2_OUT'),all);

OUTPUT(COUNT(TMP_ERR_FIXDEDUP),NAMED('TMP_ERR_FIXDEDUP'));
OUTPUT(COUNT(TMP_ERR_FIXALL),NAMED('TMP_ERR_FIXALL'));
OUTPUT(COUNT(TMP_ERR_FIX),NAMED('TMP_ERR_FIX'));
// OUTPUT(COUNT(DID_SET),NAMED('DID_SET'));
OUTPUT(COUNT(FIX_DS),NAMED('FIX_DS'));
/* *****************************************************************
****  THESE ARE NOW SUCCESSFULLY COMING UP WITH ZERO RECORDS ****
********************************************************************
 JOIN_BHD := JOIN(FIX_DS, TMP_ERR_FIX,
   							LEFT.did = RIGHT.did
   								// and LEFT.prim_range = RIGHT.prim_range
   								// and LEFT.prim_range = RIGHT.prim_name
   								// and LEFT.zip = RIGHT.zip
   					,TRANSFORM({FIX_DS}
   							,self:=left)
   				,LEFT ONLY
   				);
   JOIN_ERR := JOIN(FIX_DS, TMP_ERR_FIX,
   							LEFT.did = RIGHT.did
   								// and LEFT.prim_range = RIGHT.prim_range
   								// and LEFT.prim_range = RIGHT.prim_name
   								// and LEFT.zip = RIGHT.zip
   					,TRANSFORM({TMP_ERR_FIX}
   							,self:=right)
   				,RIGHT ONLY
   				);
OUTPUT(COUNT(JOIN_BHD),NAMED('JOIN_BHD'));
OUTPUT(COUNT(JOIN_ERR),NAMED('JOIN_ERR'));
OUTPUT(JOIN_BHD,NAMED('JOIN_BHD_OUT'),all);
OUTPUT(JOIN_ERR,NAMED('JOIN_ERR_OUT'),all);
***************************************************************** */
JOIN_FIX := JOIN(FIX_DS, TMP_ERR_FIX,
							LEFT.did = RIGHT.did
								// and LEFT.prim_range = RIGHT.prim_range
								// and LEFT.prim_range = RIGHT.prim_name
								and LEFT.zip = RIGHT.zip
					,TRANSFORM({FIX_DS}
							,SELF.did 		:= Right.s_did
							,SELF.s_did 	:= Right.s_did
							,SELF.hhid 		:= Right.s_did
							,SELF.uid 		:= Right.s_did
							,SELF.rid			:= Right.s_did
							,self				:= left)
				,INNER
				);
// FinalNewDS := KEEP_DS1+KEEP_DS2+JOIN_FIX;
FinalNewDS := KEEP_DS1+KEEP_DS2+KEEP_DS3;
OUTPUT(COUNT(FinalNewDS),NAMED('FinalNewDS'));
OUTPUT(FinalNewDS,NAMED('FinalNewDS_OUT'));
OUTPUT(COUNT(JOIN_FIX),NAMED('JOIN_FIX'));
OUTPUT(JOIN_FIX,NAMED('JOIN_FIX_OUT'),all);
// 888809054142
OUTPUT(MAX(JOIN_FIX,did));
lzFilePathGatewayFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;

// Alpha_Base_DS XForm (Alpha_Base_DS L, TMP_ERR_FIX R) := TRANSFORM
		// SELF.did 		:= R.did;
		// SELF.s_did 	:= R.did;
		// SELF.hhid 	:= R.did;
		// SELF.uid 		:= R.did;
		// SELF := L;		
		// SELF := [];
// END;

// NEXTDS := ITERATE(Alpha_Base_DS,XForm(LEFT,RIGHT));
EXPORT_DS := SORT(FinalNewDS,did);
// TEST_DS := NEXTDS;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);

