import  doxie, suppress, dx_Gong, risk_indicators;

export Phone_Research_Records(Doxie.IDataAccess mod_access) := FUNCTION

  string3 area_code_value := '' : stored('AreaCode');
  string3 exchange_value := '' : stored('Exchange');

  hist_npa_nxx_key := dx_Gong.key_history_npa_nxx_line();
  hist_phone_key := dx_Gong.key_history_phone();
  npa_change_key := risk_indicators.Key_AreaCode_Change_plus;

  main_init := dataset([{area_code_value, exchange_value}],
  {string3 npa, string3 nxx});

  layout_phone_info get_npa_change(npa_change_key r) := transform
    self.npa := area_code_value,
    self.nxx := exchange_value,
    self.old_npa := r.new_npa,
    self.old_nxx := r.new_nxx,
    self := r,
  end;

  main_info := join(main_init, npa_change_key,
         keyed(left.npa=right.old_NPA) and
            keyed(left.nxx=right.old_NXX) and
         right.reverse_flag=true,
            get_npa_change(right), left outer, keep(1));

  disc_phones_raw := limit(hist_npa_nxx_key(keyed(npa=area_code_value),
    keyed(nxx=exchange_value), current_flag=false),
    400000, skip);

  optout_layout := RECORD
    string10 phone10;
    unsigned4 global_sid;
    unsigned8 record_sid;
    unsigned6 did;
  END;

  disc_phones_slim := project(disc_phones_raw, transform(optout_layout,
    self.global_sid := left.global_sid;
    self.record_sid := left.record_sid;
    self.did := left.did;
    self.phone10 := left.phone10;
  ));

  disc_phones := dedup(sort(disc_phones_slim, phone10), phone10);

  pre_disc_phones_final := join(disc_phones, hist_phone_key,
    keyed((left.phone10[4..10]) = right.p7) and
    keyed((left.phone10[1..3]) = right.p3) and
    right.current_flag=true,
    TRANSFORM(left), left only);

  disc_phones_final_optout := Suppress.MAC_SuppressSource(pre_disc_phones_final, mod_access);
  disc_phones_final := PROJECT(disc_phones_final_optout, {string10 phone10});

  output(main_info, named('AreacodeChangeInfo'));

  RETURN disc_phones_final;
END;
