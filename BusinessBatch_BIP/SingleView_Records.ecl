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
  export results() := function
    biz_consumer_ap := biz_links.ConsumerAppend();
    biz_bip_ap := biz_links.BipAppend();
    biz_summary := biz_links.summary;


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

    results_w_consumer := join(results_summary, biz_consumer_ap, 
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
  export contact_results() := function

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
  export business_results() := function

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
  // -------------------------------------------

end;
