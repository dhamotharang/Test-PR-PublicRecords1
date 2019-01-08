// PRTE2_PropertyInfo.U_Convert_V2_Expanded

IMPORT PRTE2_Common, ut, Address;
IMPORT PRTE2_Header_Ins, PRTE2_X_Ins_PropertyScramble;
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

// --------------------------------------------------------------------------------------------------------
// ??????????????  I believe I have found that 1756 rows have not got the clean address fields filled in the base
//  I think a pre-process to fix that might make the BHEADER join unneccesssary!!!!
// ----------------------------------- FIX EVERYTHING WE CAN FROM XREF ------------------------------------
PropertyExpandedRec_V2 U_Fix_XREF_Fields_Xform(PropInfoDS L, XREF1 R) := TRANSFORM
	SELF.DID := R.LexID;
	SELF.DOB := (INTEGER)R.DOB;
	SELF := R;
	SELF := L;
	SELF := [];
END;
XREF_JOIN1		:= JOIN(PropInfoDS, XREF1
										, LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name
											AND LEFT.zip[1..5] = RIGHT.zip[1..5] AND LEFT.st = RIGHT.st
								,U_Fix_XREF_Fields_Xform(LEFT,RIGHT)
								,LEFT OUTER
								);
Fixed_XREF_1 := XREF_JOIN1(DID>0);
PostProcess1 := XREF_JOIN1(DID=0);			// This left 1756 not matched - try the BHDR and see if that helps.

/*   
******************************************************************************************************************
FIRST - we joined to the XREF since it has only 1 record per property.  That resolves all except 1756
SECONDARY - postprocess to try to fix those 1756 records - try the BOCA HEADER - 
I need to sort header by DOB so the oldest comes up first and then do a DEDUP before the JOIN
because it's running into DUP header records where it has two or more living in the same address.
******************************************************************************************************************
*/

// ----------------------------------- FIX EVERYTHING WE CAN FROM BHDR ------------------------------------
// Sort to keep (a) the highest SSN and the oldest DOB (SSN because it was keeping at least one with zero SSN)
// If we have to we should keep a zero SSN but if possible keep another occupant which has a SSN
HeaderDS1			:= SORT(PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS,prim_range,prim_name,zip,st,-ssn,-dob);
// OUTPUT(COUNT(HeaderDS1),NAMED('HeaderDS1'));
HeaderDS2			:= DEDUP(HeaderDS1,prim_range,prim_name,zip,st);
// OUTPUT(COUNT(HeaderDS2),NAMED('HeaderDS2'));
HeaderDS2b		:= SORT(HeaderDS2,did);
HeaderDS3			:= DEDUP(HeaderDS2b,did);
// OUTPUT(COUNT(HeaderDS3),NAMED('HeaderDS3'));
// OUTPUT(HeaderDS3(lname='BATES' and prim_name='GENTIAN'),NAMED('DOUBLE_CHECK'));
// This is the test case where I saw it keeping someone with zero SSN and added that sort prior to the DOB.

PropertyExpandedRec_V2 U_Fix_HDR_Fields_Xform(PropertyExpandedRec_V2 L, HeaderDS3 R) := TRANSFORM
	SELF := R;
	SELF := L;
END;


OUTPUT(XREF_JOIN1,NAMED('XREF_JOIN1'));
OUTPUT(COUNT(XREF_JOIN1),NAMED('XREF_JOIN1_Cnt'));
aString := ''+COUNT(Fixed_XREF_1)+' '+COUNT(PostProcess1)+' '+ (COUNT(Fixed_XREF_1)+COUNT(PostProcess1));
output(aString);

SecondFixesDS		:= JOIN(PostProcess1, HeaderDS3
									, LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name
										AND LEFT.zip = RIGHT.zip AND LEFT.st = RIGHT.st
							,U_Fix_HDR_Fields_Xform(LEFT,RIGHT)
							,LEFT OUTER
							);
SecondFixes17 := SORT(SecondFixesDS,property_rid);

// ----------------------------------- MERGE THE ABOVE TWO FIXES BACK TO ONE FILE ------------------------------------
EXPORT_DS0 := SORT(Fixed_XREF_1+SecondFixesDS,property_rid);
OUTPUT(EXPORT_DS0,NAMED('EXPORT_DS0'));

// ----------------------------------- CLEAN UP THE ADDRESS FIELDS ------------------------------------
PropertyExpandedRec_V2 spreadsheet_clean(PropertyExpandedRec_V2 L) := TRANSFORM
			// addr1		:= Address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,L.postdir,L.unit_desig,L.sec_range);
			// clean_address := PRTE2_Common.Clean_Address.cleanAddr1CSZ(addr1, l.property_city,l.property_state,l.property_zip);
			clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(L.property_street_address, L.property_city_state_zip);
			// SELF.property_street_address := clean_address.addr1;		// First time through clean up bad address1 lines??
			// SELF.property_city_state_zip := clean_address.addr2;			// This will no longer be primary, replaced by property_city, property_state, property_zip
			SELF.property_city := clean_address.v_city_name;
			SELF.property_state := clean_address.st;
			SELF.property_zip := clean_address.zip;
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


EXPORT_DS := PROJECT(EXPORT_DS0, spreadsheet_clean(LEFT));
// ----------------------------------- WE ARE DONE NOW - JUST OUTPUT AND DESPRAY ------------------------------------
OUTPUT(EXPORT_DS,NAMED('EXPORT_DS'));


OUTPUT(COUNT(PropInfoDS),NAMED('PropInfoDS'));
OUTPUT(PropInfoDS);

OUTPUT(COUNT(EXPORT_DS),NAMED('EXPORT_DS_cnt'));
OUTPUT(COUNT(EXPORT_DS(did=0)),NAMED('EXPORT_DS_zeros'));
OUTPUT(COUNT(EXPORT_DS)-COUNT(PropInfoDS),NAMED('EXPORT_DS_added'));
OUTPUT(EXPORT_DS);

lzFilePathGatewayFile	:= PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + desprayName;
lzFilePathGatewayFile2	:= PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + desprayName2;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
PRTE2_Common.DesprayCSV(SecondFixes17, TempCSV2, LandingZoneIP, lzFilePathGatewayFile2);

