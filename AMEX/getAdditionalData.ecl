import doxie, paw, paw_services, ContactCard, Easi, avm_v2, VotersV2_Services, riskWise, risk_indicators;
import American_Student_Services;

export getAdditionalData(
       dataset (doxie.layout_references) dids,
			 string30 Account,
			 unsigned1 DPPA_Purpose,
			 unsigned1 GLB_Purpose, 
			 unsigned3 history_date = 999999, 
			 boolean isFCRA = false,
			 string10 DataRestriction =risk_indicators.iid_constants.default_DataRestriction,
			 string6 ssn_mask_value = '',
			 boolean probation_override_value = false,
			 boolean ln_branded = false,
			 unsigned1 BSversion = 1,
			 boolean suppressNearDups = false,
			 boolean Count_RelsAtAddrs = true
			 ) := MODULE
	//History Rule: first_seen_dt < full_history_date
   full_history_date := risk_indicators.iid_constants.full_history_date(history_date);
	//Valid Voter Registration
	 voterRecs := VotersV2_Services.raw.report_view.by_did (dids, ssn_mask_value);
	 voterRecsH := voterRecs((unsigned)process_date < (unsigned)full_history_date);
  //output(VoterRecsH, named('voterRecsH'));
	//Education (FCRA compliant)
	 collegeRecsH := American_Student_Services.Functions.GetCollegeIndicators(dids,isFCRA, history_date);
	//People at Work
	contact_ids :=  paw_services.PAW_Raw.getContactIDs.byDIDs(dids);
	pawAll := join(contact_ids, PAW.key_contactID, keyed(left.contact_id=right.contact_id), transform(recordof(paw.Key_contactID), self := right), atmost(riskwise.max_atmost), keep(100));
  pawAllH := pawAll((unsigned)dt_first_seen < (unsigned)full_history_date);	
	pawLatestRecsH := dedup(sort(pawAllH, did, -dt_last_seen, -dt_first_seen), did);
	//get top10 relatives if not FCRA
	top10Rels := if (isFCRA = false,fn_getRels(dids));
	relOnlydids := project(top10Rels,doxie.layout_references);
	                                          //add parameters back in for real runs....
	rel_comp := doxie.Comp_Subject_Addresses(relOnlydids,
																						,
																						DPPA_Purpose,
																						GLB_Purpose,
																						ln_branded,
																						,
																						probation_override_value,
																						,
																						,
																						,
																						);
																						
																						
  rel_addrsH := rel_comp.addresses((unsigned)(dt_first_seen[1..6]+'01') < (unsigned)full_history_date);	

	rel_addrs_sorted := sort(rel_addrsH, 
	                         did,
													 prim_range, 
													 predir, 
													 prim_name, 
													 suffix, 
													 postdir, 
													 zip);
  
	rel_addrs_deduped := dedup(rel_addrs_sorted, did, prim_range, predir, prim_name, suffix, postdir, zip);
	
	rel_c := record
	 rel_addrs_deduped.prim_range;
	 rel_addrs_deduped.predir;
	 rel_addrs_deduped.prim_name;
	 rel_addrs_deduped.suffix;
	 rel_addrs_deduped.postdir;
	 rel_addrs_deduped.zip;
	 integer relativesAtAddr := count(group);
	end;
	rel_count := table(rel_addrs_deduped,
	                   rel_c, 
										 rel_addrs_deduped.prim_range,
										 rel_addrs_deduped.predir,
										 rel_addrs_deduped.prim_name,
										 rel_addrs_deduped.suffix,
										 rel_addrs_deduped.postdir,
										 rel_addrs_deduped.zip);
	
	//Address History test...
	risk_indicators.Layout_Input fillDid(doxie.layout_references L) := transform
	  self := L;
		self := [];
	end;
	indata := project(dids,fillDid(LEFT));
	
	with_DID := risk_indicators.iid_getDID_prepOutput(indata, 
	                                                  DPPA_Purpose, 
																										GLB_Purpose, 
																										history_date, 
																										isFCRA, 
																										BSVersion,
																										DataRestriction);
	with_header := risk_indicators.iid_getHeader(with_DID, DPPA_Purpose, GLB_Purpose, history_date, isFCRA, ln_branded, bsversion := BSversion, dataRestriction:=DataRestriction);
	just_layout_output := PROJECT (with_header,TRANSFORM(risk_indicators.layout_output, SELF := LEFT));		
  rolled_header := AMEX.iid_roll_header5(just_layout_output, suppressNearDups, BSversion);
	
	//normalize subjects 5 addresses
	subAddr := AMEX.layouts.subAddr;
	subAddr normIt(AMEX.layouts.shell_with5 l, integer c) := transform
	  self.order := c;
	  self.did := l.did;
		self.prim_range := CHOOSE(C, L.chronoprim_range, L.chronoprim_range2, L.chronoprim_range3, L.chronoprim_range4, L.chronoprim_range5);
		self.predir := CHOOSE(C, L.chronopredir, L.chronopredir2, L.chronopredir3, L.chronopredir4, L.chronopredir5);
		self.prim_name := CHOOSE(C, L.chronoprim_name, L.chronoprim_name2, L.chronoprim_name3, L.chronoprim_name4, L.chronoprim_name5);
		self.suffix := CHOOSE(C, L.chronosuffix, L.chronosuffix2, L.chronosuffix3, L.chronosuffix4, L.chronosuffix5);
		self.postdir := CHOOSE(C, L.chronopostdir, L.chronopostdir2, L.chronopostdir3, L.chronopostdir4, L.chronopostdir5);
		zipval :=CHOOSE(C, L.chronozip, L.chronozip2, L.chronozip3, L.chronozip54, L.chronozip5); 		
		self.zip := if (self.prim_range = '' and self.prim_name = '' and zipval = '', skip,zipval); 
		self.dt_first_seen := CHOOSE(C, L.chronodate_first, L.chronodate_first2, L.chronodate_first3, L.chronodate_first4, L.chronodate_first5);
		self.dt_last_seen := CHOOSE(C, L.chronodate_last, L.chronodate_last2, L.chronodate_last3, L.chronodate_last4, L.chronodate_last5);
		self.unit_desig := CHOOSE(C, L.chronounit_desig, L.chronounit_desig2, L.chronounit_desig3, L.chronounit_desig4, L.chronounit_desig5);
		self.sec_range := CHOOSE(C, L.chronosec_range, L.chronosec_range2, L.chronosec_range3, L.chronosec_range4, L.chronosec_range5);
		self.city_name := CHOOSE(C, L.chronocity, L.chronocity2, L.chronocity3, L.chronocity4, L.chronocity5);;
		self.st := CHOOSE(C, L.chronostate, L.chronostate2, L.chronostate3, L.chronostate4, L.chronostate5);
		self.zip4 := CHOOSE(C, L.chronozip4, L.chronozip4_2, L.chronozip4_3, L.chronozip4_4, L.chronozip4_5);
		self.county := CHOOSE(C, L.chronocounty, L.chronocounty2, L.chronocounty3, L.chronocounty4, L.chronocounty5);
		self.county_name := '';
		self.phone := CHOOSE(C, L.chronophone, L.chronophone2, L.chronophone3, L.chronophone4, L.chronophone5);
		self.listed_phone := CHOOSE(C, L.chronophone, L.chronophone2, L.chronophone3, L.chronophone4, L.chronophone5);
		self.geo_blk := CHOOSE(C, L.chronogeo_blk, L.chronogeo_blk2, L.chronogeo_blk3, L.chronogeo_blk4, L.chronogeo_blk5);
		self.chronoaddrscore := CHOOSE(C, L.chronoaddrscore, L.chronoaddrscore2, L.chronoaddrscore3, L.chronoaddrscore4, L.chronoaddrscore5);
		self.chrono_sources := CHOOSE(C, L.chrono_sources, L.chrono_sources2, L.chrono_sources3, L.chrono_sources4, L.chrono_sources5);
		self.chrono_addrcount := CHOOSE(C, L.chrono_addrcount, L.chrono_addrcount2, L.chrono_addrcount3, L.chrono_addrcount4, L.chrono_addrcount5);
		self.chrono_eqfsaddrcount := CHOOSE(C, L.chrono_eqfsaddrcount, L.chrono_eqfsaddrcount2, L.chrono_eqfsaddrcount3, L.chrono_eqfsaddrcount4, L.chrono_eqfsaddrcount5);;
		self.chrono_dladdrcount := CHOOSE(C, L.chrono_dladdrcount, L.chrono_dladdrcount2, L.chrono_dladdrcount3, L.chrono_dladdrcount4, L.chrono_dladdrcount5);
		self.chrono_emaddrcount := CHOOSE(C, L.chrono_emaddrcount, L.chrono_emaddrcount2, L.chrono_emaddrcount3, L.chrono_emaddrcount4, L.chrono_emaddrcount5);	
		self := [];
   end;
	 norm5 := ungroup(normalize(rolled_header, 5, normIt(LEFT,COUNTER)));	
  	
	//count relatives at address
	subAddr  joinEm(subAddr l, rel_c r) := transform
	   self.relativesAtAddr := r.relativesAtAddr;
	   self := l;
	end;
	
	norm5withCounts := if (Count_RelsAtAddrs,
													join(norm5, rel_count,
														lEFT.prim_range = RIGHT.prim_range AND 
														LEFT.predir = RIGHT.predir AND
														left.prim_name = right.prim_name AND
														left.suffix = right.suffix AND
														left.postdir = right.postdir AND
														left.zip = right.zip, 
														joinEm(left,right), left outer),
												   norm5);
  
	sorted5withCounts := sort(norm5withCounts,order);
	// most recent address, append the EASI census information 
	EASI_w_seq := RECORD
		INTEGER did ;
		easi.layout_census;
	END;
  
	EASI_rec := join(rolled_header, Easi.Key_Easi_Census,
							keyed(right.geolink=left.chronostate+left.chronocounty+left.chronogeo_blk),
							transform(EASI_w_seq, 
							          self.state := left.chronostate, 
												self.county := left.chronocounty, 
							          self.TRACT := left.chronogeo_blk[1..6], 
												self.BLKGRP := left.chronogeo_blk[7], 
												self.geo_blk := left.chronogeo_blk, 
											  self := right, 
												self := left,
												self := []), 
												left outer,atmost(AMEX.constants.easi_max_recs),keep(10));
	
  
  //Automated Valuation for properties top 5 addresses (FCRA compliant).
	avm_w_seq := RECORD
		INTEGER did ;
		recordof(avm_v2.Key_AVM_Address);         
	END;
		
	avm_addr1 := if (isFCRA, join(rolled_header, avm_v2.Key_AVM_Address_FCRA,
									left.chronoprim_name <> '' and left.chronozip <> '' and
									keyed(left.chronoprim_name = right.prim_name) and
									keyed(left.chronostate = right.st) and
									keyed(left.chronozip = right.zip) and
									keyed(left.chronoprim_range = right.prim_range) and
									keyed(left.chronosec_range = right.sec_range) and
									left.chronopredir=right.predir and 
									left.chronopostdir=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								,
									join(rolled_header, avm_v2.Key_AVM_Address,
									left.chronoprim_name <> '' and left.chronozip <> '' and
									keyed(left.chronoprim_name = right.prim_name) and
									keyed(left.chronostate = right.st) and
									keyed(left.chronozip = right.zip) and
									keyed(left.chronoprim_range = right.prim_range) and
									keyed(left.chronosec_range = right.sec_range) and
									left.chronopredir=right.predir and 
									left.chronopostdir=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								);
		
	avm_addr2 := if (isFCRA, join(rolled_header, avm_v2.Key_AVM_Address_FCRA,
									left.chronoprim_name2 <> '' and left.chronozip2 <> '' and
									keyed(left.chronoprim_name2 = right.prim_name) and
									keyed(left.chronostate2 = right.st) and
									keyed(left.chronozip2 = right.zip) and
									keyed(left.chronoprim_range2 = right.prim_range) and
									keyed(left.chronosec_range2 = right.sec_range) and
									left.chronopredir2=right.predir and 
									left.chronopostdir2=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								,
									join(rolled_header, avm_v2.Key_AVM_Address,
									left.chronoprim_name2 <> '' and left.chronozip2 <> '' and
									keyed(left.chronoprim_name2 = right.prim_name) and
									keyed(left.chronostate2 = right.st) and
									keyed(left.chronozip2 = right.zip) and
									keyed(left.chronoprim_range2 = right.prim_range) and
									keyed(left.chronosec_range2 = right.sec_range) and
									left.chronopredir2=right.predir and 
									left.chronopostdir2=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								);
  
	
	avm_addr3 := if (isFCRA,join(rolled_header, avm_v2.Key_AVM_Address_FCRA,
									left.chronoprim_name3 <> '' and left.chronozip3 <> '' and
									keyed(left.chronoprim_name3 = right.prim_name) and
									keyed(left.chronostate3 = right.st) and
									keyed(left.chronozip3 = right.zip) and
									keyed(left.chronoprim_range3 = right.prim_range) and
									keyed(left.chronosec_range3 = right.sec_range) and
									left.chronopredir3=right.predir and 
									left.chronopostdir3=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								,
									join(rolled_header, avm_v2.Key_AVM_Address,
									left.chronoprim_name3 <> '' and left.chronozip3 <> '' and
									keyed(left.chronoprim_name3 = right.prim_name) and
									keyed(left.chronostate3 = right.st) and
									keyed(left.chronozip3 = right.zip) and
									keyed(left.chronoprim_range3 = right.prim_range) and
									keyed(left.chronosec_range3 = right.sec_range) and
									left.chronopredir3=right.predir and 
									left.chronopostdir3=right.postdir,
									transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
								);
						
	
	avm_addr4 := if (isFCRA,join(rolled_header, avm_v2.Key_AVM_Address_FCRA,
								left.chronoprim_name4 <> '' and left.chronozip54 <> '' and
								keyed(left.chronoprim_name4 = right.prim_name) and
								keyed(left.chronostate4 = right.st) and
								keyed(left.chronozip54 = right.zip) and
								keyed(left.chronoprim_range4 = right.prim_range) and
								keyed(left.chronosec_range4 = right.sec_range) and
								left.chronopredir4=right.predir and 
								left.chronopostdir4=right.postdir,
								transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
							,
								join(rolled_header, avm_v2.Key_AVM_Address,
								left.chronoprim_name4 <> '' and left.chronozip54 <> '' and
								keyed(left.chronoprim_name4 = right.prim_name) and
								keyed(left.chronostate4 = right.st) and
								keyed(left.chronozip54 = right.zip) and
								keyed(left.chronoprim_range4 = right.prim_range) and
								keyed(left.chronosec_range4 = right.sec_range) and
								left.chronopredir4=right.predir and 
								left.chronopostdir4=right.postdir,
								transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
							);
  
	
	avm_addr5 := if (isFCRA,join(rolled_header, avm_v2.Key_AVM_Address_FCRA,
								left.chronoprim_name5 <> '' and left.chronozip5 <> '' and
								keyed(left.chronoprim_name5 = right.prim_name) and
								keyed(left.chronostate5 = right.st) and
								keyed(left.chronozip5 = right.zip) and
								keyed(left.chronoprim_range5 = right.prim_range) and
								keyed(left.chronosec_range5 = right.sec_range) and
								left.chronopredir5=right.predir and 
								left.chronopostdir5=right.postdir,
								transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
							,
								join(rolled_header, avm_v2.Key_AVM_Address,
								left.chronoprim_name5 <> '' and left.chronozip5 <> '' and
								keyed(left.chronoprim_name5 = right.prim_name) and
								keyed(left.chronostate5 = right.st) and
								keyed(left.chronozip5 = right.zip) and
								keyed(left.chronoprim_range5 = right.prim_range) and
								keyed(left.chronosec_range5 = right.sec_range) and
								left.chronopredir5=right.predir and 
								left.chronopostdir5=right.postdir,
								transform(avm_w_seq, self := right, self := left), left outer, atmost(AMEX.constants.easi_max_recs))
							);
  avm_addr1H := avm_addr1((unsigned)recording_date < (unsigned)full_history_date);
  avm_addr2H := avm_addr2((unsigned)recording_date < (unsigned)full_history_date);
  avm_addr3H := avm_addr3((unsigned)recording_date < (unsigned)full_history_date);
  avm_addr4H := avm_addr4((unsigned)recording_date < (unsigned)full_history_date);
  avm_addr5H := avm_addr5((unsigned)recording_date < (unsigned)full_history_date);
		
	avm_nodups1 := ungroup(dedup(sort(avm_addr1H, did, -recording_date, -assessed_value_year), did))		;			
	avm_nodups2 := ungroup(dedup(sort(avm_addr2H, did, -recording_date, -assessed_value_year), did))		;			
	avm_nodups3 := ungroup(dedup(sort(avm_addr3H, did, -recording_date, -assessed_value_year), did))		;			
	avm_nodups4 := ungroup(dedup(sort(avm_addr4H, did, -recording_date, -assessed_value_year), did))		;			
	avm_nodups5 := ungroup(dedup(sort(avm_addr5H, did, -recording_date, -assessed_value_year), did))		;			

	avmRecs :=  project(avm_nodups1,recordof(avm_v2.Key_AVM_Address)) + 
	             project(avm_nodups2,recordof(avm_v2.Key_AVM_Address)) + 
							 project(avm_nodups3,recordof(avm_v2.Key_AVM_Address)) + 
							 project(avm_nodups4,recordof(avm_v2.Key_AVM_Address)) + 
							 project(avm_nodups5,recordof(avm_v2.Key_AVM_Address));
							 
	//load data into results record	 
	amex.layouts.outputProc2  loadResults() := transform
	 self.account := account;
	 self.did     := dids[1].did;
	
	 self.voter_vtid   := voterRecsH[1].vtid;
	 
	 self.college := collegeRecsH[1];
	 
	 //self.paw     := pawLatestRecsH[1];
	 self.paw_contact_id := pawLatestRecsH[1].contact_id;
	 self.paw_company_name := pawLatestRecsH[1].company_name;
	 self.paw_company_title := pawLatestRecsH[1].company_title;
	 self.paw_title := pawLatestRecsH[1].title;
	 self.paw_dt_last_seen := pawLatestRecsH[1].dt_last_seen;
	 
	 //self.easi    := EASI_rec[1] ;
	 self.easi_MED_HHINC :=EASI_rec[1].MED_HHINC ;
	 self.easi_MED_HVAL :=EASI_rec[1].MED_HVAL;
	 self.easi_MURDERS :=EASI_rec[1].MURDERS;
	 self.easi_CARTHEFT :=EASI_rec[1].CARTHEFT;
   self.easi_BURGLARY :=EASI_rec[1].BURGLARY;
	 self.easi_TOTCRIME :=EASI_rec[1].TOTCRIME;
	 
	 //self.avm     := choosen(avmRecs,AMEX.constants.max_addr);
	 self.avm1_valuation := (string)avm_nodups1[1].automated_valuation;
	 self.avm2_valuation := (string)avm_nodups2[1].automated_valuation;
	 self.avm3_valuation := (string)avm_nodups3[1].automated_valuation;
	 self.avm4_valuation := (string)avm_nodups4[1].automated_valuation;
	 self.avm5_valuation := (string)avm_nodups5[1].automated_valuation;
	 //self.addrs   := choosen(sorted5withCounts,AMEX.constants.max_addr);  //5 address rows.	 
	 self.addrs1_zip :=  sorted5withCounts[1].zip;
	 self.addrs1_zip4 :=  sorted5withCounts[1].zip4; 
	 self.addrs1_dt_first_seen :=  sorted5withCounts[1].dt_first_seen;
	 self.addrs1_dt_last_seen :=  sorted5withCounts[1].dt_last_seen;
	 self.addrs1_relativesAtAddr :=  sorted5withCounts[1].relativesAtAddr;
	 self.addrs2_zip :=  sorted5withCounts[2].zip; 
	 self.addrs2_zip4 :=  sorted5withCounts[2].zip4;
	 self.addrs2_dt_first_seen :=  sorted5withCounts[2].dt_first_seen;
	 self.addrs2_dt_last_seen :=  sorted5withCounts[2].dt_last_seen;
	 self.addrs2_relativesAtAddr :=  sorted5withCounts[2].relativesAtAddr;
	 self.addrs3_zip :=  sorted5withCounts[3].zip;
	 self.addrs3_zip4 :=  sorted5withCounts[3].zip4;
	 self.addrs3_dt_first_seen :=  sorted5withCounts[3].dt_first_seen;
	 self.addrs3_dt_last_seen :=  sorted5withCounts[3].dt_last_seen;
	 self.addrs3_relativesAtAddr :=  sorted5withCounts[3].relativesAtAddr;
	 self.addrs4_zip :=  sorted5withCounts[4].zip;							
	 self.addrs4_zip4 :=  sorted5withCounts[4].zip4;
	 self.addrs4_dt_first_seen :=  sorted5withCounts[4].dt_first_seen;
	 self.addrs4_dt_last_seen :=  sorted5withCounts[4].dt_last_seen;
	 self.addrs4_relativesAtAddr :=  sorted5withCounts[4].relativesAtAddr;
	 self.addrs5_zip :=  sorted5withCounts[5].zip; 
	 self.addrs5_zip4 :=  sorted5withCounts[5].zip4;
	 self.addrs5_dt_first_seen :=  sorted5withCounts[5].dt_first_seen;
	 self.addrs5_dt_last_seen :=  sorted5withCounts[5].dt_last_seen;
 	 self.addrs5_relativesAtAddr :=  sorted5withCounts[5].relativesAtAddr;
	 
	 self.rels.Relative_key1 := if (top10rels[1].did > 0,intformat(top10rels[1].did,12,1),'');
	 self.rels.Relative_type1:= top10rels[1].title;
	 self.rels.Relative_key2:= if (top10rels[2].did > 0, intformat(top10rels[2].did,12,1),'');
	 self.rels.Relative_type2:= top10rels[2].title;
	 self.rels.Relative_key3:= if (top10rels[3].did > 0, intformat(top10rels[3].did,12,1),'');
	 self.rels.Relative_type3:= top10rels[3].title;
	 self.rels.Relative_key4:= if (top10rels[4].did > 0, intformat(top10rels[4].did,12,1),'');
	 self.rels.Relative_type4:= top10rels[4].title;
	 self.rels.Relative_key5:= if (top10rels[5].did > 0, intformat(top10rels[5].did,12,1),'');
	 self.rels.Relative_type5:= top10rels[5].title;
	 self.rels.Relative_key6:= if (top10rels[6].did > 0, intformat(top10rels[6].did,12,1),'');
	 self.rels.Relative_type6:= top10rels[6].title;
	 self.rels.Relative_key7:= if (top10rels[7].did > 0, intformat(top10rels[7].did,12,1),'');
	 self.rels.Relative_type7:= top10rels[7].title;
	 self.rels.Relative_key8:= if (top10rels[8].did > 0, intformat(top10rels[8].did,12,1),'');
	 self.rels.Relative_type8:= top10rels[8].title;
	 self.rels.Relative_key9:= if (top10rels[9].did > 0, intformat(top10rels[9].did,12,1),'');
	 self.rels.Relative_type9:= top10rels[9].title;
	 self.rels.Relative_key10:= if (top10rels[10].did > 0, intformat(top10rels[10].did,12,1),'');
	 self.rels.Relative_type10:= top10rels[10].title;
	 self := [];
	end;

  EXPORT RESULTS := dataset([loadResults()]);
END;