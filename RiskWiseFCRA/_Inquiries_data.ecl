import doxie, fcra, inquiry_acclogs, riskwise, dx_Gong, risk_indicators, ut, mdr, dx_header, data_services;

EXPORT _Inquiries_data(  dataset (doxie.layout_references) bshell_dids,
                      dataset (fcra.Layout_override_flag) ds_flagfile
) := function

  unsigned1 iFcra := data_services.data_env.iFCRA;

  unsigned2 MAX_OVERRIDE_LIMIT := 100;

  temp := record
    Inquiry_AccLogs.Layout.Layout_inquiry_disclosure;
    unsigned inquiry_seq;
    // fields used for determining which gong record to return as the listed name
    unsigned dt_first_seen;
    unsigned dt_last_seen;
    unsigned fname_score;
    unsigned lname_score;
    // to help determine which record from phone table to return
    unsigned phone_table_dt_first_seen;
    unsigned lexid_from_inquiry_phone;

    unsigned DID_from_addr_search;
    string9 ssn_from_addr_search;
  end;

  inquiries_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.inquiries), flag_file_id );
  inquiries_correction_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.inquiries), trim(record_id) );
  inquiries_corr  := CHOOSEN(FCRA.key_override_inquiries_ffid( keyed( flag_file_id in inquiries_ffids ) ), MAX_OVERRIDE_LIMIT );

  // comment this out when inquiries override key is ready
  // inquiries_corr  := dataset([], recordof(FCRA.key_override_inquiries_ffid)) ;

  inquiry_main_raw  := join(bshell_dids, Inquiry_AccLogs.Key_FCRA_DID,
                          left.did<>0 and keyed(left.did=right.appended_adl)
                          and trim(right.search_info.transaction_id) not in inquiries_correction_keys
                          and (ut.DaysApart(ut.GetDate,right.search_info.datetime[1..8]) < ut.DaysInNYears(1) or
                               trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.employee_volunteer_purposes_set)
                          and (ut.DaysApart(ut.GetDate,right.search_info.datetime[1..8]) < ut.DaysInNYears(2) or
                               trim(right.permissions.fcra_purpose) NOT IN Inquiry_AccLogs.shell_constants.employee_volunteer_purposes_set)
                          and trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_permissible_purposes,
                          transform(Inquiry_AccLogs.Layout.Layout_inquiry_disclosure, self := right, self := []),
                          KEEP(100), atmost(riskwise.max_atmost));

  // add a sequence number to the inquiry records for deduping later
  with_seq := project(inquiry_main_raw, transform(temp, self.inquiry_seq := counter, self := left, self := []));

  with_gong_address := join(with_seq, dx_Gong.key_history_address(iFcra),
                    trim(left.person_q.prim_name)!='' and trim(left.person_q.zip5)!='' and
                    keyed(right.prim_name=left.person_q.prim_name) and keyed(right.st=left.person_q.st) and
                    keyed(right.z5=left.person_q.zip5) and
                    keyed(right.prim_range=left.person_q.prim_range) and left.person_q.sec_range=right.sec_range and
                    right.current_flag,
                    transform(temp,
                      self.dt_first_seen := (unsigned)right.dt_first_seen;
                      self.dt_last_seen := (unsigned)right.dt_last_seen;
                      self.fname_score := risk_indicators.FnameScore(left.person_q.fname, right.name_first);
                      self.lname_score := risk_indicators.LnameScore(left.person_q.lname, right.name_last);
                      self.address_characteristics.listed_phone := right.phone10;
                      self.address_characteristics.listed_phone_fname := right.name_first;
                      self.address_characteristics.listed_phone_lname := right.name_last;
                      self.address_characteristics.listed_phone_source := right.src;
                    self := left;
                    self := [];
                    ),
                    atmost(RiskWise.max_atmost),
                    keep(100), left outer);

// return the gong record with the closest matching name and then most recent record if there is still a tie
gong_deduped := dedup(sort(with_gong_address, inquiry_seq, -fname_score, -lname_score, -dt_last_seen, -dt_first_seen, -address_characteristics.listed_phone), inquiry_seq);

addr_prepped := project(gong_deduped,
transform(riskwisefcra.layouts.layout_addrflags_input,
  self.prim_range := left.person_q.prim_range ;
  self.predir := left.person_q.predir ;
  self.prim_name := left.person_q.prim_name ;
  self.suffix := left.person_q.addr_suffix ;
  self.postdir := left.person_q.postdir ;
  self.unit_desig := left.person_q.unit_desig ;
  self.sec_range := left.person_q.sec_range ;
  self.city_name := left.person_q.v_city_name ;
  self.st := left.person_q.st ;
  self.zip := left.person_q.zip5 ;
  self := [];
));

addr_flags := RiskWiseFCRA._address_flags(addr_prepped);

with_address_characteristics := join(gong_deduped, addr_flags,
      trim(left.person_q.prim_name)!='' and trim(left.person_q.zip5)!='' and
      right.zip=left.person_q.zip5 and
      right.prim_range=left.person_q.prim_range and
      right.predir=left.person_q.predir and
      right.prim_name=left.person_q.prim_name and
      right.suffix=left.person_q.addr_suffix and
      right.postdir=left.person_q.postdir and
      left.person_q.sec_range=right.sec_range,
      transform(temp, self.address_characteristics.addr_flags := right.addr_flags, self := left),
      left outer, keep(1));

with_telcordia := join(with_address_characteristics, risk_indicators.Key_FCRA_Telcordia_tpm_slim,
                        LEFT.person_q.personal_phone !='' AND
                        keyed(LEFT.person_q.personal_phone[1..3]=(RIGHT.npa)) and
                        keyed(LEFT.person_q.personal_phone[4..6]=RIGHT.nxx) and
                        KEYED(RIGHT.tb IN [LEFT.person_q.personal_phone[7]]),
                        transform(temp,
                          self.phone_characteristics.phone_type := right.nxx_type,
                          self.phone_characteristics.zipcode_phone_match := IF(left.person_q.personal_phone='', '',
                            if(left.person_q.zip5 in set(right.zipcodes, zip), 'Y', 'N'));
                          self := left),
                      left outer, atmost(riskwise.max_atmost), keep(1));

with_phone_indicator := join(with_telcordia, dx_Gong.key_phone_table(iFcra),
  LEFT.person_q.personal_phone !='' and
  keyed(LEFT.person_q.personal_phone = right.phone10),
  transform(temp,
    self.phone_table_dt_first_seen := right.dt_first_seen;
    // calculate hriskphoneflag and hphonetypeflag to be used to calculate the phone_indicator
    hriskphoneflag := risk_indicators.PRIIPhoneRiskFlag(LEFT.person_q.personal_phone).phoneRiskFlag(right.nxx_type, right.potDisconnect, right.sic_code);
    hphonetypeflag := risk_indicators.PRIIPhoneRiskFlag(LEFT.person_q.personal_phone).PWphoneRiskFlag(right.nxx_type, right.sic_code);
    self.phone_characteristics.phone_indicator := MAP(
      length(trim(LEFT.person_q.personal_phone)) < 6 or LEFT.person_q.personal_phone = '' => '6',
      hphonetypeflag='5' => '3',
      right.isaCompany => '1',
      hphonetypeflag in ['1','2','3','6','9','A'] => '4',
      ~right.isaCompany AND right.phone10<>'' => '2',
      right.nxx_type = '' => '0',
      '5');
    sic_description := risk_indicators.iid_constants.hri_sic_code_description(right.sic_code);
    self.phone_characteristics.highriskphone_description := sic_description;
    self.phone_characteristics.highriskphone_source := if(sic_description<>'', mdr.sourceTools.src_Gong_History, '');
    self := left),
    left outer, atmost(riskwise.max_atmost), keep(1));

phone_indicator_deduped := dedup(sort(with_phone_indicator, inquiry_seq, -dt_first_seen, -phone_characteristics.phone_indicator), inquiry_seq);


with_phone_listing := join(phone_indicator_deduped, dx_Gong.key_history_phone(iFcra),
  left.person_q.personal_phone<>''
  and keyed(right.p3=left.person_q.personal_phone[1..3]) and keyed(right.p7=left.person_q.personal_phone[4..10])
  and right.current_flag,
  transform(temp,
    self.LexIDs_per_inquiry_phone := if(right.did!=0 and right.current_flag and right.listing_type_res != '', 1, 0); //count only current non-business records
    self.LEXID_from_inquiry_phone := right.did;  // hang on to this to count up # of unique DIDs later
    self.phone_characteristics.listed_prim_range := right.prim_range;
    self.phone_characteristics.listed_predir := right.predir;
    self.phone_characteristics.listed_prim_name := right.prim_name;
    self.phone_characteristics.listed_suffix := right.suffix;
    self.phone_characteristics.listed_postdir := right.postdir;
    self.phone_characteristics.listed_unit_desig := right.unit_desig;
    self.phone_characteristics.listed_sec_range := right.sec_range;
    self.phone_characteristics.listed_city_name := right.p_city_name;
    self.phone_characteristics.listed_st := right.st;
    self.phone_characteristics.listed_zip := right.z5;
    self.phone_characteristics.listed_fname := right.name_first;
    self.phone_characteristics.listed_lname := right.name_last;
    self.phone_characteristics.listed_address_source := right.src;
    self.phone_characteristics.disconnects_last_12months := if(right.p7='', '', (string2)right.disc_cnt12);
    self.dt_first_seen := (unsigned)right.dt_first_seen;
    self.dt_last_seen := (unsigned)right.dt_last_seen;
    self.fname_score := risk_indicators.FnameScore(left.person_q.fname, right.name_first);
    self.lname_score := risk_indicators.LnameScore(left.person_q.lname, right.name_last);
    self := left;
  ), ATMOST(RiskWise.max_atmost),keep(100), left outer);

gong_phone_deduped := dedup(sort(with_phone_listing, inquiry_seq, -fname_score, -lname_score, -dt_last_seen, -dt_first_seen, -phone_characteristics.listed_fname), inquiry_seq);

temp roll_phone_dids(temp le, temp rt) := transform
  self.LexIDs_per_inquiry_phone := le.LexIDs_per_inquiry_phone+IF(le.LEXID_from_inquiry_phone=rt.LEXID_from_inquiry_phone,0,rt.LexIDs_per_inquiry_phone);  // don't increment if the DID is a duplicate
  self := rt;
end;
rolled_lexids_per_phone := rollup( group(sort(with_phone_listing, inquiry_seq, -LEXID_from_inquiry_phone),inquiry_seq), true, roll_phone_dids(left,right));

with_lexids_per_phone := join(gong_phone_deduped, rolled_lexids_per_phone,
  left.inquiry_seq=right.inquiry_seq,
    transform(temp, self.LexIDs_per_inquiry_phone := right.LexIDs_per_inquiry_phone, self := left));

with_Lexids_per_ssn := join(with_lexids_per_phone, risk_indicators.key_ssn_table_v4_filtered_fcra,
                   left.person_q.ssn!='' and keyed(left.person_q.ssn=right.ssn),
                   transform(temp,
                    self.lexids_per_inquiry_ssn := right.combo.didcount;
                    self := left;
                   ),
                   left outer, ATMOST(500), keep(1));

dk := choosen(dx_header.key_max_dt_last_seen(iFcra), 1);
header_build_date := (unsigned3)dk[1].max_date_last_seen[1..6];
key_header_address := dx_header.key_header_address(iFcra);
temp add_header_by_address(temp le, key_header_address rt) := transform
  self.DID_from_addr_search := rt.did;
  self.ssn_from_addr_search := rt.ssn;
  self.lexids_per_inquiry_address := if(rt.did!=0,1,0);
  self.ssns_per_inquiry_address := if(trim(rt.ssn)!='',1,0);
  self := le;
end;

header_by_inquiry_address := Join(with_Lexids_per_ssn, key_header_address,
                              left.person_q.prim_name!='' and left.person_q.zip5!='' and
                              keyed(left.person_q.prim_name=right.prim_name)/* and keyed(left.st=right.st)*/ and
                              keyed(left.person_q.zip5=right.zip) and keyed(left.person_q.prim_range=right.prim_range) and
                              keyed(left.person_q.sec_range=right.sec_range) and
                              left.person_q.predir=right.predir and left.person_q.postdir=right.postdir and
                              right.dt_last_seen>=header_build_date,

                            add_header_by_address(left,right), left outer,
                            atmost(left.person_q.prim_name=right.prim_name
                                    and left.person_q.zip5=right.zip
                                    and left.person_q.prim_range=right.prim_range
                                    and left.person_q.sec_range=right.sec_range, 2001),
                                    keep(2000));

// SSN per Address counts
counts_per_ssn := table(header_by_inquiry_address, {inquiry_seq, ssn_from_addr_search,
                              _ssns_per_addr := count(group, ssns_per_inquiry_address>0),
                              }, inquiry_seq, ssn_from_addr_search, few);

ssns_per_addr_counts := table(counts_per_ssn, {inquiry_seq,
                              ssns_per_inquiry_addr := count(group, _ssns_per_addr>0)},
                              inquiry_seq, few);


// ADL per address counts
counts_per_adl := table(header_by_inquiry_address, {inquiry_seq, DID_from_addr_search,
                              _adls_per_addr := count(group, lexids_per_inquiry_address>0)
                              }, inquiry_seq, DID_from_addr_search, few);

adls_per_addr_counts := table(counts_per_adl, {inquiry_seq,
                              lexids_per_inquiry_addr := count(group, _adls_per_addr>0)},
                              inquiry_seq, few);

// now append the adls_per_inquiry_addr and ssns_per_inquiry_addr back to the inquiries_main

with_ssns_per_addr := join(with_lexids_per_ssn, ssns_per_addr_counts, left.inquiry_seq=right.inquiry_seq,
  transform(temp,
    self.ssns_per_inquiry_address := right.ssns_per_inquiry_addr,
    self := left), left outer, keep(1));

with_lexids_per_inquiry_address := join(with_ssns_per_addr, adls_per_addr_counts, left.inquiry_seq=right.inquiry_seq,
  transform(temp,
    self.lexids_per_inquiry_address := right.lexids_per_inquiry_addr,
    self := left), left outer, keep(1));

inquiries_main := sort(project(with_lexids_per_inquiry_address, transform(Inquiry_AccLogs.Layout.Layout_inquiry_disclosure, self := left)), -search_info.datetime);

inquiry_recs1 := inquiries_main +
PROJECT( inquiries_corr,
transform( Inquiry_AccLogs.Layout.Layout_inquiry_disclosure,
          self := LEFT) );

final := sort( inquiry_recs1, -search_info.datetime);

// debugging section...
// output(inquiry_main_raw, named('inquiry_main_raw'));
// output(with_gong_address, named('with_gong_address'));
// output(gong_deduped, named('gong_deduped'));
// output(addr_prepped, named('addr_prepped'));
// output(addr_flags, named('addr_flags'));
// output(with_address_characteristics, named('with_address_characteristics'));
// output(with_telcordia, named('with_telcordia'));
// output(with_phone_indicator, named('with_phone_indicator'));
// output(phone_indicator_deduped, named('phone_indicator_deduped'));
// output(with_phone_listing, named('with_phone_listing'));
// output(gong_phone_deduped, named('gong_phone_deduped'));


// output(header_by_inquiry_address, named('header_by_inquiry_address'));
// output(counts_per_ssn, named('counts_per_ssn'));
// output(ssns_per_addr_counts, named('ssns_per_addr_counts'));
// output(counts_per_adl, named('counts_per_adl'));
// output(adls_per_addr_counts, named('adls_per_addr_counts'));
// output(with_ssns_per_addr, named('with_ssns_per_addr'));
// output(with_lexids_per_inquiry_address, named('with_lexids_per_inquiry_address'));

// output(inquiries_main, named('inquiries_main'));

return final;


end;
