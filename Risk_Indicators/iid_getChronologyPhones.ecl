import _Control, risk_indicators, riskwise, ut, NID;
onThor := _Control.Environment.OnThor;

export iid_getChronologyPhones(grouped dataset(risk_indicators.Layout_Output) somedata, 
					boolean from_IT1O=false, 
					string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
					boolean isFCRA, UNSIGNED8 BSOptions, UNSIGNED1 glb) := function


ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[iid_constants.posExactPhoneMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;


Risk_Indicators.Layouts.layout_input_plus_overrides prep_chronology(risk_indicators.layout_output le, integer C) := transform
	self.prim_range := choose(c, le.chronoprim_range, le.chronoprim_range2, le.chronoprim_range3);
	self.predir := choose(c, le.chronopredir, le.chronopredir2, le.chronopredir3);
	self.prim_name := choose(c,le.chronoprim_name,le.chronoprim_name2,le.chronoprim_name3);
	self.addr_suffix := choose(c, le.chronosuffix, le.chronosuffix2, le.chronosuffix3);
	self.postdir := choose(c, le.chronopostdir, le.chronopostdir2, le.chronopostdir3);
	self.unit_desig := choose(c, le.chronounit_desig, le.chronounit_desig2, le.chronounit_desig3);
	self.sec_range := choose(c, le.chronosec_range, le.chronosec_range2, le.chronosec_range3);
	self.p_city_name := choose(c, le.chronocity, le.chronocity2, le.chronocity3);
	self.st := choose(c, le.chronostate, le.chronostate2, le.chronostate3);
	self.z5 := choose(c, le.chronozip, le.chronozip2, le.chronozip3);
	self := [];
end;

chrono_inputs_temp := ungroup(NORMALIZE(somedata,3,prep_chronology(LEFT, COUNTER)));

chrono_inputs_roxie := dedup(sort(chrono_inputs_temp, prim_name,z5,prim_range, sec_range), prim_name, z5, prim_range, sec_range);
chrono_inputs_thor := dedup(sort(distribute(chrono_inputs_temp, hash64(prim_range, prim_name,z5)), prim_name,z5,prim_range, sec_range, LOCAL), prim_name, z5, prim_range, sec_range, LOCAL);

#IF(onThor)
	chrono_inputs := chrono_inputs_thor;
#ELSE
	chrono_inputs := chrono_inputs_roxie;
#END

chrono_phones := riskwise.getDirsByAddr(chrono_inputs, isFCRA, glb, BSOptions);

risk_indicators.layout_output eqfsphonetrans(risk_indicators.layout_output l, riskwise.Layout_Dirs_Address r, INTEGER i) := transform
	
	lscore_result := risk_indicators.LnameScore(l.lname,r.name_last);
	self.chronophone_namematch := IF(i=1, lscore_result, l.chronophone_namematch);
	
	n1 := NID.PreferredFirstNew(l.fname);
	n2 := NID.PreferredFirstNew(r.name_first);
	fscore := iid_constants.g(risk_indicators.fnameScore(l.fname, r.name_first)) and if(ExactFirstNameRequired, l.fname=r.name_first, true) and
							  if(ExactFirstNameRequiredAllowNickname, l.fname=r.name_first or n1=n2, true);
	lscore := iid_constants.g(lscore_result) and if(ExactLastNameRequired, l.lname=r.name_last, true);
	
	ascore := iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(l.chronoprim_range, l.chronoprim_name, l.chronosec_range, 
																						r.prim_range, r.prim_name, r.sec_range))
						and if(ExactAddrRequired, l.chronoprim_range=r.prim_range and l.chronoprim_name=r.prim_name  and 
																			(l.chronozip=r.z5 or (l.chronocity=r.p_city_name and l.chronostate=r.st)) and
																			ut.nneq(l.chronosec_range,r.sec_range), true);

	isCurrent := (l.historydate=iid_constants.default_history_date and r.current_flag) OR // realtime and current
							 (l.historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]) and r.current_flag) OR // history mode in current month and current
							 (l.historydate <= (unsigned) (r.deletion_date[1..6])) OR // deletion date in the future
							 (l.historydate <= (unsigned) (r.dt_last_seen[1..6]));	// date last seen is in the future
																													
	self.chronoaddrscore := if(i=1 and from_IT1O, map(r.phone10='' => 0,
																										l.phone10=r.phone10 => 1,
																										length(trim(r.phone10))=7 => 2,
																										fscore and lscore and ascore => 3,
																										lscore and ascore => 4,
																										ascore => 5,
																										6) ,l.chronoaddrscore);
	self.chronofirst := if(i=1 and from_IT1O and self.chronoaddrscore in [4,5], r.name_first, l.chronofirst);
	self.chronolast := if(i=1 and from_IT1O and self.chronoaddrscore = 5, r.name_last, l.chronolast);
	self.chronophone := IF(i=1 and (lscore or from_IT1O), if(length(trim(r.phone10))=7, '', r.phone10),l.chronophone);
	self.chronoMatchLevel := IF(i=1, map(r.prim_name='' or (~fscore and ~lscore) => 0,	// nothing found or address only match
																			 fscore and lscore and ascore and isCurrent => 4, // full match
																			 lscore and ascore and isCurrent => 3,	// last and addr match
																			 fscore and lscore and ascore => 2, // full name but disconnected
																			 1), // last and addr but disconnected
															l.chronoMatchLevel);	
	self.chronoActivePhone := IF(i=1, if(self.chronoMatchLevel >= 3, (unsigned)r.phone10, l.chronoActivePhone), l.chronoActivePhone);
	
	self.chronophone2_namematch := IF(i=2, lscore_result, l.chronophone2_namematch);
	self.chronophone2 := IF(i=2 and (lscore or from_IT1O),if(length(trim(r.phone10))=7, '', r.phone10),l.chronophone2);
	ascore2 := iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(l.chronoprim_range2, l.chronoprim_name2, l.chronosec_range2,
																													r.prim_range, r.prim_name, r.sec_range))
							and if(ExactAddrRequired, l.chronoprim_range2=r.prim_range and l.chronoprim_name2=r.prim_name  and 
																				(l.chronozip2=r.z5 or (l.chronocity2=r.p_city_name and l.chronostate2=r.st)) and
																				ut.nneq(l.chronosec_range2,r.sec_range), true);

	self.chronoaddrscore2 := if(i=2 and from_IT1O, map(r.phone10='' => 0,
																										 l.phone10=r.phone10 => 1,
																										 length(trim(r.phone10))=7 => 2,
																										 fscore and lscore and ascore2 => 3,
																										 lscore and ascore2 => 4,
																										 ascore2 => 5,
																										 6) ,l.chronoaddrscore2);
	self.chronofirst2 := if(i=2 and from_IT1O and self.chronoaddrscore2 in [4,5], r.name_first, l.chronofirst2);
	self.chronolast2 := if(i=2 and from_IT1O and self.chronoaddrscore2 = 5, r.name_last, l.chronolast2);
	self.chronoMatchLevel2 := IF(i=2, map(r.prim_name='' or (~fscore and ~lscore) => 0,	// nothing found or address only match
																				fscore and lscore and ascore2 and isCurrent => 4, // full match
																				lscore and ascore2 and isCurrent => 3,	// last and addr match
																				fscore and lscore and ascore2 => 2, // full name but disconnected
																				1), // last and addr but disconnected
															 l.chronoMatchLevel2);
	self.chronoActivePhone2 := IF(i=2, if(self.chronoMatchLevel2 >= 3, (unsigned)r.phone10, l.chronoActivePhone2), l.chronoActivePhone2);
	
	self.chronophone3_namematch := IF(i=3, lscore_result, l.chronophone3_namematch);
	self.chronophone3 := IF(i=3 and (lscore or from_IT1O),if(length(trim(r.phone10))=7, '', r.phone10),l.chronophone3);
	ascore3 := iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(l.chronoprim_range3, l.chronoprim_name3, l.chronosec_range3,
																													r.prim_range, r.prim_name, r.sec_range))
				and if(ExactAddrRequired, l.chronoprim_range3=r.prim_range and l.chronoprim_name3=r.prim_name  and 
																	(l.chronozip3=r.z5 or (l.chronocity3=r.p_city_name and l.chronostate3=r.st)) and
																	ut.nneq(l.chronosec_range3,r.sec_range), true);

	self.chronoaddrscore3 := if(i=3 and from_IT1O, map( r.phone10='' => 0,
																											l.phone10=r.phone10 => 1,
																											length(trim(r.phone10))=7 => 2,
																											fscore and lscore and ascore3 => 3,
																											lscore and ascore3 => 4,
																											ascore3 => 5,
																											6) ,l.chronoaddrscore3);
	self.chronofirst3 := if(i=3 and from_IT1O and self.chronoaddrscore3 in [4,5], r.name_first, l.chronofirst3);
	self.chronolast3 := if(i=3 and from_IT1O and self.chronoaddrscore3 = 5, r.name_last, l.chronolast3);
	self.chronoMatchLevel3 := IF(i=3, map(r.prim_name='' or (~fscore and ~lscore) => 0,	// nothing found or address only match
																				fscore and lscore and ascore3 and isCurrent => 4, // full match
																				lscore and ascore3 and isCurrent => 3,	// last and addr match
																				fscore and lscore and ascore3 => 2, // full name but disconnected
																				1), // last and addr but disconnected
															 l.chronoMatchLevel3);
	self.chronoActivePhone3 := IF(i=3, if(self.chronoMatchLevel3 >= 3, (unsigned)r.phone10, l.chronoActivePhone3), l.chronoActivePhone3);
	
	self := l;
END;

eqfsphonerecs_history_roxie := join(somedata, chrono_phones,
									left.chronoprim_name<> '' AND left.chronozip<>'' AND
				    	    left.chronoprim_name=right.prim_name and left.chronostate=right.st and 
				          left.chronozip=right.z5 and left.chronoprim_range=right.prim_range and left.chronosec_range=right.sec_range AND
				          // check date
				          ((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate) ) AND
				          (RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				          eqfsphonetrans(left,right,1), left outer, many lookup,
					  ATMOST(
						  left.chronoprim_name=right.prim_name and left.chronostate=right.st and 
						  left.chronozip=right.z5 and left.chronoprim_range=right.prim_range and left.chronosec_range=right.sec_range,
						  RiskWise.max_atmost
					  ),
					  keep(300));
						
						
eqfsphonerecs_history_thor_pre := join(distribute(somedata(chronoprim_name<> '' AND chronozip<>''), hash64(chronoprim_name,chronoprim_range,chronozip)),
									distribute(chrono_phones, hash64(prim_name,prim_range,z5)),
				    	    left.chronoprim_name=right.prim_name and left.chronostate=right.st and 
				          left.chronozip=right.z5 and left.chronoprim_range=right.prim_range and left.chronosec_range=right.sec_range AND
				          // check date
				          ((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) ) AND
				          (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				          eqfsphonetrans(left,right,1), left outer, 
					  ATMOST(
						  left.chronoprim_name=right.prim_name and left.chronostate=right.st and 
						  left.chronozip=right.z5 and left.chronoprim_range=right.prim_range and left.chronosec_range=right.sec_range,
						  RiskWise.max_atmost
					  ),
					  keep(300),LOCAL);
						
eqfsphonerecs_history_thor := group(sort(eqfsphonerecs_history_thor_pre + 
									project(somedata(chronoprim_name= '' OR chronozip=''), transform(recordof(left), self.chronophone_namematch:=255,self:=left)), seq, did, LOCAL), seq, did,LOCAL);

#IF(onThor)
	eqfsphonerecs_history := sort(eqfsphonerecs_history_thor, seq, did, -chronophone, record);
#ELSE
	eqfsphonerecs_history := sort(eqfsphonerecs_history_roxie, seq, did, -chronophone, record);
#END

risk_indicators.layout_output rollphone1(risk_indicators.layout_output le, risk_indicators.layout_output ri) := TRANSFORM
	take_left1 := iid_constants.tscore(le.chronophone_namematch) >= iid_constants.tscore(ri.chronophone_namematch);						// only takes phones that match last and address
	SELF.chronophone := if(take_left1, le.chronophone, ri.chronophone);
	SELF.chronophone_namematch := if(take_left1, le.chronophone_namematch, ri.chronophone_namematch);
						// for infotrace, need to hang onto the phonestatus and names that go with the phone that we're keeping in the rollup
	self.chronoaddrscore := if(~take_left1 and from_IT1O, ri.chronoaddrscore, le.chronoaddrscore);
	self.chronofirst := if(~take_left1 and from_IT1O, ri.chronofirst, le.chronofirst);
	self.chronolast := if(~take_left1 and from_IT1O, ri.chronolast, le.chronolast);
	self.chronoMatchLevel := MAX(le.chronoMatchLevel, ri.chronoMatchLevel);	// pick the higher of the 2
	self.chronoActivePhone := if(le.chronoMatchLevel>=ri.chronoMatchLevel, le.chronoActivePhone, ri.chronoActivePhone);
	SELF := le;
END;
eqfsphonerecs_rolled := ROLLUP(eqfsphonerecs_history,true,rollphone1(LEFT,RIGHT));



eqfsphonerecs2_history_roxie := join(eqfsphonerecs_rolled,chrono_phones,
				  	      left.chronoprim_name2<> '' AND left.chronozip2<>'' AND
					      left.chronoprim_name2=right.prim_name and left.chronostate2=right.st and 
				           left.chronozip2=right.z5 and left.chronoprim_range2=right.prim_range and left.chronosec_range2=right.sec_range AND
				           // check date
				           ((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate) ) AND
				          (RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				           eqfsphonetrans(left,right,2),left outer, many lookup , 
					  ATMOST(
						  left.chronoprim_name2=right.prim_name and left.chronostate2=right.st and 
						  left.chronozip2=right.z5 and left.chronoprim_range2=right.prim_range and left.chronosec_range2=right.sec_range,
						  RiskWise.max_atmost
					), keep(300));
							 
eqfsphonerecs2_history_thor_pre := join(distribute(eqfsphonerecs_rolled(chronoprim_name2<> '' AND chronozip2<>''), hash64(chronoprim_name2,chronoprim_range2,chronozip2)),
								distribute(chrono_phones, hash64(prim_name,prim_range,z5)),
					      left.chronoprim_name2=right.prim_name and left.chronostate2=right.st and 
				           left.chronozip2=right.z5 and left.chronoprim_range2=right.prim_range and left.chronosec_range2=right.sec_range AND
				           // check date
				           ((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) ) AND
				          (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				           eqfsphonetrans(left,right,2),left outer,
					  ATMOST(
						  left.chronoprim_name2=right.prim_name and left.chronostate2=right.st and 
						  left.chronozip2=right.z5 and left.chronoprim_range2=right.prim_range and left.chronosec_range2=right.sec_range,
						  RiskWise.max_atmost
					), keep(300), LOCAL);
					
eqfsphonerecs2_history_thor := group(sort(eqfsphonerecs2_history_thor_pre + 
						project(eqfsphonerecs_rolled(chronoprim_name2= '' OR chronozip2=''),transform(recordof(left), self.chronophone2_namematch:=255,self:=left)), seq, did, LOCAL), seq, did,LOCAL);

#IF(onThor)
	eqfsphonerecs2_history := sort(eqfsphonerecs2_history_thor, seq, did, -chronophone2, record);
#ELSE
	eqfsphonerecs2_history := sort(eqfsphonerecs2_history_roxie, seq, did, -chronophone2, record);
#END

risk_indicators.layout_output rollphone2(risk_indicators.layout_output le, risk_indicators.layout_output ri) := TRANSFORM
	take_left2 := iid_constants.tscore(le.chronophone2_namematch) >= iid_constants.tscore(ri.chronophone2_namematch);
	SELF.chronophone2 := if(take_left2, le.chronophone2, ri.chronophone2);
	SELF.chronophone2_namematch := if(take_left2, le.chronophone2_namematch, ri.chronophone2_namematch);
							// for infotrace, need to hang onto the phonestatus and names that go with the phone that we're keeping in the rollup
	self.chronoaddrscore2 := if(~take_left2 and from_IT1O, ri.chronoaddrscore2, le.chronoaddrscore2);
	self.chronofirst2 := if(~take_left2 and from_IT1O, ri.chronofirst2, le.chronofirst2);
	self.chronolast2 := if(~take_left2 and from_IT1O, ri.chronolast2, le.chronolast2);
	self.chronoMatchLevel2 := MAX(le.chronoMatchLevel2, ri.chronoMatchLevel2);	// pick the higher of the 2
	self.chronoActivePhone2 := if(le.chronoMatchLevel2>=ri.chronoMatchLevel2, le.chronoActivePhone2, ri.chronoActivePhone2);
	SELF := le;
END;
eqfsphonerecs2_rolled := ROLLUP(eqfsphonerecs2_history,true,rollphone2(LEFT,RIGHT));


eqfsphonerecs3_history_roxie := join(eqfsphonerecs2_rolled, chrono_phones,
					      left.chronoprim_name3<> '' AND left.chronozip3<>'' AND
					      left.chronoprim_name3=right.prim_name and left.chronostate3=right.st and 
				        left.chronozip3=right.z5 and left.chronoprim_range3=right.prim_range and left.chronosec_range3=right.sec_range AND
				        // check date
				        ((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate) ) AND
				        (RIGHT.current_flag OR iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				           eqfsphonetrans(left,right,3),left outer, many lookup, 
						   ATMOST(
						   left.chronoprim_name3=right.prim_name and left.chronostate3=right.st and 
						   left.chronozip3=right.z5 and left.chronoprim_range3=right.prim_range and left.chronosec_range3=right.sec_range,
						   RiskWise.max_atmost),
					   keep(300));

eqfsphonerecs3_history_thor_pre := join(distribute(eqfsphonerecs2_rolled(chronoprim_name3<> '' AND chronozip3<>''), hash64(chronoprim_name3, chronoprim_range3,chronozip3)), 
								distribute(chrono_phones, hash64(prim_name,prim_range,z5)),
					      left.chronoprim_name3=right.prim_name and left.chronostate3=right.st and 
				        left.chronozip3=right.z5 and left.chronoprim_range3=right.prim_range and left.chronosec_range3=right.sec_range AND
				        // check date
				        ((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) ) AND
				        (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'31'))),
				           eqfsphonetrans(left,right,3),left outer, 
						   ATMOST(
						   left.chronoprim_name3=right.prim_name and left.chronostate3=right.st and 
						   left.chronozip3=right.z5 and left.chronoprim_range3=right.prim_range and left.chronosec_range3=right.sec_range,
						   RiskWise.max_atmost),
					   keep(300), LOCAL);
eqfsphonerecs3_history_thor := group(sort(eqfsphonerecs3_history_thor_pre + 
					project(eqfsphonerecs2_rolled(chronoprim_name3='' OR chronozip3=''),transform(recordof(left), self.chronophone3_namematch:=255,self:=left)), seq, did, LOCAL), seq, did,LOCAL);
						 
#IF(onThor)
	eqfsphonerecs3_history := sort(eqfsphonerecs3_history_thor, seq, did, -chronophone3, record);
#ELSE
	eqfsphonerecs3_history := sort(eqfsphonerecs3_history_roxie, seq, did, -chronophone3, record);
#END

risk_indicators.layout_output rollphone3(risk_indicators.layout_output le, risk_indicators.layout_output ri) := TRANSFORM
	take_left3 := iid_constants.tscore(le.chronophone3_namematch) >= iid_constants.tscore(ri.chronophone3_namematch);							
	SELF.chronophone3 := if(take_left3, le.chronophone3, ri.chronophone3);
	SELF.chronophone3_namematch := if(take_left3, le.chronophone3_namematch, ri.chronophone3_namematch);
							// for infotrace, need to hang onto the phonestatus and names that go with the phone that we're keeping in the rollup
	self.chronoaddrscore3 := if(~take_left3 and from_IT1O, ri.chronoaddrscore3, le.chronoaddrscore3);
	self.chronofirst3 := if(~take_left3 and from_IT1O, ri.chronofirst3, le.chronofirst3);
	self.chronolast3 := if(~take_left3 and from_IT1O, ri.chronolast3, le.chronolast3);
	self.chronoMatchLevel3 := MAX(le.chronoMatchLevel3, ri.chronoMatchLevel3);	// pick the higher of the 2
	self.chronoActivePhone3 := if(le.chronoMatchLevel3>=ri.chronoMatchLevel3, le.chronoActivePhone3, ri.chronoActivePhone3);
	SELF := le;
END;
eqfsphones := ROLLUP(eqfsphonerecs3_history,true,rollphone3(LEFT,RIGHT));

return eqfsphones;
end;
