import risk_indicators, ut;

export iid_roll_header5(grouped DATASET(risk_indicators.Layout_Output) all_head, boolean suppressNearDups=false,
											 unsigned1 BSversion) := function

betterAddresses := risk_indicators.Grade_Addresses_Function(all_head);

all_header := project(all_head,AMEX.layouts.shell_with5);

noNearDups := JOIN(all_header, betterAddresses,
												LEFT.seq = RIGHT.indata.seq 
												AND LEFT.chronoprim_range=RIGHT.prim_range
												AND LEFT.chronoprim_name=RIGHT.prim_name 
												AND LEFT.chronosec_range=RIGHT.sec_range
												AND LEFT.chronozip = RIGHT.zip,
												TRANSFORM(AMEX.layouts.shell_with5, SELF := LEFT), LOOKUP);

header_addresses := IF(suppressNearDups, noNearDups, all_header); 


// FOR MULTIPLE ADLS, UNGROUP AND THEN REGROUP BY SEQ AND DID
ug := ungroup(header_addresses);
gh := group(sort(ug, seq,did), seq, did);
	
	
sortedBest := sort(gh, seq, did, -dt_last_seen, -chronodate_first, chronolast, chronofirst, 
		// added more fields to sort by to make code deterministic when picking between EQ record and EQ(QH) record with same dates, but different address and ssn_valid results
		-socsvalid, -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, -chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate);
		
		
AMEX.layouts.shell_with5 countadd(AMEX.layouts.shell_with5 l,AMEX.layouts.shell_with5 r) := transform
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
	SELF.adl_eqfs_last_seen := ut.max2(l.adl_eqfs_last_seen,r.adl_eqfs_last_seen);
	
	SELF.adl_en_first_seen := ut.Min2(l.adl_en_first_seen,r.adl_en_first_seen);
	SELF.adl_en_last_seen := ut.max2(l.adl_en_last_seen,r.adl_en_last_seen);
	
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
	self.adl_TU_last_seen := ut.Max2(l.adl_tu_last_seen, r.adl_tu_last_seen);
	self.adl_DL_first_seen := ut.Min2(l.adl_dl_first_seen, r.adl_dl_first_seen);
	self.adl_DL_last_seen := ut.Max2(l.adl_dl_last_seen, r.adl_dl_last_seen);
	self.adl_PR_first_seen := ut.Min2(l.adl_pr_first_seen, r.adl_pr_first_seen);
	self.adl_PR_last_seen := ut.Max2(l.adl_pr_last_seen, r.adl_pr_last_seen);
	self.adl_V_first_seen := ut.Min2(l.adl_v_first_seen, r.adl_v_first_seen);
	self.adl_V_last_seen := ut.Max2(l.adl_v_last_seen, r.adl_v_last_seen);
	self.adl_EM_first_seen := ut.Min2(l.adl_em_first_seen, r.adl_em_first_seen);
	self.adl_EM_last_seen := ut.Max2(l.adl_em_last_seen, r.adl_em_last_seen);
	self.adl_W_first_seen := ut.Min2(l.adl_w_first_seen, r.adl_w_first_seen);
	self.adl_W_last_seen := ut.Max2(l.adl_w_last_seen, r.adl_w_last_seen);
	self.adl_VO_first_seen := ut.Max2(l.adl_vo_first_seen, r.adl_vo_first_seen);
	self.adl_VO_last_seen := ut.Max2(l.adl_vo_last_seen, r.adl_vo_last_seen);
	self.adl_EM_only_first_seen := ut.Max2(l.adl_em_only_first_seen, r.adl_em_only_first_seen);
	self.adl_EM_only_last_seen := ut.Max2(l.adl_em_only_last_seen, r.adl_em_only_last_seen);
	
	SELF.adl_other_first_seen := ut.Min2(l.adl_other_first_seen,r.adl_other_first_seen);
	SELF.adl_other_last_seen := ut.max2(l.adl_other_last_seen,r.adl_other_last_seen);
	
	howmany := MAP(l.chronoprim_name=''  OR (l.chronoprim_name= r.chronoprim_name and l.chronoprim_range= r.chronoprim_range and l.chronozip= r.chronozip) => 1,
								 l.chronoprim_name2='' OR (l.chronoprim_name2=r.chronoprim_name and l.chronoprim_range2=r.chronoprim_range and l.chronozip2=r.chronozip) => 2,
								 l.chronoprim_name3='' OR (l.chronoprim_name3=r.chronoprim_name and l.chronoprim_range3=r.chronoprim_range and l.chronozip3=r.chronozip) => 3,
								 l.chronoprim_name4='' OR (l.chronoprim_name4=r.chronoprim_name and l.chronoprim_range4=r.chronoprim_range and l.chronozip54=r.chronozip) => 4,
								 l.chronoprim_name5='' OR (l.chronoprim_name5=r.chronoprim_name and l.chronoprim_range5=r.chronoprim_range and l.chronozip5=r.chronozip) => 5,
								 6);

	// chronology that keeps track of which sources
	chrono_source_seen := IF(howmany=1,r.src='XX' OR Stringlib.StringFind(l.chrono_sources,trim(r.CHRONO_SOURCES),1)>0,false);
	SELF.chrono_sources := IF(howmany<>1 OR chrono_source_seen, l.chrono_sources, TRIM(l.chrono_sources)+r.CHRONO_SOURCES);
	SELF.chrono_addrcount := IF(howmany<>1 OR chrono_source_seen,l.chrono_addrcount,l.chrono_addrcount+1);
	SELF.chrono_eqfsaddrcount := IF(howmany<>1,l.chrono_eqfsaddrcount,l.chrono_eqfsaddrcount OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount := IF(howmany<>1,l.chrono_dladdrcount,l.chrono_dladdrcount OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount := IF(howmany<>1,l.chrono_emaddrcount,l.chrono_emaddrcount OR r.chrono_emaddrcount);

	self.chronofirst := IF(howmany=1,r.chronofirst,l.chronofirst);
	self.chronolast := IF(howmany=1,r.chronolast,l.chronolast);
	self.chronoprim_range := IF(howmany=1,r.chronoprim_range,l.chronoprim_range);
	self.chronopredir := IF(howmany=1,r.chronopredir,l.chronopredir);
	self.chronoprim_name := IF(howmany=1,r.chronoprim_name,l.chronoprim_name);
	self.chronosuffix := IF(howmany=1,r.chronosuffix,l.chronosuffix);
	self.chronopostdir := IF(howmany=1,r.chronopostdir,l.chronopostdir);
	self.chronounit_desig := IF(howmany=1,r.chronounit_desig,l.chronounit_desig);
	self.chronosec_range := IF(howmany=1,r.chronosec_range,l.chronosec_range);
	self.chronocity := IF(howmany=1,r.chronocity,l.chronocity);
	self.chronostate := IF(howmany=1,r.chronostate,l.chronostate);
	self.chronozip := IF(howmany=1,r.chronozip,l.chronozip);
	self.chronozip4 := IF(howmany=1,r.chronozip4,l.chronozip4);
	self.chronocounty := IF(howmany=1,r.chronocounty,l.chronocounty);
	self.chronogeo_blk := IF(howmany=1,r.chronogeo_blk,l.chronogeo_blk);
	self.chronodate_first := IF(howmany=1,ut.Min2(l.chronodate_first,r.chronodate_first),l.chronodate_first);
	self.chronodate_last := IF(howmany=1,ut.Max2(l.chronodate_last,r.chronodate_last),l.chronodate_last);
	self.chronoaddrscore := IF(howmany=1,r.chronoaddrscore,l.chronoaddrscore);

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
	self.chronodate_last2 := IF(howmany=2,ut.Max2(l.chronodate_last2,r.chronodate_last),l.chronodate_last2);
	self.chronoaddrscore2 := IF(howmany=2,r.chronoaddrscore,l.chronoaddrscore2);

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
	self.chronodate_last3 := IF(howmany=3,ut.Max2(l.chronodate_last3,r.chronodate_last),l.chronodate_last3);
	self.chronoaddrscore3 := IF(howmany=3,r.chronoaddrscore,l.chronoaddrscore3);

// addition of chrono 4 and 5
  chrono_source_seen4 := IF(howmany=4,r.src='XX' OR Stringlib.StringFind(l.chrono_sources4,trim(r.chrono_sources),1)>0,false);
	SELF.chrono_sources4 := IF(howmany<>4 OR chrono_source_seen4, l.chrono_sources4, TRIM(l.chrono_sources4)+r.chrono_sources);
	SELF.chrono_addrcount4 := IF(howmany<>4 OR chrono_source_seen4,l.chrono_addrcount4,l.chrono_addrcount4+1);
	SELF.chrono_eqfsaddrcount4 := IF(howmany<>4,l.chrono_eqfsaddrcount4,l.chrono_eqfsaddrcount4 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount4 := IF(howmany<>4,l.chrono_dladdrcount4,l.chrono_dladdrcount4 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount4 := IF(howmany<>4,l.chrono_emaddrcount4,l.chrono_emaddrcount4 OR r.chrono_emaddrcount);

	self.chronofirst4 := IF(howmany=4,r.chronofirst,l.chronofirst4);
	self.chronolast4 := IF(howmany=4,r.chronolast,l.chronolast4);
	self.chronoprim_range4 := IF(howmany=4,r.chronoprim_range,l.chronoprim_range4);
	self.chronopredir4 := IF(howmany=4,r.chronopredir,l.chronopredir4);
	self.chronoprim_name4 := IF(howmany=4,r.chronoprim_name,l.chronoprim_name4);
	self.chronosuffix4 := IF(howmany=4,r.chronosuffix,l.chronosuffix4);
	self.chronopostdir4 := IF(howmany=4,r.chronopostdir,l.chronopostdir4);
	self.chronounit_desig4 := IF(howmany=4,r.chronounit_desig,l.chronounit_desig4);
	self.chronosec_range4 := IF(howmany=4,r.chronosec_range,l.chronosec_range4);
	self.chronocity4 := IF(howmany=4,r.chronocity,l.chronocity4);
	self.chronostate4 := IF(howmany=4,r.chronostate,l.chronostate4);
	self.chronozip54 := IF(howmany=4,r.chronozip,l.chronozip54);
	self.chronozip4_4 := IF(howmany=4,r.chronozip4,l.chronozip4_4);
	self.chronocounty4 := IF(howmany=4,r.chronocounty,l.chronocounty4);
	self.chronogeo_blk4 := IF(howmany=4,r.chronogeo_blk,l.chronogeo_blk4);
	self.chronodate_first4 := IF(howmany=4,ut.Min2(l.chronodate_first4,r.chronodate_first),l.chronodate_first4);
	self.chronodate_last4 := IF(howmany=4,ut.Max2(l.chronodate_last4,r.chronodate_last),l.chronodate_last4);
	self.chronoaddrscore4 := IF(howmany=4,r.chronoaddrscore,l.chronoaddrscore4);

  chrono_source_seen5 := IF(howmany=5,r.src='XX' OR Stringlib.StringFind(l.chrono_sources5,trim(r.chrono_sources),1)>0,false);
	SELF.chrono_sources5 := IF(howmany<>5 OR chrono_source_seen5, l.chrono_sources5, TRIM(l.chrono_sources5)+r.chrono_sources);
	SELF.chrono_addrcount5 := IF(howmany<>5 OR chrono_source_seen5,l.chrono_addrcount5,l.chrono_addrcount5+1);
	SELF.chrono_eqfsaddrcount5 := IF(howmany<>5,l.chrono_eqfsaddrcount5,l.chrono_eqfsaddrcount5 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount5 := IF(howmany<>5,l.chrono_dladdrcount5,l.chrono_dladdrcount5 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount5 := IF(howmany<>5,l.chrono_emaddrcount5,l.chrono_emaddrcount5 OR r.chrono_emaddrcount);

	self.chronofirst5 := IF(howmany=5,r.chronofirst,l.chronofirst5);
	self.chronolast5 := IF(howmany=5,r.chronolast,l.chronolast5);
	self.chronoprim_range5 := IF(howmany=5,r.chronoprim_range,l.chronoprim_range5);
	self.chronopredir5 := IF(howmany=5,r.chronopredir,l.chronopredir5);
	self.chronoprim_name5 := IF(howmany=5,r.chronoprim_name,l.chronoprim_name5);
	self.chronosuffix5 := IF(howmany=5,r.chronosuffix,l.chronosuffix5);
	self.chronopostdir5 := IF(howmany=5,r.chronopostdir,l.chronopostdir5);
	self.chronounit_desig5 := IF(howmany=5,r.chronounit_desig,l.chronounit_desig5);
	self.chronosec_range5 := IF(howmany=5,r.chronosec_range,l.chronosec_range5);
	self.chronocity5 := IF(howmany=5,r.chronocity,l.chronocity5);
	self.chronostate5 := IF(howmany=5,r.chronostate,l.chronostate5);
	self.chronozip5 := IF(howmany=5,r.chronozip,l.chronozip5);
	self.chronozip4_5 := IF(howmany=5,r.chronozip4,l.chronozip4_5);
	self.chronocounty5 := IF(howmany=5,r.chronocounty,l.chronocounty5);
	self.chronogeo_blk5 := IF(howmany=5,r.chronogeo_blk,l.chronogeo_blk5);
	self.chronodate_first5 := IF(howmany=5,ut.Min2(l.chronodate_first5,r.chronodate_first),l.chronodate_first5);
	self.chronodate_last5 := IF(howmany=5,ut.Max2(l.chronodate_last5,r.chronodate_last),l.chronodate_last5);
	self.chronoaddrscore5 := IF(howmany=5,r.chronoaddrscore,l.chronoaddrscore5);
// ==========================

	ssn_by_score := Risk_Indicators.iid_constants.tscore(l.socsscore)>=Risk_Indicators.iid_constants.tscore(r.socsscore);

	// ssn_lpicker := MAP(l.socsvalid='G' AND r.socsvalid='G' => ssn_by_score,
					// l.socsvalid='G' AND ~(l.header_footprint < 4)		=> true,
					// r.socsvalid='G' AND ~(l.header_footprint < 4)	=> false,
					// ssn_by_score);
	
	self.versocs := IF(ssn_by_score,l.versocs,r.versocs);
	self.socsscore := IF(ssn_by_score,l.socsscore,r.socsscore);
	self.socsvalid := IF(ssn_by_score,l.socsvalid,r.socsvalid);
	self.ssn := if(length(trim(l.ssn)) = 4 and length(trim(r.ssn)) = 9, r.ssn, l.ssn);
	
	
	addr_lpicker := Risk_Indicators.iid_constants.tscore(l.addrscore)>=Risk_Indicators.iid_constants.tscore(r.addrscore) or (l.verprim_name<>'' and r.addrcount=0);
	
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
	
	self.addrscore := IF(addr_lpicker,l.addrscore,r.addrscore);
	
	self.addrmultiple := l.prim_name<>'' AND r.prim_name<>'';
	
	self.verlast := IF(Risk_Indicators.iid_constants.tscore(l.lastscore)>=Risk_Indicators.iid_constants.tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.verlast,r.verlast);
	self.lastscore := IF(Risk_Indicators.iid_constants.tscore(l.lastscore)>=Risk_Indicators.iid_constants.tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.lastscore,r.lastscore);
	
	self.verfirst := IF(Risk_Indicators.iid_constants.tscore(l.firstscore)>=Risk_Indicators.iid_constants.tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.verfirst,r.verfirst);
	self.firstscore := IF(Risk_Indicators.iid_constants.tscore(l.firstscore)>=Risk_Indicators.iid_constants.tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.firstscore,r.firstscore);
	
	take_left_dob := Map( (l.dobscore = 90 and r.dobscore = 95 and (integer)l.verdob<>0) => true, /* dobscore 90=miskey - Return 90 when presented with choice of 90 or 95 */
											  (l.dobscore = 95 and r.dobscore = 90 and (integer)r.verdob<>0) => false,
												(Risk_Indicators.iid_constants.tscore(l.dobscore)>=Risk_Indicators.iid_constants.tscore(r.dobscore) and (integer)l.verdob<>0) => true,
												((integer)l.verdob<>0 and r.dobcount=0) => true,
												false );												
	self.verdob := IF(take_left_dob,l.verdob,r.verdob);	
	self.dobscore := if(take_left_dob,l.dobscore,r.dobscore);
												
	self.verhphone := IF(Risk_Indicators.iid_constants.tscore(l.hphonescore)>=Risk_Indicators.iid_constants.tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.verhphone,r.verhphone);
	self.hphonescore := IF(Risk_Indicators.iid_constants.tscore(l.hphonescore)>=Risk_Indicators.iid_constants.tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.hphonescore,r.hphonescore);
	
	self.verwphone := IF(Risk_Indicators.iid_constants.tscore(l.wphonescore)>=Risk_Indicators.iid_constants.tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.verwphone,r.verwphone);
	self.wphonescore := IF(Risk_Indicators.iid_constants.tscore(l.wphonescore)>=Risk_Indicators.iid_constants.tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.wphonescore,r.wphonescore);
	
	self.verdate_first := ut.Min2(l.verdate_first,r.verdate_first);
	
	self.isPrison := l.isPrison or r.isPrison;
	self.prisonFSdate := ut.Min2(l.prisonFSdate, r.prisonFSdate);	// take the earliest non 0 date
	
	self := l;
END;


rollbestcount := rollup(sortedbest,countadd(left,right), seq, did);	// rollup by seq and did, for when using multiple did for boca shell 3

// check to see if correction record or only 1 element verified then revert back to no DID found
AMEX.layouts.shell_with5 removeHeader(AMEX.layouts.shell_with5 le) := TRANSFORM
	isOnly1 := ((INTEGER)(BOOLEAN)le.firstcount+(INTEGER)(BOOLEAN)le.lastcount+(INTEGER)(BOOLEAN)le.addrcount+(INTEGER)(BOOLEAN)le.socscount+(INTEGER)(BOOLEAN)le.dobcount) = 1;
				
	blankOut := isOnly1 and StringLib.StringFind(le.src,'CO',1)=0;
	
	self.did := if(blankOut, 0, le.did);

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
	
	//add chrono 4 & 5
	
	SELF.chrono_sources4 := if(blankOut, '', le.chrono_sources4);
	SELF.chrono_addrcount4 := if(blankOut, 0, le.chrono_addrcount4);
	SELF.chrono_eqfsaddrcount4 := if(blankOut, false, le.chrono_eqfsaddrcount3);
	SELF.chrono_dladdrcount4 := if(blankOut, false, le.chrono_dladdrcount4);
	SELF.chrono_emaddrcount4 := if(blankOut, false, le.chrono_emaddrcount4);

	self.chronofirst4 := if(blankOut, '', le.chronofirst4);
	self.chronolast4 := if(blankOut, '', le.chronolast4);
	self.chronoprim_range4 := if(blankOut, '', le.chronoprim_range4);
	self.chronopredir4 := if(blankOut, '', le.chronopredir4);
	self.chronoprim_name4 := if(blankOut, '', le.chronoprim_name4);
	self.chronosuffix4 := if(blankOut, '', le.chronosuffix4);
	self.chronopostdir4 := if(blankOut, '', le.chronopostdir4);
	self.chronounit_desig4 := if(blankOut, '', le.chronounit_desig4);
	self.chronosec_range4 := if(blankOut, '', le.chronosec_range4);
	self.chronocity4 := if(blankOut, '', le.chronocity4);
	self.chronostate4 := if(blankOut, '', le.chronostate4);
	self.chronozip54 := if(blankOut, '', le.chronozip54);
	self.chronozip4_4 := if(blankOut, '', le.chronozip4_4);
	self.chronocounty4 := if(blankOut, '', le.chronocounty4);
	self.chronogeo_blk4 := if(blankOut, '', le.chronogeo_blk4);
	self.chronodate_first4 := if(blankOut, 0, le.chronodate_first4);
	self.chronodate_last4 := if(blankOut, 0, le.chronodate_last4);
	self.chronoaddrscore4 := if(blankOut, 0, le.chronoaddrscore4);

	SELF.chrono_sources5 := if(blankOut, '', le.chrono_sources5);
	SELF.chrono_addrcount5 := if(blankOut, 0, le.chrono_addrcount5);
	SELF.chrono_eqfsaddrcount5 := if(blankOut, false, le.chrono_eqfsaddrcount5);
	SELF.chrono_dladdrcount5 := if(blankOut, false, le.chrono_dladdrcount5);
	SELF.chrono_emaddrcount5 := if(blankOut, false, le.chrono_emaddrcount5);

	self.chronofirst5 := if(blankOut, '', le.chronofirst5);
	self.chronolast5 := if(blankOut, '', le.chronolast5);
	self.chronoprim_range5 := if(blankOut, '', le.chronoprim_range5);
	self.chronopredir5 := if(blankOut, '', le.chronopredir5);
	self.chronoprim_name5 := if(blankOut, '', le.chronoprim_name5);
	self.chronosuffix5 := if(blankOut, '', le.chronosuffix5);
	self.chronopostdir5 := if(blankOut, '', le.chronopostdir5);
	self.chronounit_desig5 := if(blankOut, '', le.chronounit_desig5);
	self.chronosec_range5 := if(blankOut, '', le.chronosec_range5);
	self.chronocity5 := if(blankOut, '', le.chronocity5);
	self.chronostate5 := if(blankOut, '', le.chronostate5);
	self.chronozip5 := if(blankOut, '', le.chronozip5);
	self.chronozip4_5 := if(blankOut, '', le.chronozip4_5);
	self.chronocounty5 := if(blankOut, '', le.chronocounty5);
	self.chronogeo_blk5 := if(blankOut, '', le.chronogeo_blk5);
	self.chronodate_first5 := if(blankOut, 0, le.chronodate_first5);
	self.chronodate_last5 := if(blankOut, 0, le.chronodate_last5);
	self.chronoaddrscore5 := if(blankOut, 0, le.chronoaddrscore5);

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
	self.verwphone := if(blankOut, '', le.verwphone);//ri.phone;  // not sure how to handle this yet

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
	self := le;
end;
	
removeVer2 := project(rollbestcount, removeHeader(left));	

ugRemoveVer2 := ungroup(removeVer2);	// remove the grouping by seq and did here

gRemoveVer2 := group(sort(ugRemoveVer2,seq,did), seq);	// was sorted by seq, did, and now just seq	
	
	
// right here for multiple adl, we have up to 3 records.  populate the did2 and did3 fields
AMEX.layouts.shell_with5 getMultADL(AMEX.layouts.shell_with5 le, integer C) := transform

	// self.DIDCount- The total number of DID’s found	// need to get this right after mac did append
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
AMEX.layouts.shell_with5 roll_dids(AMEX.layouts.shell_with5 le, AMEX.layouts.shell_with5 ri) := transform
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
	
	
AMEX.layouts.shell_with5 figureChronology(AMEX.layouts.shell_with5 le) := TRANSFORM
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

return commonstart;

end;