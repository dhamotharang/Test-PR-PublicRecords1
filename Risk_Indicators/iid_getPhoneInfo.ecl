import _Control, riskwise, did_add, ut, risk_indicators, NID, gateway;
onThor := _Control.Environment.OnThor;

export iid_getPhoneInfo(grouped dataset(risk_indicators.Layout_Output) with_address_info, dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa, unsigned1 glb, 
													boolean isFCRA, boolean require2Ele, 
													integer BSversion, boolean allowCellphonesIn,
													string10 ExactMatchLevel= risk_indicators.iid_constants.default_ExactMatchLevel,
													unsigned3 LastSeenThreshold = risk_indicators.iid_constants.oneyear,
													unsigned8 BSOptions=0,
													string20 companyID,
													unsigned2 EverOccupant_PastMonths=0,
													unsigned4 EverOccupant_StartDate = 99999999,
													boolean IncludeNAPData = false
												) := function

ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[iid_constants.posExactPhoneMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;
ExactAddrZip5andPrimRange := ExactMatchLevel[iid_constants.posExactAddrZip5andPrimRange]=iid_constants.sTrue;


// As of 3/7/2012 per bug 97686 we are not going to EID3220 and will send all gateway traffic to PDE until further notice
// so set doE3220 to false here for now and if it was going to go to EID3220, treat it like idp1 and send those phones to PDE
doE3220 := false;//exists(gateways(servicename='targuse3220'));
allowCellPhones := allowCellphonesIn OR exists(gateways(servicename='targuse3220'));
doInquiries := (BSOptions & iid_constants.BSOptions.IncludeInquiries)>0;	// this flag is set in main query based off of several items being true, DRM 16, ~disable inquries and ciid v1 (for now)
IIDv1 := (BSOptions & risk_indicators.iid_constants.BSOptions.IsInstantIDv1) > 0;
cellPhoneTypes := ['04','55','60','01','57','62','64','65'];	

// by searching the inquiry results this way, we are rolling them up like NAS does and not picking the best 1 result - 
// using this newly created iid_getInquiryNAP for now but might want to change to use boca shell inquiries for code maintenance
// bsversion must be >= 50 for historydatetimestamp enhancement [Bug 148853]
withInquiriesNAP := if(doInquiries and ~isFCRA, risk_indicators.iid_getInquiryNAP(with_address_info, isFCRA, ExactMatchLevel, LastSeenThreshold, 50), with_address_info);


Risk_Indicators.Layouts.layout_input_plus_overrides prep_phones(risk_indicators.layout_output le, integer C) := transform
	// use original phone as input, unless the dirsaddr_phone or utiliphone indicate a miskeyed phone
	homephone := map(ExactPhoneRequired => le.phone10,
									iid_constants.gn(le.dirsaddr_phonescore) and length(trim(le.dirsaddr_phone))=10 => le.dirsaddr_phone,
									iid_constants.gn(le.utili_phonescore) and length(trim(le.utiliphone))=10 => le.utiliphone,
									le.phone10);
									
	// only search the phone data with valid phones. blank out phone10 if invalid, and the dirsByPhone ignores blank phones on input
	self.phone10 := choose(c, if(le.hphonevalflag in ['1','2','3','4','5'], homephone,''), if(le.wphonevalflag in ['1','2','3','4','5'], le.wphone10,''));

	cell_phone_nxx_types := if(allowCellphones or doE3220, cellPhoneTypes, []);	
	
	// allow call to targus - dont call targus if we verified the phone on inquiries
	doTargus := choose(c, (le.isPOTS or trim(le.nxx_type) in cell_phone_nxx_types) AND le.inquiryNAPphonecount=0, false);
	
	// populate the work phone field with the homephone if it isPOTS or if we are allowing cell phones(GE) or E3220 is requested and the homephone is a cell phone
	self.wphone10 := choose(c, if(doTargus, homephone,''), '');	//check for blank phones
	
	// populate the lname_prev field with "E3220" for targus3220 input, so that getTargusGW knows to call this service or not
	self.lname_prev := choose(c, if((trim(le.nxx_type) in cell_phone_nxx_types) and doE3220, 'E3220', ''),'');
	
	self := le;
end;

phone_input := normalize(withInquiriesNAP,2, prep_phones(left, counter));

dirs_by_phone := riskwise.getDirsByPhone(ungroup(phone_input), gateways, dppa, glb, isFCRA, BSOptions, lastSeenThreshold, ExactMatchLevel, companyID);


risk_indicators.layout_output phvertrans(risk_indicators.layout_output le, dirs_by_phone ri) := transform
	firstscore := risk_indicators.FnameScore(le.fname, ri.name_first);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(ri.name_first);
	firstmatch := iid_constants.g(firstscore) and if(ExactFirstNameRequired, le.fname=ri.name_first, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=ri.name_first or n1=n2, true);			
	lastscore := risk_indicators.LnameScore(le.lname, ri.name_last);
	lastmatch := iid_constants.g(lastscore) and if(ExactLastNameRequired, le.lname=ri.name_last, true);
	
	zip_score1 := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.z5);
	primRange_score1 := Risk_Indicators.AddrScore.primRange_score(le.prim_range, ri.prim_range);
	cityst_score1 := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.p_city_name, ri.st, le.cityzipflag);
	// addrscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						// ri.prim_range, ri.prim_name, ri.sec_range,
																						// zip_score, cityst_score);
	addrmatch_score1 := IF(ExactAddrZip5andPrimRange,
									IF(zip_score1=100
										and primRange_score1=100,
										100, 11),
									Risk_Indicators.AddrScore.AddressScore( le.prim_range, le.prim_name, le.sec_range, 
																													ri.prim_range, ri.prim_name, ri.sec_range,
																													zip_score1, cityst_score1));
																						
	addrmatch := iid_constants.ga(addrmatch_score1) and if(ExactAddrRequired, le.prim_range=ri.prim_range and le.prim_name=ri.prim_name and 
																																			(le.in_zipcode=ri.z5 or le.z5=ri.z5 or 
																																						(le.in_city=ri.p_city_name and le.in_state=ri.st) or (le.p_city_name=ri.p_city_name and le.st=ri.st)) and
																																			ut.nneq(le.sec_range,ri.sec_range), true);
	phonescore := risk_indicators.PhoneScore(le.phone10, ri.phone10);
	phonematch := iid_constants.gn(phonescore) and if(ExactPhoneRequired, le.phone10=ri.phone10, true);
	cmpyscore := IF(ri.business_flag, did_add.company_name_match_score(le.employer_name, ri.listed_name), 255);
	cmpymatch := iid_constants.gc(cmpyscore);
	
	goodHit := IF(((INTEGER)firstmatch+(INTEGER)lastmatch+(INTEGER)addrmatch+(INTEGER)phonematch+(INTEGER)cmpymatch)>1,true,false);	// only keep the record if it matches at least 2 elements
	
	self.isPhoneConnected := ri.phone10<>'' and ri.current_flag and ri.src in ['GH','WP','TG'];	// new logic to determine if we have a connected phone for ciid v1
	self.idtheftflag := MAP(lastscore < iid_constants.min_score and (ri.name_last<>'' or ri.geo_lat<>'') => '1',
													//isDisjoint => 2,
													'0');

	disc_prior := IF (le.historydate=iid_constants.default_history_date,
															if(le.phonedissflag and ri.current_flag, false, le.phonedissflag),	// if realtime
															if((((unsigned) (Ri.dt_first_seen[1..6]) < le.historydate) AND (le.historydate <= (unsigned) (Ri.dt_last_seen[1..6]))) or le.phone10='' or ri.phone10='', false, true));				
					
	disc_archive :=map(	(((unsigned)(Ri.dt_first_seen[1..6]) < le.historydate) AND 
													(le.historydate <= (unsigned) (Ri.dt_last_seen[1..6]))) => false,
											(((unsigned)(Ri.dt_first_seen[1..6]) < le.historydate) AND 
													(ri.current_flag and (integer) ri.deletion_date = 0)) => false,
											le.phone10='' or ri.phone10='' => false,	
											true);

	disc_realtime :=  map(ri.current_flag => false,
												ri.current_flag = false and ri.p7 != '' => true,//old non-current phones so don't set as false		
												le.phone10='' or ri.phone10='' => false,
												le.phonedissflag);
	disc_new := if(le.historydate = iid_constants.default_history_date, disc_realtime, disc_archive);

	disc := if(BSVersion < 41, disc_prior, disc_new);
	self.phonedissflag := disc;
																	
	self.hriskphoneflag := if(le.hriskphoneflag='5' and ~disc, '0', le.hriskphoneflag);
	
	self.hphonetypeflag := le.hphonetypeflag;

	self.phonevalflag := if (~disc, map(	ri.business_flag or ri.listing_type_bus != '' => '1', // valid business phone	
																				ri.listing_type_res != ''                     => '2', // valid residential phone
																				le.phonevalflag
																			), if(ri.phone10<>'', '3', le.phonevalflag));	// if disconnected check if it exists
													
	self.hphonevalflag := if(~disc, map(	le.hphonevalflag = '3' 												 => '3', // high risk, keep high risk if it was	
																				ri.business_flag	or ri.listing_type_bus != '' => '1', // valid business phone
																				ri.listing_type_res != ''                      => '2', // valid residential phone
																				le.hphonevalflag
																			), if(ri.phone10<>'', '5', le.hphonevalflag));	// if disconnected check if it exists


	self.phonefirstcount := IF((require2Ele and goodHit) or ~require2Ele, IF(firstmatch,1,0),0);
	self.phonelastcount := IF((require2Ele and goodHit) or ~require2Ele, IF(lastmatch,1,0),0);
	self.phoneaddrcount := IF((require2Ele and goodHit) or ~require2Ele, IF(addrmatch,1,0),0);
	self.phonephonecount := IF((require2Ele and goodHit) or ~require2Ele, IF(phonematch,1,0),0);
	self.phonecmpycount := IF((require2Ele and goodHit) or ~require2Ele, IF(cmpymatch,1,0),0);
	
	// added extra logic for processing with archive dates
	self.phone_disconnected := IF((require2Ele and goodhit) or ~require2Ele and disc, ri.p7<>''/* AND (ri.deletion_date!='' and ri.deletion_date < full_history_date)*/, false);
	self.phone_disconnectdate := IF(self.phone_disconnected, (INTEGER)(ri.deletion_date[1..6]),0);	
	SELF.phone_disconnectcount := IF((require2Ele and goodHit) or ~require2Ele, ri.disc_cnt12,0);
	self.phone_date_last_seen := IF(goodHit, (unsigned)ri.dt_last_seen,0);// require 2 elements 
	self.phone_date_first_seen := IF(goodHit, (unsigned)ri.dt_first_seen,0);// require 2 elements 
	
	self.dirsfirst := IF((require2Ele and goodHit) or ~require2Ele, ri.name_first,'');
	self.dirslast := IF((require2Ele and goodHit) or ~require2Ele, ri.name_last,'');
	self.dirs_prim_range := IF((require2Ele and goodHit) or ~require2Ele, ri.prim_range,'');
	self.dirs_predir := IF((require2Ele and goodHit) or ~require2Ele, ri.predir,'');
	self.dirs_prim_name := IF((require2Ele and goodHit) or ~require2Ele, ri.prim_name,'');
	self.dirs_suffix := IF((require2Ele and goodHit) or ~require2Ele, ri.suffix,'');
	self.dirs_postdir := IF((require2Ele and goodHit) or ~require2Ele, ri.postdir,'');
	self.dirs_unit_desig := IF((require2Ele and goodHit) or ~require2Ele, ri.unit_desig,'');
	self.dirs_sec_range := IF((require2Ele and goodHit) or ~require2Ele, ri.sec_range,'');
	self.dirscity := IF((require2Ele and goodHit) or ~require2Ele, ri.p_city_name,'');
	self.dirsstate := IF((require2Ele and goodHit) or ~require2Ele, ri.st,'');
	self.dirszip := IF((require2Ele and goodHit) or ~require2Ele, ri.z5+ri.z4,'');
	self.dirscmpy := IF(((require2Ele and goodHit) or ~require2Ele) and ri.business_flag, ri.listed_name,'');
	
	self.disthphoneaddr := IF(length(trim(le.phone10))=10,if(le.lat='' or ri.geo_lat='',9999,round(ut.ll_dist((REAL)le.lat,(REAL)le.long,(REAL)ri.geo_lat,(REAL)ri.geo_long))),9999);
	
	self.dirs_firstscore := IF((require2Ele and goodHit) or ~require2Ele, firstscore,255);
	self.dirs_lastscore := IF((require2Ele and goodHit) or ~require2Ele, lastscore,255);
	self.dirs_addrscore := IF((require2Ele and goodHit) or ~require2Ele, addrmatch_score1,255);
	self.dirs_citystatescore := IF((require2Ele and goodHit) or ~require2Ele, cityst_score1,255);
	self.dirs_zipscore := IF((require2Ele and goodHit) or ~require2Ele, zip_score1,255);
	self.dirs_phonescore := IF((require2Ele and goodHit) or ~require2Ele, phonescore,255);
	self.dirs_cmpyscore := IF((require2Ele and goodHit) or ~require2Ele, cmpyscore,255);
	
	self.hphonelat := ri.geo_lat;
	self.hphonelong := ri.geo_long;
	
	self.p_did := ri.did;
	self.adls_per_phone := if(ri.did!=0, 1, 0);
	self.adls_per_phone_current := if(BSversion < 41, 
				 if(ri.did!=0 and ~disc, 1, 0),
				 if(ri.did!=0 and ~disc and ri.listing_type_res != '', 1, 0)); //don't count businesses
	
	self.adls_per_phone_created_6months := if(ri.did!=0 and ut.DaysApart(iid_constants.myGetDate(le.historydate), ri.dt_first_seen) < 183, 1, 0);
	
	p_street := trim(trim(ri.prim_range) + trim(ri.prim_name));
	self.p_street := p_street;
	self.addrs_per_phone := if(p_street!='', 1, 0);
	self.addrs_per_phone_created_6months := if(p_street!='' and ut.DaysApart(iid_constants.myGetDate(le.historydate), ri.dt_first_seen) < 183, 1, 0);
	
	self.targusgatewayused := ri.targusgatewayused;
	self.targustype := ri.targustype;
	self.publish_code := map(
		ri.publish_code='P' => 'P',
		lastmatch and  addrmatch => '5', // triggers isCode75
		lastmatch  => '4',
		addrmatch  => '3',
		firstmatch => '2',
		phonematch => '1',
		'0'
	);
	
	self.phone_sources := map(goodhit and trim(le.phone_sources)='' =>	ri.src + ',',
													goodhit =>	le.phone_sources + ri.src + ',',
													le.phone_sources);
													
	self.phoneSourceUsed := if(ri.phone10<>'', ri.src+',', '');
	self.src := ri.src;															
	self := le;
END;

biggestrec_history_roxie := join(withInquiriesNAP,dirs_by_phone,
					left.phone10<>'' and
								(IF(iid_constants.gn(left.dirsaddr_phonescore) and length(trim(left.dirsaddr_phone))=10,left.dirsaddr_phone[4..10],
								IF(iid_constants.gn(left.utili_phonescore) and length(trim(left.utiliphone))=10,left.utiliphone[4..10],left.phone10[4..10]))=right.p7) and 
								(IF(iid_constants.gn(left.dirsaddr_phonescore) and length(trim(left.dirsaddr_phone))=10,left.dirsaddr_phone[1..3],
								IF(iid_constants.gn(left.utili_phonescore) and length(trim(left.utiliphone))=10,left.utiliphone[1..3],left.phone10[1..3]))=right.p3) and 
					// check pullid
					LEFT.pullidflag = '' AND					
					// check date
					((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
					(RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
					phvertrans(left,right), left outer, many lookup, 
					keep(300));

with_InquiriesNAP_withPhone := withInquiriesNAP(phone10<>'' OR iid_constants.gn(dirsaddr_phonescore) or iid_constants.gn(utili_phonescore));
with_InquiriesNAP_noPhone := withInquiriesNAP(phone10='' AND NOT risk_indicators.iid_constants.gn(dirsaddr_phonescore) AND NOT risk_indicators.iid_constants.gn(utili_phonescore));

biggestrec_history_thor_pre := join(distribute( with_InquiriesNAP_withPhone, 
								hash64(IF(iid_constants.gn(dirsaddr_phonescore) and length(trim(dirsaddr_phone))=10,dirsaddr_phone,
																					IF(iid_constants.gn(utili_phonescore) and length(trim(utiliphone))=10,utiliphone,phone10)))),
								distribute(dirs_by_phone, hash64(p3+p7)),
								(IF(iid_constants.gn(left.dirsaddr_phonescore) and length(trim(left.dirsaddr_phone))=10,left.dirsaddr_phone[4..10],
								IF(iid_constants.gn(left.utili_phonescore) and length(trim(left.utiliphone))=10,left.utiliphone[4..10],left.phone10[4..10]))=right.p7) and 
								(IF(iid_constants.gn(left.dirsaddr_phonescore) and length(trim(left.dirsaddr_phone))=10,left.dirsaddr_phone[1..3],
								IF(iid_constants.gn(left.utili_phonescore) and length(trim(left.utiliphone))=10,left.utiliphone[1..3],left.phone10[1..3]))=right.p3) and 
					// check pullid
					LEFT.pullidflag = '' AND					
					// check date
					((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)) AND
					(RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
					phvertrans(left,right), left outer, 
					keep(300), LOCAL);

biggestrec_history_thor_nophone := project(with_InquiriesNAP_noPhone,
																					transform(risk_indicators.layout_output,
																											self.dirs_addrscore := 255;
																											self.dirs_firstscore := 255;
																											self.dirs_lastscore := 255;
																											self.publish_code := '0';
																											self.idtheftflag := '0';
																											self.dirs_citystatescore := 255;
																											self.dirs_zipscore := 255;
																											self.dirs_phonescore := 255;
																											self.dirs_cmpyscore := 255;
																											self.hphonelat := '';
																											self.hphonelong := '';
																											self := left));

biggestrec_history_thor := group(sort(biggestrec_history_thor_pre + biggestrec_history_thor_nophone, seq, -phone_date_last_seen, dirslast,dirsfirst,dirscmpy, record/*,-dirs_addrscore*/), seq);

biggestrec_history_roxie_sort := IF(IsFCRA, sort(biggestrec_history_roxie,seq, -phone_date_last_seen, dirslast,dirsfirst,dirscmpy, record), biggestrec_history_roxie);

#IF(onThor)
	biggestrec_history := biggestrec_history_thor;
#ELSE
	biggestrec_history := biggestrec_history_roxie_sort;
#END

phone_velocity := risk_indicators.iid_roll_PhoneVelocity(biggestrec_history);


risk_indicators.layout_output roll_phone_trans(risk_indicators.layout_output l,risk_indicators.layout_output r) := transform

	countLeft := l.phonefirstcount+l.phonelastcount+l.phoneaddrcount+l.phonephonecount+l.phonecmpycount;
	countRight := r.phonefirstcount+r.phonelastcount+r.phoneaddrcount+r.phonephonecount+r.phonecmpycount;

	// change this phone chooser to look at the phone source for ciid v1 updates
	phone_chooser := MAP(	~l.phone_disconnected AND r.phone_disconnected  AND l.phone_sources in ['GH,','WP,','TG,'] AND r.phone_sources in ['GH,','WP,','TG,']	=>	true,
												l.phone_disconnected AND ~r.phone_disconnected  AND l.phone_sources in ['GH,','WP,','TG,']  AND r.phone_sources in ['GH,','WP,','TG,']	=>	false,
												countLeft >= countRight);
																				
																
	self.phoneSourceUsed := IF(phone_chooser, TRIM(l.phoneSourceused,all), TRIM(r.phoneSourceUsed,all));
																
	self.hriskphoneflag := if(l.hriskphoneflag='0', l.hriskphoneflag, r.hriskphoneflag);	
	self.hphonetypeflag := l.hphonetypeflag;	
	self.phonevalflag := l.phonevalflag;	
	self.hphonevalflag := l.hphonevalflag;	
	self.phonedissflag := if(~l.phonedissflag, l.phonedissflag, r.phonedissflag);
												
	self.phonefirstcount := IF(phone_chooser,l.phonefirstcount,r.phonefirstcount);
	self.phonelastcount := IF(phone_chooser,l.phonelastcount,r.phonelastcount);
	self.phoneaddrcount := IF(phone_chooser,l.phoneaddrcount,r.phoneaddrcount);
	self.phonephonecount := IF(phone_chooser,l.phonephonecount,r.phonephonecount);
	self.phonecmpycount := IF(phone_chooser,l.phonecmpycount,r.phonecmpycount);
	self.phone_disconnected := IF(phone_chooser,l.phone_disconnected, r.phone_disconnected);
	self.phone_disconnectdate := IF(l.phone_disconnected AND r.phone_disconnected,
								MAX(l.phone_disconnectdate,r.phone_disconnectdate),
							   IF(phone_chooser,l.phone_disconnectdate,r.phone_disconnectdate));
	self.phone_disconnectcount := MAX(l.phone_disconnectcount,r.phone_disconnectcount);
	self.phone_date_last_seen := MAX(l.phone_date_last_seen, r.phone_date_last_seen);
	self.phone_date_first_seen := ut.Min2(l.phone_date_first_seen, r.phone_date_first_seen);
	
	self.dirsfirst := IF(phone_chooser,l.dirsfirst,r.dirsfirst);
	self.dirslast := IF(phone_chooser,l.dirslast,r.dirslast);
	self.dirs_prim_range := IF(phone_chooser,l.dirs_prim_range,r.dirs_prim_range);
	self.dirs_predir := IF(phone_chooser,l.dirs_predir,r.dirs_predir);
	self.dirs_prim_name := IF(phone_chooser,l.dirs_prim_name,r.dirs_prim_name);
	self.dirs_suffix := IF(phone_chooser,l.dirs_suffix,r.dirs_suffix);
	self.dirs_postdir := IF(phone_chooser,l.dirs_postdir,r.dirs_postdir);
	self.dirs_unit_desig := IF(phone_chooser,l.dirs_unit_desig,r.dirs_unit_desig);
	self.dirs_sec_range := IF(phone_chooser,l.dirs_sec_range,r.dirs_sec_range);
	self.dirscity := IF(phone_chooser,l.dirscity,r.dirscity);
	self.dirsstate := IF(phone_chooser,l.dirsstate,r.dirsstate);
	self.dirszip := IF(phone_chooser,l.dirszip,r.dirszip);
	self.dirscmpy := IF(phone_chooser,l.dirscmpy,r.dirscmpy);
	
	self.dirs_firstscore := IF(phone_chooser,l.dirs_firstscore,r.dirs_firstscore);
	self.dirs_lastscore := IF(phone_chooser,l.dirs_lastscore,r.dirs_lastscore);
	self.dirs_addrscore := IF(phone_chooser,l.dirs_addrscore,r.dirs_addrscore);
	self.dirs_citystatescore := IF(phone_chooser,l.dirs_citystatescore,r.dirs_citystatescore);
	self.dirs_zipscore := IF(phone_chooser,l.dirs_zipscore,r.dirs_zipscore);
	self.dirs_phonescore := IF(phone_chooser,l.dirs_phonescore,r.dirs_phonescore);
	self.dirs_cmpyscore := IF(phone_chooser,l.dirs_cmpyscore,r.dirs_cmpyscore);
	self.publish_code := map(
		// pick current published numbers when present.
		 phone_chooser and l.publish_code='P' => 'P',
		~phone_chooser and r.publish_code='P' => 'P',
		(string1)max( (integer1)l.publish_code, (integer1)r.publish_code) // all non-'P' values are numeric, and higher values take precedence
	);
	self.disthphoneaddr := MIN((INTEGER)l.disthphoneaddr,(INTEGER)r.disthphoneaddr);
	self.disthphonewphone := MIN((INTEGER)l.disthphonewphone,(INTEGER)r.disthphonewphone);
	self.distwphoneaddr := MIN((INTEGER)l.distwphoneaddr,(INTEGER)r.distwphoneaddr);
	self.idtheftflag := IF(phone_chooser, l.idtheftflag, r.idtheftflag);
		
	wphone_chooser := MAP(~l.phone_disconnected AND r.phone_disconnected		=>	true,
					  l.phone_disconnected AND ~r.phone_disconnected		=>	false,
					  l.phonefirstcount+l.phonelastcount+l.phoneaddrcount+l.phonephonecount+l.phonecmpycount >=
																r.phonefirstcount+r.phonelastcount+r.phoneaddrcount+r.phonephonecount+r.phonecmpycount);
																
	self.wphonewphonecount := IF(wphone_chooser, l.wphonewphonecount,r.wphonewphonecount);
	self.wphonewphonescore := IF(wphone_chooser, l.wphonewphonescore, r.wphonewphonescore);
	
	self.wphonename := IF(wphone_chooser, l.wphonename,r.wphonename);
	self.wphoneaddr := IF(wphone_chooser, l.wphoneaddr,r.wphoneaddr);
	self.wphonecity := IF(wphone_chooser, l.wphonecity,r.wphonecity);
	self.wphonestate := IF(wphone_chooser, l.wphonestate,r.wphonestate);
	self.wphonezip := IF(wphone_chooser, l.wphonezip,r.wphonezip);
	
	self.wphonedissflag := if(~l.wphonedissflag, l.wphonedissflag, r.wphonedissflag);
	
	self.targusgatewayused := l.targusgatewayused or r.targusgatewayused;
	
	phone_sources := l.phone_sources + r.phone_sources;
	phone_sources_cat := if(stringlib.stringfind(phone_sources, 'GH', 1) > 0, 'GH,', '') + 
												if(stringlib.stringfind(phone_sources, 'WP', 1) > 0, 'WP,', '') + 
												if(stringlib.stringfind(phone_sources, 'TG', 1) > 0, 'TG,', '') + 
												if(stringlib.stringfind(phone_sources, 'U', 1) > 0, 'U,', '') + 
												if(stringlib.stringfind(phone_sources, 'IR', 1) > 0, 'IR,', '') +
												if(stringlib.stringfind(phone_sources, 'IP', 1) > 0, 'IP,', '') +
												if(stringlib.stringfind(phone_sources, 'PP', 1) > 0, 'PP,', '') +
												if(stringlib.stringfind(phone_sources, 'S', 1) > 0, 'S,', '');	
	self.phone_sources := trim(phone_sources_cat);
	self.targustype := if(l.targusgatewayused, l.targustype, r.targustype);

	self.isPhoneConnected := l.isPhoneConnected or r.isPhoneConnected;
	
	self := l;
END;

phone_velocity_sorted :=sort(ungroup(phone_velocity), seq, src);
phone_velocity_grped := group(phone_velocity_sorted, seq);
ds_for_rollup := if(BSversion>1, if(BSversion >= 50, phone_velocity_grped, phone_velocity),
							biggestrec_history);
biggestrec_rolled := rollup(ds_for_rollup,true,roll_phone_trans(left,right));


risk_indicators.layout_output wphvertrans(risk_indicators.layout_output l, dirs_by_phone r) := transform
	skip_hw_dist := length(trim(l.wphone10))<>10 OR l.hphonelat='' OR r.geo_lat='';
	self.disthphonewphone := MAP(l.phone10 = l.wphone10 and l.phone10 <> '' => 0,
						    ~skip_hw_dist => round(ut.LL_Dist((REAL)l.hphonelat,(REAL)l.hphonelong,(REAL)r.geo_lat,(REAL)r.geo_long)),
						    9999);
	skip_w_dist := length(trim(l.wphone10))<>10 OR l.lat='' OR r.geo_lat='';
	self.distwphoneaddr := IF(~skip_w_dist,
							round(ut.LL_Dist((REAL)l.lat,(REAL)l.long,
												(REAL)r.geo_lat,(REAL)r.geo_long)),9999);
	self.wphonename := IF(r.business_flag,r.listed_name,'');
	self.wphoneaddr := IF(r.business_flag,Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range,r.predir,r.prim_name,r.suffix,r.postdir,r.unit_desig,r.sec_range),'');
	self.wphonecity := IF(r.business_flag,r.p_city_name,'');
	self.wphonestate := IF(r.business_flag,r.st,'');
	self.wphonezip := IF(r.business_flag,r.z5+r.z4,'');
		
	firstmatch_score := risk_indicators.FnameScore(l.fname, r.name_first);
	n1 := NID.PreferredFirstNew(l.fname);
	n2 := NID.PreferredFirstNew(r.name_first);
	firstmatch := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, l.fname=r.name_first, true) and
							  if(ExactFirstNameRequiredAllowNickname, l.fname=r.name_first or n1=n2, true);	
	lastmatch_score := risk_indicators.LnameScore(l.lname, r.name_last);
	lastmatch := iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, l.lname=r.name_last, true);
	
	zip_score2 := Risk_Indicators.AddrScore.zip_score(l.in_zipcode, r.z5);
	primRange_score2 := Risk_Indicators.AddrScore.primRange_score(l.prim_range, r.prim_range);
	cityst_score2 := Risk_Indicators.AddrScore.citystate_score(l.in_city, l.in_state, r.p_city_name, r.st, l.cityzipflag);
	// addrmatch_score := Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						// r.prim_range, r.prim_name, r.sec_range,
																						// zip_score, cityst_score);
	addrmatch_score2 := IF(ExactAddrZip5andPrimRange,
										IF(zip_score2=100
											and primRange_score2=100,
											100, 11),
										Risk_Indicators.AddrScore.AddressScore( l.prim_range, l.prim_name, l.sec_range, 
																														r.prim_range, r.prim_name, r.sec_range,
																														zip_score2, cityst_score2));
	addrmatch := iid_constants.ga(addrmatch_score2) and if(ExactAddrRequired, l.prim_range=r.prim_range and l.prim_name=r.prim_name and 
																																						(l.in_zipcode=r.z5 or l.z5=r.z5 or 
																																								(l.in_city=r.p_city_name and l.in_state=r.st) or (l.p_city_name=r.p_city_name and l.st=r.st)) and
																																						ut.nneq(l.sec_range,r.sec_range), true);
	wphonescore := risk_indicators.PhoneScore(l.wphone10, r.phone10);
	wphonematch := iid_constants.gn(wphonescore) and if(ExactPhoneRequired, l.wphone10=r.phone10, true);
	cmpyscore := IF(r.business_flag, did_add.company_name_match_score(l.employer_name, r.listed_name), 255);
	cmpymatch := iid_constants.gc(cmpyscore);
	
	goodHit := IF(((INTEGER)firstmatch+(INTEGER)lastmatch+(INTEGER)addrmatch+(INTEGER)wphonematch+(INTEGER)cmpymatch)>1,true,false);	// only keep the record if it matches at least 2 elements
	
	self.wphonewphonecount := IF((require2Ele and goodHit) or ~require2Ele, IF(wphonematch,1,0),0);
	self.wphonewphonescore := IF((require2Ele and goodHit) or ~require2Ele, wphonescore,255);
	
	self.wphonedissflag := if(l.wphonedissflag and r.current_flag, false, l.wphonedissflag);
	
	self := l;
END;
wphonerec_history_roxie := join(biggestrec_rolled,dirs_by_phone,
						left.wphone10<>'' AND left.wphone10[4..10]=right.p7 and left.wphone10[1..3]=right.p3 and
						// check date
						((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
						(RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
						wphvertrans(left,right), left outer, many lookup, 
						ATMOST(
							left.wphone10[4..10]=right.p7 and left.wphone10[1..3]=right.p3,
							RiskWise.max_atmost
						), keep(300));


wphonerec_history_thor_pre := join(distribute(biggestrec_rolled(wphone10<>''), hash64(wphone10)),
						distribute(dirs_by_phone, hash64(p3+p7)),
						left.wphone10<>'' AND left.wphone10[4..10]=right.p7 and left.wphone10[1..3]=right.p3 and
						// check date
						((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
						(RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'), LastSeenThreshold)),
						wphvertrans(left,right), left outer,
						keep(300), LOCAL);

wphonerec_history_thor_nowphone := project(biggestrec_rolled(wphone10=''), transform(risk_indicators.layout_output,
					self.wphonewphonescore := 255;
					self.disthphonewphone := 9999;
					self.distwphoneaddr := 9999;
					self := left));
					
wphonerec_history_thor := wphonerec_history_thor_pre + wphonerec_history_thor_nowphone;

#IF(onThor)
	wphonerec_history := group(sort(wphonerec_history_thor, seq, local), seq, local);
#ELSE
	wphonerec_history := wphonerec_history_roxie;
#END

rollphonerecs := rollup(wphonerec_history,true,roll_phone_trans(left,right));


risk_indicators.layout_output naptrans(risk_indicators.layout_output le) := transform
	 
	 comp_nap(unsigned2 local_phonefirstcount, unsigned2 local_phonelastcount,
			unsigned2 local_phoneaddrcount, unsigned2 local_phonephonecount) := 
					map(local_phonefirstcount=0 and local_phonelastcount=0 and local_phoneaddrcount=0 and local_phonephonecount>=1 =>
						1,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount=0 =>
						2,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						3,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount=0 and local_phonephonecount >=1 => 
						4,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						5,
						local_phonefirstcount=0 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount >=1 => 
						6,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount >=1 => 
						7,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						8,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount>= 1 => 
						9,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						10,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						11,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						12,
						0);
	try1 := IF(le.phoneSourceUsed in ['GH,','WP,','TG,'], comp_nap(le.phonefirstcount, le.phonelastcount, le.phoneaddrcount, le.phonephonecount), 0);	// gong, wp, targus gw
	try2 := IF(le.phoneAddrSourceUsed in ['GH,','WP,'], comp_nap(le.phoneaddr_firstcount, le.phoneaddr_lastcount, le.phoneaddr_addrcount, le.phoneaddr_phonecount), 0);	// gong, wp
	try3 := comp_nap(le.utiliaddr_firstcount, le.utiliaddr_lastcount, le.utiliaddr_addrcount, le.utiliaddr_phonecount);	// utility
	try4 := IF(le.phoneSourceUsed='PP,', comp_nap(le.phonefirstcount, le.phonelastcount, le.phoneaddrcount, le.phonephonecount), 0);	// phonesplus, make this same priority as utility
	try5 := IF(le.phoneAddrSourceUsed='PA,', comp_nap(le.phoneaddr_firstcount, le.phoneaddr_lastcount, le.phoneaddr_addrcount, le.phoneaddr_phonecount), 0);	// phonesplus, make this same priority as utility
	try6 := comp_nap(le.inquiryNAPfirstcount, le.inquiryNAPlastcount, le.inquiryNAPaddrcount, le.inquiryNAPphonecount);	// inquiries, make this same priority as utility	
	try7 := IF(le.phoneSourceUsed='IP,', comp_nap(le.phonefirstcount, le.phonelastcount, le.phoneaddrcount, le.phonephonecount), 0);	// insurance, make this same priority as utility

// 1.  If we have a current phone record "connected/current" use that for the NAP even if the Utility record has a better NAP
// 2.  For a disconnect phone and a utility record scenario use the record with the higher NAP 
	pgood := try1>0 AND ~le.phone_disconnected;
	agood := try2>0 AND ~le.phoneaddr_disconnected;
		
	STRING2 m := 	MAP(
										// new logic to not let targus gateway lower the nap result
										le.targusgatewayused and try1 >= try2 and try1 >= try3 and try1 >= try4 => 'P',	// targusgatewayused means we got a hit on targus gateway (assumed current and at least level 1)
										// take either one if 1 is disconnected and the other one is not and it is better than or equal to all new searches
										pgood AND ~agood and ~le.targusgatewayused and try1 >= try4 and try1 >= try5 and try1 >= try6 and try1 >= try7		=>	'P',	// use try1
										~pgood AND agood and try2 >= try4 and try2 >= try5 and try2 >= try6 and try2 >= try7	=>	'A',	// use try2
										// if both are connected, take the better one if it is better than or equal to all new searches
										pgood AND agood AND try1 >= try2 and try1 >= try4 and try1 >= try5 and try1 >= try6 and try1 >= try7 	=>	'P',
										agood	and try2 >= try4 and try2 >= try5 and try2 >= try6 and try2 >= try7		=>	'A',
										// otherwise, both are disconnected and we'll consider using utility and inquiry and phonesplus and insurance
										try1 >= try2 AND try1 >= try3 AND try1 >= try4 AND try1 >= try5 AND try1 >= try6 AND try1 >= try7		=> 	'P',
										try2 >= try1 AND try2 >= try3 AND try2 >= try4 AND try2 >= try5 AND try2 >= try6 AND try2 >= try7		=>	'A',
										try3 >= try1 AND try3 >= try2 AND try3 >= try4 AND try3 >= try5 AND try3 >= try6 AND try3 >= try7   =>  'U',
										// new cases
										try4 >= try5 AND try4 >= try6 AND try4 >= try7   =>  'PP',	// phonesplus phone
										try5 >= try6 AND try5 >= try7   =>  'PA',	// phonesplus address
										try6 >= try7   =>  'S',	// inquiries
										'I');	// insurance									
					
	phoneverlevelTemp := CASE(m,	'P'	=> try1,
																'A' => try2,
																'U' => try3,
																'PP' => try4,
																'PA' => try5,
																'S' => try6,
																try7);

	// If instantid v1 and we would have output a nap=9, but we also have a nap=8, then set the nap=12
	merge8_9 := IIDv1 AND phoneverlevelTemp = 9 AND (try2=8 OR try3=8 OR try5=8 OR try6=8);	

	phoneverlevel := IF(merge8_9, 12, phoneverlevelTemp);
	
	// figure out which try we used so that we know which address to populate in the phone address
	dirs_prim_range := MAP(	try2=8 => le.dirsaddr_prim_range,
													try3=8 => le.utili_prim_range,
													try5=8 => le.dirsaddr_prim_range,
													try6=8 => le.inquirynapprim_range,
													'');
	dirs_predir :=  MAP(try2=8 => le.dirsaddr_predir,
											try3=8 => le.utili_predir,
											try5=8 => le.dirsaddr_predir,
											try6=8 => le.inquirynappredir,
											'');
	dirs_prim_name := MAP(try2=8 => le.dirsaddr_prim_name,
												try3=8 => le.utili_prim_name,
												try5=8 => le.dirsaddr_prim_name,
												try6=8 => le.inquirynapprim_name,
												'');
	dirs_suffix := MAP(	try2=8 => le.dirsaddr_suffix,
											try3=8 => le.utili_suffix,
											try5=8 => le.dirsaddr_suffix,
											try6=8 => le.inquirynapsuffix,
											'');
	dirs_postdir := MAP(try2=8 => le.dirsaddr_postdir,
											try3=8 => le.utili_postdir,
											try5=8 => le.dirsaddr_postdir,
											try6=8 => le.inquirynappostdir,
											'');
	dirs_unit_desig := MAP(	try2=8 => le.dirsaddr_unit_desig,
													try3=8 => le.utili_unit_desig,
													try5=8 => le.dirsaddr_unit_desig,
													try6=8 => le.inquirynapunit_desig,
													'');
	dirs_sec_range := MAP(try2=8 => le.dirsaddr_sec_range,
												try3=8 => le.utili_sec_range,
												try5=8 => le.dirsaddr_sec_range,
												try6=8 => le.inquirynapsec_range,
												'');
	dirscity := MAP(try2=8 => le.dirsaddr_city,
									try3=8 => le.utilicity,
									try5=8 => le.dirsaddr_city,
									try6=8 => le.inquirynapcity,
									'');
	dirsstate := MAP(	try2=8 => le.dirsaddr_state,
										try3=8 => le.utilistate,
										try5=8 => le.dirsaddr_state,
										try6=8 => le.inquirynapst,
										'');
	dirszip := MAP(	try2=8 => le.dirsaddr_zip,
									try3=8 => le.utilizip,
									try5=8 => le.dirsaddr_zip,
									try6=8 => le.inquirynapz5,
									'');								
	
	// vdata - if we merged, then use the calculated fields above
	self.dirs_prim_range := IF(merge8_9, dirs_prim_range, le.dirs_prim_range);
	self.dirs_predir := IF(merge8_9, dirs_predir, le.dirs_predir);
	self.dirs_prim_name := IF(merge8_9, dirs_prim_name, le.dirs_prim_name);
	self.dirs_suffix := IF(merge8_9, dirs_suffix, le.dirs_suffix);
	self.dirs_postdir := IF(merge8_9, dirs_postdir, le.dirs_postdir);
	self.dirs_unit_desig := IF(merge8_9, dirs_unit_desig, le.dirs_unit_desig);
	self.dirs_sec_range := IF(merge8_9, dirs_sec_range, le.dirs_sec_range);
	self.dirscity := IF(merge8_9, dirscity, le.dirscity);
	self.dirsstate := IF(merge8_9, dirsstate, le.dirsstate);
	self.dirszip := IF(merge8_9, dirszip, le.dirszip);
	// count
	self.phoneaddrcount := IF(merge8_9, 1, le.phoneaddrcount);
	// score
	dirs_addrscore := MAP(try2=8 => le.dirsaddr_addrscore,
												try3=8 => le.utili_addrscore,
												try5=8 => le.dirsaddr_addrscore,
												try6=8 => le.inquirynapaddrscore,
												255);
	dirs_citystatescore := MAP(	try2=8 => le.dirsaddr_citystatescore,
															try3=8 => le.utili_citystatescore,
															try5=8 => le.dirsaddr_citystatescore,
															try6=8 => 255,	// inquiry does not have a citystatescore
															255);
	dirs_zipscore :=  MAP(try2=8 => le.dirsaddr_zipscore,
												try3=8 => le.utili_zipscore,
												try5=8 => le.dirsaddr_zipscore,
												try6=8 => 255,	// inquiry does not have a zipscore
												255);
	self.dirs_addrscore := IF(merge8_9, dirs_addrscore, le.dirs_addrscore);
	self.dirs_citystatescore := IF(merge8_9, dirs_citystatescore, le.dirs_citystatescore);
	self.dirs_zipscore := IF(merge8_9, dirs_zipscore, le.dirs_zipscore);
															
	self.phoneverlevel := phoneverlevel;
	convertedM := MAP(m='PP' => 'P',
										m='PA' => 'A',
										TRIM(m));
	SELF.phonever_type := convertedM;	// even if we do the combine 8 and 9, the type should have been a 'P', so no need to modify it
	SELF.NAP_Type := if(phoneverlevel>0, convertedM, '');
	
	NAP_Status := map(
											self.nap_type not in ['A','P'] or phoneverlevel = 0 => '',
											self.nap_type = 'A' and le.phoneaddr_disconnected => 'D',
											self.nap_type = 'P' and le.phone_disconnected => 'D',
											'C'
										);
												
	NAP_Status_CIIDv1 := map(	// for ciidv1, use the real status of the phone on input
														le.phonedissflag => 'D', // ciid v1 and input phone is disconnected
														le.phonevalflag in ['1','2'] => 'C',	// ciid v1 and input phone is found and not disconnected
														''
													);
	SELF.NAP_Status := IF(IIDv1, NAP_Status_CIIDv1, NAP_Status);
												

// bocashell version 50 doesn't count gong and targus white pages as a nonderog
	self.num_nonderogs := le.num_nonderogs + if(bsversion>=50, 0, (integer)(le.phone_date_last_seen>0 or le.phoneaddr_date_last_seen>0));
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.num_nonderogs30 := le.num_nonderogs30 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,30, le.historydate));
	self.num_nonderogs90 := le.num_nonderogs90 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,90, le.historydate));
	self.num_nonderogs180 := le.num_nonderogs180 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,180, le.historydate));
	self.num_nonderogs12 := le.num_nonderogs12 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,iid_constants.oneyear, le.historydate));
	self.num_nonderogs24 := le.num_nonderogs24 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,iid_constants.twoyears, le.historydate));
	self.num_nonderogs36 := le.num_nonderogs36 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,iid_constants.threeyears, le.historydate));
	self.num_nonderogs60 := le.num_nonderogs60 +  if(bsversion>=50, 0, (integer)iid_constants.checkDays(myGetDate,(string)le.phone_date_last_seen,iid_constants.fiveyears, le.historydate));
		
	self := le;
END;
pphonerec := project(rollphonerecs,naptrans(left));


risk_indicators.layout_output mergeNap(pphonerec le) := transform
												

	
	addrOverlap := (integer)(le.phoneaddr_firstcount>0 and le.phonefirstcount>0) + (integer)(le.phoneaddr_lastcount>0 and le.phonelastcount>0) + (integer)(le.phoneaddr_addrcount>0 and 
													(le.phoneaddrcount>0 or (le.targusgatewayused and le.dirs_prim_name=''/* and (/*~* /doE3220 or le.nxx_type /*not* / in cellPhoneTypes)*/)));// number of fields matching
	utilOverlap := (integer)(le.utiliaddr_firstcount>0 and le.phonefirstcount>0) + (integer)(le.utiliaddr_lastcount>0 and le.phonelastcount>0) + (integer)(le.utiliaddr_addrcount>0 and 
													(le.phoneaddrcount>0 or (le.targusgatewayused and le.dirs_prim_name=''/* and (~doE3220 or le.nxx_type /*not * /in cellPhoneTypes)*/))) + (integer)(le.utiliaddr_phonecount>0 and le.phonephonecount>0);// number of fields matching
	overlap := map(le.targusgatewayused and le.nap_type = 'A' and (addrOverlap>1 or (addrOverlap=1 and le.phoneaddr_addrcount>0 and le.phoneaddrcount>0 and le.addr_type='S')) => 1, // merge with address results
								 le.targusgatewayused and le.nap_type = 'P' and (addrOverlap>1 /*or (addrOverlap=1 and le.addr_type='S')*/) and le.phoneaddr_addrcount>0 and 
														~le.phoneaddr_disconnected and le.phoneverlevel>1 => 3, // merge with address results
								 le.targusgatewayused and le.nap_type = 'P' and (utilOverlap>1 /*or (utilOverlap=1 and le.addr_type='S')*/) and le.utiliaddr_addrcount>0  and le.phoneverlevel>1 and 
														((le.phoneaddr_firstcount+le.phoneaddr_lastcount+le.phoneaddr_addrcount+le.phoneaddr_phonecount)<=1) => 4, // merge with util results
								 le.targusgatewayused and le.nap_type = 'U' and (utilOverlap>1 or (utilOverlap=1 and le.utiliaddr_addrcount>0 and le.phoneaddrcount>0 and le.addr_type='S')) => 4, // merge with util results
								 0); // don't merge
								 
	AddrMatch := if(overlap > 0 and (le.phoneaddrcount>0 or le.dirs_prim_name=''), overlap, 0); // check for phone address match or not populated
	
								 
								 
	 comp_nap(unsigned2 local_phonefirstcount, unsigned2 local_phonelastcount, unsigned2 local_phoneaddrcount, unsigned2 local_phonephonecount) := 
					map(local_phonefirstcount=0 and local_phonelastcount=0 and local_phoneaddrcount=0 and local_phonephonecount>=1 =>
						1,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount=0 =>
						2,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						3,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount=0 and local_phonephonecount >=1 => 
						4,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						5,
						local_phonefirstcount=0 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount >=1 => 
						6,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount >=1 => 
						7,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount=0 => 
						8,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount=0 and local_phonephonecount>= 1 => 
						9,
						local_phonefirstcount>=1 and local_phonelastcount=0 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						10,
						local_phonefirstcount=0 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						11,
						local_phonefirstcount>=1 and local_phonelastcount>=1 and local_phoneaddrcount>=1 and local_phonephonecount>= 1 => 
						12,
						0);
						
	betternameA := Map( AddrMatch in [1,3] and le.phonefirstcount>0 and le.phonelastcount>0 => 1,// use phone names
											AddrMatch in [1,3] and le.phoneaddr_firstcount>0 and le.phoneaddr_lastcount>0 => 2, // use addr names
											AddrMatch in [1,3] and le.phonelastcount>0 => 3, // use phone last name
											AddrMatch in [1,3] and le.phoneaddr_lastcount>0 => 4, // use addr last name
											AddrMatch in [1,3] and le.phonefirstcount>0 => 5, // use phone first name
											AddrMatch in [1,3] and le.phoneaddr_firstcount>0 => 6, // use addr first name
											0);
											
	betternameU := Map( AddrMatch = 4 and le.phonefirstcount>0 and le.phonelastcount>0 => 1,// use phone names
											AddrMatch = 4 and le.utiliaddr_firstcount>0 and le.utiliaddr_lastcount>0 => 2, // use addr names
											AddrMatch = 4 and le.phonelastcount>0 => 3, // use phone last name
											AddrMatch = 4 and le.utiliaddr_lastcount>0 => 4, // use addr last name
											AddrMatch = 4 and le.phonefirstcount>0 => 5, // use phone first name
											AddrMatch = 4 and le.utiliaddr_firstcount>0 => 6, // use addr first name
											0);
										
	
	mergedNap := if(AddrMatch>0, if(AddrMatch in [1,3], comp_nap(if(betternameA in [1,5],le.phonefirstcount,if(betternameA in [2,6], le.phoneaddr_firstcount,0)), 
																																	if(betternameA in [1,3],le.phonelastcount, if(betternameA in [2,4], le.phoneaddr_lastcount,0)), 
																																	MAX(le.phoneaddrcount, le.phoneaddr_addrcount), le.phonephonecount),
																											comp_nap(if(betternameU in [1,5],le.phonefirstcount,if(betternameU in [2,6], le.utiliaddr_firstcount,0)), 
																																	if(betternameU in [1,3],le.phonelastcount, if(betternameU in [2,4], le.utiliaddr_lastcount,0)), 
																																	MAX(le.phoneaddrcount, le.utiliaddr_addrcount), le.phonephonecount)),
																	le.phoneverlevel);
																	
																	
	getPhoneverlevel := if(le.phoneverlevel=3 and mergedNap=10, le.phoneverlevel, mergedNap);		// if original nap was 3 and merged nap is 10 then dont do it	
	
	override_nap1_to_0 := getPhoneverlevel=1 and (le.dirs_prim_name='' or le.dirsfirst='' or le.dirslast='');
	phoneverlevelTemp := if(override_nap1_to_0, 0, getPhoneverlevel);	// set the phoneverlevel to 0 if was 1 and no first or last or address found, per jim c.  has to be fully contrary to be a 1
	self.phoneverlevel := phoneverlevelTemp;	// set the phoneverlevel to 0 if was 1 and no first or last or address found, per jim c.  has to be fully contrary to be a 1
	nap_type := if(override_nap1_to_0, '', le.NAP_Type);	// set the nap_type to blank if we set the phoneverlevel back to 0
	phonever_type := if(override_nap1_to_0, '', le.phonever_type);	// set the phonever_type to blank if we set the phoneverlevel back to 0
	
		
	// if we merged with targus result, set type to 'P' (mainly for verhphone and rc27 later) and also set status to connected
	weMerged := AddrMatch > 0 and getPhoneverlevel in [1,4,6,7,9,10,11,12];	// merging was done
	
	SELF.phonever_type := if(weMerged, 'P', phonever_type);
	NAP_TypeTemp := if(weMerged, 'P', nap_type);
	SELF.NAP_Type := NAP_TypeTemp;
	SELF.NAP_Status := if(weMerged, 'C', le.NAP_Status);
	
	OccupPhoneFirstSeen_dt := map( NAP_TypeTemp = 'U' => (string)le.utiliaddr_first_seen_date,
																					NAP_TypeTemp = 'A' => ((string)le.phoneaddr_date_first_seen)[1..6],
																					NAP_TypeTemp = 'P' => ((string)le.phone_date_first_seen)[1..6],
																					NAP_TypeTemp = 'S' => '0',
																					'0');
																					
	OccupPhoneLastSeen_dt := map( NAP_TypeTemp = 'U' => (string)le.utiliaddr_last_seen_date,
																					NAP_TypeTemp = 'A' => ((string)le.phoneaddr_date_last_seen)[1..6],
																					NAP_TypeTemp = 'P' => ((string)le.phone_date_last_seen)[1..6],
																					NAP_TypeTemp = 'S' => '0',
																					'0');
																					
	// Add NAP value to Occupant logic for ID2																			
	ever_start_date   := Risk_Indicators.iid_constants.MyGetDate((unsigned3) ((string)EverOccupant_StartDate)[1..6] )[1..6];
	ever_past_date	:= (string)if(EverOccupant_PastMonths > 0,ut.month_math((string)ever_start_date[1..6],  -EverOccupant_PastMonths), (string)ever_start_date[1..6]);
	
	CURRENT_OCCUPANT_MONTHS := 4; // from today, how many months back we'll consider someone a 'current' resident
	
	currOccFlag := if(phoneverlevelTemp in [8,12] and (unsigned3)OccupPhoneLastSeen_dt >= iid_constants.MonthRollback((string)le.historydate,CURRENT_OCCUPANT_MONTHS),  true, risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.CurrentOccupant, le.iid_flags )) ;
	
	NAPCurrOccFlag := iid_constants.SetFlag(iid_constants.IIDFlag.CurrentOccupant, currOccFlag );
	
	everOccFlag := 	if(phoneverlevelTemp in [8,12] and (unsigned3)ever_past_date <= (unsigned3)OccupPhoneLastSeen_dt 
										and  (unsigned3)ever_start_date >=  (unsigned3)OccupPhoneFirstSeen_dt,  
										True, 
									  risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.EverOccupant, le.iid_flags )) ;
	
	NAPEverOccFlag := iid_constants.SetFlag( iid_constants.IIDFlag.EverOccupant, everOccFlag );

	self.iid_flags := if(IncludeNAPData, NAPCurrOccFlag + NAPEverOccFlag, le.iid_flags);
	
	// if we merge, pretend like the internal hit and the phone hit have all the merged data on each of them 
	self.phonefirstcount := if(weMerged,  map(betternameA in [1,5] or betternameU in [1,5] => le.phonefirstcount, 
																						betternameA in [2,6] => le.phoneaddr_firstcount,
																						betternameU in [2,6] => le.utiliaddr_firstcount,
																						0), 
														 le.phonefirstcount);
	self.phonelastcount := if(weMerged, map(betternameA in [1,3] or betternameU in [1,3] => le.phonelastcount, 
																					betternameA in [2,4] => le.phoneaddr_lastcount,
																					betternameU in [2,4] => le.utiliaddr_lastcount,
																					0), 
														le.phonelastcount);
	self.phoneaddrcount := if(weMerged, if(addrMatch in [1,3], MAX(le.phoneaddrcount, le.phoneaddr_addrcount), 
																														 MAX(le.phoneaddrcount, le.utiliaddr_addrcount)), 
																			le.phoneaddrcount);
	self.phonephonecount := le.phonephonecount;
	self.phonecmpycount := le.phonecmpycount;
	
	self.phone_disconnected := if(weMerged, false, le.phone_disconnected);	// set the phone to current if targus hit
	self.phone_disconnectdate := if(weMerged, 0, le.phone_disconnectdate);	// blank out date if we used targus hit
	self.phone_disconnectcount := if(weMerged, 0, le.phone_disconnectcount);	// set count to 0 if targus hit
	self.phone_date_last_seen := le.phone_date_last_seen;	// this should be correct in the code
	self.phone_date_first_seen := le.phone_date_first_seen;	// this should be correct in the code
	
	
	self.phoneaddr_firstcount := if(weMerged, map(betternameA in [1,5] => le.phonefirstcount, 	// if we merged with address, pick the higher of the 2
																								betternameA in [2,6] => le.phoneaddr_firstcount,
																								0), 																					// can this just be le.phoneaddr_firstcount?
																						le.phoneaddr_firstcount);
	self.phoneaddr_lastcount := if(weMerged,  map(betternameA in [1,3] => le.phonelastcount, 
																								betternameA in [2,4] => le.phoneaddr_lastcount,
																								0), 
																						le.phoneaddr_lastcount);
	self.phoneaddr_addrcount := if(weMerged, if(addrMatch in [1,3], MAX(le.phoneaddrcount, le.phoneaddr_addrcount), 
																																	le.phoneaddr_addrcount), 
																					 le.phoneaddr_addrcount);
	self.phoneaddr_phonecount := if(weMerged, if(addrMatch in [1,3], le.phonephonecount, 
																																	 le.phoneaddr_phonecount), 
																						le.phoneaddr_phonecount);
	self.phoneaddr_cmpycount := le.phoneaddr_cmpycount;
	
	self.phoneaddr_disconnected := if(weMerged and addrMatch in [1,3], false, le.phoneaddr_disconnected);	// set the phone to current if merged with targus, treat as same record
	self.phoneaddr_disconnectdate := if(weMerged and addrMatch in [1,3], 0, le.phoneaddr_disconnectdate);	// blank out date if we merged with targus	
	self.phoneaddr_date_last_seen := if(weMerged and addrMatch in [1,3], le.phone_date_last_seen, le.phoneaddr_date_last_seen);	// use the current targus date if merged
	self.phoneaddr_date_first_seen := if(weMerged and addrMatch in [1,3], le.phone_date_first_seen, le.phoneaddr_date_first_seen);	// use the current targus date if merged
	
	
	self.utiliaddr_firstcount := if(weMerged, map(betternameU in [1,5] => le.phonefirstcount, 	// if we merged with utility, pick the higher of the 2
																								betternameU in [2,6] => le.utiliaddr_firstcount,
																								0), 
																						le.utiliaddr_firstcount);
	self.utiliaddr_lastcount := if(weMerged,  map(betternameU in [1,3] => le.phonelastcount, 
																								betternameU in [2,4] => le.utiliaddr_lastcount,
																								0), 
																						le.utiliaddr_lastcount);
	self.utiliaddr_addrcount := if(weMerged, if(addrMatch = 4, MAX(le.phoneaddrcount, le.utiliaddr_addrcount), 
																														 le.utiliaddr_addrcount), 
																					 le.utiliaddr_addrcount);
	self.utiliaddr_phonecount := if(weMerged, if(addrMatch = 4, le.phonephonecount, 
																															le.utiliaddr_phonecount), 
																						le.utiliaddr_phonecount);
	self.utiliaddr_socscount := le.utiliaddr_socscount;
  phone_last_seen := ((string) le.phone_date_last_seen)[1..6];
	self.utiliaddr_date := if(weMerged and addrMatch = 4, (unsigned3) phone_last_seen, le.utiliaddr_date);	// use the targus date if merged with utility
	self.utiliaddr_last_seen_date := if(weMerged and addrMatch = 4, (unsigned3) phone_last_seen, le.utiliaddr_last_seen_date);	// use the targus date if merged with utility
	self.utiliaddr_first_seen_date := if(weMerged and addrMatch = 4, (unsigned3) phone_last_seen, le.utiliaddr_first_seen_date);	// use the targus date if merged with utility
	
	
	self.dirsfirst := if(weMerged,  map(betternameA in [1,5] or betternameU in [1,5] => le.dirsfirst, 
																			betternameA in [2,6] => le.dirsaddr_first,
																			betternameU in [2,6] => le.utilifirst,
																			addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_firstscore) > iid_constants.tscore(le.dirs_firstscore) => le.dirsaddr_first,
																			addrMatch = 4 and iid_constants.tscore(le.utili_firstscore) > iid_constants.tscore(le.dirs_firstscore) => le.utilifirst,
																			le.dirsfirst), 
																	le.dirsfirst);
	self.dirslast := if(weMerged, map(betternameA in [1,5] or betternameU in [1,5] => le.dirslast, 
																		betternameA in [2,4] => le.dirsaddr_last,
																		betternameU in [2,4] => le.utililast,
																		addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_lastscore) > iid_constants.tscore(le.dirs_lastscore) => le.dirsaddr_last,
																		addrMatch = 4 and iid_constants.tscore(le.utili_lastscore) > iid_constants.tscore(le.dirs_lastscore) => le.utililast,
																		le.dirslast), 
																le.dirslast);
	self.dirs_prim_range := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_prim_range,
																						addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_prim_range,
																						le.dirs_prim_range), 
																				le.dirs_prim_range);
	self.dirs_predir := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_predir,
																				addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_predir,
																				le.dirs_predir), 
																		le.dirs_predir);
	self.dirs_prim_name := if(weMerged, map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_prim_name,
																					addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_prim_name,
																					le.dirs_prim_name), 
																			le.dirs_prim_name);
	self.dirs_suffix := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_suffix,
																				addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_suffix,
																				le.dirs_suffix), 
																		le.dirs_suffix);
	self.dirs_postdir := if(weMerged, map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_postdir,
																				addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_postdir,
																				le.dirs_postdir), 
																		le.dirs_postdir);
	self.dirs_unit_desig := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_unit_desig,
																						addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_unit_desig,
																						le.dirs_unit_desig), 
																				le.dirs_unit_desig);
	self.dirs_sec_range := if(weMerged, map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_sec_range,
																					addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utili_sec_range,
																					le.dirs_sec_range), 
																			le.dirs_sec_range);
	self.dirscity := if(weMerged, map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_city,
																		addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utilicity,
																		le.dirscity), 
																le.dirscity);
	self.dirsstate := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_state,
																			addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utilistate,
																			le.dirsstate), 
																	le.dirsstate);
	self.dirszip := if(weMerged,  map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_zip,
																		addrMatch = 4 and iid_constants.tscore(le.utili_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.utilizip,
																		le.dirszip), 
																le.dirszip);	
	self.dirscmpy := if(weMerged, map(addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_addrscore) > iid_constants.tscore(le.dirs_addrscore) => le.dirsaddr_cmpy,
																		le.dirscmpy), 
																le.dirscmpy);
																
	self.dirs_firstscore := if(weMerged,  map(betternameA in [1,5] or betternameU in [1,5] => le.dirs_firstscore, 
																						betternameA in [2,6] => le.dirsaddr_firstscore,
																						betternameU in [2,6] => le.utili_firstscore,
																						addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_firstscore) > iid_constants.tscore(le.dirs_firstscore) => le.dirsaddr_firstscore,
																						addrMatch = 4 and iid_constants.tscore(le.utili_firstscore) > iid_constants.tscore(le.dirs_firstscore) => le.utili_firstscore,
																						le.dirs_firstscore), 
														 le.dirs_firstscore);
	self.dirs_lastscore := if(weMerged, map(betternameA in [1,3] or betternameU in [1,3] => le.dirs_lastscore, 
																					betternameA in [2,4] => le.dirsaddr_lastscore,
																					betternameU in [2,4] => le.utili_lastscore,
																					addrMatch in [1,3] and iid_constants.tscore(le.dirsaddr_lastscore) > iid_constants.tscore(le.dirs_lastscore) => le.dirsaddr_lastscore,
																					addrMatch = 4 and iid_constants.tscore(le.utili_lastscore) > iid_constants.tscore(le.dirs_lastscore) => le.utili_lastscore,
																					le.dirs_lastscore), 
														le.dirs_lastscore);
	self.dirs_addrscore := if(weMerged, if(addrMatch in [1,3], MAX(iid_constants.tscore(le.dirs_addrscore), iid_constants.tscore(le.dirsaddr_addrscore)), 
																														 MAX(iid_constants.tscore(le.dirs_addrscore), iid_constants.tscore(le.utili_addrscore))), 
																			le.dirs_addrscore);
	self.dirs_citystatescore := if(weMerged, if(addrMatch in [1,3], MAX(iid_constants.tscore(le.dirs_citystatescore), iid_constants.tscore(le.dirsaddr_citystatescore)), 
																														 MAX(iid_constants.tscore(le.dirs_citystatescore), iid_constants.tscore(le.utili_citystatescore))), 
																			le.dirs_citystatescore);
	self.dirs_zipscore := if(weMerged, if(addrMatch in [1,3], MAX(iid_constants.tscore(le.dirs_zipscore), iid_constants.tscore(le.dirsaddr_zipscore)), 
																														 MAX(iid_constants.tscore(le.dirs_zipscore), iid_constants.tscore(le.utili_zipscore))), 
																			le.dirs_zipscore);
																			
	self.dirs_phonescore := le.dirs_phonescore;
	self.dirs_cmpyscore := le.dirs_cmpyscore;
	
	self.dirsaddr_first := if(weMerged, map(betternameA in [1,5] => le.dirsfirst, 
																					betternameA in [2,6] => le.dirsaddr_first,
																					addrMatch in [1,3] and iid_constants.tscore(le.dirs_firstscore) > iid_constants.tscore(le.dirsaddr_firstscore) => le.dirsfirst,
																					le.dirsaddr_first), 
																			le.dirsaddr_first);
	self.dirsaddr_last := if(weMerged,  map(betternameA in [1,5] => le.dirslast, 
																					betternameA in [2,4] => le.dirsaddr_last,
																					addrMatch in [1,3] and iid_constants.tscore(le.dirs_lastscore) > iid_constants.tscore(le.dirsaddr_lastscore) => le.dirslast,
																					le.dirsaddr_last), 
																			le.dirsaddr_last);
	self.dirsaddr_prim_range := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_prim_range, le.dirsaddr_prim_range);
	self.dirsaddr_predir := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_predir, le.dirsaddr_predir);
	self.dirsaddr_prim_name := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_prim_name, le.dirsaddr_prim_name);
	self.dirsaddr_suffix := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_suffix, le.dirsaddr_suffix);
	self.dirsaddr_postdir := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_postdir, le.dirsaddr_postdir);
	self.dirsaddr_unit_desig := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_unit_desig, le.dirsaddr_unit_desig);
	self.dirsaddr_sec_range :=  if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_sec_range, le.dirsaddr_sec_range);
	self.dirsaddr_city :=  if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirscity, le.dirsaddr_city);
	self.dirsaddr_state :=  if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirsstate, le.dirsaddr_state);
	self.dirsaddr_zip :=  if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirszip, le.dirsaddr_zip);
	self.dirsaddr_phone :=  if(weMerged and addrMatch in [1,3], le.phone10, le.dirsaddr_phone);
	self.dirsaddr_cmpy := le.dirsaddr_cmpy;
	
	self.dirsaddr_firstscore := if(weMerged,  map(betternameA in [1,5] => le.dirs_firstscore, 
																								betternameA in [2,6] => le.dirsaddr_firstscore,
																								addrMatch in [1,3] and iid_constants.tscore(le.dirs_firstscore) > iid_constants.tscore(le.dirsaddr_firstscore) => le.dirs_firstscore,
																								le.dirsaddr_firstscore), 
																 le.dirsaddr_firstscore);
	self.dirsaddr_lastscore := if(weMerged, map(betternameA in [1,5] => le.dirs_lastscore, 
																							betternameA in [2,4] => le.dirsaddr_lastscore,
																							addrMatch in [1,3] and iid_constants.tscore(le.dirs_lastscore) > iid_constants.tscore(le.dirsaddr_lastscore) => le.dirs_lastscore,
																							le.dirsaddr_lastscore), 
															 le.dirsaddr_lastscore);
	self.dirsaddr_addrscore := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_addrscore, le.dirsaddr_addrscore);
// use the same selection logic to pick citystatescore and zipscore as the addrscore so they all refer to the same matched record
	self.dirsaddr_citystatescore := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_citystatescore, le.dirsaddr_citystatescore);
	self.dirsaddr_zipscore := if(weMerged and addrMatch in [1,3] and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.dirsaddr_addrscore), le.dirs_zipscore, le.dirsaddr_zipscore);

	
	self.dirsaddr_phonescore :=if(weMerged and addrMatch in [1,3], le.dirs_phonescore, le.dirsaddr_phonescore);
	self.dirsaddr_cmpyscore := le.dirsaddr_cmpyscore;
	
	
	self.utilifirst := if(weMerged, map(betternameU in [1,5] => le.dirsfirst, 
																			betternameU in [2,6] => le.utilifirst,
																			addrMatch = 4 and iid_constants.tscore(le.dirs_firstscore) > iid_constants.tscore(le.utili_firstscore) => le.dirsfirst,
																			le.utilifirst), 
																	le.utilifirst);
	self.utililast := if(weMerged,  map(betternameU in [1,5] => le.dirslast, 
																			betternameU in [2,4] => le.utililast,
																			addrMatch = 4 and iid_constants.tscore(le.dirs_lastscore) > iid_constants.tscore(le.utili_lastscore) => le.dirslast,
																			le.utililast), 
																	le.utililast);
	self.utili_prim_range := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_prim_range, le.utili_prim_range);
	self.utili_predir := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_predir, le.utili_predir);
	self.utili_prim_name := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_prim_name, le.utili_prim_name);
	self.utili_suffix := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_suffix, le.utili_suffix);
	self.utili_postdir := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_postdir, le.utili_postdir);
	self.utili_unit_desig := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_unit_desig, le.utili_unit_desig);
	self.utili_sec_range := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_sec_range, le.utili_sec_range);
	self.utilicity := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirscity, le.utilicity);
	self.utilistate := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirsstate, le.utilistate);
	self.utilizip := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirszip, le.utilizip);
	self.utiliphone := if(weMerged and addrMatch = 4, le.phone10, le.utiliphone);
	
	self.utili_firstscore := if(weMerged, map(betternameU in [1,5] => le.dirs_firstscore, 
																						betternameU in [2,6] => le.utili_firstscore,
																						addrMatch = 4 and iid_constants.tscore(le.dirs_firstscore) > iid_constants.tscore(le.utili_firstscore) => le.dirs_firstscore,
																						le.utili_firstscore), 
														 le.utili_firstscore);
	self.utili_lastscore := if(weMerged,  map(betternameU in [1,5] => le.dirs_lastscore, 
																						betternameU in [2,4] => le.utili_lastscore,
																						addrMatch = 4 and iid_constants.tscore(le.dirs_lastscore) > iid_constants.tscore(le.utili_lastscore) => le.dirs_lastscore,
																						le.utili_lastscore), 
														 le.utili_lastscore);
	self.utili_addrscore := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_addrscore, le.utili_addrscore);
	// use the same selection logic to pick citystatescore and zipscore as the addrscore so they all refer to the same matched record
	self.utili_citystatescore := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_citystatescore, le.utili_citystatescore);
	self.utili_zipscore := if(weMerged and addrMatch = 4 and iid_constants.tscore(le.dirs_addrscore) > iid_constants.tscore(le.utili_addrscore), le.dirs_zipscore, le.utili_zipscore);
	
	self.utili_phonescore := if(weMerged and addrMatch = 4, le.dirs_phonescore, le.utili_phonescore);
	
	// self.hphonelat := ri.geo_lat;		// these 2 fields will always be blank when we merge
	// self.hphonelong := ri.geo_long;
																
	self := le;																	
end;
phonerec_merged := project(pphonerec, mergeNap(left));
// output(phone_input, named('phone_input'));
 // output(withInquiriesNAP, named('withInquiriesNAP'));
 // output(biggestrec_history, named('biggestrec_history'));
// output(phone_velocity, named('phone_velocity'));
 // output(dirs_by_phone, named('dirs_by_phone'));
// output(biggestrec_rolled, named('biggestrec_rolled'));
// output(rollphonerecs, named('rollphonerecs'));
// output(pphonerec, named('pphonerec'));
// output(phonerec_merged, named('phonerec_merged'));
// output(EverOccupant_StartDate, named('EverOccupant_StartDate'));
// output(ever_start_dateTEST, named('ever_start_dateTEST'));
// output(ever_past_dateTEST, named('ever_past_dateTEST'));


return phonerec_merged;

end;