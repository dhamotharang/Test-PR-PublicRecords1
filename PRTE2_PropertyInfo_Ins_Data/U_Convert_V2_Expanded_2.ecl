/* **************************************************************************************
NO!!!   THIS PROCESS DIDN'T ELIMINATE THE NEED TO POST PROCESS SOME RECORDS WITH BHDR
I'll save it just to document that we considered this and tried it but it didn't help.
We'll use the original U_Convert_V2_Expanded process to do the final layout fix
************************************************************************************** */

/* U_Convert_V2_Expanded_2 ************************************************************
I noticed that there were 1756 records in the original file that had blank prim_name, prim_range!!
Therefore we might be able to reverse this and completely avoid the step of fixing 1756 records from the BHDR file.
1. pass thru original file and do clean address on all addresses.
2. do the XREF join to fix all records
3. Now count to see if any records still have a blank DID
   If not, we do not need the BHDR join
**************************************************************************************
NO!!!   THIS PROCESS DIDN'T ELIMINATE THE NEED TO POST PROCESS SOME RECORDS WITH BHDR
**************************************************************************************  */


//TODO - not yet done but checked in for reference.

IMPORT PRTE2_Common, ut, Address;
IMPORT PRTE2_X_Ins_PropertyScramble;
IMPORT PRTE2_PropertyInfo;

dateString		:= ut.GetDate+'';
TempCSV				:= PRTE2_PropertyInfo.Files.FILE_SPRAY + '::' +  WORKUNIT;
TempCSV2			:= PRTE2_PropertyInfo.Files.FILE_SPRAY + '2::' +  WORKUNIT;
LandingZoneIP := PRTE2_PropertyInfo.Constants.LandingZoneIP;
desprayName 	:= 'PropInfo_Fix_AV2_DEV_'+dateString+'.csv';
desprayName2 	:= 'PropInfo_Fix_AV2_last1756_'+dateString+'.csv';
PropInfoDS 		:= SORT(PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS,property_rid);
XREF1 				:= PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_CNT_SF_DS;

PropertyExpandedRec_V2 := PRTE2_PropertyInfo.Layouts.PropertyExpandedRec_V2;

// ----------------------------------- PRE-CLEAN THE CLEAN ADDRESS FIELDS ------------------------------------
PropInfoDS spreadsheet_clean(PropInfoDS L) := TRANSFORM
			clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(L.property_street_address, L.property_city_state_zip);
			SELF.prim_name  := clean_address.prim_name;
			SELF.predir     := clean_address.predir;
			SELF.prim_range := clean_address.prim_range;
			SELF.sec_range  := clean_address.sec_range;					
			SELF.unit_desig := clean_address.unit_desig;
			SELF.postdir    := clean_address.postdir;
			SELF.addr_suffix := clean_address.addr_suffix;
			SELF.st         := clean_address.st;
			self.zip        := clean_address.zip; 
			self.zip4       := clean_address.zip4;
			SELF.msa        := clean_address.msa;
			SELF.err_stat   := clean_address.err_stat;
			SELF.cart       := clean_address.cart;
			SELF.cr_sort_sz := clean_address.cr_sort_sz;
			SELF.lot        := clean_address.lot;
			SELF.lot_order  := clean_address.lot_order;
			SELF.dbpc       := clean_address.dbpc;
			SELF.chk_digit  := clean_address.chk_digit;
			SELF.rec_type   := clean_address.rec_type;
			SELF.county     := clean_address.fips_state+clean_address.fips_county;	// ??? This is what it used to do - [141-145]
			self.geo_lat    := clean_address.geo_lat;
			self.geo_long   := clean_address.geo_long;
			SELF.geo_blk    := clean_address.geo_blk;
			SELF.geo_match  := clean_address.geo_match;
			SELF.p_city_name := clean_address.p_city_name;
			SELF.v_city_name := clean_address.v_city_name;
			SELF := L;
END;


PropInfoDS_2 := PROJECT(PropInfoDS, spreadsheet_clean(LEFT));
PropInfo2_CAB := PropInfoDS_2(prim_name='' and prim_range='');
// ----------------------------------- WE ARE DONE NOW - JUST OUTPUT AND DESPRAY ------------------------------------

// ----------------------------------- FIX EVERYTHING WE CAN FROM XREF ------------------------------------
PropertyExpandedRec_V2 U_Fix_XREF_Fields_Xform(PropInfoDS_2 L, XREF1 R) := TRANSFORM
	SELF.DID := R.LexID;
	SELF.DOB := (INTEGER)R.DOB;
	SELF := R;
	SELF := L;
	SELF := [];
END;
XREF_JOIN1		:= JOIN(PropInfoDS_2, XREF1
										, LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name
											AND LEFT.zip[1..5] = RIGHT.zip[1..5] AND LEFT.st = RIGHT.st
								,U_Fix_XREF_Fields_Xform(LEFT,RIGHT)
								,LEFT OUTER
								);
Fixed_XREF_1 := XREF_JOIN1(DID>0);
PostProcess1 := XREF_JOIN1(DID=0);			// NOPE --- we still have broken one's - this is not a better way to fix records.
OUTPUT(COUNT(PropInfoDS_2),NAMED('PropInfoDS_2'));
OUTPUT(COUNT(PropInfo2_CAB),NAMED('PropInfoDS_2_CAFail_Cnt'));
OUTPUT(COUNT(PropInfoDS_2),NAMED('PropInfoDS_2_Cnt'));
OUTPUT(COUNT(XREF_JOIN1),NAMED('XREF_JOIN1_Cnt'));
OUTPUT(COUNT(Fixed_XREF_1),NAMED('Fixed_XREF_1_Cnt'));
OUTPUT(COUNT(PostProcess1),NAMED('PostProcess1_cnt'));

OUTPUT(XREF_JOIN1,NAMED('XREF_JOIN1'));
aString := ''+COUNT(Fixed_XREF_1)+' '+COUNT(PostProcess1)+' '+ (COUNT(Fixed_XREF_1)+COUNT(PostProcess1));
output(aString);

// ----------------------------------- MERGE THE ABOVE TWO FIXES BACK TO ONE FILE ------------------------------------
EXPORT_DS := SORT(Fixed_XREF_1,property_rid);
OUTPUT(COUNT(EXPORT_DS),NAMED('EXPORT_DS_cnt'));
OUTPUT(COUNT(EXPORT_DS(did=0)),NAMED('EXPORT_DS_zeros'));
OUTPUT(EXPORT_DS,NAMED('EXPORT_DS'));


OUTPUT(PropInfoDS);

OUTPUT(COUNT(EXPORT_DS)-COUNT(PropInfoDS_2),NAMED('EXPORT_DS_added'));
OUTPUT(EXPORT_DS);

// lzFilePathGatewayFile	:= PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + desprayName;
// lzFilePathGatewayFile2	:= PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + desprayName2;
// PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
// PRTE2_Common.DesprayCSV(SecondFixes17, TempCSV2, LandingZoneIP, lzFilePathGatewayFile2);

