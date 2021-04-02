import _Control, Risk_Indicators, dx_header, RiskWise, InfutorCID, dx_Gong, header_quick, MDR, ut, address, AID_Build, ProfileBooster, Doxie, Suppress, EmailV2_Services, Gateway, dx_BestRecords, dx_ProfileBooster;
onThor := _Control.Environment.OnThor;

EXPORT V2_getVerification(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Shell) PB2Shell,
											doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	nines	 := 9999999;

infutorcid_key := InfutorCID.Key_Infutor_DID;
gonghistorydid_key := dx_Gong.key_history_did();
header_key := dx_header.key_header();
quickheader_key := header_quick.key_DID;
address_rank_key := dx_header.key_addr_hist();

//search Infutor by DID to verify input name, address, phone
	{ProfileBooster.V2_Layouts.Layout_PB2_Shell, UNSIGNED4 global_sid} getInfutor(PB2Shell le, infutorcid_key ri) := transform
		EmrgDt_first_seen        := IF(ri.dt_first_seen=0,99998888,ri.dt_first_seen);
		self.EmrgDt_first_seen   := EmrgDt_first_seen;
		self.EmrgSrc             := MDR.sourceTools.src_InfutorCID;
		//No DOB in InfutorCID
		self.EmrgPrimaryRange    := ri.prim_range;
		self.EmrgPredirectional	 := ri.predir;
		self.EmrgPrimaryName	 := ri.prim_name;
		self.EmrgSuffix	         := ri.addr_suffix;	
		self.EmrgPostdirectional := ri.postdir;
		self.EmrgUnitDesignation := ri.unit_desig;
		self.EmrgSecondaryRange	 := ri.sec_range;
		self.EmrgCity_Name	     := ri.p_city_name;	
		self.EmrgSt			     := ri.st;
		self.EmrgZIP5			 := ri.zip;
		self.EmrgZIP4		     := ri.zip4;
		
		self.global_sid := ri.global_sid;
		self.firstscore 	:= Risk_Indicators.FnameScore(le.fname, ri.fname);
		self.firstcount 	:= (integer)Risk_Indicators.iid_constants.g(self.firstscore);
		self.lastscore 		:= Risk_Indicators.LnameScore(le.lname, ri.lname);
		self.lastcount 		:= (integer)Risk_Indicators.iid_constants.g(self.lastscore);
		zip_score 				:= Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
		cityst_score 			:= Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.p_city_name, ri.st, '1');
		self.addrscore 		:= Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
																														 ri.prim_range, ri.prim_name, ri.sec_range,
																														 zip_score, cityst_score);
		self.addrcount 		:= (integer)Risk_Indicators.iid_constants.ga(self.AddrScore);
		self.phonescore 	:= Risk_Indicators.PhoneScore(le.phone10, ri.phone);
		self.phonecount 	:= (integer)Risk_Indicators.iid_constants.gn(self.phonescore);
		self 							:= le;
	end;

	wInfutorcid_roxie_unsuppressed := join(PB2Shell, infutorcid_key,
										left.did<>0 and
										keyed(left.did=right.did) and
										right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
										getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));

	wInfutorcid_roxie_flagged := Suppress.MAC_FlagSuppressedSource(wInfutorcid_roxie_unsuppressed, mod_access);

wInfutorcid_roxie := PROJECT(wInfutorcid_roxie_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
    SELF := LEFT;
));

	wInfutorcid_thor_unsuppressed := join(distribute(PB2Shell, did), distribute(pull(infutorcid_key), did),
										left.did<>0 and
										left.did=right.did and
										right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
										getInfutor(left,right), left outer, KEEP(100), local);

	wInfutorcid_thor_flagged := Suppress.MAC_FlagSuppressedSource(wInfutorcid_thor_unsuppressed, mod_access);

	wInfutorcid_thor := PROJECT(wInfutorcid_thor_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
    SELF := LEFT;
));

	#IF(onThor)
		wInfutorCid := wInfutorCid_thor;
	#ELSE
		wInfutorCid := wInfutorCid_roxie;
	#END

//search Gong by DID to verify input name, address, phone
	{ProfileBooster.V2_Layouts.Layout_PB2_Shell, UNSIGNED4 global_sid} getGong(PB2Shell le, gonghistorydid_key ri) := transform
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR le.EmrgDt_first_seen IN [0,99998]; 
		EmrgDt_first_seen        := IF(ri.dt_first_seen='0',(STRING)le.EmrgDt_first_seen,(STRING)ri.dt_first_seen);
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ri.dt_first_seen,(UNSIGNED6)EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.src,le.EmrgSrc);
		//No DOB in Gong
		self.EmrgPrimaryRange    := IF(OlderErmgRecord,ri.prim_range,le.EmrgPrimaryRange);
		self.EmrgPredirectional	 := IF(OlderErmgRecord,ri.predir,le.EmrgPredirectional);
		self.EmrgPrimaryName	 := IF(OlderErmgRecord,ri.prim_name,le.EmrgPrimaryName);
		self.EmrgSuffix	         := IF(OlderErmgRecord,ri.suffix,le.EmrgSuffix);	
		self.EmrgPostdirectional := IF(OlderErmgRecord,ri.postdir,le.EmrgPostdirectional);
		self.EmrgUnitDesignation := IF(OlderErmgRecord,ri.unit_desig,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	 := IF(OlderErmgRecord,ri.sec_range,le.EmrgSecondaryRange);
		self.EmrgCity_Name	     := IF(OlderErmgRecord,ri.p_city_name,le.EmrgCity_Name);	
		self.EmrgSt			     := IF(OlderErmgRecord,ri.st,le.EmrgSt);
		self.EmrgZIP5			 := IF(OlderErmgRecord,ri.z5,le.EmrgZIP5);
		self.EmrgZIP4		     := IF(OlderErmgRecord,ri.z4,le.EmrgZIP4);
		
		self.global_sid 			:= ri.global_sid;
		self.firstscore 	:= Risk_Indicators.FnameScore(le.fname, ri.name_first);
		self.firstcount 	:= (integer)Risk_Indicators.iid_constants.g(self.firstscore);
		self.lastscore 		:= Risk_Indicators.LnameScore(le.lname, ri.name_last);
		self.lastcount 		:= (integer)Risk_Indicators.iid_constants.g(self.lastscore);
		zip_score 				:= Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.z5);
		cityst_score 			:= Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.v_city_name, ri.st, '1');
		self.addrscore 		:= Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
																														 ri.prim_range, ri.prim_name, ri.sec_range,
																														 zip_score, cityst_score);
		self.addrcount 		:= (integer)Risk_Indicators.iid_constants.ga(self.AddrScore);
		self.phonescore 	:= Risk_Indicators.PhoneScore(le.phone10, ri.phone10);
		self.phonecount 	:= (integer)Risk_Indicators.iid_constants.gn(self.phonescore);
		self 							:= le;
	end;

	wGong_roxie_unsuppressed := join(PB2Shell, gonghistorydid_key,
										left.did<>0 and
										keyed(left.did=right.l_did) and
										right.dt_first_seen < risk_indicators.iid_constants.myGetDate(left.historydate),
										getGong(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));

	wGong_roxie_flagged := Suppress.MAC_FlagSuppressedSource(wGong_roxie_unsuppressed, mod_access);

	wGong_roxie := PROJECT(wGong_roxie_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
    SELF := LEFT;));

	wGong_thor_unsuppressed := join(distribute(PB2Shell, did), distribute(pull(gonghistorydid_key), did),
										left.did<>0 and
										left.did=right.l_did and
										right.dt_first_seen < risk_indicators.iid_constants.myGetDate(left.historydate),
										getGong(left,right), left outer, KEEP(100), local);

	wGong_thor_flagged := Suppress.MAC_FlagSuppressedSource(wGong_thor_unsuppressed, mod_access);

	wGong_thor := PROJECT(wGong_thor_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
    SELF := LEFT;));

	#IF(onThor)
		wGong := wGong_thor;
	#ELSE
		wGong := wGong_roxie;
	#END

//search header by DID to verify input name, address, phone, SSN
	{ProfileBooster.V2_Layouts.Layout_PB2_Shell, UNSIGNED4 global_sid} getHeader(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, header_key ri) := transform
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR le.EmrgDt_first_seen IN [0,99998]; 
		EmrgDt_first_seen        := IF(ri.dt_first_seen=0,le.EmrgDt_first_seen,ri.dt_first_seen);
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ri.dt_first_seen,EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.src,le.EmrgSrc);
		EmrgDob	:= MAP(~OlderErmgRecord                       => le.EmrgDob, 
		               ri.src=mdr.sourceTools.src_TUCS_Ptrack => le.EmrgDob, 
															     (STRING)ri.dob);
		self.EmrgDob			 := EmrgDob;
		fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		//first attempt at calculating EmrgAge
		self.EmrgAge   			 := if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, -99997, risk_indicators.years_apart((unsigned)EmrgDt_first_seen, (unsigned)EmrgDob));
		self.EmrgPrimaryRange    := IF(OlderErmgRecord,ri.prim_range,le.EmrgPrimaryRange);
		self.EmrgPredirectional	 := IF(OlderErmgRecord,ri.predir,le.EmrgPredirectional);
		self.EmrgPrimaryName	 := IF(OlderErmgRecord,ri.prim_name,le.EmrgPrimaryName);
		self.EmrgSuffix	         := IF(OlderErmgRecord,ri.suffix,le.EmrgSuffix);	
		self.EmrgPostdirectional := IF(OlderErmgRecord,ri.postdir,le.EmrgPostdirectional);
		self.EmrgUnitDesignation := IF(OlderErmgRecord,ri.unit_desig,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	 := IF(OlderErmgRecord,ri.sec_range,le.EmrgSecondaryRange);
		self.EmrgCity_Name	     := IF(OlderErmgRecord,ri.city_name,le.EmrgCity_Name);	
		self.EmrgSt			     := IF(OlderErmgRecord,ri.st,le.EmrgSt);
		self.EmrgZIP5			 := IF(OlderErmgRecord,ri.zip,le.EmrgZIP5);
		self.EmrgZIP4		     := IF(OlderErmgRecord,ri.zip4,le.EmrgZIP4);
		
		self.global_sid 					:= ri.global_sid;
		self.firstscore 			:= Risk_Indicators.FnameScore(le.fname, ri.fname);
		self.firstcount 			:= (integer)Risk_Indicators.iid_constants.g(self.firstscore);
		self.lastscore 				:= Risk_Indicators.LnameScore(le.lname, ri.lname);
		self.lastcount 				:= (integer)Risk_Indicators.iid_constants.g(self.lastscore);
		zip_score 						:= Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
		cityst_score 					:= Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.city_name, ri.st, '1');
		self.addrscore 				:= Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		zip_score, cityst_score);
		self.addrcount 				:= (integer)Risk_Indicators.iid_constants.ga(self.AddrScore);
		self.phonescore 			:= Risk_Indicators.PhoneScore(le.phone10, ri.phone);
		self.phonecount 			:= (integer)Risk_Indicators.iid_constants.gn(self.phonescore);
		self.socsscore 				:= Risk_Indicators.PhoneScore(le.ssn, ri.ssn);
		self.socscount 				:= (integer)Risk_Indicators.iid_constants.gn(self.socsscore);
		self.dt_first_seen 		:= ri.dt_first_seen;

    	historydate := (unsigned)fullhistorydate[1..6];
		self.dt_last_seen			:= if(ri.dt_last_seen > HistoryDate, HistoryDate, ri.dt_last_seen);
		self.dob							:= if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, '', (string)ri.dob);
    self.ProspectAge 			:= if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)ri.dob));
		self.title						:= ri.title;
		self.HHID							:= IF(ri.HHID = 0, le.HHID, ri.HHID);
		self.hdr_prim_range		:= ri.prim_range;
		self.hdr_predir				:= ri.predir;
		self.hdr_prim_name		:= ri.prim_name;
		self.hdr_addr_suffix	:= ri.suffix;
		self.hdr_postdir			:= ri.postdir;
		self.hdr_unit_desig		:= ri.unit_desig;
		self.hdr_sec_range		:= ri.sec_range;
		self.hdr_z5						:= ri.zip;
		self.hdr_zip4					:= ri.zip4;
		self.hdr_city_name		:= ri.city_name;
		self.hdr_st						:= ri.st;
		self.hdr_county				:= ri.county;
		self.hdr_geo_blk			:= ri.geo_blk;
		self.hdr_lname				:= ri.lname;
		self.hdr_addr1				:= trim(ri.prim_range) + trim(ri.prim_name);
		self.hdr_rawaid 			:= ri.rawaid;
		inputAddrFound				:= le.prim_range = ri.prim_range and le.prim_name = ri.prim_name and le.z5 = ri.zip;
		self.VerifiedCurrResMatchIndex	:= if(inputAddrFound, '1', '0'); //if input address is on header, flag it as being known
		self									:= le;
	end;

	wHeader_roxie_unsuppressed := join(PB2Shell, header_key,
										left.DID <> 0 and
										keyed(left.DID = right.s_DID) and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(200), atmost(RiskWise.max_atmost));

	wHeader_roxie_flagged := Suppress.MAC_FlagSuppressedSource(wHeader_roxie_unsuppressed, mod_access);

	wHeader_roxie := PROJECT(wHeader_roxie_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
		self.socsscore 				:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.socsscore);
		self.socscount 				:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.socscount);
		self.dt_first_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
		self.dt_last_seen			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
		self.dob							:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.dob);
		self.ProspectAge 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.ProspectAge);
		self.title						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.title);
		self.HHID							:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.HHID);
		self.hdr_prim_range		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_prim_range);
		self.hdr_predir				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_predir);
		self.hdr_prim_name		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_prim_name);
		self.hdr_addr_suffix	:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_addr_suffix);
		self.hdr_postdir			:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_postdir);
		self.hdr_unit_desig		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_unit_desig);
		self.hdr_sec_range		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_sec_range);
		self.hdr_z5						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_z5);
		self.hdr_zip4					:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_zip4);
		self.hdr_city_name		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_city_name);
		self.hdr_st						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_st);
		self.hdr_county				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_county);
		self.hdr_geo_blk			:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_geo_blk);
		self.hdr_lname				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_lname);
		self.hdr_addr1				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_addr1);
		self.hdr_rawaid 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.hdr_rawaid);
    SELF := LEFT;));

	wHeader_thor_unsuppressed := join(distribute(PB2Shell, did), distribute(pull(header_key), s_did),
										left.DID <> 0 and
										left.DID = right.s_DID and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(200), local);

	wHeader_thor_flagged := Suppress.MAC_FlagSuppressedSource(wHeader_thor_unsuppressed, mod_access);

	wHeader_thor := PROJECT(wHeader_roxie_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
		self.firstscore 	:=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstscore);
		self.firstcount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.firstcount);
		self.lastscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastscore);
		self.lastcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.lastcount);
		self.addrscore 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrscore);
		self.addrcount 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.addrcount);
		self.phonescore 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonescore);
		self.phonecount 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.phonecount);
		self.socsscore 				:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.socsscore);
		self.socscount 				:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.socscount);
		self.dt_first_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
		self.dt_last_seen			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
		self.dob							:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.dob);
		self.ProspectAge 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.ProspectAge);
		self.title						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.title);
		self.HHID							:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.HHID);
		self.hdr_prim_range		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_prim_range);
		self.hdr_predir				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_predir);
		self.hdr_prim_name		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_prim_name);
		self.hdr_addr_suffix	:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_addr_suffix);
		self.hdr_postdir			:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_postdir);
		self.hdr_unit_desig		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_unit_desig);
		self.hdr_sec_range		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_sec_range);
		self.hdr_z5						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_z5);
		self.hdr_zip4					:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_zip4);
		self.hdr_city_name		:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_city_name);
		self.hdr_st						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_st);
		self.hdr_county				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_county);
		self.hdr_geo_blk			:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_geo_blk);
		self.hdr_lname				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_lname);
		self.hdr_addr1				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.hdr_addr1);
		self.hdr_rawaid 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.hdr_rawaid);
    SELF := LEFT;));

	#IF(onThor)
		wHeader := wHeader_thor;
	#ELSE
		wHeader := wHeader_roxie;
	#END

	{ProfileBooster.V2_Layouts.Layout_PB2_Shell, UNSIGNED4 global_sid} getQHeader(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, quickheader_key ri) := transform
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR le.EmrgDt_first_seen=0; 
		EmrgDt_first_seen := IF(OlderErmgRecord,ri.dt_first_seen,le.EmrgDt_first_seen);
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ri.dt_first_seen,EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.src,le.EmrgSrc);
		EmrgDob	:= MAP(~OlderErmgRecord                       => le.EmrgDob, 
		               ri.src=mdr.sourceTools.src_TUCS_Ptrack => le.EmrgDob, 
															     (STRING)ri.dob);
		self.EmrgDob			 := EmrgDob;
    	fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		self.EmrgAge   			 := if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)EmrgDt_first_seen, (unsigned)EmrgDob));
		self.EmrgPrimaryRange    := IF(OlderErmgRecord,ri.prim_range,le.EmrgPrimaryRange);
		self.EmrgPredirectional	 := IF(OlderErmgRecord,ri.predir,le.EmrgPredirectional);
		self.EmrgPrimaryName	 := IF(OlderErmgRecord,ri.prim_name,le.EmrgPrimaryName);
		self.EmrgSuffix	         := IF(OlderErmgRecord,ri.suffix,le.EmrgSuffix);	
		self.EmrgPostdirectional := IF(OlderErmgRecord,ri.postdir,le.EmrgPostdirectional);
		self.EmrgUnitDesignation := IF(OlderErmgRecord,ri.unit_desig,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	 := IF(OlderErmgRecord,ri.sec_range,le.EmrgSecondaryRange);
		self.EmrgCity_Name	     := IF(OlderErmgRecord,ri.city_name,le.EmrgCity_Name);	
		self.EmrgSt			     := IF(OlderErmgRecord,ri.st,le.EmrgSt);
		self.EmrgZIP5			 := IF(OlderErmgRecord,ri.zip,le.EmrgZIP5);
		self.EmrgZIP4		     := IF(OlderErmgRecord,ri.zip4,le.EmrgZIP4);
		
		self.global_sid			:= ri.global_sid;
		self.firstscore 			:= Risk_Indicators.FnameScore(le.fname, ri.fname);
		self.firstcount 			:= (integer)Risk_Indicators.iid_constants.g(self.firstscore);
		self.lastscore 				:= Risk_Indicators.LnameScore(le.lname, ri.lname);
		self.lastcount 				:= (integer)Risk_Indicators.iid_constants.g(self.lastscore);
		zip_score 						:= Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
		cityst_score 					:= Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.city_name, ri.st, '1');
		self.addrscore 				:= Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		zip_score, cityst_score);
		self.addrcount 				:= (integer)Risk_Indicators.iid_constants.ga(self.AddrScore);
		self.phonescore 			:= Risk_Indicators.PhoneScore(le.phone10, ri.phone);
		self.phonecount 			:= (integer)Risk_Indicators.iid_constants.gn(self.phonescore);
		self.socsscore 				:= Risk_Indicators.PhoneScore(le.ssn, ri.ssn);
		self.socscount 				:= (integer)Risk_Indicators.iid_constants.gn(self.socsscore);
		self.dt_first_seen 		:= ri.dt_first_seen;

    	historydate := (unsigned)fullhistorydate[1..6];
		self.dt_last_seen			:= if(ri.dt_last_seen > HistoryDate, HistoryDate, ri.dt_last_seen);
		self.dob							:= if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, '', (string)ri.dob);
		self.ProspectAge 			:= if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)ri.dob));
   		self.title						:= ri.title;
		self.hdr_prim_range		:= ri.prim_range;
		self.hdr_predir				:= ri.predir;
		self.hdr_prim_name		:= ri.prim_name;
		self.hdr_addr_suffix	:= ri.suffix;
		self.hdr_postdir			:= ri.postdir;
		self.hdr_unit_desig		:= ri.unit_desig;
		self.hdr_sec_range		:= ri.sec_range;
		self.hdr_z5						:= ri.zip;
		self.hdr_zip4					:= ri.zip4;
		self.hdr_city_name		:= ri.city_name;
		self.hdr_st						:= ri.st;
		self.hdr_county				:= ri.county;
		self.hdr_geo_blk			:= ri.geo_blk;
		self.hdr_lname				:= ri.lname;
		self.hdr_addr1				:= trim(ri.prim_range) + trim(ri.prim_name);
		self.hdr_rawaid 			:= ri.rawaid;
		inputAddrFound				:= le.prim_range = ri.prim_range and le.prim_name = ri.prim_name and le.z5 = ri.zip;
		self.VerifiedCurrResMatchIndex	:= if(inputAddrFound, '1', '0'); //if input address is on header, flag it as being known
		self									:= le;
	end;

	wQHeader_roxie_unsuppressed := join(PB2Shell, quickheader_key,
										left.DID <> 0 and
										keyed(left.DID = right.DID) and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));

	wQHeader_roxie := Suppress.Suppress_ReturnOldLayout(wQHeader_roxie_unsuppressed, mod_access, ProfileBooster.V2_Layouts.Layout_PB2_Shell);

	wQHeader_thor_unsuppressed := join(distribute(PB2Shell, did), distribute(pull(quickheader_key), did),
										left.DID <> 0 and
										left.DID = right.DID and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getQHeader(left, right), keep(200), local);

	wQHeader_thor := Suppress.Suppress_ReturnOldLayout(wQHeader_thor_unsuppressed, mod_access, ProfileBooster.V2_Layouts.Layout_PB2_Shell);

	#IF(onThor)
		wQHeader := wQHeader_thor;
	#ELSE
		wQHeader := wQHeader_roxie;
	#END

//sort all verification records by seq
	sortVer := sort(ungroup(wInfutorCid + wGong + wHeader + wQHeader), seq);

//rollup to accumulate the verification counts
  ProfileBooster.V2_Layouts.Layout_PB2_Shell rollVer(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		self.firstcount		:= le.firstcount + ri.firstcount;
		self.lastcount		:= le.lastcount + ri.lastcount;
		self.addrcount		:= le.addrcount + ri.addrcount;
		self.phonecount		:= le.phonecount + ri.phonecount;
		self.socscount		:= le.socscount + ri.socscount;
		self.dt_first_seen		:= map(le.dt_first_seen = 0		=> ri.dt_first_seen,
																 ri.dt_first_seen = 0		=> le.dt_first_seen,
																													 min(le.dt_first_seen, ri.dt_first_seen));
		self.dt_last_seen			:= max(le.dt_last_seen, ri.dt_last_seen);
		self.dob							:= if(le.dob <> '', le.dob, ri.dob);		//keep whichever is populated
		self.ProspectAge			:= if(le.ProspectAge <> 0, le.ProspectAge, ri.ProspectAge);		//keep whichever is populated
		self.title						:= if(le.title <> '', le.title, ri.title);		//keep whichever is populated
		self.HHID							:= if(le.HHID <> 0, le.HHID, ri.HHID);		//keep whichever is populated
		self.VerifiedCurrResMatchIndex	:= if(ri.VerifiedCurrResMatchIndex = '1', ri.VerifiedCurrResMatchIndex, le.VerifiedCurrResMatchIndex);
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.EmrgDt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR le.EmrgDt_first_seen=0;
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,ri.EmrgDt_first_seen,le.EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.EmrgSrc,le.EmrgSrc);
		EmrgDob					 := IF(OlderErmgRecord,ri.EmrgDob,le.EmrgDob);
		self.EmrgDob			 := EmrgDob;
    	fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		EmrgAge     			 := if(OlderErmgRecord,ri.EmrgAge,le.EmrgAge);
		self.EmrgAge   			 := EmrgAge;
		self.EmrgPrimaryRange    := IF(OlderErmgRecord,ri.EmrgPrimaryRange,le.EmrgPrimaryRange);
		self.EmrgPredirectional	 := IF(OlderErmgRecord,ri.EmrgPredirectional,le.EmrgPredirectional);
		self.EmrgPrimaryName	 := IF(OlderErmgRecord,ri.EmrgPrimaryName,le.EmrgPrimaryName);
		self.EmrgSuffix	         := IF(OlderErmgRecord,ri.EmrgSuffix,le.EmrgSuffix);	
		self.EmrgPostdirectional := IF(OlderErmgRecord,ri.EmrgPostdirectional,le.EmrgPostdirectional);
		self.EmrgUnitDesignation := IF(OlderErmgRecord,ri.EmrgUnitDesignation,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	 := IF(OlderErmgRecord,ri.EmrgSecondaryRange,le.EmrgSecondaryRange);
		self.EmrgCity_Name	     := IF(OlderErmgRecord,ri.EmrgCity_Name,le.EmrgCity_Name);	
		self.EmrgSt			     := IF(OlderErmgRecord,ri.EmrgSt,le.EmrgSt);
		self.EmrgZIP5			 := IF(OlderErmgRecord,ri.EmrgZIP5,le.EmrgZIP5);
		self.EmrgZIP4		     := IF(OlderErmgRecord,ri.EmrgZIP4,le.EmrgZIP4);
		
		self									:= le;
	end;

  rolledVer := rollup(sortVer, rollVer(left,right), seq);

	ProfileBooster.V2_Layouts.Layout_PB2_Shell addVerification(PB2Shell le, rolledVer ri) := TRANSFORM
		self.firstscore 	:= ri.firstscore;
		self.firstcount 	:= ri.firstcount;
		self.lastscore 		:= ri.lastscore;
		self.lastcount 		:= ri.lastcount;
		self.addrscore 		:= ri.addrscore;
		self.addrcount 		:= ri.addrcount;
		self.phonescore 	:= ri.phonescore;
		self.phonecount 	:= ri.phonecount;
		self.socsscore 		:= ri.socsscore;
		self.socscount 		:= ri.socscount;
		self.dt_first_seen := ri.dt_first_seen;
		self.dt_last_seen	:= ri.dt_last_seen;
		self.dob					:= ri.dob;
		self.ProspectAge	:= ri.ProspectAge;
		self.title				:= ri.title;
		self.HHID					:= ri.HHID;
		self.VerifiedCurrResMatchIndex	:= ri.VerifiedCurrResMatchIndex;
		self.EmrgDt_first_seen	 := ri.EmrgDt_first_seen;
		self.EmrgSrc             := ri.EmrgSrc;
		self.EmrgDob			 := ri.EmrgDob;
    	self.EmrgAge   			 := ri.EmrgAge;
		self.EmrgPrimaryRange    := ri.EmrgPrimaryRange;
		self.EmrgPredirectional	 := ri.EmrgPredirectional;
		self.EmrgPrimaryName	 := ri.EmrgPrimaryName;
		self.EmrgSuffix	         := ri.EmrgSuffix;	
		self.EmrgPostdirectional := ri.EmrgPostdirectional;
		self.EmrgUnitDesignation := ri.EmrgUnitDesignation;
		self.EmrgSecondaryRange	 := ri.EmrgSecondaryRange;
		self.EmrgCity_Name	     := ri.EmrgCity_Name;	
		self.EmrgSt			     := ri.EmrgSt;
		self.EmrgZIP5			 := ri.EmrgZIP5;
		self.EmrgZIP4		     := ri.EmrgZIP4;
		self 							:= le;
	END;

	wVerification := join(PB2Shell, rolledVer,
													 left.seq = right.seq,
											  addVerification(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));

	allHeader := wHeader + wQHeader; //combine regular header and quick header hits

//only need one record per address so dedup here
	dedupHdr	:= dedup(sort(allHeader, seq, hdr_z5, hdr_prim_range, hdr_prim_name),
																		 seq, hdr_z5, hdr_prim_range, hdr_prim_name);


//join all addresses from the header to the address history key to determine current address versus previous address
	ProfileBooster.V2_Layouts.Layout_PB2_Shell getAddrSeq(dedupHdr le, address_rank_key ri) := TRANSFORM
		single_instance_address 	:= ri.addressstatus[5]='S';
		addr1 := address.Addr1FromComponents(ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range);
		address_history_seq := map(
			ri.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or ri.addresstype='BUS' 														=> 255,
			risk_indicators.iid_constants.override_addr_type(addr1, '','')='P'																						=> 255,  //exclude PO Box addresses
			le.zip4='' 																																																		=> 255,
			ri.source_count=1 and single_instance_address 																																=> 255,
			ri.source_count=1 and ri.insurance_source_count=0 and ri.property_source_count=0 and
			ri.utility_source_count=0 and ri.vehicle_source_count=0 and ri.dl_source_count=0 and ri.voter_source_count=0 	=> 255,
																																																											 ri.address_history_seq);
		SELF.address_history_seq	:= address_history_seq;
		SELF.hdr_date_first_seen	:= ri.date_first_seen;
		SELF.hdr_date_last_seen		:= ri.date_last_seen;
    LifeMoveNewMsnc           := ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],((string)ri.date_first_seen)[1..6]);
		SELF.LifeMoveNewMsnc  		:= if(ri.date_first_seen <> 0 AND LifeMoveNewMsnc>=0, 
                                    LifeMoveNewMsnc, 
                                    nines);
		SELF 											:= le;
	END;

	wAddrSeq_roxie := join(dedupHdr, address_rank_key,
													keyed(left.DID = right.s_did) and
													left.DID <> 0 and left.hdr_z5 <> '' and left.hdr_prim_name <> '' and
													left.hdr_z5 = right.zip and
													left.hdr_prim_range = right.prim_range and
													left.hdr_prim_name = right.prim_name,
													getAddrSeq(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));
	wAddrSeq_thor := join(distribute(dedupHdr, did), distribute(pull(address_rank_key), s_did),
													left.DID = right.s_did and
													left.DID <> 0 and left.hdr_z5 <> '' and left.hdr_prim_name <> '' and
													left.hdr_z5 = right.zip and
													left.hdr_prim_range = right.prim_range and
													left.hdr_prim_name = right.prim_name,
													getAddrSeq(LEFT,RIGHT), left outer, local);

	#IF(onThor)
		wAddrSeq := wAddrSeq_thor;
	#ELSE
		wAddrSeq := wAddrSeq_roxie;
	#END

//each unique address now has assigned sequence. drop any bad addresses (0 or 9x), sort by seq / address seq and keep only first two.
	// dedupAddrs := dedup(sort(wAddrSeq(address_history_seq <> 255), seq, address_history_seq),seq, keep(2));
	goodAddrs := group(sort(wAddrSeq(address_history_seq <> 255), seq, address_history_seq), seq);

//reassign the sequence number in case there are holes (eg - change 1,3,4... to 1,2,3...)
  reseqAddrs := iterate(goodAddrs, transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell, self.address_history_seq := counter, self := right));
 
  // ProfileBooster.V2_Layouts.Layout_PB2_Shell xfm_addSeq(goodAddrs L, goodAddrs R, INTEGER cnt) := TRANSFORM
     // SELF.address_history_seq := cnt;
     // SELF := R;
  // END;
	// reseqAddrs := ungroup(iterate(goodAddrs, xfm_addSeq(LEFT,RIGHT,COUNTER)));
	// reseqAddrs := iterate(goodAddrs, transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell, self.address_history_seq := counter, self := right));
  // reseqAddrs := PROJECT(goodAddrs, transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell, self.address_history_seq := counter, self := left));
// with_hdr_addr_cache := reseqAddrs; GROUP


	aid_key := AID_Build.Key_AID_Base;

	ProfileBooster.V2_Layouts.Layout_PB2_Shell append_addr_type(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, aid_key rt) := transform
		unparsedAddress := address.Addr1FromComponents(le.hdr_prim_range, le.hdr_predir, le.hdr_prim_name, le.hdr_addr_suffix, le.hdr_postdir, le.hdr_unit_desig, le.hdr_sec_range);
		self.hdr_addr_type		:= risk_indicators.iid_constants.override_addr_type(unparsedAddress,
																		rt.rec_type,
																		rt.cart);
		self.hdr_addr_status			:= rt.err_stat;
		self := le;
	end;

//at this point, a rec with address_history_seq of '1' is the current address and '2' is the previous address
	filtered_reseqAddrs := reseqAddrs(address_history_seq in [1,2] or VerifiedCurrResMatchIndex = '1' and hdr_rawaid<>0);

	with_hdr_addr_cache_roxie := join(filtered_reseqAddrs,
															aid_key,
															keyed(right.rawaid=left.hdr_rawaid),
															append_addr_type(left,right), left outer,
															atmost(riskwise.max_atmost), keep(1));

	with_hdr_addr_cache_thor := join(distribute(filtered_reseqAddrs, hdr_rawaid), distribute(pull(aid_key), rawaid),
													 right.rawaid=left.hdr_rawaid,
															append_addr_type(left,right),
															left outer, atmost(riskwise.max_atmost), keep(1), local);

	#IF(onThor)
		with_hdr_addr_cache := group(with_hdr_addr_cache_thor, seq);
	#ELSE
		with_hdr_addr_cache := with_hdr_addr_cache_roxie;
	#END

	withAddrs := join(wVerification, with_hdr_addr_cache,
												left.seq = right.seq,
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	isInputAddr						:= left.prim_range = right.hdr_prim_range and left.prim_name = right.hdr_prim_name and left.z5 = right.hdr_z5;
																	HdrAddrFull           := TRIM(Address.Addr1FromComponents(right.hdr_prim_range,right.hdr_predir,right.hdr_prim_name,
                                                                                       right.hdr_addr_suffix,right.hdr_postdir,right.hdr_unit_desig, 
                                                                                       right.hdr_sec_range))+' '+TRIM(right.hdr_city_name)+', '+right.hdr_st
                                                                                       +' '+right.hdr_z5+'-'+right.hdr_zip4;															    
                                  self.address_history_seq := right.address_history_seq;                                  
                                  self.AddrCurrFull     := if(right.address_history_seq=1, HdrAddrFull, '');                             
                                  self.curr_addr_rawaid := if(right.address_history_seq=1, right.hdr_rawaid, 0);
                                  self.curr_prim_range	:= if(right.address_history_seq=1, right.hdr_prim_range, '');
																	self.curr_predir			:= if(right.address_history_seq=1, right.hdr_predir, '');
																	self.curr_prim_name		:= if(right.address_history_seq=1, right.hdr_prim_name, '');
																	self.curr_addr_suffix	:= if(right.address_history_seq=1, right.hdr_addr_suffix, '');
																	self.curr_postdir			:= if(right.address_history_seq=1, right.hdr_postdir, '');
																	self.curr_unit_desig	:= if(right.address_history_seq=1, right.hdr_unit_desig, '');
																	self.curr_sec_range		:= if(right.address_history_seq=1, right.hdr_sec_range, '');
																	self.curr_city_name		:= if(right.address_history_seq=1, right.hdr_city_name, '');
																	self.curr_st					:= if(right.address_history_seq=1, right.hdr_st, '');
																	self.curr_z5					:= if(right.address_history_seq=1, right.hdr_z5, '');
																	self.curr_zip4				:= if(right.address_history_seq=1, right.hdr_zip4, '');
																	self.curr_date_first_seen	:= if(right.address_history_seq=1, right.hdr_date_first_seen, 0);
																	self.curr_date_last_seen	:= if(right.address_history_seq=1, right.hdr_date_last_seen, 0);
																	self.LifeMoveNewMsnc	:= if(right.address_history_seq=1, right.LifeMoveNewMsnc, nines);
																	self.curr_addr_type		:= if(right.address_history_seq=1, right.hdr_addr_type, '');
																	self.curr_addr_status		:= if(right.address_history_seq=1, right.hdr_addr_status, '');
																	self.curr_county			:= if(right.address_history_seq=1, right.hdr_county, '');
																	self.curr_geo_blk			:= if(right.address_history_seq=1, right.hdr_geo_blk, '');
																	isSameAddr            := left.curr_addr_rawaid=right.hdr_rawaid;
                                  self.AddrPrevFull     := if(right.address_history_seq=2, HdrAddrFull, '');
                                  self.prev_addr_rawaid := if(right.address_history_seq=2, right.hdr_rawaid, 0);
                                  self.prev_prim_range	:= if(right.address_history_seq=2, right.hdr_prim_range, '');
																	self.prev_predir			:= if(right.address_history_seq=2, right.hdr_predir, '');
																	self.prev_prim_name		:= if(right.address_history_seq=2, right.hdr_prim_name, '');
																	self.prev_addr_suffix	:= if(right.address_history_seq=2, right.hdr_addr_suffix, '');
																	self.prev_postdir			:= if(right.address_history_seq=2, right.hdr_postdir, '');
																	self.prev_unit_desig	:= if(right.address_history_seq=2, right.hdr_unit_desig, '');
																	self.prev_sec_range		:= if(right.address_history_seq=2, right.hdr_sec_range, '');
																	self.prev_city_name		:= if(right.address_history_seq=2, right.hdr_city_name, '');
																	self.prev_st					:= if(right.address_history_seq=2, right.hdr_st, '');
																	self.prev_z5					:= if(right.address_history_seq=2, right.hdr_z5, '');
																	self.prev_zip4				:= if(right.address_history_seq=2, right.hdr_zip4, '');
																	self.prev_date_first_seen	:= if(right.address_history_seq=2, right.hdr_date_first_seen, 0);
																	self.prev_date_last_seen	:= if(right.address_history_seq=2, right.hdr_date_last_seen, 0);
																	self.prev_addr_type		:= if(right.address_history_seq=2, right.hdr_addr_type, '');
																	self.prev_addr_status	:= if(right.address_history_seq=2, right.hdr_addr_status, '');
																	self.prev_county			:= if(right.address_history_seq=2, right.hdr_county, '');
																	self.prev_geo_blk			:= if(right.address_history_seq=2, right.hdr_geo_blk, '');
																	self.VerifiedCurrResMatchIndex	:= if(right.address_history_seq=1 and isInputAddr, '2', left.VerifiedCurrResMatchIndex);
																	self := left), left outer);

//rollup to get current and previous address on same record
  ProfileBooster.V2_Layouts.Layout_PB2_Shell rollAddrs(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		self.curr_prim_range	:= if(ri.curr_prim_range<>'', ri.curr_prim_range, le.curr_prim_range);
		self.curr_predir			:= if(ri.curr_predir<>'', ri.curr_predir, le.curr_predir);
		self.curr_prim_name		:= if(ri.curr_prim_name<>'', ri.curr_prim_name, le.curr_prim_name);
		self.curr_addr_suffix	:= if(ri.curr_addr_suffix<>'', ri.curr_addr_suffix, le.curr_addr_suffix);
		self.curr_postdir			:= if(ri.curr_postdir<>'', ri.curr_postdir, le.curr_postdir);
		self.curr_unit_desig	:= if(ri.curr_unit_desig<>'', ri.curr_unit_desig, le.curr_unit_desig);
		self.curr_sec_range		:= if(ri.curr_sec_range<>'', ri.curr_sec_range, le.curr_sec_range);
		self.curr_city_name		:= if(ri.curr_city_name<>'', ri.curr_city_name, le.curr_city_name);
		self.curr_st					:= if(ri.curr_st<>'', ri.curr_st, le.curr_st);
		self.curr_z5					:= if(ri.curr_z5<>'', ri.curr_z5, le.curr_z5);
		self.curr_zip4				:= if(ri.curr_zip4<>'', ri.curr_zip4, le.curr_zip4);
		self.curr_date_first_seen	:= if(ri.curr_date_first_seen<>0, ri.curr_date_first_seen, le.curr_date_first_seen);
		self.curr_date_last_seen	:= if(ri.curr_date_last_seen<>0, ri.curr_date_last_seen, le.curr_date_last_seen);
		self.LifeMoveNewMsnc	:= map(le.LifeMoveNewMsnc<0 and ri.LifeMoveNewMsnc>=0 => ri.LifeMoveNewMsnc,
                                 le.LifeMoveNewMsnc>=0 and ri.LifeMoveNewMsnc<0 => le.LifeMoveNewMsnc,
                                 min(le.LifeMoveNewMsnc, ri.LifeMoveNewMsnc)); //min will get months since move to current address
    CurrAddrType          := if(ri.curr_addr_type<>'', TRIM(ri.curr_addr_type), TRIM(le.curr_addr_type));		
    self.curr_addr_type		:= CurrAddrType;    
    self.CurrAddrType     := CurrAddrType;
    self.CurrAddrTypeIndx := MAP(CurrAddrType in ['S','G','R']	=> 3,
                                 CurrAddrType in ['P']					=> 2,
                                 CurrAddrType in ['H','F']			=> 1,
                                 le.CurrAddrTypeIndx<>0         => le.CurrAddrTypeIndx,
                                                                   0);
		self.curr_county			:= if(ri.curr_county<>'', ri.curr_county, le.curr_county);
		self.curr_geo_blk			:= if(ri.curr_geo_blk<>'', ri.curr_geo_blk, le.curr_geo_blk);
		self.prev_prim_range	:= if(ri.prev_prim_range<>'', ri.prev_prim_range, le.prev_prim_range);
		self.prev_predir			:= if(ri.prev_predir<>'', ri.prev_predir, le.prev_predir);
		self.prev_prim_name		:= if(ri.prev_prim_name<>'', ri.prev_prim_name, le.prev_prim_name);
		self.prev_addr_suffix	:= if(ri.prev_addr_suffix<>'', ri.prev_addr_suffix, le.prev_addr_suffix);
		self.prev_postdir			:= if(ri.prev_postdir<>'', ri.prev_postdir, le.prev_postdir);
		self.prev_unit_desig	:= if(ri.prev_unit_desig<>'', ri.prev_unit_desig, le.prev_unit_desig);
		self.prev_sec_range		:= if(ri.prev_sec_range<>'', ri.prev_sec_range, le.prev_sec_range);
		self.prev_city_name		:= if(ri.prev_city_name<>'', ri.prev_city_name, le.prev_city_name);
		self.prev_st					:= if(ri.prev_st<>'', ri.prev_st, le.prev_st);
		self.prev_z5					:= if(ri.prev_z5<>'', ri.prev_z5, le.prev_z5);
		self.prev_zip4				:= if(ri.prev_zip4<>'', ri.prev_zip4, le.prev_zip4);
		self.prev_date_first_seen	:= if(ri.prev_date_first_seen<>0, ri.prev_date_first_seen, le.prev_date_first_seen);
		self.prev_date_last_seen	:= if(ri.prev_date_last_seen<>0, ri.prev_date_last_seen, le.prev_date_last_seen);
    PrevAddrType          := if(ri.prev_addr_type<>'', ri.prev_addr_type, le.prev_addr_type);		
    self.prev_addr_type		:= PrevAddrType;    
    // self.PrevAddrType     := PrevAddrType;
    // self.PrevAddrTypeIndx := MAP(ri.prev_addr_type in ['S','G','R']	=> 3,
                                 // ri.prev_addr_type in ['P']					=> 2,
                                 // ri.prev_addr_type in ['H','F']			=> 1,
                                 // le.PrevAddrTypeIndx<>0             => le.PrevAddrTypeIndx,
                                                                       // 0);
		self.prev_county			:= if(ri.prev_county<>'', ri.prev_county, le.prev_county);
		self.prev_geo_blk			:= if(ri.prev_geo_blk<>'', ri.prev_geo_blk, le.prev_geo_blk);
		self.VerifiedCurrResMatchIndex	:= if(ri.VerifiedCurrResMatchIndex > le.VerifiedCurrResMatchIndex, ri.VerifiedCurrResMatchIndex, le.VerifiedCurrResMatchIndex);
		self									:= le;
	end;

  rolledAddrs := rollup(withAddrs, rollAddrs(left,right), seq);

	hdr_slim := RECORD
		allHeader.Seq;
		allHeader.Did;
		allHeader.HistoryDate;
		allHeader.hdr_lname;
		allHeader.hdr_addr1;
		allHeader.dt_first_seen;
		allHeader.dt_last_seen;
	END;

	hf_slim := DISTRIBUTE(
    project(allHeader,
      transform(hdr_slim,
        self.historydate := (unsigned)(risk_indicators.iid_constants.myGetDate(left.historydate)[1..6]) ;
        self := left)),
        did);

	addr_slim := RECORD
	hf_slim.seq;
	hf_slim.did;
	hf_slim.HistoryDate;
	hf_slim.hdr_addr1;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
	END;

	d_addr := TABLE(hf_slim(TRIM(hdr_addr1)<>''), addr_slim, seq, did, historydate, hdr_addr1, LOCAL);

// use the build start date as today and adjust the timeframes
	// addr_stats := record
		// seq := d_addr.seq;
		// did := d_addr.did;
		// addr_ct := count(group);
    // addr_ct180 := count(group, ( ut.DaysApart((string)d_addr.HistoryDate, ((STRING)d_addr.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.fifteenyears ) or ((STRING)d_addr.dt_first_seen)[1..6]+'31' >= (string)d_addr.HistoryDate and d_addr.dt_first_seen<>999999);
    
	// end;

	// addr_counts := table(d_addr, addr_stats, seq, did, local);

	lname_slim := record
		hf_slim.seq;
		hf_slim.did;
		hf_slim.HistoryDate;
		hf_slim.hdr_lname;
		dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
		dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
	END;

	d_last := TABLE(hf_slim(TRIM(hdr_lname)<>''), lname_slim, seq, did, historydate, hdr_lname, LOCAL);

	// use the build start date as today and adjust the timeframes
	lname_stats := record
		seq := d_last.seq;
		did := d_last.did;
		lname_ct        := count(group);
		lname_ct12      := count(group, ( ut.DaysApart((string)d_last.HistoryDate, ((STRING)d_last.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.elevenMonths ) or ((STRING)d_last.dt_first_seen)[1..6]+'31' >= (string)d_last.HistoryDate and d_last.dt_first_seen<>999999);
    // dt_first_seen_max := MAX(group, IF(d_last.dt_first_seen=999999,0,d_last.dt_first_seen));
	END;
	
	lname_counts := table(d_last, lname_stats, seq, did, local);

//join last name counts back to PB shell and append last name counts
/* 	ProfileBooster.V2_Layouts.Layout_PB2_Shell getAddrCounts(rolledAddrs le, addr_counts ri) := TRANSFORM
   		// SELF.LifeAddrCnt			:= ri.addr_ct;
   		SELF.LifeAddrCnt			:= ri.addr_ct180;
   		SELF 										:= le;
   	END;
*/
	
	// wAddrCounts := join(rolledAddrs, addr_counts,
													// left.seq = right.seq and
													// left.DID = right.DID,
									 // getAddrCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));

//join last name counts back to PB shell and append last name counts
	ProfileBooster.V2_Layouts.Layout_PB2_Shell getLnameCounts(rolledAddrs le, lname_counts ri) := TRANSFORM
		SELF.LifeNameLastChngFlag			:= if(ri.lname_ct > 1, 1, 0);
		SELF.LifeNameLastChngFlag1Y	  := if(ri.lname_ct12 > 0, 1, 0);
    SELF.LifeNameLastCntEv        := ri.lname_ct;
    // SELF.LifeNameLastChngNewMsnc  := if(ri.lname_ct > 1, ut.DaysApart((string)le.HistoryDate, ((STRING)ri.dt_first_seen_max)[1..6]+'31'),-99998);
		SELF 														:= le;
	END;
	
	// wLnameCounts := join(wAddrCounts, lname_counts,
	wLnameCounts := join(rolledAddrs, lname_counts,
													left.seq = right.seq and
													left.DID = right.DID,
									 getLnameCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));

	lname_stats2 := record
		seq := d_last.seq;
		did := d_last.did;
		lname_ct        := count(group);
		// lname_ct12      := count(group, ( ut.DaysApart((string)d_last.HistoryDate, ((STRING)d_last.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.elevenMonths ) or ((STRING)d_last.dt_first_seen)[1..6]+'31' >= (string)d_last.HistoryDate and d_last.dt_first_seen<>999999);
    dt_first_seen_max := MAX(group, IF(d_last.dt_first_seen=999999,0,d_last.dt_first_seen));
	END;
	
	lname_counts2 := table(d_last, lname_stats2, seq, did, local);

//join last name counts back to PB shell and append last name counts
	ProfileBooster.V2_Layouts.Layout_PB2_Shell getLnameCounts2(wLnameCounts le, lname_counts2 ri) := TRANSFORM
		// SELF.LifeNameLastChngFlag			:= if(ri.lname_ct > 1, 1, 0);
		// SELF.LifeNameLastChngFlag1Y	  := if(ri.lname_ct12 > 0, 1, 0);
    // SELF.LifeNameLastCntEv        := ri.lname_ct;
    SELF.LifeNameLastChngNewMsnc  := if(ri.lname_ct > 1, ut.DaysApart((string)le.HistoryDate, ((STRING)ri.dt_first_seen_max)[1..6]+'31'),-99998);
		SELF 														:= le;
	END;
	
	wLnameCounts2 := join(wLnameCounts, lname_counts2,
													left.seq = right.seq and
													left.DID = right.DID,
									 getLnameCounts2(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));


//get email verification
	valid_email_inputs := wLnameCounts2(did<>0 and trim(email_address)<>'');  // only send the transactions with a populated email address and populated DID
	ret := UnGROUP(project(valid_email_inputs, TRANSFORM(risk_indicators.Layout_Input, SELF.did := LEFT.did, 
		SELF.email_address := LEFT.email_address, SELF.seq := LEFT.seq, SELF := [])));

	email_in:= Project(ret,TRANSFORM(EmailV2_Services.Layouts.batch_in_rec, SELF:=LEFT));
                                 
	in_email_mod := Module(EmailV2_Services.IParams.EmailParams);
		EXPORT UNSIGNED2  PenaltThreshold      := EmailV2_Services.Constants.Defaults.PenaltThreshold;  // specific to EAA search type
		EXPORT UNSIGNED  MaxResultsPerAcct    := EmailV2_Services.Constants.Defaults.MaxResultsPerAcct;  
		EXPORT BOOLEAN   IncludeHistoricData  := TRUE; //
		EXPORT BOOLEAN   RequireLexidMatch    := TRUE;  // specific to EAA search type
		EXPORT UNSIGNED1  EmailQualityRulesMask := 0;
		EXPORT BOOLEAN   RunDeepDive          := TRUE;  // specific to EAA search type
		EXPORT STRING    SearchType := 'EAA';   
		//EXPORT STRING    IntendedPurpose := EmailV2_Services.Constants.IntendedPurpose.Standard;   
		EXPORT STRING    BVAPIkey := ''; 
		EXPORT STRING    RestrictedUseCase := EmailV2_Services.Constants.RestrictedUseCase.DirectMarketing; 
		EXPORT UNSIGNED  MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable;   //max number of result email addresses per account to send to gateway for delivery check
		EXPORT BOOLEAN   CheckEmailDeliverable := FALSE;  // option  for whether to use external gateway call to check if email address deliverable
		EXPORT BOOLEAN   KeepUndeliverableEmail := FALSE; // specific to EAA search type
		EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);  // to check delivery status
	END;	
	
	email_search_results := EmailV2_Services.Functions.getEmaildata(email_in,in_email_mod,EmailV2_Services.Constants.SearchBy.ByLexId);
	// email_search_results := EmailV2_Services.Functions.getEmaildata(email_in,in_email_mod,EmailV2_Services.Constants.SearchBy.ByEmail);

	mylayout_OUTPUT := record
		unsigned seq;
		unsigned did;
		string email_address;  // input email
		string veremail;  
		unsigned email_score;
		unsigned email_count;
	end;

	with_email_verification := JOIN(ret, email_search_results, LEFT.seq=RIGHT.seq,
		TRANSFORM(mylayout_OUTPUT,
		SELF.seq := LEFT.seq;
		SELF.did := LEFT.did;
		SELF.email_address := LEFT.email_address;
		ecompare := risk_indicators.EmailCompare(LEFT.email_address, RIGHT.cleaned.clean_email, '', '');
		emailmatch_score:=ecompare.EmailScore;
		emailmatch:= risk_indicators.iid_constants.g(emailmatch_score);
		SELF.veremail := IF(emailmatch, RIGHT.cleaned.clean_email, '');  
		SELF.email_score := emailmatch_score;
		SELF.email_count := IF(emailmatch, 1, 0);
		),LEFT outer, keep(1));
		
	mylayout_OUTPUT emailroll (mylayout_OUTPUT l,mylayout_OUTPUT r):=TRANSFORM
		SELF:=l;
	END;

	SORTed_email:= GROUP(SORT(with_email_verification,seq,did,-email_count,-veremail),seq);		
	rolled_email:= ROLLUP(SORTed_email, LEFT.seq=RIGHT.seq, emailroll(LEFT,RIGHT));
	 
	ProfileBooster.V2_Layouts.Layout_PB2_Shell cleanemail(wLnameCounts2 l, rolled_email r):=TRANSFORM
	 SELF.email_score:=r.email_score;
	 SELF.email_count:=r.email_count;
	 SELF.veremail:=r.veremail;
	 SELF:=l;
	 END;
	 
	JOIN_rolled_email:=JOIN(wLnameCounts2, rolled_email,
													LEFT.seq=RIGHT.seq,
													cleanemail(LEFT,RIGHT),
													LEFT OUTER, keep(1));

// DEBUGGING  
// OUTPUT(COUNT(PB2Shell), NAMED('V2GV_In_Cnt'));
// OUTPUT(CHOOSEN(PB2Shell,100), NAMED('V2GV_In'));
// OUTPUT(wInfutor, NAMED('wInfutor'));
// OUTPUT(wGong, NAMED('wGong'));
// OUTPUT(wHeader, NAMED('wHeader'));
// OUTPUT(wQHeader, NAMED('wQHeader'));
// OUTPUT(rolledVer, NAMED('rolledVer'));
// OUTPUT(wVerification, NAMED('wVerification'));
// OUTPUT(allHeader, NAMED('allHeader'));
// OUTPUT(dedupHdr, NAMED('dedupHdr'));
// OUTPUT(CHOOSEN(wAddrSeq,100), NAMED('wAddrSeq'));
// OUTPUT(CHOOSEN(goodAddrs,100), NAMED('goodAddrs'));
// OUTPUT(goodAddrs(did=168219), NAMED('goodAddrs168219'));
// OUTPUT(CHOOSEN(reseqAddrs,100), NAMED('reseqAddrs'));
// OUTPUT(reseqAddrs(did=168219), NAMED('reseqAddrs168219'));
// OUTPUT(COUNT(reseqAddrs(address_history_seq>5)), NAMED('reseqAddrs5cnt'));
// OUTPUT(CHOOSEN(withAddrs,100), NAMED('withAddrs'));
// OUTPUT(CHOOSEN(rolledAddrs,100), NAMED('rolledAddrs'));
// OUTPUT(hdrBuildDate01, NAMED('hdrBuildDate01'));
// OUTPUT(hf_slim, NAMED('hf_slim'));
// OUTPUT(d_addr, NAMED('d_addr'));
// OUTPUT(addr_counts, NAMED('addr_counts'));
// OUTPUT(d_last, NAMED('d_last'));
// OUTPUT(lname_counts, NAMED('lname_counts'));
// OUTPUT(wAddrCounts, NAMED('wAddrCounts'));
// OUTPUT(CHOOSEN(wLnameCounts,100), NAMED('wLnameCounts'));
// OUTPUT(CHOOSEN(wLnameCounts2,100), NAMED('wLnameCounts2'));
// output(filtered_reseqAddrs, named('reseqAddrs'));
// output(with_hdr_addr_cache, named('with_hdr_addr_cache'));
// output(withaddrs, named('withaddrs'));
// OUTPUT(wLnameCounts,,'~jfrancis::profilebooster20::V2_getVerification_ROXIE_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
// OUTPUT(with_hdr_addr_cache,,'~jfrancis::profilebooster20::V2_getVerification_with_hdr_addr_cache_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
// OUTPUT(rolledAddrs,,'~jfrancis::profilebooster20::V2_getVerification_rolledAddrs_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
// OUTPUT(goodAddrs(did=168219),,'~jfrancis::profilebooster20::V2_getVerification_goodAddrs168219_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
// OUTPUT(COUNT(JOIN_rolled_email), NAMED('V2GV_Out_Cnt'));
// OUTPUT(CHOOSEN(JOIN_rolled_email,100), NAMED('V2GV_Out'));

return JOIN_rolled_email;

END;
