IMPORT BatchServices, iesp, Address, Gateway, AutoStandardI, Doxie_Raw, Royalty, doxie, dx_gateway, STD;
EXPORT FN_AppendQSentDetails(dataset(progressive_phone.layout_progressive_batch_in) f_in_raw,
  dataset(progressive_phone.layout_progressive_phone_batch_with_details_out) finalout_without_qsent,
  doxie.IDataAccess mod_access,
  DATASET(Gateway.Layouts.Config) QSENTV2_GW = Gateway.Constants.void_gateway,
  STRING QSentV2_SearchType = '') := FUNCTION
  
  boolean SkipPhoneScoring := false : stored('SkipPhoneScoring');
  boolean keep_all_phone := false : stored('KeepSamePhoneInDiffLevels');
  integer max_phone_count := 1000 : stored('MaxPhoneCount');
  g_mod := AutoStandardI.GlobalModule();
  
  DO_QSENTV2_NAME_ADDR := QSentV2_SearchType = batchServices.constants.RealTime.SearchType.NAME_ADDR;
  DO_QSENTV2_NAME_SSN  := QSentV2_SearchType = batchServices.constants.RealTime.SearchType.NAME_SSN;
  
  layout_hist_phone := record
    string20  acctno;
    string10  hist_phone;
    unsigned1 sort_order;
  end;

  layout_hist_phone get_hist_phone(f_in_raw l, unsigned1 cnt) := transform
    self.acctno := l.acctno;
    self.hist_phone := map( // TODO: CHOSE would be more effective here
      cnt=1 => l.phoneno_1,
      cnt=2 => l.phoneno_2,
      cnt=3 => l.phoneno_3,
      cnt=4 => l.phoneno_4, 
      cnt=5 => l.phoneno_5,
      cnt=6 => l.phoneno_6, 
      cnt=7 => l.phoneno_7,
      cnt=8 => l.phoneno_8,
      cnt=9 => l.phoneno_9,
      cnt=10 => l.phoneno_10,
      cnt=11 => l.phoneno_11,
      cnt=12 => l.phoneno_12,
      cnt=13 => l.phoneno_13,
      cnt=14 => l.phoneno_14,
      cnt=15 => l.phoneno_15,
      cnt=16 => l.phoneno_16,
      cnt=17 => l.phoneno_17,
      cnt=18 => l.phoneno_18,
      cnt=19 => l.phoneno_19,
      cnt=20 => l.phoneno_20,
      cnt=21 => l.phoneno_21,
      cnt=22 => l.phoneno_22,
      cnt=23 => l.phoneno_23,
      cnt=24 => l.phoneno_24,
      cnt=25 => l.phoneno_25,
      cnt=26 => l.phoneno_26,
      cnt=27 => l.phoneno_27,
      cnt=28 => l.phoneno_28,
      cnt=29 => l.phoneno_29,
      cnt=30 => l.phoneno_30,
      l.phoneno);
    self.sort_order := cnt;
  end;
  input_dedup := normalize(f_in_raw, 31, get_hist_phone(left, counter))(hist_phone<>'');

  layout_hist_phone phone_trans_dedupe(finalout_without_qsent l, unsigned1 cnt) := transform
    self.acctno := l.acctno;
    self.hist_phone := l.subj_phone10;
    self.sort_order := 31+l.sort_order;
  end;
  without_qsent_dedup := project(finalout_without_qsent, phone_trans_dedupe(left, counter));
  without_qsent_dedup_srt := sort((without_qsent_dedup + input_dedup), acctno, sort_order);

  gw_layout := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

  gw_layout_out := record   //temporary structure to hold all resulting rows for each request (acct).
    string20 acctno;
    dataset(gw_layout) gw_results {maxcount(batchServices.constants.RealTime.REALTIME_PHONE_LIMIT)};
  end;
  
  gw_layout_out getGateway(recordof(f_in_raw) L) := TRANSFORM
    rtp_mod := MODULE(project(g_mod,BatchServices.RealTimePhones_Params.params,opt))
      // DEFAULTS
      export boolean failOnError := FALSE;  //True fails the entire batch, do not want that to happen when one address has the ST of GU
      export string5 serviceType := 'iQ411';
      export string20 acctno := L.acctno;
      export boolean TUGatewayPhoneticMatch := TRUE;
      export boolean UseQSENTV2 := TRUE;
      export unsigned8 MaxResults := batchServices.constants.RealTime.REALTIME_PHONE_LIMIT;
      // export unsigned1 RecordCount := batchServices.constants.RealTime.REALTIME_Record_default : stored('MaxPhoneCount');
      // EXCLUDED PHONES
      ds_ExcludedPhone := PROJECT(without_qsent_dedup_srt(acctno = L.acctno), TRANSFORM(iesp.share.t_StringArrayItem, SELF.Value := LEFT.hist_phone;));
      export dataset(iesp.share.t_StringArrayItem) ExcludedPhones := if(DO_QSENTV2_NAME_ADDR OR DO_QSENTV2_NAME_SSN,
                                                                        CHOOSEN(ds_ExcludedPhone, iesp.Constants.MAX_EXCLUDED_PHONES),
                                                                        DATASET([], iesp.share.t_StringArrayItem));
      // NAME
      export string30 firstname	:= L.name_first;
      export string30 lastname  := L.name_last;
      // ADDR
      export string200 addr := if(DO_QSENTV2_NAME_ADDR,Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.unit_desig, L.sec_range),'');
      export string25 city  := if(DO_QSENTV2_NAME_ADDR,L.p_city_name,'');
      export string2 state  := if(DO_QSENTV2_NAME_ADDR,L.st,'');
      export string6 zip    := if(DO_QSENTV2_NAME_ADDR,L.z5,'');
      // SSN
      export string11 ssn := if(DO_QSENTV2_NAME_SSN,L.ssn,'');
    end;

    call_gateway := ((DO_QSENTV2_NAME_ADDR OR DO_QSENTV2_NAME_SSN) AND COUNT(QSENTV2_GW) > 0);
    gw_res := IF(call_gateway, choosen(Doxie_Raw.RealTimePhones_Raw(rtp_mod, QSENTV2_GW, 30, 0, call_gateway), rtp_mod.MaxResults));

    self.gw_results := project(gw_res, gw_layout);													 
    self.acctno := L.acctno;
    self := L;
  end;

  f_in_raw_clean := dx_gateway.parser_qsent_raw.CleanRawRequest(f_in_raw, mod_access);
  gw_out := project(f_in_raw_clean, getGateway(LEFT));

  gw_layout flat_recs(gw_layout_out L, gw_layout R) := transform
    self.acctno := L.acctno; // input values from parent
    self := R; // 1 child result per record
  end;

  // flatten results for batch output
  gw_out_flat := NORMALIZE(gw_out, LEFT.gw_results, flat_recs(LEFT, RIGHT));
  gw_out_clean := dx_gateway.parser_qsent_raw.CleanRawResponse(gw_out_flat, mod_access);
  
  TrimUpper(string input) := TRIM(STD.STR.ToUpperCase(input),LEFT,RIGHT);
  progressive_phone.layout_progressive_phone_batch_with_details_out batchit(gw_layout L) := transform
    ///////// progressive_phone.layout_progressive_batch_out_with_did (reuse fields for QSENT results)
    self.acctno := L.acctno;
    self.matchcodes := '';
    self.error_code := 0;
    self.subj_first := TrimUpper(L.fname);
    self.subj_middle := TrimUpper(L.mname);
    self.subj_last := TrimUpper(L.lname);
    self.subj_suffix := TrimUpper(L.name_suffix);
    self.subj_phone10 := TrimUpper(L.phone);
    self.subj_name_dual := TrimUpper(STD.STR.CleanSpaces(L.lname + ' ' + L.fname + ' '+ L.mname));
    // self.subj_phone_type := '';
    // self.subj_date_first := '';
    // self.subj_date_last := '';
    // self.phpl_phones_plus_type := '';
    // self.phpl_phone_carrier := '';
    // self.phpl_carrier_city := '';
    // self.phpl_carrier_state  := '';
    // self.subj_phone_type_new := '';
    // self.switch_type := '';
    self.sort_order := 0;
    self.sort_order_internal := 0;
    // self.sub_rule_number := '';
    // self.dup_phone_flag := '';
    // self.vendor := '';		
    // self.subj_phone_relationship := '';
    // self.phone_score := '';  
    self.prim_range := TrimUpper(L.prim_range);
    self.predir := TrimUpper(L.predir);
    self.prim_name := TrimUpper(L.prim_name);
    self.addr_suffix := TrimUpper(L.suffix);
    self.postdir := TrimUpper(L.postdir);
    self.unit_desig := TrimUpper(L.unit_desig);
    self.sec_range := TrimUpper(L.sec_range);
    self.p_city_name := TrimUpper(L.city_name);
    // self.v_city_name := '';
    self.st := TrimUpper(L.st);
    self.zip5 := TrimUpper(L.zip);
    self.ssn := TrimUpper(L.ssn);
    // self.p_name_last := '';
    // self.p_name_first := '';
    // self.VanityCities := '';
    // self.subj_phone_date_last := '';
    self.did := TrimUpper(L.did);
    // self.p_did := '';
    
    ///////// BatchServices.Layouts.RTPhones.rec_output_internal;
    // self.acctno := L.acctno ;
    // self.ssn := L.ssn;
    // self.phone :=  L.phone ;                            
    // self.name :=   STD.STR.CleanSpaces(L.lname + ' ' + L.fname + ' '+ L.mname);
    self.callerid_name := TrimUpper(L.listed_name);
    self.address := 
      TrimUpper(STD.STR.CleanSpaces(L.prim_range+ ' ' + 
        L.predir +' ' + 
        L.prim_name +' ' + 
        L.suffix + ' ' + 
        L.postdir + ' ' + 
        L.unit_desig + ' ' + 
        L.sec_range));	
    // self.city :=  L.city_name ;
    // self.state :=  L.st ;
    self.zip :=  L.zip + L.zip4 ;
    self.congressional_district := TrimUpper(L.RealTimePhone_Ext.CongressionalDistrict);
    self.carrier_route := TrimUpper(L.RealTimePhone_Ext.carrierroute);
    self.sort_zone := TrimUpper(L.RealTimePhone_Ext.sortzone);
    self.fips := TrimUpper(L.RealTimePhone_Ext.CountyCode);
    self.msa := TrimUpper(L.RealTimePhone_Ext.MetroStatAreaCode);
    self.cmsa := TrimUpper(L.RealTimePhone_Ext.ConsMetroStatAreaCode);
    cDate := TrimUpper(iesp.ECL2ESP.t_DateToString8(L.RealTimePhone_Ext.ListingCreationDate));
    self.listing_creation_date := cDate[5..8] + cDate[1..4];
    tDate := TrimUpper(iesp.ECL2ESP.t_DateToString8(L.RealTimePhone_Ext.ListingTransactionDate));
    self.listing_transaction_date := tDate[5..8] + tDate[1..4];
    /////////	
    // self.dt_last_seen := tDate;
    self.subj_date_last := tDate;
    // self.dt_first_seen := cDate;
    self.subj_date_first := cDate;
    /////////
    self.address_type := TrimUpper(L.caption_text);
    self.source := TrimUpper(L.new_type);
    self.carrier_info := TrimUpper(L.carrier_name);
    self.line_type := TrimUpper(L.RealTimePhone_Ext.DataSource);
    self.phone_line_status := TrimUpper(L.RealTimePhone_Ext.StatusCode_Desc); //this isn't filled by "ecl_gateway_wrapper" when its a Statelisting 
    self.phone_listing_type := TrimUpper(L.RealTimePhone_Ext.listingtype);
    self.non_published := TrimUpper(L.RealTimePhone_Ext.NonPublished);
    self.ported := CASE(L.RealTimePhone_Ext.portingcode
      ,'0'=>'U'
      ,'1'=>'Y'
      ,'2'=>'N'
      ,'');
    self.operating_company_name := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.name);
    self.operating_company_affiliated_to := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.AffiliatedTo);
    self.operating_company_address := 
      TrimUpper(STD.STR.CleanSpaces(
        L.RealTimePhone_Ext.OperatingCompany.address.StreetNumber+ ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.StreetPreDirection +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.StreetName +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.Streetsuffix + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.Streetpostdirection + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.unitdesignation  + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.address.unitNumber));
    self.operating_company_city := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.address.city);
    self.operating_company_state := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.address.state);
    self.operating_company_zip := 
      TrimUpper(L.RealTimePhone_Ext.OperatingCompany.address.zip5 + 
        L.RealTimePhone_Ext.OperatingCompany.address.zip4);
    self.operating_company_phone := 
      TrimUpper(L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNPA +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNXX +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneLine);
    self.operating_company_fax := 
      TrimUpper(L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNPA +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNXX +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxLine);
    self.operating_company_contact := 
      TrimUpper(if (length(trim(L.RealTimePhone_Ext.OperatingCompany.contact.name.fullname)) > 0 ,
        L.RealTimePhone_Ext.OperatingCompany.contact.name.fullname,
        STD.STR.CleanSpaces(
          L.RealTimePhone_Ext.OperatingCompany.contact.name.fname + ' ' +
          L.RealTimePhone_Ext.OperatingCompany.contact.name.mname + ' ' +
          L.RealTimePhone_Ext.OperatingCompany.contact.name.lname)));
    self.company_contact_email := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.contact.email);
    self.company_contact_address := 
      TrimUpper(STD.STR.CleanSpaces(
        L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetNumber+ ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetPreDirection +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetName +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.Streetsuffix + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.Streetpostdirection + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.unitdesignation  + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.unitNumber));
    self.company_contact_city := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.contact.address.city);
    self.company_contact_state := TrimUpper(L.RealTimePhone_Ext.OperatingCompany.contact.address.state);
    self.company_contact_zip := 
      TrimUpper(L.RealTimePhone_Ext.OperatingCompany.contact.address.zip5 +
        L.RealTimePhone_Ext.OperatingCompany.contact.address.zip4);
      
    self := L.RealTimePhone_Ext;
    // self.responsestatus := '';
    self.TypeFlag := TrimUpper(L.typeflag);
    self.qsent_sort_order := 1;
    self.royalty_type := if (self.typeFlag = 'I',	Royalty.Constants.RoyaltyType.QSENT_IQ411,Royalty.Constants.RoyaltyType.QSENT_PVS ); 
    self := L;	
    self := []; 
  end;
  gw_out_qsent := project(gw_out_clean, batchit(LEFT));
  
  // Combine QSent results with progressive_phone_with_details results and re-apply deduping logic
  //   Dedup is being executed again since a client can send in 30 phones to dedup on or use the
  //   combination of input phones plus progressive phone results (up to a total of 15) to pass into
  //   the QSent gateway.  Since QSent can only handle 15 at this time, there is the chance of getting 
  //   a phone from QSent that exists in our progressive phone results thus needing to be deduped.
  out_with_qsent := gw_out_qsent + finalout_without_qsent;
  out_with_qsent_srt := sort(out_with_qsent, acctno, subj_phone10, -qsent_sort_order, -subj_date_last, -subj_date_first, -ssn, -prim_name, -p_city_name, -zip5, -subj_last, -subj_first);
  out_with_qsent_dedup := if(keep_all_phone, out_with_qsent_srt, dedup(out_with_qsent_srt, acctno, subj_phone10));
  out_with_qsent_grp := group(out_with_qsent_dedup, acctno);

  out_with_qsent_legacy := TopN(out_with_qsent_grp, max_phone_count, 
                                acctno, -qsent_sort_order, sort_order, sort_order_internal, -subj_date_last, subj_name_dual, subj_phone10,-did, subj_date_first);	
  out_with_qsent_scored := TopN(out_with_qsent_grp, max_phone_count, 
                                acctno, -qsent_sort_order, -phone_score, sort_order, sort_order_internal, -subj_date_last, subj_name_dual, subj_phone10,-did, subj_date_first);
  out_AppendQSentDetails := IF(SkipPhoneScoring = TRUE, out_with_qsent_legacy, SORT(out_with_qsent_scored, -qsent_sort_order, -phone_score));

  // TESTING //////////////////////////////////////
  // output(f_in_raw, named('f_in_raw'));
  // output(f_in_raw_clean, named('f_in_raw_clean'));
  // output(QSENTV2_GW,named('QSENTV2_GW'));
  // output(without_qsent_dedup_srt,named('without_qsent_dedup_srt'));
  // output(gw_out,named('gw_out'));
  // output(gw_out_flat,named('gw_out_flat'));
  // output(gw_out_clean,named('gw_out_clean'));
  // output(gw_out_qsent,named('gw_out_qsent'));
  // output(finalout_without_qsent,named('finalout_without_qsent'));
  // output(out_AppendQSentDetails,named('out_AppendQSentDetails'));
  /////////////////////////////////////////////////

  return out_AppendQSentDetails;
END;
