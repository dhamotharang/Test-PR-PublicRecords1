IMPORT dx_Gong, roxiekeybuild, ut, data_services, promotesupers, watchdog, strata;

unsigned1 i_FCRA := Data_Services.data_env.iFCRA;

//data_root is for test build purposes: prepends all index names with a prefix
EXPORT proc_build_history_keys(string rundate) := FUNCTION

  //logical files' common prefix (old and new format)
  prefix                    := '~thor_data400::key::gong_history::' + rundate + '::';
  prefix_fcra               := '~thor_data400::key::gong_history::fcra::' + rundate + '::';
  name_history_address      := prefix + 'address';
  name_history_phone        := prefix + 'phone';
  name_history_did          := prefix + 'did';
  name_history_hhid         := prefix + 'hhid';
  name_history_bdid         := prefix + 'bdid';
  name_history_name         := prefix + 'name';
  name_history_clean_name   := prefix + 'cleanname';
  name_history_zip_name     := prefix + 'zip_name';
  name_history_npa_nxx_line := prefix + 'npa_nxx_line';
  name_history_surname      := prefix + 'surnames';
  name_history_wdtg         := prefix + 'wdtg';
  name_history_companyname  := prefix + 'companyname';
  name_history_city_st_name := prefix + 'city_st_name';
  name_history_wild_name_zip:= prefix + 'wild_name_zip';
  name_history_LinkIDs      := prefix + 'linkids';
  name_history_address_fcra := prefix_fcra + 'address';
  name_history_phone_fcra   := prefix_fcra + 'phone';
  name_history_did_fcra     := prefix_fcra + 'did';
  name_did                  := '~thor_data400::key::gong_weekly::'+rundate+'::did';
  name_hhid                 := '~thor_data400::key::gong_weekly::'+rundate+'::hhid';
  name_cn                   := '~thor_data400::key::gong_weekly::'+rundate+'::cn';
  name_cn_to_company        := '~thor_data400::key::gong_weekly::'+rundate+'::cn_to_company';
  name_phone10_v2           := '~thor_data400::key::business_header::'+rundate+'::hri::phone10_v2';
  name_phone10_v2_ft_fcra   := '~thor_data400::key::business_header::filtered::fcra::'+rundate+'::hri::phone10_v2';

  // Build gong_did base file
  g_did                     := Watchdog.DID_Gong;
  ut.mac_SF_Move('~thor_data400::base::gong_did','P',mv_gong2prod);

  // Build keys with history naming convention
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_address(),       Gong_Neustar.data_key_history_address(),       '', name_history_address,       bk_addr);
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_phone(),         Gong_Neustar.data_key_history_phone,           '', name_history_phone,         bk_phone);
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_did(),           Gong_Neustar.data_key_history_did,             '', name_history_did,           bk_did);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_hhid(),          Gong_Neustar.data_key_history_hhid,            '', name_history_hhid,          bk_hhid);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_bdid(),          Gong_Neustar.data_key_history_bdid,            '', name_history_bdid,          bk_bdid);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_name(),          Gong_Neustar.data_key_history_name,            '', name_history_name,          bk_name);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_clean_name(),    Gong_Neustar.data_key_history_CleanName,       '', name_history_clean_name,    bk_clnname);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_zip_name(),      Gong_Neustar.data_key_history_zip_name,        '', name_history_zip_name,      bk_zip_name);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_npa_nxx_line(),  Gong_Neustar.data_key_history_npa_nxx_line,    '', name_history_npa_nxx_line,  bk_npa_nxx_line);
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_surname(),       Gong_Neustar.data_key_history_surname,         '', name_history_surname,       bk_surname);          
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_wdtg(),          Gong_Neustar.data_key_wdtgGong,                '', name_history_wdtg,          bk_wdtg);           
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_companyname(),   Gong_Neustar.data_key_history_companyname,     '', name_history_companyname,   bk_cmp_name);           
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_city_st_name(),  Gong_Neustar.data_key_history_city_st_name,    '', name_history_city_st_name,  bk_csn);           
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_wild_name_zip(), Gong_Neustar.data_key_history_wild_name_zip,   '', name_history_wild_name_zip, bk_wnzip);           
  RoxieKeybuild.MAC_build_logical(dx_Gong.key_history_LinkIDs.key,     Gong_Neustar.data_key_history_LinkIDs,         '', name_history_LinkIDs,       bk_LinkIDs);           
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_address(i_FCRA), Gong_Neustar.data_key_history_address(i_FCRA), '', name_history_address_fcra, bk_fcra_addr);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_phone(i_FCRA),   Gong_Neustar.data_key_fcra_history_phone,      '', name_history_phone_fcra, bk_fcra_phone);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_history_did(i_FCRA),     Gong_Neustar.data_key_fcra_history_did,        '', name_history_did_fcra, bk_fcra_did);

  // Build keys with weekly naming convention and business header keys
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_did(),                   Gong_Neustar.data_key_did,                     '', name_did,                bk_did_curr);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_hhid(),                  Gong_Neustar.data_key_hhid,                    '', name_hhid,               bk_hhid_curr);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_cn(),                    Gong_Neustar.data_key_cn,                      '', name_cn,                 bk_cn);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_cn_to_company(),         Gong_Neustar.data_key_cn_to_company,           '', name_cn_to_company,      bk_cn_to_company);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_phone_table(),        Gong_Neustar.data_key_phone_table(),        '', name_phone10_v2,         Buildkey6);
  // RoxieKeyBuild.MAC_build_logical(dx_Gong.key_phone_table(i_FCRA),     $.data_key_phone_table(i_FCRA),       '', name_phone10_v2_ft,      BuildFCRAkey5);
  RoxieKeyBuild.MAC_build_logical(dx_Gong.key_phone_table(i_FCRA),  Gong_Neustar.data_key_phone_table(i_FCRA, TRUE), '', name_phone10_v2_ft_fcra, Build2ndFCRAkey5);

  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_address,       name_history_address,       mv1_addr);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_phone,         name_history_phone,         mv1_phone);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_did,           name_history_did,           mv1_did);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_hhid,          name_history_hhid,          mv1_hhid);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_bdid,          name_history_bdid,          mv1_bdid);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_name,          name_history_name,          mv1_name);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_clean_name,    name_history_clean_name,    mv1_clnname);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_zip_name,      name_history_zip_name,      mv1_zip_name);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_npa_nxx_line,  name_history_npa_nxx_line,  mv1_npa_nxx_line);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_surname,       name_history_surname,       mv1_surname);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_wdtg,          name_history_wdtg,          mv1_wdtg);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_companyname,   name_history_companyname,   mv1_cmp_name);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_city_st_name,  name_history_city_st_name,  mv1_csn);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_wild_name_zip, name_history_wild_name_zip, mv1_wnzip);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_LinkIDs,       name_history_LinkIDs,       mv1_linkids);

// moved from full keys build - needs history completed to create 
  RoxieKeyBuild.Mac_SK_Move_To_Built(name_did,           dx_Gong.names('').i_did,              mv_did, 3);
  RoxieKeyBuild.Mac_SK_Move_To_Built(name_hhid,          dx_Gong.names('').i_hhid,             mv_hhid, 3);
  RoxieKeyBuild.Mac_SK_Move_To_Built(name_cn,            dx_Gong.names('').i_cn,               mv_cn, 3);
  RoxieKeyBuild.Mac_SK_Move_To_Built(name_cn_to_company, dx_Gong.names('').i_cn_to_company,    mv_cn_to_company, 3);
  RoxieKeyBuild.Mac_SK_Move_To_Built(name_phone10_v2,    dx_Gong.names('').i_phone_table,      MoveKeyToBuilt6);
  // RoxieKeyBuild.Mac_SK_Move_To_Built(name_phone10_v2_ft, dx_Gong.names('').i_phone_table_ft,   MoveFCRAKeyToBuilt5);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_phone_table_ft_fcra, name_phone10_v2_ft_fcra, Move2ndFCRAKeyToBuilt5);

  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_address_fcra, name_history_address_fcra, mv1_fcra_addr);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_phone_fcra, name_history_phone_fcra, mv1_fcra_phone);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_history_did_fcra, name_history_did_fcra, mv1_fcra_did);

  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_address,       'Q', mk_addr);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_phone,         'Q', mk_phone);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_did,           'Q', mk_did);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_hhid,          'Q', mk_hhid);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_bdid,          'Q', mk_bdid);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_name,          'Q', mk_name);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_clean_name,    'Q', mk_clnname);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_zip_name,      'Q', mk_zip_name);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_npa_nxx_line,  'Q', mk_npa_nxx_line);
  RoxieKeyBuild.MAC_SK_Move_v2(dx_Gong.names('').i_history_surname,       'Q', mk_surname);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_wdtg,          'Q', mk_wdtg);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_companyname,   'Q', mk_cmp_name);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_city_st_name,  'Q', mk_csn);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_wild_name_zip, 'Q', mk_wnzip);
  promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_history_LinkIDs,       'Q', mk_LinkIDs);

// moved from full keys build - needs history completed to create 
  roxiekeybuild.mac_sk_move(dx_Gong.names('').i_did,            'Q', out1);
  roxiekeybuild.mac_sk_move(dx_Gong.names('').i_hhid,           'Q', out2);
  roxiekeybuild.mac_sk_move(dx_Gong.names('').i_cn,             'Q', out12);
  roxiekeybuild.mac_sk_move(dx_Gong.names('').i_cn_to_company,  'Q', out13);
  roxiekeybuild.mac_sk_move(dx_Gong.names('').i_phone_table,    'Q', MoveKeyToQA2);
  RoxieKeyBuild.MAC_SK_Move_v2(dx_Gong.names('').i_phone_table_ft_fcra, 'Q', Move2ndFCRAKeyToQA3);
  RoxieKeyBuild.MAC_SK_Move_v2(dx_Gong.names('').i_history_address_fcra, 'Q', mk_fcra_addr);
  RoxieKeyBuild.MAC_SK_Move_v2(dx_Gong.names('').i_history_phone_fcra, 'Q', mk_fcra_phone);                 
  RoxieKeyBuild.MAC_SK_Move_v2(dx_Gong.names('').i_history_did_fcra, 'Q', mk_fcra_did);                 

  //Verify deprecated fields are blank or zero
  cnt_fcra_address := OUTPUT(strata.macf_pops(dx_Gong.key_history_address(i_FCRA),,,,,,FALSE,
                                                          ['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
                                                           'see_also_text']));
  cnt_fcra_did     := OUTPUT(strata.macf_pops(dx_Gong.key_history_did(i_FCRA),,,,,,FALSE,
                                                          ['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
                                                           'see_also_text']));
  cnt_fcra_phone   := OUTPUT(strata.macf_pops(dx_Gong.key_history_phone(i_FCRA),,,,,,FALSE,
                                                          ['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
                                                           'see_also_text']));

                 
  bk := PARALLEL (bk_addr, bk_phone, bk_did,
                  bk_hhid, bk_bdid, bk_name, bk_clnname, bk_zip_name, bk_npa_nxx_line,
                  bk_surname, bk_wdtg, bk_cmp_name, bk_csn, bk_wnzip, 
                  bk_did_curr, bk_hhid_curr, Buildkey6, bk_cn, bk_cn_to_company, Build2ndFCRAkey5,
                  bk_LinkIDs,
                  bk_fcra_addr, bk_fcra_phone, bk_fcra_did
  );

  mv1 := PARALLEL(mv1_addr, mv1_phone, mv1_did,
                  mv1_hhid, mv1_bdid, mv1_name, mv1_clnname, mv1_zip_name, mv1_npa_nxx_line,
                  mv1_surname, mv1_wdtg, mv1_cmp_name, mv1_csn, mv1_wnzip,
                  mv_did, mv_hhid, MoveKeyToBuilt6, mv_cn, mv_cn_to_company, Move2ndFCRAKeyToBuilt5,
                  mv1_linkids,
                  mv1_fcra_addr, mv1_fcra_phone, mv1_fcra_did
  );

  mk := PARALLEL (mk_addr, mk_phone, mk_did,
                  mk_hhid, mk_bdid, mk_name, mk_clnname, mk_zip_name, mk_npa_nxx_line,
                  mk_surname, mk_wdtg, mk_cmp_name, mk_csn, mk_wnzip,
                  out1, out2, out12, out13, MoveKeyToQA2, Move2ndFCRAKeyToQA3,
                  mk_LinkIDs,
                  mk_fcra_addr, mk_fcra_phone, mk_fcra_did
  );

  //Verify deprecated fields are blank or zero
  fcra_deprecate_stats := PARALLEL(cnt_fcra_address, cnt_fcra_did, cnt_fcra_phone);

  build_keys := SEQUENTIAL( g_did, mv_gong2prod,     // Gong_did base file
    bk, 
    mv1, 
    mk,
    fcra_deprecate_stats
   );

  RETURN build_keys;
END;
