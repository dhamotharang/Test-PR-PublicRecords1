/* ************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Generate_2_From_IHDR_Records

*********************************************  WIP!!! ********************************************
Next time - rethink the date aging.  There was a dirty workaround in here this last time I did it.
*********************************************  WIP!!! ********************************************
Already gathered Party and Main records from production data...
A merging program should be able to take IHDR records and join on these by JoinInt + State 
and merge those with the fake people (still need PII removed)
Then join on tmsid to create new main records to go with those Party records tied to fake people.
Final steps are to replace tmsids and other PII fields without breaking the Party/Main joins.
(Replacing other PII fields but decided to just inject an 'I' (for insurance) into the tmsid/rmsid but otherwise 
	leave tmsid and rmsid close to what they were so I don't have to worry about relinking with an 'old_tmsid' approach)

1. Read people from an IHDR Joinable file
2. We can handle multiple Party with the same DID
3. Join those to records in the same state in Save_ProdParty_DS and Save_ProdMain_DS
		to create new fake test cases (implies all the required field blanking and generating is done)

Note: if you put references in the IHDR ln_product_tie field it will transfer into the new L&J data for future reference.
************************************************************************************ */

IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Common, LiensV2_preprocess, PRTE2_Liens_Ins, PRTE2_X_Ins_DataCleanse, STD, ut, Address, PromoteSupers;
#WORKUNIT ('NAME','CT Generate_2_From_IHDR_Records');

//-----------------------------------------------------------------------------------------
// ?????????? do we need DC below? ????????????
allStates := ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY',
							'LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH',
							'OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY'];
//----------------------------------------
appendIf := PRTE2_Common.Functions.appendIf;
AppendIF4 := PRTE2_Common.Functions.AppendIF4;
AppendIF5 := PRTE2_Common.Functions.AppendIF5;
UPPER := PRTE2_Common.Functions.UPPER;

//-----------------------------------------------------------------------------------------
IncomingPeople := PRTE2_Liens_Ins_DataPrep.Files.Incoming_IHDR_DS;
GatheredParties := PRTE2_Liens_Ins_DataPrep.Files.Save_ProdParty_DS(st in allStates);
GatheredMains := PRTE2_Liens_Ins_DataPrep.Files.Save_ProdMain_DS(tmsid<>'');
//------Create a link to person header to ensure no conflicts -------------------
PerHeadKey := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Latest_PRCT_HeaderKey;		// because we are going to confirm alpha lexid is not in BHDR.
//-------------------------------------------------------------------------------
PartyJoinLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BasePartyInJoin;
PartyExJoinLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BasePartyExtraJoin;
PartyBocaHitLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BasePartyBocaHit;
MainPartyLayout := PRTE2_Liens_Ins_DataPrep.Layouts.BaseMainInJoin;
//-----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------
PartyExJoinLayout trxParty(IncomingPeople L, INTEGER CNT) := TRANSFORM
		SELF.joinint := L.joinint;
		SELF.exJoinInt := CNT;
		SELF.DID  := (STRING)L.uniqueid;
		tmpFullName := AppendIF4(L.last_name,L.middle_name,L.last_name,L.name_suffix);
		betterFullName := ut.CleanSpacesAndUpper(tmpFullName);
		
WANT_TO_STOP_COMPILE_TILL_FIXED!
//TODO There was an error with some records orig_fname was not properly containing the right value
// looked like it held old prod data values for orig_fname
		SELF.orig_full_debtorname := betterFullName;
		SELF.orig_name 						:= betterFullName; 
		SELF.orig_lname 					:= UPPER(L.last_name);
		SELF.orig_fname 					:= UPPER(L.first_name);		// ??? ERROR
		SELF.orig_mname 					:= UPPER(L.middle_name);
		SELF.orig_suffix 					:= UPPER(L.name_suffix);
		SELF.ssn := L.ssn;

//TODO - some really nonsense CT names appear to return a blank clean name --- be careful and inspect
		// SELF.address.Layout_Clean_Name;
		// FML = name order.  There is also Address.CleanPersonLFM73, Address.CleanPerson73
		cName := Address.CleanPersonFML73(betterFullName);
		slf.title				:= TRIM(cName[1..5]);
		self.fname				:= TRIM(cName[6..25]);
		self.mname				:= TRIM(cName[26..45]);
		self.lname				:= TRIM(cName[46..65]);
		self.name_suffix	:= TRIM(cName[66..70]);
		self.name_score		:= TRIM(cName[71..73]);		

		tmpAddr1 := L.street_address;
		tmpAddr2 := AppendIF4('',L.CITY,L.STATE,L.ZIP5);
		SELF.orig_address1 := UPPER(tmpAddr1);
		SELF.orig_address2 := UPPER(tmpAddr2);
		SELF.orig_city := UPPER(L.CITY);
		SELF.orig_state := UPPER(L.STATE);
		SELF.orig_zip5 := L.ZIP5[1..5];
		SELF.orig_zip4 := '';
		SELF.orig_county := '';
		SELF.orig_country :='';

		// have to do a clean address to get individual fields like this
		clean_address := PRTE2_Common.Clean_Address.FromLine(L.street_address, l.CITY,l.STATE,L.ZIP5);
		SELF.prim_name  :=  clean_address.prim_name;
		SELF.predir     := clean_address.predir;
		SELF.prim_range := clean_address.prim_range;
		SELF.sec_range  := clean_address.sec_range;					
		SELF.unit_desig := clean_address.unit_desig;
		SELF.postdir    := clean_address.postdir;
		SELF.addr_suffix := clean_address.addr_suffix;
		SELF.p_city_name := clean_address.p_city_name;
		SELF.v_city_name := clean_address.v_city_name;
		SELF.st         := clean_address.st;
		self.zip        := clean_address.zip; 
		self.zip4       := clean_address.zip4;
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
		SELF.msa        := clean_address.msa;
		SELF.geo_blk    := clean_address.geo_blk;
		SELF.geo_match  := clean_address.geo_match;
		// shouldn't we use p_city or v_city below instead of the original city?		
		
		SELF.phone := '';					// NOT THERE
		SELF.name_type := 'D';		// imitating what I see in PRCT data which had: 6130=D, 12=A and 26=C

		// THESE NEED TO COME LATER FROM THE PROD SAMPLE RECORD
		SELF.date_first_seen := '';		//L.date_first_seen;
		SELF.date_last_seen := '';		//L.date_last_seen;
		SELF.date_vendor_first_reported := '';		//L.date_first_seen;
		SELF.date_vendor_last_reported := '';		//L.date_last_seen;

		SELF.cname 				:= '';							// no businesses
		SELF.BDID 				:= '';							// no businesses
		SELF.tax_id 			:= '';							// no businesses

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
PartyMid := PROJECT(IncomingPeople,trxParty(LEFT,COUNTER));

// ---------------- DO we have any records whose DID already exists in Boca Header?
PartyBocaHit0 := JOIN(PartyMid,PerHeadKey,
										(unsigned6)left.DID = right.s_did,
												TRANSFORM({PartyBocaHitLayout},
														SELF.BocaHit := IF(RIGHT.s_did=0,'','Y'),
														SELF := LEFT),
										LEFT OUTER
										);
// Dedup on the exJoinInt that was prepared prior to the BocaHit join since the Party can have multiple records per did.
PartyBocaHit_All := DEDUP(SORT(PartyBocaHit0,ExJoinInt),ExJoinInt);	

// Now separate hits from non-hits.
PartyHits := PROJECT(PartyBocaHit_All(BocaHit='Y'),PartyJoinLayout);			// Keep these initially to report on them and review
PartyNoHit := PROJECT(PartyBocaHit_All(BocaHit<>'Y'),PartyJoinLayout);
OUTPUT(COUNT(IncomingPeople),NAMED('IncomingPeople'));						//
OUTPUT(COUNT(PartyHits),NAMED('PartyHits'));											// just in case we have any.
//----------------------------------------------------------
OUTPUT(COUNT(PartyHits),NAMED('Cnt_PartyReadyHits'));
OUTPUT(COUNT(PartyNoHit),NAMED('Cnt_PartyReadyNoHits'));
//----------------------------------------------------------
// PartyReady := SORT(PartyHits+PartyNoHit,st,joinint);									// Keep hits initially to report on them and review
PartyReady := SORT(PartyNoHit,st,joinint);														// Later only process the no hits.
//----------------------------------------------------------
PartyReady2 := JOIN(PartyReady,GatheredParties,
											LEFT.JoinInt = RIGHT.JoinInt AND LEFT.st = RIGHT.st,
											TRANSFORM({PartyReady},
												SELF.tmsid := RIGHT.tmsid,
												SELF.rmsid := RIGHT.rmsid,
												SELF.phone := RIGHT.phone,
												SELF.name_type := 'D', //??
												SELF.date_first_seen := RIGHT.date_first_seen,
												SELF.date_last_seen := RIGHT.date_last_seen,
												SELF.date_vendor_first_reported := RIGHT.date_vendor_first_reported,
												SELF.date_vendor_last_reported := RIGHT.date_vendor_last_reported,
												SELF.persistent_record_id :=0,
											, SELF := LEFT));
//----------------------------------------------------------
OUTPUT(PartyReady2,NAMED('PartyReady2'));

//-----------------------------------------------------------------------------------------
tmsIDSignificant(STRING S1) := S1[1..2];
anyNonBlank(STRING S1, STRING S2) := IF(TRIM(S1)='',S2,S1);
bestFilingString(STRING S1, STRING S2,STRING S3) := AnyNonBlank(AnyNonBlank(S1,S2),S3);

// date logic - last minute change here to workaround some dates ending up a year in future.
// workaround worked but we really ought to re-think the entire thing.  Not sure what the full intention of 
//    two dates going into FIXYearWithCheck was.
FIXYear := PRTE2_Liens_Ins_DataPrep.Fn_DateMath.FIXYear;
FIXYearWithCheck := PRTE2_Liens_Ins_DataPrep.Fn_DateMath.FIXYearWithCheck;
FIXFilingYear := PRTE2_Liens_Ins_DataPrep.Fn_DateMath.FIXFilingYear;
// **********************************************************************************************
PartyTemp := PROJECT(SORT(PartyReady2,tmsid),TRANSFORM({PartyExJoinLayout},
										SELF.exJoinInt := COUNTER,
										SELF.ln_product_tie := IF(TRIM(LEFT.ln_product_tie)='','Risk_Classifier',LEFT.ln_product_tie);
										SELF := LEFT));
MainRelated0 := JOIN(PartyTemp,GatheredMains,
											LEFT.tmsid = RIGHT.tmsid AND left.rmsid=RIGHT.rmsid,
											TRANSFORM({Layouts.BaseMainRenumberJoin},
												SELF.exJoinInt1 := LEFT.st+':'+INTFORMAT(LEFT.JoinInt,5,0),
												SELF.ln_product_tie := LEFT.ln_product_tie;
												SELF := RIGHT),
											LEFT OUTER);
MainRelated := DEDUP(SORT(MainRelated0,joinInt),joinInt);
OUTPUT(MainRelated,NAMED('MainRelated'));	//
OUTPUT(COUNT(MainRelated),NAMED('CNT_MainRelated'));

// ****************************** USE SAME Formula to alter tmsid and rmsid or links break ***************
PartyTemp2 := PROJECT(SORT(PartyTemp,tmsid),TRANSFORM({PartyExJoinLayout},
									SELF.persistent_record_id := 0;
									tmsCut := IF(LEFT.rmsid[3]='R',2,3);	// different sources have different rules on rmsid
									tmsCut2 := tmsCut+1;
									tms1 := LEFT.tmsid[1..tmsCut];
									tms2 := LEFT.tmsid[tmsCut2..];
									SELF.tmsid := tms1+'I'+tms2;
									rms1 := LEFT.rmsid[1..3];
									rms2 := LEFT.rmsid[4..];
									SELF.rmsid := rms1+'I'+rms2;
									SELF.date_first_seen := FIXYear(LEFT.date_first_seen);
									SELF.date_last_seen := FIXYear(LEFT.date_last_seen);
									SELF.date_vendor_first_reported := FIXYear(LEFT.date_vendor_first_reported);
									SELF.date_vendor_last_reported := FIXYear(LEFT.date_vendor_last_reported);
									SELF := LEFT));

MainTemp1 := PROJECT(SORT(MainRelated,tmsid),TRANSFORM({Layouts.BaseMainRenumberJoin},
									SELF.persistent_record_id := 0,
									tmsCut := IF(LEFT.rmsid[3]='R',2,3);
									tmsCut2 := tmsCut+1;
									tms1 := LEFT.tmsid[1..tmsCut];
									tms2 := LEFT.tmsid[tmsCut2..];
									SELF.tmsid := tms1+'I'+tms2;
									rms1 := LEFT.rmsid[1..3];
									rms2 := LEFT.rmsid[4..];
									SELF.rmsid := rms1+'I'+rms2;
									SELF.bcbflag := TRUE;
									SELF.process_date := FIXYearWithCheck(LEFT.filing_date,LEFT.process_date);
									SELF.date_vendor_removed := FIXYearWithCheck(LEFT.filing_date,LEFT.date_vendor_removed);
									SELF.orig_filing_date := FIXYearWithCheck(LEFT.filing_date,LEFT.orig_filing_date);
									SELF.orig_filing_time := FIXYearWithCheck(LEFT.filing_date,LEFT.orig_filing_time);
									SELF.filing_date := FIXFilingYear(LEFT.filing_date);
									SELF.vendor_entry_date := FIXYearWithCheck(LEFT.filing_date,LEFT.vendor_entry_date);
									SELF.release_date := FIXYearWithCheck(LEFT.filing_date,LEFT.release_date);
									SELF.judg_satisfied_date := FIXYearWithCheck(LEFT.filing_date,LEFT.judg_satisfied_date);
									SELF.judg_vacated_date := FIXYearWithCheck(LEFT.filing_date,LEFT.judg_vacated_date);
									SELF.effective_date := FIXYearWithCheck(LEFT.filing_date,LEFT.effective_date);
									SELF.lapse_date := FIXYearWithCheck(LEFT.filing_date,LEFT.lapse_date);
									SELF.accident_date := FIXYearWithCheck(LEFT.filing_date,LEFT.accident_date);
									SELF.expiration_date := FIXYearWithCheck(LEFT.filing_date,LEFT.expiration_date);
									SELF := LEFT));
// END ************************** USE SAME Formula to alter tmsid and rmsid ******************************

MainTemp1 trxMainF(MainTemp1 L) := TRANSFORM
					origFilingNum 					:= TRIM(bestFilingString(L.filing_number,L.case_number,L.orig_filing_number));
					tmsSig 									:= TRIM(tmsIDSignificant(L.tmsid));
					uniqifier								:= INTFORMAT(L.joinInt,7,1)[4..];
					origFilingHash					:= (STRING)HASH(origFilingNum); //[9..];
					filingString 						:= TRIM(origFilingHash)+'ICT'+uniqifier;
					tmsSufStart							:= length(TRIM(L.tmsid))-2;		// was 2 go ahead and get a bit more
					rmsSufStart							:= length(TRIM(L.rmsid))-4;		// was 2 go ahead and get a bit more
					rmsSuffix								:= L.rmsid[rmsSufStart..];
					tmsSuffix								:= L.tmsid[tmsSufStart..];
					SELF.orig_filing_number := IF(L.orig_filing_number<>'', filingString,'');		// fill from above if not blank
					SELF.case_number 				:= IF(L.case_number<>'', filingString,'');					// fill from above if not blank
					SELF.filing_number 			:= IF(L.filing_number<>'', filingString,'');				// fill from above if not blank
					SELF.filing_type_desc		:= IF(TRIM(L.filing_type_desc)<>'',L.filing_type_desc,L.orig_filing_type);
					WordArray := STD.Str.SplitWords(L.Filing_status,'!');
					SELF.filing_status 			:= WordArray[1];
					SELF.filing_status_desc	:= WordArray[2];
					SELF := L;
END;					
MainTemp2 := PROJECT(MainTemp1,trxMainF(LEFT));

//-----------------------------------------------------------------------------------------
PartyFinal := SORT(PartyTemp2,tmsid,joinint);
MainFinal := SORT(MainTemp2(joinint>0),tmsid,joinint);

PromoteSupers.Mac_SF_BuildProcess(PartyFinal, Files.Save_PartyWIP_Name, buildBase1,2);
PromoteSupers.Mac_SF_BuildProcess(MainFinal, Files.Save_MainWIP_Name, buildBase2,2);
PromoteSupers.Mac_SF_BuildProcess(SORT(PartyHits,tmsid), Files.Incoming_BocaHit_Name, buildBase3,2);

SEQUENTIAL(buildBase1,buildBase2,buildBase3);
