import address, doxie, ut, bankruptcyv2, risk_indicators, std;

slimmerrec := RECORD
	address.Layout_Clean182;
	string12 	geolink;
	unsigned6 did;
	unsigned6 bdid;
	BOOLEAN 	bankrupt := false;
	UNSIGNED4	date_last_seen := 0;
	STRING1 	filing_type := '';
	STRING35 	disposition := '';	
	UNSIGNED1 filing_count := 0;
	UNSIGNED1 bk_recent_count := 0;
	UNSIGNED1 bk_disposed_recent_count := 0;
	UNSIGNED1 bk_disposed_historical_count := 0;
	UNSIGNED1 bk_count30 := 0;
	UNSIGNED1 bk_count90 := 0;
	UNSIGNED1 bk_count180 := 0;
	UNSIGNED1 bk_count12 := 0;
	UNSIGNED1 bk_count24 := 0;
	UNSIGNED1 bk_count36 := 0;
	UNSIGNED1 bk_count48 := 0;
	UNSIGNED1 bk_count60 := 0;	
	UNSIGNED1	bk_ch7_cnt := 0;
	UNSIGNED1	bk_ch11_cnt := 0;
	UNSIGNED1	bk_ch12_cnt := 0;
	UNSIGNED1	bk_ch13_cnt := 0;
	UNSIGNED1	bk_discharged_cnt := 0;
	UNSIGNED1 bk_dismissed_cnt := 0;
	UNSIGNED1	bk_pro_se_cnt := 0;
	UNSIGNED1	bk_business_flag_cnt := 0;
	UNSIGNED1	bk_corp_flag_cnt := 0;
// UNSIGNED1	bk_assets_available_cnt := 0;
// UNSIGNED1	bk_joint_flag_cnt := 0;
END;


slimrec := record
	slimmerrec;
	string5    court_code;
	string7    case_num; 
END;

//

myGetDate := (STRING8)Std.Date.Today();
historydate := 999999;
slimrec get_bkrupt(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.did;
	self.bdid := (integer)L.bdid;
	
	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.orig_addr1, l.orig_city, l.orig_st, l.orig_zip5);
	self.prim_range := clean_address [1..10];
	self.predir := clean_address [11..12];
	self.prim_name := clean_address [13..40];
	self.addr_suffix := clean_address [41..44];
	self.postdir := clean_address [45..46];
	self.unit_desig := clean_address [47..56];
	self.sec_range := clean_address [57..65];
	self.p_city_name := clean_address [90..114];
	self.st := clean_address [115..116];
	self.zip := clean_address [117..121];
	self.zip4 := clean_address[122..125];
	self.county := clean_address[143..145];
	self.geo_lat := clean_address[146..155];
	self.geo_long := clean_address[156..166];
	self.msa := clean_address[167..170];
	self.geo_blk := clean_address[171..177];
	self.geo_match := clean_address[178];
	
	//build geolink for AddrRisk
	self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];	
	
	self.v_city_name := l.v_city_name;  
	self.cr_sort_sz := l.cr_sort_sz;
	self.cart := l.cart;
	self.lot := l.lot;	
	self.lot_order := l.lot_order;	
	self.dbpc := l.dbpc;		
	self.chk_digit := l.chk_digit;	
	self.rec_type := l.rec_type;	
	self.err_stat := l.err_stat;	
	
		// disposition and date file used to be on the main, but they're on the search file now
	self.filing_type := l.filing_type;
	self.disposition := l.disposition;
	date_last_seen := MAX((INTEGER)trim(l.date_filed), (INTEGER)trim(l.discharged));  // discharged now instead of disposed_date
	self.date_last_seen := date_last_seen;
	SELF.bk_disposed_recent_count := (INTEGER)(trim(l.disposition)<>'' AND ut.DaysApart(trim(l.discharged),myGetDate)<365*2+1);
	SELF.bk_disposed_historical_count := (INTEGER)(trim(l.disposition)<>'' AND ut.DaysApart(trim(l.discharged),myGetDate)>365*2);
	
	SELF.bk_count30  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,30, historydate);
	SELF.bk_count90  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,90, historydate);
	SELF.bk_count180 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,180, historydate);
	SELF.bk_count12  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(1), historydate);
	SELF.bk_count24  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(2), historydate);
	SELF.bk_count36  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(3), historydate);
	SELF.bk_count48  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(4), historydate);
	SELF.bk_count60  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(5), historydate);
	
	SELF.bk_ch7_cnt  := (integer)(trim(l.chapter) =  '7');
	SELF.bk_ch11_cnt := (integer)(trim(l.chapter) = '11');
	SELF.bk_ch12_cnt := (integer)(trim(l.chapter) = '12');
	SELF.bk_ch13_cnt := (integer)(trim(l.chapter) = '13');
	
	SELF.bk_discharged_cnt := (integer)(trim(l.disposition) = 'Discharged');
	SELF.bk_dismissed_cnt  := (integer)(trim(l.disposition) = 'Dismissed');
	SELF.bk_pro_se_cnt  := (integer)(trim(l.pro_se_ind) = 'Y');
	
	SELF.bk_business_flag_cnt := (integer)(trim(l.business_flag) <> 'I' OR (integer)l.bdid <> 0 OR l.cname <> '');
	SELF.bk_corp_flag_cnt := (integer)(trim(l.corp_flag) = 'Y' AND ((integer)l.bdid <> 0 OR l.cname <> ''));
	// SELF.bk_assets_available_cnt := (integer)(l.chapter =  '7');  //missing from 
	// SELF.bk_joint_flag_cnt := (integer)(l.chapter =  '7');
	
	self := []
end;

w_bksearch := project(BankruptcyV2.file_bankruptcy_search_v3((integer)did != 0 and name_type='D'),			
				get_bkrupt(LEFT));

// output(w_bksearch, named('w_bksearch'));				

slimrec get_bkmain(w_bksearch Le, BankruptcyV2.file_bankruptcy_main_v3 Ri) := transform
	SELF.bankrupt := ri.case_number<>'';
 	hit := ri.case_number<>'';
	SELF.filing_count := (INTEGER)hit;
	SELF.bk_recent_count := (INTEGER)(hit AND le.disposition='');
	self := le;
end;

w_bksearch_dist := distribute( w_bksearch, hash(trim(case_num),trim(court_code)));
main_dist := distribute( BankruptcyV2.file_bankruptcy_main_v3, hash(trim(case_number),trim(court_code)));

w_bk := join(w_bksearch_dist, main_dist,
			LEFT.case_num<>'' AND LEFT.court_code<>'' AND
			left.case_num = right.case_number and
			left.court_code = right.court_code,
		   get_bkmain(LEFT,RIGHT), local);

// output(w_bk, named('w_bk'));

slimrec roll_bankrupt(w_bk le, w_bk ri) := TRANSFORM

	sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
	SELF.bankrupt := le.bankrupt OR ri.bankrupt;
	
	// keep the filing type and disposition together with the date that is selected 
	// instead of always selecting the left filing type and left disposition
	use_right := ri.date_last_seen > le.date_last_seen;
	SELF.date_last_seen := if(use_right, ri.date_last_seen, le.date_last_seen);
	SELF.filing_type := if(use_right, ri.filing_type, le.filing_type);
	SELF.disposition := if(use_right, ri.disposition, le.disposition);
	
	SELF.filing_count := le.filing_count + IF(sameBankruptcy,0,ri.filing_count);
	SELF.bk_recent_count := le.bk_recent_count + IF(sameBankruptcy,0,ri.bk_recent_count);
	SELF.bk_disposed_recent_count := le.bk_disposed_recent_count + IF(sameBankruptcy,0,ri.bk_disposed_recent_count);
	SELF.bk_disposed_historical_count := le.bk_disposed_historical_count + IF(sameBankruptcy,0,ri.bk_disposed_historical_count);							
	
	SELF.bk_count30 := le.bk_count30 + IF(sameBankruptcy,0,ri.bk_count30);
	SELF.bk_count90 := le.bk_count90 + IF(sameBankruptcy,0,ri.bk_count90);							
	SELF.bk_count180:= le.bk_count180+ IF(sameBankruptcy,0,ri.bk_count180);
	SELF.bk_count12 := le.bk_count12 + IF(sameBankruptcy,0,ri.bk_count12);
	SELF.bk_count24 := le.bk_count24 + IF(sameBankruptcy,0,ri.bk_count24);
	SELF.bk_count36 := le.bk_count36 + IF(sameBankruptcy,0,ri.bk_count36);
	SELF.bk_count48 := le.bk_count48 + IF(sameBankruptcy,0,ri.bk_count48);
	SELF.bk_count60 := le.bk_count60 + IF(sameBankruptcy,0,ri.bk_count60);
			
	SELF.bk_ch7_cnt := le.bk_ch7_cnt + IF(sameBankruptcy,0,ri.bk_ch7_cnt);
	SELF.bk_ch11_cnt:= le.bk_ch11_cnt+ IF(sameBankruptcy,0,ri.bk_ch11_cnt);
	SELF.bk_ch12_cnt:= le.bk_ch12_cnt+ IF(sameBankruptcy,0,ri.bk_ch12_cnt);
	SELF.bk_ch13_cnt:= le.bk_ch13_cnt+ IF(sameBankruptcy,0,ri.bk_ch13_cnt);
	
	SELF.bk_discharged_cnt := le.bk_discharged_cnt + IF(sameBankruptcy,0,ri.bk_discharged_cnt);
	SELF.bk_dismissed_cnt  := le.bk_dismissed_cnt + IF(sameBankruptcy,0,ri.bk_dismissed_cnt);
	SELF.bk_pro_se_cnt  	 := le.bk_pro_se_cnt + IF(sameBankruptcy,0,ri.bk_pro_se_cnt);
	
	SELF.bk_business_flag_cnt := le.bk_business_flag_cnt + IF(sameBankruptcy,0,ri.bk_business_flag_cnt);
	SELF.bk_corp_flag_cnt := le.bk_corp_flag_cnt + IF(sameBankruptcy,0,ri.bk_corp_flag_cnt);
	
	// SELF.bk_assets_available_cnt := le.bk_assets_available_cnt + IF(sameBankruptcy,0,ri.bk_assets_available_cnt);
	// SELF.bk_joint_flag_cnt := le.bk_joint_flag_cnt + IF(sameBankruptcy,0,ri.bk_joint_flag_cnt);
	
	SELF := le;
END;

bankrupt_rolled := ROLLUP(SORT(distribute(w_bk, did), did,court_code,case_num,-date_last_seen, local), LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);

export file_bankruptcy := PROJECT(bankrupt_rolled, slimmerrec);