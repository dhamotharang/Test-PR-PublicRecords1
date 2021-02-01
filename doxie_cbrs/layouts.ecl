IMPORT bankruptcyv2_services, bbb2, corp, corp2, corp2_services, dca, dnb, domains, doxie, doxie_cbrs, doxie_crs, 
  iesp, LiensV2_Services, Prof_LicenseV2, uccv2_services, VehicleV2_Services, watercraftV2_Services;
EXPORT layouts := MODULE
  
  EXPORT layout_base_rec := RECORD // doxie_cbrs.fn_getBaseRecs
    doxie_cbrs.Layout_BH;
    STRING60 msaDesc := '';
    STRING18 county_name := '';
    STRING120 company_clean := '';
    UNSIGNED2 name_source_id := 0;
    UNSIGNED2 addr_source_id := 0;
    UNSIGNED2 phone_source_id := 0;
    UNSIGNED2 fein_source_id := 0;
    UNSIGNED6 group_id := 0;
  END;
    
  EXPORT bankruptcy_record := RECORD (doxie.layout_bk_output) // doxie_cbrs.bankruptcy_records
    BOOLEAN SelfRepresented; // to match accurint
    BOOLEAN AssetsForUnsecured;
  END;

  EXPORT bankruptcy_slim_record := RECORD, MAXLENGTH(doxie_crs.maxlength_bk) // doxie_cbrs.bankruptcy_records_trimmed
    bankruptcy_record.court_name;
    bankruptcy_record.court_state;
    bankruptcy_record.court_code;
    bankruptcy_record.date_filed;
    bankruptcy_record.orig_filing_date;
    bankruptcy_record.record_type;
    bankruptcy_record.case_number;
    bankruptcy_record.orig_case_number;
    bankruptcy_record.attorney_name;
    bankruptcy_record.attorney_company;
    bankruptcy_record.attorney_address1;
    bankruptcy_record.attorney_address2;
    bankruptcy_record.attorney_city;
    bankruptcy_record.attorney_st;
    bankruptcy_record.attorney_zip;
    bankruptcy_record.attorney_zip4;
    bankruptcy_record.attorney2_name;
    bankruptcy_record.attorney2_company;
    bankruptcy_record.attorney2_address1;
    bankruptcy_record.attorney2_address2;
    bankruptcy_record.attorney2_city;
    bankruptcy_record.attorney2_st;
    bankruptcy_record.attorney2_zip;
    bankruptcy_record.attorney2_zip4;
    DATASET(doxie.layout_bk_child) debtor_records;
  END;

  EXPORT bankruptcy_slim_record_v2 := bankruptcyv2_services.layouts.layout_rollup; // doxie_cbrs.bankruptcy_records_trimmed_v2

  EXPORT bbb_member_record := RECORD
    bbb2.Layouts_Files.Base.Member - [global_sid, record_sid];
  END;
  
  EXPORT bbb_nonmember_record := RECORD
    bbb2.Layouts_Files.Base.NonMember - [global_sid, record_sid];
  END;
  
  EXPORT corporation_filings_record := RECORD, MAXLENGTH(100000) // doxie_cbrs.Corporation_Filings_records
    UNSIGNED1 level;
    Corp.Layout_Corp_Base;
    STRING25 corp_state_origin_decoded;
    STRING25 corp_inc_state_decoded;
    STRING25 corp_for_profit_ind_decoded;
    STRING25 corp_foreign_domestic_ind_decoded;
  END;

  EXPORT registered_agent_record := RECORD // doxie_cbrs.registered_agents_records
    corporation_filings_record.bdid;
    corporation_filings_record.corp_ra_name;
    corporation_filings_record.dt_last_seen;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    QSTRING5 zip;
    QSTRING4 zip4;
  END;

  EXPORT dnb_record := RECORD
    dnb.Layout_DNB_Base - [global_sid, record_sid]; // doxie_cbrs.dnb_records
    STRING15 structure_type_decoded;
    STRING30 type_of_establishment_decoded;
    STRING5 owns_rents_decoded;
  END;
  
  EXPORT foreclosure_record := RECORD
    iesp.foreclosure.t_ForeclosureReportRecord;
    BOOLEAN foreclosed;
  END;
  
  EXPORT internet_domains_record := RECORD // doxie_cbrs.Internet_Domains_records
    UNSIGNED1 level; //defined Level field as it is missing IN Domains.Layout_Whois_Base which is added to "WSR" IN doxie_cbrs.mac_RollStart
    domains.Layout_Whois_Base - [global_sid, record_sid];
    STRING8 update_date_decode;
    STRING8 expire_date_decode;
    STRING8 create_date_decode;
    STRING18 county_name := '';
    STRING18 admin_county_name := '';
    STRING18 tech_county_name := '';
  END;

  EXPORT internet_domains_slim_record := RECORD
    internet_domains_record.bdid;
    internet_domains_record.domain_name;
  END;
  
  EXPORT proflic_record := RECORD
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base - [global_sid, record_sid];
  END;

  EXPORT best_info_record := RECORD
    $.layout_best_info;
    UNSIGNED name_source_id;
    UNSIGNED addr_source_id;
    UNSIGNED phone_source_id;
  END;

  EXPORT upcr_record := RECORD // doxie_cbrs.ultimate_parent_information
    doxie_cbrs.layout_references;
    doxie_cbrs.layout_best_info; 
  END;

  EXPORT name_variation_record := RECORD  // doxie_cbrs.name_variations_base
    doxie_cbrs.Layout_BH.company_name;
    UNSIGNED2 name_source_id;
  END;

  EXPORT addr_variation_record := RECORD // doxie_cbrs.address_variations_base 
    doxie_cbrs.Layout_BH.prim_range;
    doxie_cbrs.Layout_BH.predir;
    doxie_cbrs.Layout_BH.prim_name;
    doxie_cbrs.Layout_BH.addr_suffix;
    doxie_cbrs.Layout_BH.sec_range;
    doxie_cbrs.Layout_BH.city;
    doxie_cbrs.Layout_BH.state;
    doxie_cbrs.Layout_BH.zip;
    STRING60 msaDesc := '';
    STRING18 county_name := '';
    doxie_cbrs.Layout_BH.msa;
    UNSIGNED2 addr_source_id := 0;
    doxie_cbrs.Layout_BH.dt_first_seen;
    doxie_cbrs.Layout_BH.dt_last_seen;
  END;

  EXPORT phone_variation_record := RECORD // doxie_cbrs.phone_variations_base
    doxie_cbrs.Layout_BH.phone;
    UNSIGNED2 phone_source_id := 0;
  END;

  SHARED dcarec := dca.Layout_DCA_Base_slim;

  EXPORT dca_slim_record := RECORD // doxie_cbrs.DCA_records_trimmed
    dcarec.level;
    dcarec.name;
    dcarec.prim_range;
    dcarec.predir;
    dcarec.prim_name;
    dcarec.addr_suffix;
    dcarec.postdir;
    dcarec.sec_range;
    dcarec.unit_desig;
    STRING25 city;
    STRING2 state;
    STRING5 zip;
    dcarec.zip4;
    dcarec.Province;
    dcarec.Country;
    dcarec.Phone;
    dcarec.bus_desc;
  END;

  EXPORT sales_record := RECORD // doxie_cbrs.sales_records_trimmed 
    dcarec.sales;
    dcarec.sales_desc;
    dcarec.name;
    dcarec.process_date;
    dcarec.earnings;
    dcarec.assets;
    dcarec.liabilities;
    dcarec.net_worth_;
  END;

  EXPORT industry_info_slim_record := RECORD // doxie_cbrs.industry_information_records_trimmed
    STRING4 sic_code;
    STRING97 sic_descriptions;
  END;

  recduns := RECORD
    DNB.Layout_DNB_Base.duns_number;
  END;
  recfeins := RECORD // doxie_cbrs.fn_getBaseRecs
    doxie_cbrs.Layout_BH.fein;
    UNSIGNED2 fein_source_id;
  END;
  kcbc := corp2.Key_Corp_Corpkey;
  recstateids := RECORD // doxie_cbrs.Corp_IDs_raw and doxie_cbrs.Corp_IDs_raw_v2
    kcbc.corp_orig_sos_charter_nbr;
    kcbc.corp_state_origin;
  END;

  EXPORT id_num_record := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
    DATASET(recduns) duns_numbers;
    DATASET(recfeins) feins;
    DATASET(recstateids) state_ids;
    DATASET(recstateids) state_ids_v2;
  END;

  jlrec := $.Layout_Liens_Judgments_raw;
  jl_slim_record := RECORD // doxie_cbrs.Liens_Judments_records 
    jlrec.court_desc;
    jlrec.plaintiff;
    jlrec.defname;
    jlrec.amount;
    jlrec.filing_date;
    jlrec.filingtype_desc;
    jlrec.casenumber;
    jlrec.book;
    jlrec.page;
    jlrec.release_date;
    jlrec.prim_range;
    jlrec.predir;
    jlrec.prim_name;
    jlrec.suffix;
    jlrec.postdir;
    jlrec.unit_desig;
    jlrec.sec_range;
    jlrec.p_city_name;
    jlrec.v_city_name;
    jlrec.state;
    jlrec.zip;
    jlrec.zip4;
    jlrec.cart;
    jlrec.cr_sort_sz;
    jlrec.lot;
    jlrec.lot_order;
    jlrec.dbpc;
    jlrec.chk_digit;
    jlrec.rec_type;
    jlrec.county;
    jlrec.geo_lat;
    jlrec.geo_long;
    jlrec.msa;
    jlrec.geo_blk;
    jlrec.geo_match;
    jlrec.err_stat;
    jlrec.county_name;
  END;

  uccs := uccv2_services.layout_legacy.super_rec;
  ucc_slim_record := RECORD // doxie_cbrs.UCC_Records
    uccs.debtor_name;
    uccs.secured_name;
    uccs.filing_date;
    uccs.filing_type_desc;
    uccs.filing_state;
    uccs.event_document_num;
  END;

  EXPORT lj_ucc_record_slim := RECORD, MAXLENGTH(doxie_crs.maxlength_report) // doxie_cbrs.Liens_Judgments_UCC_records_trimmed
    DATASET(jl_slim_record) Judgment_Liens;
    DATASET(ucc_slim_record) UCCS;
  END;
  EXPORT lj_ucc_record_slim_v2 := RECORD, MAXLENGTH(doxie_crs.maxlength_report) //doxie_cbrs.Liens_Judgments_UCC_records_trimmed_v2
    DATASET(LiensV2_Services.layout_lien_rollup) Judgment_Liens; // doxie_cbrs.Liens_Judments_records_v2 
    DATASET(uccv2_services.layout_ucc_rollup) UCCS; //  doxie_cbrs.UCC_Records_v2 -> UCCv2_services.fn_getUCC_tmsid -> uccv2_services.layout_ucc_rollup
  END;

  corpkeyrec := corp2.Key_Corp_corpkey;
  EXPORT profile_record := RECORD, MAXLENGTH(100000) // doxie_cbrs.profile_records
    corpkeyrec.bdid;
    corpkeyrec.corp_legal_name;
    corpkeyrec.corp_inc_date;
    corpkeyrec.corp_inc_state;
    corpkeyrec.corp_orig_sos_charter_nbr;
    corpkeyrec.corp_status_desc;
    corpkeyrec.corp_orig_org_structure_desc;
    corpkeyrec.corp_term_exist_desc;
    corpkeyrec.record_type;
    STRING10 record_date;
  END;

  EXPORT profile_record_v2 := corp2_services.layout_corp2_rollup; // doxie_cbrs.profile_records_v2
  
  EXPORT mvr_record := RECORD, MAXLENGTH(doxie_crs.maxlength_mv) // doxie_cbrs.Motor_Vehicle_Records_trimmed -> .. -> Doxie_Raw.Veh_Raw
    Doxie.Layout_VehicleSearch;
  END;

  EXPORT mvr_record_v2 := RECORD // doxie_cbrs.Motor_Vehicle_Records_trimmed_v2 -> .. -> VehicleV2_Services.Functions.GetVehicleReport
    VehicleV2_Services.Layout_Report;
  END;

  EXPORT watercraft_record := RECORD, MAXLENGTH(doxie_crs.maxlength_wc) // doxie_cbrs.Watercraft_Records_trimmed -> .. -> Doxie_Raw.AirCraft_Raw
    watercraftV2_Services.layouts.report_out;
  END; 

  EXPORT faa_record := RECORD, MAXLENGTH(doxie_crs.maxlength_ac) // doxie_cbrs.Aircraft_Records_trimmed
    doxie_crs.layout_Faa_Aircraft_records;
  END;

END;

