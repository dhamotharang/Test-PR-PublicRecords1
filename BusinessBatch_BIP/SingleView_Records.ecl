import AutoKeyI, BusinessBatch_BIP, BIPV2_Crosswalk, doxie_cbrs, Std;

export SingleView_Records(dataset(BusinessBatch_BIP.Layouts.SingleView.Input_Processed) batch_in,
  BusinessBatch_Bip.iParam.SingleView.BatchParams inMod) :=
module

  shared current_date := Std.Date.Today();

  shared sv_func := $.SingleView_Functions(inMod);

  // clean, convert and, in some cases, enhance the inputs for the CrossWalk core service
  cw_input_0 := sv_func.get_crosswalk_inputs(batch_in);
  cw_input_1 := sv_func.update_crosswalk_consumer(cw_input_0);
  shared cw_input_final := sv_func.update_crosswalk_business(cw_input_1);

  // get crosswalk results - marketing restriction will be determined from mod_access
  shared biz_links := BIPV2_Crosswalk.BusinessLinks(cw_input_final, 
    consumerScore := inMod.Score_Threshold, 
    bipScore := inMod.Biz_Score_Threshold, 
    mod_access := inMod);

  shared layout_title := record
    string title;
    unsigned dt_first_seen;
    unsigned dt_last_seen;
    unsigned rank;
  end;

  // dataset used to roll up linked business entries
  shared layout_business_ex := record(BusinessBatch_BIP.Layouts.SingleView.Business_Best)
    dataset(layout_title) _titles;
    layout_title _display_title;
    unsigned2 request_id;
    unsigned _seq;
    unsigned _best_dt;
    unsigned _dt_rank;
  end;


  // main summary results
  // ------------------------------------------
  linking_results() := function
    biz_consumer_ap := biz_links.ConsumerAppend();
    biz_bip_ap := biz_links.BipAppend();
    biz_summary := biz_links.summary;
    biz_verify := biz_links.VerifyInputs();


    // add business summary elements and restore original acctno
    BusinessBatch_BIP.Layouts.SingleView.Output_Summary summary_trans_0(BusinessBatch_BIP.Layouts.SingleView.Input_Processed l, 
      recordof(biz_summary) r) := transform
      self.acctno := l.orig_acctno;
      self.request_id := (unsigned)l.acctno;
      self.input_is_linked := r.input_is_linked;
      self.linked_business_count := r.cnt_linked_business;
      self.linked_contact_count := r.cnt_contacts;
      self.contact_lexid_count := r.cnt_contact_lexid;
      self.contact_no_lexid_count := r.cnt_contact_no_lexid;
      self := [];
    end;

    results_summary := join(batch_in, biz_summary, 
      (unsigned)left.acctno = right.request_id, 
      summary_trans_0(left, right), 
      left outer, keep(1), limit(0)
    );


    // add verification info to business summary
    BusinessBatch_BIP.Layouts.SingleView.Output_Summary verify_trans(BusinessBatch_BIP.Layouts.SingleView.Output_Summary l, 
      recordof(biz_verify) r) := transform
      self.match_first_last_name := r.first_last_name;
      self.match_first_name := r.first_name;
      self.match_last_name := r.last_name;
      self.match_first_bus_name_addr1 := r.first_bus_name_addr1;
      self.match_last_bus_name_addr1 := r.last_bus_name_addr1;
      self.match_first_bus_name := r.first_bus_name;
      self.match_last_bus_name := r.last_bus_name;
      self.match_addr1 := r.addr1;
      self.match_bus_addr1 := r.bus_addr1;
      self.match_ssn := r.ssn;
      self.match_ssn_fein := r.ssn_fein;
      self.match_phone := r.phone;
      self.match_bus_phone := r.bus_phone;
      self := l;
    end;

    results_verify := join(results_summary, biz_verify, 
      left.request_id = right.request_id, 
      verify_trans(left, right), 
      left outer, keep(1), limit(0)
    );


    // add appended consumer best data
    BusinessBatch_BIP.Layouts.SingleView.Output_Summary summary_trans_1(BusinessBatch_BIP.Layouts.SingleView.Output_Summary l, 
      recordof(biz_consumer_ap) r) := transform
      self.best_name_first := r.fname;
      self.best_name_middle := r.mname;
      self.best_name_last := r.lname;
      self.best_name_suffix := r.suffix;
      self.best_prim_range := r.prim_range;
      self.best_predir := r.predir;
      self.best_prim_name := r.prim_name;
      self.best_addr_suffix := r.addr_suffix;
      self.best_unit_desig := r.unit_desig;
      self.best_sec_range := r.sec_range;
      self.best_city := r.p_city_name;
      self.best_state := r.st;
      self.best_zip := r.z5;
      self.best_zip4 := r.zip4;
      self.best_home_phone := r.phone10;
      self.lex_id := r.did;
      self := l;
    end;

    results_w_consumer := join(results_verify, biz_consumer_ap, 
      left.request_id = right.seq, 
      summary_trans_1(left, right), 
      left outer, keep(1), limit(0)
    );


    // add appended business best data
    BusinessBatch_BIP.Layouts.SingleView.Output_Summary summary_trans_2(BusinessBatch_BIP.Layouts.SingleView.Output_Summary l, 
      recordof(biz_bip_ap) r) := transform
      self.best_co_name := r.company_name;
      self.best_co_prim_range := r.prim_range;
      self.best_co_predir := r.predir;
      self.best_co_prim_name := r.prim_name;
      self.best_co_addr_suffix := r.addr_suffix;
      self.best_co_unit_desig := r.unit_desig;
      self.best_co_sec_range := r.sec_range;
      self.best_co_city := r.p_city_name;
      self.best_co_state := r.st;
      self.best_co_zip := r.zip;
      self.best_co_zip4 := r.zip4;
      self.best_co_phone := r.company_phone;
      self.ultid := r.ultid;
      self.orgid := r.orgid;
      self.seleid := r.seleid;
      self.proxid := r.proxid;
      self.powid := r.powid;
      self := l;
    end;
    
    results_w_biz := join(results_w_consumer, biz_bip_ap, 
      left.request_id = right.request_id, 
      summary_trans_2(left, right), 
      left outer, keep(1), limit(0)
    );

    // check the matching request to determine if it was valid and, if so, what type
    // was the request (consumer only, business only, consumer and business)
    // status and error_code are set here
    results_out := join(results_w_biz, cw_input_final, 
      left.request_id = right.request_id, 
      transform(BusinessBatch_BIP.Layouts.SingleView.Output_Summary, 
        status_val := map(right._valid_c and right._valid_b => 'consumer_business_link', 
          right._valid_c => 'consumer_only_link', 
          right._valid_b => 'business_only_link', 
          'invalid_input'
        );
        self.status := status_val, 
        self.error_code := if(status_val = 'invalid_input', 
          AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT, 
          0);
        self := left
      ), 
      left outer, keep(1), limit(0)
    );

    // debug outputs
    //output(cw_input_0, named('CW_Input_Raw'));
    //output(cw_input_1, named('CW_Input_C'));
    //output(cw_input_final, named('CW_Input_CB'));

    //output(biz_consumer_ap, named('CW_Consumer_Append'));
    //output(biz_bip_ap, named('CW_Business_Append'));
    //output(biz_linked_business, named('CW_Linked_Businesses'));
    //output(biz_linked_contact, named('CW_Linked_Contacts'));
    //output(biz_summary, named('CW_Summary'));

    return results_out;

  end;
  // -------------------------------------------


  // linked contact results
  // -------------------------------------------
  contact_results() := function

    biz_linked_contact := biz_links.contacts();

    limit_dt := Std.Date.AdjustDate(current_date, -inMod.History_Limit_Years);

    BusinessBatch_BIP.Layouts.SingleView.Output_Consumer contact_trans(BusinessBatch_BIP.Layouts.SingleView.Input_Processed l, 
      recordof(biz_linked_contact) r) := transform
      latest_dt := if(r.dt_last_seen_at_business > r.dt_first_seen_at_business, 
        r.dt_last_seen_at_business, 
        r.dt_first_seen_at_business
      );
      // records that are too old should be dropped
      within_limit := latest_dt = 0 or limit_dt < latest_dt;

      self.acctno := l.orig_acctno;
      self.request_id := if(within_limit, (unsigned)l.acctno, skip);
      self.best_name_first := r.fname;
      self.best_name_middle := r.mname;
      self.best_name_last := r.lname;
      self.best_name_suffix := r.name_suffix;
      self.best_prim_range := r.prim_range;
      self.best_prim_name := r.prim_name;
      self.best_sec_range := r.sec_range;
      self.best_city := r.city;
      self.best_state := r.state;
      self.best_zip := r.zip;
      self.best_home_phone := r.phone;
      self.lex_id := r.did;
      self.empid := r.empid;
      self.job_title1 := r.job_title1;
      self.job_title2 := r.job_title2;
      self.job_title3 := r.job_title3;
      self.dt_first_seen := if(r.dt_first_seen_at_business > 0, (string)r.dt_first_seen_at_business, '');
      self.dt_last_seen := if(r.dt_last_seen_at_business > 0, (string)r.dt_last_seen_at_business, '');
      self := [];
    end;

    // restore original acctno and format the linked contacts for output
    results_out := join(batch_in, biz_linked_contact, 
      (unsigned)left.acctno = right.request_id, 
      contact_trans(left, right), 
      limit(BusinessBatch_BIP.Constants.SingleView.MaxLinkedPerRequest));

    return results_out;

  end;
  // -------------------------------------------


  // linked business results
  // -------------------------------------
  business_results() := function

    biz_linked_business := biz_links.businesses();

    limit_dt := Std.Date.AdjustDate(current_date, -inMod.History_Limit_Years);
    dt_24 := Std.Date.AdjustDate(current_date, 0, -24);
    dt_84 := Std.Date.AdjustDate(current_date, 0, -84);

    str_date(unsigned dt) := if(dt > 0, (string)dt, '');


    // first convert to internal format
    layout_business_ex bus_trans_convert(recordof(biz_linked_business) rin, unsigned ct) := transform
      valid_company := trim(rin.company_name, all) <> '';
      b_dt := if(rin.last_seen_at_business > rin.first_seen_at_business, 
        rin.last_seen_at_business, rin.first_seen_at_business);

      // as with many BIP services, if a valid company name is not present, we will drop the record
      self.request_id := if(valid_company, rin.request_id, skip);
      self.best_co_name := rin.company_name;
      self.best_co_prim_range := rin.prim_range;
      self.best_co_prim_name := rin.prim_name;
      self.best_co_sec_range := rin.sec_range;
      self.best_co_city := rin.city;
      self.best_co_state := rin.state;
      self.best_co_zip := rin.zip;
      self.best_co_phone := rin.company_phone;
      self.ultid := rin.ultid;
      self.orgid := rin.orgid;
      self.seleid := rin.seleid;
      self.proxid := rin.proxid;
      self.powid := rin.powid;
      self._display_title.title := rin.title;
      self._display_title.dt_first_seen := rin.first_seen_at_business;
      self._display_title.dt_last_seen := rin.last_seen_at_business;
      self._display_title.rank := if(trim(rin.title, all) <> '',100,101);
      self._best_dt := b_dt;
      self._dt_rank := map(b_dt >= dt_24 => 0, b_dt >= dt_84 => 1, 2);
      self._seq := ct;
      self := [];
    end;

    results_cvt := project(biz_linked_business, bus_trans_convert(left, counter));


    // rank and standardize executive titles
    results_rank := join(results_cvt, doxie_cbrs.executive_titles,
      trim(left._display_title.title, left, right) = right.stored_title,
      transform(layout_business_ex,
        self._display_title.title := if(right.display_title <> '', right.display_title, left._display_title.title),
        self._display_title.rank := if(right.display_title <> '', right.title_rank, left._display_title.rank);
        self := left),
      left outer);

    // order by date bucket, title rank and latest date - beyond that preserve the original order
    results_srtd := sort(results_rank, 
      request_id, ultid, orgid, seleid, _dt_rank, _display_title.rank, -_best_dt, _seq
    );


    // eliminate undesirable records here (either empty recs or those prior to our history limit)
    layout_business_ex bus_trans_preroll(layout_business_ex rin) := transform
      rt := rin._display_title;
      dt := rin._best_dt;
      empty_rec := trim(rt.title, all) = '' and dt = 0;
      valid_dt := dt > limit_dt or dt = 0;

      self.request_id := if(not empty_rec and valid_dt, rin.request_id, skip);
      self._titles := 
        dataset([ {rt.title, rt.dt_first_seen, rt.dt_last_seen, 0} ], layout_title);
      self := rin;
    end;

    results_filt := project(results_srtd, bus_trans_preroll(left));


    // roll up the display_title buckets
    layout_business_ex bus_trans_roll(layout_business_ex l, layout_business_ex r) := transform
      self._titles := l._titles + r._titles;
      self := l;
    end;

    results_rolled := rollup(results_filt, bus_trans_roll(left, right), request_id, ultid, orgid, seleid);


    // finalize the output
    BusinessBatch_BIP.Layouts.SingleView.Output_Business bus_trans_out(BusinessBatch_BIP.Layouts.SingleView.Input_Processed l, 
      layout_business_ex r) := transform
      ttls_d := dedup(r._titles, all);

      self.acctno := l.orig_acctno;
      self.request_id := r.request_id;
      self.job_title1 := ttls_d[1].title;
      self.job_title2 := ttls_d[2].title;
      self.job_title3 := ttls_d[3].title;
      self.dt_first_seen1 := str_date(ttls_d[1].dt_first_seen);
      self.dt_first_seen2 := str_date(ttls_d[2].dt_first_seen);
      self.dt_first_seen3 := str_date(ttls_d[3].dt_first_seen);
      self.dt_last_seen1 := str_date(ttls_d[1].dt_last_seen);
      self.dt_last_seen2 := str_date(ttls_d[2].dt_last_seen);
      self.dt_last_seen3 := str_date(ttls_d[3].dt_last_seen);
      self := r;
    end;

    results_out := join(batch_in, results_rolled, 
      (unsigned)left.acctno = right.request_id, 
      bus_trans_out(left, right), limit(BusinessBatch_BIP.Constants.SingleView.MaxLinkedPerRequest)
    );

    //output(results_cvt, named('BR_results_converted'));
    //output(results_srtd, named('BR_results_sorted'));
    //output(results_filt, named('BR_results_filtered'));
    //output(results_rolled, named('BR_results_rolled'));

    return results_out;

  end;

  // combined results
  // -------------------------------------
  export combined_results() := function

    l_res := linking_results();
    b_res := business_results();
    c_res := contact_results();

    l_combined := project(l_res, 
      transform(BusinessBatch_BIP.Layouts.SingleView.Output_Combined, 
        self.record_type := $.Constants.SingleView.LinkingRecordType, 
        self := left, 
        self := []
      )
    );

    BusinessBatch_BIP.Layouts.SingleView.Output_Combined b_trans(BusinessBatch_BIP.Layouts.SingleView.Output_Business l) := transform
      self.record_type := $.Constants.SingleView.BusinessRecordType;
      self.acctno := l.acctno;
      self.request_id := l.request_id;
      self.b_best_co_name := l.best_co_name;
      self.b_best_co_prim_range := l.best_co_prim_range;
      self.b_best_co_predir := l.best_co_predir;
      self.b_best_co_prim_name := l.best_co_prim_name;
      self.b_best_co_addr_suffix := l.best_co_addr_suffix;
      self.b_best_co_unit_desig := l.best_co_unit_desig;
      self.b_best_co_sec_range := l.best_co_sec_range;
      self.b_best_co_city := l.best_co_city;
      self.b_best_co_state := l.best_co_state;
      self.b_best_co_zip := l.best_co_zip;
      self.b_best_co_zip4 := l.best_co_zip4;
      self.b_best_co_phone := l.best_co_phone;
      self.b_ultid := l.ultid;
      self.b_orgid := l.orgid;
      self.b_seleid := l.seleid;
      self.b_proxid := l.proxid;
      self.b_powid := l.powid;
      self.b_job_title1 := l.job_title1;
      self.b_dt_first_seen1 := l.dt_first_seen1;
      self.b_dt_last_seen1 := l.dt_last_seen1;
      self.b_job_title2 := l.job_title2;
      self.b_dt_first_seen2 := l.dt_first_seen2;
      self.b_dt_last_seen2 := l.dt_last_seen2;
      self.b_job_title3 := l.job_title3;
      self.b_dt_first_seen3 := l.dt_first_seen3;
      self.b_dt_last_seen3 := l.dt_last_seen3;
      self := [];
    end;
    b_combined := project(b_res, b_trans(left));

    BusinessBatch_BIP.Layouts.SingleView.Output_Combined c_trans(BusinessBatch_BIP.Layouts.SingleView.Output_Consumer l) := transform
      self.record_type := $.Constants.SingleView.ContactRecordType;
      self.acctno := l.acctno;
      self.request_id := l.request_id;
      self.c_best_name_first := l.best_name_first;
      self.c_best_name_middle := l.best_name_middle;
      self.c_best_name_last := l.best_name_last;
      self.c_best_name_suffix := l.best_name_suffix;
      self.c_best_prim_range := l.best_prim_range;
      self.c_best_predir := l.best_predir;
      self.c_best_prim_name := l.best_prim_name;
      self.c_best_addr_suffix := l.best_addr_suffix;
      self.c_best_unit_desig := l.best_unit_desig;
      self.c_best_sec_range := l.best_sec_range;
      self.c_best_city := l.best_city;
      self.c_best_state := l.best_state;
      self.c_best_zip := l.best_zip;
      self.c_best_zip4 := l.best_zip4;
      self.c_best_home_phone := l.best_home_phone;
      self.c_lex_id := l.lex_id;
      self.c_empid := l.empid;
      self.c_job_title1 := l.job_title1;
      self.c_job_title2 := l.job_title2;
      self.c_job_title3 := l.job_title3;
      self.c_dt_first_seen := l.dt_first_seen;
      self.c_dt_last_seen := l.dt_last_seen;
      self := [];
    end;
    c_combined := project(c_res, c_trans(left));

    l_grp := group(sort(l_combined, acctno, request_id), acctno);
    b_grp := group(sort(b_combined, acctno, request_id), acctno);
    c_grp := group(sort(c_combined, acctno, request_id), acctno);

    l_limit := topn(l_grp, inMod.MaxResultsPerAcct, acctno);
    b_limit := topn(b_grp, inMod.MaxBusinessesPerAcct, acctno);
    c_limit := topn(c_grp, inMod.MaxContactsPerAcct, acctno);

    combined_all := ungroup(l_limit) & ungroup(b_limit) & ungroup(c_limit);

    return combined_all;

  end;
  // -------------------------------------------

end;
