import _Control, Risk_Indicators, dx_header, dx_Gong, RiskWise, InfutorCID, Gong, header_quick, MDR, ut, address, AID_Build, ProfileBooster;
onThor := _Control.Environment.OnThor;

EXPORT V2_Key_getVerification_THOR(DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell) PBShell) := FUNCTION

	nines	 := 9999999;

infutorcid_key := InfutorCID.Key_Infutor_DID;
gonghistorydid_key := dx_Gong.key_history_did();
header_key := dx_header.key_header();
quickheader_key := header_quick.key_DID;
address_rank_key := dx_header.key_addr_hist();

	//search Infutor by DID to verify input name, address, phone
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getInfutor(PBShell le, infutorcid_key ri) := transform	
		EmrgDt_first_seen        := IF(ri.dt_first_seen=0,'99998888',ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen));
		self.EmrgDt_first_seen   := (UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8(EmrgDt_first_seen);
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
											
	wInfutorcid_thor := join(distribute(PBShell, did), distribute(pull(infutorcid_key), did),	
										left.did<>0 and
										left.did=right.did and
										right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
										 getInfutor(left,right), left outer, KEEP(100), local);

	wInfutorCid := wInfutorCid_thor;
  
//search Gong by DID to verify input name, address, phone
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getGong(PBShell le, gonghistorydid_key ri) := transform	
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
		EmrgDt_first_seen        := IF(ri.dt_first_seen='0',ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen));
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),(UNSIGNED6)EmrgDt_first_seen);
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
	
	wGong_thor := join(distribute(PBShell, did), distribute(pull(gonghistorydid_key), did),	
										left.did<>0 and
										left.did=right.l_did and
										right.dt_first_seen < risk_indicators.iid_constants.myGetDate(left.historydate),
										getGong(left,right), left outer, KEEP(100), local);

	wGong := wGong_thor;

	//search header by DID to verify input name, address, phone, SSN	
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getHeader(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, header_key ri) := transform
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
		EmrgDt_first_seen        := IF((STRING)ri.dt_first_seen='0',ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen));
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),(UNSIGNED6)EmrgDt_first_seen);
		// OlderErmgRecord := (UNSIGNED6)((ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen))[1..6]) <= (UNSIGNED6)((ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen))[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
		// EmrgDt_first_seen        := IF(ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen)='0',(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen),(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen));
		// self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),(UNSIGNED6)EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.src,le.EmrgSrc);
		EmrgDob	:= MAP(~OlderErmgRecord or ri.dob=0           => le.EmrgDob, 
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
		
		self.firstscore 		 := Risk_Indicators.FnameScore(le.fname, ri.fname);
		self.firstcount 		 := (integer)Risk_Indicators.iid_constants.g(self.firstscore);
		self.lastscore 			 := Risk_Indicators.LnameScore(le.lname, ri.lname);
		self.lastcount 			 := (integer)Risk_Indicators.iid_constants.g(self.lastscore);
		zip_score 				 := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
		cityst_score 			 := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.city_name, ri.st, '1');
		self.addrscore 			 := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		zip_score, cityst_score);
		self.addrcount 			 := (integer)Risk_Indicators.iid_constants.ga(self.AddrScore);		
		self.phonescore 		 := Risk_Indicators.PhoneScore(le.phone10, ri.phone);
		self.phonecount 		 := (integer)Risk_Indicators.iid_constants.gn(self.phonescore);
		self.socsscore 			 := Risk_Indicators.PhoneScore(le.ssn, ri.ssn);
		self.socscount 			 := (integer)Risk_Indicators.iid_constants.gn(self.socsscore);		
		self.dt_first_seen 		 := ri.dt_first_seen;
    
    	historydate := (unsigned)fullhistorydate[1..6];
		self.dt_last_seen		 := if(ri.dt_last_seen > HistoryDate, HistoryDate, ri.dt_last_seen);
		self.dob				 := if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, '', (string)ri.dob);
		self.ProspectAge 		 := if(ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)ri.dob));
		// self.Emerg
		self.title				 := ri.title;
        self.geolink          	 := if(ri.st<>'' and ri.county<>'' and ri.geo_blk<>'', ri.st + ri.county + ri.geo_blk, '');
		self.HHID				 := ri.HHID;
		self.hdr_prim_range		 := ri.prim_range;
		self.hdr_predir			 := ri.predir;
		self.hdr_prim_name		 := ri.prim_name;
		self.hdr_addr_suffix	 := ri.suffix;
		self.hdr_postdir		 := ri.postdir;
		self.hdr_unit_desig		 := ri.unit_desig;
		self.hdr_sec_range		 := ri.sec_range;
		self.hdr_z5				 := ri.zip;		
		self.hdr_zip4			 := ri.zip4;
		self.hdr_city_name		 := ri.city_name;
		self.hdr_st				 := ri.st;
		self.hdr_county			 := ri.county;
		self.hdr_geo_blk		 := ri.geo_blk;			
		self.hdr_lname			 := ri.lname;
		self.hdr_addr1			 := trim(ri.prim_range) + trim(ri.prim_name);	
		self.hdr_rawaid 		 := ri.rawaid;
		inputAddrFound			 := le.prim_range = ri.prim_range and le.prim_name = ri.prim_name and le.z5 = ri.zip; 
		self.VerifiedCurrResMatchIndex	:= if(inputAddrFound, '1', '0'); //if input address is on header, flag it as being known 
		self					 := le;
	end;
	
	wHeader := join(distribute(PBShell, did), distribute(pull(header_key), s_did),	
										left.DID <> 0 and
										left.DID = right.s_DID and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(200), local);

  	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getQHeader(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, quickheader_key ri) := transform
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
		EmrgDt_first_seen        := IF((STRING)ri.dt_first_seen='0',ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen));
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),(UNSIGNED6)EmrgDt_first_seen);
		// OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
		// EmrgDt_first_seen := IF(OlderErmgRecord,ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen));
		// self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.dt_first_seen),(UNSIGNED6)EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.src,le.EmrgSrc);
		EmrgDob	:= MAP(~OlderErmgRecord or ri.dob=0           => le.EmrgDob, 
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
	
	wQHeader_thor := join(distribute(PBShell, did), distribute(pull(quickheader_key), did),		
										left.DID <> 0 and
										left.DID = right.DID and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getQHeader(left, right), keep(200), local);

	wQHeader := wQHeader_thor;
  
//sort all verification records by seq
	sortVer := sort(ungroup(wInfutorCid + wGong + wHeader + wQHeader), seq);

//rollup to accumulate the verification counts 
  	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollVer(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell ri) := transform
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
		
		OlderErmgRecord := (UNSIGNED6)(((STRING)ri.EmrgDt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888'];
		self.EmrgDt_first_seen   := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.EmrgDt_first_seen),(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen));
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
		
		// self.EmrgAtOrAfter21Flag := IF(EmrgAge>=21,1,0);
		
		// emrgatorafter21flag 	
		// emrgage25to59flag 	
		// emrgrecordtype 	
		// emrgaddresshrindex 	
		// emrglexidsatemrgaddrcnt1y 	
		self									:= le;
	end;
	
  	rolledVer := rollup(sortVer, rollVer(left,right), seq);

	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell addVerification(PBShell le, rolledVer ri) := TRANSFORM
		self.firstscore 		 := ri.firstscore;
		self.firstcount 		 := ri.firstcount;
		self.lastscore 			 := ri.lastscore;
		self.lastcount 			 := ri.lastcount;
		self.addrscore 			 := ri.addrscore;
		self.addrcount 		 	 := ri.addrcount;		
		self.phonescore 		 := ri.phonescore;
		self.phonecount 		 := ri.phonecount;
		self.socsscore 			 := ri.socsscore;
		self.socscount 		 	 := ri.socscount;	
		self.dt_first_seen   	 := ri.dt_first_seen;
		self.dt_last_seen		 := ri.dt_last_seen;
		self.dob				 := ri.dob;		
		self.ProspectAge		 := ri.ProspectAge;		
		self.title				 := ri.title;					
		self.HHID				 := ri.HHID;		
		self.VerifiedCurrResMatchIndex	:= ri.VerifiedCurrResMatchIndex;
		self.EmrgDt_first_seen	 := (UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.EmrgDt_first_seen);
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
		self 				     := le;
	END;
	
	wVerification := join(PBShell, rolledVer,
													 left.seq = right.seq,
											  addVerification(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));
																					
	allHeader := wHeader + wQHeader; //combine regular header and quick header hits
	
//only need one record per address so dedup here
	dedupHdr	:= dedup(sort(allHeader, seq, hdr_z5, hdr_prim_range, hdr_prim_name), 
																		 seq, hdr_z5, hdr_prim_range, hdr_prim_name); 

	
//join all addresses from the header to the address history key to determine current address versus previous address
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getAddrSeq(dedupHdr le, address_rank_key ri) := TRANSFORM
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
		SELF.LifeMoveNewMsnc		:= if(ri.date_first_seen <> 0, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],((string)ri.date_first_seen)[1..6]), nines);
    SELF.in_streetaddress     := addr1;	
    SELF 											:= le;
	END;
	
	wAddrSeq_thor := join(distribute(dedupHdr, did), distribute(pull(address_rank_key), s_did),
													left.DID = right.s_did and
													left.DID <> 0 and left.hdr_z5 <> '' and left.hdr_prim_name <> '' and
													left.hdr_z5 = right.zip and
													left.hdr_prim_range = right.prim_range and
													left.hdr_prim_name = right.prim_name,
													getAddrSeq(LEFT,RIGHT), left outer, local);

	wAddrSeq := wAddrSeq_thor;

//each unique address now has assigned sequence. drop any bad addresses (0 or 9x), sort by seq / address seq and keep only first two.
	// dedupAddrs := dedup(sort(wAddrSeq(address_history_seq <> 255), seq, address_history_seq),seq, keep(2));
	goodAddrs := group(sort(wAddrSeq(address_history_seq <> 255), seq, address_history_seq), seq);
	
//reassign the sequence number in case there are holes (eg - change 1,3,4... to 1,2,3...) 
	reseqAddrs := iterate(goodAddrs, transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell, self.address_history_seq := counter, self := right));

// with_hdr_addr_cache := reseqAddrs;


	aid_key := AID_Build.Key_AID_Base;
	
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_addr_type(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, aid_key rt) := transform
		unparsedAddress := address.Addr1FromComponents(le.hdr_prim_range, le.hdr_predir, le.hdr_prim_name, le.hdr_addr_suffix, le.hdr_postdir, le.hdr_unit_desig, le.hdr_sec_range);
		self.hdr_addr_type		:= risk_indicators.iid_constants.override_addr_type(unparsedAddress, 
																		rt.rec_type,
																		rt.cart);
		self.hdr_addr_status			:= rt.err_stat;
    	self.curr_addr_rawaid     := rt.rawaid;
    	self.prev_addr_rawaid     := rt.rawaid;
		self := le;
	end;
	
//at this point, a rec with address_history_seq of '1' is the current address and '2' is the previous address	
	filtered_reseqAddrs := reseqAddrs(address_history_seq in [1,2] or VerifiedCurrResMatchIndex = '1' and hdr_rawaid<>0);
	
	with_hdr_addr_cache_thor := join(distribute(filtered_reseqAddrs, hdr_rawaid), distribute(pull(aid_key), rawaid),
													 right.rawaid=left.hdr_rawaid,
															append_addr_type(left,right), 
															left outer, atmost(riskwise.max_atmost), keep(1), local);
															
	with_hdr_addr_cache := group(with_hdr_addr_cache_thor, seq);

	withAddrs := join(wVerification, with_hdr_addr_cache,  
												left.seq = right.seq,
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	isInputAddr						:= left.prim_range = right.hdr_prim_range and left.prim_name = right.hdr_prim_name and left.z5 = right.hdr_z5; 
                                  HdrAddrFull           := TRIM(Address.Addr1FromComponents(right.hdr_prim_range,right.hdr_predir,right.hdr_prim_name,
                                                                                       right.hdr_addr_suffix,right.hdr_postdir,right.hdr_unit_desig, 
                                                                                       right.hdr_sec_range))+' '+TRIM(right.hdr_city_name)+', '+right.hdr_st
                                                                                       +' '+right.hdr_z5+'-'+right.hdr_zip4;															    
                                  self.address_history_seq  := right.address_history_seq;                                  
                                  self.AddrCurrFull         := if(right.address_history_seq=1, HdrAddrFull, '');                             
                                  self.curr_addr_rawaid     := if(right.address_history_seq=1, right.hdr_rawaid, 0);
                                  self.curr_prim_range	    := if(right.address_history_seq=1, right.hdr_prim_range, '');
								  self.curr_predir			:= if(right.address_history_seq=1, right.hdr_predir, '');
								  self.curr_prim_name		:= if(right.address_history_seq=1, right.hdr_prim_name, '');
								  self.curr_addr_suffix	    := if(right.address_history_seq=1, right.hdr_addr_suffix, '');
								  self.curr_postdir			:= if(right.address_history_seq=1, right.hdr_postdir, '');
								  self.curr_unit_desig	    := if(right.address_history_seq=1, right.hdr_unit_desig, '');
								  self.curr_sec_range		:= if(right.address_history_seq=1, right.hdr_sec_range, '');
								  self.curr_city_name		:= if(right.address_history_seq=1, right.hdr_city_name, '');
								  self.curr_st				:= if(right.address_history_seq=1, right.hdr_st, '');
								  self.curr_z5				:= if(right.address_history_seq=1, right.hdr_z5, '');
								  self.curr_zip4			:= if(right.address_history_seq=1, right.hdr_zip4, '');
								  self.curr_date_first_seen	:= if(right.address_history_seq=1, right.hdr_date_first_seen, 0);
								  self.curr_date_last_seen	:= if(right.address_history_seq=1, right.hdr_date_last_seen, 0);
								  self.LifeMoveNewMsnc	    := if(right.address_history_seq=1, right.LifeMoveNewMsnc, nines);
								  // self.LifeMoveNewMsnc	:= if(right.address_history_seq=1, right.LifeMoveNewMsnc, left.LifeMoveNewMsnc);
								  self.curr_addr_type		:= if(right.address_history_seq=1, right.hdr_addr_type, '');
								  self.curr_addr_status		:= if(right.address_history_seq=1, right.hdr_addr_status, '');
								  self.curr_county			:= if(right.address_history_seq=1, right.hdr_county, '');
								  self.curr_geo_blk			:= if(right.address_history_seq=1, right.hdr_geo_blk, '');
                                  isSameAddr                := left.curr_addr_rawaid=right.hdr_rawaid;
                                  self.AddrPrevFull         := if(right.address_history_seq=2 AND ~isSameAddr, HdrAddrFull, '');
                                  self.prev_addr_rawaid     := if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_rawaid, 0);
                                  self.prev_prim_range	    := if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_prim_range, '');
								  self.prev_predir			:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_predir, '');
								  self.prev_prim_name		:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_prim_name, '');
								  self.prev_addr_suffix  	:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_addr_suffix, '');
								  self.prev_postdir			:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_postdir, '');
								  self.prev_unit_desig	    := if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_unit_desig, '');
								  self.prev_sec_range		:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_sec_range, '');
								  self.prev_city_name		:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_city_name, '');
								  self.prev_st				:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_st, '');
								  self.prev_z5				:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_z5, '');
								  self.prev_zip4			:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_zip4, '');
								  self.prev_date_first_seen	:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_date_first_seen, 0);
								  self.prev_date_last_seen	:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_date_last_seen, 0);
								  self.prev_addr_type		:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_addr_type, '');
								  self.prev_addr_status		:= if(right.address_history_seq=2 AND ~isSameAddr, right.hdr_addr_status, '');
								  self.prev_county			:= if(right.address_history_seq=2, right.hdr_county, '');
								  self.prev_geo_blk			:= if(right.address_history_seq=2, right.hdr_geo_blk, '');
								  self.VerifiedCurrResMatchIndex	:= if(right.address_history_seq=1 and isInputAddr, '2', left.VerifiedCurrResMatchIndex);
								  self := left), left outer);

  // sortedAddrs := SORT(withAddrs, seq, -address_history_seq);

//rollup to get current and previous address on same record
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollAddrs(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell ri) := transform
        self.AddrCurrFull     := if(ri.AddrCurrFull<>'', ri.AddrCurrFull, le.AddrCurrFull);                             
        self.curr_addr_rawaid := if(ri.curr_addr_rawaid<>0, ri.curr_addr_rawaid, le.curr_addr_rawaid);                             
    
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
		self.LifeMoveNewMsnc	:= min(le.LifeMoveNewMsnc, ri.LifeMoveNewMsnc); //min will get months since move to current address
		CurrAddrType          := if(ri.curr_addr_type<>'', ri.curr_addr_type, le.curr_addr_type);		
        self.curr_addr_type		:= CurrAddrType;    
        self.CurrAddrType     := CurrAddrType;
        self.CurrAddrTypeIndx := MAP(ri.curr_addr_type in ['S','G','R']	=> 3,
                                 ri.curr_addr_type in ['P']					=> 2,
                                 ri.curr_addr_type in ['H','F']			=> 1,
                                 le.CurrAddrTypeIndx<>0             => le.CurrAddrTypeIndx,
                                                                       0);
		self.curr_county			:= if(ri.curr_county<>'', ri.curr_county, le.curr_county);
		self.curr_geo_blk			:= if(ri.curr_geo_blk<>'', ri.curr_geo_blk, le.curr_geo_blk);
		self.AddrPrevFull     := if(ri.AddrPrevFull<>'', ri.AddrPrevFull, le.AddrPrevFull);                             
        self.prev_addr_rawaid := if(ri.prev_addr_rawaid<>0 AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_addr_rawaid, le.prev_addr_rawaid);                             
        self.prev_prim_range	:= if(ri.prev_prim_range<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_prim_range, le.prev_prim_range);
		self.prev_predir			:= if(ri.prev_predir<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_predir, le.prev_predir);
		self.prev_prim_name		:= if(ri.prev_prim_name<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_prim_name, le.prev_prim_name);
		self.prev_addr_suffix	:= if(ri.prev_addr_suffix<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_addr_suffix, le.prev_addr_suffix);
		self.prev_postdir			:= if(ri.prev_postdir<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_postdir, le.prev_postdir);
		self.prev_unit_desig	:= if(ri.prev_unit_desig<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_unit_desig, le.prev_unit_desig);
		self.prev_sec_range		:= if(ri.prev_sec_range<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_sec_range, le.prev_sec_range);
		self.prev_city_name		:= if(ri.prev_city_name<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_city_name, le.prev_city_name);
		self.prev_st					:= if(ri.prev_st<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_st, le.prev_st);
		self.prev_z5					:= if(ri.prev_z5<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_z5, le.prev_z5);
		self.prev_zip4				:= if(ri.prev_zip4<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_zip4, le.prev_zip4);
		self.prev_date_first_seen	:= if(ri.prev_date_first_seen<>0 AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_date_first_seen, le.prev_date_first_seen);
		self.prev_date_last_seen	:= if(ri.prev_date_last_seen<>0 AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_date_last_seen, le.prev_date_last_seen);
		self.prev_addr_type		:= if(ri.prev_addr_type<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_addr_type, le.prev_addr_type);
		self.prev_county			:= if(ri.prev_county<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_county, le.prev_county);
		self.prev_geo_blk			:= if(ri.prev_geo_blk<>'' AND ri.AddrCurrFull<>le.AddrCurrFull, ri.prev_geo_blk, le.prev_geo_blk);
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
	addr_stats := record
		seq := d_addr.seq;
		did := d_addr.did;
		addr_ct := count(group); 
    // addr_ct180 := count(group, ( ut.DaysApart((string)d_addr.HistoryDate, ((STRING)d_addr.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.fifteenyears ) or ((STRING)d_addr.dt_first_seen)[1..6]+'31' >= (string)d_addr.HistoryDate and d_addr.dt_first_seen<>999999);
	end;
	
	addr_counts := table(d_addr, addr_stats, seq, did, local);

  //join address counts back to PB shell and append address count
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getAddrCounts(rolledAddrs le, addr_counts ri) := TRANSFORM
		SELF.LifeAddrCnt			:= ri.addr_ct;
		// SELF.LifeAddrCnt			:= ri.addr_ct180;
		SELF 						:= le;
	END;
	
	wAddrCounts := join(rolledAddrs, addr_counts,
													left.seq = right.seq and
													left.DID = right.DID,
									 getAddrCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));

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
		seq               := d_last.seq;
		did               := d_last.did;
		lname_ct          := count(group);
		lname_ct12        := count(group, ( ut.DaysApart((string)d_last.HistoryDate, ((STRING)d_last.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.elevenMonths ) or ((STRING)d_last.dt_first_seen)[1..6]+'31' >= (string)d_last.HistoryDate and d_last.dt_first_seen<>999999);
    	dt_first_seen_max := MAX(group, IF(d_last.dt_first_seen=999999,0,d_last.dt_first_seen));
	END;
	
	lname_counts := table(d_last, lname_stats, seq, did, local);

//join last name counts back to PB shell and append last name counts
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getLnameCounts(wAddrCounts le, lname_counts ri) := TRANSFORM
		SELF.LifeNameLastChngFlag	  := if(ri.lname_ct > 1, 1, 0);
		SELF.LifeNameLastChngFlag1Y	  := if(ri.lname_ct12 > 0, 1, 0);
        SELF.LifeNameLastCntEv        := ri.lname_ct;
        SELF.LifeNameLastChngNewMsnc  := if(ri.lname_ct > 1, ut.DaysApart((string)le.HistoryDate, ((STRING)ri.dt_first_seen_max)[1..6]+'31'),-99998);
		SELF 						  := le;
	END;
	
	wLnameCounts := join(wAddrCounts, lname_counts,
		 				 left.seq = right.seq and
						 left.DID = right.DID,
					     getLnameCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));
// DEBUGGING	
OUTPUT(CHOOSEN(wInfutorCID,100), NAMED('wInfutorCID'));
OUTPUT(CHOOSEN(wGong,100), NAMED('wGong'));
OUTPUT(CHOOSEN(wHeader,100), NAMED('wHeader'));
OUTPUT(CHOOSEN(wQHeader,100), NAMED('wQHeader'));
OUTPUT(CHOOSEN(rolledVer,100), NAMED('rolledVer'));
OUTPUT(CHOOSEN(wVerification,100), NAMED('wVerification'));
// OUTPUT(allHeader, NAMED('allHeader'));
// OUTPUT(CHOOSEN(dedupHdr,100), NAMED('dedupHdr'));
// OUTPUT(CHOOSEN(wAddrSeq,100), NAMED('wAddrSeq'));
// OUTPUT(goodAddrs, NAMED('goodAddrs'));
// OUTPUT(reseqAddrs, NAMED('reseqAddrs'));
testDIDs := [59916920346,1377159319,1572947382,848704579,548611871,1495681593,142389283,1879116723,356454149,13251542986];//110099,181264,1600350
OUTPUT(CHOOSEN(sortVer(did IN testDIDs),100), NAMED('sortVer'));
OUTPUT(CHOOSEN(withAddrs(did IN testDIDs),100), NAMED('withAddrs'));
// OUTPUT(CHOOSEN(sortedAddrs(seq IN seqDups),100), NAMED('sortedAddrs'));
// OUTPUT(CHOOSEN(rolledAddrs(did IN testDIDs),100), NAMED('rolledAddrs'));
// OUTPUT(CHOOSEN(rolledAddrs(curr_addr_rawaid=prev_addr_rawaid),100), NAMED('rolledAddrsDups'));
// OUTPUT(COUNT(rolledAddrs(curr_addr_rawaid=prev_addr_rawaid)), NAMED('rolledAddrsDups_Cnt'));
// OUTPUT(hdrBuildDate01, NAMED('hdrBuildDate01'));
// OUTPUT(hf_slim, NAMED('hf_slim'));
// OUTPUT(d_addr, NAMED('d_addr'));
// OUTPUT(addr_counts, NAMED('addr_counts'));
// OUTPUT(d_last, NAMED('d_last'));
// OUTPUT(CHOOSEN(lname_counts,100), NAMED('lname_counts'));
// OUTPUT(wAddrCounts, NAMED('wAddrCounts'));
// OUTPUT(wLnameCounts, NAMED('wLnameCounts'));
// OUTPUT(filtered_reseqAddrs, named('reseqAddrs'));
// OUTPUT(CHOOSEN(with_hdr_addr_cache,100), named('with_hdr_addr_cache'));
// OUTPUT(withaddrs, named('withaddrs'));
// OUTPUT(CHOOSEN(wLnameCounts(did IN testDIDs),100), NAMED('wLnameCounts_getVer_Final'));
OUTPUT(wLnameCounts,,'~jfrancis::profilebooster20::V2_getVerification_THOR', OVERWRITE);
	// output(ids_only,, '~dvstemp::profile_booster_property_testcase::ids_only::mathis_' + thorlib.wuid());

return wLnameCounts;	
	
END;