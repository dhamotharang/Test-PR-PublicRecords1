import suppress, mdr, doxie_raw, DriversV2_Services, ut, CriminalRecords_Services;

export base_presentation(DATASET(doxie.layout_presentation) pre_outf, 
												 string phoneToMatch = '',
												 boolean reduceddata = false) := FUNCTION

boolean nolookupsearch := false : stored('NoLookupSearch');
boolean bestonly := false : stored('BestOnly');
boolean include_phonesPlus := false : stored('IncludePhonesPlus');
boolean include_dlinfo := false : stored('IncludeDLInfo');

boolean negate_true_defaults := false : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
boolean return_waf := true : STORED('ReturnAlsoFound');
boolean includeCriminalImages := false : STORED('IncludeCriminalImageIndicators');
// same input parameter is used to control whether to produce static counts along with dynamic ones.
// this behaviour is easy to modify, if required. Also any individual static count may be used (see below)
boolean include_wealsofound := return_waf AND ~negate_true_defaults;
isKnowx := ut.IndustryClass.is_knowx;

doxie.mac_selection_declare();
doxie.mac_header_field_declare();

score_tab := MIN(pre_outf, penalt)+3;

withphones := doxie.layout_presentation_phones;

outf_raw := pre_outf(penalt < score_tab OR ~bestonly);
//current listings from phone file don't need to pass through this macro again
//non-current listings can be determined by an empty listed_name

outf_raw_no_ph := outf_raw(doxie.needAppends(src, listed_name));

dids_for_rels := dedup(sort(project(outf_raw_no_ph, doxie.layout_references),did),did);
outf_no_ph := if(reduceddata,project(outf_raw_no_ph,transform(doxie.layout_presentation_phones, self:=left)),doxie.Append_Gong(outf_raw_no_ph,doxie.relative_dids(dids_for_rels),dial_contactprecision_value,
                          include_phonesPlus, score_threshold_value, glb_purpose,dppa_purpose,phoneToMatch));

// if CurrentResidentsOnly selected, filter any historical records after AppendGong has upgraded
// the tnt values of the header records
outf_no_ph_cur := if(currentResidentsOnly, outf_no_ph(tnt != 'H'), outf_no_ph);

//here get the phone dates for the child dataset of records did not go through append gong - ~doxie.needAppends
doxie.Layout_Phones makePhoneChild(outf_raw le) := TRANSFORM
	SELF.phone10 := le.phone;
	SELF.match_type := 1;
	// only current phones from Gong should be marked "listed"
	SELF.listed := IF(doxie.tnt_score(le.tnt) <= 1, true, false);
	SELF.listed_name := IF(le.publish_code ='N','',le.listed_name);
	SELF.phone_first_seen := le.dt_first_seen;
	SELF.phone_last_seen := le.dt_last_seen;
	SELF.gong_score := 0;
	SELF := le;
END;

//here append the phone dates to the main record of records did not go through append gong - ~doxie.needAppends
withphones fixPhones(outf_raw le) := TRANSFORM
	SELF.phones := PROJECT(le, makePhoneChild(le));
	SELF.listed_name := IF(le.publish_code ='N','',le.listed_name);
	SELF.phone_first_seen := le.dt_first_seen;
	SELF.phone_last_seen := le.dt_last_seen;
	SELF := le;
END;

ut.getTimeZone(outf_raw(~doxie.needAppends(src, listed_name)),phone,timezone,outf_raw_ph_w_tzone)
ut.getTimeZone(outf_raw_ph_w_tzone,listed_phone,listed_timezone,outf_raw_ph_w_listed_tzone)

outf_raw_ph_ready := PROJECT(outf_raw_ph_w_listed_tzone, fixPhones(LEFT));
outf_raw_dates_rolled := doxie.fn_roll_gong_dates(outf_raw(~doxie.needAppends(src, listed_name)));

outf_raw_ph_ready patch_ph_first_seen(outf_raw_ph_ready l, outf_raw_dates_rolled r) := transform
     picked_phone_first_seen := if(r.phone_first_seen < l.phone_first_seen and r.phone_first_seen>0,r.phone_first_seen,l.phone_first_seen);
	   SELF.phone_first_seen := picked_phone_first_seen;
     SELF.phones := project(l.phones, transform(doxie.Layout_Phones, 
	                                              SELF.phone_first_seen := if(left.phone10 = l.listed_phone, picked_phone_first_seen, left.phone_first_seen),
	                                              SELF := LEFT));
	self := l;
end;

outf_raw_ph := join(outf_raw_ph_ready, outf_raw_dates_rolled,
                    left.prim_name=right.prim_name and
			              left.prim_range=right.prim_range and
			              left.st=right.st and
			              left.zip=right.zip and 
			              left.listed_phone=right.phone,
			              patch_ph_first_seen(left, right), left outer, keep(1), limit(0));

outf := if(reduced_data_value or reduceddata
           ,project(outf_raw, transform(withphones,self:=left, self.Phones:=[]))
           ,outf_no_ph_cur + outf_raw_ph);

doxie.Layout_HeaderFileSearch trans(outf le) :=
TRANSFORM
	SELF.did := IF(le.did=0,'',INTFORMAT(le.did,12,1));
	// current phone source doc retrieveal requires a DID, so blank out any RIDs for empty DIDs
	SELF.rid := MAP(le.src='PH'	=>	IF(SELF.did<> '',SELF.did+'PH'+(STRING)le.phone, ''), 
					le.src in MDR.sourceTools.set_Daily_Utility_sources	=>	SELF.did+'UT'+(STRING)le.rid, 
					le.src='QH'	=>	SELF.did+'QH'+(STRING)le.rid,
									(STRING)le.rid);
// note that although daily utilities are split into good and bad, method for 'rid' above is the same for both.
	SELF.src := MAP (le.src = MDR.sourceTools.src_Daily_Utilities  =>'UT',
	                 le.src = MDR.sourceTools.src_Daily_ZUtilities =>'ZT',
	                 le.src);
	SELF.first_seen := le.dt_first_seen;
	SELF.last_seen := MAP( ~glb_ok and ~isKnowx =>le.dt_nonglb_last_seen,
                   le.dt_last_seen<>0 => le.dt_last_seen, 0);
	SELF.name_suffix := IF( le.name_suffix[1]='U','',le.name_suffix );
	SELF.age := ut.age(le.dob);
	SELF.prim_name := IF(mdr.SourceTools.SourceIsDeath(le.src),'',le.prim_name);
	SELF.phone :=  IF((INTEGER)le.phone=0,'',le.phone);
	SELF.veh_cnt:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('VEH')) and include_wealsofound);
	SELF.dl_cnt:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('DL')) and include_wealsofound);
	SELF.head_cnt:= 0;
	SELF.crim_cnt:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('CRIM')) and include_wealsofound);
	SELF.sex_cnt:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('SEX')) and include_wealsofound);
	SELF.ccw_cnt:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('CCW')) and include_wealsofound);
	SELF.rel_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('REL')) and include_wealsofound);
	SELF.assoc_count:= 0;
	SELF.fire_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('FIRE')) and include_wealsofound);
	SELF.faa_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('FAA')) and include_wealsofound);
	SELF.prof_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PROF')) and include_wealsofound);
	SELF.vess_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('VESS')) and include_wealsofound);
	SELF.bus_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('BUS')) and include_wealsofound);
	SELF.paw_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PAW')) and include_wealsofound);
	SELF.bc_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('BC')) and include_wealsofound);
	SELF.prop_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PROP')) and include_wealsofound);
	SELF.prop_asses_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PROP_ASSES')) and include_wealsofound);
	SELF.prop_deeds_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PROP_DEEDS')) and include_wealsofound);
	SELF.bk_count:= (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('BK')) and include_wealsofound);
	SELF.sanc_count := (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('SANC')) and include_wealsofound);
	SELF.prov_count := (unsigned2) (ut.bit_test(le.lookup_did, doxie.lookup_bit('PROV')) and include_wealsofound);
	SELF.DLRecs := [];
	SELF.corp_affil_count:= 0;
	SELF.comp_prop_count:= 0;
	SELF.phonesplus_count:= 0;
	SELF.email_count := 0;
	SELF.accident_count := 0;
	SELF.hri_address := [];
	SELF.hri_ssn := [];
	self.hri_phone := [];
	SELF.ssn_issue_early := 0;
  SELF.ssn_issue_last := 0;
  SELF.ssn_issue_place := '';
	SELF.dead_age := 0;
	SELF := le;
END;

outf_pulled := outf(ssn NOT IN doxie.pullSSN);

outf check_valid_ssn(outf_pulled le, suppress.Key_SSN_Bad ri) := TRANSFORM
	self.valid_ssn := IF(ri.s_ssn <> '', '', le.valid_ssn);
	self := le;
END;

outf_valid := JOIN(outf_pulled, suppress.Key_SSN_Bad, 
									left.ssn <> '' and left.valid_ssn IN ['G','M'] and 
									keyed(left.ssn = right.s_ssn) AND right.cnt>4, 
									check_valid_ssn(LEFT, RIGHT),
									KEEP(1), LIMIT(0), LEFT OUTER);

// need to exempt daily util from the SSN pruning
// SSN pruning key does not get updated as frequently as the daily util data, which by definition is current 
ta3_daily_util := PROJECT(outf_valid(src = 'DU'),trans(LEFT));
ta3 := PROJECT(outf_valid(src <> 'DU'), trans(LEFT));

doxie.MAC_PruneOldSSNs(ta3, ta3_pruned, ssn, did);

ta4 := if(reduced_data_value,ta3,ta3_pruned) + ta3_daily_util;

// need to perform lookups on all non-zero DIDs including those found only in Gong lookup (replacing get_dids())
use_dids := dedup(sort(PROJECT(ta4(did <> ''), TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did)), did, did));

dd := doxie_raw.death_raw(use_dids,,dateVal,dppa_purpose,glb_purpose);
doxie.Layout_HeaderFileSearch check_death1(doxie.Layout_HeaderFileSearch le, dd ri) :=
TRANSFORM
	SELF.did := le.did;
	SELF.dod := (INTEGER)IF((INTEGER)ri.did=0 AND mdr.SourceTools.SourceIsDeath(le.src), '', ri.dod8);
	SELF.dead_age := ut.age (le.dob,SELF.dod);
	SELF.death_code := IF(SELF.dod<>0,ri.VorP_code,'');
	SELF.deceased := if ((integer)ri.did > 0 , 'Y','N');
	SELF.IsLimitedAccessDMF := ri.IsLimitedAccessDMF;
	SELF := le;
END;
death_checked := JOIN(ta4, dd, (INTEGER)LEFT.did=(INTEGER)RIGHT.did, check_death1(LEFT,RIGHT), LEFT OUTER);

clean_age := if(reduced_data_value, ta4, death_checked);

doxie.Layout_HeaderFileSearch add_lookups(clean_age le, doxie.Key_Did_Lookups_v2 ri) := transform
	// bug 58262 -- remove the override processing for singleton DIDs 
  // self.valid_ssn := IF(le.valid_ssn IN ['G','M'] AND ri.head_cnt=1, '', le.valid_ssn);
  self.valid_ssn := le.valid_ssn;
  self.did := le.did;
  self.comp_prop_count := le.comp_prop_count;//why in key layout when not populated there???
  self := ri;
  self := le;
  end;

lookup_rec := doxie.header_lookups(use_dids);

doxie.Layout_HeaderFileSearch revise_counts(clean_age le, doxie.Key_Did_Lookups_v2 ri) := transform
	// bug 58262 -- remove the override processing for singleton DIDs 
  // self.valid_ssn := IF(le.valid_ssn IN ['G','M'] AND ri.head_cnt=1, '', le.valid_ssn);
  self.did := le.did;
  self.prop_count := if(ri.prop_count>0,1,0);
  self.prop_asses_count := if(ri.prop_asses_count>0,1,0);
	self.prop_deeds_count := if(ri.prop_deeds_count>0,1,0);
  self := le;
  end;


clean_age_revisedpropcounts := join(clean_age,lookup_rec,(unsigned6) left.did= right.did,revise_counts(left,right));


jnd2 := join(clean_age,lookup_rec,(unsigned6)left.did=right.did,add_lookups(left,right),left outer);

// NB: seems like "nolookupsearch" is out of touch now...
ta := if (include_wealsofound,
          if ( nolookupsearch,clean_age_revisedpropcounts,jnd2 ),
          clean_age);
// OUTPUT(pre_outf,NAMED('pre_outf'));
// output(outf_raw, named('outf_raw'));

// need to perform lookups on all non-zero DIDs for DL info
dlRollRec := RECORD
	UNSIGNED6 did;
	doxie.Layout_DLStateInfo;
END;

dlRollRec rollDates(DriversV2_Services.layouts.result_narrow L, DATASET(DriversV2_Services.layouts.result_narrow) R) := TRANSFORM
	SELF.did:=L.did;
	SELF.dl_num:=L.dl_number;
	SELF.dl_st:=L.orig_state;
	SELF.earliest_lic_issue_date:=MIN(R(lic_issue_date!=0),lic_issue_date);
	SELF.latest_expiration_date:=MAX(R,expiration_date);
END;

doxie.Layout_HeaderFileSearch MyDLTransform(doxie.Layout_HeaderFileSearch inRec, dlRollRec dlInfoDetail) := TRANSFORM
	SELF.dlrecs.dl_num := dlInfoDetail.dl_num;
	SELF.dlrecs.dl_st := dlInfoDetail.dl_st;
	SELF.dlrecs.earliest_lic_issue_date := dlInfoDetail.earliest_lic_issue_date;
	SELF.dlrecs.latest_expiration_date := dlInfoDetail.latest_expiration_date;
	SELF := inRec;
END;

MyDLDids := dedup(sort(PROJECT(ta(did <> ''), TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did)), did, did));
MyDLRecs := SORT(DriversV2_Services.DLRaw.narrow_view.by_did(MyDLDids),did,dl_number,-lic_issue_date,-expiration_date);
MyDLRoll := ROLLUP(GROUP(MyDLRecs,did,dl_number),GROUP,rollDates(LEFT,ROWS(LEFT)));
MyDLSort := DEDUP(SORT(MyDLRoll,did,-latest_expiration_date,earliest_lic_issue_date),did);
MyDLJoin := Join(ta,MyDLSort,(integer)LEFT.did=RIGHT.did,MyDLTransform(left,right),Left outer,Keep(1), limit(0));

ta_Temp := if(include_dlinfo,MyDLJoin,ta);

// add crim indicators
recsIn := PROJECT(ta_Temp,TRANSFORM({doxie.Layout_HeaderFileSearch,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
ta_Temp1 := PROJECT(if(include_CriminalIndicators_val,recsOut,recsIn),doxie.Layout_HeaderFileSearch);
CriminalRecords_Services.MAC_CrimImage_Indicators(ta_Temp1,ta_Temp2);
ta_Final := if(includeCriminalImages,ta_Temp2,ta_Temp1);

// output(outf_raw,named('outf_raw'),extend);
// output(outf_raw_no_ph,named('outf_raw_no_ph'),extend);
// output(outf_no_ph,named('outf_no_ph'),extend);
// output(outf_raw_ph_ready,named('outf_raw_ph_ready'),extend);
// output(outf_raw_dates_rolled,named('outf_raw_dates_rolled'),extend);
// output(outf_raw_ph,named('outf_raw_ph'),extend);
// output(outf,named('outf'),extend);
// output(lookup_rec,named('lookup_rec'),extend);
// output(ta_Final,named('ta_Final'),extend);
RETURN ta_Final;

END;
