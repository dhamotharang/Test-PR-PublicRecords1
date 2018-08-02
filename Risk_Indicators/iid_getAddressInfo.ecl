import _Control, riskwise, did_add, ut, UtilFile, risk_indicators, NID;
onThor := _Control.Environment.OnThor;

export iid_getAddressInfo(grouped dataset(risk_indicators.Layout_Output ) flagrecs, unsigned1 glb, boolean isFCRA, 
											boolean require2Ele, integer BSversion, boolean isUtility,
											string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
											unsigned3 LastSeenThreshold = iid_constants.oneyear,
											unsigned8 BSOptions
										) := function

ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactSSNRequired := ExactMatchLevel[iid_constants.posExactSSNMatch]=iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[iid_constants.posExactPhoneMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;
ExactAddrZip5andPrimRange := ExactMatchLevel[iid_constants.posExactAddrZip5andPrimRange]=iid_constants.sTrue;

orig_input := project(flagrecs, transform(Risk_Indicators.Layouts.layout_input_plus_overrides, self:=left));

dirs_by_addr := riskwise.getDirsByAddr(dedup(ungroup(orig_input), prim_name, z5, prim_range, sec_range), isFCRA, glb, BSOptions);

risk_indicators.layout_output phoneByAddress(risk_indicators.layout_output l, dirs_by_addr r) := transform
	firstmatch_score := risk_indicators.FnameScore(l.fname, r.name_first);
	n1 := NID.PreferredFirstNew(l.fname); 
	n2 := NID.PreferredFirstNew(r.name_first);
	firstmatch := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, l.fname=r.name_first, true) and
							  if(ExactFirstNameRequiredAllowNickname, l.fname=r.name_first or n1=n2, true);
	lastmatch_score := risk_indicators.LnameScore(l.lname, r.name_last);
	lastmatch := iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, l.lname=r.name_last, true);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(l.in_zipcode, r.z5);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(l.in_city, l.in_state, r.p_city_name, r.st, l.cityzipflag);
	// addrmatch_score := Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						// r.prim_range, r.prim_name, r.sec_range,
																						// zip_score, cityst_score);
	addrmatch_score := IF(ExactAddrZip5andPrimRange,
												IF(zip_score=100
													 and Risk_Indicators.AddrScore.primRange_score(l.prim_range, r.prim_range)=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore( l.prim_range, l.prim_name, l.sec_range, 
																																r.prim_range, r.prim_name, r.sec_range,
																																zip_score, cityst_score));
																						
	addrmatch := iid_constants.ga(addrmatch_score) and if(ExactAddrRequired, l.prim_range=r.prim_range and l.prim_name=r.prim_name and 
																																						(l.in_zipcode=r.z5 or l.z5=r.z5 or 
																																							(l.in_city=r.p_city_name and l.in_state=r.st) or (l.p_city_name=r.p_city_name and l.st=r.st)) and
																																						ut.nneq(l.sec_range,r.sec_range), true);
	phonescore := risk_indicators.PhoneScore(l.phone10, r.phone10);
	phonematch := iid_constants.gn(phonescore) and if(exactPhoneRequired, l.phone10=r.phone10, true);
	cmpyscore := IF(r.business_flag, did_add.company_name_match_score(l.employer_name, r.listed_name), 255);
	cmpymatch := iid_constants.gc(cmpyscore);
	
	isCurrent := (l.historydate=iid_constants.default_history_date and r.current_flag) OR // realtime and current
							 (l.historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]) and r.current_flag) OR // history mode in current month and current
							 (l.historydate <= (unsigned) (r.deletion_date[1..6])) OR // deletion date in the future
							 (l.historydate <= (unsigned) (r.dt_last_seen[1..6]));	// date last seen is in the future
	
	ascore := iid_constants.ga(/*addrmatch_score*/Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range,
																											 r.prim_range, r.prim_name, r.sec_range))	// legacy field, don't allow zipcode or citymatch to impact addrscore
						and if(ExactAddrRequired, l.prim_range=r.prim_range and l.prim_name=r.prim_name and 
																			(l.in_zipcode=r.z5 or l.z5=r.z5 or 
																						(l.in_city=r.p_city_name and l.in_state=r.st) or (l.p_city_name=r.p_city_name and l.st=r.st)) and
																			ut.nneq(l.sec_range,r.sec_range), true);
	self.inputAddrMatchLevel := map(r.prim_name='' or (~firstmatch and ~lastmatch) => 0,	// nothing found or address only match
																	firstmatch and lastmatch and ascore and isCurrent => 4, // full match
																	lastmatch and ascore and isCurrent => 3,	// last and addr match
																	firstmatch and lastmatch and ascore => 2, // full name but disconnected
																	1); // last and addr but disconnected
														
	self.inputAddrActivePhone := if(self.inputAddrMatchLevel >= 3, (unsigned)r.phone10, l.inputAddrActivePhone);
	
	
	
	goodHit := IF(((INTEGER)firstmatch+(INTEGER)lastmatch+(INTEGER)addrmatch+(INTEGER)phonematch+(INTEGER)cmpymatch)>1,true,false);	// need at least 2 elements to match to keep record
		
	self.phoneaddr_firstcount := IF((require2Ele and goodhit) or ~require2Ele, IF(firstmatch,1,0),0);
	self.phoneaddr_lastcount := IF((require2Ele and goodhit) or ~require2Ele, IF(lastmatch,1,0),0);
	self.phoneaddr_addrcount := IF((require2Ele and goodhit) or ~require2Ele, IF(addrmatch,1,0),0);
	self.phoneaddr_phonecount := IF((require2Ele and goodhit) or ~require2Ele, IF(phonematch,1,0),0);
	self.phoneaddr_cmpycount := IF((require2Ele and goodhit) or ~require2Ele, IF(cmpymatch,1,0),0);
	
	self.hriskphoneflag := if(l.hriskphoneflag='5' and r.current_flag and l.sec_range=r.sec_range and (phonematch or r.phone10=''), '0', l.hriskphoneflag);	// not sure if we should set to 0 here
																															// is phonematch good enough, does it match 7 bytes?
	
	self.phonedissflag := if(l.phonedissflag and self.hriskphoneflag<>'5', false, l.phonedissflag);	// if hriskphoneflag says not disconnected then set to not disconnected
	
	// added extra logic for processing with archive dates							
	self.phoneaddr_disconnected := IF(((require2Ele and goodhit) or ~require2Ele) and self.phonedissflag, r.prim_name<>'' AND 
																(r.deletion_date!='' and r.deletion_date < iid_constants.full_history_date(l.historydate) ), false);			
	self.phoneaddr_disconnectdate := IF(self.phoneaddr_disconnected, (INTEGER)(r.deletion_date[1..6]),0);	
	self.isAddrPhoneConnected := r.src in ['GH','WP'] and goodHit and ~self.phoneaddr_disconnected;	// used for nap status with ciid v1
	self.phoneaddr_date_last_seen := IF(goodhit, (unsigned)r.dt_last_seen, 0);
	self.phoneaddr_date_first_seen := IF(goodhit, (unsigned)r.dt_first_seen, 0);
	self.dirsaddr_first := IF((require2Ele and goodhit) or ~require2Ele, r.name_first,'');
	self.dirsaddr_last := IF((require2Ele and goodhit) or ~require2Ele, r.name_last,'');
	self.dirsaddr_prim_range := IF((require2Ele and goodhit) or ~require2Ele, r.prim_range,'');
	self.dirsaddr_predir := IF((require2Ele and goodhit) or ~require2Ele, r.predir,'');
	self.dirsaddr_prim_name := IF((require2Ele and goodhit) or ~require2Ele, r.prim_name,'');
	self.dirsaddr_suffix := IF((require2Ele and goodhit) or ~require2Ele, r.suffix,'');
	self.dirsaddr_postdir := IF((require2Ele and goodhit) or ~require2Ele, r.postdir,'');
	self.dirsaddr_unit_desig := IF((require2Ele and goodhit) or ~require2Ele, r.unit_desig,'');
	self.dirsaddr_sec_range := IF((require2Ele and goodhit) or ~require2Ele, r.sec_range,'');
	self.dirsaddr_city := IF((require2Ele and goodhit) or ~require2Ele, r.p_city_name,'');
	self.dirsaddr_state := IF((require2Ele and goodhit) or ~require2Ele, r.st,'');
	self.dirsaddr_zip := IF((require2Ele and goodhit) or ~require2Ele, r.z5+r.z4,'');
	SELF.dirsaddr_phone := IF((require2Ele and goodhit) or ~require2Ele, r.phone10,'');
	SELF.dirsaddr_cmpy := IF(((require2Ele and goodhit) or ~require2Ele) and r.business_flag, r.listed_name,'');
	
	self.dirsaddr_firstscore := IF((require2Ele and goodhit) or ~require2Ele, firstmatch_score,255);
	self.dirsaddr_lastscore := IF((require2Ele and goodhit) or ~require2Ele, lastmatch_score,255);
	self.dirsaddr_addrscore := IF((require2Ele and goodhit) or ~require2Ele, addrmatch_score,255);
	self.dirsaddr_citystatescore := IF((require2Ele and goodhit) or ~require2Ele, cityst_score,255);
	self.dirsaddr_zipscore := IF((require2Ele and goodhit) or ~require2Ele, zip_score,255);
	
	self.dirsaddr_phonescore := IF((require2Ele and goodhit) or ~require2Ele, phonescore,255);
	self.dirsaddr_cmpyscore := IF((require2Ele and goodhit) or ~require2Ele, cmpyscore,255);
	
	self.disthphoneaddr := if(phonematch or r.phone10='', 
						IF(length(trim(l.phone10))=10,if(l.lat='' or r.geo_lat='',9999,round(ut.ll_dist((REAL)l.lat,(REAL)l.long,(REAL)r.geo_lat,(REAL)r.geo_long))),9999),
						9999);
	self.hphonelat := if(phonematch or r.phone10='',r.geo_lat, '');
	self.hphonelong := if(phonematch or r.phone10='',r.geo_long, '');
	
	self.phone_from_addr := r.phone10;
	self.phones_per_addr := if(trim(r.phone10)!='', 1, 0);
	self.phones_per_addr_current := if(trim(r.phone10)!='' and l.sec_range=r.sec_range and ~self.phoneaddr_disconnected, 1, 0);
	
	self.phones_per_addr_created_6months := if(trim(r.phone10) != '' and ut.DaysApart(iid_constants.myGetDate(l.historydate), r.dt_first_seen) < 183, 1, 0);

	self.phone_sources := map(goodhit and phonematch and trim(l.phone_sources)='' =>	r.src + ',',
													goodhit and phonematch =>	l.phone_sources + r.src + ',',
													l.phone_sources);
													
	self.phoneAddrSourceUsed := if(r.prim_name<>'', r.src+',', '');
													
	self := l;
END;				  

phonerecsByaddr_history_roxie := join(flagrecs, dirs_by_addr,
					       left.prim_name<>'' AND left.z5<>'' AND
					       left.prim_name=right.prim_name and left.st=right.st and 
				            left.z5=right.z5 and left.prim_range=right.prim_range and ut.NNEQ(left.sec_range,right.sec_range) and
										// check pullid
										LEFT.pullidflag = '' AND
				            // check date
				            ((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
							(RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
							phoneByAddress(left,right),left outer, many lookup, 
						   ATMOST(
						       left.prim_name=right.prim_name and left.st=right.st and 
						       left.z5=right.z5 and left.prim_range=right.prim_range, 						  
						       RiskWise.max_atmost),
					       keep(300));
								 
phonerecsByaddr_history_thor := join(distribute(flagrecs, hash64(prim_name, z5, prim_range)), 
								 distribute(dirs_by_addr, hash64(prim_name, z5, prim_range)),
					       left.prim_name<>'' AND left.z5<>'' AND
					       left.prim_name=right.prim_name and left.st=right.st and 
				            left.z5=right.z5 and left.prim_range=right.prim_range and ut.NNEQ(left.sec_range,right.sec_range) and
										// check pullid
										LEFT.pullidflag = '' AND
				            // check date
				            ((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)) AND
							(RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
							phoneByAddress(left,right),left outer,
						   ATMOST(
						       left.prim_name=right.prim_name and left.st=right.st and 
						       left.z5=right.z5 and left.prim_range=right.prim_range, 						  
						       RiskWise.max_atmost),
					       keep(300), LOCAL);
								 

#IF(onThor)
	phonerecsByaddr_history := group(sort(distribute(phonerecsByaddr_history_thor, hash64(seq)), seq,-dirsaddr_phone, -phoneaddr_date_last_seen, dirsaddr_last, dirsaddr_first, dirsaddr_cmpy, phoneAddrSourceUsed, record, LOCAL),seq, LOCAL);
#ELSE
	phonerecsByaddr_history := sort(phonerecsByaddr_history_roxie, seq,-dirsaddr_phone, -phoneaddr_date_last_seen, dirsaddr_last, dirsaddr_first, dirsaddr_cmpy, phoneAddrSourceUsed, record);
#END

phonerecsByaddr := phonerecsByaddr_history;	

phonesPerAddr := risk_indicators.getPhonesPerAddr(phonerecsByaddr);

risk_indicators.layout_output roll_addr_trans(risk_indicators.layout_output l,risk_indicators.layout_output r) := transform
	self.inputaddrMatchLevel := MAX(l.inputaddrMatchLevel, r.inputaddrMatchLevel);	// pick the higher of the 2
	self.inputaddrActivePhone := if(l.inputaddrMatchLevel>=r.inputaddrMatchLevel, l.inputaddrActivePhone, r.inputaddrActivePhone);
	
	countLeft := l.phoneaddr_firstcount+l.phoneaddr_lastcount+l.phoneaddr_addrcount+l.phoneaddr_phonecount+l.phoneaddr_cmpycount;
	countRight := r.phoneaddr_firstcount+r.phoneaddr_lastcount+r.phoneaddr_addrcount+r.phoneaddr_phonecount+r.phoneaddr_cmpycount;
						
	phoneaddr_chooser := MAP(~l.phoneaddr_disconnected AND r.phoneaddr_disconnected AND ((l.dwelltype='' AND l.addrvalflag<>'N') OR 
										((iid_constants.tscore(l.dirsaddr_lastscore)>79) or (iid_constants.tscore(l.dirsaddr_cmpyscore)>64))) AND l.phoneAddrSourceUsed in ['GH,','WP,'] AND r.phoneAddrSourceUsed in ['GH,','WP,'] =>	1,
						l.phoneaddr_disconnected AND ~r.phoneaddr_disconnected and ((r.dwelltype='' and r.addrvalflag<>'N') OR 
						((iid_constants.tscore(r.dirsaddr_lastscore)>79) or (iid_constants.tscore(r.dirsaddr_cmpyscore)>64))) AND l.phoneAddrSourceUsed in ['GH,','WP,'] AND r.phoneAddrSourceUsed in ['GH,','WP,'] =>	2,
						// if the left source is PA and right source is not and they equal, keep the right
						countLeft=countRight and countLeft>0 and l.phoneAddrSourceUsed not in ['GH,','WP,'] and r.phoneAddrSourceUsed in ['GH,','WP,'] and
								((r.dwelltype='' and r.addrvalflag<>'N') OR ((iid_constants.tscore(r.dirsaddr_lastscore)>79) or (iid_constants.tscore(r.dirsaddr_cmpyscore)>64))) => 2,
						countLeft >= countRight and 
										((l.dwelltype='' AND l.addrvalflag<>'N') or ((iid_constants.tscore(l.dirsaddr_lastscore)>79) or (iid_constants.tscore(l.dirsaddr_cmpyscore)>64))) and
										((l.phoneaddr_phonecount >= r.phoneaddr_phonecount and length(trim(l.dirsaddr_phone)) >= length(trim(r.dirsaddr_phone))) OR l.phoneaddrsourceused in ['GH,','WP,'] and r.phoneaddrsourceused not in ['GH,','WP,']) => 3,	// keep the GH/WP record if it is higher NAP than the PA record even if the PA record has a phonematch
						countRight >= countLeft and 
										((r.dwelltype='' and r.addrvalflag<>'N') or ((iid_constants.tscore(r.dirsaddr_lastscore)>79) or (iid_constants.tscore(r.dirsaddr_cmpyscore)>64))) => 4,
						5);					
						
	self.phoneAddrSourceUsed := MAP(phoneaddr_chooser IN [1,3] => TRIM(l.phoneAddrSourceUsed,all),
																	phoneaddr_chooser IN [2,4] => TRIM(r.phoneAddrSourceUsed,all),
																	l.phoneAddrSourceUsed);					
						
	self.phoneaddr_firstcount := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_firstcount,
							   phoneaddr_chooser IN [2,4] => r.phoneaddr_firstcount,
							   0);
	self.phoneaddr_lastcount := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_lastcount,
							  phoneaddr_chooser IN [2,4] => r.phoneaddr_lastcount,
							  0);
	self.phoneaddr_addrcount := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_addrcount,
							  phoneaddr_chooser IN [2,4] => r.phoneaddr_addrcount,
							  0);
	self.phoneaddr_phonecount := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_phonecount,
							   phoneaddr_chooser IN [2,4] => r.phoneaddr_phonecount,
							   0);
	self.phoneaddr_cmpycount := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_cmpycount,
							  phoneaddr_chooser IN [2,4] => r.phoneaddr_cmpycount,
							  0);
	self.phoneaddr_disconnected := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_disconnected,
								phoneaddr_chooser IN [2,4] => r.phoneaddr_disconnected,
								false);
	self.phoneaddr_disconnectdate := MAP(phoneaddr_chooser IN [1,3] => l.phoneaddr_disconnectdate,
								  phoneaddr_chooser IN [2,4] => r.phoneaddr_disconnectdate,
								  0);
	self.phoneaddr_date_last_seen := MAX(l.phoneaddr_date_last_seen,r.phoneaddr_date_last_seen);
	self.phoneaddr_date_first_seen := ut.min2(l.phoneaddr_date_first_seen,r.phoneaddr_date_first_seen);
							   
							   
	self.dirsaddr_first := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_first,
						  phoneaddr_chooser IN [2,4] => r.dirsaddr_first,
						  '');
	self.dirsaddr_last := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_last,
						 phoneaddr_chooser IN [2,4] => r.dirsaddr_last,
						 '');
	self.dirsaddr_prim_range := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_prim_range,
							  phoneaddr_chooser IN [2,4] => r.dirsaddr_prim_range,
							  '');
	self.dirsaddr_predir := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_predir,
						   phoneaddr_chooser IN [2,4] => r.dirsaddr_predir,
						  '');
	self.dirsaddr_prim_name := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_prim_name,
							 phoneaddr_chooser IN [2,4] => r.dirsaddr_prim_name,
							 '');
	self.dirsaddr_suffix := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_suffix,
						   phoneaddr_chooser IN [2,4] => r.dirsaddr_suffix,
						   '');
	self.dirsaddr_postdir := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_postdir,
						    phoneaddr_chooser IN [2,4] => r.dirsaddr_postdir,
						    '');
	self.dirsaddr_unit_desig := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_unit_desig,
							  phoneaddr_chooser IN [2,4] => r.dirsaddr_unit_desig,
							  '');
	self.dirsaddr_sec_range := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_sec_range,
							 phoneaddr_chooser IN [2,4] => r.dirsaddr_sec_range,
							 '');
	self.dirsaddr_city := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_city,
						 phoneaddr_chooser IN [2,4] => r.dirsaddr_city,
						 '');
	self.dirsaddr_state := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_state,
						  phoneaddr_chooser IN [2,4] => r.dirsaddr_state,
						  '');
	self.dirsaddr_zip :=MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_zip,
					    phoneaddr_chooser IN [2,4] => r.dirsaddr_zip,
					    '');
	self.dirsaddr_phone := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_phone,
					       phoneaddr_chooser IN [2,4] => r.dirsaddr_phone,
					       '');				    
	self.dirsaddr_cmpy := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_cmpy,
						 phoneaddr_chooser IN [2,4] => r.dirsaddr_cmpy,
						 '');
					    
	self.dirsaddr_firstscore := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_firstscore,
							  phoneaddr_chooser IN [2,4] => r.dirsaddr_firstscore,
							  255);
	self.dirsaddr_lastscore := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_lastscore,
							 phoneaddr_chooser IN [2,4] => r.dirsaddr_lastscore,
							 255);
	self.dirsaddr_addrscore := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_addrscore,
							 phoneaddr_chooser IN [2,4] => r.dirsaddr_addrscore,
							 255);
	self.dirsaddr_phonescore := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_phonescore,
							  phoneaddr_chooser IN [2,4] => r.dirsaddr_phonescore,
							  255);
	self.dirsaddr_cmpyscore := MAP(phoneaddr_chooser IN [1,3] => l.dirsaddr_cmpyscore,
							 phoneaddr_chooser IN [2,4] => r.dirsaddr_cmpyscore,
							 255);
							  
	
	// Per Bug 44805 - The utilityaddr_socscount was throwing off the chooser for select cases (See bug). This socscount shouldn't be taken
	//   into account as the utility data is being used.
	utili_chooser := l.utiliaddr_firstcount+l.utiliaddr_lastcount+l.utiliaddr_addrcount+l.utiliaddr_phonecount >=
									 r.utiliaddr_firstcount+r.utiliaddr_lastcount+r.utiliaddr_addrcount+r.utiliaddr_phonecount;
	
	self.utiliaddr_firstcount := IF(utili_chooser,l.utiliaddr_firstcount,r.utiliaddr_firstcount);
	self.utiliaddr_lastcount := IF(utili_chooser,l.utiliaddr_lastcount,r.utiliaddr_lastcount);
	self.utiliaddr_addrcount := IF(utili_chooser,l.utiliaddr_addrcount,r.utiliaddr_addrcount);
	self.utiliaddr_phonecount := IF(utili_chooser,l.utiliaddr_phonecount,r.utiliaddr_phonecount);
	self.utiliaddr_socscount := IF(utili_chooser,l.utiliaddr_socscount,r.utiliaddr_socscount);
	self.utiliaddr_date := MAX(l.utiliaddr_date,r.utiliaddr_date);
	self.utiliaddr_last_seen_date := MAX(l.utiliaddr_last_seen_date,r.utiliaddr_last_seen_date);
	self.utiliaddr_first_seen_date := ut.min2(l.utiliaddr_date,r.utiliaddr_date);
	
	self.utilifirst := IF(utili_chooser,l.utilifirst,r.utilifirst);
	self.utililast := IF(utili_chooser,l.utililast,r.utililast);
	self.utili_prim_range := IF(utili_chooser,l.utili_prim_range,r.utili_prim_range);
	self.utili_predir := IF(utili_chooser,l.utili_predir,r.utili_predir);
	self.utili_prim_name := IF(utili_chooser,l.utili_prim_name,r.utili_prim_name);
	self.utili_suffix := IF(utili_chooser,l.utili_suffix,r.utili_suffix);
	self.utili_postdir := IF(utili_chooser,l.utili_postdir,r.utili_postdir);
	self.utili_unit_desig := IF(utili_chooser,l.utili_unit_desig,r.utili_unit_desig);
	self.utili_sec_range := IF(utili_chooser,l.utili_sec_range,r.utili_sec_range);
	self.utilicity := IF(utili_chooser,l.utilicity,r.utilicity);
	self.utilistate := IF(utili_chooser,l.utilistate,r.utilistate);
	self.utilizip := IF(utili_chooser,l.utilizip,r.utilizip);
	self.utiliphone := IF(utili_chooser,l.utiliphone,r.utiliphone);
	
	self.utili_firstscore := IF(utili_chooser,l.utili_firstscore,r.utili_firstscore);
	self.utili_lastscore := IF(utili_chooser,l.utili_lastscore,r.utili_lastscore);
	self.utili_addrscore := IF(utili_chooser,l.utili_addrscore,r.utili_addrscore);
	self.utili_phonescore := If(utili_chooser,l.utili_phonescore,r.utili_phonescore);
	
	phone_sources := l.phone_sources + r.phone_sources;
	phone_sources_cat := if(stringlib.stringfind(phone_sources, 'GH', 1) > 0, 'GH,', '') + 
												if(stringlib.stringfind(phone_sources, 'WP', 1) > 0, 'WP,', '') + 
												if(stringlib.stringfind(phone_sources, 'TG', 1) > 0, 'TG,', '') + 
												if(stringlib.stringfind(phone_sources, 'U', 1) > 0, 'U,', '') + 
												if(stringlib.stringfind(phone_sources, 'IR', 1) > 0, 'IR,', '') +
												if(stringlib.stringfind(phone_sources, 'PA', 1) > 0, 'PA,', '');
	self.phone_sources := trim(phone_sources_cat);
	
	self.isAddrPhoneConnected := l.isAddrPhoneConnected or r.isAddrPhoneConnected;
	
	self := l;
END;

phonerecsByaddr_rolled := rollup(if(BSversion>1, phonesPerAddr, phonerecsByaddr),true,roll_addr_trans(left,right));

risk_indicators.layout_output utiliByAddr(risk_indicators.layout_output le, UtilFile.Key_Address ri) := TRANSFORM
	firstmatch_score := risk_indicators.FnameScore(le.fname, ri.fname);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(ri.fname);
	firstmatch := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, le.fname=ri.fname, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=ri.fname or n1=n2, true);
	lastmatch_score := risk_indicators.LnameScore(le.lname, ri.lname);
	lastmatch := iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, le.lname=ri.lname, true);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.p_city_name, ri.st, le.cityzipflag);
	// addrmatch_score := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						// ri.prim_range, ri.prim_name, ri.sec_range,
																						// zip_score, cityst_score);
	addrmatch_score := IF(ExactAddrZip5andPrimRange,
												IF(zip_score=100
													 and Risk_Indicators.AddrScore.primRange_score(le.prim_range, ri.prim_range)=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore( le.prim_range, le.prim_name, le.sec_range, 
																																ri.prim_range, ri.prim_name, ri.sec_range,
																																zip_score, cityst_score));
																						
	addrmatch := iid_constants.ga(addrmatch_score) and if(ExactAddrRequired, le.prim_range=ri.prim_range and le.prim_name=ri.prim_name and 
																																						(le.in_zipcode=ri.zip or le.z5=ri.zip or 
																																							(le.in_city=ri.p_city_name and le.in_state=ri.st) or (le.p_city_name=ri.p_city_name and le.st=ri.st)) and
																																						ut.nneq(le.sec_range,ri.sec_range), true);
	phonematch_score := risk_indicators.PhoneScore(le.phone10, ri.phone);
	phonematch := iid_constants.gn(phonematch_score) and if(ExactPhoneRequired, le.phone10=ri.phone, true);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ri.ssn);
	socsmatch := iid_constants.gn(socsmatchscore) and if(ExactSSNRequired, le.ssn=ri.ssn, true);
	
	goodHit := IF(((INTEGER)firstmatch+(INTEGER)lastmatch+(INTEGER)addrmatch+(INTEGER)phonematch/*+(INTEGER)socsmatch*/)>1,true,false);	// only keep the info if 2 elements match

	self.utiliaddr_firstcount := IF((require2Ele and goodHit) or ~require2Ele, IF(firstmatch,1,0),0);
	self.utiliaddr_lastcount := IF((require2Ele and goodHit) or ~require2Ele, IF(lastmatch,1,0),0);
	self.utiliaddr_addrcount := IF((require2Ele and goodHit) or ~require2Ele, IF(addrmatch,1,0),0);
	self.utiliaddr_phonecount := IF((require2Ele and goodHit) or ~require2Ele, IF(phonematch,1,0),0);
	self.utiliaddr_socscount := IF((require2Ele and goodHit) or ~require2Ele, IF(socsmatch,1,0),0);
	self.utiliaddr_date := IF((require2Ele and goodHit) or ~require2Ele, (INTEGER)(ri.connect_date[1..6]),0);
	self.utiliaddr_last_seen_date := IF((require2Ele and goodHit) or ~require2Ele, (INTEGER)(ri.record_date[1..6]),0);
	
	self.utilifirst := IF((require2Ele and goodHit) or ~require2Ele, ri.fname,'');
	self.utililast := IF((require2Ele and goodHit) or ~require2Ele, ri.lname,'');
	self.utili_prim_range := IF((require2Ele and goodHit) or ~require2Ele, ri.prim_range,'');
	self.utili_predir := IF((require2Ele and goodHit) or ~require2Ele, ri.predir,'');
	self.utili_prim_name := IF((require2Ele and goodHit) or ~require2Ele, ri.prim_name,'');
	self.utili_suffix := IF((require2Ele and goodHit) or ~require2Ele, ri.addr_suffix,'');
	self.utili_postdir := IF((require2Ele and goodHit) or ~require2Ele, ri.postdir,'');
	self.utili_unit_desig := IF((require2Ele and goodHit) or ~require2Ele, ri.unit_desig,'');
	self.utili_sec_range := IF((require2Ele and goodHit) or ~require2Ele, ri.sec_range,'');									 
	self.utilicity := IF((require2Ele and goodHit) or ~require2Ele, ri.p_city_name,'');
	self.utilistate := IF((require2Ele and goodHit) or ~require2Ele, ri.st,'');
	self.utilizip := IF((require2Ele and goodHit) or ~require2Ele, ri.zip + ri.zip4,'');
	self.utiliphone := IF((require2Ele and goodHit) or ~require2Ele, ri.phone,'');
	
	self.utili_firstscore := IF((require2Ele and goodHit) or ~require2Ele, firstmatch_score,255);
	self.utili_lastscore := IF((require2Ele and goodHit) or ~require2Ele, lastmatch_score,255);
	self.utili_addrscore := IF((require2Ele and goodHit) or ~require2Ele, addrmatch_score,255);
	self.utili_citystatescore := IF((require2Ele and goodHit) or ~require2Ele, cityst_score,255);
	self.utili_zipscore := IF((require2Ele and goodHit) or ~require2Ele, zip_score,255);
	self.utili_phonescore := IF((require2Ele and goodHit) or ~require2Ele, phonematch_score,255);
	
	self.phone_sources := map(goodhit and phonematch and trim(le.phone_sources)='' =>	'U,',
													goodhit and phonematch =>	le.phone_sources + 'U,',
													le.phone_sources);
													
	SELF := le;
END;

utiliRecsByAddr_roxie := if (isFCRA, PhoneRecsByAddr_rolled,
				   JOIN(phoneRecsByAddr_rolled, UtilFile.Key_Address,
					(isFCRA or ut.PermissionTools.glb.ok( glb)) and
					left.z5!='' and left.prim_name != '' and
					~isUtility AND keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and keyed(left.sec_range=right.sec_range) and
					// check pullid
					LEFT.pullidflag = '' AND					
					// check date
					((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
					// addr type = 'S' means that this is the service address
					RIGHT.addr_type='S',
					// ut.DaysApart(myGetDate,((STRING6)RIGHT.connect_date+'31')) <= 365,
				   utiliByAddr(left,right),left outer, 
				   ATMOST(
					  keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					  keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and 
					  keyed(left.sec_range=right.sec_range), 100)));

utiliRecsByAddr_thor := if (isFCRA, PhoneRecsByAddr_rolled,
				   group(sort(JOIN(distribute(phoneRecsByAddr_rolled, hash64(prim_name, z5, prim_range)), 
					distribute(pull(UtilFile.Key_Address), hash64(prim_name, zip, prim_range)),
					(isFCRA or ut.PermissionTools.glb.ok( glb)) and
					left.z5!='' and left.prim_name != '' and
					~isUtility AND  (left.prim_name=right.prim_name) and (left.st=right.st) and 
					(left.z5=right.zip) and (left.prim_range=right.prim_range) and (left.sec_range=right.sec_range) and
					// check pullid
					LEFT.pullidflag = '' AND					
					// check date
					((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)) AND
					// addr type = 'S' means that this is the service address
					RIGHT.addr_type='S',
					// ut.DaysApart(myGetDate,((STRING6)RIGHT.connect_date+'31')) <= 365,
				   utiliByAddr(left,right),left outer, 
				   ATMOST(
					   (left.prim_name=right.prim_name) and (left.st=right.st) and 
					  (left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and 
					  (left.sec_range=right.sec_range), 100), LOCAL),seq),seq));
						
#IF(onThor)
	utiliRecsByAddr := utiliRecsByAddr_thor;
#ELSE
	utiliRecsByAddr := utiliRecsByAddr_roxie;
#END

utiliRecsByAddr_rolled := if (isFCRA, utiliRecsByAddr,
						rollup(utiliRecsByAddr,true,roll_addr_trans(left,right)));
						
// output(dirs_by_addr, named('dirsbyaddr'));
// output(phonerecsByaddr_history, named('phonerecsByaddr_history'));									
// output(phonesPerAddr, named('phonesPerAddr'));									
// output(phonerecsByaddr_rolled, named('phonerecsByaddr_rolled'));									
return utiliRecsByAddr_rolled;
						
end;