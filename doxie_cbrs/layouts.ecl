IMPORT bbb2, corp, dnb, domains, doxie, doxie_cbrs, iesp, Prof_LicenseV2;
EXPORT layouts := MODULE
  
  EXPORT bankruptcy_record := RECORD (doxie.layout_bk_output) // doxie_cbrs.bankruptcy_records
    BOOLEAN SelfRepresented; // to match accurint
    BOOLEAN AssetsForUnsecured;
  END;

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
  
  EXPORT proflic_record := RECORD
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base - [global_sid, record_sid];
  END;

END;

