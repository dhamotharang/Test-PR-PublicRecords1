import Address, BIPV2, BIPV2_Best, BusinessBatch_BIP, BIPV2_Crosswalk, Doxie, dx_BestRecords;

export SingleView_Functions(BusinessBatch_Bip.iParam.SingleView.BatchParams inMod) := module

  shared mod_access := project(inMod, Doxie.IDataAccess);

  shared layout_name := record
    string fname;
    string mname;
    string lname;
    string suffix;
  end;

  shared layout_addr := record
    string prim_range;
    string predir;
    string prim_name;
    string addr_suffix;
    string postdir;
    string unit_desig;
    string sec_range;
    string p_city_name;
    string st;
    string z5;
    string zip4;
  end;

  // get a clean name from the input fields - if input is not sufficient, return an empty set
  shared dataset(layout_name) get_name(string f_nm, string m_nm, string l_nm, string sfx, string fullname) := function
    valid_full := trim(fullname, all) <> '';
    valid_part := trim(f_nm, all) <> '' and trim(l_nm, all) <> '';

    layout_name trans_full() := transform
      nm_clean := Address.GetCleanNameAddress.CleanPersonName(fullname, false);
      self.fname := nm_clean.fname;
      self.mname := nm_clean.mname;
      self.lname := nm_clean.lname;
      self.suffix := nm_clean.name_suffix;
    end;

    layout_name trans_part() := transform
      self.fname := trim(f_nm, left, right);
      self.mname := trim(m_nm, left, right);
      self.lname := trim(l_nm, left, right);
      self.suffix := trim(sfx, left, right);
    end;

    return map(valid_part => dataset([ row(trans_part()) ], layout_name), 
      valid_full => dataset([ row(trans_full()) ], layout_name), 
      dataset([], layout_name)
    );
  end;

  // get clean address from inputs - return empty set if input invalid
  shared dataset(layout_addr) get_addr(string staddr1, string staddr2, string city, string state, string zip) := function
    valid_street := trim(staddr1, all) <> '' or trim(staddr2, all) <> '';
    valid_zip := trim(zip, all) <> '';
    valid_cty_st := trim(city, all) <> '' and trim(state, all) <> '';

    layout_addr trans_addr() := transform
      a1 := trim(staddr1, left, right) + ' ' + trim(staddr2, left, right);
      a2 := trim(city, left, right) + ' ' + trim(state, left, right) + ' ' + trim(zip, left, right);
      a_clean := Address.getCleanAddress(a1, a2, Address.Components.Country.US).results;

      self.prim_range := a_clean.prim_range;
      self.predir := a_clean.predir;
      self.prim_name := a_clean.prim_name;
      self.addr_suffix := a_clean.suffix;
      self.postdir := a_clean.postdir;
      self.unit_desig := a_clean.unit_desig;
      self.sec_range := a_clean.sec_range;
      self.p_city_name := a_clean.p_city;
      self.st := a_clean.state;
      self.z5 := a_clean.zip;
      self.zip4 := a_clean.zip4;
    end;

    return if(valid_street and (valid_zip or valid_cty_st),
      dataset([ row(trans_addr()) ], layout_addr),
      dataset([], layout_addr)
    );
  end;

  export layout_crosswalk_ex := record(BIPV2_Crosswalk.IdLinkLayouts.crosswalkInput)
    // keep track of valid consumer and business inputs
    boolean _valid_c;
    boolean _valid_b;
  end;

  // convert to inputs for crosswalk BusinessLinks - set valid/invalid flags for consumer/business inputs
  export dataset(layout_crosswalk_ex) get_crosswalk_inputs(dataset(BusinessBatch_BIP.Layouts.SingleView.Input_Processed) batch_in) := function

    layout_crosswalk_ex crosswalk_trans(BusinessBatch_BIP.Layouts.SingleView.Input_Processed rin) := transform
      nm_clean := get_name(rin.name_first, rin.name_middle, rin.name_last, rin.name_suffix, 
        rin.unparsed_full_name)[1];
      ad_clean := get_addr(rin.street_address, rin.street_address2, rin.city, rin.state, rin.zip)[1];
      co_ad_clean := get_addr(rin.co_street_address, rin.co_street_address2, rin.co_city, rin.co_state, 
        rin.co_zip)[1];

      // check for valid inputs
      c_valid_name := nm_clean.fname <> '' and nm_clean.lname <> '';
      c_valid_addr := ad_clean.prim_name <> '' and ad_clean.prim_range <> '' 
        and ad_clean.z5 <> '';
      c_valid_ssn := trim(rin.ssn, all) <> '';

      b_valid_name := trim(rin.comp_name, all) <> '';
      b_valid_addr := co_ad_clean.prim_name <> '' and co_ad_clean.prim_range <> '' 
        and co_ad_clean.z5 <> '';

      // consumer inputs
      self.consumer.ssn := rin.ssn;
      self.consumer.dob := rin.dob;
      self.consumer.phone10 := rin.home_phone;
      self.consumer.fname := nm_clean.fname;
      self.consumer.mname := nm_clean.mname;
      self.consumer.lname := nm_clean.lname;
      self.consumer.suffix := nm_clean.suffix;
      self.consumer.prim_range := ad_clean.prim_range;
      self.consumer.predir := ad_clean.predir;
      self.consumer.prim_name := ad_clean.prim_name;
      self.consumer.addr_suffix := ad_clean.addr_suffix;
      self.consumer.postdir := ad_clean.postdir;
      self.consumer.unit_desig := ad_clean.unit_desig;
      self.consumer.sec_range := ad_clean.sec_range;
      self.consumer.p_city_name := ad_clean.p_city_name;
      self.consumer.st := ad_clean.st;
      self.consumer.z5 := ad_clean.z5;
      self.consumer.zip4 := ad_clean.zip4;
      self.consumer.email := rin.email_address;  
      self.consumer.did := rin.lex_id;

      // business inputs
      self.business.company_name := rin.comp_name;
      self.business.dba_name := rin.dba_name;
      self.business.prim_range := co_ad_clean.prim_range;
      self.business.prim_name := co_ad_clean.prim_name;
      self.business.sec_range := co_ad_clean.sec_range;
      self.business.city := co_ad_clean.p_city_name;
      self.business.state := co_ad_clean.st;
      self.business.zip5 := co_ad_clean.z5;
      self.business.phone10 := rin.co_phone;
      self.business.fein := rin.fein;
      self.business.email := rin.co_email_address;
      self.business.url := rin.co_url;
      self.business.proxid := rin.proxid;
      self.business.seleid := rin.seleid;

      self.request_id := (unsigned)rin.acctno;
      self._valid_c := c_valid_name and (c_valid_addr or c_valid_ssn);
      self._valid_b := b_valid_name and b_valid_addr;
      self := [];
    end;

    return project(batch_in, crosswalk_trans(left));

  end;

  // if insufficient consumer data is provided but a LexId exists - use person best to update
  export dataset(layout_crosswalk_ex) update_crosswalk_consumer(dataset(layout_crosswalk_ex) recs_in) := function

    ap_recs := recs_in(not _valid_c and consumer.did > 0);
    noap_recs := recs_in(_valid_c or consumer.did = 0);

    best_perm := dx_BestRecords.Functions.get_perm_type_idata(inMod, useMarketing := inMod.ExcludeMarketing);
    best_ap := dx_BestRecords.append(ap_recs, consumer.did, best_perm);

    layout_crosswalk_ex best_trans(recordof(best_ap) rin) := transform
      self.consumer.ssn := rin._best.ssn;
      self.consumer.dob := (string)rin._best.dob;
      self.consumer.fname := rin._best.fname;
      self.consumer.mname := rin._best.mname;
      self.consumer.lname := rin._best.lname;
      self.consumer.suffix := rin._best.name_suffix;
      self.consumer.prim_range := rin._best.prim_range;
      self.consumer.predir := rin._best.predir;
      self.consumer.prim_name := rin._best.prim_name;
      self.consumer.addr_suffix := rin._best.suffix;
      self.consumer.unit_desig := rin._best.unit_desig;
      self.consumer.sec_range := rin._best.sec_range;
      self.consumer.p_city_name := rin._best.city_name;
      self.consumer.st := rin._best.st;
      self.consumer.z5 := rin._best.zip;
      self.consumer.zip4 := rin._best.zip4;
      self._valid_c := rin._best.did > 0;
      self := rin;
    end;

    results_pre := project(best_ap, best_trans(left)) + noap_recs;
    results_valid := results_pre(_valid_c);
    results_clear := project(results_pre(not _valid_c), 
      transform(layout_crosswalk_ex, self.consumer := [], self := left));

    return results_valid + results_clear;

  end;

  // if insufficient business data is provided but a seleId exists - use business best to update
  export dataset(layout_crosswalk_ex) update_crosswalk_business(dataset(layout_crosswalk_ex) recs_in) := function

    legacy_mod := module
      Doxie.compliance.MAC_CopyComplianceValuesToLegacy(inMod);
    end;
    bipv2_mod := project(legacy_mod, BIPV2.mod_sources.iParams, opt);

    ap_recs := recs_in(not _valid_b and business.seleid > 0);
    noap_recs := recs_in(_valid_b or business.seleid = 0);

    pre_best := project(ap_recs,
      transform(BIPV2.IdLayouts.l_xlink_ids2,
        self.uniqueid := left.request_id,
        self.seleid := left.business.seleid, 
        self.proxid := left.business.proxid, 
        self := []
      )
    );
    best_raw := if(inMod.ExcludeMarketing, 
      BIPV2_Best.Key_linkIds.kfetch2Marketing(pre_best, bipv2.IDconstants.Fetch_Level_SELEID, 
        in_mod := bipv2_mod, includeStatus := false),
      BIPV2_Best.Key_LinkIds.kfetch2(pre_best, bipv2.IDconstants.Fetch_Level_SELEID, 
        in_mod := bipv2_mod, includeStatus := false))(proxid = 0);
    
    best_recs := dedup(best_raw, ultid, orgid, seleid, proxid, uniqueid);

    layout_crosswalk_ex best_trans(layout_crosswalk_ex l, recordof(best_recs) r) := transform
      self.business.company_name := r.company_name[1].company_name;
      self.business.prim_range := r.company_address[1].company_prim_range;
      self.business.prim_name := r.company_address[1].company_prim_name;
      self.business.sec_range := r.company_address[1].company_sec_range;
      self.business.city := r.company_address[1].company_p_city_name;
      self.business.state := r.company_address[1].company_st;
      self.business.zip5 := r.company_address[1].company_zip5;
      self.business.fein := r.company_fein[1].company_fein;
      self.business.proxid := r.proxid;
      self.business.seleid := r.seleid;
      self._valid_b := r.seleid > 0;
      self := l;
    end;

    best_out := join(ap_recs, best_recs, 
      left.request_id = right.uniqueid, 
      best_trans(left, right), 
      left outer, keep(1), limit(0)
    );

    results_pre := best_out + noap_recs;
    results_valid := results_pre(_valid_b);
    results_clear := project(results_pre(not _valid_b), 
      transform(layout_crosswalk_ex, self.business := [], self := left));

    return results_valid + results_clear;

  end;

end;
