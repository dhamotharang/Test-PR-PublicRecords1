// basefile: thor_data400::base::liens::main::Hogan
#workunit('name', 'Insurance_L&J_sample');
import LiensV2;
eyeball := 25;  //each category in sample

// full_lv2_key := choosen(LiensV2.key_liens_main_ID_FCRA, 25);
full_lv2_key := choosen(LiensV2.key_liens_main_ID_FCRA, all);
// output(choosen(full_lv2_key, eyeball), named('tmsid_rmsid_main_key'));
// output(count(full_lv2_key), named('tmsid_rmsid_main_key_count'));

// lv2_party_key := choosen(LiensV2.key_liens_party_ID, all);
// lv2_party_key := choosen(LiensV2.key_liens_party_ID, all);
// output(choosen(lv2_party_key, eyeball), named('tmsid_rmsid_party_key'));
// output(count(lv2_party_key), named('tmsid_rmsid_party_key_mcount'));

// main_lay := liensv2.Layout_liens_main_module.layout_liens_main;

// party_lay := record
  // liensv2.layout_liens_party;
	// BIPV2.IDlayouts.l_xlink_ids;
// end;

// add_field := record
		// string filt_scenario;
		// main_lay main;
		// party_lay party;
// end;

// add_field append_all(recordof(full_lv2_key) le, party_lay ri) := transform
		// self.main := le;
		// self.party := ri;
		// self.filt_scenario := [];
// end;

// full_lv2 := join(full_lv2_key, lv2_party_key, left.tmsid = right.tmsid and left.rmsid = right.rmsid, append_all(left, right) ) : persist('~nkoubsky::persist::lv2_full2');
// output(choosen(full_lv2, eyeball), named('tmsid_full_party_key'));
// output(count(full_lv2), named('tmsid_rmsid_full_key_count'));


dis := distribute(full_lv2_key, (integer)tmsid);

// clean := full_lv2(main.rmsid <> '');
tbl_type := table(dis, {mytype	 := 	filing_type_desc	; _count := count(group)},filing_type_desc, local);
src_table_cert	:= table(tbl_type, {mytype; rec_count := sum(group, _count)}, mytype);

// add_field trans(full_lv2 le) := transform
// self.main.filing_type_desc := trim(le.main.filing_type_desc, left, right);
// self.main.rmsid := (Trim(le.main.rmsid,left,right)[(length(Trim(le.main.rmsid,left,right))-1)..]);
// self.main.bcbflag := StringLib.StringToUpperCase(le.main.bcbflag);
// self := le;
// end;

// trim_ds := project(full_lv2, trans(left));
output(src_table_cert, all);

// sortds := sort(trim_ds, main.tmsid);


// bcb := trim_ds(main.bcbflag = true);
// clean := bcb(party.did <> '000000000000');

// bcb2 := sortds(main.bcbflag = true);
// clean2_child := bcb(party.did <> '000000000000');

// Slim := record 
// string50 tmsid;
// end;


// slim trans_parent(clean le) := transform
// self.tmsid := le.main.tmsid;
// self := [];
// end;

// parent := project(clean, trans_parent(left));

// dedup_parent := dedup(parent, tmsid);

// output(choosen(dedup_parent, 25));

// add_field2 := record
		// string filt_scenario;
		// main_lay main;
		// party_lay party;
		// integer2 rec_count;
// end;



// add_field2 table_trans2(clean2_child le, integer c) := TRANSFORM
// self.rec_count := [];
// self := le;
// end;

// child := project(clean2_child, table_trans2(left, counter));
// output(child);
// dedup_child := dedup(child, main.tmsid, main.filing_number);
// group_child := group(dedup_child, main.tmsid);

// count_child := iterate(group_child, transform(add_field2, self.rec_count := counter, self:= right));

// output(count_child);

// output(choosen(count_child(rec_count>1) ,50));


// many_recs := count_child(rec_count>1 and party.did <> '000000000000');

// output(many_recs(main.rmsid = 'RL'));
// output(many_recs(main.rmsid = 'RM'));
// output(many_recs(main.rmsid = 'FR'));
// output(many_recs(main.rmsid = 'AR'));
// output(many_recs(main.rmsid = 'RS'));
// output(many_recs(main.rmsid = 'SR'));
// output(many_recs(main.rmsid = 'WR'));
// output(many_recs(main.rmsid = 'RL'));
// output(many_recs(main.rmsid = 'RL'));
// output(many_recs(main.rmsid = 'RL'));

// output(count_child(main.tmsid = 'HG00000000000007765341TNCOCM1'));


// nested_lay := record
// string50 tmsid;
// integer2 count_;
// dataset(add_field2) nested;
// end;


// nested_lay DeNormThem(nested_lay Le, DATASET(add_field2) Ri) := TRANSFORM
		// self.tmsid := le.tmsid;
		// SELF.count_ := COUNT(Ri);
    // SELF.nested := ri;
    // SELF := le;
// END;
// DeNormedRecs := DENORMALIZE(parent, count_child, LEFT.tmsid = RIGHT.nested.main.tmsid, GROUP,  DeNormThem(LEFT,ROWS(RIGHT)));

// OUTPUT(DeNormedRecs);
						
// nested_lay child(ut.ds_oneRecord le, integer c) :=  TRANSFORM
		// self.tmsid := le.tmsid;
		// SELF.count_total := slim_count_p;
		// self.full_range := Min_ + ' ' +'-' + ' ' + max_;  
			  	// self.nested := project(parent, table_trans2(left, counter));	
			  	// self.nested := project(sortds, table_trans2(left));	
					// self := le;
// end;


// dset_slim := project(parent, child(left, counter));			
			
			
						
// dis(main.orig_filing_date = '')
// output(choosen(dis(main.orig_filing_date = ''), 25),named('Blank_orig_filing_date'));
// output(choosen(dis((integer)main.release_date[1..4] < 2000), 25),named('release_date'));

// output(choosen(src_table_cert, all), named('tbl_type'));

// output(choosen(clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER RELEAS'), 5),named('FORCIBLE_ENTRY_DETAINER_RELEAS'));
// output(choosen(clean2(main.filing_type_desc = 'LIS PENDENS RELEASE'), 5),named('LIS_PENDENS_RELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'WELFARE LIEN'), 5),named('WELFARE_LIEN'));
// output(choosen(clean2(main.filing_type_desc = 'DOMESTIC JUDGMENT IN DIVORCE'), 5),named('DOMESTIC_JUDGMENT_IN_DIVORCE'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX WARRANT RENEWED'), 5),named('STATE_TAX_WARRANT_RENEWED'));
// output(choosen(clean2(main.filing_type_desc = 'CHILD SUPPORT PAYMENT'), 5),named('CHILD_SUPPORT_PAYMENT'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX WARRANT'), 5),named('STATE_TAX_WARRANT'));
// output(choosen(clean2(main.filing_type_desc = 'CITY TAX LIEN RELEASE'), 5),named('CITY_TAX_LIEN_RELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'JUDGEMENT LIEN'), 5),named('JUDGEMENT_LIEN'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE SATISFIED'), 5),named('FORECLOSURE_SATISFIED'));
// output(choosen(clean2(main.filing_type_desc = 'SIDEWALK WITHDRAWAL'), 5),named('SIDEWALK_WITHDRAWAL'));
// output(choosen(clean2(main.filing_type_desc = 'COUNTY TAX LIEN RELEASE'), 5),named('COUNT_TAX_LIEN_RELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE PAID'), 5),named('FORECLOSURE_PAID'));
// output(choosen(clean2(main.filing_type_desc = 'DOMESTIC RELEASE IN DIVORCE'), 5),named('DOMESTIC_RELEAS_IN_DIVORCE'));
// output(choosen(clean2(main.filing_type_desc = 'BUILDING WITHDRAWAL'), 5),named('BUILDIN_WITHDRAWAL'));
// output(choosen(clean2(main.filing_type_desc = 'RENEWED SMALL CLAIM JUDGMENT'), 5),named('RENEWEDSMALLCLAIMJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER RELEASE'), 5),named('FORCIBLEENTRYDETAINERRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'SIDEWALK LIEN'), 5),named('SIDEWALKLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'WRIT - BULK TRANSFER'), 5),named('WRITBULKTRANSFER'));
// output(choosen(clean2(main.filing_type_desc = 'JUDGMENT LIEN RELEASE'), 5),named('JUDGMENTLIENRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE NEW FILING'), 5),named('FORECLOSURENEWFILING'));
// output(choosen(clean2(main.filing_type_desc = 'BUILDING RELEASE'), 5),named('BUILDINGRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'GARNISHMENT COLLECT'), 5),named('GARNISHMENTCOLLECT'));
// output(choosen(clean2(main.filing_type_desc = 'CORRECTED FEDERAL TAX LIEN'), 5),named('CORRECTEDFEDERALTAXLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'FEDERAL COURT NEW FILING'), 5),named('FEDERALCOURTNEWFILING'));
// output(choosen(clean2(main.filing_type_desc = 'GARNISHMENT'), 5),named('GARNISHMENT'));
// output(choosen(clean2(main.filing_type_desc = 'WRIT - LIST OF CREDITORS'), 5),named('WRITLISTOFCREDITORS'));
// output(choosen(clean2(main.filing_type_desc = 'RENEW/REOPEN SMALL CLAIM JUDGM'), 5),named('RENEWREOPENSMALLCLAIMJUDGM'));
// output(choosen(clean2(main.filing_type_desc = 'MECHANICS LIEN RELEASE'), 5),named('MECHANICSLIENRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'CIVIL JUDGMENT'), 5),named('CIVILJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE FILING'), 5),named('FORECLOSUREFILING'));
// output(choosen(clean2(main.filing_type_desc = 'BUILDING LIEN'), 5),named('BUILDINGLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'RENEW/REOPEN CIVIL JUDGEMENT'), 5),named('RENEWREOPENCIVILJUDGEMENT'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE'), 5),named('FORECLOSURE'));
// output(choosen(clean2(main.filing_type_desc = 'FEDERAL TAX LIEN RELEASE'), 5),named('FEDERALTAXLIENRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'RENEWED CIVIL JUDGMENT'), 5),named('RENEWEDCIVILJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'MECHANICS LIEN WITHDRAWAL'), 5),named('MECHANICSLIENWITHDRAWAL'));
// output(choosen(clean2(main.filing_type_desc = 'CIVIL NEW FILING'), 5),named('CIVILNEWFILING'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX WARRANT RELEASE'), 5),named('STATETAXWARRANTRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX LIEN RENEWED'), 5),named('STATETAXLIENRENEWED'));
// output(choosen(clean2(main.filing_type_desc = 'CITY TAX LIEN'), 5),named('CITYTAXLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'FEDERAL TAX LIEN'), 5),named('FEDERALTAXLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'WRIT - MISCELLANEOUS'), 5),named('WRITMISCELLANEOUS'));
// output(choosen(clean2(main.filing_type_desc = ''), 5),named('blanks'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX LIEN RELEASE'), 5),named('STATETAXLIENRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'CHILD SUPPORT LIEN'), 5),named('CHILDSUPPORTLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'MECHANICS LIEN'), 5),named('MECHANICSLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'FEDERAL COURT JUDGMENT'), 5),named('FEDERALCOURTJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'COUNTY TAX LIEN'), 5),named('COUNTYTAXLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'CHILD SUPPORT PAYMENT RELEASE'), 5),named('CHILDSUPPORTPAYMENTRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'WRIT OF ATTACHMENT'), 5),named('WRITOFATTACHMENT'));
// output(choosen(clean2(main.filing_type_desc = 'CIVIL SPECIAL JUDGMENT'), 5),named('CIVILSPECIALJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX LIEN RENEWAL'), 5),named('STATETAXLIENRENEWAL'));
// output(choosen(clean2(main.filing_type_desc = 'SMALL CLAIMS JUDGMENT RELEASE'), 5),named('SMALLCLAIMSJUDGMENTRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'STATE TAX LIEN'), 5),named('STATETAXLIEN'));
// output(choosen(clean2(main.filing_type_desc = 'SIDEWALK RELEASE'), 5),named('SIDEWALKRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'WRIT - ASSIGN FOR LIST OF CREDITORS'), 5),named('WRITASSIGNFORLISTOFCREDITORS'));
// output(choosen(clean2(main.filing_type_desc = 'SMALL CLAIMS JUDGMENT'), 5),named('SMALLCLAIMSJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'FORECLOSURE (JUDGMENT)'), 5),named('FORECLOSUREJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'CIVIL SPECIAL JUDGMENT RELEASE'), 5),named('CIVILSPECIALJUDGMENTRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER'), 5),named('FORCIBLEENTRYDETAINER'));
// output(choosen(clean2(main.filing_type_desc = 'DISMISSED FORECLOSURE'), 5),named('DISMISSEDFORECLOSURE'));
// output(choosen(clean2(main.filing_type_desc = 'ABSTRACT OF JUDGMENT'), 5),named('ABSTRACTOFJUDGMENT'));
// output(choosen(clean2(main.filing_type_desc = 'CIVIL JUDGMENT RELEASE'), 5),named('CIVILJUDGMENTRELEASE'));
// output(choosen(clean2(main.filing_type_desc = 'LIS PENDENS NOTICE'), 5),named('LISPENDENSNOTICE'));

// slim51:= clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER RELEAS');
// slim52:= clean2(main.filing_type_desc = 'LIS PENDENS RELEASE');
// slim53:= clean2(main.filing_type_desc = 'WELFARE LIEN');
// slim54:= clean2(main.filing_type_desc = 'DOMESTIC JUDGMENT IN DIVORCE');
// slim55:= clean2(main.filing_type_desc = 'STATE TAX WARRANT RENEWED');
// slim56:= clean2(main.filing_type_desc = 'CHILD SUPPORT PAYMENT');
// slim57:= clean2(main.filing_type_desc = 'STATE TAX WARRANT');
// slim58:= clean2(main.filing_type_desc = 'CITY TAX LIEN RELEASE');
// slim59:= clean2(main.filing_type_desc = 'JUDGEMENT LIEN');
// slim60:= clean2(main.filing_type_desc = 'FORECLOSURE SATISFIED');
// slim61:= clean2(main.filing_type_desc = 'SIDEWALK WITHDRAWAL');
// slim62:= clean2(main.filing_type_desc = 'COUNTY TAX LIEN RELEASE');
// slim63:= clean2(main.filing_type_desc = 'FORECLOSURE PAID');
// slim64:= clean2(main.filing_type_desc = 'DOMESTIC RELEASE IN DIVORCE');
// slim65:= clean2(main.filing_type_desc = 'BUILDING WITHDRAWAL');
// slim66:= clean2(main.filing_type_desc = 'RENEWED SMALL CLAIM JUDGMENT');
// slim67:= clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER RELEASE');
// slim68:= clean2(main.filing_type_desc = 'SIDEWALK LIEN');
// slim69:= clean2(main.filing_type_desc = 'WRIT - BULK TRANSFER');
// slim70:= clean2(main.filing_type_desc = 'JUDGMENT LIEN RELEASE');
// slim71:= clean2(main.filing_type_desc = 'FORECLOSURE NEW FILING');
// slim72:= clean2(main.filing_type_desc = 'BUILDING RELEASE');
// slim73:= clean2(main.filing_type_desc = 'GARNISHMENT COLLECT');
// slim74:= clean2(main.filing_type_desc = 'CORRECTED FEDERAL TAX LIEN');
// slim75:= clean2(main.filing_type_desc = 'FEDERAL COURT NEW FILING');
// slim76:= clean2(main.filing_type_desc = 'GARNISHMENT');
// slim77:= clean2(main.filing_type_desc = 'WRIT - LIST OF CREDITORS');
// slim78:= clean2(main.filing_type_desc = 'RENEW/REOPEN SMALL CLAIM JUDGM');
// slim79:= clean2(main.filing_type_desc = 'MECHANICS LIEN RELEASE');
// slim80:= clean2(main.filing_type_desc = 'CIVIL JUDGMENT');
// slim81:= clean2(main.filing_type_desc = 'FORECLOSURE FILING');
// slim82:= clean2(main.filing_type_desc = 'BUILDING LIEN');
// slim83:= clean2(main.filing_type_desc = 'RENEW/REOPEN CIVIL JUDGEMENT');
// slim84:= clean2(main.filing_type_desc = 'FORECLOSURE');
// slim85:= clean2(main.filing_type_desc = 'FEDERAL TAX LIEN RELEASE');
// slim86:= clean2(main.filing_type_desc = 'RENEWED CIVIL JUDGMENT');
// slim87:= clean2(main.filing_type_desc = 'MECHANICS LIEN WITHDRAWAL');
// slim88:= clean2(main.filing_type_desc = 'CIVIL NEW FILING');
// slim89:= clean2(main.filing_type_desc = 'STATE TAX WARRANT RELEASE');
// slim90:= clean2(main.filing_type_desc = 'STATE TAX LIEN RENEWED');
// slim91:= clean2(main.filing_type_desc = 'CITY TAX LIEN');
// slim92:= clean2(main.filing_type_desc = 'FEDERAL TAX LIEN');
// slim93:= clean2(main.filing_type_desc = 'WRIT - MISCELLANEOUS');
// slim94:= clean2(main.filing_type_desc = '');
// slim95:= clean2(main.filing_type_desc = 'STATE TAX LIEN RELEASE');
// slim96:= clean2(main.filing_type_desc = 'CHILD SUPPORT LIEN');
// slim97:= clean2(main.filing_type_desc = 'MECHANICS LIEN');
// slim98:= clean2(main.filing_type_desc = 'FEDERAL COURT JUDGMENT');
// slim99:= clean2(main.filing_type_desc = 'COUNTY TAX LIEN');
// slim100:= clean2(main.filing_type_desc = 'CHILD SUPPORT PAYMENT RELEASE');
// slim101:= clean2(main.filing_type_desc = 'WRIT OF ATTACHMENT');
// slim102:= clean2(main.filing_type_desc = 'CIVIL SPECIAL JUDGMENT');
// slim103:= clean2(main.filing_type_desc = 'STATE TAX LIEN RENEWAL');
// slim104:= clean2(main.filing_type_desc = 'SMALL CLAIMS JUDGMENT RELEASE');
// slim105:= clean2(main.filing_type_desc = 'STATE TAX LIEN');
// slim106:= clean2(main.filing_type_desc = 'SIDEWALK RELEASE');
// slim107:= clean2(main.filing_type_desc = 'WRIT - ASSIGN FOR LIST OF CREDITORS');
// slim108:= clean2(main.filing_type_desc = 'SMALL CLAIMS JUDGMENT');
// slim109:= clean2(main.filing_type_desc = 'FORECLOSURE (JUDGMENT)');
// slim110:= clean2(main.filing_type_desc = 'CIVIL SPECIAL JUDGMENT RELEASE');
// slim111:= clean2(main.filing_type_desc = 'FORCIBLE ENTRY/DETAINER');
// slim112:= clean2(main.filing_type_desc = 'DISMISSED FORECLOSURE');
// slim113:= clean2(main.filing_type_desc = 'ABSTRACT OF JUDGMENT');
// slim114:= clean2(main.filing_type_desc = 'CIVIL JUDGMENT RELEASE');
// slim115:= clean2(main.filing_type_desc = 'LIS PENDENS NOTICE');



// rmsid_set := ['CJ', 'RL', 'CS', 'RM', 'CF', 'FT', 'FR', 'AJ', 'AR', 'SC', 'RS', 'ST', 'SR', 'TW', 'WR'];
// rmsid_set2 := ['VJ', 'FE','SE','WE'];
// rmsid_set3 := ['RL','RM','FR','AR','RS','SR','WR'];


// slim := clean(main.rmsid = 'CJ' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim2 := clean(main.rmsid = 'RL' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim3 := clean(main.rmsid = 'CS' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim4 := clean(main.rmsid = 'RM' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim5 := clean(main.rmsid = 'CF' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim6 := clean(main.rmsid = 'FT' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim7 := clean(main.rmsid = 'FR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim8 := clean(main.rmsid = 'AJ' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim9 := clean(main.rmsid = 'AR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim10 := clean(main.rmsid = 'SC' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim11 := clean(main.rmsid = 'RS' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim12 := clean(main.rmsid = 'ST' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim13 := clean(main.rmsid = 'SR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim14 := clean(main.rmsid = 'TW' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim15 := clean(main.rmsid = 'WR' and main.filing_type_desc = '' and party.did <> '000000000000');

// slim16 := clean(main.rmsid = 'VJ' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim17 := clean(main.rmsid = 'FE' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim18 := clean(main.rmsid = 'SE' and main.filing_type_desc = '' and party.did <> '`');
// slim19 := clean(main.rmsid = 'WE' and main.filing_type_desc = '' and party.did <> '000000000000');

// slim20 := clean(main.orig_filing_date = '' and party.did <> '000000000000');
// slim21 := clean(main.rmsid = 'FT' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim22 := clean(main.rmsid = 'FR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim23 := clean(main.rmsid = 'AJ' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim24 := clean(main.rmsid = 'AR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim25 := clean(main.rmsid = 'SC' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim26 := clean(main.rmsid = 'RS' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim27 := clean(main.rmsid = 'ST' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim28 := clean(main.rmsid = 'SR' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim29 := clean(main.rmsid = 'TW' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim30 := clean(main.rmsid = 'WR' and main.filing_type_desc = '' and party.did <> '000000000000');

// slim31 := clean(main.agency_state = 'NM' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');
// slim32 := clean(main.agency_state = 'IN' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');
// slim33 := clean(main.agency_state = 'OK' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');

// slim34 := clean(main.agency_state = 'KS' and main.filing_type_desc = '' and party.did <> '000000000000');

// slim35 :=clean(main.rmsid = 'TW' and main.agency_state = 'NM' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim36 := clean(main.rmsid = 'TW' and main.agency_state = 'NY' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim37 := clean(main.rmsid = 'TW' and main.agency_state = 'WA' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim38 := clean(main.rmsid = 'TW' and main.agency_state = 'IN' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim39 :=  clean(main.rmsid = 'TW' and main.agency_state = 'OK' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim40 :=  clean(main.rmsid = 'TW' and main.agency_state = 'WI' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim41 := clean(main.rmsid = 'WR' and main.agency_state = 'KS' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim42 :=  clean(main.rmsid = 'WR' and main.agency_state = 'NM' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim43 :=  clean(main.rmsid = 'WR' and main.agency_state = 'WA' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim44 :=  clean(main.rmsid = 'WR' and main.agency_state = 'IN' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim45 :=  clean(main.rmsid = 'WR' and main.agency_state = 'OK' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim46 := clean(main.agency_state = 'NM' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');
// slim47 := clean(main.agency_state = 'IN' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');
// slim48 := clean(main.agency_state = 'OK' and main.filing_type_desc = 'STATE TAX WARRANT' and party.did <> '000000000000');

// slim49 := clean(main.agency_state = 'KS' and main.filing_type_desc = '' and party.did <> '000000000000');

// slim50 :=clean(main.rmsid = 'TW' and main.agency_state = 'NM' and main.filing_type_desc = '' and party.did <> '000000000000');

// a1:= choosen(slim, 5);
// a2:= choosen(slim2, 5);
// a3:= choosen(slim3, 5);
// a4:= choosen(slim4, 5);
// a5:= choosen(slim5, 5);
// a6:= choosen(slim6, 5);
// a7:= choosen(slim7, 5);
// a8:= choosen(slim8, 5);
// a9:= choosen(slim9, 5);
// a10:= choosen(slim10, 5);
// a11:= choosen(slim11, 5);
// a12:= choosen(slim12, 5);
// a13:= choosen(slim13, 5);
// a14:= choosen(slim14, 5);
// a15:= choosen(slim15, 5);
// a16:= choosen(slim16, 5);
// a17:= choosen(slim17, 5);
// a18:= choosen(slim18, 5);
// a19:= choosen(slim19, 5);
// a20:= choosen(slim20, 5);
// a21:= choosen(slim21, 5);
// a22:= choosen(slim22, 5);
// a23:= choosen(slim23, 5);
// a24:= choosen(slim24, 5);
// a25:= choosen(slim25, 5);
// a26:= choosen(slim26, 5);
// a27:= choosen(slim27, 5);
// a28:= choosen(slim28, 5);
// a29:= choosen(slim29, 5);
// a30:= choosen(slim30, 5);
// a31:= choosen(slim31, 5);
// a32:= choosen(slim32, 5);
// a33:= choosen(slim33, 5);
// a34:= choosen(slim34, 5);
// a35:= choosen(slim35, 5);
// a36:= choosen(slim36, 5);
// a37:= choosen(slim37, 5);
// a38:= choosen(slim38, 5);
// a39:= choosen(slim39, 5);
// a40:= choosen(slim40, 5);
// a41:= choosen(slim41, 5);
// a42:= choosen(slim42, 5);
// a43:= choosen(slim43, 5);
// a44:= choosen(slim44, 5);
// a45:= choosen(slim45, 5);
// a46:= choosen(slim46, 5);
// a47:= choosen(slim47, 5);
// a48:= choosen(slim48, 5);
// a49:= choosen(slim49, 5);
// a50:= choosen(slim50, 5);
// a51:= choosen(slim51, 5);
// a52:= choosen(slim52, 5);
// a53:= choosen(slim53, 5);
// a54:= choosen(slim54, 5);
// a55:= choosen(slim55, 5);
// a56:= choosen(slim56, 5);
// a57:= choosen(slim57, 5);
// a58:= choosen(slim58, 5);
// a59:= choosen(slim59, 5);
// a60:= choosen(slim60, 5);
// a61:= choosen(slim61, 5);
// a62:= choosen(slim62, 5);
// a63:= choosen(slim63, 5);
// a64:= choosen(slim64, 5);
// a65:= choosen(slim65, 5);
// a66:= choosen(slim66, 5);
// a67:= choosen(slim67, 5);
// a68:= choosen(slim68, 5);
// a69:= choosen(slim69, 5);
// a70:= choosen(slim70, 5);
// a71:= choosen(slim71, 5);
// a72:= choosen(slim72, 5);
// a73:= choosen(slim73, 5);
// a74:= choosen(slim74, 5);
// a75:= choosen(slim75, 5);
// a76:= choosen(slim76, 5);
// a77:= choosen(slim77, 5);
// a78:= choosen(slim78, 5);
// a79:= choosen(slim79, 5);
// a80:= choosen(slim80, 5);
// a81:= choosen(slim81, 5);
// a82:= choosen(slim82, 5);
// a83:= choosen(slim83, 5);
// a84:= choosen(slim84, 5);
// a85:= choosen(slim85, 5);
// a86:= choosen(slim86, 5);
// a87:= choosen(slim87, 5);
// a88:= choosen(slim88, 5);
// a89:= choosen(slim89, 5);
// a90:= choosen(slim90, 5);
// a91:= choosen(slim91, 5);
// a92:= choosen(slim92, 5);
// a93:= choosen(slim93, 5);
// a94:= choosen(slim94, 5);
// a95:= choosen(slim95, 5);
// a96:= choosen(slim96, 5);
// a97:= choosen(slim97, 5);
// a98:= choosen(slim98, 5);
// a99:= choosen(slim99, 5);
// a100:= choosen(slim100, 5);
// a101:= choosen(slim101, 5);
// a102:= choosen(slim102, 5);
// a103:= choosen(slim103, 5);
// a104:= choosen(slim104, 5);
// a105:= choosen(slim105, 5);
// a106:= choosen(slim106, 5);
// a107:= choosen(slim107, 5);
// a108:= choosen(slim108, 5);
// a109:= choosen(slim109, 5);
// a110:= choosen(slim110, 5);
// a111:= choosen(slim111, 5);
// a112:= choosen(slim112, 5);
// a113:= choosen(slim113, 5);
// a114:= choosen(slim114, 5);
// a115:= choosen(slim115, 5);


// full_ := (a1
// +a2
// +a3
// +a4
// +a5
// +a6
// +a7
// +a8
// +a9
// +a10
// +a11
// +a12
// +a13
// +a14
// +a15
// +a16
// +a17
// +a18
// +a19
// +a20
// +a21
// +a22
// +a23
// +a24
// +a25
// +a26
// +a27
// +a28
// +a29
// +a30
// +a31
// +a32
// +a33
// +a34
// +a35
// +a36
// +a37
// +a38
// +a39
// +a40
// +a41
// +a42
// +a43
// +a44
// +a45
// +a46
// +a47
// +a48
// +a49
// +a50
// +a51
// +a52
// +a53
// +a54
// +a55
// +a56
// +a57
// +a58
// +a59
// +a60
// +a61
// +a62
// +a63
// +a64
// +a65
// +a66
// +a67
// +a68
// +a69
// +a70
// +a71
// +a72
// +a73
// +a74
// +a75
// +a76
// +a77
// +a78
// +a79
// +a80
// +a81
// +a82
// +a83
// +a84
// +a85
// +a86
// +a87
// +a88
// +a89
// +a90
// +a91
// +a92
// +a93
// +a94
// +a95
// +a96
// +a97
// +a98
// +a99
// +a100
// +a101
// +a102
// +a103
// +a104
// +a105
// +a106
// +a107
// +a108
// +a109
// +a110
// +a111
// +a112
// +a113
// +a114
// +a115
// );

// output(full_, all);



// slim6 := clean(main.rmsid = 'TW' and main.agency_state = 'NY' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim7 := clean(main.rmsid = 'TW' and main.agency_state = 'WA' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim8 := clean(main.rmsid = 'TW' and main.agency_state = 'IN' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim9 :=  clean(main.rmsid = 'TW' and main.agency_state = 'OK' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim10 :=  clean(main.rmsid = 'TW' and main.agency_state = 'WI' and main.filing_type_desc = '' and party.did <> '000000000000');
// slim11 := clean(main.rmsid = 'WR' and main.agency_state = 'KS' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim12 :=  clean(main.rmsid = 'WR' and main.agency_state = 'NM' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim13 :=  clean(main.rmsid = 'WR' and main.agency_state = 'WA' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim14 :=  clean(main.rmsid = 'WR' and main.agency_state = 'IN' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');
// slim15 :=  clean(main.rmsid = 'WR' and main.agency_state = 'OK' and main.filing_type_desc = 'STATE TAX LIEN RELEASE' and party.did <> '000000000000');

// a := choosen(slim, 5);
// a2 := choosen(slim2, 5);
// a3 := choosen(slim3, 5);
// a4 := choosen(slim4, 5);
// a5 := choosen(slim5, 5);
// a6 := choosen(slim6, 5);
// a7 := choosen(slim7, 5);
// a8 := choosen(slim8, 5);
// a9 := choosen(slim9, 5);
// a10 := choosen(slim10, 5);
// a11 := choosen(slim11, 5);
// a12 := choosen(slim12, 5);
// a13 := choosen(slim13, 5);
// a14 := choosen(slim14, 5);
// a15 := choosen(slim15, 5);

// full_ := (a+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15);

// output(full_, all);


// c1 		:= 		clean(Models.Common.Contains(full_lv2(main.filing_type_desc, 'VACATED')));
// output(choosen(c1, eyeball), named('c1'));

// c2 		:= 		full_lv2(Models.Common.Contains(main.filing_type_desc, 'Filed'));
// output(choosen(c2, eyeball), named('c2'));

// c3		:= 		full_lv2(trim(main.filing_type_desc) = '' );
// output(choosen(c3, eyeball), named('c3'));

// c4 		:= 		full_lv2(Models.Common.Contains(main.filing_type_desc, 'LIEN'));
// output(choosen(c4, eyeball), named('c4'));

// c5 		:= 		full_lv2(Models.Common.Contains(main.filing_type_desc, 'TAX'));
// output(choosen(c5, eyeball), named('c5'));

// c10 = Any filing record with the last 2 characters of rmsid are in the following list: CJ, RL, CS, RM, CF, FT, FR, AJ, AR, SC, RS, ST, SR, TW, WR 
// test[(length(test)-1)..]

// c10 		:= 		full_lv2(main.rmsid[length(main.rmsid)-1..] = 'SR');
// output(choosen(c10, eyeball), named('c10'));





//c12 = Any filing record with BLANK filing_number
// c12 		:= 		full_lv2(main.filing_number = '');
// output(choosen(c12, eyeball), named('c12'));


//c14 = Any filing record with BLANK orig_filing_number
// c14 		:= 		full_lv2(main.filing_number = '');
// output(choosen(c14, eyeball), named('c14'));



/*Test Content Examples Needed:
c1 = Any filing record with filing_type_desc  in ”VACATED JUDGMENT”
c1 = Any filing record with filing_type_desc  in "VACATED JUDGMENTS"
c2 = Any filing record with filing_type_desc beginning with “FILED IN ERROR” verbiage
c3 = Any filing record with BLANK filing_type_desc and the last 2 characters of rmsid = VJ, FE,SE,WE
c4 = Any filing record with isDisputed=true
c5 = Any filing record with orig_filing_date is > Application Date
c6 = Any filing record with a filling type of CORRECTED FEDERAL TAX LIEN
c7 = Any filing record with a filling type of JUDGEMENT LIEN
c8 = Any filing record with a filling type of JUDGMENT LIEN RELEASE
c9 = Any filing record with a filling type of STATE TAX WARRANT RELEASE
c10 = Any filing record with the last 2 characters of rmsid are in the following list: 
CJ, RL, CS, RM, CF, FT, FR, AJ, AR, SC, RS, ST, SR, TW, WR 
c11 = Any filing record with BLANK Filing_Type_Desc with the last 2 characters of rmsid in the following release codes: 
"RL","RM","FR","AR","RS","SR","WR"
c12 = Any filing record with BLANK filing_number
c13 = Any filing record with the release_date over the one without release_date
c14 = Any filing record with BLANK orig_filing_number
*/





