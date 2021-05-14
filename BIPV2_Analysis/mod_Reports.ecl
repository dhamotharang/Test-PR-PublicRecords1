//IMPORT BIPV2, MDR, Visualizer, STD, ut;
IMPORT BIPV2, MDR, STD, ut;

  // Notes
  // - Filter PO Box-related ULs to separate output?
  // - _X for _A vs _H (vs U vs F), comparisons across fields for candidates
  // - Scaling for rec cnt and field pop %
  // - Max score still "row too large"?
  // - Loc ID instead of Addr?
  // - Blank Name / ProxID not found by service?  Thin pop filtered from keys?
  //
  // - LocID - Coming to BIP?  Same location with diff street addr?  SR 9 v Roswell Road?
  // - Combo - Diff name/same addr/same biz type (ING Financial & Voya Financial at same place same time), Diff name/same addr/same biz type (Gordon Painting v A1 Painting)
  // - Date  - Check overlap / Coexistence - MinDtFirst/MaxDtLast - If name/addr mismatch but dateoverlap on the other, extra credit?
  // - Name  - Any token of one cnp_name/prim_name within the other? Expensive, somewhat risky, sometimes helpful (John Gordon v Gordon Painting; Tamiani v Tamiani Estate; etc.)
  // - Addr  - Filter Street Type (Street/St,Avenue/Ave,Trail/Trl,etc.) or directions (North/N,Northwest/NW,West/W,etc.)?  Cleaner should do this?  Some sneaking through?
  // - Addr  - PO Box conflict or no?
  // - Name  - Filter fluff words/abbrs?
  //   - Business: Incorporated/Inc/Corporation/Corp, LLC/L.L.C., Company/Co, Services/Svcs, Com (.com), Tech?(nology,nical...?)
  //   - Personal: Mr/Mrs/Ms/Jr/Sr, but leave profession-related: Dr, DDS, DVM, CPA, Atty, etc.?
  // - Prop  - Conf prop penalties

 
EXPORT mod_Reports(STRING rpt_ver_in = '', STRING bld_ver_in = '') := MODULE // STRING bld_wu_in = '', STRING bld_user_in = ''
 
  // ---------------------------------------------------------------------
  // Config
  // ---------------------------------------------------------------------
  EXPORT build_ds                 := BIPV2.CommonBase.DS_Built;   // DS_Base   (QA)
  EXPORT build_fn                 := BIPV2.CommonBase.File_Built; // File_Base (QA)
  //EXPORT outfile_prefix           := '~temp::pml::BIPV2_ProxID::reports::';
  EXPORT outfile_prefix           := '~thor_data400::BIPV2::ProxID::reports::';
  EXPORT outfile_suffix           := '_full'; // '_full', '_sample', etc.
  EXPORT persist_prefix           := REGEXREPLACE('temp',outfile_prefix,'temp::persist::full'); //PML reset this // ::full, ::sample, etc.
  EXPORT persist_expire           := 32; // : PERSIST(persist_prefix+'<filename>', EXPIRE(persist_expire), SINGLE);

  EXPORT keep_count               := 20; // 10 - 2x Count -> ~50% larger norm_dd file (~600Gb->~900Gb), alt_id counts went up understandably (more retained)
  EXPORT alt_count                := 10;

  EXPORT base_filter              := 'rcid>0'; //TRIM(ingest_status) NOT IN [\'Old\',\'OLD\']';

  EXPORT ul_compare_parent_filter := 'score>=5';
  EXPORT ul_compare_child_filter  := 'ul_issue=\'MULTIPLE\'';
  EXPORT ul_compare_desc          := '_5up';
 
 
  // ---------------------------------------------------------------------
  // Layouts
  // ---------------------------------------------------------------------
  EXPORT base_lo                  := BIPV2.CommonBase_mod.Layout;

  // Field configuration for value-based reporting, as OL factors, UL factors, etc.
  EXPORT field_config_lo          := { UNSIGNED1 id, STRING10 type, STRING10 abbr, STRING fields, STRING filter, UNSIGNED1 val_rpt,
                                       UNSIGNED1 ol_max, UNSIGNED1 ol_min, UNSIGNED1 ol_th, REAL ol_scale,
                                       UNSIGNED1 ul_max, UNSIGNED1 ul_min, UNSIGNED1 ul_th, REAL ul_scale };
  //EXPORT ul_risk_config_lo        := { STRING20 factor, UNSIGNED1 min_score, UNSIGNED1 max_score, REAL scale, UNSIGNED1 th };
  //EXPORT ol_risk_config_lo        := { STRING20 factor, UNSIGNED1 score, UNSIGNED1 th };
  //EXPORT risk_config_lo           := { STRING20 factor, UNSIGNED1 min_score, UNSIGNED1 max_score, REAL scale, UNSIGNED1 th };
 
  // Fields available for sanity-checking OL or UL risks (truncated should be ok), with separate names to avoid conflicts in the value-based reporting tables
  EXPORT sanity_field_lo          := { STRING3 src, TYPEOF(base_lo.sele_gold) seg, STRING20 cname, 
                                       //STRING20 v_city, STRING20 p_city, TYPEOF(base_lo.st) a_st };
                                       TYPEOF(base_lo.prim_range) p_rng, STRING20 p_name,
                                       STRING20 v_city, STRING20 p_city, STRING2 a_st, STRING5 a_z };
  //EXPORT sanity_fields            := 'src, seg, cname, v_city, p_city, a_st';
  EXPORT sanity_fields            := 'src, seg, cname, p_rng, p_name, v_city, p_city, a_st, a_z';
 
  SHARED alt_info_lo              := { TYPEOF(base_lo.proxid) alt_proxid, TYPEOF(sanity_field_lo.cname) alt_cname,
                                       //TYPEOF(sanity_field_lo.v_city) alt_v_city, TYPEOF(sanity_field_lo.p_city) alt_p_city, TYPEOF(sanity_field_lo.a_st) alt_a_st,
                                       TYPEOF(sanity_field_lo.p_rng) alt_p_rng, TYPEOF(sanity_field_lo.p_name) alt_p_name,
                                       TYPEOF(sanity_field_lo.v_city) alt_v_city, TYPEOF(sanity_field_lo.a_st) alt_a_st, TYPEOF(sanity_field_lo.a_z) alt_a_z,
                                       TYPEOF(sanity_field_lo.src) alt_src, TYPEOF(base_lo.rcid) alt_rcid };
  //EXPORT alt_info_fields          := 'alt_proxid, alt_cname, alt_v_city, alt_p_city, alt_src, alt_rcid, alt_a_st';
  EXPORT alt_info_fields          := 'alt_proxid, alt_cname, alt_p_rng, alt_p_name, alt_v_city, alt_a_st, alt_a_z, alt_src, alt_rcid';
 
  EXPORT ul_risk_lo               := { base_lo.proxid, UNSIGNED  score, STRING factors };
  EXPORT ul_dtl_lo                := { STRING il_svc__html:='',
                                       alt_info_lo.alt_proxid, STRING8 ul_issue, STRING ul_value, UNSIGNED8 ul_val_cnt,
                                       //sanity_field_lo.src, sanity_field_lo.cname, sanity_field_lo.v_city, sanity_field_lo.p_city, sanity_field_lo.a_st,
                                       #EXPAND('sanity_field_lo.'+REGEXREPLACE(',',sanity_fields,', sanity_field_lo.')),
                                       alt_info_lo -alt_proxid, base_lo.rcid };
  //EXPORT ul_dtl_link_lo           := { STRING il_svc__html, ul_dtl_lo };
  EXPORT ul_dtl_ext_lo            := { ul_dtl_lo.il_svc__html, ul_dtl_lo.alt_proxid,
                                       STRING1 will_link, STRING10 scored, STRING10 forced, STRING5 blocked, INTEGER2 conf,
                                       ul_dtl_lo -[il_svc__html,alt_proxid] };
  EXPORT ul_lo                    := { ul_risk_lo, REAL avg_score, TYPEOF(base_lo.sele_gold) seg,
                                       UNSIGNED8 cnt_recs,    REAL pct_pop,           // % of UL-meaningful fields populated
                                       UNSIGNED8 alt_proxids, UNSIGNED8 max_id_score, DATASET(ul_dtl_lo) ul_dtls };
  EXPORT ul_ext_lo                := { ul_lo -ul_dtls, UNSIGNED8 alt_links, UNSIGNED8 alt_forces, UNSIGNED8 alt_blocks, DATASET(ul_dtl_ext_lo) ul_dtls };
  //EXPORT ul_link_lo               := { ul_lo -ul_dtls, DATASET(ul_dtl_link_lo) ul_dtls };
  EXPORT ul_norm_lo               := { ul_lo     -ul_dtls, ul_dtl_lo     };
  EXPORT ul_norm_ext_lo           := { ul_ext_lo -ul_dtls, ul_dtl_ext_lo };
  EXPORT ul_agg_lo                := { ul_lo.proxid, ul_dtl_lo.alt_proxid, ul_lo.score, STRING1 flip,
                                       ul_lo.avg_score, ul_lo.cnt_recs, ul_lo.pct_pop, ul_lo.alt_proxids, ul_lo.max_id_score, ul_lo.seg,
                                       // Compare Results
                                       ul_dtl_ext_lo.will_link, ul_dtl_ext_lo.scored, ul_dtl_ext_lo.forced, ul_dtl_ext_lo.blocked, ul_dtl_ext_lo.conf, ul_dtl_lo.ul_val_cnt,
                                       // Factor Breakouts
                                       STRING1 ent_a, STRING1 ent_h, STRING1 ent_x, STRING1 duns_a, STRING1 duns_h, STRING1 dcorp_a, STRING1 dcorp_h, STRING1 fcorp, STRING1 ucorp, STRING1 corp_x,
                                       //STRING1 fein, STRING1 ebr, STRING1 srcvl, STRING1 srcrid, STRING1 sele, STRING1 bdid, STRING1 cnamef, STRING1 lname, STRING1 dname,
                                       STRING1 fein_o, STRING1 fein_x, STRING1 ebr, STRING1 srcvl, STRING1 srcrid, STRING1 sele, STRING1 bdid, STRING1 cnamef, STRING1 lname, STRING1 dname,
                                       //STRING1 addrvsz, STRING1 addrpsz, STRING1 addrst, STRING1 addrst2, STRING1 cphn, STRING1 url, STRING1 ticker, STRING1 tickex,
                                       STRING1 addrpsz, STRING1 addrvsz, STRING1 addrst, STRING1 addrst2, STRING1 cphn, STRING1 phn_x, STRING1 url_o, STRING1 url_x, STRING1 ticker, STRING1 tickex,
                                       STRING1 owndid, STRING1 pdid, STRING1 did_x, STRING1 pname, STRING1 pssn, STRING1 peml, STRING1 pdom, STRING1 pphn,
                                       // "Only" flags
                                       STRING1 entoa, STRING1 entoh, STRING1 entox, STRING1 dunsoa, STRING1 dunsoh, STRING1 dunso, STRING1 dcorpoa, STRING1 dcorpoh, STRING1 dcorpof, STRING1 dcorpou, STRING1 dcorpox,
                                       STRING1 feinof, STRING1 feinos, STRING1 feinox, STRING1 phnoc, STRING1 phnop, STRING1 phnox, STRING1 urlou, STRING1 urlod, STRING1 urlox, STRING1 didoo, STRING1 didop, STRING1 didox,
                                       // Calc/Derive
                                       //UNSIGNED1 factor_cnt, STRING1 name, STRING1 addr, STRING1 ent, STRING1 corp, STRING1 duns, STRING1 src, STRING1 lnid, STRING1 phn, STRING1 did, STRING1 contact, STRING1 tick,
                                       UNSIGNED1 factor_cnt, STRING1 name, STRING1 addr, STRING1 ent, STRING1 duns, STRING1 corp, STRING1 fein, STRING1 src, STRING1 lnid,
                                       STRING1 phn, STRING1 url, STRING1 did, STRING1 contact, STRING1 tick,
                                       REAL norm_score, REAL norm_avg, REAL norm_recs, REAL norm_pop, REAL norm_alts, REAL norm_max, REAL norm_conf, REAL norm_ulvals };
 
  EXPORT ol_risk_lo               := { base_lo.proxid, UNSIGNED1 score, STRING factors };
  EXPORT ol_lo                    := { ol_risk_lo, UNSIGNED8 recs, UNSIGNED8 chi, UNSIGNED8 chi_name, UNSIGNED8 chi_ssn, UNSIGNED8 chi_dob,
                                       UNSIGNED1 mi_score,      STRING mi_orig_factors, STRING mi_mac_factors,  UNSIGNED1 mi_orig_score,
                                       UNSIGNED1 mi_cnt_score,  UNSIGNED1 mi_max_score, UNSIGNED1 mi_avg_score, UNSIGNED1 mi_calc_score,
                                       UNSIGNED1 mi_cnt_raw,    UNSIGNED1 mi_max_raw,   UNSIGNED1 mi_avg_raw,   UNSIGNED1 mi_calc_raw };
 
  EXPORT profile_thin_lo          := { base_lo.proxid       , STRING1  enum      := '', STRING1  vend     := '', STRING1 deliv := '', STRING1  xlink := '',
                                       STRING1  active := '', STRING1  presc     := '', STRING30 practype := '', STRING5 st    := '',
                                       STRING20 seg    := '', STRING10 lexid_seg := ''};
  EXPORT profile_ext_lo           := { profile_thin_lo,           UNSIGNED1 enum_result := 0, UNSIGNED8 best_lexid := 0,
                                       UNSIGNED1 cnt_lics  := 0,  UNSIGNED1 lic_sts     := 0, UNSIGNED1 act_lics   := 0, UNSIGNED1 act_lic_sts := 0,
                                       UNSIGNED1 cnt_npis  := 0,  UNSIGNED1 npi_sts     := 0, UNSIGNED1 act_npis   := 0, UNSIGNED1 act_npi_sts := 0,
                                       UNSIGNED1 cnt_deas  := 0,  UNSIGNED1 dea_sts     := 0, UNSIGNED1 act_deas   := 0, UNSIGNED1 act_dea_sts := 0,
                                       UNSIGNED1 cnt_sancs := 0,  UNSIGNED1 act_sancs   := 0, UNSIGNED1 dod_vals   := 0};
  EXPORT profile_lo               := profile_ext_lo;
  EXPORT stat_lo                  := { UNSIGNED1 id, STRING25 stat, STRING25 cnt, STRING10 pct };
  EXPORT id_lo                    := { // Internal IDs
                                       base_lo.rcid, base_lo.proxid, base_lo.seleid, base_lo.orgid, //base_lo.dotid, base_lo.empid, base_lo.powid, base_lo.lgid3, base_lo.ultid,
                                       // Active IDs
                                       base_lo.active_enterprise_number, base_lo.active_domestic_corp_key, base_lo.active_duns_number,
                                       base_lo.company_fein, base_lo.best_fein_indicator, base_lo.foreign_corp_key, base_lo.unk_corp_key,
                                       // Source/Vendor ID
                                       base_lo.source, base_lo.source_record_id, base_lo.vl_id, base_lo.ebr_file_number, base_lo.company_bdid,
                                       // Company Name
                                       base_lo.cnp_name, base_lo.cnp_number, base_lo.cnp_store_number, 
                                       TYPEOF(base_lo.cnp_name) cnp_name_phonetic, base_lo.corp_legal_name, base_lo.dba_name, //base_lo.company_name,
                                       base_lo.company_name_type_raw, base_lo.company_name_type_derived,
                                       // Address
                                       base_lo.address_type_derived, base_lo.prim_range_derived, base_lo.predir, base_lo.prim_name_derived, // derived vs raw?
                                       base_lo.addr_suffix, base_lo.postdir, base_lo.unit_desig, base_lo.sec_range,
                                       base_lo.v_city_name, base_lo.p_city_name, STRING3 st, base_lo.zip,
                                       // Contact
                                       base_lo.company_phone, base_lo.phone_type, base_lo.contact_type_derived, base_lo.contact_did,
                                       //base_lo.title, base_lo.fname, base_lo.mname, base_lo.lname, base_lo.name_suffix,
                                       STRING70 contact_name,
                                       base_lo.contact_ssn, base_lo.contact_dob, base_lo.contact_phone, base_lo.contact_email, base_lo.contact_email_domain,
                                       // Type
                                       base_lo.company_sic_code1, base_lo.company_naics_code1,
                                       // Historical IDs
                                       base_lo.hist_enterprise_number, base_lo.hist_domestic_corp_key, base_lo.hist_duns_number,
                                       // Misc
                                       base_lo.company_ticker, base_lo.company_ticker_exchange, base_lo.company_url, base_lo.vanity_owner_did,
                                       base_lo.duns_number, base_lo.company_charter_number, base_lo.sele_gold, base_lo.cnt_prox_per_lgid3, base_lo.ingest_status,
                                       // Cross-Field IDs
                                       TYPEOF(base_lo.active_enterprise_number) ent_x   :='', STRING1 ex_src :='',
                                       //TYPEOF(base_lo.active_duns_number)       duns_x  :='', STRING1 dx_src :='',
                                       TYPEOF(base_lo.active_domestic_corp_key) corp_x  :='', STRING1 cx_src :='',
                                       TYPEOF(base_lo.company_fein)             fein_x  :='', STRING1 fx_src :='',
                                       TYPEOF(base_lo.company_phone)            phn_x   :='', STRING1 px_src :='',
                                       TYPEOF(base_lo.company_url)              url_x   :='', STRING1 ux_src :='',
                                       TYPEOF(base_lo.contact_did)              did_x   := 0, STRING1 dx_src :='',
                                       //TYPEOF(base_lo.cnp_name)                 name_x  :='', STRING1 nx_src :='',
                                       sanity_field_lo }; // min_dt_first_seen>0, max_dt_last_seen
   EXPORT id_dedup_fields         := 'proxid, seleid, orgid, active_enterprise_number, active_domestic_corp_key, active_duns_number,'+
                                     'hist_enterprise_number, hist_domestic_corp_key, hist_duns_number,'+
                                     'duns_number, foreign_corp_key, unk_corp_key, company_fein, ebr_file_number, company_bdid,'+ // best_fein_indicator,
                                     'source, source_record_id, vl_id,'+
                                     'cnp_name, cnp_number, cnp_store_number, cnp_name_phonetic, corp_legal_name, dba_name,'+
                                     //'company_name_type_raw, company_name_type_derived,'+
                                     'address_type_derived, prim_range_derived, prim_name_derived,'+ // predir,
                                     'unit_desig, sec_range, v_city_name, p_city_name, st, zip,'+ // addr_suffix, postdir,
                                     'company_phone, phone_type, contact_did, contact_name,'+ // contact_type_derived,
                                     'contact_ssn, contact_dob, contact_phone, contact_email, contact_email_domain,'+
                                     'company_sic_code1, company_naics_code1,'+
                                     'company_ticker, company_ticker_exchange, company_url, vanity_owner_did,'+
                                     'company_charter_number, sele_gold'; // cnt_prox_per_lgid3, ingest_status

   EXPORT stats_file_lo           := { STRING20 report_version,
                                       STRING10 stat_type, STRING12 stat_subtype, UNSIGNED1 stat_id, UNSIGNED1 stat_pri, STRING50 stat_name, STRING stat_value,
                                       STRING20 build_version, STRING20 build_wu, STRING20 build_user, STRING20 report_wu, STRING20 report_user };
 
 
  // ---------------------------------------------------------------------
  // Files
  // ---------------------------------------------------------------------
  //EXPORT base_proxid              := DISTRIBUTE(build_ds,HASH32(proxid)) : INDEPENDENT;
  EXPORT base_proxid              := DISTRIBUTE(build_ds(#EXPAND(base_filter)),HASH32(proxid)) : INDEPENDENT;
  //EXPORT base_proxid              := DISTRIBUTE(CHOOSEN(build_ds,5000000),HASH32(proxid)) : INDEPENDENT; // Subset for performance testing
  //  
  //EXPORT base_proxid0             := DISTRIBUTE(build_ds,HASH32(proxid));
  ////EXPORT random_ids               := DISTRIBUTE(CHOOSEN(SORT(TABLE(base_proxid0, { proxid, UNSIGNED cnt:=COUNT(GROUP,ingest_status<>'Old') }, proxid, LOCAL)(cnt BETWEEN 10 AND 1000),proxid),10000),HASH32(proxid));
  //EXPORT random_ids               := DISTRIBUTE(CHOOSEN(SORT(TABLE(base_proxid0, { proxid, UNSIGNED cnt:=COUNT(GROUP,ingest_status<>'Old') }, proxid, LOCAL)(cnt BETWEEN 1 AND 1000),proxid),10000),HASH32(proxid));
  //EXPORT sample_ids               := DISTRIBUTE(DATASET('~temp::pml::bipv2_proxid::underlinks::samples_w20191024-150738_proxids',{ base_lo.proxid, UNSIGNED cnt },THOR),HASH32(proxid));
  //EXPORT subset_ids               := DEDUP(SORT(random_ids + sample_ids,proxid,LOCAL),proxid,LOCAL);
  //
  //EXPORT base_proxid              := JOIN(base_proxid0, subset_ids, LEFT.proxid=RIGHT.proxid, TRANSFORM(LEFT), LOCAL) : INDEPENDENT; // Subset for performance testing
  //EXPORT base_seleid              := DISTRIBUTE(build_ds,HASH32(seleid)) : INDEPENDENT;
  //EXPORT base_lgid3               := DISTRIBUTE(build_ds,HASH32(lgid3))  : INDEPENDENT;
  //EXPORT base_orgid               := DISTRIBUTE(build_ds,HASH32(orgid))  : INDEPENDENT;
  EXPORT base                     := base_proxid;
 
 
  // ---------------------------------------------------------------------
  // Helpers & Defaults
  // ---------------------------------------------------------------------
  EXPORT today                    := (UNSIGNED4)WORKUNIT[2..9]; // STD.Date.Today();
  EXPORT today_dow                := STD.Date.DayOfWeek(today);
  //EXPORT last_Sun                 := STD.Date.AdjustDate(today, 0, 0, 1-today_dow);
  //EXPORT last_Mon                 := IF(today_dow=1, STD.Date.AdjustDate(today, 0, 0, -6), STD.Date.AdjustDate(today, 0, 0, 2-today_dow));
  EXPORT default_asOf             := (STRING)today; //MAX(report_file,report_wu)[2..9];
  EXPORT now                      := REGEXREPLACE('-',Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),'')[1..14];
  EXPORT thor_nodes               := STD.System.Thorlib.Nodes();
  EXPORT avg_dist_pct             := ROUND(1/thor_nodes*100,2);
  EXPORT max_xjoin_in_cnt         := 50000; // 100000
  EXPORT divider                  := '__________________________________________________';
  EXPORT break                    := OUTPUT(divider);
  EXPORT header_pad               := '__________';
  EXPORT section_pad              := '_____';
  EXPORT samples(ds)              := MACRO CHOOSEN(ds,100) ENDMACRO;
  EXPORT rnd2(REAL x)             := ROUND(x,2);
  EXPORT pct(REAL x, REAL y)      := rnd2(x/y*100);
  EXPORT pcs(REAL x, REAL y)      := REGEXREPLACE('([0-9]*\\.[0-9]{2}).*',(STRING)pct(x,y),'$1'); // rnd2 sometimes creating more than 2 decimals
  EXPORT trm(REAL x)              := REGEXREPLACE('([0-9]*\\.[0-9]{2}).*',(STRING)    x   ,'$1'); // rnd2 sometimes creating more than 2 decimals
  EXPORT iwc(INTEGER x)           := ut.IntWithCommas(x);
  EXPORT swc(STRING  x)           := iwc((INTEGER)REGEXREPLACE('[^0-9]',x,''));                   // reformat str num w/o commas to string w/ commas
  EXPORT dt_yyyy(UNSIGNED4 dt)    := (UNSIGNED2)(dt/10000);
  EXPORT dt_mm  (UNSIGNED4 dt)    := (UNSIGNED1)(dt%10000/100);
  EXPORT dt_dd  (UNSIGNED4 dt)    := (UNSIGNED1)(dt%100);
 
  //EXPORT proxid_compare           := pml.mod_ProxIDCompare();
  EXPORT proxid_compare           := mod_ProxIDCompare();
  EXPORT pic_cand_key             := DISTRIBUTE(PULL(proxid_compare.cand_key),HASH32(proxid ));
  EXPORT pic_cand_key_ids         := DEDUP(SORT(pic_cand_key,proxid ,rcid   ,LOCAL),proxid         ,LOCAL);
  EXPORT pic_attr_key             := DISTRIBUTE(PULL(proxid_compare.attr_key),HASH32(proxid1));
  EXPORT pic_attr_key_ids         := DEDUP(SORT(pic_attr_key,proxid1,proxid2,-conf,rule,rcid1,rcid2,LOCAL),proxid1,proxid2,LOCAL);
  EXPORT pic_spec_key             :=                 proxid_compare.spec_key;
  EXPORT pic_all_m                := DISTRIBUTE(PULL(proxid_compare.all_m   ),HASH32(proxid1));
  EXPORT pic_all_m_pairs          := DEDUP(SORT(pic_all_m   ,proxid1,proxid2,-conf,rule,rcid1,rcid2,LOCAL),proxid1,proxid2,LOCAL);
  EXPORT pic_mt                   := DISTRIBUTE(PULL(proxid_compare.mt      ),HASH32(proxid1));
  EXPORT pic_mt_pairs             := DEDUP(SORT(pic_mt      ,proxid1,proxid2,-conf,rule,rcid1,rcid2,LOCAL),proxid1,proxid2,LOCAL);

  //EXPORT il_svc_url               := 'http://10.173.102.101:8002/WsEcl/xslt/query/roxie_102/bipv2_proxid.proxidcompareservice?';
  //EXPORT il_svc_url               := 'http://prod_esp.br.seisint.com:8002/WsEcl/xslt/query/hthor_eclcc/pml.svc_proxid_compare_ext?';
  EXPORT il_svc_url               := 'http://prod_esp.br.seisint.com:8002/WsEcl/xslt/query/hthor_eclcc/bipv2_analysis.svc_proxid_compare_ext?';
  EXPORT mac_link(url, desc)      := MACRO '<a href="'+url+'" target="_blank">'+desc+'</a>' ENDMACRO;

  EXPORT curr_ver_base_lf         := NOTHOR(STD.File.SuperFileContents(build_fn));
  EXPORT curr_ver_base            := REGEXREPLACE('.*::([0-9]+).*' ,curr_ver_base_lf                                    [1].name,'$1');
 
  EXPORT default_rpt_ver          := IF(TRIM(rpt_ver_in)>'', rpt_ver_in,  (STRING)today);
  EXPORT default_rpt_wu           := WORKUNIT;
  EXPORT default_rpt_user         := STD.System.Job.User();
  EXPORT default_bld_ver          := IF(TRIM(bld_ver_in)>'', bld_ver_in,  curr_ver_base);
  EXPORT default_bld_wu           := '';
  EXPORT default_bld_user         := '';
 
  EXPORT stats_file_lf            := outfile_prefix+'stats_'+default_rpt_ver+'_'+WORKUNIT;
  EXPORT stats_file_sf            := outfile_prefix+'stats_sf';
  EXPORT stats_file               := DATASET(stats_file_sf,stats_file_lo,THOR);
 
  EXPORT ul_norm_lo     normUL     (ul_lo     L, INTEGER C)  := TRANSFORM
                                       SELF := L.ul_dtls[C]; SELF := L; END;
  EXPORT norm_ul        (DATASET(ul_lo)     in_uls)      :=   NORMALIZE(in_uls, COUNT(LEFT.ul_dtls), normUL   (LEFT, COUNTER), LOCAL);
 
  EXPORT ul_norm_ext_lo normULExt  (ul_ext_lo L, INTEGER C)  := TRANSFORM
                                       SELF := L.ul_dtls[C]; SELF := L; END;
  EXPORT norm_ul_ext    (DATASET(ul_ext_lo) in_uls)      :=   NORMALIZE(in_uls, COUNT(LEFT.ul_dtls), normULExt(LEFT, COUNTER), LOCAL);
 
  EXPORT ul_ext_lo      denormULExt(ul_ext_lo L, DATASET(ul_norm_ext_lo) R) := TRANSFORM
                                       SELF.ul_dtls:=PROJECT(R, TRANSFORM(ul_dtl_ext_lo, SELF:=LEFT)); SELF:=L; END;
  EXPORT denorm_ul_ext  (DATASET(ul_ext_lo) in_ul_exts, DATASET(ul_norm_ext_lo) in_ul_norm_exts) :=
                                       DENORMALIZE(DISTRIBUTE(in_ul_exts,HASH32(proxid)), DISTRIBUTE(in_ul_norm_exts,HASH32(proxid)), LEFT.proxid=RIGHT.proxid, GROUP,
                                         denormULExt(LEFT, ROWS(RIGHT)), LOCAL);


  // ---------------------------------------------------------------------
  // Configuration - Factors
  // ---------------------------------------------------------------------
  EXPORT empty_field_config       := DATASET([],field_config_lo);
  EXPORT field_config             := DATASET([ // Loading from Excel
     {1, 'ID_EXT',    'ENT_A',     'active_enterprise_number',                                                        'TRIM(active_enterprise_number)>\'\'',                                                                                                                   1,1,1,1,1.0,3,1,1,1.0}
    ,{2, 'ID_EXT',    'ENT_H',     'hist_enterprise_number',                                                          'TRIM(hist_enterprise_number)>\'\'',                                                                                                                     1,1,1,1,1.0,1,1,1,1.0}
    ,{3, 'ID_EXT',    'DUNS_A',    'active_duns_number',                                                              'TRIM(active_duns_number)>\'\'',                                                                                                                         1,1,1,1,1.0,2,1,1,1.0}
    ,{4, 'ID_EXT',    'DUNS_H',    'hist_duns_number',                                                                'TRIM(hist_duns_number)>\'\'',                                                                                                                           1,1,1,1,1.0,1,1,1,1.0}
    ,{5, 'ID_EXT',    'DUNS',      'duns_number',                                                                     'TRIM(duns_number)>\'\'',                                                                                                                                1,1,1,1,1.0,1,1,1,1.0}
    ,{6, 'ID_EXT',    'DCORP_A',   'active_domestic_corp_key',                                                        'TRIM(active_domestic_corp_key)>\'\'',                                                                                                                   1,1,1,1,1.0,2,1,1,1.0}
    ,{7, 'ID_EXT',    'DCORP_H',   'hist_domestic_corp_key',                                                          'TRIM(hist_domestic_corp_key)>\'\'',                                                                                                                     1,1,1,1,1.0,1,1,1,1.0}
    ,{8, 'ID_EXT',    'FCORP',     'foreign_corp_key',                                                                'TRIM(foreign_corp_key)>\'\'',                                                                                                                           1,1,1,1,1.0,1,1,1,1.0}
    ,{9, 'ID_EXT',    'UCORP',     'unk_corp_key',                                                                    'TRIM(unk_corp_key)>\'\'',                                                                                                                               1,1,1,1,1.0,1,1,1,1.0}
    ,{10,'ID_EXT',    'FEIN',      'company_fein',                                                                    'TRIM(company_fein)>\'\'',                                                                                                                               1,1,1,1,1.0,2,1,1,1.0}
    ,{11,'ID_EXT',    'EBR',       'ebr_file_number',                                                                 'TRIM(ebr_file_number)>\'\'',                                                                                                                            1,1,1,1,1.0,2,1,1,1.0}
    ,{12,'ID_EXT',    'SRCVL',     'source,vl_id',                                                                    'TRIM(source)>\'\' AND TRIM(vl_id)>\'\'',                                                                                                                1,0,1,1,1.0,2,1,1,1.0}
    ,{13,'ID_EXT',    'SRCRID',    'source,source_record_id',                                                         'TRIM(source)>\'\' AND source_record_id>0',                                                                                                              1,0,1,1,1.0,2,1,1,1.0}
    ,{14,'ID_INT',    'SELE',      'seleid',                                                                          'seleid>0',                                                                                                                                              1,1,1,1,1.0,1,1,1,1.0}
    ,{15,'COMPANY',   'CNAME',     'cnp_name',                                                                        'TRIM(cnp_name)>\'\'',                                                                                                                                   0,0,1,1,1.0,0,1,1,1.0}
    ,{16,'COMPANY',   'CNAMEF',    'cnp_name_phonetic',                                                               'TRIM(cnp_name_phonetic)>\'\'',                                                                                                                          1,1,1,1,1.0,1,1,1,1.0}
    ,{17,'COMPANY',   'LNAME',     'corp_legal_name',                                                                 'TRIM(corp_legal_name)>\'\'',                                                                                                                            1,1,1,1,1.0,1,1,1,1.0}
    ,{18,'COMPANY',   'DNAME',     'dba_name',                                                                        'TRIM(dba_name)>\'\'',                                                                                                                                   1,1,1,1,1.0,1,1,1,1.0}
    ,{19,'COMPANY',   'ADDRPSZ',   'address_type_derived,p_city_name,st,zip',                                         'TRIM(address_type_derived)>\'\' AND TRIM(p_city_name)>\'\' AND TRIM(st)>\'\' AND TRIM(zip)>\'\'',                                                       1,1,1,1,1.0,0,1,1,1.0}
    ,{20,'COMPANY',   'ADDRVSZ',   'address_type_derived,v_city_name,st,zip',                                         'TRIM(address_type_derived)>\'\' AND TRIM(v_city_name)>\'\' AND TRIM(st)>\'\' AND TRIM(zip)>\'\'',                                                       1,1,1,1,1.0,0,1,1,1.0}
    ,{21,'COMPANY',   'ADDRST',    'address_type_derived,prim_range_derived,prim_name_derived',                       'TRIM(address_type_derived)>\'\' AND TRIM(prim_range_derived)>\'\' AND TRIM(prim_name_derived)>\'\'',                                                    1,1,1,1,1.0,1,1,1,1.0}
    ,{22,'COMPANY',   'ADDRST2',   'address_type_derived,prim_range_derived,prim_name_derived,unit_desig,sec_range',  'TRIM(address_type_derived)>\'\' AND TRIM(prim_range_derived)>\'\' AND TRIM(prim_name_derived)>\'\' AND (TRIM(unit_desig)>\'\' OR TRIM(sec_range)>\'\')',1,1,1,1,1.0,1,1,1,1.0}
    ,{23,'COMPANY',   'CPHN',      'company_phone',                                                                   'TRIM(company_phone)>\'\'',                                                                                                                              1,1,1,1,1.0,1,1,1,1.0}
    ,{24,'COMPANY',   'URL',       'company_url',                                                                     'TRIM(company_url)>\'\'',                                                                                                                                1,1,1,1,1.0,0,1,1,1.0}
    ,{25,'COMPANY',   'TICKER',    'company_ticker',                                                                  'TRIM(company_ticker)>\'\'',                                                                                                                             1,1,1,1,1.0,0,1,1,1.0}
    ,{26,'COMPANY',   'TICKEX',    'company_ticker_exchange,company_ticker',                                          'TRIM(company_ticker_exchange)>\'\' AND TRIM(company_ticker)>\'\'',                                                                                      1,1,1,1,1.0,0,1,1,1.0}
    ,{27,'CONTACT',   'OWNDID',    'vanity_owner_did',                                                                'vanity_owner_did>0',                                                                                                                                    1,1,1,1,1.0,1,1,1,1.0}
    ,{28,'CONTACT',   'PDID',      'contact_did',                                                                     'contact_did>0',                                                                                                                                         1,0,1,1,1.0,1,1,1,1.0}
    ,{29,'CONTACT',   'PNAME',     'contact_name',                                                                    'TRIM(contact_name)>\'\'',                                                                                                                               1,0,1,1,1.0,0,1,1,1.0}
    ,{30,'CONTACT',   'PSSN',      'contact_ssn',                                                                     'TRIM(contact_ssn)>\'\'',                                                                                                                                1,0,1,1,1.0,1,1,1,1.0}
    ,{31,'CONTACT',   'PEML',      'contact_email',                                                                   'TRIM(contact_email)>\'\'',                                                                                                                              1,0,1,1,1.0,1,1,1,1.0}
    ,{32,'CONTACT',   'PEMLDOM',   'contact_email_domain',                                                            'TRIM(contact_email_domain)>\'\'',                                                                                                                       1,0,1,1,1.0,0,1,1,1.0}
    ,{33,'CONTACT',   'PPHN',      'contact_phone',                                                                   'TRIM(contact_phone)>\'\'',                                                                                                                              1,0,1,1,1.0,1,1,1,1.0}
    ,{34,'COMPANY',   'CNUM',      'cnp_number',                                                                      'TRIM(cnp_number)>\'\'',                                                                                                                                 1,1,1,1,1.0,0,1,1,1.0}
    ,{35,'COMPANY',   'CSTORE',    'cnp_store_number',                                                                'TRIM(cnp_store_number)>\'\'',                                                                                                                           1,1,1,1,1.0,0,1,1,1.0}
    ,{36,'COMPANY',   'CHARTER',   'company_charter_number',                                                          'TRIM(company_charter_number)>\'\'',                                                                                                                     1,1,1,1,1.0,0,1,1,1.0}
    ,{37,'COMPANY',   'SIC1',      'company_sic_code1',                                                               'TRIM(company_sic_code1)>\'\'',                                                                                                                          1,1,1,1,1.0,0,1,1,1.0}
    ,{38,'COMPANY',   'NAICS1',    'company_naics_code1',                                                             'TRIM(company_naics_code1)>\'\'',                                                                                                                        1,1,1,1,1.0,0,1,1,1.0}
    ,{39,'COMPANY',   'ADDR',      'address',                                                                         'TRIM(address)>\'\'',                                                                                                                                    0,0,1,1,1.0,0,1,1,1.0}
    ,{40,'ID_EXT',    'ENT_X',     'ent_x',                                                                           'TRIM(ent_x)>\'\'',                                                                                                                                      1,1,1,1,1.0,3,1,1,1.0}
    //,{41,'ID_EXT',    'DUNS_X',    'duns_x',                                                                          'TRIM(duns_x)>\'\'',                                                                                                                                     1,1,1,1,1.0,0,1,1,1.0}
    ,{42,'ID_EXT',    'CORP_X',    'corp_x',                                                                          'TRIM(corp_x)>\'\'',                                                                                                                                     1,1,1,1,1.0,2,1,1,1.0}
    ,{43,'ID_EXT',    'FEIN_X',    'fein_x',                                                                          'TRIM(fein_x)>\'\'',                                                                                                                                     1,1,1,1,1.0,2,1,1,1.0}
    ,{44,'ID_EXT',    'PHN_X',     'phn_x',                                                                           'TRIM(phn_x)>\'\'',                                                                                                                                      1,1,1,1,1.0,1,1,1,1.0}
    ,{45,'ID_EXT',    'URL_X',     'url_x',                                                                           'TRIM(url_x)>\'\'',                                                                                                                                      1,1,1,1,1.0,1,1,1,1.0}
    ,{46,'ID_INT',    'DID_X',     'did_x',                                                                           'did_x>0',                                                                                                                                               1,1,1,1,1.0,1,1,1,1.0}
    ,{47,'ID_INT',    'BDID',      'company_bdid',                                                                    'company_bdid>0',                                                                                                                                        1,1,1,1,1.0,1,1,1,1.0}
    //,{XX,'COMPANY',   'ADDRPOB',   'address_type_derived,prim_name_derived',                                          'TRIM(address_type_derived)>\'\' AND REGEXFIND(\'PO BOX\',prim_name_derived)',                                                                           1,1,1,1,1.0,1,1,1,1.0}
  ], field_config_lo);


  // ---------------------------------------------------------------------
  // Configuration - Visualizations
  // ---------------------------------------------------------------------
/*  
  SHARED viz_prefix               := 'viz_';
  SHARED viz_palette              := 'hpcc10';
  SHARED viz_y_high               := 5;
  SHARED viz_y_low                := -0.5;
  SHARED viz_map2(f1,f2,f3,f4)    := MACRO DATASET([{f1,f2},{f3,f4}],Visualizer.KeyValueDef) ENDMACRO;
  SHARED viz_props                (title, ymx='0', ymn='0') := MACRO
                                       DATASET([{'title',STD.Str.ToUpperCase(title)},{'yAxisTitle',STD.Str.ToUpperCase(title)},
                                         {'paletteID',viz_palette},{'snappingColumns',4},{'snappingRows',4}],Visualizer.KeyValueDef)+
                                       IF(ymx<>0 AND ymn<>0, DATASET([{'yAxisDomainHigh',ymx},{'yAxisDomainLow',ymn}],Visualizer.KeyValueDef), DATASET([],Visualizer.KeyValueDef))
                                     ENDMACRO;

  SHARED viz_graphxy              := 3; // XxY size of each graph (uniform for now)
  SHARED viz_graphs               := (COUNT(field_config)+1)*4;
  SHARED viz_totcols              := 4;
  SHARED viz_totrows              := ROUNDUP(viz_graphs/viz_totcols);
  SHARED viz_startid              := 99999;

  SHARED viz_head                 := '{"__class":"visualizer_VisualizerGrid","__properties":{"designMode":false,"fitTo":"width","snapping":"none","snappingColumns":'+
                                     viz_totcols*viz_graphxy+',"snappingRows":'+viz_totrows*viz_graphxy+',"content":[';
  SHARED viz_props1               := '{"__class":"layout_Cell","__properties":{"title":"';                         // Title
  SHARED viz_props2               := '","widget":{"__class":"chart_Column","__id":"';                              // Viz output name + '__hpcc_visualization'
  SHARED viz_propshv              := '__hpcc_visualization';
  SHARED viz_props3               := '","__properties":{"fields":[{"__class":"common_Database.Field","__id":"_pe'; // Uniq ID for X-axis DS val?
  SHARED viz_props4               := '","__properties":{"label":"';                                                // X-axis DS val name
  SHARED viz_props5               := '"}},{"__class":"common_Database.Field","__id":"_pe';                         // Uniq ID for Y-axis DS val?
  SHARED viz_props6               := '","__properties":{"label":"';                                                // Y-axis DS val name
  SHARED viz_props7               := '"}}],"yAxisTitle":"';                                                        // Y-axis title
  SHARED viz_props8               := '","paletteID":"';                                                            // Palette ID
  SHARED viz_props9               := '"}},"gridRow":';                                                             // Which row (0 first) for this graph
  SHARED viz_props10              := ',"gridCol":';                                                                // Which col (0 first) for this graph
  SHARED viz_props11              := ',"gridRowSpan":'+viz_graphxy+',"gridColSpan":'+viz_graphxy+'}}';             // +',' if more cells
  SHARED viz_foot                 := ']}}';

  SHARED viz_layout(title_in, vizout_in, xid_in, xname_in, yid_in, yname_in, ytitle_in, pal_in, row_in, col_in) := MACRO
    viz_props1 + title_in + viz_props2 + vizout_in + viz_propshv + viz_props3 + xid_in + viz_props4 + xname_in + viz_props5 + yid_in + viz_props6 + yname_in + viz_props7 + ytitle_in +
    viz_props8 + pal_in + viz_props9 + row_in*viz_graphxy + viz_props10 + col_in*viz_graphxy + viz_props11
  ENDMACRO;
//*/

  // ---------------------------------------------------------------------
  // Filtering & Cleaning
  // ---------------------------------------------------------------------
  EXPORT trusted_sources          := BIPv2.mod_sources.set_Trusted;
                                     // Allowed VL_ID sources derived from BIPV2_ProxID.file_SrcRidVlid
  EXPORT vlid_sources             := [MDR.SourceTools.set_Dunn_Bradstreet, MDR.SourceTools.set_DCA, MDR.SourceTools.set_CorpV2, MDR.SourceTools.set_Business_Credit];
 
  EXPORT states                   := ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA',
                                      'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD',
                                      'ME','MI','MN','MO','MS','MT','NC','ND','NE','NH',
                                      'NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC',
                                      'SD','TN','TX','UT','VA','VT','WA','WI','WV','WY'];
  EXPORT territories              := ['AS','FM','GU','MH','MP','PR','PW','UM','VI'];
  EXPORT military                 := ['AA','AE','AP'];
  EXPORT valid_states             := states + territories + military;
  // Obsolete: CM, CZ, NB, PI, TT
 
  //EXPORT bad_ents                 := [];
  //EXPORT bad_duns                 := []; // Some vals have nearly 800k IDs, but don't seem like bad vals
  //EXPORT bad_corps                := []; // All-zero charters? Ex: 37-0000000
  EXPORT bad_feins                := ['000000000','000000001','123456788','XXXXX1553','XXXXX4986'];
  //EXPORT bad_ebrs                 := [];
  //EXPORT bad_vlids                := []; // 37-0000000 reappears, hrm...
  //EXPORT bad_rids                 := [];
  //EXPORT bad_seles                := [];
  //EXPORT bad_bdids                := [];
  //EXPORT bad_cnamefs              := [];
  //EXPORT bad_lnames               := [];
  //EXPORT bad_dnames               := [];
  //EXPORT bad_addrpszs             := []; // Postal: Business creation centers?  Wilmington, DE, 19808/19801, etc.
  //EXPORT bad_addrvszs             := []; // Vanity: Business creation centers?  Wilmington, DE, 19808/19801, etc.
  //EXPORT bad_addrsts              := []; //         Business creation centers?  2711 Centerville,          Wilmington, DE, 19808; 1209 Orange, Wilmington, DE, 19801, etc.
  //EXPORT bad_addrst2s             := []; //         Business creation centers?  2711 Centerville, Ste 400, Wilmington, DE, 19808;  160 Greentree, Ste 101, Dover, DE, 19904, etc.
  EXPORT bad_phones               := ['0000000000','0007777777','0009999999','1000000001','2000000002','9999999999'];
  //EXPORT bad_urls                 := []; // Top 5: google.com, usps.com, star.com, aol.com, att.com
  //EXPORT bad_tickers              := []; // Top 5: MCD, WAG, NWY, SBUX, HRB
  //EXPORT bad_charters             := []; // All-zero charters? Ex: 0000000 from 37-0000000
  //EXPORT bad_sics                 := [];
  //EXPORT bad_naics                := [];
  //EXPORT bad_dids                 := [];
  //EXPORT bad_pnames               := []; // Some people on tens of thousands of proxids: Cheyenne Moseley, David Williams, David Smith, Michael Smith, Imelda Vasquez
  EXPORT bad_ssns                 := ['000000000','000010101','300000000','770000007'];
  //EXPORT bad_emails               := []; // Top 5: solutions@sodexo.com, jeffc@wendcentral.com, s.griffin@lq.com, d.cooper@lq.com, g.hornsby@lq.com
  //EXPORT bad_domains              := []; // Top 5: aol.com, yahoo.com, hotmail.com, ameritrade.com, goarmy.com

  // Modified Base for ID/Field Stats
  EXPORT default_base             := base; // Used to be different to allow extra filtering, but now more transparent with base_filter up top
  EXPORT id_base0                 := PROJECT(default_base, TRANSFORM(id_lo,
                                       // Modified Fields
                                       SELF.vl_id:=IF(LEFT.source IN vlid_sources,LEFT.vl_id,''); // Remove unreliable VL_ID
                                       //SELF.cnp_name_phonetic:=REGEXREPLACE('[^0-9A-Z ]',STD.Str.ToUpperCase(LEFT.cnp_name),''),
                                       SELF.cnp_name_phonetic:=REGEXREPLACE('[^BCDFGHJKLMNPQRSTVWXYZ ]',STD.Str.ToUpperCase(LEFT.cnp_name),''), // [^A-Z ] makes 5TH = 37TH
                                       SELF.prim_name_derived:=REGEXREPLACE('[^0-9A-Z ]',STD.Str.ToUpperCase(LEFT.prim_name_derived),''),
                                       //pnd                   :=REGEXREPLACE('[^A-Z ]',STD.Str.ToUpperCase(LEFT.prim_name_derived),'');
                                       //SELF.prim_name_derived:=IF(REGEXFIND('PO[ ]*BOX',pnd),'',pnd),
                                       SELF.company_fein     :=IF(LEFT.company_fein IN bad_feins,'',LEFT.company_fein),
                                       SELF.company_phone    :=IF(LEFT.company_phone IN bad_phones,'',REGEXREPLACE('[^0-9]',LEFT.company_phone,'')),
                                       contact_name_prep     :=TRIM(LEFT.title)+'|'+TRIM(LEFT.fname)+'|'+TRIM(LEFT.mname)+'|'+TRIM(LEFT.lname)+'|'+TRIM(LEFT.name_suffix);
                                       SELF.contact_name     :=IF(TRIM(contact_name_prep)='||||','',contact_name_prep),
                                       SELF.contact_ssn      :=IF(LEFT.contact_ssn IN bad_ssns,'',REGEXREPLACE('[^0-9]',LEFT.contact_ssn,'')),
                                       SELF.contact_phone    :=IF(LEFT.contact_phone IN bad_phones,'',REGEXREPLACE('[^0-9]',LEFT.contact_phone,'')),
                                       SELF.company_url      :=REGEXREPLACE('.*\\.([^\\.]+\\.[^\\.][A-Z]+)[^A-Z]*$',STD.Str.ToUpperCase(LEFT.company_url),'$1'), // Other characters: /-?&=;
                                       // Sanity Fields
                                       SELF.src:=IF(LEFT.source IN trusted_sources,'T','U')+LEFT.source; // Prepend trusted status
                                       SELF.seg:=LEFT.sele_gold, SELF.cname:=LEFT.cnp_name,
                                       SELF.p_rng:=LEFT.prim_range_derived, SELF.p_name:=LEFT.prim_name_derived, // LEFT vs SELF
                                       SELF.v_city:=LEFT.v_city_name, SELF.p_city:=LEFT.p_city_name, SELF.a_st:=LEFT.st, SELF.a_z:=LEFT.zip,
 
                                       SELF:=LEFT));
                                       //SELF:=LEFT))(~REGEXFIND('PO[ ]*BOX',prim_name_derived));
                                       //SELF:=LEFT)) : PERSIST(persist_prefix+'id_base', EXPIRE(persist_expire), SINGLE);
                                       //SELF:=LEFT)) : INDEPENDENT; // Persist is 10 Tb but only saves ~9m reproc time
 
  // ---------------------------------------------------------------------
  // Cross-field comparison (*_X) field initalization
  // ---------------------------------------------------------------------
  EXPORT id_base_ent_a            := PROJECT(id_base0(TRIM(active_enterprise_number)>''), TRANSFORM(id_lo,
                                       SELF.ent_x  := LEFT.active_enterprise_number, SELF.ex_src := 'A', SELF:=LEFT));
  EXPORT id_base_ent_h            := PROJECT(id_base0(TRIM(hist_enterprise_number)  >''), TRANSFORM(id_lo,
                                       SELF.ent_x  := LEFT.hist_enterprise_number,   SELF.ex_src := 'H', SELF:=LEFT));
  EXPORT id_base_ent_x            := DEDUP(SORT(id_base_ent_a  + id_base_ent_h
                                       , proxid,ent_x, ex_src,rcid,LOCAL),proxid,ent_x, LOCAL);
  
  //EXPORT id_base_duns_a           := PROJECT(id_base0(TRIM(active_duns_number)      >''), TRANSFORM(id_lo,
                                       //SELF.duns_x := LEFT.active_duns_number,       SELF.dx_src := 'A', SELF:=LEFT));
  //EXPORT id_base_duns_h           := PROJECT(id_base0(TRIM(hist_duns_number)        >''), TRANSFORM(id_lo,
                                       //SELF.duns_x := LEFT.hist_duns_number,         SELF.dx_src := 'H', SELF:=LEFT));
  //EXPORT id_base_duns             := PROJECT(id_base0(TRIM(duns_number)             >''), TRANSFORM(id_lo,
                                       //SELF.duns_x := LEFT.duns_number,              SELF.dx_src := 'X', SELF:=LEFT));
  //EXPORT id_base_duns_x           := DEDUP(SORT(id_base_duns_a + id_base_duns_h + id_base_duns
                                       //,proxid,duns_x,dx_src,rcid,LOCAL),proxid,duns_x,LOCAL);
  
  EXPORT id_base_corp_a           := PROJECT(id_base0(TRIM(active_domestic_corp_key)>''), TRANSFORM(id_lo,
                                       SELF.corp_x := LEFT.active_domestic_corp_key, SELF.cx_src := 'A', SELF:=LEFT));
  EXPORT id_base_corp_h           := PROJECT(id_base0(TRIM(hist_domestic_corp_key)  >''), TRANSFORM(id_lo,
                                       SELF.corp_x := LEFT.hist_domestic_corp_key,   SELF.cx_src := 'H', SELF:=LEFT));
  EXPORT id_base_corp_f           := PROJECT(id_base0(TRIM(foreign_corp_key)        >''), TRANSFORM(id_lo,
                                       SELF.corp_x := LEFT.foreign_corp_key,         SELF.cx_src := 'F', SELF:=LEFT));
  EXPORT id_base_corp_u           := PROJECT(id_base0(TRIM(unk_corp_key)            >''), TRANSFORM(id_lo,
                                       SELF.corp_x := LEFT.unk_corp_key,             SELF.cx_src := 'U', SELF:=LEFT));
  EXPORT id_base_corp_x           := DEDUP(SORT(id_base_corp_a + id_base_corp_h + id_base_corp_f + id_base_corp_u
                                       ,proxid,corp_x,cx_src,rcid,LOCAL),proxid,corp_x,LOCAL);
 
  EXPORT id_base_fein_c           := PROJECT(id_base0(TRIM(company_fein)            >''), TRANSFORM(id_lo,
                                       SELF.fein_x := LEFT.company_fein,             SELF.fx_src := 'C', SELF:=LEFT));
  EXPORT id_base_fein_p           := PROJECT(id_base0(TRIM(contact_ssn)             >''), TRANSFORM(id_lo,
                                       SELF.fein_x := LEFT.contact_ssn,              SELF.fx_src := 'P', SELF:=LEFT));
  EXPORT id_base_fein_x           := DEDUP(SORT(id_base_fein_c + id_base_fein_p
                                       ,proxid,fein_x,fx_src,rcid,LOCAL),proxid,fein_x,LOCAL);
 
  EXPORT id_base_phn_c            := PROJECT(id_base0(TRIM(company_phone)           >''), TRANSFORM(id_lo,
                                       SELF.phn_x  := LEFT.company_phone,           SELF.px_src := 'C', SELF:=LEFT));
  EXPORT id_base_phn_p            := PROJECT(id_base0(TRIM(contact_phone)           >''), TRANSFORM(id_lo,
                                       SELF.phn_x  := LEFT.contact_phone,           SELF.px_src := 'P', SELF:=LEFT));
  EXPORT id_base_phn_x            := DEDUP(SORT(id_base_phn_c  + id_base_phn_p
                                       ,proxid,phn_x ,px_src,rcid,LOCAL),proxid,phn_x ,LOCAL);
 
  EXPORT id_base_url_c            := PROJECT(id_base0(TRIM(company_url)             >''), TRANSFORM(id_lo,
                                       SELF.url_x  := REGEXREPLACE('^.*\\.([^\\.]+\\.[^\\.]+)$',STD.Str.ToUpperCase(LEFT.company_url)         ,'$1'), SELF.ux_src := 'C', SELF:=LEFT));
  EXPORT id_base_url_p            := PROJECT(id_base0(TRIM(contact_email_domain)    >''), TRANSFORM(id_lo,
                                       SELF.url_x  := REGEXREPLACE('^.*\\.([^\\.]+\\.[^\\.]+)$',STD.Str.ToUpperCase(LEFT.contact_email_domain),'$1'), SELF.ux_src := 'P', SELF:=LEFT));
  EXPORT id_base_url_x            := DEDUP(SORT(id_base_url_c  + id_base_url_p
                                       ,proxid,url_x ,ux_src,rcid,LOCAL),proxid,url_x ,LOCAL);
 
  EXPORT id_base_did_o            := PROJECT(id_base0(     vanity_owner_did         > 0), TRANSFORM(id_lo,
                                       SELF.did_x  := LEFT.vanity_owner_did,        SELF.dx_src := 'O', SELF:=LEFT));
  EXPORT id_base_did_p            := PROJECT(id_base0(     contact_did              > 0), TRANSFORM(id_lo,
                                       SELF.did_x  := LEFT.contact_did,             SELF.dx_src := 'P', SELF:=LEFT));
  EXPORT id_base_did_x            := DEDUP(SORT(id_base_did_o  + id_base_did_p
                                       ,proxid,did_x ,dx_src,rcid,LOCAL),proxid,did_x ,LOCAL);

  // id_base_name_x

  EXPORT id_base                  := DEDUP(SORT(DISTRIBUTE(id_base0,HASH32(proxid)),#EXPAND(id_dedup_fields),rcid,LOCAL),#EXPAND(id_dedup_fields),LOCAL)
                                     + id_base_ent_x + /*id_base_duns_x +*/ id_base_corp_x + id_base_fein_x + id_base_phn_x + id_base_url_x + id_base_did_x
                                     : PERSIST(persist_prefix+'id_base', EXPIRE(persist_expire), SINGLE);
 
 
  // ---------------------------------------------------------------------
  // General Stats
  // ---------------------------------------------------------------------
  EXPORT cnt_base_recs            := COUNT(base);
  EXPORT cnt_basedef_recs         := COUNT(default_base);
  EXPORT cnt_baseid_recs          := COUNT(id_base) : INDEPENDENT;
 
  EXPORT base_ids                 := DEDUP(SORT(base,        proxid,rcid,LOCAL),proxid,LOCAL);
  EXPORT basedef_ids              := DEDUP(SORT(default_base,proxid,rcid,LOCAL),proxid,LOCAL);
  EXPORT baseid_ids               := TABLE(id_base, {proxid, UNSIGNED recs:=COUNT(GROUP)},proxid,LOCAL) : INDEPENDENT;
 
  EXPORT cnt_base_ids             := COUNT(base_ids);
  EXPORT cnt_basedef_ids          := COUNT(basedef_ids);
  EXPORT cnt_baseid_ids           := COUNT(baseid_ids) : INDEPENDENT;
  
  EXPORT baseid_fieldcnt          := 28;
  EXPORT baseid_fieldpop          := TABLE(id_base, {proxid, UNSIGNED cnt_recs:=COUNT(GROUP),
                                       UNSIGNED cnt_ent_a  :=COUNT(GROUP,TRIM(active_enterprise_number)>''),
                                       UNSIGNED cnt_ent_h  :=COUNT(GROUP,TRIM(hist_enterprise_number)>''),
                                       UNSIGNED cnt_duns_a :=COUNT(GROUP,TRIM(active_duns_number)>''),
                                       UNSIGNED cnt_duns_h :=COUNT(GROUP,TRIM(hist_duns_number)>''),
                                       UNSIGNED cnt_duns   :=COUNT(GROUP,TRIM(duns_number)>''),
                                       UNSIGNED cnt_dcorp_a:=COUNT(GROUP,TRIM(active_domestic_corp_key)>''),
                                       UNSIGNED cnt_dcorp_h:=COUNT(GROUP,TRIM(hist_domestic_corp_key)>''),
                                       UNSIGNED cnt_fcorp  :=COUNT(GROUP,TRIM(foreign_corp_key)>''),
                                       UNSIGNED cnt_ucorp  :=COUNT(GROUP,TRIM(unk_corp_key)>''),
                                       UNSIGNED cnt_fein   :=COUNT(GROUP,TRIM(company_fein)>''),
                                       UNSIGNED cnt_ebr    :=COUNT(GROUP,TRIM(ebr_file_number)>''),
                                       UNSIGNED cnt_srcvl  :=COUNT(GROUP,TRIM(vl_id)>''),
                                       UNSIGNED cnt_srcrid :=COUNT(GROUP,source_record_id>0),
                                       UNSIGNED cnt_sele   :=COUNT(GROUP,seleid>0),
                                       UNSIGNED cnt_bdid   :=COUNT(GROUP,company_bdid>0),
                                       UNSIGNED cnt_cname  :=COUNT(GROUP,TRIM(cnp_name)>''),
                                       UNSIGNED cnt_lname  :=COUNT(GROUP,TRIM(corp_legal_name)>''),
                                       UNSIGNED cnt_dname  :=COUNT(GROUP,TRIM(dba_name)>''),
                                       UNSIGNED cnt_pr     :=COUNT(GROUP,TRIM(prim_range_derived)>''),
                                       UNSIGNED cnt_pn     :=COUNT(GROUP,TRIM(prim_name_derived)>''),
                                       UNSIGNED cnt_cphn   :=COUNT(GROUP,TRIM(company_phone)>''),
                                       UNSIGNED cnt_url    :=COUNT(GROUP,TRIM(company_url)>''),
                                       UNSIGNED cnt_owndid :=COUNT(GROUP,vanity_owner_did>0),
                                       UNSIGNED cnt_pdid   :=COUNT(GROUP,contact_did>0),
                                       UNSIGNED cnt_pssn   :=COUNT(GROUP,TRIM(contact_ssn)>''),
                                       UNSIGNED cnt_peml   :=COUNT(GROUP,TRIM(contact_email)>''),
                                       UNSIGNED cnt_pphn   :=COUNT(GROUP,TRIM(contact_phone)>''),
                                       UNSIGNED cnt_cnum   :=COUNT(GROUP,TRIM(cnp_number)>'' OR TRIM(cnp_store_number)>'')
                                     },proxid,LOCAL);// : INDEPENDENT;
  EXPORT baseid_fieldpoptot       := PROJECT(baseid_fieldpop,
                                       TRANSFORM({base_lo.proxid, UNSIGNED cnt_recs, UNSIGNED cnt_pop, REAL pct_pop},
                                         SELF.cnt_pop:=MIN(LEFT.cnt_ent_a  ,1)+MIN(LEFT.cnt_ent_h  ,1)+
                                                       MIN(LEFT.cnt_duns_a ,1)+MIN(LEFT.cnt_duns_h ,1)+MIN(LEFT.cnt_duns ,1)+
                                                       MIN(LEFT.cnt_dcorp_a,1)+MIN(LEFT.cnt_dcorp_h,1)+MIN(LEFT.cnt_fcorp,1)+MIN(LEFT.cnt_ucorp,1)+
                                                       MIN(LEFT.cnt_fein   ,1)+MIN(LEFT.cnt_ebr    ,1)+
                                                       MIN(LEFT.cnt_srcvl  ,1)+MIN(LEFT.cnt_srcrid ,1)+MIN(LEFT.cnt_sele ,1)+MIN(LEFT.cnt_bdid ,1)+
                                                       MIN(LEFT.cnt_cname  ,1)+MIN(LEFT.cnt_lname  ,1)+MIN(LEFT.cnt_dname,1)+
                                                       MIN(LEFT.cnt_pr     ,1)+MIN(LEFT.cnt_pn     ,1)+MIN(LEFT.cnt_cphn ,1)+MIN(LEFT.cnt_url  ,1)+
                                                       MIN(LEFT.cnt_owndid ,1)+MIN(LEFT.cnt_pdid   ,1)+MIN(LEFT.cnt_pssn ,1)+
                                                       MIN(LEFT.cnt_peml   ,1)+MIN(LEFT.cnt_pphn   ,1)+MIN(LEFT.cnt_cnum ,1),
                                         SELF.pct_pop:=ROUND(SELF.cnt_pop/baseid_fieldcnt*100,2), SELF:=LEFT));
  EXPORT fieldpop_avg             := AVE(baseid_fieldpoptot,pct_pop);
  EXPORT baseid_fieldpopdf        := PROJECT(baseid_fieldpoptot, TRANSFORM({RECORDOF(LEFT), REAL df, REAL dfsqrd},
                                       SELF.df:=LEFT.pct_pop-fieldpop_avg, SELF.dfsqrd:=POWER(SELF.df,2), SELF:=LEFT));
  EXPORT fieldpop_stddev          := SQRT(SUM(baseid_fieldpopdf,dfsqrd)/(COUNT(baseid_fieldpopdf)-1));
  EXPORT baseid_fieldpopz         := PROJECT(baseid_fieldpopdf,  TRANSFORM({RECORDOF(LEFT), REAL zscore},
                                       SELF.zscore:=(LEFT.pct_pop-fieldpop_avg)/fieldpop_stddev, SELF:=LEFT));
  EXPORT baseid_fieldpopsumm      := TABLE(baseid_fieldpopz, { cnt_pop, pct_pop, UNSIGNED cnt_ids:=COUNT(GROUP), REAL pct_ids:=ROUND(COUNT(GROUP)/COUNT(baseid_fieldpopz)*100,2), df, dfsqrd, zscore },
                                       cnt_pop, FEW) : ONWARNING(2168,ignore);
 
 
  // ---------------------------------------------------------------------
  // Create Profile for reporting (template/reminder from HCP)
  // ---------------------------------------------------------------------
  //EXPORT add_segs                 := JOIN(basedef_ids, seg_ids     , LEFT.lnpid=RIGHT.lnpid, TRANSFORM(profile_lo,
                                       //SELF.enum_result := RIGHT.enum_result, SELF.enum      := IF(SELF.enum_result>0 ,'Y',''),
                                       //SELF.best_lexid  := RIGHT.best_lexid , SELF.lexid_seg := RIGHT.best_lexid_seg,
                                       //SELF.seg         := RIGHT.segmentation_ind, SELF:=LEFT), LEFT OUTER, LOCAL);
  //EXPORT add_xlink                := JOIN(add_deliv  , xlink_ids   , LEFT.lnpid=RIGHT.lnpid, TRANSFORM(profile_lo, SELF.xlink :=IF(RIGHT.lnpid>0,'Y',''), SELF:=LEFT), LEFT OUTER, LOCAL);
  //EXPORT add_pt_st                := JOIN(add_xlink  , pt_ids()    , LEFT.lnpid=RIGHT.lnpid, TRANSFORM(profile_lo,
                                       //SELF.presc:=IF(RIGHT.presc='Y','Y',''); SELF.practype:=RIGHT.chosen_pt; SELF.st:=RIGHT.chosen_st, SELF:=LEFT), LEFT OUTER, LOCAL);
  //EXPORT add_active               := JOIN(add_pt_st  , status_ids(), LEFT.lnpid=RIGHT.lnpid, TRANSFORM(profile_lo, SELF.active:=RIGHT.active,
                                       //SELF.cnt_lics :=COUNT(RIGHT.lics),  SELF.lic_sts  :=RIGHT.lic_sts,   SELF.act_lics:=RIGHT.act_lics,  SELF.act_lic_sts:=RIGHT.act_lic_sts,
                                       //SELF.cnt_npis :=COUNT(RIGHT.npis),  SELF.npi_sts  :=RIGHT.npi_sts,   SELF.act_npis:=RIGHT.act_npis,  SELF.act_npi_sts:=RIGHT.act_npi_sts,
                                       //SELF.cnt_deas :=COUNT(RIGHT.deas),  SELF.dea_sts  :=RIGHT.dea_sts,   SELF.act_deas:=RIGHT.act_deas,  SELF.act_dea_sts:=RIGHT.act_dea_sts,
                                                          //SELF.cnt_sancs:=COUNT(RIGHT.sancs), SELF.act_sancs:=RIGHT.act_sancs, SELF.dod_vals:=RIGHT.dod_vals,   SELF:=LEFT), LEFT OUTER, LOCAL);
  //EXPORT profile_info             := add_active;
  //EXPORT profile_info             := DATASET(outfile_prefix+'profile_info_20190211', profile_lo, THOR);
  //EXPORT out_profile(STRING fn)   := OUTPUT(profile_info,,IF(fn[1]='~',fn,'~'+fn),COMPRESSED,OVERWRITE);
  //EXPORT cnt_profile_ids          := COUNT(profile_info);
 
  //EXPORT profile_ds_all   (STRING asOf = default_asOf) :=
    //IF(NOTHOR(STD.File.FileExists(outfile_prefix+'profile_'          +asOf)),DATASET(outfile_prefix+'profile_'          +asOf,profile_lo,THOR)                 ,DATASET([],profile_lo));
  //EXPORT profile_ds       (SET OF UNSIGNED8 lnpids, STRING asOf = default_asOf) :=
    //IF(NOTHOR(STD.File.FileExists(outfile_prefix+'profile_'          +asOf)),DATASET(outfile_prefix+'profile_'          +asOf,profile_lo,THOR)(lnpid IN lnpids),DATASET([],profile_lo));
 
  //EXPORT lnpid_profile    (SET OF UNSIGNED8 lnpids, STRING asOf = default_asOf, STRING desc = '1') := FUNCTION
    //RETURN ORDERED(
      //OUTPUT(SORT(profile_ds(asOf)(lnpid IN lnpids),lnpid),NAMED('profile_'+desc));
      //OUTPUT(SORT(profile_ds  (lnpids, asOf),lnpid),NAMED('profile_'+desc));
    //);
  //END;
 
 
  // ---------------------------------------------------------------------
  // Reports
  // ---------------------------------------------------------------------
  EXPORT basic_stats(DATASET(profile_lo) in_prof) := DATASET([
     { 1 , 'All Base IDs'             , iwc(cnt_base_ids)     , rnd2(100) }
    ,{ 2 , 'All Base Recs'            , iwc(cnt_base_recs)    , rnd2(100) }
    ,{ 3 , 'Default Base IDs'         , iwc(cnt_basedef_ids)  , pcs(cnt_basedef_ids ,cnt_base_ids)  }
    ,{ 4 , 'Default Base Recs'        , iwc(cnt_basedef_recs) , pcs(cnt_basedef_recs,cnt_base_recs) }
    ,{ 5 , 'Analysis Base IDs'        , iwc(cnt_baseid_ids)   , pcs(cnt_baseid_ids  ,cnt_base_ids)  }
    ,{ 6 , 'Analysis Base Recs'       , iwc(cnt_baseid_recs)  , pcs(cnt_baseid_recs ,cnt_base_recs) }
    //,{ 4 , '--Profiled-ProxID-Info---', 0                                            , 0.0 }
    //,{ 9 , 'Xlinked ProxIDs'          , COUNT(in_prof(xlink ='Y'))              , pcs(COUNT(in_prof(xlink ='Y')),COUNT(in_prof)) }
    //,{ 10, '---Active-ProxID-Stats---', 0                                            , 0.0 }
    //,{ 11, 'All Active ProxIDs'       , COUNT(in_prof(active='Y'))              , pcs(COUNT(in_prof(active='Y')),COUNT(in_prof)) }
  ],stat_lo);
 
  EXPORT summary_report(DATASET(profile_lo) in_prof = DATASET([],profile_lo)) := ORDERED(
    OUTPUT(base_filter,NAMED('Base_Filter'));
    OUTPUT(field_config,NAMED('Field_Config'));
    OUTPUT(SORT(basic_stats(in_prof),id),NAMED('Basic_Stats'));
    OUTPUT(SORT(baseid_fieldpopsumm,cnt_pop),NAMED('Field_Pop_Summary'));
    //OUTPUT(SORT(TABLE(base,         { ingest_status, UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(base))         }, ingest_status, FEW),-rec_cnt),NAMED('tb_base_ingest_status'   ));
    //OUTPUT(SORT(TABLE(default_base, { ingest_status, UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(default_base)) }, ingest_status, FEW),-rec_cnt),NAMED('tb_basedef_ingest_status'));
    //OUTPUT(SORT(TABLE(id_base,      { ingest_status, UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(id_base))      }, ingest_status, FEW),-rec_cnt),NAMED('tb_baseid_ingest_status' ));
  );
 
  EXPORT summary_stats            := DATASET([
         {default_rpt_ver, 'SUMMARY'  ,'BASE'         ,1 ,1,'cnt_base_recs'                                        ,iwc(cnt_base_recs)                                   ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASE'         ,2 ,1,'pct_base_recs_of_all_recs'                            ,pcs(cnt_base_recs,cnt_base_recs)                     ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASE'         ,3 ,1,'cnt_base_ids'                                         ,iwc(cnt_base_ids)                                    ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASE'         ,4 ,1,'pct_base_ids_of_all_ids'                              ,pcs(cnt_base_ids,cnt_base_ids)                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEDEF'      ,1 ,1,'cnt_basedef_recs'                                     ,iwc(cnt_basedef_recs)                                ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEDEF'      ,2 ,1,'pct_basedef_recs_of_all_recs'                         ,pcs(cnt_basedef_recs,cnt_base_recs)                  ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEDEF'      ,3 ,1,'cnt_basedef_ids'                                      ,iwc(cnt_basedef_ids)                                 ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEDEF'      ,4 ,1,'pct_basedef_ids_of_all_ids'                           ,pcs(cnt_basedef_ids,cnt_base_ids)                    ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEDEF'      ,5 ,1,'filter_basedef'                                       ,base_filter                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEID'       ,1 ,1,'cnt_baseid_recs'                                      ,iwc(cnt_baseid_recs)                                 ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEID'       ,2 ,1,'pct_baseid_recs_of_all_recs'                          ,pcs(cnt_baseid_recs,cnt_base_recs)                   ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEID'       ,3 ,1,'cnt_baseid_ids'                                       ,iwc(cnt_baseid_ids)                                  ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
        ,{default_rpt_ver, 'SUMMARY'  ,'BASEID'       ,4 ,1,'pct_baseid_ids_of_all_ids'                            ,pcs(cnt_baseid_ids,cnt_base_ids)                     ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
    ], stats_file_lo);
 
 
  // ---------------------------------------------------------------------
  // Field Report Macro
  // ---------------------------------------------------------------------
  EXPORT mac_field_report(abbr_in, fields_in, filter_in, id_in = 'proxid', rec_in = 'rcid') := MACRO
 
    EXPORT #EXPAND(abbr_in+'_fields')                 := REGEXREPLACE(',[ \t]*',fields_in,',');
    EXPORT #EXPAND(abbr_in+'_fields_text')            := REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),'_');
    EXPORT #EXPAND(abbr_in+'_viz_row')                := field_config(abbr=abbr_in)[1].id;
 
    EXPORT #EXPAND(abbr_in+'_val_base')               := PROJECT(id_base(#EXPAND(filter_in)), TRANSFORM({#EXPAND('id_base.'+REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),', id_base.')), id_base.id_in, id_base.rec_in, sanity_field_lo }, SELF:=LEFT)) : INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tot_recs')               := COUNT(#EXPAND(abbr_in+'_val_base'));
    EXPORT #EXPAND(abbr_in+'_avg_recs')               := #EXPAND(abbr_in+'_tot_recs')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_val_base_df')            := PROJECT(DISTRIBUTE(#EXPAND(abbr_in+'_val_base'),HASH32(#EXPAND(#EXPAND(abbr_in+'_fields')))), TRANSFORM({RECORDOF(LEFT), UNSIGNED2 node}, SELF.node:=STD.System.Thorlib.Node(), SELF:=LEFT),LOCAL) : INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_val_base_di')            := PROJECT(DISTRIBUTE(#EXPAND(abbr_in+'_val_base'),HASH32(id_in))                              , TRANSFORM({RECORDOF(LEFT), UNSIGNED2 node}, SELF.node:=STD.System.Thorlib.Node(), SELF:=LEFT),LOCAL) : INDEPENDENT;
 
    // Values Info
    EXPORT #EXPAND(abbr_in+'_tb_val_uniq')            := TABLE(#EXPAND(abbr_in+'_val_base_df'),  { #EXPAND(#EXPAND(abbr_in+'_fields')),        UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(#EXPAND(abbr_in+'_val_base_df'))),                                      id_in, rec_in, #EXPAND(sanity_fields)     , node }, #EXPAND(#EXPAND(abbr_in+'_fields')), LOCAL) : ONWARNING(2168,ignore), PERSIST(persist_prefix+abbr_in+'_tb_val_uniq', EXPIRE(persist_expire), SINGLE);//, INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tot_vals')               := COUNT(#EXPAND(abbr_in+'_tb_val_uniq'));
    EXPORT #EXPAND(abbr_in+'_avg_vals')               := #EXPAND(abbr_in+'_tot_vals')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tb_val_srcs')            := TABLE(#EXPAND(abbr_in+'_val_base_df'),  { src,                                        UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(#EXPAND(abbr_in+'_val_base_df'))), #EXPAND(#EXPAND(abbr_in+'_fields')), id_in, rec_in, #EXPAND(sanity_fields[5..]), node }, src,                                 FEW)   : ONWARNING(2168,ignore);
    EXPORT #EXPAND(abbr_in+'_tb_val_ids')             := TABLE(#EXPAND(abbr_in+'_val_base_di'),  { id_in,                                      UNSIGNED rec_cnt:=COUNT(GROUP), REAL rec_pct:=pct(COUNT(GROUP),COUNT(#EXPAND(abbr_in+'_val_base_di'))), #EXPAND(#EXPAND(abbr_in+'_fields')),        rec_in, #EXPAND(sanity_fields)     , node }, id_in,                               LOCAL) : ONWARNING(2168,ignore);//, INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tot_ids')                := COUNT(#EXPAND(abbr_in+'_tb_val_ids'));
    EXPORT #EXPAND(abbr_in+'_avg_ids')                := #EXPAND(abbr_in+'_tot_ids') /thor_nodes;
 
    EXPORT #EXPAND(abbr_in+'_sort_val_uniq')          := SORT(#EXPAND(abbr_in+'_tb_val_uniq'),      -rec_cnt, #EXPAND(#EXPAND(abbr_in+'_fields')));
    EXPORT #EXPAND(abbr_in+'_top_val_uniq')           := #EXPAND('TRIM((STRING)'+abbr_in+'_sort_val_uniq'+'[1].'+   REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),')+\' | \'+TRIM((STRING)'+abbr_in+'_sort_val_uniq'+'[1].')+');');
    EXPORT #EXPAND(abbr_in+'_sort_val_srcs')          := SORT(#EXPAND(abbr_in+'_tb_val_srcs'),      -rec_cnt, #EXPAND(#EXPAND(abbr_in+'_fields')));
 
    // Values Report
    EXPORT #EXPAND(abbr_in+'_report_values')          := ORDERED(
      OUTPUT('_____'+abbr_in+'_Values_____',NAMED('_____'+abbr_in+'_Values_____'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_val_base')))      +' ('+pcs(COUNT(#EXPAND(abbr_in+'_val_base'))   ,cnt_baseid_recs)        +'% of all recs)',          NAMED('cnt_'+abbr_in+'_recs'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_val_ids')))    +' ('+pcs(COUNT(#EXPAND(abbr_in+'_tb_val_ids')) ,cnt_baseid_ids)         +'% of all IDs)',           NAMED('cnt_'+abbr_in+'_ids'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')))   +' ('+pcs(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')),COUNT(#EXPAND(abbr_in+'_val_base')))+'% of '+abbr_in+' recs)',  NAMED('cnt_'+abbr_in+'_uniq_vals'));
      OUTPUT(pct(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')),COUNT(#EXPAND(abbr_in+'_tb_val_ids')) *100),NAMED('avg_'+abbr_in+'_uniq_vals_per_ID'));
      OUTPUT(pct(COUNT(#EXPAND(abbr_in+'_tb_val_ids')), COUNT(#EXPAND(abbr_in+'_tb_val_uniq'))*100),NAMED('avg_'+abbr_in+'_IDs_per_uniq_val'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_val_uniq')),      NAMED(abbr_in+'_uniq_vals'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_val_srcs')),      NAMED(abbr_in+'_srcs'));
    );
 
    // Values Stats
    EXPORT #EXPAND(abbr_in+'_stats_values')           := DATASET([
       {default_rpt_ver, 'VALS'     ,abbr_in       ,1 ,1,'cnt_val_recs'                   ,iwc(COUNT(#EXPAND(abbr_in+'_val_base')))                                              ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,2 ,1,'pct_val_recs_of_all_recs'       ,pcs(COUNT(#EXPAND(abbr_in+'_val_base'))   ,cnt_baseid_recs)                           ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,3 ,1,'cnt_val_ids'                    ,iwc(COUNT(#EXPAND(abbr_in+'_tb_val_ids')))                                            ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,4 ,1,'pct_val_ids_of_all_ids'         ,pcs(COUNT(#EXPAND(abbr_in+'_tb_val_ids')) ,cnt_baseid_ids)                            ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,5 ,1,'cnt_uniq_vals'                  ,iwc(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')))                                           ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,6 ,1,'pct_uniq_vals_of_val_recs'      ,pcs(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')),COUNT(#EXPAND(abbr_in+'_val_base')))       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,7 ,1,'avg_vals_per_id'                ,pct(COUNT(#EXPAND(abbr_in+'_tb_val_uniq')),COUNT(#EXPAND(abbr_in+'_tb_val_ids')) *100),default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,8 ,1,'avg_ids_per_val'                ,pct(COUNT(#EXPAND(abbr_in+'_tb_val_ids' )),COUNT(#EXPAND(abbr_in+'_tb_val_uniq'))*100),default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,9 ,1,'top_uniq_val'                   ,#EXPAND(abbr_in+'_top_val_uniq')                                                      ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,10,1,'top_uniq_val_rec_cnt'           ,#EXPAND(abbr_in+'_sort_val_uniq')[1].rec_cnt                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,11,1,'top_uniq_val_rec_pct'           ,#EXPAND(abbr_in+'_sort_val_uniq')[1].rec_pct                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,12,1,'top_src'                        ,#EXPAND(abbr_in+'_sort_val_srcs')[1].src                                              ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,13,1,'top_src_rec_cnt'                ,#EXPAND(abbr_in+'_sort_val_srcs')[1].rec_cnt                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in       ,14,1,'top_src_rec_pct'                ,#EXPAND(abbr_in+'_sort_val_srcs')[1].rec_pct                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
    ], stats_file_lo);
 
    // One Value, Multiple IDs
    EXPORT #EXPAND(abbr_in+'_tb_val_id_dd')           := TABLE(#EXPAND(abbr_in+'_val_base_df'),  { #EXPAND(#EXPAND(abbr_in+'_fields')), id_in, UNSIGNED rec_cnt:=COUNT(GROUP),                                                                                                                                       rec_in, #EXPAND(sanity_fields), node }, #EXPAND(#EXPAND(abbr_in+'_fields')), id_in, LOCAL) : ONWARNING(2168,ignore), INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tb_val_dd')              := TABLE(#EXPAND(abbr_in+'_tb_val_id_dd'), { #EXPAND(#EXPAND(abbr_in+'_fields')),        UNSIGNED id_cnt :=COUNT(GROUP), UNSIGNED tot_rec_cnt:=SUM(GROUP,rec_cnt), UNSIGNED xjoin_cnt:=(COUNT(GROUP)-1)*(COUNT(GROUP)-1), id_in,                               rec_in, #EXPAND(sanity_fields), node }, #EXPAND(#EXPAND(abbr_in+'_fields')),        LOCAL) : ONWARNING(2168,ignore);
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id')         := #EXPAND(abbr_in+'_tb_val_dd')(id_cnt>1) : PERSIST(persist_prefix+abbr_in+'_tb_val_mult_id', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id_out')     := #EXPAND(abbr_in+'_tb_val_mult_id')(id_cnt > max_xjoin_in_cnt);
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id_use')     := #EXPAND(abbr_in+'_tb_val_mult_id')(id_cnt <=max_xjoin_in_cnt);
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id_ex')      := JOIN(#EXPAND(abbr_in+'_tb_val_id_dd'), #EXPAND(abbr_in+'_tb_val_mult_id'),
                                                           #EXPAND('LEFT.'+REGEXREPLACE(',',REGEXREPLACE('([^,]+)',#EXPAND(abbr_in+'_fields'),'$1=RIGHT.$1'),' AND LEFT.')),
                                                           TRANSFORM({UNSIGNED id_cnt,  RECORDOF(LEFT)}, SELF.id_cnt :=RIGHT.id_cnt,  SELF:=LEFT), KEEP(keep_count), LOCAL)
                                                           : PERSIST(persist_prefix+abbr_in+'_tb_val_mult_id_ex', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;

    EXPORT #EXPAND(abbr_in+'_tot_vmi_vals')           := COUNT(#EXPAND(abbr_in+'_tb_val_mult_id'));
    EXPORT #EXPAND(abbr_in+'_avg_vmi_vals')           := #EXPAND(abbr_in+'_tot_vmi_vals')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_ids')            := SUM(#EXPAND(abbr_in+'_tb_val_mult_id'),id_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_ids')            := #EXPAND(abbr_in+'_tot_vmi_ids') /thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_recs')           := SUM(#EXPAND(abbr_in+'_tb_val_mult_id'),tot_rec_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_recs')           := #EXPAND(abbr_in+'_tot_vmi_recs')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_xjns')           := SUM(#EXPAND(abbr_in+'_tb_val_mult_id'),xjoin_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_xjns')           := #EXPAND(abbr_in+'_tot_vmi_xjns')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id_sk')      := TABLE(#EXPAND(abbr_in+'_tb_val_mult_id'), { node,
                                                           UNSIGNED node_val_cnt:=COUNT(GROUP),           REAL node_val_pct:=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_vmi_vals')    *100,2), REAL node_val_skew:=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_vmi_vals')    *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_id_cnt :=SUM(GROUP,id_cnt),      REAL node_id_pct :=ROUND(SUM(GROUP,id_cnt)     /#EXPAND(abbr_in+'_tot_vmi_ids')     *100,2), REAL node_id_skew :=ROUND(SUM(GROUP,id_cnt)     /#EXPAND(abbr_in+'_tot_vmi_ids')     *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_rec_cnt:=SUM(GROUP,tot_rec_cnt), REAL node_rec_pct:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_vmi_recs')    *100,2), REAL node_rec_skew:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_vmi_recs')    *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_xjn_cnt:=SUM(GROUP,xjoin_cnt),   REAL node_xjn_pct:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_vmi_xjns')    *100,2), REAL node_xjn_skew:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_vmi_xjns')    *100/avg_dist_pct-1,2)
                                                           }, node, LOCAL);
    EXPORT #EXPAND(abbr_in+'_tot_vmi_vals_use')       := COUNT(#EXPAND(abbr_in+'_tb_val_mult_id_use'));
    EXPORT #EXPAND(abbr_in+'_avg_vmi_vals_use')       := #EXPAND(abbr_in+'_tot_vmi_vals_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_ids_use')        := SUM(#EXPAND(abbr_in+'_tb_val_mult_id_use'),id_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_ids_use')        := #EXPAND(abbr_in+'_tot_vmi_ids_use') /thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_recs_use')       := SUM(#EXPAND(abbr_in+'_tb_val_mult_id_use'),tot_rec_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_recs_use')       := #EXPAND(abbr_in+'_tot_vmi_recs_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_vmi_xjns_use')       := SUM(#EXPAND(abbr_in+'_tb_val_mult_id_use'),xjoin_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_vmi_xjns_use')       := #EXPAND(abbr_in+'_tot_vmi_xjns_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tb_val_mult_id_sk_use')  := TABLE(#EXPAND(abbr_in+'_tb_val_mult_id_use'), { node,
                                                           UNSIGNED node_val_cnt:=COUNT(GROUP),           REAL node_val_pct:=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_vmi_vals_use')*100,2), REAL node_val_skew:=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_vmi_vals_use')*100/avg_dist_pct-1,2),
                                                           UNSIGNED node_id_cnt :=SUM(GROUP,id_cnt),      REAL node_id_pct :=ROUND(SUM(GROUP,id_cnt)     /#EXPAND(abbr_in+'_tot_vmi_ids_use') *100,2), REAL node_id_skew :=ROUND(SUM(GROUP,id_cnt)     /#EXPAND(abbr_in+'_tot_vmi_ids_use') *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_rec_cnt:=SUM(GROUP,tot_rec_cnt), REAL node_rec_pct:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_vmi_recs_use')*100,2), REAL node_rec_skew:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_vmi_recs_use')*100/avg_dist_pct-1,2),
                                                           UNSIGNED node_xjn_cnt:=SUM(GROUP,xjoin_cnt),   REAL node_xjn_pct:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_vmi_xjns_use')*100,2), REAL node_xjn_skew:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_vmi_xjns_use')*100/avg_dist_pct-1,2)
                                                           }, node, LOCAL);
 
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id')       := SORT(#EXPAND(abbr_in+'_tb_val_mult_id'),       -id_cnt, #EXPAND(#EXPAND(abbr_in+'_fields')));
    EXPORT #EXPAND(abbr_in+'_top_val_mult_id')        := #EXPAND('TRIM((STRING)'+abbr_in+'_sort_val_mult_id'+'[1].'+REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),')+\' | \'+TRIM((STRING)'+abbr_in+'_sort_val_mult_id'+'[1].')+');');
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_ex')    := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_ex'),    -id_cnt, #EXPAND(#EXPAND(abbr_in+'_fields')));
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_v')  := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk'),    -node_val_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_i')  := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk'),    -node_id_cnt,  node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_r')  := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk'),    -node_rec_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_x')  := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk'),    -node_xjn_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_uv') := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),-node_val_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_ui') := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),-node_id_cnt,  node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_ur') := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),-node_rec_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_val_mult_id_sk_ux') := SORT(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),-node_xjn_cnt, node);
 
    // One Value, Multiple IDs Report
    EXPORT #EXPAND(abbr_in+'_report_1_val_m_id')      := ORDERED(
      OUTPUT('_____1_'+abbr_in+'_Val_w_Mult_IDs_____',NAMED('_____1_'+abbr_in+'_Val_w_Mult_IDs_____'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id')))+' ('+pcs(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id')),COUNT(#EXPAND(abbr_in+'_tb_val_uniq')))+'% of uniq vals)',         NAMED('cnt_'+abbr_in+'_vals_w_mult_ids'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id_out'))),NAMED('cnt_'+abbr_in+'_vals_w_mult_ids_outliers'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_val_mult_id')),     NAMED(abbr_in+'_vals_w_mult_ids'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_val_mult_id_ex')),  NAMED(abbr_in+'_vals_w_mult_ids_examples'));
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_val_mult_id_sk'    ),node_id_skew )-MIN(#EXPAND(abbr_in+'_tb_val_mult_id_sk'    ),node_id_skew )),NAMED('tot_'+abbr_in+'_vals_w_mult_ids_skew_id'     ),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),node_id_skew )-MIN(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),node_id_skew )),NAMED('tot_'+abbr_in+'_vals_w_mult_ids_skew_use_id' ),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_val_mult_id_sk'    ),node_xjn_skew)-MIN(#EXPAND(abbr_in+'_tb_val_mult_id_sk'    ),node_xjn_skew)),NAMED('tot_'+abbr_in+'_vals_w_mult_ids_skew_xjn'    ),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),node_xjn_skew)-MIN(#EXPAND(abbr_in+'_tb_val_mult_id_sk_use'),node_xjn_skew)),NAMED('tot_'+abbr_in+'_vals_w_mult_ids_skew_use_xjn'),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_v') [..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_v') [thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_val'       ),ALL);
//2019      OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_i') [..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_i') [thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_id'        ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_r') [..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_r') [thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_rec'       ),ALL);
//2019      OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_x') [..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_x') [thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_xjn'       ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_uv')[..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_uv')[thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_use_val'   ),ALL);
      OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_ui')[..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_ui')[thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_use_id'    ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_ur')[..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_ur')[thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_use_rec'   ),ALL);
      OUTPUT(#EXPAND(abbr_in+'_sort_val_mult_id_sk_ux')[..50]+#EXPAND(abbr_in+'_sort_val_mult_id_sk_ux')[thor_nodes-49..],NAMED(abbr_in+'_vals_w_mult_ids_skew_use_xjn'   ),ALL);
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_val_skew'    ,,abbr_in+'_vals_w_mult_ids_skew_val',       viz_map2('node','node','val_skew','node_val_skew'),,viz_props('val_skew_'    +abbr_in+'_vmi',2.5,-0.5));
//2019      Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_id_skew'     ,,abbr_in+'_vals_w_mult_ids_skew_id' ,       viz_map2('node','node','id_skew' ,'node_id_skew' ),,viz_props('id_skew_'     +abbr_in+'_vmi',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_rec_skew'    ,,abbr_in+'_vals_w_mult_ids_skew_rec',       viz_map2('node','node','rec_skew','node_rec_skew'),,viz_props('rec_skew_'    +abbr_in+'_vmi',2.5,-0.5));
//2019      Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_xjn_skew'    ,,abbr_in+'_vals_w_mult_ids_skew_xjn',       viz_map2('node','node','xjn_skew','node_xjn_skew'),,viz_props('xjn_skew_'    +abbr_in+'_vmi',5.0,-1.0));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_val_skew_use',,abbr_in+'_vals_w_mult_ids_skew_use_val',   viz_map2('node','node','val_skew','node_val_skew'),,viz_props('val_skew_use_'+abbr_in+'_vmi',2.5,-0.5));
//2020      Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_id_skew_use' ,,abbr_in+'_vals_w_mult_ids_skew_use_id' ,   viz_map2('node','node','id_skew' ,'node_id_skew' ),,viz_props('id_skew_use_' +abbr_in+'_vmi',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_rec_skew_use',,abbr_in+'_vals_w_mult_ids_skew_use_rec',   viz_map2('node','node','rec_skew','node_rec_skew'),,viz_props('rec_skew_use_'+abbr_in+'_vmi',2.5,-0.5));
//2020      Visualizer.MultiD.column(viz_prefix+abbr_in+'_vmi_xjn_skew_use',,abbr_in+'_vals_w_mult_ids_skew_use_xjn',   viz_map2('node','node','xjn_skew','node_xjn_skew'),,viz_props('xjn_skew_use_'+abbr_in+'_vmi',5.0,-1.0));
    );
 
    //EXPORT #EXPAND(abbr_in+'_viz_layout_vmi_sk_ui')   := viz_layout(abbr_in+'_VMI_id_skew_use' , viz_prefix+abbr_in+'_vmi_id_skew_use' , viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4), 'node', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4)+2, 'id_skew' , 'id_skew_use_' +abbr_in+'_vmi', 'hpcc10', #EXPAND(abbr_in+'_viz_row'), 1) +',';
    //EXPORT #EXPAND(abbr_in+'_viz_layout_vmi_sk_ux')   := viz_layout(abbr_in+'_VMI_xjn_skew_use', viz_prefix+abbr_in+'_vmi_xjn_skew_use', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4), 'node', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4)+2, 'xjn_skew', 'xjn_skew_use_'+abbr_in+'_vmi', 'hpcc10', #EXPAND(abbr_in+'_viz_row'), 2) +',';
    //EXPORT #EXPAND(abbr_in+'_viz_layout_vmi_sk_u')    := #EXPAND(abbr_in+'_viz_layout_vmi_sk_ui') + #EXPAND(abbr_in+'_viz_layout_vmi_sk_ux');

    // One Value, Multiple IDs Stats
    EXPORT #EXPAND(abbr_in+'_stats_1_val_m_id')       := DATASET([
       {default_rpt_ver, 'VALS'     ,abbr_in+'_VMI',1 ,1,'cnt_1_val_mult_id'              ,iwc(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id')))                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_VMI',2 ,1,'pct_1_val_mult_id_of_uniq_vals' ,pcs(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id')),COUNT(#EXPAND(abbr_in+'_tb_val_uniq'))) ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_VMI',3 ,1,'top_1_val_mult_id'              ,#EXPAND(abbr_in+'_top_val_mult_id')                                                   ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_VMI',4 ,1,'top_1_val_mult_id_id_cnt'       ,#EXPAND(abbr_in+'_sort_val_mult_id')[1].id_cnt                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_VMI',5 ,1,'cnt_1_val_mult_id_outliers'     ,iwc(COUNT(#EXPAND(abbr_in+'_tb_val_mult_id_out')))                                    ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
    ], stats_file_lo);
 
    // One ID, Multiple Values
    EXPORT #EXPAND(abbr_in+'_tb_id_val_dd')           := TABLE(#EXPAND(abbr_in+'_val_base_di'),  { id_in, #EXPAND(#EXPAND(abbr_in+'_fields')), UNSIGNED rec_cnt:=COUNT(GROUP),                                                                                                                                       rec_in, #EXPAND(sanity_fields), node }, id_in, #EXPAND(#EXPAND(abbr_in+'_fields')), LOCAL) : ONWARNING(2168,ignore), INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tb_id_dd')               := TABLE(#EXPAND(abbr_in+'_tb_id_val_dd'), { id_in,                                      UNSIGNED val_cnt:=COUNT(GROUP), UNSIGNED tot_rec_cnt:=SUM(GROUP,rec_cnt), UNSIGNED xjoin_cnt:=(COUNT(GROUP)-1)*(COUNT(GROUP)-1), #EXPAND(#EXPAND(abbr_in+'_fields')), rec_in, #EXPAND(sanity_fields), node }, id_in,                                      LOCAL) : ONWARNING(2168,ignore);
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val')         := #EXPAND(abbr_in+'_tb_id_dd')(val_cnt>1) : PERSIST(persist_prefix+abbr_in+'_tb_id_mult_val', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val_out')     := #EXPAND(abbr_in+'_tb_id_mult_val')(val_cnt> max_xjoin_in_cnt);
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val_use')     := #EXPAND(abbr_in+'_tb_id_mult_val')(val_cnt<=max_xjoin_in_cnt);
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val_ex')      := JOIN(#EXPAND(abbr_in+'_tb_id_val_dd'), #EXPAND(abbr_in+'_tb_id_mult_val'),
                                                           LEFT.id_in=RIGHT.id_in,
                                                           TRANSFORM({UNSIGNED val_cnt, RECORDOF(LEFT)}, SELF.val_cnt:=RIGHT.val_cnt, SELF:=LEFT), KEEP(keep_count), LOCAL)
                                                           : PERSIST(persist_prefix+abbr_in+'_tb_id_mult_val_ex', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;
 
    EXPORT #EXPAND(abbr_in+'_tot_imv_vals')           := SUM(#EXPAND(abbr_in+'_tb_id_mult_val'),val_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_vals')           := #EXPAND(abbr_in+'_tot_imv_vals')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_ids')            := COUNT(#EXPAND(abbr_in+'_tb_id_mult_val'));
    EXPORT #EXPAND(abbr_in+'_avg_imv_ids')            := #EXPAND(abbr_in+'_tot_imv_ids') /thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_recs')           := SUM(#EXPAND(abbr_in+'_tb_id_mult_val'),tot_rec_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_recs')           := #EXPAND(abbr_in+'_tot_imv_recs')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_xjns')           := SUM(#EXPAND(abbr_in+'_tb_id_mult_val'),xjoin_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_xjns')           := #EXPAND(abbr_in+'_tot_imv_xjns')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val_sk')      := TABLE(#EXPAND(abbr_in+'_tb_id_mult_val'), { node,
                                                           UNSIGNED node_val_cnt:=SUM(GROUP,val_cnt),     REAL node_val_pct:=ROUND(SUM(GROUP,val_cnt)    /#EXPAND(abbr_in+'_tot_imv_vals')    *100,2), REAL node_val_skew:=ROUND(SUM(GROUP,val_cnt)    /#EXPAND(abbr_in+'_tot_imv_vals')    *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_id_cnt :=COUNT(GROUP),           REAL node_id_pct :=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_imv_ids')     *100,2), REAL node_id_skew :=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_imv_ids')     *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_rec_cnt:=SUM(GROUP,tot_rec_cnt), REAL node_rec_pct:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_imv_recs')    *100,2), REAL node_rec_skew:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_imv_recs')    *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_xjn_cnt:=SUM(GROUP,xjoin_cnt),   REAL node_xjn_pct:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_imv_xjns')    *100,2), REAL node_xjn_skew:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_imv_xjns')    *100/avg_dist_pct-1,2)
                                                           }, node, LOCAL);
    EXPORT #EXPAND(abbr_in+'_tot_imv_vals_use')       := SUM(#EXPAND(abbr_in+'_tb_id_mult_val_use'),val_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_vals_use')       := #EXPAND(abbr_in+'_tot_imv_vals_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_ids_use')        := COUNT(#EXPAND(abbr_in+'_tb_id_mult_val_use'));
    EXPORT #EXPAND(abbr_in+'_avg_imv_ids_use')        := #EXPAND(abbr_in+'_tot_imv_ids_use') /thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_recs_use')       := SUM(#EXPAND(abbr_in+'_tb_id_mult_val_use'),tot_rec_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_recs_use')       := #EXPAND(abbr_in+'_tot_imv_recs_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tot_imv_xjns_use')       := SUM(#EXPAND(abbr_in+'_tb_id_mult_val_use'),xjoin_cnt);
    EXPORT #EXPAND(abbr_in+'_avg_imv_xjns_use')       := #EXPAND(abbr_in+'_tot_imv_xjns_use')/thor_nodes;
    EXPORT #EXPAND(abbr_in+'_tb_id_mult_val_sk_use')  := TABLE(#EXPAND(abbr_in+'_tb_id_mult_val_use'), { node,
                                                           UNSIGNED node_val_cnt:=SUM(GROUP,val_cnt),     REAL node_val_pct:=ROUND(SUM(GROUP,val_cnt)    /#EXPAND(abbr_in+'_tot_imv_vals_use')*100,2), REAL node_val_skew:=ROUND(SUM(GROUP,val_cnt)    /#EXPAND(abbr_in+'_tot_imv_vals_use')*100/avg_dist_pct-1,2),
                                                           UNSIGNED node_id_cnt :=COUNT(GROUP),           REAL node_id_pct :=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_imv_ids_use') *100,2), REAL node_id_skew :=ROUND(COUNT(GROUP)          /#EXPAND(abbr_in+'_tot_imv_ids_use') *100/avg_dist_pct-1,2),
                                                           UNSIGNED node_rec_cnt:=SUM(GROUP,tot_rec_cnt), REAL node_rec_pct:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_imv_recs_use')*100,2), REAL node_rec_skew:=ROUND(SUM(GROUP,tot_rec_cnt)/#EXPAND(abbr_in+'_tot_imv_recs_use')*100/avg_dist_pct-1,2),
                                                           UNSIGNED node_xjn_cnt:=SUM(GROUP,xjoin_cnt),   REAL node_xjn_pct:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_imv_xjns_use')*100,2), REAL node_xjn_skew:=ROUND(SUM(GROUP,xjoin_cnt)  /#EXPAND(abbr_in+'_tot_imv_xjns_use')*100/avg_dist_pct-1,2)
                                                           }, node, LOCAL);
 
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val')       := SORT(#EXPAND(abbr_in+'_tb_id_mult_val'),       -val_cnt, id_in);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_ex')    := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_ex'),    -val_cnt, id_in);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_v')  := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk'),    -node_val_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_i')  := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk'),    -node_id_cnt,  node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_r')  := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk'),    -node_rec_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_x')  := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk'),    -node_xjn_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_uv') := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),-node_val_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_ui') := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),-node_id_cnt,  node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_ur') := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),-node_rec_cnt, node);
    EXPORT #EXPAND(abbr_in+'_sort_id_mult_val_sk_ux') := SORT(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),-node_xjn_cnt, node);
 
 
    // One ID, Multiple Values Report
    EXPORT #EXPAND(abbr_in+'_report_1_id_m_val')      := ORDERED(
      OUTPUT('_____1_ID_w_Mult_'+abbr_in+'_Vals_____',NAMED('_____1_ID_w_Mult_'+abbr_in+'_Vals_____'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val')))+' ('+pcs(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val')),COUNT(#EXPAND(abbr_in+'_tb_val_ids')))+'% of '+abbr_in+' IDs)',    NAMED('cnt_ids_w_mult_'+abbr_in+'_vals'));
      OUTPUT(iwc(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val_out'))),NAMED('cnt_ids_w_mult_'+abbr_in+'_vals_outliers'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_id_mult_val')),     NAMED('ids_w_mult_'+abbr_in+'_vals'));
      OUTPUT(samples(#EXPAND(abbr_in+'_sort_id_mult_val_ex')),  NAMED('ids_w_mult_'+abbr_in+'_vals_examples'));
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_id_mult_val_sk'    ),node_val_skew)-MIN(#EXPAND(abbr_in+'_tb_id_mult_val_sk'    ),node_val_skew)),NAMED('tot_ids_w_mult_'+abbr_in+'_vals_skew_val'    ),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),node_val_skew)-MIN(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),node_val_skew)),NAMED('tot_ids_w_mult_'+abbr_in+'_vals_skew_use_val'),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_id_mult_val_sk'    ),node_xjn_skew)-MIN(#EXPAND(abbr_in+'_tb_id_mult_val_sk'    ),node_xjn_skew)),NAMED('tot_ids_w_mult_'+abbr_in+'_vals_skew_xjn'    ),ALL);
      OUTPUT(trm(MAX(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),node_xjn_skew)-MIN(#EXPAND(abbr_in+'_tb_id_mult_val_sk_use'),node_xjn_skew)),NAMED('tot_ids_w_mult_'+abbr_in+'_vals_skew_use_xjn'),ALL);
//2019      OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_v') [..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_v') [thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_val'    ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_i') [..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_i') [thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_id'     ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_r') [..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_r') [thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_rec'    ),ALL);
//2019      OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_x') [..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_x') [thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_xjn'    ),ALL);
      OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_uv')[..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_uv')[thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_use_val'),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_ui')[..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_ui')[thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_use_id' ),ALL);
      //OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_ur')[..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_ur')[thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_use_rec'),ALL);
      OUTPUT(#EXPAND(abbr_in+'_sort_id_mult_val_sk_ux')[..50]+#EXPAND(abbr_in+'_sort_id_mult_val_sk_ux')[thor_nodes-49..],NAMED('ids_w_mult_'+abbr_in+'_vals_skew_use_xjn'),ALL);
//2019      Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_val_skew'    ,,'ids_w_mult_'+abbr_in+'_vals_skew_val',    viz_map2('node','node','val_skew','node_val_skew'),,viz_props('val_skew_'    +abbr_in+'_imv',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_id_skew'     ,,'ids_w_mult_'+abbr_in+'_vals_skew_id',     viz_map2('node','node','id_skew' ,'node_id_skew' ),,viz_props('id_skew_'     +abbr_in+'_imv',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_rec_skew'    ,,'ids_w_mult_'+abbr_in+'_vals_skew_rec',    viz_map2('node','node','rec_skew','node_rec_skew'),,viz_props('rec_skew_'    +abbr_in+'_imv',2.5,-0.5));
//2019      Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_xjn_skew'    ,,'ids_w_mult_'+abbr_in+'_vals_skew_xjn',    viz_map2('node','node','xjn_skew','node_xjn_skew'),,viz_props('xjn_skew_'    +abbr_in+'_imv',5.0,-1.0));
//2020      Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_val_skew_use',,'ids_w_mult_'+abbr_in+'_vals_skew_use_val',viz_map2('node','node','val_skew','node_val_skew'),,viz_props('val_skew_use_'+abbr_in+'_imv',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_id_skew_use' ,,'ids_w_mult_'+abbr_in+'_vals_skew_use_id', viz_map2('node','node','id_skew' ,'node_id_skew' ),,viz_props('id_skew_use_' +abbr_in+'_imv',2.5,-0.5));
      //Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_rec_skew_use',,'ids_w_mult_'+abbr_in+'_vals_skew_use_rec',viz_map2('node','node','rec_skew','node_rec_skew'),,viz_props('rec_skew_use_'+abbr_in+'_imv',2.5,-0.5));
//2020      Visualizer.MultiD.column(viz_prefix+abbr_in+'_imv_xjn_skew_use',,'ids_w_mult_'+abbr_in+'_vals_skew_use_xjn',viz_map2('node','node','xjn_skew','node_xjn_skew'),,viz_props('xjn_skew_use_'+abbr_in+'_imv',5.0,-1.0));
    );
 
    //EXPORT #EXPAND(abbr_in+'_viz_layout_imv_sk_uv')   := viz_layout(abbr_in+'_IMV_val_skew_use', viz_prefix+abbr_in+'_imv_val_skew_use', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4), 'node', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4)+2, 'val_skew', 'val_skew_use_'+abbr_in+'_imv', 'hpcc10', #EXPAND(abbr_in+'_viz_row'), 3) +',';
    //EXPORT #EXPAND(abbr_in+'_viz_layout_imv_sk_ux')   := viz_layout(abbr_in+'_IMV_xjn_skew_use', viz_prefix+abbr_in+'_imv_xjn_skew_use', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4), 'node', viz_startid+((#EXPAND(abbr_in+'_viz_row')-1)*4)+2, 'xjn_skew', 'xjn_skew_use_'+abbr_in+'_imv', 'hpcc10', #EXPAND(abbr_in+'_viz_row'), 4) +',';
    //EXPORT #EXPAND(abbr_in+'_viz_layout_imv_sk_u')    := #EXPAND(abbr_in+'_viz_layout_imv_sk_uv') + #EXPAND(abbr_in+'_viz_layout_imv_sk_ux');

    // One ID, Multiple Values Stats
    EXPORT #EXPAND(abbr_in+'_stats_1_id_m_val')       := DATASET([
       {default_rpt_ver, 'VALS'     ,abbr_in+'_IMV',1 ,1,'cnt_1_id_mult_val'              ,iwc(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val')))                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_IMV',2 ,1,'pct_1_id_mult_val_of_val_ids'   ,pcs(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val')),COUNT(#EXPAND(abbr_in+'_tb_val_ids' ))) ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_IMV',3 ,1,'top_1_id_mult_val'              ,#EXPAND(abbr_in+'_sort_id_mult_val')[1].id_in                                         ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_IMV',4 ,1,'top_1_id_mult_val_val_cnt'      ,#EXPAND(abbr_in+'_sort_id_mult_val')[1].val_cnt                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'VALS'     ,abbr_in+'_IMV',5 ,1,'cnt_1_id_mult_val_outliers'     ,iwc(COUNT(#EXPAND(abbr_in+'_tb_id_mult_val_out')))                                    ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
    ], stats_file_lo);
 
    // Complete Report
    EXPORT #EXPAND(abbr_in+'_report_header')          := OUTPUT('==================================================',NAMED(#EXPAND(abbr_in+'_fields_text')+'_field_report'));
    EXPORT #EXPAND(abbr_in+'_report_all')             := ORDERED(
      #EXPAND(abbr_in+'_report_header');
      #EXPAND(abbr_in+'_report_values');
      #EXPAND(abbr_in+'_report_1_val_m_id');
      #EXPAND(abbr_in+'_report_1_id_m_val');
    );
 
    // Complete Viz layout props
    //EXPORT #EXPAND(abbr_in+'_viz_layout')             := #EXPAND(abbr_in+'_viz_layout_vmi_sk_u')  + #EXPAND(abbr_in+'_viz_layout_imv_sk_u');

    // Complete Stats File Updates
    EXPORT #EXPAND(abbr_in+'_stats_all')              := #EXPAND(abbr_in+'_stats_values') + #EXPAND(abbr_in+'_stats_1_val_m_id') + #EXPAND(abbr_in+'_stats_1_id_m_val');
 
  ENDMACRO;
 
 
  // ---------------------------------------------------------------------
  // Initialize Field Reports Exports
  // ---------------------------------------------------------------------
/*
  mac_field_report_by_config(in_ds) := MACRO
    mac_field_report(in_ds[1].abbr, in_ds[1].fields, in_ds[1].filter);
  ENDMACRO;
  // IDs - External
  mac_field_report_by_config(field_config(abbr='ENT_A'));
  mac_field_report_by_config(field_config(abbr='ENT_H'));
  mac_field_report_by_config(field_config(abbr='ENT_X'));
  mac_field_report_by_config(field_config(abbr='DUNS_A'));
  mac_field_report_by_config(field_config(abbr='DUNS_H'));
  mac_field_report_by_config(field_config(abbr='DUNS'));
  //mac_field_report_by_config(field_config(abbr='DUNS_X'));
  mac_field_report_by_config(field_config(abbr='DCORP_A'));
  mac_field_report_by_config(field_config(abbr='DCORP_H'));
  mac_field_report_by_config(field_config(abbr='FCORP'));
  mac_field_report_by_config(field_config(abbr='UCORP'));
  mac_field_report_by_config(field_config(abbr='CORP_X'));
  mac_field_report_by_config(field_config(abbr='FEIN'));
  mac_field_report_by_config(field_config(abbr='FEIN_X'));
  mac_field_report_by_config(field_config(abbr='EBR'));
  mac_field_report_by_config(field_config(abbr='SRCVL'));
  mac_field_report_by_config(field_config(abbr='SRCRID'));
  // IDs - Internal
  mac_field_report_by_config(field_config(abbr='SELE'));
  mac_field_report_by_config(field_config(abbr='BDID'));
  // Company
  //mac_field_report_by_config(field_config(abbr='CNAME'));
  mac_field_report_by_config(field_config(abbr='CNAMEF'));
  mac_field_report_by_config(field_config(abbr='LNAME'));
  mac_field_report_by_config(field_config(abbr='DNAME'));
  mac_field_report_by_config(field_config(abbr='ADDRPSZ'));
  mac_field_report_by_config(field_config(abbr='ADDRVSZ'));
  mac_field_report_by_config(field_config(abbr='ADDRST'));
  mac_field_report_by_config(field_config(abbr='ADDRST2'));
  mac_field_report_by_config(field_config(abbr='CPHN'));
  mac_field_report_by_config(field_config(abbr='PHN_X'));
  mac_field_report_by_config(field_config(abbr='URL'));
  mac_field_report_by_config(field_config(abbr='URL_X'));
  mac_field_report_by_config(field_config(abbr='TICKER'));
  mac_field_report_by_config(field_config(abbr='TICKEX'));
  mac_field_report_by_config(field_config(abbr='CNUM'));
  mac_field_report_by_config(field_config(abbr='CSTORE'));
  mac_field_report_by_config(field_config(abbr='CHARTER'));
  mac_field_report_by_config(field_config(abbr='SIC1'));
  mac_field_report_by_config(field_config(abbr='NAICS1'));
  //mac_field_report_by_config(field_config(abbr='ADDR'));
  // Contacts
  mac_field_report_by_config(field_config(abbr='OWNDID'));
  mac_field_report_by_config(field_config(abbr='PDID'));
  mac_field_report_by_config(field_config(abbr='DID_X'));
  mac_field_report_by_config(field_config(abbr='PNAME'));
  mac_field_report_by_config(field_config(abbr='PSSN'));
  mac_field_report_by_config(field_config(abbr='PEML'));
  mac_field_report_by_config(field_config(abbr='PEMLDOM'));
  mac_field_report_by_config(field_config(abbr='PPHN'));
//*/
//*
  // IDs - External
  mac_field_report('ENT_A','active_enterprise_number','TRIM(active_enterprise_number)>\'\'');
  mac_field_report('ENT_H','hist_enterprise_number','TRIM(hist_enterprise_number)>\'\'');
  mac_field_report('ENT_X','ent_x','TRIM(ent_x)>\'\'');
  mac_field_report('DUNS_A','active_duns_number','TRIM(active_duns_number)>\'\'');
  mac_field_report('DUNS_H','hist_duns_number','TRIM(hist_duns_number)>\'\'');
  mac_field_report('DUNS','duns_number','TRIM(duns_number)>\'\'');
  //mac_field_report('DUNS_X','duns_x','TRIM(duns_x)>\'\'');
  mac_field_report('DCORP_A','active_domestic_corp_key','TRIM(active_domestic_corp_key)>\'\'');
  mac_field_report('DCORP_H','hist_domestic_corp_key','TRIM(hist_domestic_corp_key)>\'\'');
  mac_field_report('FCORP','foreign_corp_key','TRIM(foreign_corp_key)>\'\'');
  mac_field_report('UCORP','unk_corp_key','TRIM(unk_corp_key)>\'\'');
  mac_field_report('CORP_X','corp_x','TRIM(corp_x)>\'\'');
  mac_field_report('FEIN','company_fein','TRIM(company_fein)>\'\'');
  mac_field_report('FEIN_X','fein_x','TRIM(fein_x)>\'\'');
  mac_field_report('EBR','ebr_file_number','TRIM(ebr_file_number)>\'\'');
  mac_field_report('SRCVL','source,vl_id','TRIM(source)>\'\' AND TRIM(vl_id)>\'\'');
  mac_field_report('SRCRID','source,source_record_id','TRIM(source)>\'\' AND source_record_id>0');
  // IDs - Internal
  mac_field_report('SELE','seleid','seleid>0');
  mac_field_report('BDID','company_bdid','company_bdid>0');
  // Company
  //mac_field_report('CNAME','cnp_name','TRIM(cnp_name)>\'\'');
  mac_field_report('CNAMEF','cnp_name_phonetic','TRIM(cnp_name_phonetic)>\'\'');
  mac_field_report('LNAME','corp_legal_name','TRIM(corp_legal_name)>\'\'');
  mac_field_report('DNAME','dba_name','TRIM(dba_name)>\'\'');
  mac_field_report('ADDRPSZ','address_type_derived,p_city_name,st,zip','TRIM(address_type_derived)>\'\' AND TRIM(p_city_name)>\'\' AND TRIM(st)>\'\' AND TRIM(zip)>\'\'');
  mac_field_report('ADDRVSZ','address_type_derived,v_city_name,st,zip','TRIM(address_type_derived)>\'\' AND TRIM(v_city_name)>\'\' AND TRIM(st)>\'\' AND TRIM(zip)>\'\'');
  mac_field_report('ADDRST','address_type_derived,prim_range_derived,prim_name_derived','TRIM(address_type_derived)>\'\' AND TRIM(prim_range_derived)>\'\' AND TRIM(prim_name_derived)>\'\'');
  mac_field_report('ADDRST2','address_type_derived,prim_range_derived,prim_name_derived,unit_desig,sec_range','TRIM(address_type_derived)>\'\' AND TRIM(prim_range_derived)>\'\' AND TRIM(prim_name_derived)>\'\' AND (TRIM(unit_desig)>\'\' OR TRIM(sec_range)>\'\')');
  //mac_field_report('CPHN','phone_type,company_phone','TRIM(phone_type)>\'\' AND TRIM(company_phone)>\'\'');
  mac_field_report('CPHN','company_phone','TRIM(company_phone)>\'\'');
  mac_field_report('PHN_X','phn_x','TRIM(phn_x)>\'\'');
  mac_field_report('URL','company_url','TRIM(company_url)>\'\'');
  mac_field_report('URL_X','url_x','TRIM(url_x)>\'\'');
  mac_field_report('TICKER','company_ticker','TRIM(company_ticker)>\'\'');
  mac_field_report('TICKEX','company_ticker_exchange,company_ticker','TRIM(company_ticker_exchange)>\'\' AND TRIM(company_ticker)>\'\'');
  mac_field_report('CNUM','cnp_number','TRIM(cnp_number)>\'\'');
  mac_field_report('CSTORE','cnp_store_number','TRIM(cnp_store_number)>\'\'');
  mac_field_report('CHARTER','company_charter_number','TRIM(company_charter_number)>\'\'');
  mac_field_report('SIC1','company_sic_code1','TRIM(company_sic_code1)>\'\'');
  mac_field_report('NAICS1','company_naics_code1','TRIM(company_naics_code1)>\'\'');
  //mac_field_report('ADDR','address','TRIM(address)>\'\'');
  // Contacts
  mac_field_report('OWNDID','vanity_owner_did','vanity_owner_did>0');
  mac_field_report('PDID','contact_did','contact_did>0');
  mac_field_report('DID_X','did_x','did_x>0');
  mac_field_report('PNAME','contact_name','TRIM(contact_name)>\'\'');
  mac_field_report('PSSN','contact_ssn','TRIM(contact_ssn)>\'\'');
  mac_field_report('PEML','contact_email','TRIM(contact_email)>\'\'');
  mac_field_report('PEMLDOM','contact_email_domain','TRIM(contact_email_domain)>\'\'');
  mac_field_report('PPHN','contact_phone','TRIM(contact_phone)>\'\'');
//*/

  // Try to auto-init using field_config
  //mac_field_report(field_config[1].abbr, field_config[1].fields, field_config[1].filter);
  //#EXPAND('mac_field_report('+field_config[1].abbr+', '+field_config[1].fields+', '+field_config[1].filter+');');
  //#EXPAND('mac_field_report(\''+field_config[1].abbr+'\', \''+field_config[1].fields+'\', \''+field_config[1].filter+'\');');
  /*
  mac_field_init(abbr_init, fields_init, filter_init) := MACRO
    mac_field_report(abbr_init, fields_init, filter_init);
    //mac_field_report('\''+abbr_init+'\'', '\''+fields_init+'\'', '\''+filter_init+'\'');
  ENDMACRO;
  mac_field_init((STRING)field_config[1].abbr, (STRING)field_config[1].fields, (STRING)field_config[1].filter);
  //*/
 
 
  // ---------------------------------------------------------------------
  // Field Reports
  // ---------------------------------------------------------------------
  EXPORT all_field_reports        := ORDERED(
    IF(field_config(abbr='ENT_A')  [1].val_rpt>0, ent_a_report_all);
    IF(field_config(abbr='ENT_H')  [1].val_rpt>0, ent_h_report_all);
    IF(field_config(abbr='ENT_X')  [1].val_rpt>0, ent_x_report_all);
    IF(field_config(abbr='DUNS_A') [1].val_rpt>0, duns_a_report_all);
    IF(field_config(abbr='DUNS_H') [1].val_rpt>0, duns_h_report_all);
    IF(field_config(abbr='DUNS')   [1].val_rpt>0, duns_report_all);
    //IF(field_config(abbr='DUNS_X') [1].val_rpt>0, duns_x_report_all);
    IF(field_config(abbr='DCORP_A')[1].val_rpt>0, dcorp_a_report_all);
    IF(field_config(abbr='DCORP_H')[1].val_rpt>0, dcorp_h_report_all);
    IF(field_config(abbr='FCORP')  [1].val_rpt>0, fcorp_report_all);
    IF(field_config(abbr='UCORP')  [1].val_rpt>0, ucorp_report_all);
    IF(field_config(abbr='CORP_X') [1].val_rpt>0, corp_x_report_all);
    IF(field_config(abbr='FEIN')   [1].val_rpt>0, fein_report_all);
    IF(field_config(abbr='FEIN_X') [1].val_rpt>0, fein_x_report_all);
    IF(field_config(abbr='EBR')    [1].val_rpt>0, ebr_report_all);
    IF(field_config(abbr='SRCVL')  [1].val_rpt>0, srcvl_report_all);
    IF(field_config(abbr='SRCRID') [1].val_rpt>0, srcrid_report_all); // srcrid_report_header; srcrid_report_values; srcrid_report_1_val_m_id; // We know 1 ID can have multiple source recs, which have the most?
    IF(field_config(abbr='SELE')   [1].val_rpt>0, sele_report_all);
    IF(field_config(abbr='BDID')   [1].val_rpt>0, bdid_report_all);
    //IF(field_config(abbr='CNAME')  [1].val_rpt>0, cname_report_all);
    IF(field_config(abbr='CNAMEF') [1].val_rpt>0, cnamef_report_all);
    IF(field_config(abbr='LNAME')  [1].val_rpt>0, lname_report_all);
    IF(field_config(abbr='DNAME')  [1].val_rpt>0, dname_report_all);
    IF(field_config(abbr='ADDRPSZ')[1].val_rpt>0, addrpsz_report_all);
    IF(field_config(abbr='ADDRVSZ')[1].val_rpt>0, addrvsz_report_all);
    IF(field_config(abbr='ADDRST') [1].val_rpt>0, addrst_report_all);
    IF(field_config(abbr='ADDRST2')[1].val_rpt>0, addrst2_report_all);
    IF(field_config(abbr='CPHN')   [1].val_rpt>0, cphn_report_all);
    IF(field_config(abbr='PHN_X')  [1].val_rpt>0, phn_x_report_all);
    IF(field_config(abbr='URL')    [1].val_rpt>0, url_report_all);
    IF(field_config(abbr='URL_X')  [1].val_rpt>0, url_x_report_all);
    IF(field_config(abbr='TICKER') [1].val_rpt>0, ticker_report_all);
    IF(field_config(abbr='TICKEX') [1].val_rpt>0, tickex_report_all);
    IF(field_config(abbr='CNUM')   [1].val_rpt>0, cnum_report_all);
    IF(field_config(abbr='CSTORE') [1].val_rpt>0, cstore_report_all);
    IF(field_config(abbr='CHARTER')[1].val_rpt>0, charter_report_all);
    IF(field_config(abbr='SIC1')   [1].val_rpt>0, sic1_report_all);
    IF(field_config(abbr='NAICS1') [1].val_rpt>0, naics1_report_all);
    //IF(field_config(abbr='ADDR')   [1].val_rpt>0, addr_report_all);
    IF(field_config(abbr='OWNDID') [1].val_rpt>0, owndid_report_all);
    IF(field_config(abbr='PDID')   [1].val_rpt>0, pdid_report_all);
    IF(field_config(abbr='DID_X')  [1].val_rpt>0, did_x_report_all);
    IF(field_config(abbr='PNAME')  [1].val_rpt>0, pname_report_all);
    IF(field_config(abbr='PSSN')   [1].val_rpt>0, pssn_report_all);
    IF(field_config(abbr='PEML')   [1].val_rpt>0, peml_report_all);
    IF(field_config(abbr='PEMLDOM')[1].val_rpt>0, pemldom_report_all);
    IF(field_config(abbr='PPHN')   [1].val_rpt>0, pphn_report_all);
  );
 
 
  // ---------------------------------------------------------------------
  // Field Viz Layouts
  // ---------------------------------------------------------------------
/*
  EXPORT all_field_viz_layouts    := ''
    + IF(field_config(abbr='ENT_A')  [1].val_rpt>0, ent_a_viz_layout, '')
    + IF(field_config(abbr='ENT_H')  [1].val_rpt>0, ent_h_viz_layout, '')
    + IF(field_config(abbr='ENT_X')  [1].val_rpt>0, ent_x_viz_layout, '')
    + IF(field_config(abbr='DUNS_A') [1].val_rpt>0, duns_a_viz_layout, '')
    + IF(field_config(abbr='DUNS_H') [1].val_rpt>0, duns_h_viz_layout, '')
    + IF(field_config(abbr='DUNS')   [1].val_rpt>0, duns_viz_layout, '')
    //+ IF(field_config(abbr='DUNS_X') [1].val_rpt>0, duns_x_viz_layout, '')
    + IF(field_config(abbr='DCORP_A')[1].val_rpt>0, dcorp_a_viz_layout, '')
    + IF(field_config(abbr='DCORP_H')[1].val_rpt>0, dcorp_h_viz_layout, '')
    + IF(field_config(abbr='FCORP')  [1].val_rpt>0, fcorp_viz_layout, '')
    + IF(field_config(abbr='UCORP')  [1].val_rpt>0, ucorp_viz_layout, '')
    + IF(field_config(abbr='CORP_X') [1].val_rpt>0, corp_x_viz_layout, '')
    + IF(field_config(abbr='FEIN')   [1].val_rpt>0, fein_viz_layout, '')
    + IF(field_config(abbr='FEIN_X') [1].val_rpt>0, fein_x_viz_layout, '')
    + IF(field_config(abbr='EBR')    [1].val_rpt>0, ebr_viz_layout, '')
    + IF(field_config(abbr='SRCVL')  [1].val_rpt>0, srcvl_viz_layout, '')
    + IF(field_config(abbr='SRCRID') [1].val_rpt>0, srcrid_viz_layout, '') // srcrid_stats_header srcrid_stats_values srcrid_stats_1_val_m_id // We know 1 ID can have multiple source recs, which have the most?
    + IF(field_config(abbr='SELE')   [1].val_rpt>0, sele_viz_layout, '')
    + IF(field_config(abbr='BDID')   [1].val_rpt>0, bdid_viz_layout, '')
    //+ IF(field_config(abbr='CNAME')  [1].val_rpt>0, cname_viz_layout, '')
    + IF(field_config(abbr='CNAMEF') [1].val_rpt>0, cnamef_viz_layout, '')
    + IF(field_config(abbr='LNAME')  [1].val_rpt>0, lname_viz_layout, '')
    + IF(field_config(abbr='DNAME')  [1].val_rpt>0, dname_viz_layout, '')
    + IF(field_config(abbr='ADDRPSZ')[1].val_rpt>0, addrpsz_viz_layout, '')
    + IF(field_config(abbr='ADDRVSZ')[1].val_rpt>0, addrvsz_viz_layout, '')
    + IF(field_config(abbr='ADDRST') [1].val_rpt>0, addrst_viz_layout, '')
    + IF(field_config(abbr='ADDRST2')[1].val_rpt>0, addrst2_viz_layout, '')
    + IF(field_config(abbr='CPHN')   [1].val_rpt>0, cphn_viz_layout, '')
    + IF(field_config(abbr='PHN_X')  [1].val_rpt>0, phn_x_viz_layout, '')
    + IF(field_config(abbr='URL')    [1].val_rpt>0, url_viz_layout, '')
    + IF(field_config(abbr='URL_X')  [1].val_rpt>0, url_x_viz_layout, '')
    + IF(field_config(abbr='TICKER') [1].val_rpt>0, ticker_viz_layout, '')
    + IF(field_config(abbr='TICKEX') [1].val_rpt>0, tickex_viz_layout, '')
    + IF(field_config(abbr='CNUM')   [1].val_rpt>0, cnum_viz_layout, '')
    + IF(field_config(abbr='CSTORE') [1].val_rpt>0, cstore_viz_layout, '')
    + IF(field_config(abbr='CHARTER')[1].val_rpt>0, charter_viz_layout, '')
    + IF(field_config(abbr='SIC1')   [1].val_rpt>0, sic1_viz_layout, '')
    + IF(field_config(abbr='NAICS1') [1].val_rpt>0, naics1_viz_layout, '')
    //+ IF(field_config(abbr='ADDR')   [1].val_rpt>0, addr_viz_layout, '')
    + IF(field_config(abbr='OWNDID') [1].val_rpt>0, owndid_viz_layout, '')
    + IF(field_config(abbr='PDID')   [1].val_rpt>0, pdid_viz_layout, '')
    + IF(field_config(abbr='DID_X')  [1].val_rpt>0, did_x_viz_layout, '')
    + IF(field_config(abbr='PNAME')  [1].val_rpt>0, pname_viz_layout, '')
    + IF(field_config(abbr='PSSN')   [1].val_rpt>0, pssn_viz_layout, '')
    + IF(field_config(abbr='PEML')   [1].val_rpt>0, peml_viz_layout, '')
    + IF(field_config(abbr='PEMLDOM')[1].val_rpt>0, pemldom_viz_layout, '')
    + IF(field_config(abbr='PPHN')   [1].val_rpt>0, pphn_viz_layout, '')
  ;
//*/

  // ---------------------------------------------------------------------
  // Field Stats
  // ---------------------------------------------------------------------
  EXPORT all_field_stats          := DATASET([],stats_file_lo)
    + IF(field_config(abbr='ENT_A')  [1].val_rpt>0, ent_a_stats_all)
    + IF(field_config(abbr='ENT_H')  [1].val_rpt>0, ent_h_stats_all)
    + IF(field_config(abbr='ENT_X')  [1].val_rpt>0, ent_x_stats_all)
    + IF(field_config(abbr='DUNS_A') [1].val_rpt>0, duns_a_stats_all)
    + IF(field_config(abbr='DUNS_H') [1].val_rpt>0, duns_h_stats_all)
    + IF(field_config(abbr='DUNS')   [1].val_rpt>0, duns_stats_all)
    //+ IF(field_config(abbr='DUNS_X') [1].val_rpt>0, duns_x_stats_all)
    + IF(field_config(abbr='DCORP_A')[1].val_rpt>0, dcorp_a_stats_all)
    + IF(field_config(abbr='DCORP_H')[1].val_rpt>0, dcorp_h_stats_all)
    + IF(field_config(abbr='FCORP')  [1].val_rpt>0, fcorp_stats_all)
    + IF(field_config(abbr='UCORP')  [1].val_rpt>0, ucorp_stats_all)
    + IF(field_config(abbr='CORP_X') [1].val_rpt>0, corp_x_stats_all)
    + IF(field_config(abbr='FEIN')   [1].val_rpt>0, fein_stats_all)
    + IF(field_config(abbr='FEIN_X') [1].val_rpt>0, fein_x_stats_all)
    + IF(field_config(abbr='EBR')    [1].val_rpt>0, ebr_stats_all)
    + IF(field_config(abbr='SRCVL')  [1].val_rpt>0, srcvl_stats_all)
    + IF(field_config(abbr='SRCRID') [1].val_rpt>0, srcrid_stats_all) // srcrid_stats_header srcrid_stats_values srcrid_stats_1_val_m_id // We know 1 ID can have multiple source recs, which have the most?
    + IF(field_config(abbr='SELE')   [1].val_rpt>0, sele_stats_all)
    + IF(field_config(abbr='BDID')   [1].val_rpt>0, bdid_stats_all)
    //+ IF(field_config(abbr='CNAME')  [1].val_rpt>0, cname_stats_all)
    + IF(field_config(abbr='CNAMEF') [1].val_rpt>0, cnamef_stats_all)
    + IF(field_config(abbr='LNAME')  [1].val_rpt>0, lname_stats_all)
    + IF(field_config(abbr='DNAME')  [1].val_rpt>0, dname_stats_all)
    + IF(field_config(abbr='ADDRPSZ')[1].val_rpt>0, addrpsz_stats_all)
    + IF(field_config(abbr='ADDRVSZ')[1].val_rpt>0, addrvsz_stats_all)
    + IF(field_config(abbr='ADDRST') [1].val_rpt>0, addrst_stats_all)
    + IF(field_config(abbr='ADDRST2')[1].val_rpt>0, addrst2_stats_all)
    + IF(field_config(abbr='CPHN')   [1].val_rpt>0, cphn_stats_all)
    + IF(field_config(abbr='PHN_X')  [1].val_rpt>0, phn_x_stats_all)
    + IF(field_config(abbr='URL')    [1].val_rpt>0, url_stats_all)
    + IF(field_config(abbr='URL_X')  [1].val_rpt>0, url_x_stats_all)
    + IF(field_config(abbr='TICKER') [1].val_rpt>0, ticker_stats_all)
    + IF(field_config(abbr='TICKEX') [1].val_rpt>0, tickex_stats_all)
    + IF(field_config(abbr='CNUM')   [1].val_rpt>0, cnum_stats_all)
    + IF(field_config(abbr='CSTORE') [1].val_rpt>0, cstore_stats_all)
    + IF(field_config(abbr='CHARTER')[1].val_rpt>0, charter_stats_all)
    + IF(field_config(abbr='SIC1')   [1].val_rpt>0, sic1_stats_all)
    + IF(field_config(abbr='NAICS1') [1].val_rpt>0, naics1_stats_all)
    //+ IF(field_config(abbr='ADDR')   [1].val_rpt>0, addr_stats_all)
    + IF(field_config(abbr='OWNDID') [1].val_rpt>0, owndid_stats_all)
    + IF(field_config(abbr='PDID')   [1].val_rpt>0, pdid_stats_all)
    + IF(field_config(abbr='DID_X')  [1].val_rpt>0, did_x_stats_all)
    + IF(field_config(abbr='PNAME')  [1].val_rpt>0, pname_stats_all)
    + IF(field_config(abbr='PSSN')   [1].val_rpt>0, pssn_stats_all)
    + IF(field_config(abbr='PEML')   [1].val_rpt>0, peml_stats_all)
    + IF(field_config(abbr='PEMLDOM')[1].val_rpt>0, pemldom_stats_all)
    + IF(field_config(abbr='PPHN')   [1].val_rpt>0, pphn_stats_all)
  ;
 
 
  // ---------------------------------------------------------------------
  // Possible Overlinks
  // ---------------------------------------------------------------------
 
  //EXPORT ol_risk_config - Now part of field_config
  //  OL fields: ol_max, ol_min, ol_th, ol_scale (REAL)
 
 
  // ---------------------------------------------------------------------
  // Possible Underlinks
  // ---------------------------------------------------------------------
 
  //EXPORT ul_risk_config - Now part of field_config
  //  ul fields: ul_max, ul_min, ul_th, ul_scale (REAL)
 
    // Filter norm join to decrease false positives, hopefully without being overly restrictive
    // V_City better-populated... how often one without the other?
  EXPORT ul_filter_str            := // City Requirement
                                       //'(LEFT.p_city=\'\' OR RIGHT.v_city=\'\' OR LEFT.v_city=RIGHT.v_city OR LEFT.p_city=RIGHT.p_city OR LEFT.v_city=RIGHT.p_city OR LEFT.p_city=RIGHT.v_city)' +
                                       //'(LEFT.v_city=RIGHT.v_city OR LEFT.p_city=RIGHT.p_city OR LEFT.v_city=RIGHT.p_city OR LEFT.p_city=RIGHT.v_city)' +
                                     '   (((TRIM(LEFT.a_z)   >\'\' AND  LEFT.a_z   =RIGHT.a_z)' +                                  // ZIP
                                     '  OR (TRIM(LEFT.v_city)>\'\' AND (LEFT.v_city=RIGHT.v_city OR LEFT.v_city=RIGHT.p_city))'  + // V_City
                                     '  OR (TRIM(LEFT.p_city)>\'\' AND (LEFT.p_city=RIGHT.p_city OR LEFT.p_city=RIGHT.v_city)))' + // P_City
                                     ' AND ' +
                                     // Street Requirement
                                     '    ((TRIM(LEFT.p_rng)  >\'\' AND LEFT.p_rng =RIGHT.p_rng)' +                                // Street #
                                       //'  OR (TRIM(LEFT.p_name) >\'\' AND LEFT.p_name[..3]=RIGHT.p_name[..3]))' +
                                     //'  OR((TRIM(LEFT.p_name) >\'\' AND STD.Str.Find(RIGHT.p_name,LEFT.p_name[..3])>0) ' +         // Street Name
                                     //'  OR (TRIM(RIGHT.p_name)>\'\' AND STD.Str.Find(LEFT.p_name,RIGHT.p_name[..3])>0))' +
                                     //'  OR(                             STD.Str.Find(LEFT.p_name, \'PO BOX\')      >0  ' +         // PO Box
                                     //'  OR                              STD.Str.Find(RIGHT.p_name,\'PO BOX\')      >0)))'+
                                     '  OR((TRIM(LEFT.p_name) >\'\' AND ~REGEXFIND(\'PO BOX\',LEFT.p_name)  AND STD.Str.Find(RIGHT.p_name,LEFT.p_name [..3])  >0) ' +                                      // Street Name
                                     '  OR (TRIM(RIGHT.p_name)>\'\' AND ~REGEXFIND(\'PO BOX\',RIGHT.p_name) AND STD.Str.Find(LEFT.p_name, RIGHT.p_name[..3])  >0))' +
                                     //'  OR((TRIM(LEFT.p_name) >\'\' AND  REGEXFIND(\'PO BOX\',LEFT.p_name)  AND STD.Str.Find(RIGHT.p_name,LEFT.p_name [6..8]) >0) ' +                                      // PO Box
                                     //'  OR (TRIM(RIGHT.p_name)>\'\' AND  REGEXFIND(\'PO BOX\',RIGHT.p_name) AND STD.Str.Find(LEFT.p_name, RIGHT.p_name[6..8]))>0)))'+
                                     '  OR((TRIM(LEFT.p_name) >\'\' AND  REGEXFIND(\'PO BOX\',LEFT.p_name)  AND STD.Str.Find(RIGHT.p_name,REGEXREPLACE(\'PO BOX ([^ ]+).*\',LEFT.p_name, \'$1\'))>0) '  +  // PO Box
                                     '  OR (TRIM(RIGHT.p_name)>\'\' AND  REGEXFIND(\'PO BOX\',RIGHT.p_name) AND STD.Str.Find(LEFT.p_name, REGEXREPLACE(\'PO BOX ([^ ]+).*\',RIGHT.p_name,\'$1\'))>0))))'+
                                     '';
  //EXPORT ul_name_check_str        := 'AND (LEFT.prim_name=RIGHT.prim_name OR LEFT.v_city_name=RIGHT.v_city_name OR LEFT.p_city_name=RIGHT.p_city_name)'; // For Joins to avoid false positives
  //EXPORT ul_name_filter_str       := '         (prim_name=  alt_prim_name OR      v_city_name=  alt_v_city_name OR      p_city_name=  alt_p_city_name)'; // For Tables
 
  // Calculate/Recalculate some risk factors with more refined criteria

    // Source Name & Source RID - Template for manual/non-macro tweaks
  EXPORT SRCRID_ul_r1             := PROJECT(SRCRID_tb_val_mult_id, TRANSFORM(ul_norm_lo,
                                       SELF.ul_issue:='SRCRID', SELF.ul_value:=TRIM(LEFT.source)+'_'+LEFT.source_record_id, SELF.ul_val_cnt:=LEFT.id_cnt-1, SELF:=LEFT, SELF:=[]), LOCAL);
  EXPORT SRCRID_ul_r2             := JOIN(SRCRID_ul_r1, SRCRID_tb_val_mult_id, LEFT.ul_value=TRIM(RIGHT.source)+'_'+RIGHT.source_record_id AND LEFT.proxid<>RIGHT.proxid, TRANSFORM(ul_norm_lo,
                                       SELF.alt_proxid:=RIGHT.proxid, SELF.alt_rcid:=RIGHT.rcid, SELF.alt_src:=RIGHT.src, SELF.alt_cname:=RIGHT.cname,
                                       //SELF.alt_v_city:=RIGHT.v_city, SELF.alt_p_city:=RIGHT.p_city, SELF.alt_a_st:=RIGHT.a_st, SELF:=LEFT), LOCAL);
                                       SELF.alt_p_rng:=RIGHT.p_rng, SELF.alt_p_name:=RIGHT.p_name, SELF.alt_v_city:=RIGHT.v_city, SELF.alt_a_st:=RIGHT.a_st, SELF.alt_a_z:=RIGHT.a_z, SELF:=LEFT), LOCAL);
  EXPORT SRCRID_ul                := ROLLUP(GROUP(SORT(DISTRIBUTE(SRCRID_ul_r2,HASH32(proxid)),proxid,LOCAL),proxid,LOCAL), GROUP, TRANSFORM(ul_lo, SELF.factors:=':'+LEFT.ul_issue,
                                       SELF.score:=SUM(DEDUP(SORT(ROWS(LEFT),ul_value,FEW),ul_value),ul_val_cnt), SELF.ul_dtls:=PROJECT(ROWS(LEFT),ul_dtl_lo), SELF:=LEFT));
 
  SHARED empty_ul_norm            := DATASET([],ul_norm_lo);
 
  // Prepare risk factor information
  EXPORT mac_ul_scores(abbr_in, filter_ds)            := MACRO // Note: Not an active factor if max score is 0
    // Just table info in ul risk format
    EXPORT #EXPAND(abbr_in+'_ul_raw')                 := IF(field_config(abbr=abbr_in)[1].ul_max>0,
                                                           PROJECT(#EXPAND(abbr_in+'_tb_val_mult_id'), TRANSFORM(ul_risk_lo, cfg:=field_config(abbr=abbr_in)[1];
                                                             // If count >= risk threshold, score at least the min, but no more than the max, after adjusting count by scale
                                                             SELF.score  :=IF(LEFT.id_cnt>=cfg.ul_th, MAX(cfg.ul_min, MIN(LEFT.id_cnt*cfg.ul_scale, cfg.ul_max)), SKIP),
                                                             SELF.factors:=abbr_in+' '+(STRING)SELF.score+':', SELF:=LEFT)),
                                                           DATASET([],ul_risk_lo));
    // Populate Issue and primary ID info
    EXPORT #EXPAND(abbr_in+'_ul_proj')                := IF(field_config(abbr=abbr_in)[1].ul_max>0,
                                                           DISTRIBUTE(PROJECT(#EXPAND(abbr_in+'_tb_val_mult_id_ex')(id_cnt<=max_xjoin_in_cnt), // Remove high skew/cross-join vals - Can do separately across nodes if needed
                                                             TRANSFORM(ul_norm_lo, cfg:=field_config(abbr=abbr_in)[1];
                                                               SELF.ul_issue:=abbr_in, SELF.ul_val_cnt:=LEFT.id_cnt-1,
                                                               SELF.ul_value:=#EXPAND('TRIM((STRING)LEFT.'+REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),')+\'|\'+TRIM((STRING)LEFT.')+')'),
                                                               SELF:=LEFT, SELF:=[]), LOCAL),HASH32(ul_value)), // Local should be the default, just being extra careful with the distros
                                                           empty_ul_norm);
    // Populate initial Score and Alt ID info
    EXPORT #EXPAND(abbr_in+'_ul_norm_raw')            := IF(COUNT(#EXPAND(abbr_in+'_ul_proj'))>0,
                                                           //JOIN(#EXPAND(abbr_in+'_ul_proj'), #EXPAND(abbr_in+'_tb_val_mult_id_ex'),
                                                             //LEFT.ul_value=#EXPAND('TRIM((STRING)RIGHT.'+REGEXREPLACE(',',#EXPAND(abbr_in+'_fields'),')+\'|\'+TRIM((STRING)RIGHT.')+')')
                                                           JOIN(#EXPAND(abbr_in+'_ul_proj'), #EXPAND(abbr_in+'_ul_proj'),
                                                             LEFT.ul_value=RIGHT.ul_value AND LEFT.proxid<>RIGHT.proxid AND #EXPAND(ul_filter_str),
                                                             TRANSFORM(ul_norm_lo, cfg:=field_config(abbr=abbr_in)[1];
                                                               // If count >= risk threshold, score at least the min, but no more than the max, after adjusting count by scale
                                                               SELF.score  :=IF(LEFT.ul_val_cnt>=cfg.ul_th, MAX(cfg.ul_min, MIN(LEFT.ul_val_cnt*cfg.ul_scale, cfg.ul_max)), SKIP),
                                                               SELF.factors:=TRIM(cfg.abbr)+' '+(STRING)SELF.score+':',
                                                               //PML To Do: Replace with Regex using alt_info_fields to fields without 'alt_'
                                                               SELF.alt_proxid:=RIGHT.proxid, SELF.alt_rcid:=RIGHT.rcid, SELF.alt_src:=RIGHT.src, SELF.alt_cname:=RIGHT.cname,
                                                               //SELF.alt_v_city:=RIGHT.v_city, SELF.alt_p_city:=RIGHT.p_city, SELF.alt_a_st:=RIGHT.a_st, SELF:=LEFT), LOCAL),
                                                               SELF.alt_p_rng:=RIGHT.p_rng, SELF.alt_p_name:=RIGHT.p_name, SELF.alt_v_city:=RIGHT.v_city, SELF.alt_a_st:=RIGHT.a_st, SELF.alt_a_z:=RIGHT.a_z,
                                                               SELF:=LEFT), LOCAL),
                                                           empty_ul_norm);

    // Adjust overlapping cross-field (*_X) factors so they aren't double-counted (only keep cross-field as a factor when in-field itself doesn't match)
    EXPORT #EXPAND(abbr_in+'_ul_norm')                := IF(~REGEXFIND('_X',abbr_in) OR COUNT(filter_ds)=0, #EXPAND(abbr_in+'_ul_norm_raw'), // Only redist & filter when needed
                                                           DISTRIBUTE(JOIN(DISTRIBUTE(#EXPAND(abbr_in+'_ul_norm_raw'),HASH32(proxid)), DISTRIBUTE(filter_ds,HASH32(proxid)),
                                                             LEFT.proxid=RIGHT.proxid AND LEFT.alt_proxid=RIGHT.alt_proxid, TRANSFORM(LEFT), LEFT ONLY, LOCAL),HASH32(ul_value)));
                                                           
    // ID-unique issues / risk factors
    EXPORT #EXPAND(abbr_in+'_ul_tb_issues')           := IF(COUNT(#EXPAND(abbr_in+'_ul_norm'))>0,
                                                           TABLE(#EXPAND(abbr_in+'_ul_norm'), { proxid, ul_issue,   UNSIGNED id_cnt   :=COUNT(GROUP) }, proxid, ul_issue,   LOCAL),
                                                           DATASET([],{ul_norm_lo.proxid, ul_norm_lo.ul_issue,   UNSIGNED id_cnt}));

    // Used to filter further work to top 10 UL candidates / alt_proxids
    EXPORT #EXPAND(abbr_in+'_ul_top_alt_ids')         := IF(COUNT(#EXPAND(abbr_in+'_ul_norm'))>0, DEDUP(SORT(
                                                           TABLE(#EXPAND(abbr_in+'_ul_norm'), { proxid, alt_proxid, UNSIGNED issue_cnt:=COUNT(GROUP) }, proxid, alt_proxid, LOCAL),
                                                             proxid,-issue_cnt,alt_proxid,LOCAL),proxid,KEEP(keep_count),LOCAL),
                                                           DATASET([],{ul_norm_lo.proxid, ul_norm_lo.alt_proxid, UNSIGNED issue_cnt}));

    // Norm recs for top 10 UL candidates / alt_proxids
    EXPORT #EXPAND(abbr_in+'_ul_norm_top_alt_ids')    := IF(COUNT(#EXPAND(abbr_in+'_ul_norm'))>0,
                                                           JOIN(#EXPAND(abbr_in+'_ul_norm'), #EXPAND(abbr_in+'_ul_top_alt_ids'),
                                                             LEFT.proxid=RIGHT.proxid AND LEFT.alt_proxid=RIGHT.alt_proxid, TRANSFORM(LEFT), LOCAL),
                                                           empty_ul_norm);

    // Alt-ID-unique issues / risk factors
    EXPORT #EXPAND(abbr_in+'_ul_tb_top_alt_id_issues'):= IF(COUNT(#EXPAND(abbr_in+'_ul_norm'))>0,
                                                           TABLE(#EXPAND(abbr_in+'_ul_norm_top_alt_ids'), { proxid, alt_proxid, ul_issue, UNSIGNED val_cnt:=COUNT(GROUP) }, proxid, alt_proxid, ul_issue, LOCAL),
                                                           DATASET([],{ul_norm_lo.proxid, ul_norm_lo.alt_proxid, ul_norm_lo.ul_issue, UNSIGNED val_cnt}));

    // Roll up Total Score and create child DS
    EXPORT #EXPAND(abbr_in+'_ul_roll')                := IF(COUNT(#EXPAND(abbr_in+'_ul_norm'))>0,
                                                           ROLLUP(GROUP(SORT(DISTRIBUTE(#EXPAND(abbr_in+'_ul_norm_top_alt_ids'),HASH32(proxid)),proxid,LOCAL),proxid,LOCAL), GROUP,
                                                             TRANSFORM(ul_lo, cfg:=field_config(abbr=abbr_in)[1];
                                                               SELF.factors:=':'+LEFT.ul_issue,
                                                               //SELF.score  :=SUM(DEDUP(SORT(ROWS(LEFT),ul_value,FEW),ul_value),ul_val_cnt), // Retain for research reasons
                                                               SELF.score  :=MAX(cfg.ul_min, MIN(SUM(DEDUP(SORT(ROWS(LEFT),ul_value,FEW),ul_value),ul_val_cnt), cfg.ul_max)),
                                                               SELF.ul_dtls:=PROJECT(ROWS(LEFT), TRANSFORM(ul_dtl_lo,
                                                                 SELF.il_svc__html:=mac_link(il_svc_url+'proxidone='+LEFT.proxid+'&proxidtwo='+LEFT.alt_proxid,'il_svc'),
                                                                 SELF:=LEFT)),
                                                               SELF:=LEFT)),
                                                           DATASET([],ul_lo));
  ENDMACRO;
 
  // Initialize UL Scoring Exports
  mac_ul_scores('ENT_A'  , empty_ul_norm);
  mac_ul_scores('ENT_H'  , empty_ul_norm);
  mac_ul_scores('ENT_X'  , ENT_A_ul_norm   + ENT_H_ul_norm); // Filter using *_ul_norm_top_alt_ids instead of *_ul_norm?  Will double-count some again but not for the top pairs
  mac_ul_scores('DUNS_A' , empty_ul_norm);
  mac_ul_scores('DUNS_H' , empty_ul_norm);
  mac_ul_scores('DUNS'   , empty_ul_norm);
  //mac_ul_scores('DUNS_X' , DUNS_A_ul_norm  + DUNS_H_ul_norm  + DUNS_ul_norm);
  mac_ul_scores('DCORP_A', empty_ul_norm);
  mac_ul_scores('DCORP_H', empty_ul_norm);
  mac_ul_scores('FCORP'  , empty_ul_norm);
  mac_ul_scores('UCORP'  , empty_ul_norm);
  mac_ul_scores('CORP_X' , DCORP_A_ul_norm + DCORP_H_ul_norm + FCORP_ul_norm + UCORP_ul_norm);
  mac_ul_scores('FEIN'   , empty_ul_norm);
  mac_ul_scores('PSSN'   , empty_ul_norm);
  mac_ul_scores('FEIN_X' , FEIN_ul_norm    + PSSN_ul_norm);
  mac_ul_scores('EBR'    , empty_ul_norm);
  mac_ul_scores('SRCVL'  , empty_ul_norm);
  mac_ul_scores('SRCRID' , empty_ul_norm);
  mac_ul_scores('SELE'   , empty_ul_norm);
  mac_ul_scores('BDID'   , empty_ul_norm);
    // CNAME
  mac_ul_scores('CNAMEF' , empty_ul_norm);
  mac_ul_scores('LNAME'  , empty_ul_norm);
  mac_ul_scores('DNAME'  , empty_ul_norm);
  mac_ul_scores('ADDRPSZ', empty_ul_norm);
  mac_ul_scores('ADDRVSZ', empty_ul_norm);
  mac_ul_scores('ADDRST' , empty_ul_norm);
  mac_ul_scores('ADDRST2', empty_ul_norm);
  mac_ul_scores('CPHN'   , empty_ul_norm);
  mac_ul_scores('PPHN'   , empty_ul_norm);
  mac_ul_scores('PHN_X'  , CPHN_ul_norm    + PPHN_ul_norm);
  mac_ul_scores('URL'    , empty_ul_norm);
  mac_ul_scores('PEMLDOM', empty_ul_norm);
  mac_ul_scores('URL_X'  , URL_ul_norm     + PEMLDOM_ul_norm);
  mac_ul_scores('TICKER' , empty_ul_norm);
  mac_ul_scores('TICKEX' , empty_ul_norm);
  mac_ul_scores('CNUM'   , empty_ul_norm);
  mac_ul_scores('CSTORE' , empty_ul_norm);
  mac_ul_scores('CHARTER', empty_ul_norm);
  mac_ul_scores('SIC1'   , empty_ul_norm);
  mac_ul_scores('NAICS1' , empty_ul_norm);
    // ADDR
  mac_ul_scores('OWNDID' , empty_ul_norm);
  mac_ul_scores('PDID'   , empty_ul_norm);
  mac_ul_scores('DID_X'  , OWNDID_ul_norm  + PDID_ul_norm);
  mac_ul_scores('PNAME'  , empty_ul_norm);
  //mac_ul_scores('PSSN'   , empty_ul_norm); // Moved for FEIN_X filtering
  mac_ul_scores('PEML'   , empty_ul_norm);
  //mac_ul_scores('PEMLDOM', empty_ul_norm); // Moved for URL_X  filtering
  //mac_ul_scores('PPHN'   , empty_ul_norm); // Moved for PHN_X  filtering
 
  // Aggregate risk factor information
  //EXPORT uls_raw                  := ENT_A_ul_raw + ENT_H_ul_raw + DUNS_A_ul_raw + DUNS_H_ul_raw + DUNS_ul_raw + DCORP_A_ul_raw + DCORP_H_ul_raw + FCORP_ul_raw + UCORP_ul_raw +
                                     //FEIN_ul_raw + EBR_ul_raw + SRCVL_ul_raw + SRCRID_ul_raw + SELE_ul_raw + CNAMEF_ul_raw + LNAME_ul_raw + DNAME_ul_raw +
                                     //ADDRPSZ_ul_raw + ADDRVSZ_ul_raw + ADDRST_ul_raw + ADDRST2_ul_raw +
                                     //CPHN_ul_raw + URL_ul_raw + TICKER_ul_raw + TICKEX_ul_raw + CNUM_ul_raw + CSTORE_ul_raw + CHARTER_ul_raw + SIC1_ul_raw + NAICS1_ul_raw +
                                     //OWNDID_ul_raw + PDID_ul_raw + PNAME_ul_raw + PSSN_ul_raw + PEML_ul_raw + PEMLDOM_ul_raw + PPHN_ul_raw;
 
  //EXPORT uls_raw_roll             := ROLLUP(SORT(DISTRIBUTE(uls_raw,HASH32(proxid)),proxid,factors,LOCAL), LEFT.proxid=RIGHT.proxid, TRANSFORM(ul_risk_lo, SELF.score:=LEFT.score+RIGHT.score, SELF.factors:=LEFT.factors+RIGHT.factors, SELF:=LEFT), LOCAL);
 
  //EXPORT uls_norm                 := ENT_A_ul_norm + ENT_H_ul_norm + DUNS_A_ul_norm + DUNS_H_ul_norm + DUNS_ul_norm + DCORP_A_ul_norm + DCORP_H_ul_norm + FCORP_ul_norm + UCORP_ul_norm +
                                     //FEIN_ul_norm + EBR_ul_norm + SRCVL_ul_norm + SRCRID_ul_norm + SELE_ul_norm + CNAMEF_ul_norm + LNAME_ul_norm + DNAME_ul_norm +
                                     //ADDRPSZ_ul_norm + ADDRVSZ_ul_norm + ADDRST_ul_norm + ADDRST2_ul_norm +
                                     //CPHN_ul_norm + URL_ul_norm + TICKER_ul_norm + TICKEX_ul_norm + CNUM_ul_norm + CSTORE_ul_norm + CHARTER_ul_norm + SIC1_ul_norm + NAICS1_ul_norm +
                                     //OWNDID_ul_norm + PDID_ul_norm + PNAME_ul_norm + PSSN_ul_norm + PEML_ul_norm + PEMLDOM_ul_norm + PPHN_ul_norm;
 
  EXPORT uls_norm                 := ENT_A_ul_norm_top_alt_ids + ENT_H_ul_norm_top_alt_ids + DUNS_A_ul_norm_top_alt_ids + DUNS_H_ul_norm_top_alt_ids + DUNS_ul_norm_top_alt_ids + DCORP_A_ul_norm_top_alt_ids + DCORP_H_ul_norm_top_alt_ids + FCORP_ul_norm_top_alt_ids + UCORP_ul_norm_top_alt_ids +
                                     FEIN_ul_norm_top_alt_ids + EBR_ul_norm_top_alt_ids + SRCVL_ul_norm_top_alt_ids + SRCRID_ul_norm_top_alt_ids + SELE_ul_norm_top_alt_ids + CNAMEF_ul_norm_top_alt_ids + LNAME_ul_norm_top_alt_ids + DNAME_ul_norm_top_alt_ids +
                                     ADDRPSZ_ul_norm_top_alt_ids + ADDRVSZ_ul_norm_top_alt_ids + ADDRST_ul_norm_top_alt_ids + ADDRST2_ul_norm_top_alt_ids +
                                     CPHN_ul_norm_top_alt_ids + URL_ul_norm_top_alt_ids + TICKER_ul_norm_top_alt_ids + TICKEX_ul_norm_top_alt_ids + CNUM_ul_norm_top_alt_ids + CSTORE_ul_norm_top_alt_ids + CHARTER_ul_norm_top_alt_ids + SIC1_ul_norm_top_alt_ids + NAICS1_ul_norm_top_alt_ids +
                                     OWNDID_ul_norm_top_alt_ids + PDID_ul_norm_top_alt_ids + PNAME_ul_norm_top_alt_ids + PSSN_ul_norm_top_alt_ids + PEML_ul_norm_top_alt_ids + PEMLDOM_ul_norm_top_alt_ids + PPHN_ul_norm_top_alt_ids +
                                     ENT_X_ul_norm_top_alt_ids + /*DUNS_X_ul_norm_top_alt_ids +*/ CORP_X_ul_norm_top_alt_ids + BDID_ul_norm_top_alt_ids +
                                     FEIN_X_ul_norm_top_alt_ids + PHN_X_ul_norm_top_alt_ids + URL_X_ul_norm_top_alt_ids + DID_X_ul_norm_top_alt_ids;
 
  EXPORT uls_norm_dd              := TABLE(SORT(DISTRIBUTE(uls_norm,HASH32(proxid)),proxid,alt_proxid,LOCAL),
                                       { proxid, alt_proxid, UNSIGNED issue_cnt:=COUNT(GROUP), ul_issue, ul_value, ul_val_cnt,
                                         #EXPAND(sanity_fields), #EXPAND(REGEXREPLACE('alt_proxid,',alt_info_fields,'')) }
                                       ,proxid,alt_proxid,LOCAL)
                                       : ONWARNING(2168,ignore), PERSIST(persist_prefix+'uls_norm_dd', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;
 
  EXPORT tb_ul_alt_ids            := TABLE(uls_norm_dd, { proxid, UNSIGNED id_cnt:=COUNT(GROUP), UNSIGNED max_issue_cnt:=MAX(GROUP,issue_cnt) }, proxid, LOCAL);
 
  EXPORT uls_roll                 := ENT_A_ul_roll + ENT_H_ul_roll + DUNS_A_ul_roll + DUNS_H_ul_roll + DUNS_ul_roll + DCORP_A_ul_roll + DCORP_H_ul_roll + FCORP_ul_roll + UCORP_ul_roll +
                                     FEIN_ul_roll + EBR_ul_roll + SRCVL_ul_roll + SRCRID_ul_roll + SELE_ul_roll + CNAMEF_ul_roll + LNAME_ul_roll + DNAME_ul_roll +
                                     ADDRPSZ_ul_roll + ADDRVSZ_ul_roll + ADDRST_ul_roll + ADDRST2_ul_roll +
                                     CPHN_ul_roll + URL_ul_roll + TICKER_ul_roll + TICKEX_ul_roll + CNUM_ul_roll + CSTORE_ul_roll + CHARTER_ul_roll + SIC1_ul_roll + NAICS1_ul_roll +
                                     OWNDID_ul_roll + PDID_ul_roll + PNAME_ul_roll + PSSN_ul_roll + PEML_ul_roll + PEMLDOM_ul_roll + PPHN_ul_roll +
                                     ENT_X_ul_roll + /*DUNS_X_ul_roll +*/ CORP_X_ul_roll + BDID_ul_roll + FEIN_X_ul_roll + PHN_X_ul_roll + URL_X_ul_roll + DID_X_ul_roll
                                     : PERSIST(persist_prefix+'uls_roll', EXPIRE(persist_expire), SINGLE);// : INDEPENDENT;
 
  // Basic Output without batch ProxID Compare scoring (which can take a long time if there are lots of UL ProxID pairs to check)
  EXPORT uls_rolled1              := ROLLUP(SORT(DISTRIBUTE(uls_roll,HASH32(proxid)),proxid,factors,LOCAL), LEFT.proxid=RIGHT.proxid, TRANSFORM(ul_lo,
                                       left_cfg       := IF(COUNT(field_config(abbr=LEFT.factors [2..]))>0,field_config(abbr=LEFT.factors [2..])[1],empty_field_config[1]);
                                       right_cfg      := IF(COUNT(field_config(abbr=RIGHT.factors[2..]))>0,field_config(abbr=RIGHT.factors[2..])[1],empty_field_config[1]);
                                       first_fact     := ~REGEXFIND('[0-9]',LEFT.factors);
                                       repeat_fact    := REGEXFIND(RIGHT.factors,LEFT.factors);
                                       // Check if this factor has previously contributed to score and needs to be adjusted
                                       lfact_score    := IF(repeat_fact,
                                                           // Repeat Factor
                                                           IF(REGEXFIND(RIGHT.factors+' [0-9]',LEFT.factors),
                                                             // Has    been scored previously, extract last score contribution
                                                             (UNSIGNED)REGEXREPLACE('.*'+RIGHT.factors+' ([0-9]+).*',LEFT.factors,'$1'),
                                                             // Hasn't been scored previously, set based on config criteria
                                                             IF(TRIM(left_cfg.abbr)>'',
                                                               // Legit single factor, not an aggregate, has a config entry
                                                               IF(LEFT.score>=left_cfg.ul_th,(UNSIGNED)MAX(MIN(LEFT.score*left_cfg.ul_scale,left_cfg.ul_max),left_cfg.ul_min),0),
                                                               // Aggregate already, take the score
                                                               0)),
                                                           // Not a Repeat Factor
                                                           IF(LEFT.score>=left_cfg.ul_th,(UNSIGNED)MAX(MIN(LEFT.score*left_cfg.ul_scale,left_cfg.ul_max),left_cfg.ul_min),0));
                                                         // Get next score for this factor if it meets the threshold, enforce Max and Min
                                       rfact_score    := IF(RIGHT.score>=right_cfg.ul_th,(UNSIGNED)MAX(MIN(RIGHT.score*right_cfg.ul_scale,right_cfg.ul_max),right_cfg.ul_min),0);
                                       // Don't exceed Max even if the factor has been seen multiple times
                                       factor_score   := IF(repeat_fact,MIN(lfact_score+rfact_score,right_cfg.ul_max), rfact_score);
                                       SELF.score     := IF(first_fact,lfact_score + factor_score,LEFT.score - lfact_score + factor_score),
                                       SELF.factors   := IF(repeat_fact,REGEXREPLACE(RIGHT.factors+' [0-9]+',LEFT.factors,RIGHT.factors+' '+factor_score),
                                                           IF(first_fact,LEFT.factors+' '+lfact_score+RIGHT.factors+' '+factor_score,LEFT.factors+RIGHT.factors+' '+factor_score)),
                                       SELF.ul_dtls   := LEFT.ul_dtls+RIGHT.ul_dtls, SELF:=LEFT), LOCAL);
  EXPORT uls_rolled2              := PROJECT(uls_rolled1, TRANSFORM(ul_lo,
                                       single_rec     := ~REGEXFIND('[0-9]',LEFT.factors); // [LENGTH(TRIM(LEFT.factors))]
                                       cfg            := IF(single_rec,field_config(abbr=LEFT.factors[2..])[1],empty_field_config[1]);
                                       raw_score      := IF(single_rec,IF(LEFT.score>=cfg.ul_th,(UNSIGNED)MAX(MIN(LEFT.score*cfg.ul_scale,cfg.ul_max),cfg.ul_min),0),LEFT.score);
                                       adj_score      := IF(LEFT.pct_pop>=fieldpop_avg,raw_score,
                                                           // Scale thin-pop clusters
                                                           raw_score*(1+ABS(baseid_fieldpopsumm(pct_pop=LEFT.pct_pop)[1].zscore)));
                                       SELF.score     := adj_score,
                                       SELF.factors   := IF(single_rec,LEFT.factors+' '+SELF.score,LEFT.factors),
                                       //SELF.ul_dtls   := SORT(LEFT.ul_dtls,alt_proxid,ul_issue,ul_value),
//PML Optional: Rollup distinct alt IDs in child DS, roll their factors, decrease child DS size to enable display against full header results
                                       SELF.ul_dtls   := IF(COUNT(LEFT.ul_dtls)=1,
                                                           PROJECT(LEFT.ul_dtls, TRANSFORM(ul_dtl_lo, SELF.ul_val_cnt:=1, SELF:=LEFT)),
                                                           SORT(ROLLUP(SORT(LEFT.ul_dtls,alt_proxid,ul_issue,LOCAL), LEFT.alt_proxid=RIGHT.alt_proxid, TRANSFORM(ul_dtl_lo,
                                                             SELF.ul_val_cnt:=IF(REGEXFIND(':',LEFT.ul_value), LEFT.ul_val_cnt+1, 2),
                                                             SELF.ul_value  :=IF(REGEXFIND(':',LEFT.ul_value),
                                                               IF(REGEXFIND(TRIM(RIGHT.ul_issue),LEFT.ul_value), LEFT.ul_value, TRIM(LEFT.ul_value)+':'+RIGHT.ul_issue),
                                                               ':'+IF(REGEXFIND(TRIM(RIGHT.ul_issue),LEFT.ul_issue), LEFT.ul_issue, TRIM(LEFT.ul_issue)+':'+RIGHT.ul_issue)),
                                                             // Retain most-restrictive in cases where it's only most-inclusive overlapping with most-restrictive, not "MULTIPLE"
                                                             SELF.ul_issue  :=MAP(SELF.ul_value=':ADDRST:ADDRST2' => ':ADDRST2',
                                                                                  SELF.ul_value=':CORP_X:DCORP_A' => ':DCORP_A',
                                                                                  SELF.ul_value=':CORP_X:DCORP_H' => ':DCORP_H',
                                                                                  SELF.ul_value=':CORP_X:FCORP'   => ':FCORP',
                                                                                  SELF.ul_value=':CORP_X:UCORP'   => ':UCORP',
                                                                                  SELF.ul_value=':FEIN:FEIN_X'    => ':FEIN',
                                                                                  SELF.ul_value=':FEIN_X:PSSN'    => ':PSSN',
                                                                                  SELF.ul_value=':CPHN:PHN_X'     => ':CPHN',
                                                                                  SELF.ul_value=':PHN_X:PPHN'     => ':PPHN',
                                                                                  SELF.ul_value=':URL:URL_X'      => ':URL',
                                                                                  SELF.ul_value=':PEMLDOM:URL_X'  => ':PEMLDOM',
                                                                                  SELF.ul_value=':DID_X:OWNDID'   => ':OWNDID',
                                                                                  SELF.ul_value=':DID_X:PDID'     => ':PDID',
                                                                                                                     'MULTIPLE'),
                                                             //SELF:=LEFT), LOCAL), ul_issue<>'MULTIPLE', -STD.Str.CountWords(ul_value,':'), -ul_val_cnt, alt_proxid, ul_issue, LOCAL)[..10]),
                                                             SELF:=LEFT), LOCAL), ul_issue<>'MULTIPLE', -STD.Str.FindCount (ul_value,':'), -ul_val_cnt, alt_proxid, ul_issue, LOCAL)[..alt_count]),
                                       SELF:=LEFT));
  //EXPORT uls_rolled3              := JOIN(uls_rolled2, baseid_ids,         LEFT.proxid=RIGHT.proxid, TRANSFORM(ul_lo,
                                       //SELF.cnt_recs:=RIGHT.recs, SELF:=LEFT), LEFT OUTER, LOCAL);
  EXPORT uls_rolled3              := JOIN(uls_rolled2, baseid_fieldpoptot, LEFT.proxid=RIGHT.proxid, TRANSFORM(ul_lo,
                                       SELF.cnt_recs:=RIGHT.cnt_recs, SELF.pct_pop:=RIGHT.pct_pop,    SELF:=LEFT), LEFT OUTER, LOCAL);
  EXPORT uls_rolled4              := JOIN(uls_rolled3, tb_ul_alt_ids,      LEFT.proxid=RIGHT.proxid, TRANSFORM(ul_lo,
                                       SELF.alt_proxids:=MAX(RIGHT.id_cnt,1), SELF.max_id_score:=RIGHT.max_issue_cnt,
                                       SELF.avg_score:=rnd2((REAL)LEFT.score/(REAL)SELF.alt_proxids), SELF:=LEFT), LEFT OUTER, LOCAL);
  EXPORT uls_rolled               := uls_rolled4;

  //EXPORT final_uls                := uls_raw_roll;
  EXPORT final_uls                := uls_rolled;
 
  // Output file access and reference functions
  EXPORT ul_ds_all       (STRING asOf  = default_asOf) :=
    IF(NOTHOR(STD.File.FileExists(outfile_prefix+'underlinks_'       +asOf)),DATASET(outfile_prefix+'underlinks_'       +asOf,ul_lo    ,THOR)                   ,DATASET([],ul_lo    ));
  EXPORT ul_ds           (SET OF UNSIGNED8 proxids, STRING asOf = default_asOf) :=
    IF(NOTHOR(STD.File.FileExists(outfile_prefix+'underlinks_'       +asOf)),DATASET(outfile_prefix+'underlinks_'       +asOf,ul_lo    ,THOR)(proxid IN proxids),DATASET([],ul_lo    ));
 
  EXPORT ul_risk    (SET OF UNSIGNED8 proxids, STRING asOf = default_asOf, STRING desc = '1') := FUNCTION
    RETURN ORDERED(
      OUTPUT(samples(SORT(ul_ds       (proxids, asOf),proxid)),NAMED('ul_risk_'+desc));
    );
  END;
 
  // Summary table
  EXPORT tb_ul(ds, fields = 'score,', desc1, desc2) := FUNCTIONMACRO // PML To Do: Auto gen the cols based on what's active instead of all possible?
    IMPORT STD;
    RETURN TABLE(SORT(ds,#EXPAND(fields)proxid), { total:=(STRING6)#EXPAND(desc1), issues:=(STRING2)#EXPAND(desc2),
             UNSIGNED cnt         :=COUNT(GROUP);                               REAL pct           :=pct(COUNT(GROUP),COUNT(ds));
             REAL     ave_recs    :=rnd2(AVE(GROUP,cnt_recs));                  REAL ave_alts      :=rnd2(AVE(GROUP,alt_proxids));
             REAL     ave_avg     :=rnd2(AVE(GROUP,avg_score));                 REAL ave_max       :=rnd2(AVE(GROUP,max_id_score));

             UNSIGNED cnt_ent_a   :=COUNT(GROUP,REGEXFIND('ENT_A'   ,factors)); UNSIGNED cnt_ent_h   :=COUNT(GROUP,REGEXFIND('ENT_H'   ,factors));
             UNSIGNED cnt_ent_x   :=COUNT(GROUP,REGEXFIND('ENT_X'   ,factors));
             UNSIGNED cnt_duns_a  :=COUNT(GROUP,REGEXFIND('DUNS_A'  ,factors)); UNSIGNED cnt_duns_h  :=COUNT(GROUP,REGEXFIND('DUNS_H'  ,factors));
             UNSIGNED cnt_duns    :=COUNT(GROUP,REGEXFIND('DUNS '   ,factors)); //UNSIGNED cnt_duns_x  :=COUNT(GROUP,REGEXFIND('DUNS_X'  ,factors));
             UNSIGNED cnt_dcorp_a :=COUNT(GROUP,REGEXFIND('DCORP_A' ,factors)); UNSIGNED cnt_dcorp_h :=COUNT(GROUP,REGEXFIND('DCORP_H' ,factors));
             UNSIGNED cnt_fcorp   :=COUNT(GROUP,REGEXFIND('FCORP'   ,factors)); UNSIGNED cnt_ucorp   :=COUNT(GROUP,REGEXFIND('UCORP'   ,factors));
             UNSIGNED cnt_corp_x  :=COUNT(GROUP,REGEXFIND('CORP_X'  ,factors));
             UNSIGNED cnt_fein    :=COUNT(GROUP,REGEXFIND('FEIN'    ,factors)); UNSIGNED cnt_fein_x  :=COUNT(GROUP,REGEXFIND('FEIN_X'  ,factors));
             UNSIGNED cnt_ebr     :=COUNT(GROUP,REGEXFIND('EBR'     ,factors));
             UNSIGNED cnt_srcvl   :=COUNT(GROUP,REGEXFIND('SRCVL'   ,factors)); UNSIGNED cnt_srcrid  :=COUNT(GROUP,REGEXFIND('SRCRID'  ,factors));
             UNSIGNED cnt_sele    :=COUNT(GROUP,REGEXFIND('SELE'    ,factors)); UNSIGNED cnt_bdid    :=COUNT(GROUP,REGEXFIND('BDID'    ,factors));

             UNSIGNED cnt_cnamef  :=COUNT(GROUP,REGEXFIND('CNAMEF'  ,factors)); UNSIGNED cnt_lname   :=COUNT(GROUP,REGEXFIND('LNAME'   ,factors));
             UNSIGNED cnt_dname   :=COUNT(GROUP,REGEXFIND('DNAME'   ,factors));
             UNSIGNED cnt_addrvsz :=COUNT(GROUP,REGEXFIND('ADDRVSZ' ,factors)); UNSIGNED cnt_addrpsz :=COUNT(GROUP,REGEXFIND('ADDRPSZ' ,factors));
             UNSIGNED cnt_addrst  :=COUNT(GROUP,REGEXFIND('ADDRST'  ,factors)); UNSIGNED cnt_addrst2 :=COUNT(GROUP,REGEXFIND('ADDRST2' ,factors));
             UNSIGNED cnt_cphn    :=COUNT(GROUP,REGEXFIND('CPHN'    ,factors)); UNSIGNED cnt_phn_x   :=COUNT(GROUP,REGEXFIND('PHN_X'   ,factors));
             UNSIGNED cnt_url     :=COUNT(GROUP,REGEXFIND('URL'     ,factors)); UNSIGNED cnt_url_x   :=COUNT(GROUP,REGEXFIND('URL_X'   ,factors));
             UNSIGNED cnt_ticker  :=COUNT(GROUP,REGEXFIND('TICKER'  ,factors)); UNSIGNED cnt_tickex  :=COUNT(GROUP,REGEXFIND('TICKEX'  ,factors));

             UNSIGNED cnt_owndid  :=COUNT(GROUP,REGEXFIND('OWNDID'  ,factors)); UNSIGNED cnt_pdid    :=COUNT(GROUP,REGEXFIND('PDID'    ,factors));
             UNSIGNED cnt_did_x   :=COUNT(GROUP,REGEXFIND('DID_X'   ,factors));
             UNSIGNED cnt_pname   :=COUNT(GROUP,REGEXFIND('PNAME'   ,factors)); UNSIGNED cnt_pssn    :=COUNT(GROUP,REGEXFIND('PSSN'    ,factors));
             UNSIGNED cnt_peml    :=COUNT(GROUP,REGEXFIND('PEML '   ,factors)); UNSIGNED cnt_pemldom :=COUNT(GROUP,REGEXFIND('PEMLDOM' ,factors));
             UNSIGNED cnt_pphn    :=COUNT(GROUP,REGEXFIND('PPHN'    ,factors));

             UNSIGNED cnt_entoa   :=COUNT(GROUP,REGEXFIND('ENT_A'   ,factors)   AND ~REGEXFIND('(ENT_X|ENT_H)'               ,factors));
             UNSIGNED cnt_entoh   :=COUNT(GROUP,REGEXFIND('ENT_H'   ,factors)   AND ~REGEXFIND('(ENT_A|ENT_X)'               ,factors));
             UNSIGNED cnt_entox   :=COUNT(GROUP,REGEXFIND('ENT_X'   ,factors)   AND ~REGEXFIND('(ENT_A|ENT_H)'               ,factors));
 
             UNSIGNED cnt_dunsoa  :=COUNT(GROUP,REGEXFIND('DUNS_A'  ,factors)   AND ~REGEXFIND('DUNS_H'                      ,factors));
             UNSIGNED cnt_dunsoh  :=COUNT(GROUP,REGEXFIND('DUNS_H'  ,factors)   AND ~REGEXFIND('DUNS_A'                      ,factors));
             UNSIGNED cnt_dunso   :=COUNT(GROUP,REGEXFIND('DUNS'    ,factors)   AND ~REGEXFIND('(DUNS_A|DUNS_H)'             ,factors));
 
             UNSIGNED cnt_dcorpoa :=COUNT(GROUP,REGEXFIND('DCORP_A' ,factors)   AND ~REGEXFIND('(CORP_X|CORP_H|FCORP|UCORP)' ,factors));
             UNSIGNED cnt_dcorpoh :=COUNT(GROUP,REGEXFIND('DCORP_H' ,factors)   AND ~REGEXFIND('(CORP_A|CORP_X|FCORP|UCORP)' ,factors));
             UNSIGNED cnt_dcorpof :=COUNT(GROUP,REGEXFIND('FCORP'   ,factors)   AND ~REGEXFIND('(CORP_A|CORP_H|CORP_X|UCORP)',factors));
             UNSIGNED cnt_dcorpou :=COUNT(GROUP,REGEXFIND('UCORP'   ,factors)   AND ~REGEXFIND('(CORP_A|CORP_H|FCORP|CORP_X)',factors));
             UNSIGNED cnt_dcorpox :=COUNT(GROUP,REGEXFIND('CORP_X'  ,factors)   AND ~REGEXFIND('(CORP_A|CORP_H|FCORP|UCORP)' ,factors));
             UNSIGNED cnt_feinox  :=COUNT(GROUP,REGEXFIND('FEIN_X'  ,factors)   AND ~REGEXFIND('(FEIN[^_]|PSSN)'             ,factors));
             UNSIGNED cnt_phnox   :=COUNT(GROUP,REGEXFIND('PHN_X'   ,factors)   AND ~REGEXFIND('(CPHN|PPHN)'                 ,factors));
             UNSIGNED cnt_urlox   :=COUNT(GROUP,REGEXFIND('URL_X'   ,factors)   AND ~REGEXFIND('(URL[^_]|PEMLDOM)'           ,factors));
             UNSIGNED cnt_didox   :=COUNT(GROUP,REGEXFIND('DID_X'   ,factors)   AND ~REGEXFIND('(OWNDID|PDID)'               ,factors));
             }, #EXPAND(fields) FEW);
  ENDMACRO;
 
  EXPORT tb_uls_summ      (DATASET(ul_lo) uls = final_uls) := tb_ul(uls,'','\'ALL\'','\'\'') & SORT(tb_ul(uls,'score,',       'score',       '\'\''),-(UNSIGNED)total,-(UNSIGNED)issues);
  EXPORT tb_uls_summ_maxid(DATASET(ul_lo) uls = final_uls) := tb_ul(uls,'','\'ALL\'','\'\'') & SORT(tb_ul(uls,'max_id_score,','max_id_score','\'\''),-(UNSIGNED)total,-(UNSIGNED)issues);
  EXPORT tb_uls_summ_altid(DATASET(ul_lo) uls = final_uls) := tb_ul(uls,'','\'ALL\'','\'\'') & SORT(tb_ul(uls,'alt_proxids,', 'alt_proxids', '\'\''),-(UNSIGNED)total,-(UNSIGNED)issues);
  //EXPORT tb_uls_dtl (DATASET(ul_lo) uls = final_uls) := tb_ul(uls,'','\'ALL\'','\'\'') & SORT(tb_ul(uls,'score,STD.Str.FindCount(factors,\':\')-STD.Str.FindCount(factors,\'0:\'),','score','(STD.Str.FindCount(factors,\':\')-STD.Str.FindCount(factors,\'0:\'))'),-(UNSIGNED)total,-(UNSIGNED)issues);
  //EXPORT tb_uls_segs(DATASET(ul_lo) uls = final_uls) := TABLE(uls, { seg, score, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=pct(COUNT(GROUP),COUNT(uls)) }, seg, score, FEW);
 
  EXPORT tb_uls_score (in_ds, in_min, in_max)         := MACRO
    OUTPUT(SORT(TABLE(in_ds(score BETWEEN in_min AND in_max), { will_link, scored, forced, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(in_ds(score BETWEEN in_min AND in_max))*100,2), il_svc__html }
      ,will_link, scored, forced, FEW),-cnt),NAMED('tb_score_'+in_min+'_to_'+in_max),ALL) : ONWARNING(2168,ignore);
  ENDMACRO;
 
  EXPORT tb_uls_factor(in_ds, in_factor)              := MACRO
    OUTPUT(SORT(TABLE(in_ds(REGEXFIND(in_factor,factors)),    { will_link, scored, forced, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(in_ds(REGEXFIND(in_factor,factors   )))*100,2), il_svc__html }
      ,will_link, scored, forced, FEW),-cnt),NAMED('tb_factor_'+in_factor)          ,ALL) : ONWARNING(2168,ignore);
  ENDMACRO;

  // Batch Comparison
  EXPORT compare_uls(DATASET(ul_lo) in_uls, STRING in_desc = ul_compare_desc) := FUNCTION//, STRING in_parent_filter = ul_compare_parent_filter, STRING in_child_filter = ul_compare_child_filter) := FUNCTION
    //compare_uls_dist              := DISTRIBUTE(in_uls(#EXPAND(in_parent_filter)),HASH32(proxid));
    //compare_uls_norm              := norm_ul(in_uls)(#EXPAND(in_child_filter));
    compare_uls_dist              := DISTRIBUTE(in_uls(#EXPAND(ul_compare_parent_filter)),HASH32(proxid));
    compare_uls_norm              := DEDUP(SORT(DISTRIBUTE(norm_ul(compare_uls_dist)(#EXPAND(ul_compare_child_filter)),HASH32(proxid))
                                       ,proxid,alt_proxid,ul_issue<>'MULTIPLE',-STD.Str.FindCount(ul_value,':'),-ul_val_cnt,LOCAL),proxid,alt_proxid,LOCAL);
    compare_uls_proj              := DISTRIBUTE(PROJECT(compare_uls_norm, TRANSFORM(proxid_compare.proxidpair_lo,
                                       SELF.proxid1:=MAX(LEFT.proxid,LEFT.alt_proxid), SELF.proxid2:=MIN(LEFT.proxid,LEFT.alt_proxid))),HASH32(proxid1));
    compare_uls_pairs             := DEDUP(SORT(compare_uls_proj,proxid1,proxid2,LOCAL),proxid1,proxid2,LOCAL);
 
    compare_uls_compared          := proxid_compare.batchCompare(compare_uls_pairs); //,roll_cand:=TRUE,use_allm:=FALSE);
 
    compare_uls_tb_link_pairs     := TABLE(compare_uls_compared, {        will_link, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_compared)*100,2) },        will_link, FEW);
    compare_uls_tb_score_pairs    := TABLE(compare_uls_compared, {        scored,    UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_compared)*100,2) },        scored,    FEW);
    compare_uls_tb_force_pairs    := TABLE(compare_uls_compared, {        forced,    UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_compared)*100,2) },        forced,    FEW);
    compare_uls_tb_block_pairs    := TABLE(compare_uls_compared, {        blocked,   UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_compared)*100,2) },        blocked,   FEW);
    compare_uls_tb_all_pairs      := TABLE(compare_uls_compared, {        will_link, scored, forced, blocked, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_compared)*100,2) },        will_link, scored, forced, blocked, FEW);
 
    compare_uls_out_norm1         := JOIN(compare_uls_norm, DISTRIBUTE(compare_uls_compared,HASH32(from_proxid)), LEFT.proxid=RIGHT.from_proxid AND LEFT.alt_proxid=RIGHT.to_proxid,
                                       TRANSFORM(ul_norm_ext_lo, SELF.will_link:=RIGHT.will_link, SELF.scored:=RIGHT.scored, SELF.forced:=RIGHT.forced, SELF.blocked:=RIGHT.blocked, SELF.conf:=RIGHT.conf_comp, SELF:=LEFT, SELF:=[]), LOCAL);
    compare_uls_out_norm2         := JOIN(compare_uls_norm, DISTRIBUTE(compare_uls_compared,HASH32(to_proxid  )), LEFT.proxid=RIGHT.to_proxid   AND LEFT.alt_proxid=RIGHT.from_proxid,
                                       TRANSFORM(ul_norm_ext_lo, SELF.will_link:=RIGHT.will_link, SELF.scored:=RIGHT.scored, SELF.forced:=RIGHT.forced, SELF.blocked:=RIGHT.blocked, SELF.conf:=RIGHT.conf_comp, SELF:=LEFT, SELF:=[]), LOCAL);
    compare_uls_out_norm          := DISTRIBUTE(compare_uls_out_norm1 + compare_uls_out_norm2,HASH32(proxid));
 
    compare_uls_tb_link_norm      := TABLE(compare_uls_out_norm, { score, will_link, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_out_norm)*100,2) }, score, will_link, FEW);
    compare_uls_tb_score_norm     := TABLE(compare_uls_out_norm, { score, scored,    UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_out_norm)*100,2) }, score, scored,    FEW);
    compare_uls_tb_force_norm     := TABLE(compare_uls_out_norm, { score, forced,    UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_out_norm)*100,2) }, score, forced,    FEW);
    compare_uls_tb_block_norm     := TABLE(compare_uls_out_norm, { score, blocked,   UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_out_norm)*100,2) }, score, blocked,   FEW);
    compare_uls_tb_all_norm       := TABLE(compare_uls_out_norm, { score, will_link, scored, forced, blocked, UNSIGNED cnt:=COUNT(GROUP), REAL pct:=ROUND(COUNT(GROUP)/COUNT(compare_uls_out_norm)*100,2) }, score, will_link, scored, forced, blocked, FEW);
 
    compare_uls_out_denorm1       := denorm_ul_ext(PROJECT(DEDUP(SORT(compare_uls_out_norm,proxid,LOCAL),proxid,LOCAL), TRANSFORM(ul_ext_lo,
                                       SELF.ul_dtls:=[], SELF:=LEFT)),compare_uls_out_norm);
    compare_uls_out_denorm        := PROJECT(compare_uls_out_denorm1, TRANSFORM(ul_ext_lo,
                                       deduped_dtls    := DEDUP(SORT(LEFT.ul_dtls,alt_proxid,LOCAL),alt_proxid,LOCAL);
                                       SELF.alt_links  := COUNT(deduped_dtls(TRIM(will_link)     IN ['A','Y'] )),
                                       SELF.alt_forces := COUNT(deduped_dtls(TRIM(forced)    NOT IN ['N/A',''])),
                                       SELF.alt_blocks := COUNT(deduped_dtls(TRIM(blocked)   NOT IN ['N/A',''])),
                                       SELF.ul_dtls    := SORT(LEFT.ul_dtls,ul_issue<>'MULTIPLE',-STD.Str.FindCount(ul_value,':'),-ul_val_cnt,alt_proxid),
                                       SELF:=LEFT));
 
    RETURN MODULE
      EXPORT compared_ul_pairs    := compare_uls_compared;
      EXPORT tb_compared_ul_pairs := compare_uls_tb_all_pairs;
 
      EXPORT compared_uls_norm    := compare_uls_out_norm;
      EXPORT tb_compared_uls_norm := compare_uls_tb_all_norm;
 
      EXPORT compared_uls_denorm  := compare_uls_out_denorm;
 
      EXPORT compared_uls         := compare_uls_out_norm;

      EXPORT compare_summary      := ORDERED(
        OUTPUT('_____UL_Compare_Counts_'+in_desc+'____',NAMED('_____UL_Compare_Counts_'+in_desc+'____')),
        OUTPUT(COUNT(in_uls),NAMED('cnt_compare_in_uls_'+in_desc)),
        //OUTPUT(in_parent_filter,NAMED('in_parent_filter_'+in_desc)),
        OUTPUT(ul_compare_parent_filter,NAMED('in_parent_filter_'+in_desc)),
        OUTPUT(COUNT(compare_uls_dist),NAMED('cnt_in_uls_filtered_'+in_desc)),
        //OUTPUT(in_child_filter,NAMED('in_child_filter_'+in_desc)),
        OUTPUT(ul_compare_child_filter,NAMED('in_child_filter_'+in_desc)),
        OUTPUT(COUNT(compare_uls_norm),NAMED('cnt_in_uls_normed_'+in_desc)),
        OUTPUT(COUNT(compare_uls_pairs),NAMED('cnt_ul_pairs_'+in_desc)),
        OUTPUT(COUNT(compare_uls_compared),NAMED('cnt_ul_pairs_compared_'+in_desc)),
        OUTPUT(COUNT(compare_uls_out_norm),NAMED('cnt_out_uls_normed_'+in_desc)),
        OUTPUT(COUNT(compare_uls_out_denorm),NAMED('cnt_out_uls_denormed_'+in_desc)),
        OUTPUT('_____UL_Compare_Samples_'+in_desc+'____',NAMED('_____UL_Compare_Samples_'+in_desc+'____')),
        OUTPUT(SORT(compare_uls_out_norm(will_link='Y')  ,proxid,alt_proxid,LOCAL),NAMED('will_link_'+in_desc)),
        OUTPUT(SORT(compare_uls_out_norm(will_link='N')  ,proxid,alt_proxid,LOCAL),NAMED('will_not_link_'+in_desc)),
        OUTPUT(SORT(compare_uls_out_norm(will_link='U')  ,proxid,alt_proxid,LOCAL),NAMED('unmatched_'+in_desc)),
        OUTPUT(SORT(compare_uls_out_norm(TRIM(forced)>''),proxid,alt_proxid,LOCAL),NAMED('forced_'+in_desc))
      );
 
      EXPORT compare_details      := ORDERED(
        OUTPUT('_____UL_Compare_Pair_Tables_'+in_desc+'____',NAMED('_____UL_Compare_Pair_Tables_'+in_desc+'____')),
        OUTPUT(SORT(compare_uls_tb_link_pairs,-cnt),NAMED('tb_link_'+in_desc)),
        OUTPUT(SORT(compare_uls_tb_score_pairs,-cnt),NAMED('tb_score_'+in_desc)),
        OUTPUT(SORT(compare_uls_tb_force_pairs,-cnt),NAMED('tb_force_'+in_desc)),
        OUTPUT(SORT(compare_uls_tb_block_pairs,-cnt),NAMED('tb_block_'+in_desc)),
        OUTPUT(SORT(compare_uls_tb_all_pairs,-cnt),NAMED('tb_all_'+in_desc)),
        OUTPUT('_____UL_Compare_Score_Tables_'+in_desc+'____',NAMED('_____UL_Compare_Score_Tables_'+in_desc+'____')),
        OUTPUT(SORT(compare_uls_tb_link_norm,-score,will_link),NAMED('tb_link_score_'+in_desc),ALL),
        OUTPUT(SORT(compare_uls_tb_score_norm,-score,scored),NAMED('tb_score_score_'+in_desc),ALL),
        OUTPUT(SORT(compare_uls_tb_force_norm,-score,forced),NAMED('tb_force_score_'+in_desc),ALL),
        OUTPUT(SORT(compare_uls_tb_block_norm,-score,blocked),NAMED('tb_block_score_'+in_desc)),
        OUTPUT(CHOOSEN(SORT(compare_uls_tb_all_norm,-score,blocked),500),NAMED('tb_all_score_'+in_desc),ALL)
      );
    END;
  END;

  EXPORT default_compare_uls      := compare_uls(final_uls(score>0));

  EXPORT ul_scores_ds_all(STRING asOf  = default_asOf) :=
    IF(NOTHOR(STD.File.FileExists(outfile_prefix+'underlinks_scores_'+asOf)),DATASET(outfile_prefix+'underlinks_scores_'+asOf,ul_ext_lo,THOR)                   ,DATASET([],ul_ext_lo));
  EXPORT ul_scores_ds    (SET OF UNSIGNED8 proxids, STRING asOf  = default_asOf) :=
    IF(NOTHOR(STD.File.FileExists(outfile_prefix+'underlinks_scores_'+asOf)),DATASET(outfile_prefix+'underlinks_scores_'+asOf,ul_ext_lo,THOR)(proxid IN proxids),DATASET([],ul_ext_lo));
 
  EXPORT ul_risk_dtl(SET OF UNSIGNED8 proxids, STRING asOf = default_asOf, STRING desc = '1') := FUNCTION
    RETURN ORDERED(
      OUTPUT(samples(SORT(ul_scores_ds(proxids, asOf),proxid)),NAMED('ul_risk_'+desc));
    );
  END;

  // Aggregate results for Power BI reporting
  EXPORT aggregate_uls(DATASET(ul_norm_ext_lo) in_uls, STRING in_desc = ul_compare_desc) := FUNCTION
    aggregate_uls                 := in_uls;
 
    norm_sco(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,score       )) / ((REAL)MAX(aggregate_uls,score       )-(REAL)MIN(aggregate_uls,score       )),4);
    norm_avg(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,avg_score   )) / ((REAL)MAX(aggregate_uls,avg_score   )-(REAL)MIN(aggregate_uls,avg_score   )),4);
    norm_rec(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,cnt_recs    )) / ((REAL)MAX(aggregate_uls,cnt_recs    )-(REAL)MIN(aggregate_uls,cnt_recs    )),4);
    norm_pop(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,pct_pop     )) / ((REAL)MAX(aggregate_uls,pct_pop     )-(REAL)MIN(aggregate_uls,pct_pop     )),4);
    norm_alt(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,alt_proxids )) / ((REAL)MAX(aggregate_uls,alt_proxids )-(REAL)MIN(aggregate_uls,alt_proxids )),4);
    norm_max(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,max_id_score)) / ((REAL)MAX(aggregate_uls,max_id_score)-(REAL)MIN(aggregate_uls,max_id_score)),4);
    norm_con(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,conf        )) / ((REAL)MAX(aggregate_uls,conf        )-(REAL)MIN(aggregate_uls,conf        )),4);
    norm_ulv(REAL n)              := ROUND((n-(REAL)MIN(aggregate_uls,ul_val_cnt  )) / ((REAL)MAX(aggregate_uls,ul_val_cnt  )-(REAL)MIN(aggregate_uls,ul_val_cnt  )),4);
 
    aggregate_uls_proj            := DISTRIBUTE(PROJECT(aggregate_uls, TRANSFORM(ul_agg_lo,
                                       SELF.proxid:=MAX(LEFT.proxid,LEFT.alt_proxid), SELF.alt_proxid:=MIN(LEFT.proxid,LEFT.alt_proxid), SELF.flip:=IF(SELF.proxid<>LEFT.proxid,'Y',''),
                                       SELF.factor_cnt   := MAX(1,LENGTH(TRIM(REGEXREPLACE('[^:]',LEFT.ul_value,'')))),
 
                                       // Bucketize certain factors further to reduce unique combinations and keep output filesize reasonable
                                       SELF.score        := MAP(LEFT.score        >= 20 => 20, LEFT.score        >= 15 => 15, LEFT.score        >= 10 => 10,                                5),
                                       SELF.avg_score    := MAP(LEFT.avg_score    >=  4 =>  4, LEFT.avg_score    >=  3 =>  3, LEFT.avg_score    >=  2 =>  2, LEFT.avg_score    >=  1 =>  1, 0),
                                       SELF.cnt_recs     := MAP(LEFT.cnt_recs     >= 50 => 50, LEFT.cnt_recs     >= 25 => 25, LEFT.cnt_recs     >= 10 => 10, LEFT.cnt_recs     >=  5 =>  5, 1),
                                       SELF.pct_pop      := MAP(LEFT.pct_pop      >= 75 => 75, LEFT.pct_pop      >= 66 => 67, LEFT.pct_pop      >= 50 => 50, LEFT.pct_pop      >= 33 => 33, 0),
                                       SELF.alt_proxids  := MAP(LEFT.alt_proxids  >= 20 => 20, LEFT.alt_proxids  >= 15 => 15, LEFT.alt_proxids  >= 10 => 10, LEFT.alt_proxids  >=  5 =>  5, 1),
                                       SELF.max_id_score := MAP(LEFT.max_id_score >= 20 => 20, LEFT.max_id_score >= 15 => 15, LEFT.max_id_score >= 10 => 10, LEFT.max_id_score >=  5 =>  5, 1),
 
                                       // Factor Breakouts
                                       // ENT  - M, A, H, X*             // No X, all vals either A or H
                                       SELF.ent_a     :=IF(REGEXFIND('ENT_A'   ,LEFT.ul_value),'Y',''), SELF.ent_h   :=IF(REGEXFIND('ENT_H'   ,LEFT.ul_value),'Y',''),
                                       SELF.ent_x     :=IF(REGEXFIND('ENT_X'   ,LEFT.ul_value),'Y',''),
                                       SELF.ent       :=IF(SELF.ent_a   ='Y',IF(SELF.ent_h   ='Y','M',IF(SELF.ent_x='Y','M','A')),IF(SELF.ent_h='Y',IF(SELF.ent_x='Y','M','H'),IF(SELF.ent_x='Y','X',''))),
                                       //SELF.ent       :=IF(SELF.ent_a   ='Y',IF(SELF.ent_h   ='Y','M','A'),IF(SELF.ent_h  ='Y','H','')),
 
                                       // DUNS - M, A, H
                                       SELF.duns_a    :=IF(REGEXFIND('DUNS_A'  ,LEFT.ul_value),'Y',''), SELF.duns_h  :=IF(REGEXFIND('DUNS_H'  ,LEFT.ul_value),'Y',''),
                                       SELF.duns      :=IF(SELF.duns_a  ='Y',IF(SELF.duns_h  ='Y','M','A'),IF(SELF.duns_h ='Y','H','')),
 
                                       // CORP - M, A, H, F, U, X
                                       SELF.dcorp_a   :=IF(REGEXFIND('DCORP_A' ,LEFT.ul_value),'Y',''), SELF.dcorp_h :=IF(REGEXFIND('DCORP_H' ,LEFT.ul_value),'Y',''),
                                       SELF.fcorp     :=IF(REGEXFIND('FCORP'   ,LEFT.ul_value),'Y',''), SELF.ucorp   :=IF(REGEXFIND('UCORP'   ,LEFT.ul_value),'Y',''),
                                       SELF.corp_x    :=IF(REGEXFIND('CORP_X'  ,LEFT.ul_value),'Y',''),
                                       SELF.corp      :=IF(SELF.dcorp_a ='Y',IF(SELF.dcorp_h ='Y','M',IF(SELF.fcorp  ='Y','M',IF(SELF.ucorp  ='Y','M',IF(SELF.corp_x ='Y','M','A')))),
                                                        IF(SELF.dcorp_h ='Y',IF(SELF.fcorp   ='Y','M',IF(SELF.ucorp  ='Y','M',IF(SELF.corp_x ='Y','M','H'))),
                                                        IF(SELF.fcorp   ='Y',IF(SELF.ucorp   ='Y','M',IF(SELF.corp_x ='Y','M','F')),
                                                        IF(SELF.ucorp   ='Y',IF(SELF.corp_x  ='Y','M','U'),
                                                        IF(SELF.corp_x  ='Y','X',''))))),
 
                                       // FEIN - M, F, S, X
                                       SELF.fein_o    :=IF(REGEXFIND('FEIN[^_]',LEFT.ul_value),'Y',''), SELF.pssn    :=IF(REGEXFIND('PSSN'    ,LEFT.ul_value),'Y',''),
                                       SELF.fein_x    :=IF(REGEXFIND('FEIN_X'  ,LEFT.ul_value),'Y',''),
                                       //SELF.fein      :=IF(SELF.fein_o  ='Y',IF(SELF.fein_x  ='Y','M','F'),IF(SELF.fein_x ='Y','X','')),
                                       SELF.fein      :=IF(SELF.fein_o  ='Y',IF(SELF.pssn    ='Y','M',IF(SELF.fein_x='Y','M','F')),IF(SELF.pssn ='Y',IF(SELF.fein_x='Y','M','S'),IF(SELF.fein_x='Y','X',''))),
 
                                       // EBR  - Y
                                       SELF.ebr       :=IF(REGEXFIND('EBR'     ,LEFT.ul_value),'Y',''),
 
                                       // SRC  - M, R, V
                                       SELF.srcvl     :=IF(REGEXFIND('SRCVL'   ,LEFT.ul_value),'Y',''), SELF.srcrid  :=IF(REGEXFIND('SRCRID'  ,LEFT.ul_value),'Y',''),
                                       SELF.src       :=IF(SELF.srcvl   ='Y',IF(SELF.srcrid  ='Y','M','V'),IF(SELF.srcrid ='Y','R','')),
 
                                       // LNID - M, B, S
                                       SELF.sele      :=IF(REGEXFIND('SELE'    ,LEFT.ul_value),'Y',''), SELF.bdid    :=IF(REGEXFIND('BDID'    ,LEFT.ul_value),'Y',''),
                                       SELF.lnid      :=IF(SELF.sele    ='Y',IF(SELF.bdid    ='Y','M','S'),IF(SELF.bdid   ='Y','B','')),
 
                                       // NAME - M, D, F, L
                                       SELF.cnamef    :=IF(REGEXFIND('CNAMEF'  ,LEFT.ul_value),'Y',''), SELF.lname   :=IF(REGEXFIND('LNAME'   ,LEFT.ul_value),'Y',''),
                                       SELF.dname     :=IF(REGEXFIND('DNAME'   ,LEFT.ul_value),'Y',''),
                                       SELF.name      :=IF(SELF.cnamef  ='Y',IF(SELF.lname   ='Y','M',IF(SELF.dname='Y','M','F')),IF(SELF.lname='Y',IF(SELF.dname='Y','M','L'),IF(SELF.dname='Y','D',''))),
 
                                       // ADDR - 1, 2
                                       SELF.addrpsz   :=IF(REGEXFIND('ADDRPSZ' ,LEFT.ul_value),'Y',''), SELF.addrvsz :=IF(REGEXFIND('ADDRVSZ' ,LEFT.ul_value),'Y',''),
                                       SELF.addrst    :=IF(REGEXFIND('ADDRST'  ,LEFT.ul_value),'Y',''), SELF.addrst2 :=IF(REGEXFIND('ADDRST2' ,LEFT.ul_value),'Y',''),
                                       SELF.addr      :=IF(SELF.addrst  ='Y',IF(SELF.addrst2 ='Y','2','1'),''), // No VSZ or PSZ at this time
 
                                       // PHN  - M, C, P, X
                                       SELF.cphn      :=IF(REGEXFIND('CPHN'    ,LEFT.ul_value),'Y',''), SELF.pphn    :=IF(REGEXFIND('PPHN'    ,LEFT.ul_value),'Y',''),
                                       SELF.phn_x     :=IF(REGEXFIND('PHN_X'   ,LEFT.ul_value),'Y',''),
                                       SELF.phn       :=IF(SELF.cphn    ='Y',IF(SELF.pphn    ='Y','M',IF(SELF.phn_x='Y','M','C')),IF(SELF.pphn ='Y',IF(SELF.phn_x='Y','M','P'),IF(SELF.phn_x='Y','X',''))),
 
                                       // URL  - M*, D*, U*, X           // No MDU - URL & Domain set to 0 max UL score
                                       SELF.url_o     :=IF(REGEXFIND('URL[^_]' ,LEFT.ul_value),'Y',''), SELF.pdom    :=IF(REGEXFIND('PEMLDOM' ,LEFT.ul_value),'Y',''),
                                       SELF.url_x     :=IF(REGEXFIND('URL_X'   ,LEFT.ul_value),'Y',''),
                                       //SELF.url       :=IF(SELF.url_o   ='Y',IF(SELF.url_x   ='Y','M','U'),IF(SELF.url_x  ='Y','X','')),
                                       SELF.url       :=IF(SELF.url_o   ='Y',IF(SELF.pdom    ='Y','M',IF(SELF.url_x='Y','M','U')),IF(SELF.pdom ='Y',IF(SELF.url_x='Y','M','D'),IF(SELF.url_x='Y','X',''))),
 
                                       // DID  - M, O, P, X
                                       SELF.owndid    :=IF(REGEXFIND('OWNDID'  ,LEFT.ul_value),'Y',''), SELF.pdid    :=IF(REGEXFIND('PDID'    ,LEFT.ul_value),'Y',''),
                                       SELF.did_x     :=IF(REGEXFIND('DID_X'   ,LEFT.ul_value),'Y',''),
                                       SELF.did       :=IF(SELF.owndid  ='Y',IF(SELF.pdid    ='Y','M',IF(SELF.did_x='Y','M','O')),IF(SELF.pdid ='Y',IF(SELF.did_x='Y','M','P'),IF(SELF.did_x='Y','X',''))),
 
                                        // CON  - M, D*, E, N*, S         // No DN - Name & Domain set to 0 max UL score
                                       SELF.pname     :=IF(REGEXFIND('PNAME'   ,LEFT.ul_value),'Y',''), SELF.peml    :=IF(REGEXFIND('PEML '   ,LEFT.ul_value),'Y',''),
                                       SELF.contact   :=IF(SELF.pname   ='Y',IF(SELF.pssn    ='Y','M',IF(SELF.peml   ='Y','M',IF(SELF.pdom   ='Y','M','N'))),
                                                        IF(SELF.pssn    ='Y',IF(SELF.peml    ='Y','M',IF(SELF.pdom   ='Y','M','S')),
                                                        IF(SELF.peml    ='Y',IF(SELF.pdom    ='Y','M','E'),
                                                        IF(SELF.pdom    ='Y','D','')))),

                                       // TICK - R*, X*                  //* No RX  - Ticker/Ex set to 0 max UL score
                                       SELF.ticker    :=IF(REGEXFIND('TICKER'  ,LEFT.ul_value),'Y',''), SELF.tickex  :=IF(REGEXFIND('TICKEX'  ,LEFT.ul_value),'Y',''),
                                       SELF.tick      :=IF(SELF.ticker  ='Y',IF(SELF.tickex  ='Y','X','R'),''),

                                       SELF.entoa   :=IF(SELF.ent ='A','Y',''),
                                       SELF.entoh   :=IF(SELF.ent ='H','Y',''),
                                       SELF.entox   :=IF(SELF.ent ='X','Y',''),
                                       SELF.dunsoa  :=IF(SELF.duns='A','Y',''),
                                       SELF.dunsoh  :=IF(SELF.duns='H','Y',''),
                                       SELF.dunso   :=IF(REGEXFIND('DUNS'    ,LEFT.ul_value) AND ~REGEXFIND('(DUNS_A|DUNS_H)'               ,LEFT.ul_value),'Y',''),
                                       SELF.dcorpoa :=IF(SELF.corp='A','Y',''),
                                       SELF.dcorpoh :=IF(SELF.corp='H','Y',''),
                                       SELF.dcorpof :=IF(SELF.corp='F','Y',''),
                                       SELF.dcorpou :=IF(SELF.corp='U','Y',''),
                                       SELF.dcorpox :=IF(SELF.corp='X','Y',''),
                                       SELF.feinof  :=IF(SELF.ent ='F','Y',''),
                                       SELF.feinos  :=IF(SELF.ent ='S','Y',''),
                                       SELF.feinox  :=IF(SELF.ent ='X','Y',''),
                                       SELF.phnoc   :=IF(SELF.ent ='C','Y',''),
                                       SELF.phnop   :=IF(SELF.ent ='P','Y',''),
                                       SELF.phnox   :=IF(SELF.ent ='X','Y',''),
                                       SELF.urlou   :=IF(SELF.ent ='U','Y',''),
                                       SELF.urlod   :=IF(SELF.ent ='D','Y',''),
                                       SELF.urlox   :=IF(SELF.ent ='X','Y',''),
                                       SELF.didoo   :=IF(SELF.ent ='O','Y',''),
                                       SELF.didop   :=IF(SELF.ent ='P','Y',''),
                                       SELF.didox   :=IF(SELF.ent ='X','Y',''),

                                       SELF.norm_score  :=norm_sco(SELF.score),
                                       SELF.norm_avg    :=norm_avg(SELF.avg_score),
                                       SELF.norm_recs   :=norm_rec(SELF.cnt_recs),
                                       SELF.norm_pop    :=norm_pop(SELF.pct_pop),
                                       SELF.norm_alts   :=norm_alt(SELF.alt_proxids),
                                       SELF.norm_max    :=norm_max(SELF.max_id_score),
                                       SELF.norm_conf   :=norm_con(LEFT.conf),        // Needed?
                                       SELF.norm_ulvals :=norm_ulv(LEFT.ul_val_cnt),  // Needed? Bucket first?

                                       SELF:=LEFT)),HASH32(proxid));
 
    aggregate_uls_dd              := DEDUP(SORT(aggregate_uls_proj,proxid,alt_proxid,-score,-factor_cnt,-ul_val_cnt,LOCAL),proxid,alt_proxid,LOCAL);
 
    aggregate_uls_tb_summ         := DISTRIBUTE(TABLE(aggregate_uls_dd, { UNSIGNED cnt:=COUNT(GROUP),
                                       score, avg_score, cnt_recs, pct_pop, alt_proxids, max_id_score, seg, will_link, scored, forced, blocked, ul_val_cnt,
                                       ebr, addrpsz, addrvsz, //ticker, tickex, pname, peml,
                                       factor_cnt, name, addr, ent, duns, corp, fein, src, lnid, phn, url, did, contact, tick, norm_score, norm_avg, norm_recs, norm_pop, norm_alts, norm_max },
 
                                       score, avg_score, cnt_recs, pct_pop, alt_proxids, max_id_score, seg, will_link, scored, forced, blocked, ul_val_cnt,
                                       ebr, addrpsz, addrvsz, //ticker, tickex, pname, peml,
                                       factor_cnt, name, addr, ent, duns, corp, fein, src, lnid, phn, url, did, contact, tick, norm_score, norm_avg, norm_recs, norm_pop, norm_alts, norm_max,
                                       MANY, UNSTABLE, UNSORTED, MERGE));

    aggregate_uls_tb_dtl          := DISTRIBUTE(TABLE(aggregate_uls_dd, { UNSIGNED cnt:=COUNT(GROUP),
                                       score, avg_score, cnt_recs, pct_pop, alt_proxids, max_id_score, seg, will_link, scored, forced, blocked, ul_val_cnt,
                                       ent_a, ent_h, ent_x, duns_a, duns_h, dcorp_a, dcorp_h, fcorp, ucorp, corp_x, fein_o, fein_x, ebr, srcvl, srcrid, sele, bdid, cnamef, lname, dname,
                                       addrpsz, addrvsz, addrst, addrst2, cphn, url_o, ticker, tickex, owndid, pdid, pname, pssn, peml, pdom, pphn,
                                       entoa, entoh, entox, dunsoa, dunsoh, dunso, dcorpoa, dcorpoh, dcorpof, dcorpou, dcorpox,
                                       feinof, feinos, feinox, phnoc, phnop, phnox, urlou, urlod, urlox, didoo, didop, didox,
                                       factor_cnt, name, addr, ent, duns, corp, fein, src, lnid, phn, url, did, contact, tick, norm_score, norm_avg, norm_recs, norm_pop, norm_alts, norm_max },
 
                                       score, avg_score, cnt_recs, pct_pop, alt_proxids, max_id_score, seg, will_link, scored, forced, blocked, ul_val_cnt,
                                       ent_a, ent_h, ent_x, duns_a, duns_h, dcorp_a, dcorp_h, fcorp, ucorp, corp_x, fein_o, fein_x, ebr, srcvl, srcrid, sele, bdid, cnamef, lname, dname,
                                       addrpsz, addrvsz, addrst, addrst2, cphn, url_o, ticker, tickex, owndid, pdid, pname, pssn, peml, pdom, pphn,
                                       entoa, entoh, entox, dunsoa, dunsoh, dunso, dcorpoa, dcorpoh, dcorpof, dcorpou, dcorpox,
                                       feinof, feinos, feinox, phnoc, phnop, phnox, urlou, urlod, urlox, didoo, didop, didox,
                                       factor_cnt, name, addr, ent, duns, corp, fein, src, lnid, phn, url, did, contact, tick, norm_score, norm_avg, norm_recs, norm_pop, norm_alts, norm_max,
                                       MANY, UNSTABLE, UNSORTED, MERGE));
 
    RETURN MODULE
      EXPORT aggregated_uls       := aggregate_uls_proj;
      EXPORT aggregated_uls_dd    := aggregate_uls_dd;
      
      EXPORT tb_aggregated_summ   := aggregate_uls_tb_summ;
      EXPORT tb_aggregated_dtl    := aggregate_uls_tb_dtl;
 
      EXPORT aggregate_summary    := ORDERED(
        OUTPUT('_____UL_Aggregate_Counts_'+in_desc+'____',NAMED('_____UL_Aggregate_Counts_'+in_desc+'____')),
        OUTPUT(COUNT(in_uls),NAMED('cnt_aggregate_in_uls_'+in_desc)),
        OUTPUT(COUNT(aggregate_uls),NAMED('cnt_agg_uls_filtered_'+in_desc)),
        OUTPUT(COUNT(aggregate_uls_proj),NAMED('cnt_agg_uls_proj_'+in_desc)),
        OUTPUT(COUNT(aggregate_uls_dd),NAMED('cnt_agg_ul_dd_'+in_desc)),
        OUTPUT(COUNT(tb_aggregated_summ),NAMED('cnt_agg_tb_summary_'+in_desc)),
        OUTPUT(SORT(tb_aggregated_summ,-cnt),NAMED('agg_tb_summary_'+in_desc)),
        OUTPUT(COUNT(tb_aggregated_dtl),NAMED('cnt_agg_tb_details_'+in_desc)),
        OUTPUT(SORT(tb_aggregated_dtl,-cnt),NAMED('agg_tb_details_'+in_desc)),
      ) : ONWARNING(1005,ignore);
    END;
  END;
 
  EXPORT default_aggregate_uls    := aggregate_uls(default_compare_uls.compared_uls_norm);
 
  SHARED ul_th_probable           := 6;
  SHARED ul_th_questionable       := 5;
  SHARED ul_th_possible           := 4;

  EXPORT underlink_report         := ORDERED(
    OUTPUT('______Possible_Underlinks______',NAMED('______Possible_Underlinks______'));
    //OUTPUT(samples(SORT(ul_risk_config,-max_score,-scale,-min_score,factor)),NAMED('Underlink_Config'));
    OUTPUT(COUNT(final_uls(score>0)),NAMED('Possible_Underlinks'));
    OUTPUT(COUNT(final_uls(score>=ul_th_probable)),NAMED('Possible_Underlinks_Probable'));
    OUTPUT(COUNT(final_uls(score>=ul_th_questionable)),NAMED('Possible_Underlinks_Questionable'));
    OUTPUT(tb_uls_summ(),      NAMED('Possible_Underlinks_Summary'));
    OUTPUT(tb_uls_summ_maxid(),NAMED('Possible_Underlinks_Summary_MaxID'));
    OUTPUT(tb_uls_summ_altid(),NAMED('Possible_Underlinks_Summary_AltIDs'));
    //OUTPUT(tb_uls_dtl (),NAMED('Possible_Underlinks_Details'));
    //OUTPUT(samples(SORT(tb_uls_segs(),-score,seg,cnt)),NAMED('Possible_Underlinks_Segs_by_Score'));
    //OUTPUT(samples(SORT(tb_uls_segs(),seg,-score,cnt)),NAMED('Possible_Underlinks_Segs_by_Segment'));
    //OUTPUT(samples(SORT(final_uls,-score,proxid)),NAMED('Possible_Underlinks_Top_Scores'));
    //OUTPUT(PROJECT(TOPN(final_uls,100,-alt_proxids,proxid),TRANSFORM(ul_lo,SELF.ul_dtls:=LEFT.ul_dtls[..10],SELF:=LEFT)),NAMED('Possible_Underlinks_Top_Alt_ProxIDs'));
    //OUTPUT(samples(SORT(final_uls,-avg_score,proxid)),NAMED('Possible_Underlinks_Top_Avg_Scores'));
    //OUTPUT(samples(SORT(final_uls(score=8),proxid)),NAMED('Possible_Underlinks_Score_8'));
    //OUTPUT(samples(SORT(final_uls(score=6),proxid)),NAMED('Possible_Underlinks_Score_6'));
    //OUTPUT(samples(SORT(final_uls(score=5),proxid)),NAMED('Possible_Underlinks_Score_5'));
    //OUTPUT(samples(SORT(final_uls(score=4),proxid)),NAMED('Possible_Underlinks_Score_4'));
    //OUTPUT(samples(SORT(final_uls(score=2),proxid)),NAMED('Possible_Underlinks_Score_2'));
    OUTPUT(DISTRIBUTE(  final_uls(score>0),HASH32(proxid)),,            outfile_prefix+'underlinks_'                                +today+outfile_suffix,COMPRESSED,OVERWRITE);
    //PML Commenting out norm_dd since it's a dupe of the persist (though would hang around longer) but it's 800+Gb, not the biggest, but still large
    //OUTPUT(SORT(uls_norm_dd,proxid,ul_issue,ul_value,alt_proxid,LOCAL),,outfile_prefix+'underlinks_norm_dd_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls,-score,proxid)),,                     outfile_prefix+'underlinks_top_'                            +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls,-max_id_score,proxid)),,              outfile_prefix+'underlinks_top_max_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls,-alt_proxids,proxid)),,               outfile_prefix+'underlinks_top_alt_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls,-avg_score,proxid)),,                 outfile_prefix+'underlinks_top_avg_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score>1),cnt_recs,-score,proxid)),,   outfile_prefix+'underlinks_top_frag_'                       +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score>1),pct_pop ,-score,proxid)),,   outfile_prefix+'underlinks_top_thin_'                       +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score=8),proxid)),,                   outfile_prefix+'underlinks_score_8_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score=6),proxid)),,                   outfile_prefix+'underlinks_score_6_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score=4),proxid)),,                   outfile_prefix+'underlinks_score_4_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(samples(SORT(final_uls(score=2),proxid)),,                   outfile_prefix+'underlinks_score_2_'                        +today+outfile_suffix,COMPRESSED,OVERWRITE);
 
    default_compare_uls.compare_summary;
    default_compare_uls.compare_details;
    OUTPUT(default_compare_uls.compared_uls_norm,,                      outfile_prefix+'underlinks_comp_norm'   +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(default_compare_uls.compared_uls_denorm,,                    outfile_prefix+'underlinks_comp_denorm' +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE);
 
    default_aggregate_uls.aggregate_summary;
    OUTPUT(default_aggregate_uls.aggregated_uls,,                       outfile_prefix+'underlinks_agg_norm'    +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(default_aggregate_uls.tb_aggregated_summ,,                   outfile_prefix+'underlinks_agg_summ'    +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(default_aggregate_uls.tb_aggregated_summ,,                   outfile_prefix+'underlinks_agg_summ_csv'+ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE,CSV(HEADING(SINGLE),SEPARATOR(',')));
    OUTPUT(default_aggregate_uls.tb_aggregated_dtl,,                    outfile_prefix+'underlinks_agg_dtl'     +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE);
    OUTPUT(default_aggregate_uls.tb_aggregated_dtl,,                    outfile_prefix+'underlinks_agg_dtl_csv' +ul_compare_desc+'_'+today+outfile_suffix,COMPRESSED,OVERWRITE,CSV(HEADING(SINGLE),SEPARATOR(',')));
  );

  EXPORT out_underlink(STRING fn) := OUTPUT(final_uls(score>0)                     ,,IF(fn[1]='~',fn,'~'+fn),COMPRESSED,OVERWRITE);
  EXPORT out_ul_norm  (STRING fn) := OUTPUT(default_compare_uls.compared_uls_norm  ,,IF(fn[1]='~',fn,'~'+fn),COMPRESSED,OVERWRITE);
  EXPORT out_ul_denorm(STRING fn) := OUTPUT(default_compare_uls.compared_uls_denorm,,IF(fn[1]='~',fn,'~'+fn),COMPRESSED,OVERWRITE);
  EXPORT ul_samples(conditions, ver = '\'_\''+default_asOf, pfx = '\''+outfile_prefix+'underlinks\'' )
                                  := MACRO OUTPUT(samples(SORT(DATASET('~'+REGEXREPLACE('~',pfx,'')+ver,ul_lo,THOR)(#EXPAND(conditions)),proxid)),NAMED('ul_samples')); ENDMACRO;

  EXPORT underlink_stats          := DATASET([
       {default_rpt_ver, 'ANALYSIS' ,'UL'          ,1 ,9,'cnt_ul_risk_all_ids'            ,iwc(COUNT(final_uls(score>0)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,2 ,3,'cnt_ul_probable_ids'            ,iwc(COUNT(final_uls(score>=ul_th_probable)))                                          ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,3 ,5,'cnt_ul_questionable_ids'        ,iwc(COUNT(final_uls(score>=ul_th_questionable)))                                      ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,4 ,9,'cnt_ul_risk_high_ids'           ,iwc(COUNT(final_uls(score>15)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,5 ,9,'cnt_ul_risk_15_ids'             ,iwc(COUNT(final_uls(score=15)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,6 ,9,'cnt_ul_risk_14_ids'             ,iwc(COUNT(final_uls(score=14)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,7 ,9,'cnt_ul_risk_13_ids'             ,iwc(COUNT(final_uls(score=13)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,8 ,9,'cnt_ul_risk_12_ids'             ,iwc(COUNT(final_uls(score=12)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,9 ,9,'cnt_ul_risk_11_ids'             ,iwc(COUNT(final_uls(score=11)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,10,9,'cnt_ul_risk_10_ids'             ,iwc(COUNT(final_uls(score=10)))                                                       ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,11,9,'cnt_ul_risk_9_ids'              ,iwc(COUNT(final_uls(score=9)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,12,9,'cnt_ul_risk_8_ids'              ,iwc(COUNT(final_uls(score=8)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,13,9,'cnt_ul_risk_7_ids'              ,iwc(COUNT(final_uls(score=7)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,14,9,'cnt_ul_risk_6_ids'              ,iwc(COUNT(final_uls(score=6)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,15,9,'cnt_ul_risk_5_ids'              ,iwc(COUNT(final_uls(score=5)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,16,9,'cnt_ul_risk_4_ids'              ,iwc(COUNT(final_uls(score=4)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,17,9,'cnt_ul_risk_3_ids'              ,iwc(COUNT(final_uls(score=3)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,18,9,'cnt_ul_risk_2_ids'              ,iwc(COUNT(final_uls(score=2)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,19,9,'cnt_ul_risk_1_ids'              ,iwc(COUNT(final_uls(score=1)))                                                        ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,20,3,'cnt_ul_prob_alt_ids'            ,iwc(COUNT(final_uls(alt_proxids>=ul_th_probable)))                                    ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,21,5,'cnt_ul_quest_alt_ids'           ,iwc(COUNT(final_uls(alt_proxids>=ul_th_questionable)))                                ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,22,5,'cnt_ul_risk_high_alt_ids'       ,iwc(COUNT(final_uls(alt_proxids>15)))                                                 ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,23,3,'cnt_ul_prob_max_ids'            ,iwc(COUNT(final_uls(max_id_score>=ul_th_probable)))                                   ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,24,5,'cnt_ul_quest_max_ids'           ,iwc(COUNT(final_uls(max_id_score>=ul_th_questionable)))                               ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
      ,{default_rpt_ver, 'ANALYSIS' ,'UL'          ,25,5,'cnt_ul_risk_high_max_ids'       ,iwc(COUNT(final_uls(max_id_score>15)))                                                ,default_bld_ver,default_bld_wu,default_bld_user,default_rpt_wu,default_rpt_user}
  ], stats_file_lo);
 
 
  // ---------------------------------------------------------------------
  // Visualizations
  // ---------------------------------------------------------------------
/*
  SHARED VMI_c := PROJECT(all_field_stats(stat_name='cnt_1_val_mult_id'),              TRANSFORM({STRING10 field, UNSIGNED cnt}, SELF.field:=REGEXREPLACE('_VMI',LEFT.stat_subtype,''), SELF.cnt:=(UNSIGNED)REGEXREPLACE(',',LEFT.stat_value,'')));
  SHARED VMI_p := PROJECT(all_field_stats(stat_name='pct_1_val_mult_id_of_uniq_vals'), TRANSFORM({STRING10 field, REAL     pct}, SELF.field:=REGEXREPLACE('_VMI',LEFT.stat_subtype,''), SELF.pct:=(REAL)    LEFT.stat_value));
  SHARED IMV_c := PROJECT(all_field_stats(stat_name='cnt_1_id_mult_val'),              TRANSFORM({STRING10 field, UNSIGNED cnt}, SELF.field:=REGEXREPLACE('_IMV',LEFT.stat_subtype,''), SELF.cnt:=(UNSIGNED)REGEXREPLACE(',',LEFT.stat_value,'')));
  SHARED IMV_p := PROJECT(all_field_stats(stat_name='pct_1_id_mult_val_of_val_ids'),   TRANSFORM({STRING10 field, REAL     pct}, SELF.field:=REGEXREPLACE('_IMV',LEFT.stat_subtype,''), SELF.pct:=(REAL)    LEFT.stat_value));
 
  EXPORT all_visualizations       := ORDERED(
    OUTPUT('==================================================',NAMED('Visualizations'));
    OUTPUT(SORT(VMI_c,-cnt),NAMED('all_fields_VMI_by_cnt'));
    OUTPUT(SORT(VMI_p,-pct),NAMED('all_fields_VMI_by_pct'));
    OUTPUT(SORT(IMV_c,-cnt),NAMED('all_fields_IMV_by_cnt'));
    OUTPUT(SORT(IMV_p,-pct),NAMED('all_fields_IMV_by_pct'));
    Visualizer.MultiD.column(viz_prefix+'VMI_cnt',,'all_fields_VMI_by_cnt',,,viz_props('1_VAL_MULT_ID_cnt'));
    Visualizer.MultiD.column(viz_prefix+'VMI_pct',,'all_fields_VMI_by_pct',,,viz_props('1_VAL_MULT_ID_pct'));
    Visualizer.MultiD.column(viz_prefix+'IMV_cnt',,'all_fields_IMV_by_cnt',,,viz_props('1_ID_MULT_VAL_cnt'));
    Visualizer.MultiD.column(viz_prefix+'IMV_pct',,'all_fields_IMV_by_pct',,,viz_props('1_ID_MULT_VAL_pct'));
  );
 
  EXPORT viz_layout_all_vmi_cnt   := viz_layout('All_Fields_VMI_by_cnt', viz_prefix+'VMI_cnt', viz_startid+(COUNT(field_config)*4), 'field', viz_startid+(COUNT(field_config)*4)+2, 'cnt', 'cnt', 'hpcc10', COUNT(field_config)+1, 1) +',';
  EXPORT viz_layout_all_vmi_pct   := viz_layout('All_Fields_VMI_by_pct', viz_prefix+'VMI_pct', viz_startid+(COUNT(field_config)*4), 'field', viz_startid+(COUNT(field_config)*4)+2, 'pct', 'pct', 'hpcc10', COUNT(field_config)+1, 2) +',';
  EXPORT viz_layout_all_imv_cnt   := viz_layout('All_Fields_IMV_by_cnt', viz_prefix+'IMV_cnt', viz_startid+(COUNT(field_config)*4), 'field', viz_startid+(COUNT(field_config)*4)+2, 'cnt', 'cnt', 'hpcc10', COUNT(field_config)+1, 3) +',';
  EXPORT viz_layout_all_imv_pct   := viz_layout('All_Fields_IMV_by_pct', viz_prefix+'IMV_pct', viz_startid+(COUNT(field_config)*4), 'field', viz_startid+(COUNT(field_config)*4)+2, 'pct', 'pct', 'hpcc10', COUNT(field_config)+1, 4);
  EXPORT viz_layout_all           := all_field_viz_layouts + viz_layout_all_vmi_cnt + viz_layout_all_vmi_pct + viz_layout_all_imv_cnt + viz_layout_all_imv_pct;

//2020  EXPORT set_viz_properties       := STD.System.Workunit.SetWorkunitAppValue('HPCC-Visualizer', 'persist', viz_head + viz_layout_all + viz_foot, TRUE);
//*/


  // ---------------------------------------------------------------------
  // Executions
  // ---------------------------------------------------------------------
  EXPORT all_reports              := ORDERED(
    summary_report();
    all_field_reports;
    //overlink_report;
    underlink_report;
  );
 
  EXPORT all_stats                := summary_stats + all_field_stats + underlink_stats;
 
  EXPORT output_stats             := OUTPUT(all_stats,,stats_file_lf,COMPRESSED,OVERWRITE);
 
  EXPORT do_all                   := ORDERED(
    all_reports;
//2020    all_visualizations;
//2019    set_viz_properties;
    output_stats;
  );
 
END;
