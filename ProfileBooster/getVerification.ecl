import _Control, Risk_Indicators, header, RiskWise, InfutorCID, Gong, Doxie, header_quick, MDR, ut, address, Watchdog, address, AID_Build;
onThor := _Control.Environment.OnThor;

EXPORT getVerification(DATASET(ProfileBooster.Layouts.Layout_PB_Shell) PBShell) := FUNCTION

	isFCRA := false;
	nines	 := 9999999;

infutorcid_key := InfutorCID.Key_Infutor_DID;
gonghistorydid_key := gong.key_history_did;
header_key := Doxie.Key_Header;
quickheader_key := header_quick.key_DID;
address_rank_key := header.key_addr_hist(isFCRA);


//search Infutor by DID to verify input name, address, phone
	Layouts.Layout_PB_Shell getInfutor(PBShell le, infutorcid_key ri) := transform	
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
	
	wInfutorcid_roxie := join(PBShell, infutorcid_key,	
										left.did<>0 and
										keyed(left.did=right.did) and
										right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
										getInfutor(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));	
										
	wInfutorcid_thor := join(distribute(PBShell, did), distribute(pull(infutorcid_key), did),	
										left.did<>0 and
										left.did=right.did and
										right.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
										getInfutor(left,right), left outer, KEEP(100), local);

	#IF(onThor)
		wInfutorCid := wInfutorCid_thor;
	#ELSE
		wInfutorCid := wInfutorCid_roxie;
	#END
  
//search Gong by DID to verify input name, address, phone
	Layouts.Layout_PB_Shell getGong(PBShell le, gonghistorydid_key ri) := transform	
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
	
	wGong_roxie := join(PBShell, gonghistorydid_key,	
										left.did<>0 and
										keyed(left.did=right.l_did) and
										right.dt_first_seen < risk_indicators.iid_constants.myGetDate(left.historydate),
										getGong(left,right), left outer, atmost(riskwise.max_atmost), KEEP(100));	
	wGong_thor := join(distribute(PBShell, did), distribute(pull(gonghistorydid_key), did),	
										left.did<>0 and
										left.did=right.l_did and
										right.dt_first_seen < risk_indicators.iid_constants.myGetDate(left.historydate),
										getGong(left,right), left outer, KEEP(100), local);

	#IF(onThor)
		wGong := wGong_thor;
	#ELSE
		wGong := wGong_roxie;
	#END
  
//search header by DID to verify input name, address, phone, SSN	
	ProfileBooster.Layouts.Layout_PB_Shell getHeader(ProfileBooster.Layouts.Layout_PB_Shell le, header_key ri) := transform
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
    
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
    historydate := (unsigned)fullhistorydate[1..6];
		self.dt_last_seen			:= if(ri.dt_last_seen > HistoryDate, HistoryDate, ri.dt_last_seen);
		self.dob							:= (string)ri.dob;
		self.ProspectAge 			:= risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)ri.dob);
		self.title						:= ri.title;	
		self.HHID							:= ri.HHID;
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
	
	wHeader_roxie := join(PBShell, header_key,	
										left.DID <> 0 and
										keyed(left.DID = right.s_DID) and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(200), atmost(RiskWise.max_atmost));	
	wHeader_thor := join(distribute(PBShell, did), distribute(pull(header_key), s_did),	
										left.DID <> 0 and
										left.DID = right.s_DID and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(200), local);

	#IF(onThor)
		wHeader := wHeader_thor;
	#ELSE
		wHeader := wHeader_roxie;
	#END
  
	ProfileBooster.Layouts.Layout_PB_Shell getQHeader(ProfileBooster.Layouts.Layout_PB_Shell le, quickheader_key ri) := transform
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
    
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
    historydate := (unsigned)fullhistorydate[1..6];
		self.dt_last_seen			:= if(ri.dt_last_seen > HistoryDate, HistoryDate, ri.dt_last_seen);
		self.dob							:= (string)ri.dob;
		self.ProspectAge 			:= risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)ri.dob);
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
	
	wQHeader_roxie := join(PBShell, quickheader_key,		
										left.DID <> 0 and
										keyed(left.DID = right.DID) and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));	
	wQHeader_thor := join(distribute(PBShell, did), distribute(pull(quickheader_key), did),		
										left.DID <> 0 and
										left.DID = right.DID and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getQHeader(left, right), keep(200), local);

	#IF(onThor)
		wQHeader := wQHeader_thor;
	#ELSE
		wQHeader := wQHeader_roxie;
	#END
  
//sort all verification records by seq
	sortVer := sort(ungroup(wInfutorCid + wGong + wHeader + wQHeader), seq);

//rollup to accumulate the verification counts 
  Layouts.Layout_PB_Shell rollVer(Layouts.Layout_PB_Shell le, Layouts.Layout_PB_Shell ri) := transform
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
		self									:= le;
	end;
	
  rolledVer := rollup(sortVer, rollVer(left,right), seq);

	Layouts.Layout_PB_Shell addVerification(PBShell le, rolledVer ri) := TRANSFORM
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
		self 							:= le;
	END;
	
	wVerification := join(PBShell, rolledVer,
													 left.seq = right.seq,
											  addVerification(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));
																					
	allHeader := wHeader + wQHeader; //combine regular header and quick header hits
	
//only need one record per address so dedup here
	dedupHdr	:= dedup(sort(allHeader, seq, hdr_z5, hdr_prim_range, hdr_prim_name), 
																		 seq, hdr_z5, hdr_prim_range, hdr_prim_name); 

	
//join all addresses from the header to the address history key to determine current address versus previous address
	ProfileBooster.Layouts.Layout_PB_Shell getAddrSeq(dedupHdr le, address_rank_key ri) := TRANSFORM
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
		SELF.LifeEvTimeLastMove		:= if(ri.date_first_seen <> 0, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],((string)ri.date_first_seen)[1..6]), nines);
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
	reseqAddrs := iterate(goodAddrs, transform(ProfileBooster.Layouts.Layout_PB_Shell, self.address_history_seq := counter, self := right));

// with_hdr_addr_cache := reseqAddrs;


	aid_key := AID_Build.Key_AID_Base;
	
	ProfileBooster.Layouts.Layout_PB_Shell append_addr_type(ProfileBooster.Layouts.Layout_PB_Shell le, aid_key rt) := transform
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
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	isInputAddr						:= left.prim_range = right.hdr_prim_range and left.prim_name = right.hdr_prim_name and left.z5 = right.hdr_z5; 
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
																	self.LifeEvTimeLastMove	:= if(right.address_history_seq=1, right.LifeEvTimeLastMove, nines);
																	self.curr_addr_type		:= if(right.address_history_seq=1, right.hdr_addr_type, '');
																	self.curr_addr_status		:= if(right.address_history_seq=1, right.hdr_addr_status, '');
																	self.curr_county			:= if(right.address_history_seq=1, right.hdr_county, '');
																	self.curr_geo_blk			:= if(right.address_history_seq=1, right.hdr_geo_blk, '');
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
																	self.prev_addr_status		:= if(right.address_history_seq=2, right.hdr_addr_status, '');
																	self.prev_county			:= if(right.address_history_seq=2, right.hdr_county, '');
																	self.prev_geo_blk			:= if(right.address_history_seq=2, right.hdr_geo_blk, '');
																	self.VerifiedCurrResMatchIndex	:= if(right.address_history_seq=1 and isInputAddr, '2', left.VerifiedCurrResMatchIndex);
																	self := left), left outer);

//rollup to get current and previous address on same record
  Layouts.Layout_PB_Shell rollAddrs(Layouts.Layout_PB_Shell le, Layouts.Layout_PB_Shell ri) := transform
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
		self.LifeEvTimeLastMove	:= min(le.LifeEvTimeLastMove, ri.LifeEvTimeLastMove); //min will get months since move to current address
		self.curr_addr_type		:= if(ri.curr_addr_type<>'', ri.curr_addr_type, le.curr_addr_type);
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
		self.prev_addr_type		:= if(ri.prev_addr_type<>'', ri.prev_addr_type, le.prev_addr_type);
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
	addr_stats := record
		seq := d_addr.seq;
		did := d_addr.did;
		addr_ct := count(group); 
	end;
	
	addr_counts := table(d_addr, addr_stats, seq, did, local);

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
		lname_ct :=    count(group);
		lname_ct12 :=  count(group, ( ut.DaysApart((string)d_last.HistoryDate, ((STRING)d_last.dt_first_seen)[1..6]+'31') < Risk_Indicators.iid_constants.elevenMonths ) or ((STRING)d_last.dt_first_seen)[1..6]+'31' >= (string)d_last.HistoryDate and d_last.dt_first_seen<>999999);
	END;
	
	lname_counts := table(d_last, lname_stats, seq, did, local);

//join address counts back to PB shell and append address count
	ProfileBooster.Layouts.Layout_PB_Shell getAddrCounts(rolledAddrs le, addr_counts ri) := TRANSFORM
		SELF.LifeEvEverResidedCnt			:= ri.addr_ct;
		SELF 													:= le;
	END;
	
	wAddrCounts := join(rolledAddrs, addr_counts,
													left.seq = right.seq and
													left.DID = right.DID,
									 getAddrCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));

//join last name counts back to PB shell and append last name counts
	ProfileBooster.Layouts.Layout_PB_Shell getLnameCounts(wAddrSeq le, lname_counts ri) := TRANSFORM
		SELF.LifeEvNameChange						:= if(ri.lname_ct > 1, '1', '0');
		SELF.LifeEvNameChangeCnt12Mo		:= if(ri.lname_ct12 > 0, '1', '0');
		SELF 														:= le;
	END;
	
	wLnameCounts := join(wAddrCounts, lname_counts,
													left.seq = right.seq and
													left.DID = right.DID,
									 getLnameCounts(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost), Keep(1));
	
// OUTPUT(wInfutor, NAMED('wInfutor'));
// OUTPUT(wGong, NAMED('wGong'));
// OUTPUT(wHeader, NAMED('wHeader'));
// OUTPUT(wQHeader, NAMED('wQHeader'));
// OUTPUT(rolledVer, NAMED('rolledVer'));
// OUTPUT(wVerification, NAMED('wVerification'));
// OUTPUT(allHeader, NAMED('allHeader'));
// OUTPUT(dedupHdr, NAMED('dedupHdr'));
// OUTPUT(wAddrSeq, NAMED('wAddrSeq'));
// OUTPUT(goodAddrs, NAMED('goodAddrs'));
// OUTPUT(reseqAddrs, NAMED('reseqAddrs'));
// OUTPUT(withAddrs, NAMED('withAddrs'));
// OUTPUT(rolledAddrs, NAMED('rolledAddrs'));
// OUTPUT(hdrBuildDate01, NAMED('hdrBuildDate01'));
// OUTPUT(hf_slim, NAMED('hf_slim'));
// OUTPUT(d_addr, NAMED('d_addr'));
// OUTPUT(addr_counts, NAMED('addr_counts'));
// OUTPUT(d_last, NAMED('d_last'));
// OUTPUT(lname_counts, NAMED('lname_counts'));
// OUTPUT(wAddrCounts, NAMED('wAddrCounts'));
// OUTPUT(wLnameCounts, NAMED('wLnameCounts'));
	
// output(filtered_reseqAddrs, named('reseqAddrs'));
// output(with_hdr_addr_cache, named('with_hdr_addr_cache'));
// output(withaddrs, named('withaddrs'));

return wLnameCounts;	
	
END;