/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_1_PrimParty
LIMITATION: JOIN with header does a DEDUP which assumes 1 record per DID need rewrite if that changes

-- take the Primary Drivers and simply convert all of those (47k records) into a prim party thor file
-- mark any of these that are a HIT in the boca header because we cannot use those Alpha DIDs for this temporary L&J workaround

********************************************************************************************* */
IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Common, LiensV2_preprocess, PRTE2_Liens_Ins, PRTE2_X_Ins_DataCleanse, STD, ut, Address;

//---- mini Prod files -----------------------------------------------
// Main_Prod_Mini		:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS,tmsid,rmsid,process_date);
// Party_Prod_Mini	:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Party_DS,tmsid,rmsid,date_first_seen);
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
PrimPartyLayout := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseParty_in_joinable_V2;
PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS;
PartyName := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.primParty_FileName;
//------Create a link to person header to ensure no conflicts -------------------
PerHeadKey := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Latest_PRCT_HeaderKey;
//-------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
/* NEXT:
Create a BWR to generate/output the new U_Gather_PRCT_Files.Prim_Party_DS in that joinable layout (number by state).
  use the new U_GatherFix_Analytics_Functions.transformDrivers2Party to do that.
*/
//-----------------------------------------------------------------------------------------

AppendIF(STRING S1, STRING S2) := IF(S1='',S2,S1+' '+S2);
AppendIF4(STRING S1, STRING S2, STRING S3, STRING S4) := AppendIF(AppendIF(S1,S2),AppendIF(S3,S4));
UPPER(STRING S1) := STD.Str.ToUpperCase(S1);

//----------------------------------------------------------
PrimPartyLayout trxParty(PrimDrivers L) := TRANSFORM
		SELF.joinint := 0;
		SELF.DID  := (STRING)L.uniqueid;
		tmpFullName := AppendIF4(L.FIRST_NAME,L.MIDDLE_NAME,L.LAST_NAME,L.NAME_SUFFIX);
		betterFullName := ut.CleanSpacesAndUpper(tmpFullName);

		SELF.orig_full_debtorname := betterFullName;
		SELF.orig_name 						:= betterFullName; 
		SELF.orig_lname 					:= UPPER(L.LAST_NAME);
		SELF.orig_fname 					:= UPPER(L.FIRST_NAME);
		SELF.orig_mname 					:= UPPER(L.MIDDLE_NAME);
		SELF.orig_suffix 					:= UPPER(L.NAME_SUFFIX);

		SELF.ssn := L.ssn;

		// SELF.address.Layout_Clean_Name;
		cName := Address.CleanPersonFML73(betterFullName);
		self.title				:= TRIM(cName[1..5]);
		self.fname				:= TRIM(cName[6..25]);
		self.mname				:= TRIM(cName[26..45]);
		self.lname				:= TRIM(cName[46..65]);
		self.name_suffix	:= TRIM(cName[66..70]);
		self.name_score		:= TRIM(cName[71..73]);		
		
		tmpAddr1 := L.STREET_ADDRESS;
		tmpAddr2 := AppendIF4('',L.CITY,L.STATE,L.ZIP5);
		tmpFullAddr := AppendIF4(L.STREET_ADDRESS,L.CITY,L.STATE,L.ZIP5);
		SELF.orig_address1 := UPPER(tmpAddr1);
		SELF.orig_address2 := UPPER(tmpAddr2);
		SELF.orig_city := UPPER(L.CITY);
		SELF.orig_state := UPPER(L.STATE);
		SELF.orig_zip5 := L.ZIP5;
		SELF.orig_zip4 := '';
		SELF.orig_county := '';
		SELF.orig_country :='';
		
		// SELF.address.Layout_Clean182;				Take this from the cleaned address in the Prim Drv record
		SELF.prim_range := L.prim_range;
		SELF.predir := L.predir;
		SELF.prim_name := L.prim_name;
		SELF.addr_suffix := L.addr_suffix;
		SELF.postdir := L.postdir;
		SELF.unit_desig := L.unit_desig;
		SELF.sec_range := L.sec_range;
		SELF.p_city_name := L.p_city_name;
		SELF.v_city_name := L.v_city_name;
		SELF.st := L.st;
		SELF.zip := L.zip;
		SELF.zip4 := L.zip4;
		SELF.cart := L.cart;
		SELF.cr_sort_sz := L.cr_sort_sz;
		SELF.lot := L.lot;
		SELF.lot_order := L.lot_order;
		SELF.dbpc := L.dbpc;
		SELF.chk_digit := L.chk_digit;
		SELF.rec_type := L.rec_type;
		SELF.county := L.fips_county;
		SELF.geo_lat := L.geo_lat;
		SELF.geo_long := L.geo_long;
		SELF.msa := L.msa;
		SELF.geo_blk := L.geo_blk;
		SELF.geo_match := L.geo_match;
		SELF.err_stat := L.err_stat;
		
		SELF.phone := '';					// NOT THERE
		SELF.name_type := 'D';		// imitating what I see in PRCT data which had: 6130=D, 12=A and 26=C
		SELF.date_first_seen := L.date_first_seen;
		SELF.date_last_seen := L.date_last_seen;
		SELF.date_vendor_first_reported := L.date_first_seen;
		SELF.date_vendor_last_reported := L.date_last_seen;

		SELF.cname 				:= '';							// no businesses
		SELF.BDID 				:= '';							// no businesses
		SELF.tax_id 			:= '';							// no businesses   ??? is this business only?

		SELF.tmsid     		:= '';
		SELF.rmsid     		:= '';
		SELF.ultid     		:= 0;
		SELF.orgid     		:= 0;
		SELF.seleid    		:= 0;
		SELF.proxid    		:= 0;
		SELF.powid     		:= 0;
		SELF.empid     		:= 0;
		SELF.dotid     		:= 0;
		SELF.ultscore     := 0;
		SELF.orgscore     := 0;
		SELF.selescore    := 0;
		SELF.proxscore    := 0;
		SELF.powscore     := 0;
		SELF.empscore     := 0;
		SELF.dotscore     := 0;
		SELF.ultweight    := 0;
		SELF.orgweight    := 0;
		SELF.seleweight   := 0;
		SELF.proxweight   := 0;
		SELF.powweight    := 0;
		SELF.empweight    := 0;
		SELF.dotweight    := 0;
		SELF.fp     			:= '';
		SELF := L;
END;
PartyMid0 := PROJECT(PrimDrivers,trxParty(LEFT));
PartyMid := DEDUP(SORT(PartyMid0,did),did);
//----------------------------------------------------------		LIMITATION: This assumes 1 record per DID need rewrite if that changes
PartyMid trxJOIN(PartyMid L, PerHeadKey R) := TRANSFORM
		SELF.joinint := 0;
		SELF.BocaHit := 'Y';
		SELF := L;
END;
PartyHots := JOIN(PartyMid,PerHeadKey,
										(unsigned6)left.DID = right.s_did,
										trxJOIN(LEFT,RIGHT),
										INNER
										);
PartyHits := DEDUP(SORT(PartyHots,DID),DID);
PFSet := SET(PartyHits,did);		// should be zero or very few of these
PartyNoHit := PartyMid(did not in PFSet);
//----------------------------------------------------------
PrimPartyLayout trxParty2(PartyNoHit L, INTEGER CNT) := TRANSFORM
		SELF.joinint := CNT;
		SELF := L
END;
G_Party := GROUP(SORT(PartyNoHit,st),st);
NoHitFinal := UNGROUP(PROJECT(G_Party,trxParty2(LEFT,COUNTER)));
//----------------------------------------------------------
PartyFinal := SORT(PartyHits+NoHitFinal,st,joinint);
//----------------------------------------------------------
OUTPUT(COUNT(PartyMid),NAMED('PartyMid'));												// 47464		after adding pre-dedup 47427
OUTPUT(COUNT(PartyHits),NAMED('PartyHits'));											// 11429
OUTPUT(COUNT(PartyNoHit),NAMED('PartyNoHit'));										// 36031		after adding pre-dedup 35998
OUTPUT(COUNT(PartyFinal),NAMED('PartyFinal'));										// 47460
OUTPUT(COUNT(PartyFinal(BocaHit='Y')),NAMED('PartyFinalHits'));		// 11429
//-----------------------------------------------------------------------------------------
// 12/13 note - Counts show I'm losing 4 records ... I guess because of the DEDUP on DID???
//-----------------------------------------------------------------------------------------
OUTPUT(PartyFinal,,PartyName,overwrite);
// ---------------------------------------------------------------------------