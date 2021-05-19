//Risk_Indicators.iid_check_best
import header, watchdog, risk_indicators, ut, _control;

export iid_check_best(grouped dataset(iid_constants.layout_outx) all_header, 
											grouped dataset(risk_indicators.Layout_Output) rolled_header,
											string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
											integer bsVersion) := function

asdf := GROUP(PROJECT(all_header(did<>0),TRANSFORM(header.layout_header, SELF := LEFT.h)));	

header_build_date := all_header[1].header_summary.header_build_date;

w := watchdog.BestAddrFunc(asdf, header_build_date);

ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;

risk_indicators.layout_output checkBest (risk_indicators.layout_output le, w ri) := TRANSFORM
	// Need to make certain the address being compared to is clean, some addresses had invalid sec_range's and were causing the scoring to improperly select the wrong address.
	streetAddress := Risk_Indicators.MOD_AddressClean.street_address('', ri.prim_range, ri.predir, ri.prim_name, ri.suffix, ri.postdir);
	//removed address cleaner as the best records should already be cleaned
	cleanRange := ri.prim_range;
	cleanName := ri.prim_name;
	cleanSecRange := ri.sec_range;

	SELF.veraddr_isBest :=
				iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						cleanRange, cleanName, cleanSecRange))
							 and if(ExactAddrRequired, le.prim_range=ri.prim_range and le.prim_name=ri.prim_name and // If exact matching is required, don't use the cleaned address.
																					(le.in_zipcode=ri.zip or le.z5=ri.zip or 
																							(le.in_city=ri.city_name and le.in_state=ri.st) or (le.p_city_name=ri.city_name and le.st=ri.st)) and
																					ut.nneq(le.sec_range,ri.sec_range), true);
	
	// Score each of the chrono addresses.
	chronoScore1 := Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range, le.chronoprim_name, le.chronosec_range,	cleanRange, cleanName, cleanSecRange);
	chronoScore2 := Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range2, le.chronoprim_name2, le.chronosec_range2, cleanRange, cleanName, cleanSecRange);
	chronoScore3 := Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range3, le.chronoprim_name3, le.chronosec_range3, cleanRange, cleanName, cleanSecRange);
	
	// Select the chrono address with the best score.  In the event that two chrono scores match, select the address that occurs first in the listing as the best address.
  maxScore := MAX(IF(chronoScore1 = 255, -1, chronoScore1), IF(chronoScore2 = 255, -1, chronoScore2), IF(chronoScore3 = 255, -1, chronoScore3));
	
	SELF.chronoaddr_isBest := 
				iid_constants.ga(chronoScore1)
				    AND (chronoScore1 = maxScore)
							and if(ExactAddrRequired, le.chronoprim_range=ri.prim_range and le.chronoprim_name=ri.prim_name  and 
																				(le.chronozip=ri.zip or (le.chronocity=ri.city_name and le.chronostate=ri.st)) and
																				ut.nneq(le.chronosec_range,ri.sec_range), true);
							
	SELF.chronoaddr_isBest2 :=
				iid_constants.ga(chronoScore2)
				    AND (chronoScore2 = maxScore AND chronoScore1 <> chronoScore2)
							and if(ExactAddrRequired, le.chronoprim_range2=ri.prim_range and le.chronoprim_name2=ri.prim_name  and 
																				(le.chronozip2=ri.zip or (le.chronocity2=ri.city_name and le.chronostate2=ri.st)) and
																				ut.nneq(le.chronosec_range2,ri.sec_range), true);
							
	SELF.chronoaddr_isBest3 :=
				iid_constants.ga(chronoScore3)
				    AND (chronoScore3 = maxScore AND chronoScore1 <> chronoScore3 AND chronoScore2 <> chronoScore3)
							and if(ExactAddrRequired, le.chronoprim_range3=ri.prim_range and le.chronoprim_name3=ri.prim_name  and 
																				(le.chronozip3=ri.zip or (le.chronocity3=ri.city_name and le.chronostate3=ri.st)) and
																				ut.nneq(le.chronosec_range3,ri.sec_range), true);

	SELF := le;
END;


#IF(_control.Environment.onThor)
	with_best_addr1 := JOIN(
												distribute(rolled_header, did), 
												distribute(w, did), 
												LEFT.did=RIGHT.did, checkBest(LEFT,RIGHT), LEFT OUTER, local);
	with_best_addr_original := group(with_best_addr1, seq, did);
#ELSE
	with_best_addr_original := JOIN(rolled_header, w, LEFT.did=RIGHT.did, checkBest(LEFT,RIGHT), LEFT OUTER, LOOKUP);
#END




risk_indicators.layout_output checkBest_50 (risk_indicators.layout_output le) := TRANSFORM
	
	chrono_streetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', le.chronoprim_range, le.chronopredir, 
		le.chronoprim_name, le.chronosuffix, le.chronopostdir, 
		le.chronounit_desig,le.chronosec_range);
	chrono_streetAddress2 := Risk_Indicators.MOD_AddressClean.street_address('', le.chronoprim_range2, le.chronopredir2, 
		le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, 
		le.chronounit_desig2,le.chronosec_range2);
	chrono_streetAddress3 := Risk_Indicators.MOD_AddressClean.street_address('', le.chronoprim_range3, le.chronopredir3, 
		le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, 
		le.chronounit_desig3,le.chronosec_range3);
		
	hierarchy_streetAddress := Risk_Indicators.MOD_AddressClean.street_address('', le.addr_hierarchy_best_prim_range, le.addr_hierarchy_best_predir, 
		le.addr_hierarchy_best_prim_name, le.addr_hierarchy_best_suffix, le.addr_hierarchy_best_postdir, 
		le.addr_hierarchy_best_unit_desig,le.addr_hierarchy_best_sec_range);
	cleanRange := le.addr_hierarchy_best_prim_range;
	cleanName := le.addr_hierarchy_best_prim_name;
	cleanSecRange := le.addr_hierarchy_best_sec_range;

	SELF.veraddr_isBest :=
				iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.verprim_range, le.verprim_name, le.versec_range, 
																						cleanRange, cleanName, cleanSecRange))
							 and if(ExactAddrRequired, le.prim_range=le.addr_hierarchy_best_prim_range and le.prim_name=le.addr_hierarchy_best_prim_name and // If exact matching is required, don't use the cleaned address.
																					(le.in_zipcode=le.addr_hierarchy_best_zip or le.z5=le.addr_hierarchy_best_zip or 
																							(le.in_city=le.addr_hierarchy_best_city and le.in_state=le.addr_hierarchy_best_state) or (le.p_city_name=le.addr_hierarchy_best_city and le.st=le.addr_hierarchy_best_state)) and
																					ut.nneq(le.sec_range,le.addr_hierarchy_best_sec_range), true);
	
	// Score each of the chrono addresses.  patch the score to 100 if the string comparison of chronoaddr to hierarchy_addr is exact
	chronoScore1 := if(chrono_streetAddress1=hierarchy_streetAddress and hierarchy_streetAddress<>'', 100, Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range, le.chronoprim_name, le.chronosec_range,	cleanRange, cleanName, cleanSecRange));
	chronoScore2 := if(chrono_streetAddress2=hierarchy_streetAddress and hierarchy_streetAddress<>'', 100, Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range2, le.chronoprim_name2, le.chronosec_range2, cleanRange, cleanName, cleanSecRange));
	chronoScore3 := if(chrono_streetAddress3=hierarchy_streetAddress and hierarchy_streetAddress<>'', 100, Risk_Indicators.AddrScore.AddressScore(le.chronoprim_range3, le.chronoprim_name3, le.chronosec_range3, cleanRange, cleanName, cleanSecRange));
	
	// Select the chrono address with the best score.  In the event that two chrono scores match, select the address that occurs first in the listing as the best address.
  maxScore := MAX(IF(chronoScore1 = 255, -1, chronoScore1), IF(chronoScore2 = 255, -1, chronoScore2), IF(chronoScore3 = 255, -1, chronoScore3));
	
	SELF.chronoaddr_isBest := 
				iid_constants.ga(chronoScore1)
				    AND (chronoScore1 = maxScore)
							and if(ExactAddrRequired, le.chronoprim_range=le.addr_hierarchy_best_prim_range and le.chronoprim_name=le.addr_hierarchy_best_prim_name  and 
																				(le.chronozip=le.addr_hierarchy_best_zip or (le.chronocity=le.addr_hierarchy_best_city and le.chronostate=le.addr_hierarchy_best_state)) and
																				ut.nneq(le.chronosec_range,le.addr_hierarchy_best_sec_range), true);
							
	SELF.chronoaddr_isBest2 :=
				iid_constants.ga(chronoScore2)
				    AND (chronoScore2 = maxScore AND chronoScore1 <> chronoScore2)
							and if(ExactAddrRequired, le.chronoprim_range2=le.addr_hierarchy_best_prim_range and le.chronoprim_name2=le.addr_hierarchy_best_prim_name  and 
																				(le.chronozip2=le.addr_hierarchy_best_zip or (le.chronocity2=le.addr_hierarchy_best_city and le.chronostate2=le.addr_hierarchy_best_state)) and
																				ut.nneq(le.chronosec_range2,le.addr_hierarchy_best_sec_range), true);
							
	SELF.chronoaddr_isBest3 :=
				iid_constants.ga(chronoScore3)
				    AND (chronoScore3 = maxScore AND chronoScore1 <> chronoScore3 AND chronoScore2 <> chronoScore3)
							and if(ExactAddrRequired, le.chronoprim_range3=le.addr_hierarchy_best_prim_range and le.chronoprim_name3=le.addr_hierarchy_best_prim_name  and 
																				(le.chronozip3=le.addr_hierarchy_best_zip or (le.chronocity3=le.addr_hierarchy_best_city and le.chronostate3=le.addr_hierarchy_best_state)) and
																				ut.nneq(le.chronosec_range3,le.addr_hierarchy_best_sec_range), true);


// take these out after done troubleshooting isBest issues
// self.fname := (string)chronoscore1;
// self.mname := (string)chronoscore2;
// self.lname := (string)chronoscore3;
// self.in_streetaddress := hierarchy_streetAddress;
// self.prim_range := cleanRange;
// self.prim_name := cleanName;
// self.sec_range := cleanSecRange;

	SELF := le;
END;

//instead of using the bestAddrFunc (w), just project rolled_header and check the addr_hierarchy_best
with_best_addr_50 := project(rolled_header, checkbest_50(left));
  
// since this function has exactly what we need to append the header sources summary for address, we'll put that in here too
with_addresses_header_summary := Risk_Indicators.Boca_Shell_Addresses_Header_Summary(all_header, with_best_addr_50);

with_best_addr := if(bsversion >= 50, with_addresses_header_summary, with_best_addr_original);

// output(with_best_addr_50, named('with_best_addr_50'));

return with_best_addr;

end;