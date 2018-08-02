import _Control, risk_indicators, ut;
onThor := _Control.Environment.OnThor;

export iid_roll_header(grouped DATASET(risk_indicators.layout_output) all_header, boolean suppressNearDups=false,
											 unsigned1 BSversion, boolean experian_batch_feed=false, boolean isFCRA=false,
											 unsigned8 BSOptions) := function

betterAddresses := risk_indicators.Grade_Addresses_Function(all_header);
noNearDups := JOIN(all_header, betterAddresses,
												LEFT.seq = RIGHT.indata.seq 
												AND LEFT.chronoprim_range=RIGHT.prim_range
												AND LEFT.chronoprim_name=RIGHT.prim_name 
												AND LEFT.chronosec_range=RIGHT.sec_range
												AND LEFT.chronozip = RIGHT.zip,
												TRANSFORM(risk_indicators.Layout_Output, SELF := LEFT), LOOKUP);

header_addresses := IF(suppressNearDups, noNearDups, all_header); 

// FOR MULTIPLE ADLS, UNGROUP AND THEN REGROUP BY SEQ AND DID
ug := ungroup(header_addresses);
gh_roxie := group(sort(ug, seq,did), seq, did);
gh_thor := group(sort(distribute(ug, hash64(seq,did)),seq,did, local), seq, did, local);

#IF(onThor)
	gh := gh_thor;
#ELSE
	gh := gh_roxie;
#END

RetainInputDID 		:= ((BSOptions & Risk_Indicators.iid_constants.BSOptions.RetainInputDID) > 0);
EnableEmergingID 	:= ((BSOptions & Risk_Indicators.iid_constants.BSOptions.EnableEmergingID) > 0);
IsInstantIDv1 		:= ~isFCRA AND (BSOptions & Risk_Indicators.iid_constants.BSOptions.IsInstantIDv1) > 0;
		
sortedBest_original := sort(gh, seq, did, -dt_last_seen, -chronodate_first, chronolast, chronofirst, 
		// added more fields to sort by to make code deterministic when picking between EQ record and EQ(QH) record with same dates, but different address and ssn_valid results
		-socsvalid, -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, -chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate, -verdob, src);

// sort the addresses using the new logic from address hierarchy key
address_hierarchy_sort := sort(gh, seq, did, if(address_history_seq=0, 255, address_history_seq), 
		-dt_last_seen, -chronodate_first, chronolast, chronofirst, 
		// added more fields to sort by to make code deterministic when picking between EQ record and EQ(QH) record with same dates, but different address and ssn_valid results
		-socsvalid, -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, 
		-chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate, -verdob, src, record );
sortedBest := if(bsversion>=50, address_hierarchy_sort, sortedBest_original);
		
risk_indicators.layout_output countadd(risk_indicators.layout_output l,risk_indicators.layout_output r) := transform
	SELF.header_footprint := l.header_footprint + r.header_footprint;
	
	source_seen := r.src='XX' OR Stringlib.StringFind(l.sources,r.src+',',1)>0;
	firstnamesource_seen := r.src='XX' OR Stringlib.StringFind(l.firstnamesources,r.src+',',1)>0;
	lastnamesource_seen := r.src='XX' OR Stringlib.StringFind(l.lastnamesources,r.src+',',1)>0;
	addrsource_seen := r.src='XX' OR Stringlib.StringFind(l.addrsources,r.src+',',1)>0;
	socssource_seen := r.src='XX' OR Stringlib.StringFind(l.socssources,r.src+',',1)>0;
	
	hphonesource_seen := r.src='XX' OR Stringlib.StringFind(l.hphonesources,r.src+',',1)>0;
	wphonesource_seen := r.src='XX' OR Stringlib.StringFind(l.wphonesources,r.src+',',1)>0;
	cmpysource_seen := r.src='XX' OR Stringlib.StringFind(l.cmpysources,r.src+',',1)>0;
	dobsource_seen := r.src='XX' OR Stringlib.StringFind(l.dobsources,r.src+',',1)>0;
	
	SELF.sources := IF(source_seen,l.sources,TRIM(l.sources)+r.src+',');
	SELF.firstnamesources := IF(firstnamesource_seen OR r.firstcount=0,l.firstnamesources,TRIM(l.firstnamesources)+r.src+',');
	SELF.lastnamesources := IF(lastnamesource_seen OR r.lastcount=0,l.lastnamesources,TRIM(l.lastnamesources)+r.src+',');
	SELF.addrsources := IF(addrsource_seen OR r.addrcount=0,l.addrsources,TRIM(l.addrsources)+r.src+',');
	SELF.socssources := IF(socssource_seen OR r.socscount=0,l.socssources,TRIM(l.socssources)+r.src+',');
	SELF.hphonesources := IF(hphonesource_seen OR r.hphonecount=0,l.hphonesources,TRIM(l.hphonesources)+r.src+',');
	SELF.wphonesources := IF(wphonesource_seen OR r.wphonecount=0,l.wphonesources,TRIM(l.wphonesources)+r.src+',');
	SELF.cmpysources := IF(cmpysource_seen OR r.cmpycount=0,l.cmpysources,TRIM(l.cmpysources)+r.src+',');
	SELF.dobsources := IF(dobsource_seen OR r.dobcount=0,l.dobsources,TRIM(l.dobsources)+r.src+',');
	
	em_only_sources_seen := Stringlib.StringFind(trim(l.em_only_sources),trim(r.em_only_sources),1)>0 or r.src not in ['EM','E1','E2','E3','E4'];
	self.em_only_sources := if(em_only_sources_seen,l.em_only_sources,TRIM(l.em_only_sources)+r.em_only_sources);
	
	SELF.numsource := l.numsource + IF(source_seen,0,1);
	
	self.num_nonderogs := l.num_nonderogs + IF(~source_seen and r.num_nonderogs>0, 1, 0);
	self.num_nonderogs30 := l.num_nonderogs30 + IF(~source_seen and r.num_nonderogs30>0, 1, 0);
	self.num_nonderogs90 := l.num_nonderogs90 + IF(~source_seen and r.num_nonderogs90>0, 1, 0);
	self.num_nonderogs180 := l.num_nonderogs180 + IF(~source_seen and r.num_nonderogs180>0, 1, 0);
	self.num_nonderogs12 := l.num_nonderogs12 + IF(~source_seen and r.num_nonderogs12>0, 1, 0);
	self.num_nonderogs24 := l.num_nonderogs24 + IF(~source_seen and r.num_nonderogs24>0, 1, 0);
	self.num_nonderogs36 := l.num_nonderogs36 + IF(~source_seen and r.num_nonderogs36>0, 1, 0);
	self.num_nonderogs60 := l.num_nonderogs60 + IF(~source_seen and r.num_nonderogs60>0, 1, 0);
	
	chooser(BOOLEAN seen, INTEGER i, INTEGER x) := IF(seen,i,i+x);

	self.firstcount := chooser(firstnamesource_seen, l.firstcount, r.firstcount);
	self.lastcount := chooser(lastnamesource_seen, l.lastcount, r.lastcount);
	self.addrcount := chooser(addrsource_seen, l.addrcount, r.addrcount);
	self.socscount := chooser(socssource_seen, l.socscount, r.socscount);
	
	self.hphonecount := chooser(hphonesource_seen, l.hphonecount, r.hphonecount);
	self.wphonecount := chooser(wphonesource_seen, l.wphonecount, r.wphonecount);
	self.cmpycount := chooser(cmpysource_seen, l.cmpycount, r.cmpycount);
	self.dobcount := chooser(dobsource_seen, l.dobcount, r.dobcount);
		
	self.eqfsfirstcount := l.eqfsfirstcount OR r.eqfsfirstcount;
	self.eqfslastcount := l.eqfslastcount OR r.eqfslastcount;
	self.eqfsaddrcount := l.eqfsaddrcount OR r.eqfsaddrcount;
	self.eqfssocscount := l.eqfssocscount OR r.eqfssocscount;
	
	self.tufirstcount := l.tufirstcount OR r.tufirstcount;
	self.tulastcount := l.tulastcount OR r.tulastcount;
	self.tuaddrcount := l.tuaddrcount OR r.tuaddrcount;
	self.tusocscount := l.tusocscount OR r.tusocscount;
	
	self.dlfirstcount := l.dlfirstcount OR r.dlfirstcount;
	self.dllastcount := l.dllastcount OR r.dllastcount;
	self.dladdrcount := l.dladdrcount OR r.dladdrcount;
	self.dlsocscount := l.dlsocscount OR r.dlsocscount;
	
	self.emfirstcount := l.emfirstcount OR r.emfirstcount;
	self.emlastcount := l.emlastcount OR r.emlastcount;
	self.emaddrcount := l.emaddrcount OR r.emaddrcount;
	self.emsocscount := l.emsocscount OR r.emsocscount;
	
	self.bkfirstcount := l.bkfirstcount OR r.bkfirstcount;
	self.bklastcount := l.bklastcount OR r.bklastcount;
	self.bkaddrcount := l.bkaddrcount OR r.bkaddrcount;
	self.bksocscount := l.bksocscount OR r.bksocscount;
	
	SELF.adl_eqfs_first_seen := ut.Min2(l.adl_eqfs_first_seen,r.adl_eqfs_first_seen);
	SELF.adl_eqfs_last_seen := MAX(l.adl_eqfs_last_seen,r.adl_eqfs_last_seen);
	
	SELF.adl_en_first_seen := ut.Min2(l.adl_en_first_seen,r.adl_en_first_seen);
	SELF.adl_en_last_seen := MAX(l.adl_en_last_seen,r.adl_en_last_seen);
	
	// new dev shell fields
	self.EQ_count := l.eq_count + r.eq_count;
	self.EN_count := l.en_count + r.en_count;
	self.TU_count := l.tu_count + r.tu_count;
	self.DL_count := l.dl_count + r.dl_count;
	self.PR_count := l.pr_count + r.pr_count;
	self.V_count := l.v_count + r.v_count;
	self.EM_count := l.em_count + r.em_count;
	self.W_count := l.w_count + r.w_count;
	self.VO_count := l.vo_count + r.vo_count;
	self.EM_only_count := l.em_only_count + r.em_only_count;
	
	self.adl_TU_first_seen := ut.Min2(l.adl_tu_first_seen, r.adl_tu_first_seen);
	self.adl_TU_last_seen := MAX(l.adl_tu_last_seen, r.adl_tu_last_seen);
	self.adl_DL_first_seen := ut.Min2(l.adl_dl_first_seen, r.adl_dl_first_seen);
	self.adl_DL_last_seen := MAX(l.adl_dl_last_seen, r.adl_dl_last_seen);
	self.adl_PR_first_seen := ut.Min2(l.adl_pr_first_seen, r.adl_pr_first_seen);
	self.adl_PR_last_seen := MAX(l.adl_pr_last_seen, r.adl_pr_last_seen);
	self.adl_V_first_seen := ut.Min2(l.adl_v_first_seen, r.adl_v_first_seen);
	self.adl_V_last_seen := MAX(l.adl_v_last_seen, r.adl_v_last_seen);
	self.adl_EM_first_seen := ut.Min2(l.adl_em_first_seen, r.adl_em_first_seen);
	self.adl_EM_last_seen := MAX(l.adl_em_last_seen, r.adl_em_last_seen);
	self.adl_W_first_seen := ut.Min2(l.adl_w_first_seen, r.adl_w_first_seen);
	self.adl_W_last_seen := MAX(l.adl_w_last_seen, r.adl_w_last_seen);
	self.adl_VO_first_seen := MAX(l.adl_vo_first_seen, r.adl_vo_first_seen);
	self.adl_VO_last_seen := MAX(l.adl_vo_last_seen, r.adl_vo_last_seen);
	self.adl_EM_only_first_seen := MAX(l.adl_em_only_first_seen, r.adl_em_only_first_seen);
	self.adl_EM_only_last_seen := MAX(l.adl_em_only_last_seen, r.adl_em_only_last_seen);
	
	SELF.adl_other_first_seen := ut.Min2(l.adl_other_first_seen,r.adl_other_first_seen);
	SELF.adl_other_last_seen := MAX(l.adl_other_last_seen,r.adl_other_last_seen);
	
	howmany := MAP(l.chronoprim_name=''  OR (l.chronoprim_name= r.chronoprim_name and l.chronoprim_range= r.chronoprim_range and l.chronozip= r.chronozip) => 1,
								 l.chronoprim_name2='' OR (l.chronoprim_name2=r.chronoprim_name and l.chronoprim_range2=r.chronoprim_range and l.chronozip2=r.chronozip) => 2,
								 l.chronoprim_name3='' OR (l.chronoprim_name3=r.chronoprim_name and l.chronoprim_range3=r.chronoprim_range and l.chronozip3=r.chronozip) => 3,
								 4);

	// chronology that keeps track of which sources
	chrono_source_seen := IF(howmany=1,r.src='XX' OR Stringlib.StringFind(l.chrono_sources,trim(r.CHRONO_SOURCES),1)>0,false);
	SELF.chrono_sources := IF(howmany<>1 OR chrono_source_seen, l.chrono_sources, TRIM(l.chrono_sources)+r.CHRONO_SOURCES);
	SELF.chrono_addrcount := IF(howmany<>1 OR chrono_source_seen,l.chrono_addrcount,l.chrono_addrcount+1);
	SELF.chrono_eqfsaddrcount := IF(howmany<>1,l.chrono_eqfsaddrcount,l.chrono_eqfsaddrcount OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount := IF(howmany<>1,l.chrono_dladdrcount,l.chrono_dladdrcount OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount := IF(howmany<>1,l.chrono_emaddrcount,l.chrono_emaddrcount OR r.chrono_emaddrcount);

	self.chronofirst := IF(howmany=1,r.chronofirst,l.chronofirst);
	self.chronolast := IF(howmany=1,r.chronolast,l.chronolast);
	// for shell 5.0, the left record is always the address we want to keep, for earlier versions of the shell, leave logic as it was
	self.chronoprim_range := IF(howmany=1,if(bsversion>=50,l.chronoprim_range,r.chronoprim_range),l.chronoprim_range);
	self.chronopredir := IF(howmany=1,if(bsversion>=50,l.chronopredir,r.chronopredir),l.chronopredir);
	self.chronoprim_name := IF(howmany=1,if(bsversion>=50,l.chronoprim_name,r.chronoprim_name),l.chronoprim_name);
	self.chronosuffix := IF(howmany=1,if(bsversion>=50,l.chronosuffix,r.chronosuffix),l.chronosuffix);
	self.chronopostdir := IF(howmany=1,if(bsversion>=50,l.chronopostdir,r.chronopostdir),l.chronopostdir);
	self.chronounit_desig := IF(howmany=1,if(bsversion>=50, l.chronounit_desig, r.chronounit_desig),l.chronounit_desig);
	self.chronosec_range := IF(howmany=1,if(bsversion>=50, l.chronosec_range,r.chronosec_range),l.chronosec_range);
	self.chronocity := IF(howmany=1,if(bsversion>=50, l.chronocity,r.chronocity),l.chronocity);
	self.chronostate := IF(howmany=1,if(bsversion>=50, l.chronostate,r.chronostate),l.chronostate);
	self.chronozip := IF(howmany=1,if(bsversion>=50, l.chronozip, r.chronozip),l.chronozip);
	self.chronozip4 := IF(howmany=1,if(bsversion>=50, l.chronozip4,r.chronozip4),l.chronozip4);
	self.chronocounty := IF(howmany=1,if(bsversion>=50, l.chronocounty,r.chronocounty),l.chronocounty);
	self.chronogeo_blk := IF(howmany=1,if(bsversion>=50, l.chronogeo_blk,r.chronogeo_blk),l.chronogeo_blk);
	self.chronodate_first := IF(howmany=1,ut.Min2(l.chronodate_first,r.chronodate_first),l.chronodate_first);
	self.chronodate_last := IF(howmany=1,MAX(l.chronodate_last,r.chronodate_last),l.chronodate_last);
	self.chronoaddrscore := IF(howmany=1,if(bsversion>=50, l.chronoaddrscore,r.chronoaddrscore),l.chronoaddrscore);
  self.rawaid1 := IF(howmany=1,if(bsversion>=50, l.rawaid_orig,r.rawaid_orig),l.rawaid_orig);

	chrono_source_seen2 := IF(howmany=2,r.src='XX' OR Stringlib.StringFind(l.chrono_sources2,trim(r.chrono_sources),1)>0,false);
	SELF.chrono_sources2 := IF(howmany<>2 OR chrono_source_seen2, l.chrono_sources2, TRIM(l.chrono_sources2)+r.chrono_sources);
	SELF.chrono_addrcount2 := IF(howmany<>2 OR chrono_source_seen2,l.chrono_addrcount2,l.chrono_addrcount2+1);
	SELF.chrono_eqfsaddrcount2 := IF(howmany<>2,l.chrono_eqfsaddrcount2,l.chrono_eqfsaddrcount2 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount2 := IF(howmany<>2,l.chrono_dladdrcount2,l.chrono_dladdrcount2 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount2 := IF(howmany<>2,l.chrono_emaddrcount2,l.chrono_emaddrcount2 OR r.chrono_emaddrcount);
	
	self.chronofirst2 := IF(howmany=2,r.chronofirst,l.chronofirst2);
	self.chronolast2 := IF(howmany=2,r.chronolast,l.chronolast2);
	self.chronoprim_range2 := IF(howmany=2,r.chronoprim_range,l.chronoprim_range2);
	self.chronopredir2 := IF(howmany=2,r.chronopredir,l.chronopredir2);
	self.chronoprim_name2 := IF(howmany=2,r.chronoprim_name,l.chronoprim_name2);
	self.chronosuffix2 := IF(howmany=2,r.chronosuffix,l.chronosuffix2);
	self.chronopostdir2 := IF(howmany=2,r.chronopostdir,l.chronopostdir2);
	self.chronounit_desig2 := IF(howmany=2,r.chronounit_desig,l.chronounit_desig2);
	self.chronosec_range2 := IF(howmany=2,r.chronosec_range,l.chronosec_range2);
	self.chronocity2 := IF(howmany=2,r.chronocity,l.chronocity2);
	self.chronostate2 := IF(howmany=2,r.chronostate,l.chronostate2);
	self.chronozip2 := IF(howmany=2,r.chronozip,l.chronozip2);
	self.chronozip4_2 := IF(howmany=2,r.chronozip4,l.chronozip4_2);
	self.chronocounty2 := IF(howmany=2,r.chronocounty,l.chronocounty2);
	self.chronogeo_blk2 := IF(howmany=2,r.chronogeo_blk,l.chronogeo_blk2);
	self.chronodate_first2 := IF(howmany=2,ut.Min2(l.chronodate_first2,r.chronodate_first),l.chronodate_first2);
	self.chronodate_last2 := IF(howmany=2,MAX(l.chronodate_last2,r.chronodate_last),l.chronodate_last2);
	self.chronoaddrscore2 := IF(howmany=2,r.chronoaddrscore,l.chronoaddrscore2);
	self.rawaid2 := IF(howmany=2,r.rawaid_orig,l.rawaid2);

	chrono_source_seen3 := IF(howmany=3,r.src='XX' OR Stringlib.StringFind(l.chrono_sources3,trim(r.chrono_sources),1)>0,false);
	SELF.chrono_sources3 := IF(howmany<>3 OR chrono_source_seen3, l.chrono_sources3, TRIM(l.chrono_sources3)+r.chrono_sources);
	SELF.chrono_addrcount3 := IF(howmany<>3 OR chrono_source_seen3,l.chrono_addrcount3,l.chrono_addrcount3+1);
	SELF.chrono_eqfsaddrcount3 := IF(howmany<>3,l.chrono_eqfsaddrcount3,l.chrono_eqfsaddrcount3 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount3 := IF(howmany<>3,l.chrono_dladdrcount3,l.chrono_dladdrcount3 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount3 := IF(howmany<>3,l.chrono_emaddrcount3,l.chrono_emaddrcount3 OR r.chrono_emaddrcount);

	self.chronofirst3 := IF(howmany=3,r.chronofirst,l.chronofirst3);
	self.chronolast3 := IF(howmany=3,r.chronolast,l.chronolast3);
	self.chronoprim_range3 := IF(howmany=3,r.chronoprim_range,l.chronoprim_range3);
	self.chronopredir3 := IF(howmany=3,r.chronopredir,l.chronopredir3);
	self.chronoprim_name3 := IF(howmany=3,r.chronoprim_name,l.chronoprim_name3);
	self.chronosuffix3 := IF(howmany=3,r.chronosuffix,l.chronosuffix3);
	self.chronopostdir3 := IF(howmany=3,r.chronopostdir,l.chronopostdir3);
	self.chronounit_desig3 := IF(howmany=3,r.chronounit_desig,l.chronounit_desig3);
	self.chronosec_range3 := IF(howmany=3,r.chronosec_range,l.chronosec_range3);
	self.chronocity3 := IF(howmany=3,r.chronocity,l.chronocity3);
	self.chronostate3 := IF(howmany=3,r.chronostate,l.chronostate3);
	self.chronozip3 := IF(howmany=3,r.chronozip,l.chronozip3);
	self.chronozip4_3 := IF(howmany=3,r.chronozip4,l.chronozip4_3);
	self.chronocounty3 := IF(howmany=3,r.chronocounty,l.chronocounty3);
	self.chronogeo_blk3 := IF(howmany=3,r.chronogeo_blk,l.chronogeo_blk3);
	self.chronodate_first3 := IF(howmany=3,ut.Min2(l.chronodate_first3,r.chronodate_first),l.chronodate_first3);
	self.chronodate_last3 := IF(howmany=3,MAX(l.chronodate_last3,r.chronodate_last),l.chronodate_last3);
	self.chronoaddrscore3 := IF(howmany=3,r.chronoaddrscore,l.chronoaddrscore3);
  self.rawaid3 := IF(howmany=3,r.rawaid_orig,l.rawaid3);

	ssn_by_score := iid_constants.tscore(l.socsscore)>=iid_constants.tscore(r.socsscore);

	
// Add additional logic for Bug: 193838 
//    The default will be the SSN the most recent and has the highest score.
//    This new logic will attempt to override the default if we find a better SSN
//    when the customer enters a 4 digit SSN.  
//    A better SSN will be one that is flagged with a G on the header record

  ssnbyscore     := IF(ssn_by_score,l.versocs,r.versocs);	
  bestbyscore    := IF(ssn_by_score,l.socsscore,r.socsscore);
  valbyscore     := IF(ssn_by_score,l.socsvalid,r.socsvalid); 
  foundbetterssn := l.socsvalid <> iid_constants.good 
	                  AND r.socsvalid = iid_constants.good
										AND iid_constants.tscore(r.socsscore)>=iid_constants.tscore(l.socsscore);
  self.versocs   := IF(foundbetterssn, r.versocs, ssnbyscore);
  self.socsscore := IF(foundbetterssn, r.socsscore, bestbyscore);
  socsvalid := IF(foundbetterssn, r.socsvalid, valbyscore);
	// found during emerging identities testing that we want to keep a socsvalid that is populated over one that isn't.  
	// quick header records are usually blank for socsvalid and show up first in the sort because of their dates
	self.socsvalid := MAP(socsvalid not in risk_indicators.iid_constants.set_valid_ssn_codes and 
											 r.socsvalid in risk_indicators.iid_constants.set_valid_ssn_codes and 
											 r.ssn_from_did=l.ssn_from_did => r.socsvalid,
											 socsvalid ='' and r.socsvalid<>'' and r.ssn_from_did=l.ssn_from_did => r.socsvalid,
											 socsvalid);
  self.ssn       := IF(foundbetterssn, r.ssn, l.ssn);
	self.ssnLookupFlag       := IF(foundbetterssn, r.ssnLookupFlag, l.ssnLookupFlag);
		
	addr_lpicker := iid_constants.tscore(l.addrscore)>=iid_constants.tscore(r.addrscore) or (l.verprim_name<>'' and r.addrcount=0);
	
	self.verprim_range := IF(addr_lpicker,l.verprim_range,r.verprim_range);
	self.verpredir := IF(addr_lpicker,l.verpredir,r.verpredir);
	self.verprim_name := IF(addr_lpicker,l.verprim_name,r.verprim_name);
	self.versuffix := IF(addr_lpicker,l.versuffix,r.versuffix);
	self.verpostdir := IF(addr_lpicker,l.verpostdir,r.verpostdir);
	self.verunit_desig := IF(addr_lpicker,l.verunit_desig,r.verunit_desig);
	self.versec_range := IF(addr_lpicker,l.versec_range,r.versec_range);
	self.vercity := IF(addr_lpicker,l.vercity,r.vercity);
	self.verstate := IF(addr_lpicker,l.verstate,r.verstate);
	self.verzip := IF(addr_lpicker,l.verzip,r.verzip);
	self.vercounty := IF(addr_lpicker,l.vercounty,r.vercounty);
	self.vergeo_blk := IF(addr_lpicker,l.vergeo_blk,r.vergeo_blk);
	// keep the dates together with the address that was chosen
	self.verdate_first := IF(addr_lpicker,l.verdate_first,r.verdate_first);
	self.verdate_last:= IF(addr_lpicker,l.verdate_last,r.verdate_last);	
	
	self.addrscore := IF(addr_lpicker,l.addrscore,r.addrscore);
	
	self.addrmultiple := l.prim_name<>'' AND r.prim_name<>'';
	
	self.verlast := IF(iid_constants.tscore(l.lastscore)>=iid_constants.tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.verlast,r.verlast);
	self.lastscore := IF(iid_constants.tscore(l.lastscore)>=iid_constants.tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.lastscore,r.lastscore);
	
	self.verfirst := IF(iid_constants.tscore(l.firstscore)>=iid_constants.tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.verfirst,r.verfirst);
	self.firstscore := IF(iid_constants.tscore(l.firstscore)>=iid_constants.tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.firstscore,r.firstscore);
	
	take_left_dob := Map(
		(l.dobscore = 90 and r.dobscore in [94, 95, 96] and (integer)l.verdob<>0) => true, /* dobscore 90=miskey - Return 90 when presented with choice of 90 or 95 */
		(l.dobscore in [94, 95, 96] and r.dobscore = 90 and (integer)r.verdob<>0) => false,
		(iid_constants.tscore(l.dobscore)>=iid_constants.tscore(r.dobscore) and (integer)l.verdob<>0) => true,
		((integer)l.verdob<>0 and r.dobcount=0) => true,
		false
	);
	self.verdob := IF(take_left_dob,l.verdob,r.verdob);	
	self.dobscore := if(take_left_dob,l.dobscore,r.dobscore);
												
	self.verhphone := IF(iid_constants.tscore(l.hphonescore)>=iid_constants.tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.verhphone,r.verhphone);
	self.hphonescore := IF(iid_constants.tscore(l.hphonescore)>=iid_constants.tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.hphonescore,r.hphonescore);
	
	self.verwphone := IF(iid_constants.tscore(l.wphonescore)>=iid_constants.tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.verwphone,r.verwphone);
	self.wphonescore := IF(iid_constants.tscore(l.wphonescore)>=iid_constants.tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.wphonescore,r.wphonescore);
	

	
	// need to see if input is prison, not any of them on corrections
	self.isPrison := l.isPrison or r.isPrison;	
	self.prisonFSdate := ut.Min2(l.prisonFSdate, r.prisonFSdate);	// take the earliest non 0 date
	
	self.address_history_summary.address_history_advo_college_hit := l.address_history_summary.address_history_advo_college_hit or r.address_history_summary.address_history_advo_college_hit;

	chrono1_isPrison := if(howmany=1, r.isPrison, 
								risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono1_isPrison, l.iid_flags ));
	chrono2_isPrison := if(howmany=2, r.isPrison, 
								risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono2_isPrison, l.iid_flags ));
	chrono3_isPrison := if(howmany=3, r.isPrison, 
								risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.Chrono3_isPrison, l.iid_flags ));							
	prison_flags := case(howmany,
		1 => Risk_Indicators.iid_constants.SetFlag(Risk_Indicators.iid_constants.IIDFlag.Chrono1_isPrison, chrono1_isPrison),
		2 => Risk_Indicators.iid_constants.SetFlag(Risk_Indicators.iid_constants.IIDFlag.Chrono2_isPrison, chrono2_isPrison),
		3 => Risk_Indicators.iid_constants.SetFlag(Risk_Indicators.iid_constants.IIDFlag.Chrono3_isPrison, chrono3_isPrison),
		r.iid_flags
		);

	self.iid_flags := l.iid_flags | r.iid_flags | prison_flags;


	// if there was a correction then the chrono_flags will be populated, use that field, otherwise use the existing field, make sure address is input address
	self.addr_type := map(risk_indicators.ga(l.chronoaddrscore) and trim(l.chrono_addr_flags.dwelltype)<>'' => l.chrono_addr_flags.dwelltype,
												risk_indicators.ga(r.chronoaddrscore) and trim(r.chrono_addr_flags.dwelltype)<>'' => r.chrono_addr_flags.dwelltype,
												risk_indicators.ga(l.chronoaddrscore) => l.addr_type,
												risk_indicators.ga(r.chronoaddrscore) => r.addr_type,
												l.addr_type);
	self.dwelltype := map(risk_indicators.ga(l.chronoaddrscore) and trim(l.chrono_addr_flags.dwelltype)<>'' => iid_constants.dwelltype(l.chrono_addr_flags.dwelltype),
												risk_indicators.ga(r.chronoaddrscore) and trim(r.chrono_addr_flags.dwelltype)<>'' => iid_constants.dwelltype(r.chrono_addr_flags.dwelltype),
												risk_indicators.ga(l.chronoaddrscore) => l.dwelltype,
												risk_indicators.ga(r.chronoaddrscore) => r.dwelltype,
												l.dwelltype);
	self.addrvalflag := map(risk_indicators.ga(l.chronoaddrscore) and trim(l.chrono_addr_flags.valid)<>'' => if(l.chrono_addr_flags.valid in ['Y','1'],'Y','N'),
													risk_indicators.ga(r.chronoaddrscore) and trim(r.chrono_addr_flags.valid)<>'' => if(r.chrono_addr_flags.valid in ['Y','1'],'Y','N'),
													risk_indicators.ga(l.chronoaddrscore) => l.addrvalflag,
													risk_indicators.ga(r.chronoaddrscore) => r.addrvalflag,
													l.addrvalflag);
	

	self.chrono_addr_flags := IF(howmany=1, r.chrono_addr_flags, l.chrono_addr_flags);																																								

	self.chrono_addr_flags2 := IF(howmany=2, R.chrono_addr_flags, L.chrono_addr_flags2);
	
	self.chrono_addr_flags3 := if(howmany=3, r.chrono_addr_flags, l.chrono_addr_flags3);												
	
	self := l;
END;


rollbestcount := rollup(sortedbest, countadd(left,right), seq, did);	// rollup by seq and did, for when using multiple did for boca shell 3
	
// check to see if correction record or only 1 element verified then revert back to no DID found
risk_indicators.layout_output removeHeader(risk_indicators.layout_output le) := TRANSFORM
	isOnly1 := ((INTEGER)(BOOLEAN)le.firstcount+(INTEGER)(BOOLEAN)le.lastcount+(INTEGER)(BOOLEAN)le.addrcount+(INTEGER)(BOOLEAN)le.socscount+(INTEGER)(BOOLEAN)le.dobcount) = 1;
				
	blankOut := isOnly1 and StringLib.StringFind(le.src,'CO',1)=0;
	
	self.did := if(blankOut and ~RetainInputDID, 0, le.did);  // checking RetainInputDID option because we were given DID but we want to keep it, for services that pass in DID (2016 = ID2).

	SELF.header_footprint := if(blankOut, 0, le.header_footprint);
		
	SELF.trueDID := if(blankOut, false, le.trueDID);
	
	self.src := if(blankOut, '', le.src);

	self.dt_last_seen := if(blankOut, 0, le.dt_last_seen);			 
	self.firstcount := if(blankOut, 0, le.firstcount);
	self.lastcount := if(blankOut, 0, le.lastcount);
	self.addrcount := if(blankOut, 0, le.addrcount);
	self.socscount := if(blankOut, 0, le.socscount);
	self.hphonecount := if(blankOut, 0, le.hphonecount);
	self.wphonecount := if(blankOut, 0, le.wphonecount);
	self.cmpycount := if(blankOut, 0, le.cmpycount);
	self.dobcount := if(blankOut, 0, le.dobcount);
	
	self.eqfsfirstcount := if(blankOut, false, le.eqfsfirstcount);
	self.eqfslastcount := if(blankOut, false, le.eqfslastcount);
	self.eqfsaddrcount := if(blankOut, false, le.eqfsaddrcount);
	self.eqfssocscount := if(blankOut, false, le.eqfssocscount);

	self.tufirstcount := if(blankOut, false, le.tufirstcount);
	self.tulastcount := if(blankOut, false, le.tulastcount);
	self.tuaddrcount := if(blankOut, false, le.tuaddrcount);
	self.tusocscount := if(blankOut, false, le.tusocscount);

	self.dlfirstcount := if(blankOut, false, le.dlfirstcount);
	self.dllastcount := if(blankOut, false, le.dllastcount);
	self.dladdrcount := if(blankOut, false, le.dladdrcount);
	self.dlsocscount := if(blankOut, false, le.dlsocscount);

	self.emfirstcount := if(blankOut, false, le.emfirstcount);
	self.emlastcount := if(blankOut, false, le.emlastcount);
	self.emaddrcount := if(blankOut, false, le.emaddrcount);
	self.emsocscount := if(blankOut, false, le.emsocscount);

	self.bkfirstcount := if(blankOut, false, le.bkfirstcount);
	self.bklastcount := if(blankOut, false, le.bklastcount);
	self.bkaddrcount := if(blankOut, false, le.bkaddrcount);
	self.bksocscount := if(blankOut, false, le.bksocscount);

	SELF.adl_eqfs_first_seen := if(blankOut, 0, le.adl_eqfs_first_seen); 
	SELF.adl_eqfs_last_seen := if(blankOut, 0, le.adl_eqfs_last_seen);
	SELF.adl_other_first_seen := if(blankOut, 0, le.adl_other_first_seen);
	SELF.adl_other_last_seen := if(blankOut, 0, le.adl_other_last_seen);
	
	SELF.adl_en_first_seen := if(blankOut, 0, le.adl_en_first_seen);
	SELF.adl_en_last_seen := if(blankOut, 0, le.adl_en_last_seen);
	
	// new dev shell fields
	self.EQ_count := if(blankOut, 0, le.eq_count);
	self.EN_count := if(blankOut, 0, le.en_count);
	self.TU_count :=if(blankOut, 0, le.tu_count);
	self.DL_count := if(blankOut, 0, le.dl_count);
	self.PR_count := if(blankOut, 0, le.pr_count);
	self.V_count := if(blankOut, 0, le.v_count);
	self.EM_count := if(blankOut, 0, le.em_count);
	self.W_count := if(blankOut, 0, le.w_count);
	self.adl_TU_first_seen := if(blankOut, 0, le.adl_tu_first_seen);
	self.adl_TU_last_seen := if(blankOut, 0, le.adl_tu_last_seen);
	self.adl_DL_first_seen := if(blankOut, 0, le.adl_dl_first_seen);
	self.adl_DL_last_seen := if(blankOut, 0, le.adl_dl_last_seen);
	self.adl_PR_first_seen := if(blankOut, 0, le.adl_pr_first_seen);
	self.adl_PR_last_seen := if(blankOut, 0, le.adl_pr_last_seen);
	self.adl_V_first_seen := if(blankOut, 0, le.adl_v_first_seen);
	self.adl_V_last_seen := if(blankOut, 0, le.adl_v_last_seen);
	self.adl_EM_first_seen := if(blankOut, 0, le.adl_em_first_seen);
	self.adl_EM_last_seen := if(blankOut, 0, le.adl_em_last_seen);
	self.adl_W_first_seen := if(blankOut, 0, le.adl_w_first_seen);
	self.adl_W_last_seen := if(blankOut, 0, le.adl_w_last_seen);

	SELF.chrono_sources := if(blankOut, '', le.chrono_sources);
	SELF.chrono_addrcount := if(blankOut, 0, le.chrono_addrcount);
	SELF.chrono_eqfsaddrcount := if(blankOut, false, le.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount := if(blankOut, false, le.chrono_dladdrcount);
	SELF.chrono_emaddrcount := if(blankOut, false, le.chrono_emaddrcount);

	self.chronofirst := if(blankOut, '', le.chronofirst);
	self.chronolast := if(blankOut, '', le.chronolast);
	self.chronoprim_range := if(blankOut, '', le.chronoprim_range);
	self.chronopredir := if(blankOut, '', le.chronopredir);
	self.chronoprim_name := if(blankOut, '', le.chronoprim_name);
	self.chronosuffix := if(blankOut, '', le.chronosuffix);
	self.chronopostdir := if(blankOut, '', le.chronopostdir);
	self.chronounit_desig := if(blankOut, '', le.chronounit_desig);
	self.chronosec_range := if(blankOut, '', le.chronosec_range);
	self.chronocity := if(blankOut, '', le.chronocity);
	self.chronostate := if(blankOut, '', le.chronostate);
	self.chronozip := if(blankOut, '', le.chronozip);
	self.chronozip4 := if(blankOut, '', le.chronozip4);
	self.chronocounty := if(blankOut, '', le.chronocounty);
	self.chronogeo_blk := if(blankOut, '', le.chronogeo_blk);
	self.chronodate_first := if(blankOut, 0, le.chronodate_first);
	self.chronodate_last := if(blankOut, 0, le.chronodate_last);
	self.chronoaddrscore := if(blankOut, 0, le.chronoaddrscore);
	self.rawaid1 := if(blankOut, 0, le.rawaid1);

	SELF.chrono_sources2 := if(blankOut, '', le.chrono_sources2);
	SELF.chrono_addrcount2 := if(blankOut, 0, le.chrono_addrcount2);
	SELF.chrono_eqfsaddrcount2 := if(blankOut, false, le.chrono_eqfsaddrcount2);
	SELF.chrono_dladdrcount2 := if(blankOut, false, le.chrono_dladdrcount2);
	SELF.chrono_emaddrcount2 := if(blankOut, false, le.chrono_emaddrcount2);

	self.chronofirst2 := if(blankOut, '', le.chronofirst2);
	self.chronolast2 := if(blankOut, '', le.chronolast2);
	self.chronoprim_range2 := if(blankOut, '', le.chronoprim_range2);
	self.chronopredir2 := if(blankOut, '', le.chronopredir2);
	self.chronoprim_name2 := if(blankOut, '', le.chronoprim_name2);
	self.chronosuffix2 := if(blankOut, '', le.chronosuffix2);
	self.chronopostdir2 := if(blankOut, '', le.chronopostdir2);
	self.chronounit_desig2 := if(blankOut, '', le.chronounit_desig2);
	self.chronosec_range2 := if(blankOut, '', le.chronosec_range2);
	self.chronocity2 := if(blankOut, '', le.chronocity2);
	self.chronostate2 := if(blankOut, '', le.chronostate2);
	self.chronozip2 := if(blankOut, '', le.chronozip2);
	self.chronozip4_2 := if(blankOut, '', le.chronozip4_2);
	self.chronocounty2 := if(blankOut, '', le.chronocounty2);
	self.chronogeo_blk2 := if(blankOut, '', le.chronogeo_blk2);
	self.chronodate_first2 := if(blankOut, 0, le.chronodate_first2);
	self.chronodate_last2 := if(blankOut, 0, le.chronodate_last2);
	self.chronoaddrscore2 := if(blankOut, 0, le.chronoaddrscore2);
	self.rawaid2 := if(blankOut, 0, le.rawaid2);

	SELF.chrono_sources3 := if(blankOut, '', le.chrono_sources3);
	SELF.chrono_addrcount3 := if(blankOut, 0, le.chrono_addrcount3);
	SELF.chrono_eqfsaddrcount3 := if(blankOut, false, le.chrono_eqfsaddrcount3);
	SELF.chrono_dladdrcount3 := if(blankOut, false, le.chrono_dladdrcount3);
	SELF.chrono_emaddrcount3 := if(blankOut, false, le.chrono_emaddrcount3);

	self.chronofirst3 := if(blankOut, '', le.chronofirst3);
	self.chronolast3 := if(blankOut, '', le.chronolast3);
	self.chronoprim_range3 := if(blankOut, '', le.chronoprim_range3);
	self.chronopredir3 := if(blankOut, '', le.chronopredir3);
	self.chronoprim_name3 := if(blankOut, '', le.chronoprim_name3);
	self.chronosuffix3 := if(blankOut, '', le.chronosuffix3);
	self.chronopostdir3 := if(blankOut, '', le.chronopostdir3);
	self.chronounit_desig3 := if(blankOut, '', le.chronounit_desig3);
	self.chronosec_range3 := if(blankOut, '', le.chronosec_range3);
	self.chronocity3 := if(blankOut, '', le.chronocity3);
	self.chronostate3 := if(blankOut, '', le.chronostate3);
	self.chronozip3 := if(blankOut, '', le.chronozip3);
	self.chronozip4_3 := if(blankOut, '', le.chronozip4_3);
	self.chronocounty3 := if(blankOut, '', le.chronocounty3);
	self.chronogeo_blk3 := if(blankOut, '', le.chronogeo_blk3);
	self.chronodate_first3 := if(blankOut, 0, le.chronodate_first3);
	self.chronodate_last3 := if(blankOut, 0, le.chronodate_last3);
	self.chronoaddrscore3 := if(blankOut, 0, le.chronoaddrscore3);
	self.rawaid3 := if(blankOut, 0, le.rawaid3);
	
	self.socsscore := if(blankOut, 255, le.socsscore);
	self.versocs := if(blankOut, '', le.versocs);		
	self.socsvalid := if(blankOut, '', le.socsvalid);
	
	// try recent addresses
	self.addrscore := if(blankOut, 255, le.addrscore);
	self.addrmultiple := if(blankOut, false, le.addrmultiple);
	
	self.verprim_range := if(blankOut, '', le.verprim_range);
	self.verpredir := if(blankOut, '', le.verpredir);
	self.verprim_name := if(blankOut, '', le.verprim_name);
	self.versuffix := if(blankOut, '', le.versuffix);
	self.verpostdir := if(blankOut, '', le.verpostdir);
	self.verunit_desig := if(blankOut, '', le.verunit_desig);
	self.versec_range := if(blankOut, '', le.versec_range);
	self.vercity := if(blankOut, '', le.vercity);
	self.verstate := if(blankOut, '', le.verstate);
	self.verzip := if(blankOut, '', le.verzip);
	self.vercounty := if(blankOut, '', le.vercounty);
	self.vergeo_blk := if(blankOut, '', le.vergeo_blk);
	SELF.verdate_last := if(blankOut, 0, le.verdate_last);
	SELF.verdate_first := if(blankOut, 0, le.verdate_first);
	
	self.lastscore := if(blankOut, 255, le.lastscore);
	self.verlast := if(blankOut, '', le.verlast);

	self.firstscore := if(blankOut, 255, le.firstscore);
	self.verfirst := if(blankOut, '', le.verfirst);
	
	self.dobscore := if(blankOut, 255, le.dobscore);
	self.verdob := if(blankOut, '', le.verdob);
	
	self.hphonescore := if(blankOut, 255, le.hphonescore);
	self.verhphone := if(blankOut, '', le.verhphone);
	
	self.wphonescore := if(blankOut, 255, le.wphonescore);
	self.verwphone := if(blankOut, '', le.verwphone);//ri.phone;  

	SELF.sources := if(blankOut, '', le.sources);	
	SELF.firstnamesources := if(blankOut, '', le.firstnamesources);
	SELF.lastnamesources := if(blankOut, '', le.lastnamesources);
	SELF.addrsources := if(blankOut, '', le.addrsources);
	SELF.socssources := if(blankOut, '', le.socssources);
	SELF.numsource := if(blankOut, 0, le.numsource);
	
	self.hphonesources := if(blankOut, '', le.hphonesources);
	self.wphonesources := if(blankOut, '', le.wphonesources);
	self.dobsources := if(blankOut, '', le.dobsources);
	self.cmpysources := if(blankOut, '', le.cmpysources);
	
	self.num_nonderogs := if(blankOut, 0, le.num_nonderogs);
	self.num_nonderogs30 := if(blankOut, 0, le.num_nonderogs30);
	self.num_nonderogs90 := if(blankOut, 0, le.num_nonderogs90);
	self.num_nonderogs180 := if(blankOut, 0, le.num_nonderogs180);
	self.num_nonderogs12 := if(blankOut, 0, le.num_nonderogs12);
	self.num_nonderogs24 := if(blankOut, 0, le.num_nonderogs24);
	self.num_nonderogs36 := if(blankOut, 0, le.num_nonderogs36);
	self.num_nonderogs60 := if(blankOut, 0, le.num_nonderogs60);
	
	self.iid_flags := if(blankOut, 0, le.iid_flags);
	
	// the rest of the fields that were in the iid_getHeader join that weren't blanked out
	self.ssn_from_did 	:=	if(blankOut, '', le.ssn_from_did	);
	self.ssns_per_adl 	:=	if(blankOut, 0, le.ssns_per_adl	);
	self.ssns_per_adl_created_6months 	:=	if(blankOut, 0, le.ssns_per_adl_created_6months	);
	self.ssns_per_adl_seen_18months 	:=	if(blankOut, 0, le.ssns_per_adl_seen_18months	);
	self.dobs_per_adl 	:=	if(blankOut, 0, le.dobs_per_adl	);
	self.dobs_per_adl_created_6months 	:=	if(blankOut, 0, le.dobs_per_adl_created_6months	);
	self.addr_from_did 	:=	if(blankOut, '', le.addr_from_did	);
	self.addrs_per_adl 	:=	if(blankOut, 0, le.addrs_per_adl	);
	self.addrs_per_adl_created_6months 	:=	if(blankOut, 0, le.addrs_per_adl_created_6months	);
	self.invalid_ssn_from_did 	:=	if(blankOut, '', le.invalid_ssn_from_did	);
	self.invalid_ssns_per_adl 	:=	if(blankOut, 0, le.invalid_ssns_per_adl	);
	self.invalid_ssns_per_adl_created_6months 	:=	if(blankOut, 0, le.invalid_ssns_per_adl_created_6months	);
	self.invalid_addr_from_did 	:=	if(blankOut, '', le.invalid_addr_from_did	);
	self.invalid_addrs_per_adl 	:=	if(blankOut, 0, le.invalid_addrs_per_adl	);
	self.invalid_addrs_per_adl_created_6months 	:=	if(blankOut, 0, le.invalid_addrs_per_adl_created_6months	);
	self.last_from_did 	:=	if(blankOut, '', le.last_from_did	);
	self.lnames_per_adl 	:=	if(blankOut, 0, le.lnames_per_adl	);
	self.lnames_per_adl30 	:=	if(blankOut, 0, le.lnames_per_adl30	);
	self.lnames_per_adl90 	:=	if(blankOut, 0, le.lnames_per_adl90	);
	self.lnames_per_adl180 	:=	if(blankOut, 0, le.lnames_per_adl180	);
	self.lnames_per_adl12 	:=	if(blankOut, 0, le.lnames_per_adl12	);
	self.lnames_per_adl24 	:=	if(blankOut, 0, le.lnames_per_adl24	);
	self.lnames_per_adl36 	:=	if(blankOut, 0, le.lnames_per_adl36	);
	self.lnames_per_adl60 	:=	if(blankOut, 0, le.lnames_per_adl60	);
	self.newest_lname_dt_first_seen 	:=	if(blankOut, 0, le.newest_lname_dt_first_seen	);
	self.addrs_last30 	:=	if(blankOut, 0, le.addrs_last30	);
	self.addrs_last90 	:=	if(blankOut, 0, le.addrs_last90	);
	self.addrs_last12 	:=	if(blankOut, 0, le.addrs_last12	);
	self.addrs_last24 	:=	if(blankOut, 0, le.addrs_last24	);
	self.addrs_last36 	:=	if(blankOut, 0, le.addrs_last36	);
	self.addrs_last_5years 	:=	if(blankOut, 0, le.addrs_last_5years	);
	self.addrs_last_10years 	:=	if(blankOut, 0, le.addrs_last_10years	);
	self.addrs_last_15years 	:=	if(blankOut, 0, le.addrs_last_15years	);
	self.hdr_dt_first_seen 	:=	if(blankOut, 0, le.hdr_dt_first_seen	);
	self.hdr_dt_last_seen 	:=	if(blankOut, 0, le.hdr_dt_last_seen	);
	self.dobcount2 	:=	if(blankOut, 0, le.dobcount2	);
	self.VO_count 	:=	if(blankOut, 0, le.VO_count	);
	self.EM_only_count 	:=	if(blankOut, 0, le.EM_only_count	);
	self.adl_VO_first_seen 	:=	if(blankOut, 0, le.adl_VO_first_seen	);
	self.adl_VO_last_seen 	:=	if(blankOut, 0, le.adl_VO_last_seen	);
	self.adl_EM_only_first_seen 	:=	if(blankOut, 0, le.adl_EM_only_first_seen	);
	self.adl_EM_only_last_seen 	:=	if(blankOut, 0, le.adl_EM_only_last_seen	);
	self.dl_addrs_per_adl 	:=	if(blankOut, 0, le.dl_addrs_per_adl	);
	self.vo_addrs_per_adl 	:=	if(blankOut, 0, le.vo_addrs_per_adl	);
	self.pl_addrs_per_adl 	:=	if(blankOut, 0, le.pl_addrs_per_adl	);
	self.chrono_addr_flags.dwelltype 	:=	if(blankOut, '', le.chrono_addr_flags.dwelltype	);
	self.chrono_addr_flags.valid 	:=	if(blankOut, '', le.chrono_addr_flags.valid	);
	self.chrono_addr_flags.prisonAddr 	:=	if(blankOut, '', le.chrono_addr_flags.prisonAddr	);
	self.chrono_addr_flags.highRisk 	:=	if(blankOut, '', le.chrono_addr_flags.highRisk	);
	self.chrono_addr_flags.corpMil 	:=	if(blankOut, '', le.chrono_addr_flags.corpMil	);
	self.chrono_addr_flags.doNotDeliver 	:=	if(blankOut, '', le.chrono_addr_flags.doNotDeliver	);
	self.chrono_addr_flags.deliveryStatus 	:=	if(blankOut, '', le.chrono_addr_flags.deliveryStatus	);
	self.chrono_addr_flags.addressType 	:=	if(blankOut, '', le.chrono_addr_flags.addressType	);
	self.chrono_addr_flags.dropIndicator 	:=	if(blankOut, '', le.chrono_addr_flags.dropIndicator	);
	self.citystatescore 	:=	if(blankOut, 255, le.citystatescore	);
	self.zipscore 	:=	if(blankOut, 255, le.zipscore	);
	self.em_only_sources 	:=	if(blankOut, '', le.em_only_sources	);
	self.addr_type 	:=	if(blankOut, '', le.addr_type	);
	self.dwelltype 	:=	if(blankOut, '', le.dwelltype	);
	self.addrvalflag 	:=	if(blankOut, '', le.addrvalflag	);

	// these fields are from the gong by DID join, blank them out also if the DID was blanked out
	self.phone_from_did := if(blankOut, '', le.phone_from_did);
	self.phones_per_adl := if(blankOut, 0, le.phones_per_adl);
	self.phones_per_adl_created_6months := if(blankOut, 0, le.phones_per_adl_created_6months);
	self.gong_ADL_dt_first_seen := if(blankOut, '', le.gong_adl_dt_first_seen);
  self.gong_ADL_dt_last_seen := if(blankOut, '', le.gong_adl_dt_last_seen);
		
	self := le;
end;
	
// remove the blankout logic for shell 5.0 and higher
removeVer2 := if(bsversion>=50, rollbestcount, project(rollbestcount, removeHeader(left)));	

ugRemoveVer2 := ungroup(removeVer2);	// remove the grouping by seq and did here

did_sort_roxie := map(IsInstantIDv1 and EnableEmergingID => sort(ugRemoveVer2, seq, -truedid, -if(socsvalid = 'M', 0, 1), -score, if(did=0, 281474976710655, did)), // if Emerging Identities input option is on, choose a DID that has a valid social (not manufactured) even if it has a lower ADL score	
								bsversion >= 50		 								 => sort(ugRemoveVer2, seq, -truedid, -score, if(did=0, 281474976710655, did)),  // remove the sort by socsvalid flag when not emerging identities
																											sort(ugRemoveVer2, seq, if(did=0, 281474976710655, did)) // original legacy version of sorting prior to InstantID v1
								);
did_sort_thor := map(IsInstantIDv1 and EnableEmergingID => sort(distribute(ugRemoveVer2, hash64(seq)), seq, -truedid, -if(socsvalid = 'M', 0, 1), -score, if(did=0, 281474976710655, did), local), // if Emerging Identities input option is on, choose a DID that has a valid social (not manufactured) even if it has a lower ADL score	
								bsversion >= 50		 								 => sort(distribute(ugRemoveVer2, hash64(seq)), seq, -truedid, -score, if(did=0, 281474976710655, did), local),  // remove the sort by socsvalid flag when not emerging identities
																											sort(distribute(ugRemoveVer2, hash64(seq)), seq, if(did=0, 281474976710655, did), local) // original legacy version of sorting prior to InstantID v1
								);				
								
#IF(onThor)
	did_sort := did_sort_thor;
#ELSE
	did_sort := did_sort_roxie;
#END

gRemoveVer2 := group(did_sort, seq);

 
risk_indicators.Layout_Output getMultADL(risk_indicators.Layout_Output le, integer C) := transform

// right here for multiple adl, we have up to 3 records.  populate the did2 and did3 fields
// risk_indicators.Layout_Output getMultADL(wildcard_rec le, integer C) := transform

	// self.DIDCount- The total number of DIDs found	// need to get this right after mac did append
	self.DID2 := if(c=2, le.did, le.did2);	// - The second DID returned from the DID Append
	self.DID3 := if(c=3, le.did, le.did3);	// - The third DID returned from the DID Append

	self.DID2_Sources := if(c=2, le.sources, le.did2_sources);	// - RC_Sources for DID2
	self.DID2_FNameSources := if(c=2, le.firstnamesources, le.did2_fnamesources);	// - FName_Sources for DID2
	self.DID2_LNameSources := if(c=2, le.lastnamesources, le.did2_lnamesources);	// - LName_Sources for DID2
	self.DID2_AddrSources := if(c=2, le.addrsources, le.did2_addrsources);	// - Addr_Sources for DID2
	self.DID2_SocsSources := if(c=2, le.socssources, le.did2_socssources);	// - SSN_Sources for DID2
	self.DID2_CreditFirstSeen := if(c=2, le.adl_eqfs_first_seen, le.did2_creditfirstseen);	// - Credit_First_Seen for DID2
	self.DID2_CreditLastSeen := if(c=2, le.adl_eqfs_last_seen, le.did2_creditlastseen);	// - Credit_Last_Seen for DID2
	self.DID2_HeaderFirstSeen := if(c=2, le.adl_other_first_seen, le.did2_headerfirstseen);	// - Header_First_Seen for DID2
	self.DID2_HeaderLastSeen := if(c=2, le.adl_other_last_seen, le.did2_headerlastseen);	// - Header_Last_Seen for DID2

	self.DID3_Sources := if(c=3, le.sources, le.did3_sources);	// - RC_Sources for DID3
	self.DID3_FNameSources := if(c=3, le.firstnamesources, le.did3_fnamesources);	//  FName_Sources for DID3
	self.DID3_LNameSources := if(c=3, le.lastnamesources, le.did3_lnamesources);	// - LName_Sources for DID3
	self.DID3_AddrSources := if(c=3, le.addrsources, le.did3_addrsources);	// - Addr_Sources for DID3
	self.DID3_SocsSources := if(c=3, le.socssources, le.did3_socssources);	// - SSN_Sources for DID3
	self.DID3_CreditFirstSeen := if(c=3, le.adl_eqfs_first_seen, le.did3_creditfirstseen);	//  - Credit_First_Seen for DID3
	self.DID3_CreditLastSeen := if(c=3, le.adl_eqfs_last_seen, le.did3_creditlastseen);	// - Credit_Last_Seen for DID3
	self.DID3_HeaderFirstSeen := if(c=3, le.adl_other_first_seen, le.did3_headerfirstseen);	// - Header_First_Seen for DID3
	self.DID3_HeaderLastSeen := if(c=3, le.adl_other_last_seen, le.did3_headerlastseen);	// - Header_Last_Seen for DID3

	self := le;	// keep everything else from DID 1
end;
denormRemoveVer2 := project(gRemoveVer2,getMultADL(LEFT, COUNTER));	


// rollup here to get one record
risk_indicators.Layout_Output roll_dids(risk_indicators.Layout_Output le, risk_indicators.Layout_Output ri) := transform
	d2 := le.did2<>0;
	self.DID2 := if(d2, le.did2, ri.did2);	// - The second DID returned from the DID Append
	self.DID2_Sources := if(d2, le.did2_sources, ri.did2_sources);	// - RC_Sources for DID2
	self.DID2_FNameSources := if(d2, le.did2_fnamesources, ri.did2_fnamesources);	// - FName_Sources for DID2
	self.DID2_LNameSources := if(d2, le.did2_lnamesources, ri.did2_lnamesources);	// - LName_Sources for DID2
	self.DID2_AddrSources := if(d2, le.did2_addrsources, ri.did2_addrsources);	// - Addr_Sources for DID2
	self.DID2_SocsSources := if(d2, le.did2_socssources, ri.did2_socssources);	// - SSN_Sources for DID2
	self.DID2_CreditFirstSeen := if(d2, le.did2_creditfirstseen, ri.did2_creditfirstseen);	// - Credit_First_Seen for DID2
	self.DID2_CreditLastSeen := if(d2, le.did2_creditlastseen, ri.did2_creditlastseen);	// - Credit_Last_Seen for DID2
	self.DID2_HeaderFirstSeen := if(d2, le.did2_headerfirstseen, ri.did2_headerfirstseen);	// - Header_First_Seen for DID2
	self.DID2_HeaderLastSeen := if(d2, le.did2_headerlastseen, ri.did2_headerlastseen);	// - Header_Last_Seen for DID2

	d3 := le.did3<>0;
	self.DID3 := if(d3, le.did3, ri.did3);	// - The third DID returned from the DID Appen
	self.DID3_Sources := if(d3, le.did3_sources, ri.did3_sources);	// - RC_Sources for DID3
	self.DID3_FNameSources := if(d3, le.did3_fnamesources, ri.did3_fnamesources);	//  FName_Sources for DID3
	self.DID3_LNameSources := if(d3, le.did3_lnamesources, ri.did3_lnamesources);	// - LName_Sources for DID3
	self.DID3_AddrSources := if(d3, le.did3_addrsources, ri.did3_addrsources);	// - Addr_Sources for DID3
	self.DID3_SocsSources := if(d3, le.did3_socssources, ri.did3_socssources);	// - SSN_Sources for DID3
	self.DID3_CreditFirstSeen := if(d3, le.did3_creditfirstseen, ri.did3_creditfirstseen);	//  - Credit_First_Seen for DID3
	self.DID3_CreditLastSeen := if(d3, le.did3_creditlastseen, ri.did3_creditlastseen);	// - Credit_Last_Seen for DID3
	self.DID3_HeaderFirstSeen := if(d3, le.did3_headerfirstseen, ri.did3_headerfirstseen);	// - Header_First_Seen for DID3
	self.DID3_HeaderLastSeen := if(d3, le.did3_headerlastseen, ri.did3_headerlastseen);	// - Header_Last_Seen for DID3
	
	self := le;
end;
rolled_DIDs := rollup(DenormRemoveVer2,true,roll_dids(left,right)); 

rolled_DIDs2 := if(BSversion>2, rolled_DIDs, removeVer2);
	
	
risk_indicators.layout_output figureChronology(risk_indicators.layout_output le) := TRANSFORM
	ver_in_chron := le.verprim_range+le.verprim_name IN ['', le.chronoprim_range+le.chronoprim_name,
											   le.chronoprim_range2+le.chronoprim_name2,
											   le.chronoprim_range3+le.chronoprim_name3];
												 
	SELF.chrono_sources3 := if(~ver_in_chron, le.sources, le.chrono_sources3);
	// SELF.chrono_addrcount3 := if(blankOut, 0, le.chrono_addrcount3);
	// SELF.chrono_eqfsaddrcount3 := if(blankOut, false, le.chrono_eqfsaddrcount3);
	// SELF.chrono_dladdrcount3 := if(blankOut, false, le.chrono_dladdrcount3);
	// SELF.chrono_emaddrcount3 := if(blankOut, false, le.chrono_emaddrcount3);
	
	self.chronofirst3 := IF(~ver_in_chron,le.verfirst,le.chronofirst3);
	self.chronolast3 := IF(~ver_in_chron,le.verlast,le.chronolast3);
	self.chronoprim_range3 := IF(~ver_in_chron,le.verprim_range,le.chronoprim_range3);
	self.chronopredir3 := IF(~ver_in_chron,le.verpredir,le.chronopredir3);
	self.chronoprim_name3 := IF(~ver_in_chron,le.verprim_name,le.chronoprim_name3);
	self.chronosuffix3 := IF(~ver_in_chron,le.versuffix,le.chronosuffix3);
	self.chronopostdir3 := IF(~ver_in_chron,le.verpostdir,le.chronopostdir3);
	self.chronounit_desig3 := IF(~ver_in_chron,le.verunit_desig,le.chronounit_desig3);
	self.chronosec_range3 := IF(~ver_in_chron,le.versec_range,le.chronosec_range3);

	self.chronocity3 := IF(~ver_in_chron,le.vercity,le.chronocity3);
	self.chronostate3 := IF(~ver_in_chron,le.verstate,le.chronostate3);
	self.chronozip3 := IF(~ver_in_chron,le.verzip[1..5],le.chronozip3);
	self.chronozip4_3 := IF(~ver_in_chron,le.verzip[6..9],le.chronozip4_3);
	self.chronocounty3 := IF(~ver_in_chron,le.vercounty,le.chronocounty3);
	self.chronogeo_blk3 := IF(~ver_in_chron,le.vergeo_blk,le.chronogeo_blk3);
	self.chronodate_first3 := if(~ver_in_chron, le.verdate_first, le.chronodate_first3);
	self.chronodate_last3 := IF(~ver_in_chron,le.verdate_last,le.chronodate_last3);
	self.chronoaddrscore3 := IF(~ver_in_chron,le.addrscore,le.chronoaddrscore3);
	
	
	input_in_chron := length(trim(le.prim_range)+trim(le.prim_name)) > 0 AND 
												 le.prim_range+le.prim_name IN [le.chronoprim_range+le.chronoprim_name,
											   le.chronoprim_range2+le.chronoprim_name2,
											   le.chronoprim_range3+le.chronoprim_name3,
											   le.verprim_range+le.verprim_name];
	input_most_recent := le.prim_range+le.prim_name = le.chronoprim_range+le.chronoprim_name;
	self.inputAddrNotMostRecent := input_in_chron and ~input_most_recent;
	SELF := le;
END;

commonstart := PROJECT(rolled_DIDs2, figureChronology(LEFT));



// start of shell 4.0 calculations
nas_rec := record
	risk_indicators.layout_output;
	integer1 record_level_nas;
end;


// compute the NAS level for each record
with_record_nas := project(gh,
										transform(nas_rec,
											self.record_level_nas := map(left.firstcount=0 and left.lastcount=0 and left.addrcount=0 and left.socscount>0 => 1,
							left.firstcount>0 and left.lastcount>0 and left.addrcount=0 and left.socscount=0 => 2,
							left.firstcount>0 and left.lastcount=0 and left.addrcount>0 and left.socscount=0 => 3,
							left.firstcount>0 and left.lastcount=0 and left.addrcount=0 and left.socscount>0 => 4,
							left.firstcount=0 and left.lastcount>0 and left.addrcount>0 and left.socscount=0 => 5,
							left.firstcount=0 and left.lastcount=0 and left.addrcount>0 and left.socscount>0 => 6,
							left.firstcount=0 and left.lastcount>0 and left.addrcount=0 and left.socscount>0 => 7,
							left.firstcount>0 and left.lastcount>0 and left.addrcount>0 and left.socscount=0 => 8,
							left.firstcount>0 and left.lastcount>0 and left.addrcount=0 and left.socscount>0 => 9,
							left.firstcount>0 and left.lastcount=0 and left.addrcount>0 and left.socscount>0 => 10,
							left.firstcount=0 and left.lastcount>0 and left.addrcount>0 and left.socscount>0 => 11,
							left.firstcount>0 and left.lastcount>0 and left.addrcount>0 and left.socscount>0 => 12,
							left.did=0 and left.ssnexists and left.pullidflag='' => 1,  // no did but hit on social and not on pullid file
							0),
							self.src := TRIM(left.chrono_sources[1..2]);  // use the source list which has E1, E2, E3, E4 broken out instead of all in EM bucket
							self := left; ));
					

// dates based on hdr_dt_first_seen	and hdr_last_seen dates, not including vendor dates here at all
source_stats := table(with_record_nas, {seq, did, src,
											nas_per_source := max(group, record_level_nas),
											records_per_source := count(group),
											first_seen_at_source := min(group, if(hdr_dt_first_seen=0, 999999, hdr_dt_first_seen)),
											max_first_seen_at_source := max(group, hdr_dt_first_seen),
											last_seen_at_source := max(group, hdr_dt_last_seen),

											fname_matched_records := count(group, firstcount>0),
											lname_matched_records := count(group, lastcount>0),
											addr_matched_records := count(group, addrcount>0),
											ssn_matched_records := count(group, socscount>0),
											dob_matched_records := count(group, dobcount2>0),
											fla_matched_records := count(group, firstcount>0 and lastcount>0 and addrcount>0),
											flas_matched_records := count(group, firstcount>0 and lastcount>0 and addrcount>0 and socscount>0),

											fname_first_seen := min(group, if(hdr_dt_first_seen<>0 and firstcount>0, hdr_dt_first_seen, 999999)),
											lname_first_seen := min(group, if(hdr_dt_first_seen<>0 and lastcount>0, hdr_dt_first_seen, 999999)),
											address_first_seen  := min(group, if(hdr_dt_first_seen<>0 and addrcount>0, hdr_dt_first_seen, 999999)),
											ssn_first_seen  := min(group, if(hdr_dt_first_seen<>0 and socscount>0, hdr_dt_first_seen, 999999)),
											dateofbirth_first_seen  := min(group, if(hdr_dt_first_seen<>0 and dobcount2>0, hdr_dt_first_seen, 999999)), 
											fla_first_seen  := min(group, if(hdr_dt_first_seen<>0 and firstcount>0 and lastcount>0 and addrcount>0, hdr_dt_first_seen, 999999)), 
											flas_first_seen  := min(group, if(hdr_dt_first_seen<>0 and firstcount>0 and lastcount>0 and addrcount>0 and socscount>0, hdr_dt_first_seen, 999999)), 																					

											fname_last_seen := max(group, if(firstcount>0,hdr_dt_last_seen, 0)),
											lname_last_seen := max(group, if(lastcount>0,hdr_dt_last_seen,0)),
											address_last_seen  := max(group, if(addrcount>0,hdr_dt_last_seen,0)),
											ssn_last_seen  := max(group, if(socscount>0,hdr_dt_last_seen,0)),
											dateofbirth_last_seen  := max(group, if(dobcount2>0,hdr_dt_last_seen,0)), 
											fla_last_seen  := max(group, if(firstcount>0 and lastcount>0 and addrcount>0,hdr_dt_last_seen,0)), 
											flas_last_seen  := max(group, if(firstcount>0 and lastcount>0 and addrcount>0 and socscount>0,hdr_dt_last_seen,0)) 
																		
											}, seq, did, src);


temp_rec := record
	UNSIGNED4 seq;
	unsigned6 did;
	string100 ver_sources := '';
	string100 ver_sources_NAS := '';
	string200 ver_sources_first_seen_date := '';
	string200 ver_sources_max_first_seen_date := '';
	string200 ver_sources_last_seen_date := '';
	string100 ver_sources_recordcount := '';
	
	string100 ver_fname_sources := '';
	string200 ver_fname_sources_first_seen_date := '';
	string100 ver_fname_sources_recordcount := '';
	
	string100 ver_lname_sources := '';
	string200 ver_lname_sources_first_seen_date := '';
	string100 ver_lname_sources_recordcount := '';
	
	string100 ver_addr_sources := '';
	string200 ver_addr_sources_first_seen_date := '';
	string100 ver_addr_sources_recordcount := '';
	
	string100 ver_ssn_sources := '';
	string200 ver_ssn_sources_first_seen_date := '';
	string100 ver_ssn_sources_recordcount := '';
		
	string100 ver_dob_sources := '';
	string200 ver_dob_sources_first_seen_date := '';
	string100 ver_dob_sources_recordcount := '';
		
end;

grp_source_stats_roxie := group(sort(source_stats, seq, did, first_seen_at_source, src), seq, did);

grp_source_stats_thor := group(sort(distribute(source_stats, hash64(seq, did)), seq, did, first_seen_at_source, src, local), seq, did, local);

#IF(onThor)
	grp_source_stats := grp_source_stats_thor;
#ELSE
	grp_source_stats := grp_source_stats_roxie;
#END

tf_source_stats := project(grp_source_stats,
						transform(temp_rec,
							fblank := left.fname_matched_records=0;						
							lblank := left.lname_matched_records=0;
							ablank := left.addr_matched_records=0;
							sblank := left.ssn_matched_records=0;
							dblank := left.dob_matched_records=0;
							vblank := (left.did=0 or (fblank and lblank and ablank and sblank and dblank)) and ~RetainInputDID;
							
							self.ver_sources := if(vblank,'',left.src + ',');
							self.ver_sources_NAS := if(vblank,'',(string)left.nas_per_source + ',');
							self.ver_sources_first_seen_date := if(vblank,'',if(left.first_seen_at_source=999999, '0', (string)left.first_seen_at_source) + ',');
							self.ver_sources_max_first_seen_date := if(vblank,'',(string)left.max_first_seen_at_source + ',');
							self.ver_sources_last_seen_date := if(vblank,'',(string)left.last_seen_at_source + ',');
							self.ver_sources_recordcount := if(vblank,'',(string)left.records_per_source + ',');
							
							self.ver_fname_sources := if(fblank, '', left.src + ',');
							self.ver_fname_sources_first_seen_date := if(fblank,'',if(left.fname_first_seen=999999, '0', (string)left.fname_first_seen) + ',');
							self.ver_fname_sources_recordcount := if(fblank,'',(string)left.fname_matched_records + ',');
							
							self.ver_lname_sources := if(lblank, '', left.src + ',');
							self.ver_lname_sources_first_seen_date := if(lblank, '',if(left.lname_first_seen=999999, '0', (string)left.lname_first_seen) + ',');
							self.ver_lname_sources_recordcount := if(lblank, '',(string)left.lname_matched_records + ',');
							
							self.ver_addr_sources := if(ablank,'', left.src + ',');
							self.ver_addr_sources_first_seen_date := if(ablank,'',if(left.address_first_seen=999999, '0', (string)left.address_first_seen) + ',');
							self.ver_addr_sources_recordcount := if(ablank,'',(string)left.addr_matched_records + ',');
							
							self.ver_ssn_sources := if(sblank,'', left.src + ',');
							self.ver_ssn_sources_first_seen_date := if(sblank,'', if(left.ssn_first_seen=999999, '0', (string)left.ssn_first_seen) + ',');
							self.ver_ssn_sources_recordcount := if(sblank,'', (string)left.ssn_matched_records + ',');							
							
							self.ver_dob_sources := if(dblank, '', left.src + ',');
							self.ver_dob_sources_first_seen_date := if(dblank, '',if(left.dateofbirth_first_seen=999999, '0', (string)left.dateofbirth_first_seen) + ',');
							self.ver_dob_sources_recordcount := if(dblank, '',(string)left.dob_matched_records + ',');
							
							self := left));					
							
temp_rec roll_source_stats(temp_rec le, temp_rec rt) := transform
	self.ver_sources := trim(le.ver_sources) + rt.ver_sources +',';
	self.ver_sources_nas := trim(le.ver_sources_nas) + rt.ver_sources_nas +',';
	self.ver_sources_max_first_seen_date := trim(le.ver_sources_max_first_seen_date) + rt.ver_sources_max_first_seen_date + ',';
	self.ver_sources_first_seen_date := trim(le.ver_sources_first_seen_date) + rt.ver_sources_first_seen_date + ',';
	self.ver_sources_last_seen_date := trim(le.ver_sources_last_seen_date) + rt.ver_sources_last_seen_date + ',';
	self.ver_sources_recordcount := trim(le.ver_sources_recordcount) + rt.ver_sources_recordcount + ',';

	self.ver_fname_sources := trim(le.ver_fname_sources) + rt.ver_fname_sources + ',';
	self.ver_fname_sources_first_seen_date := trim(le.ver_fname_sources_first_seen_date) + if(rt.ver_fname_sources='', '', rt.ver_fname_sources_first_seen_date + ',');
	self.ver_fname_sources_recordcount := trim(le.ver_fname_sources_recordcount) + if(rt.ver_fname_sources='', '', rt.ver_fname_sources_recordcount + ',');	

	self.ver_lname_sources := trim(le.ver_lname_sources) + rt.ver_lname_sources + ',';
	self.ver_lname_sources_first_seen_date := trim(le.ver_lname_sources_first_seen_date) + if(rt.ver_lname_sources='', '', rt.ver_lname_sources_first_seen_date + ',');
	self.ver_lname_sources_recordcount := trim(le.ver_lname_sources_recordcount) + if(rt.ver_lname_sources='', '', rt.ver_lname_sources_recordcount + ',');	

	self.ver_addr_sources := trim(le.ver_addr_sources) + rt.ver_addr_sources +',';
	self.ver_addr_sources_first_seen_date := trim(le.ver_addr_sources_first_seen_date) + if(rt.ver_addr_sources='', '', rt.ver_addr_sources_first_seen_date + ',');
	self.ver_addr_sources_recordcount := trim(le.ver_addr_sources_recordcount) + if(rt.ver_addr_sources='', '', rt.ver_addr_sources_recordcount + ',');	

	self.ver_ssn_sources := trim(le.ver_ssn_sources) + rt.ver_ssn_sources +',';
	self.ver_ssn_sources_first_seen_date := trim(le.ver_ssn_sources_first_seen_date) + if(rt.ver_ssn_sources='', '', rt.ver_ssn_sources_first_seen_date + ',');
	self.ver_ssn_sources_recordcount := trim(le.ver_ssn_sources_recordcount) + if(rt.ver_ssn_sources='', '', rt.ver_ssn_sources_recordcount + ',');						

	self.ver_dob_sources := trim(le.ver_dob_sources) + rt.ver_dob_sources +',';
	self.ver_dob_sources_first_seen_date := trim(le.ver_dob_sources_first_seen_date) + if(rt.ver_dob_sources='', '', rt.ver_dob_sources_first_seen_date + ',');
	self.ver_dob_sources_recordcount := trim(le.ver_dob_sources_recordcount) + if(rt.ver_dob_sources='', '', rt.ver_dob_sources_recordcount + ',');	
	
	self := rt;
end;

					
rolled_source_stats := rollup(tf_source_stats, true, roll_source_stats(left,right));
with_source_stats := join(commonstart, rolled_source_stats, left.seq=right.seq and left.did=right.did, 
												transform(risk_indicators.layout_output, 
																		self.header_summary := right,				
																		self := left), left outer);  // needed to add left outer here because the did coming in can be blanked out in removeHeader transform above

rolled_header := if(bsVersion>3, group(with_source_stats, seq), commonstart);

// num_nonderog buckets are now by category instead of the raw source.  max count will be 6 for nonderogs now
// header_summary.ver_sources up to this table contains the non_derog_category from iid_get_header
non_derog_stats := table(with_record_nas((integer)header_summary.ver_sources<>0), {seq, did, header_summary.ver_sources,																		
											_num_nonderogs := count(group, num_nonderogs>0),
											_num_nonderogs30 := count(group, num_nonderogs30>0),
											_num_nonderogs90 := count(group, num_nonderogs90>0),
											_num_nonderogs180 := count(group, num_nonderogs180>0),
											_num_nonderogs12 := count(group, num_nonderogs12>0),
											_num_nonderogs24 := count(group, num_nonderogs24>0),
											_num_nonderogs36 := count(group, num_nonderogs36>0),
											_num_nonderogs60 := count(group, num_nonderogs60>0),
											}, seq, did, header_summary.ver_sources);
											
nonderog_counts := table(non_derog_stats, {seq, did, 
	num_nonderogs := count(group, _num_nonderogs>0),
	num_nonderogs30 := count(group, _num_nonderogs30>0),
	num_nonderogs90 := count(group, _num_nonderogs90>0),
	num_nonderogs180 := count(group, _num_nonderogs180>0),
	num_nonderogs12 := count(group, _num_nonderogs12>0),
	num_nonderogs24 := count(group, _num_nonderogs24>0),
	num_nonderogs36 := count(group, _num_nonderogs36>0),
	num_nonderogs60 := count(group, _num_nonderogs60>0),
	}, seq, did);
	
rolled_header_with_fixed_nonderogs := join(rolled_header, nonderog_counts, 
	left.seq=right.seq and left.did=right.did and 
	left.num_nonderogs<>0, // don't add back nonderogs to any records which may have been blanked out
	transform(risk_indicators.layout_output,
		self.num_nonderogs := right.num_nonderogs;
		self.num_nonderogs30 := right.num_nonderogs30;
		self.num_nonderogs90 := right.num_nonderogs90;
		self.num_nonderogs180 := right.num_nonderogs180;
		self.num_nonderogs12 := right.num_nonderogs12;
		self.num_nonderogs24 := right.num_nonderogs24;
		self.num_nonderogs36 := right.num_nonderogs36;
		self.num_nonderogs60 := right.num_nonderogs60;
		self := left), left outer, keep(1));
	
// output(removeVer2, named('removeVer2'));
// output(DenormRemoveVer2, named('DenormRemoveVer2'));
// output(rolled_DIDs, named('rolled_DIDs'));
// output(rolled_DIDs2, named('rolled_DIDs2'));
// output(commonstart, named('commonstart'));
// output(gh, named('ROLL_gh'));	**
// output(with_record_nas, named('with_record_nas'));
// output(source_stats, named('source_stats'));	
// output(non_derog_stats, named('non_derog_stats'));	

// output(grp_source_stats, named('grp_source_stats'));				
// output(tf_source_stats, named('tf_source_stats'));	
// output(rolled_source_stats, named('rolled_source_stats'));
// output(with_source_stats, named('with_source_stats'));	
					
// output(choosen(sortedBest, 10), named('sortedBest'));						
// output(sortedBest_original, named('ROLL_sortedBest_original'));		//ZZZ			
// output(address_hierarchy_sort, named('ROLL_address_hierarchy_sort'));		//ZZZ			
// output(sortedBest, named('ROLL_sortedBest'));		//ZZZ			
// output(rollbestcount, named('ROLL_rollbestcount'));		//ZZZ
// output(rolled_header, named('ROLL_rolled_header'));	//ZZZ
// output(nonderog_counts, named('nonderog_counts'));		
// output(ugRemoveVer2, named('ugRemoveVer2'));
// output(ugRemoveVer2_rolled, named('ugRemoveVer2_rolled'));
// output(ugRemoveVer2_valid_ssn, named('ugRemoveVer2_valid_ssn'));
// output(wildcard_dids, named('wildcard_dids'));
// output(wildcard_dids_best, named('wildcard_dids_best'));
// output(ugRemoveVer2_wildcard, named('ugRemoveVer2_wildcard'));
// output(gRemoveVer2notEI, named('gRemoveVer2notEI'));
// output(gRemoveVer2EI, named('gRemoveVer2EI'));
// output(gRemoveVer2, named('gRemoveVer2'));
// output(rolled_header_with_fixed_nonderogs, named('ROLL_rolled_header_with_fixed_nonderogs')); //ZZZ
return if(bsversion>=50, group(rolled_header_with_fixed_nonderogs, seq), rolled_header);

end;