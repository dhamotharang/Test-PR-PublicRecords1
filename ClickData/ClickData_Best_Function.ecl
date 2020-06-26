import doxie, didville, address, ut, dx_Gong, Marketing_Best, dx_header;

Loadxml('<FOO/>');

export ClickData_Best_Function(
  dataset(clickdata.Layout_ClickData_In) inf,
  doxie.IDataAccess mod_access,
  boolean append_bests,
  boolean include_demographics = false,
  boolean enhanced_search = false,
  Zip_Radius = 0) := function

  seqrec := record
    inf;
    unsigned4	seq;
  end;

  r := record
    didville.layout_did_outbatch;
    string10  best_prim_range := '';
    string28  best_prim_name := '';
    string8 	best_sec_range := '';
    unsigned3	best_addr_date_first_seen := 0;
  end;

  seqrec into_seq(inf L, integer C) := transform
    self.seq := C;

    self.dob := L.dob;

    // Name bit
    to_clean := IF(L.full_name='',L.unParsedFullName,L.full_name);
    isParsed := L.Name_Last<>'' OR L.Name_First<>'';

    clean_name := IF(~isParsed, address.CleanPerson73(to_clean), '');
    self.name_first := IF(isParsed, L.Name_First, clean_name[6..25]);
    self.name_middle := IF(isParsed, L.Name_Middle, clean_name[26..45]);
    self.name_last := IF(isParsed, L.Name_Last, clean_name[46..65]);
    self.Name_Suffix := IF(isParsed, L.Name_Suffix, clean_name[66..70]);

    // just put the address bits into 1 set of fields
    SELF.addr1 := IF(L.addr1='',L.unParsedAddr1,L.addr1);
    SELF.city := IF(L.city='',L.p_city_name,l.city);
    SELF.state := IF(L.state='',L.st,L.state);
    SELF.zip := IF(L.zip='',L.z5,L.zip);
    self := l;
  end;

  df := project(inf, into_seq(LEFT,COUNTER));

  didville.layout_did_outbatch into_outbatch(df L) := transform
    clean_address := Address.CleanAddress182(L.addr1, address.Addr2FromComponents(L.city, L.state, L.zip));
    ut.MAC_Insert_CleanAddrs(clean_address,'P')

    self.phone10 := L.phone;

    SELF.fname := L.Name_First;
    SELF.mname := L.Name_MIddle;
    SELF.lname := L.Name_Last;
    SELF.suffix := L.Name_Suffix;

    SELF := L;
    self := [];
  end;


  df2_a := project(df(addr1<>''),into_outbatch(LEFT));

  didville.layout_did_outbatch noparse(df L) := transform
    SELF.prim_range := L.prim_range;
    SELF.predir := L.predir;
    SELF.prim_name := L.prim_name;
    SELF.addr_suffix := L.suffix;
    SELF.postdir := L.postdir;
    SELF.unit_desig := L.unit_desig;
    SELF.sec_range := L.sec_range;
    SELF.p_city_name := L.city;
    SELF.st := L.state;
    SELF.z5 := L.zip;
    SELF.zip4 := L.zip4;

    self.phone10 := L.phone;

    SELF.fname := L.Name_First;
    SELF.mname := L.Name_MIddle;
    SELF.lname := L.Name_Last;
    SELF.suffix := L.Name_Suffix;

    SELF := L;
    SELF := [];
  end;

  df2_b := PROJECT(df(addr1=''), noparse(LEFT));

  df2 := df2_a+df2_b;

  didville.MAC_DidAppend(df2,outf0,true,'ZG');

  //Expanded Search:
  outf0_enhanced := clickdata.ClickData_Enhanced_Search(df2, ungroup(outf0), zip_radius);

  outf0_final := if(enhanced_search, group(sort(outf0_enhanced, SEQ), SEQ), outf0);

  didville.MAC_HHid_Append(outf0_final, 'HHID_RELATIVES', outf0a);

  // Append another version of HHID, also add if they've asked for EDA
  outf0b := didville.HHID_Append(outf0a);
  outf0c := didville.Gong_Append(outf0b, mod_access, true);
  //NOTE Gong must go here do not move it.
  temp :=	project(outf0c,transform(r,self:=left));

  didville.MAC_BestAppend(temp,
                          'BEST_ALL',
                          'BEST_ALL',
                          0,
                          false,
                          outf1,
                          true,
                          doxie.DataRestriction.fixed_DRM,
                          ,
                          ,
                          true,
                          ,
                          mod_access.application_type,
                          ,
                          mod_access.industry_class);

  key_lookups := dx_header.key_did_lookups();
  r get_head_cnt(outf1 L, key_lookups R) := transform
    self.head_cnt := R.head_cnt;
    self := L;
  end;

  outf3 := join(outf1, key_lookups,
          left.did != 0 and
          keyed(left.did = right.did),
        get_head_cnt(LEFT,RIGHT),
        limit(0), keep(1),
        left outer);

  outseq := record
    clickdata.Layout_ClickData_Out_Ext;
    unsigned4	seq;
    string10  best_prim_range;
    string28  best_prim_name;
    string8 	best_sec_range;
  end;

  outseq_optout_layout := RECORD
    outseq;
    unsigned4 global_sid := 0;
    unsigned8 record_sid := 0;
    unsigned6 key_did := 0;
  END;

  outseq into_out(outf3 L, df R) := transform
    self.best_name_score 	   	:= IF (L.did=0, '', intformat(L.verify_best_name,3,1));
    self.best_title  			:= if (append_bests, L.best_title, '');
    self.best_Fname 			:= if (append_bests, L.best_fname, '');
    self.best_mname			:= if (append_bests, L.best_mname, '');
    self.best_lname			:= if (append_bests, L.best_lname, '');
    self.best_suffix			:= if (append_bests, L.best_name_suffix, '');
    self.best_address_score 	   	:= IF (L.did=0, '', intformat(L.verify_best_address,3,1));
    self.best_prim_range	:= if (append_bests, L.best_prim_range, '');
    self.best_prim_name	:= if (append_bests, L.best_prim_name, '');
    self.best_sec_range	:= if (append_bests, L.best_sec_range, '');
    self.best_addr1			:= if (append_bests, L.best_addr1, '');
    self.best_city				:= if (append_bests, L.best_city, '');
    self.best_state			:= if (append_bests, L.best_state, '');
    self.best_zip				:= if (append_bests and L.best_zip<>'' and L.best_zip4<>'', L.best_zip + '-' + L.best_zip4, '');
    self.best_phone_score	   	:= intformat(did_add.phone_match_score(L.phone10,L.best_phone),3,1);
    self.best_phone			:= L.best_phone;
    self.best_dob				:= L.best_dob;
    self.best_Addr_Date 		:= if (L.did = 0, '', intformat(L.best_addr_date,6,1));
    self.best_Addr_Date_first_seen := if (L.did = 0, '', intformat(L.best_addr_date_first_seen,6,1));
    self.adl 			   		:= if (L.did = 0, '', intformat(L.did, 12,1));
    self.hhid 				:= if (L.hhid = 0, '', intformat(L.hhid, 12, 1));
    self.num_header_recs 		:= if (L.did = 0, '', intformat(L.head_Cnt, 4, 1));
    self.eda_connect			:= '';
    self.eda_disconnect			:= '';
    self.score := IF (L.did=0, '', intformat(L.score,3,1));
    self.score_any_ssn := IF (L.did=0, '', intformat(L.score_any_ssn,3,1));
    self.score_any_addr := IF (L.did=0, '', intformat(L.score_any_addr,3,1));
    self.score_any_dob := IF (L.did=0, '', intformat(L.score_any_dob,3,1));
    self.score_any_phn := IF (L.did=0, '', intformat(L.score_any_phn,3,1));
    self.score_any_fzzy := IF (L.did=0, '', intformat(L.score_any_fzzy,3,1));
    self := R;
    self := [];
  end;

  outf4 := join(outf3, df,
          left.seq = right.seq,
        into_out(LEFT,RIGHT), LOOKUP);

  Key_History_Hhid := dx_Gong.key_history_hhid();
  outseq_optout_layout get_EDA(outseq L, Key_History_Hhid R) := transform
    self.eda_connect := R.dt_first_seen;
    self.eda_disconnect := R.deletion_date;
    self.global_sid := R.global_sid;
    self.record_sid := R.record_sid;
    self.key_did := R.did;
    self := l;
  end;

  Key_History_Did := dx_Gong.key_history_did();
  outseq_optout_layout get_EDA_Did(outseq_optout_layout L, Key_History_Did R) := transform
    self.eda_connect := R.dt_first_seen;
    self.eda_disconnect := R.deletion_date;
    self.global_sid := R.global_sid;
    self.record_sid := R.record_sid;
    self.key_did := R.did;
    self := l;
  end;

  outf5a := join(outf4, key_history_hhid,
          keyed((integer)Left.hhid = right.s_hhid),
        get_EDA(LEFT,RIGHT), left outer, KEEP(20));

  pre_outf5 := join(outf5a(eda_connect = ''), Key_History_Did,
          keyed((integer)Left.adl = right.l_did),
        get_EDA_Did(LEFT,RIGHT), left outer, KEEP(20)) + outf5a(eda_connect != '');

  // We can apply suppression here because the key data for outf5a is either completely intact or replaced.
  outf5_optout := Suppress.MAC_FlagSuppressedSource(pre_outf5, mod_access, key_did);
  outf5 := PROJECT(outf5_optout, TRANSFORM(outseq,
    self.eda_connect := if(LEFT.is_suppressed, '',  LEFT.eda_connect),
    self.eda_disconnect := if(LEFT.is_suppressed, '', LEFT.eda_disconnect),
    self := LEFT));

  outf5 roll_EDA(outf5 L, outf5 R) := transform
    self.eda_connect := if ((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.eda_connect or (integer)R.eda_connect = 0, L.eda_connect, R.eda_connect);
    self.eda_disconnect := if ((integer)L.eda_disconnect > (integer)R.eda_disconnect, L.eda_disconnect, R.eda_disconnect);
    self := l;
  end;

  outf6 := rollup(outf5, true, Roll_EDA(LEFT,RIGHT));

  boolean Chr2Bool(string1 chr) := chr='Y' or chr='1';

  outf6 get_dlb(outf6 L, Marketing_Best.key_equifax_DID R) := transform
    self.age := R.age_1;
    self.gender := R.gender_1;
    self.outdoors_dimension_household := Chr2Bool(R.outdoors_dimension_household);
    self.athletic_dimension_household := Chr2Bool(R.athletic_dimension_household);
    self.fitness_dimension_household 	:= Chr2Bool(R.fitness_dimension_household);
    self.domestic_dimension_household := Chr2Bool(R.domestic_dimension_household);
    self.good_life_dimension_household := Chr2Bool(R.good_life_dimension_household);
    self.cultural_dimension_household := Chr2Bool(R.cultural_dimension_household);
    self.blue_chip_dimension_household := Chr2Bool(R.blue_chip_dimension_household);
    self.do_it_yourself_dimension_household := Chr2Bool(R.do_it_yourself_dimension_household);
    self.technology_dimension_household := Chr2Bool(R.technology_dimension_household);
    self.credit_card_usage_miscellaneous := Chr2Bool(R.credit_card_usage_miscellaneous);
    self.credit_card_usage_standard_retail := Chr2Bool(R.credit_card_usage_standard_retail);
    self.credit_card_usage_standard_specialty_card := Chr2Bool(R.credit_card_usage_standard_specialty_card);
    self.credit_card_usage_upscale_retail := Chr2Bool(R.credit_card_usage_upscale_retail);
    self.credit_card_usage_upscale_spec_retail := Chr2Bool(R.credit_card_usage_upscale_spec_retail);
    self.credit_card_usage_bank_card := Chr2Bool(R.credit_card_usage_bank_card);
    self.credit_card_usage_oil_gas_card := Chr2Bool(R.credit_card_usage_oil__gas_card);
    self.credit_card_usage_Finance_Co_Card :=	Chr2Bool(R.credit_card_usage_Finance_Co_Card);
    self.credit_card_usage_Travel_Entertainment := Chr2Bool(R.credit_card_usage_Travel__Entertainment);
    self := R;
    self := L;
  end;

  // join by DID and address as we may have one DID to many households
  outf7 := join(outf6, Marketing_Best.key_equifax_DID,
                keyed((integer)left.adl = right.l_did) and
                left.best_prim_range = right.prim_range and
                left.best_prim_name = right.prim_name and
                left.best_city = right.p_city_name and
                left.best_state = right.st and
                left.best_sec_range = right.sec_range,
                get_dlb(LEFT, RIGHT),
                left outer, KEEP(1), limit(0));

  outf8 := if(include_demographics, outf7, outf6);

  outf9 := project(outf8, transform(clickdata.Layout_ClickData_Out_Ext, self := LEFT));

  clickdata.Layout_ClickData_Out_Ext markEnhancedSearch(outf8 L, outf0 R) := transform
    self.enhanced_srch := R.did = 0 and L.adl <> '';  //all DIDs will be 0 from the right
                                                     //if from extended search
    self := L;
  end;

  outf10 := join(outf8, outf0, left.seq = right.seq and left.adl = intformat(right.did, 12, 1),
                                          markEnhancedSearch(left, right),
                                          left outer);

  results_rec := if(enhanced_search, outf10, group(outf9));
  //For Debug:
  // output(df2, named('df2'));
  // output(outf0, named('outf0'));
  // output(outf0_enhanced, named('outf0_enhanced'));

  return results_rec;

end;
