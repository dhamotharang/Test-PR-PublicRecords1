IMPORT Salt31;
EXPORT BaseFile_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BaseFile_Layout_IP_Metadata)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 beg_octet1_Invalid;
    UNSIGNED1 end_octet1_Invalid;
    UNSIGNED1 beg_octet2_Invalid;
    UNSIGNED1 end_octet2_Invalid;
    UNSIGNED1 beg_octets34_Invalid;
    UNSIGNED1 end_octets34_Invalid;
    UNSIGNED1 ip_rng_beg_Invalid;
    UNSIGNED1 ip_rng_end_Invalid;
    UNSIGNED1 edge_country_Invalid;
    UNSIGNED1 edge_region_Invalid;
    UNSIGNED1 edge_city_Invalid;
    UNSIGNED1 edge_conn_speed_Invalid;
    UNSIGNED1 edge_latitude_Invalid;
    UNSIGNED1 edge_longitude_Invalid;
    UNSIGNED1 edge_postal_code_Invalid;
    UNSIGNED1 edge_two_letter_country_Invalid;
    UNSIGNED1 edge_area_codes_Invalid;
    UNSIGNED1 edge_in_dst_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 domain_name_Invalid;
    UNSIGNED1 isp_name_Invalid;
    UNSIGNED1 homebiz_type_Invalid;
    UNSIGNED1 asn_name_Invalid;
    UNSIGNED1 primary_lang_Invalid;
    UNSIGNED1 secondary_lang_Invalid;
    UNSIGNED1 proxy_type_Invalid;
    UNSIGNED1 proxy_description_Invalid;
    UNSIGNED1 is_an_isp_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 ranks_Invalid;
    UNSIGNED1 households_Invalid;
    UNSIGNED1 women_Invalid;
    UNSIGNED1 w18_34_Invalid;
    UNSIGNED1 w35_49_Invalid;
    UNSIGNED1 men_Invalid;
    UNSIGNED1 m18_34_Invalid;
    UNSIGNED1 m35_49_Invalid;
    UNSIGNED1 teens_Invalid;
    UNSIGNED1 kids_Invalid;
    UNSIGNED1 cbsa_title_Invalid;
    UNSIGNED1 cbsa_type_Invalid;
    UNSIGNED1 md_title_Invalid;
    UNSIGNED1 organization_name_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseFile_Layout_IP_Metadata)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(BaseFile_Layout_IP_Metadata) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := BaseFile_Fields.InValid_dt_first_seen((Salt31.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := BaseFile_Fields.InValid_dt_last_seen((Salt31.StrType)le.dt_last_seen);
    SELF.beg_octet1_Invalid := BaseFile_Fields.InValid_beg_octet1((Salt31.StrType)le.beg_octet1);
    SELF.end_octet1_Invalid := BaseFile_Fields.InValid_end_octet1((Salt31.StrType)le.end_octet1);
    SELF.beg_octet2_Invalid := BaseFile_Fields.InValid_beg_octet2((Salt31.StrType)le.beg_octet2);
    SELF.end_octet2_Invalid := BaseFile_Fields.InValid_end_octet2((Salt31.StrType)le.end_octet2);
    SELF.beg_octets34_Invalid := BaseFile_Fields.InValid_beg_octets34((Salt31.StrType)le.beg_octets34);
    SELF.end_octets34_Invalid := BaseFile_Fields.InValid_end_octets34((Salt31.StrType)le.end_octets34);
    SELF.ip_rng_beg_Invalid := BaseFile_Fields.InValid_ip_rng_beg((Salt31.StrType)le.ip_rng_beg);
    SELF.ip_rng_end_Invalid := BaseFile_Fields.InValid_ip_rng_end((Salt31.StrType)le.ip_rng_end);
    SELF.edge_country_Invalid := BaseFile_Fields.InValid_edge_country((Salt31.StrType)le.edge_country);
    SELF.edge_region_Invalid := BaseFile_Fields.InValid_edge_region((Salt31.StrType)le.edge_region);
    SELF.edge_city_Invalid := BaseFile_Fields.InValid_edge_city((Salt31.StrType)le.edge_city);
    SELF.edge_conn_speed_Invalid := BaseFile_Fields.InValid_edge_conn_speed((Salt31.StrType)le.edge_conn_speed);
    SELF.edge_latitude_Invalid := BaseFile_Fields.InValid_edge_latitude((Salt31.StrType)le.edge_latitude);
    SELF.edge_longitude_Invalid := BaseFile_Fields.InValid_edge_longitude((Salt31.StrType)le.edge_longitude);
    SELF.edge_postal_code_Invalid := BaseFile_Fields.InValid_edge_postal_code((Salt31.StrType)le.edge_postal_code);
    SELF.edge_two_letter_country_Invalid := BaseFile_Fields.InValid_edge_two_letter_country((Salt31.StrType)le.edge_two_letter_country);
    SELF.edge_area_codes_Invalid := BaseFile_Fields.InValid_edge_area_codes((Salt31.StrType)le.edge_area_codes);
    SELF.edge_in_dst_Invalid := BaseFile_Fields.InValid_edge_in_dst((Salt31.StrType)le.edge_in_dst);
    SELF.sic_code_Invalid := BaseFile_Fields.InValid_sic_code((Salt31.StrType)le.sic_code);
    SELF.domain_name_Invalid := BaseFile_Fields.InValid_domain_name((Salt31.StrType)le.domain_name);
    SELF.isp_name_Invalid := BaseFile_Fields.InValid_isp_name((Salt31.StrType)le.isp_name);
    SELF.homebiz_type_Invalid := BaseFile_Fields.InValid_homebiz_type((Salt31.StrType)le.homebiz_type);
    SELF.asn_name_Invalid := BaseFile_Fields.InValid_asn_name((Salt31.StrType)le.asn_name);
    SELF.primary_lang_Invalid := BaseFile_Fields.InValid_primary_lang((Salt31.StrType)le.primary_lang);
    SELF.secondary_lang_Invalid := BaseFile_Fields.InValid_secondary_lang((Salt31.StrType)le.secondary_lang);
    SELF.proxy_type_Invalid := BaseFile_Fields.InValid_proxy_type((Salt31.StrType)le.proxy_type);
    SELF.proxy_description_Invalid := BaseFile_Fields.InValid_proxy_description((Salt31.StrType)le.proxy_description);
    SELF.is_an_isp_Invalid := BaseFile_Fields.InValid_is_an_isp((Salt31.StrType)le.is_an_isp);
    SELF.company_name_Invalid := BaseFile_Fields.InValid_company_name((Salt31.StrType)le.company_name);
    SELF.ranks_Invalid := BaseFile_Fields.InValid_ranks((Salt31.StrType)le.ranks);
    SELF.households_Invalid := BaseFile_Fields.InValid_households((Salt31.StrType)le.households);
    SELF.women_Invalid := BaseFile_Fields.InValid_women((Salt31.StrType)le.women);
    SELF.w18_34_Invalid := BaseFile_Fields.InValid_w18_34((Salt31.StrType)le.w18_34);
    SELF.w35_49_Invalid := BaseFile_Fields.InValid_w35_49((Salt31.StrType)le.w35_49);
    SELF.men_Invalid := BaseFile_Fields.InValid_men((Salt31.StrType)le.men);
    SELF.m18_34_Invalid := BaseFile_Fields.InValid_m18_34((Salt31.StrType)le.m18_34);
    SELF.m35_49_Invalid := BaseFile_Fields.InValid_m35_49((Salt31.StrType)le.m35_49);
    SELF.teens_Invalid := BaseFile_Fields.InValid_teens((Salt31.StrType)le.teens);
    SELF.kids_Invalid := BaseFile_Fields.InValid_kids((Salt31.StrType)le.kids);
    SELF.cbsa_title_Invalid := BaseFile_Fields.InValid_cbsa_title((Salt31.StrType)le.cbsa_title);
    SELF.cbsa_type_Invalid := BaseFile_Fields.InValid_cbsa_type((Salt31.StrType)le.cbsa_type);
    SELF.md_title_Invalid := BaseFile_Fields.InValid_md_title((Salt31.StrType)le.md_title);
    SELF.organization_name_Invalid := BaseFile_Fields.InValid_organization_name((Salt31.StrType)le.organization_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BaseFile_Layout_IP_Metadata);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.beg_octet1_Invalid << 2 ) + ( le.end_octet1_Invalid << 3 ) + ( le.beg_octet2_Invalid << 4 ) + ( le.end_octet2_Invalid << 5 ) + ( le.beg_octets34_Invalid << 6 ) + ( le.end_octets34_Invalid << 7 ) + ( le.ip_rng_beg_Invalid << 8 ) + ( le.ip_rng_end_Invalid << 9 ) + ( le.edge_country_Invalid << 10 ) + ( le.edge_region_Invalid << 11 ) + ( le.edge_city_Invalid << 12 ) + ( le.edge_conn_speed_Invalid << 13 ) + ( le.edge_latitude_Invalid << 14 ) + ( le.edge_longitude_Invalid << 15 ) + ( le.edge_postal_code_Invalid << 16 ) + ( le.edge_two_letter_country_Invalid << 17 ) + ( le.edge_area_codes_Invalid << 18 ) + ( le.edge_in_dst_Invalid << 19 ) + ( le.sic_code_Invalid << 20 ) + ( le.domain_name_Invalid << 21 ) + ( le.isp_name_Invalid << 22 ) + ( le.homebiz_type_Invalid << 23 ) + ( le.asn_name_Invalid << 24 ) + ( le.primary_lang_Invalid << 25 ) + ( le.secondary_lang_Invalid << 26 ) + ( le.proxy_type_Invalid << 27 ) + ( le.proxy_description_Invalid << 28 ) + ( le.is_an_isp_Invalid << 29 ) + ( le.company_name_Invalid << 30 ) + ( le.ranks_Invalid << 31 ) + ( le.households_Invalid << 32 ) + ( le.women_Invalid << 33 ) + ( le.w18_34_Invalid << 34 ) + ( le.w35_49_Invalid << 35 ) + ( le.men_Invalid << 36 ) + ( le.m18_34_Invalid << 37 ) + ( le.m35_49_Invalid << 38 ) + ( le.teens_Invalid << 39 ) + ( le.kids_Invalid << 40 ) + ( le.cbsa_title_Invalid << 41 ) + ( le.cbsa_type_Invalid << 42 ) + ( le.md_title_Invalid << 43 ) + ( le.organization_name_Invalid << 44 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BaseFile_Layout_IP_Metadata);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.beg_octet1_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.end_octet1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.beg_octet2_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.end_octet2_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.beg_octets34_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.end_octets34_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.ip_rng_beg_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ip_rng_end_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.edge_country_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.edge_region_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.edge_city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.edge_conn_speed_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.edge_latitude_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.edge_longitude_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.edge_postal_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.edge_two_letter_country_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.edge_area_codes_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.edge_in_dst_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.domain_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.isp_name_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.homebiz_type_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.asn_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.primary_lang_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.secondary_lang_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.proxy_type_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.proxy_description_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.is_an_isp_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.ranks_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.households_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.women_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.w18_34_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.w35_49_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.men_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.m18_34_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.m35_49_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.teens_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.kids_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.cbsa_title_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.cbsa_type_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.md_title_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.organization_name_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    beg_octet1_ALLOW_ErrorCount := COUNT(GROUP,h.beg_octet1_Invalid=1);
    end_octet1_ALLOW_ErrorCount := COUNT(GROUP,h.end_octet1_Invalid=1);
    beg_octet2_ALLOW_ErrorCount := COUNT(GROUP,h.beg_octet2_Invalid=1);
    end_octet2_ALLOW_ErrorCount := COUNT(GROUP,h.end_octet2_Invalid=1);
    beg_octets34_ALLOW_ErrorCount := COUNT(GROUP,h.beg_octets34_Invalid=1);
    end_octets34_ALLOW_ErrorCount := COUNT(GROUP,h.end_octets34_Invalid=1);
    ip_rng_beg_ALLOW_ErrorCount := COUNT(GROUP,h.ip_rng_beg_Invalid=1);
    ip_rng_end_ALLOW_ErrorCount := COUNT(GROUP,h.ip_rng_end_Invalid=1);
    edge_country_ALLOW_ErrorCount := COUNT(GROUP,h.edge_country_Invalid=1);
    edge_region_ALLOW_ErrorCount := COUNT(GROUP,h.edge_region_Invalid=1);
    edge_city_ALLOW_ErrorCount := COUNT(GROUP,h.edge_city_Invalid=1);
    edge_conn_speed_ALLOW_ErrorCount := COUNT(GROUP,h.edge_conn_speed_Invalid=1);
    edge_latitude_ALLOW_ErrorCount := COUNT(GROUP,h.edge_latitude_Invalid=1);
    edge_longitude_ALLOW_ErrorCount := COUNT(GROUP,h.edge_longitude_Invalid=1);
    edge_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_postal_code_Invalid=1);
    edge_two_letter_country_ALLOW_ErrorCount := COUNT(GROUP,h.edge_two_letter_country_Invalid=1);
    edge_area_codes_ALLOW_ErrorCount := COUNT(GROUP,h.edge_area_codes_Invalid=1);
    edge_in_dst_ALLOW_ErrorCount := COUNT(GROUP,h.edge_in_dst_Invalid=1);
    sic_code_ALLOW_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    domain_name_ALLOW_ErrorCount := COUNT(GROUP,h.domain_name_Invalid=1);
    isp_name_ALLOW_ErrorCount := COUNT(GROUP,h.isp_name_Invalid=1);
    homebiz_type_ALLOW_ErrorCount := COUNT(GROUP,h.homebiz_type_Invalid=1);
    asn_name_ALLOW_ErrorCount := COUNT(GROUP,h.asn_name_Invalid=1);
    primary_lang_ALLOW_ErrorCount := COUNT(GROUP,h.primary_lang_Invalid=1);
    secondary_lang_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_lang_Invalid=1);
    proxy_type_ALLOW_ErrorCount := COUNT(GROUP,h.proxy_type_Invalid=1);
    proxy_description_ALLOW_ErrorCount := COUNT(GROUP,h.proxy_description_Invalid=1);
    is_an_isp_ALLOW_ErrorCount := COUNT(GROUP,h.is_an_isp_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    ranks_ALLOW_ErrorCount := COUNT(GROUP,h.ranks_Invalid=1);
    households_ALLOW_ErrorCount := COUNT(GROUP,h.households_Invalid=1);
    women_ALLOW_ErrorCount := COUNT(GROUP,h.women_Invalid=1);
    w18_34_ALLOW_ErrorCount := COUNT(GROUP,h.w18_34_Invalid=1);
    w35_49_ALLOW_ErrorCount := COUNT(GROUP,h.w35_49_Invalid=1);
    men_ALLOW_ErrorCount := COUNT(GROUP,h.men_Invalid=1);
    m18_34_ALLOW_ErrorCount := COUNT(GROUP,h.m18_34_Invalid=1);
    m35_49_ALLOW_ErrorCount := COUNT(GROUP,h.m35_49_Invalid=1);
    teens_ALLOW_ErrorCount := COUNT(GROUP,h.teens_Invalid=1);
    kids_ALLOW_ErrorCount := COUNT(GROUP,h.kids_Invalid=1);
    cbsa_title_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_title_Invalid=1);
    cbsa_type_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_type_Invalid=1);
    md_title_ALLOW_ErrorCount := COUNT(GROUP,h.md_title_Invalid=1);
    organization_name_ALLOW_ErrorCount := COUNT(GROUP,h.organization_name_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    Salt31.StrType ErrorMessage;
    Salt31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.beg_octet1_Invalid,le.end_octet1_Invalid,le.beg_octet2_Invalid,le.end_octet2_Invalid,le.beg_octets34_Invalid,le.end_octets34_Invalid,le.ip_rng_beg_Invalid,le.ip_rng_end_Invalid,le.edge_country_Invalid,le.edge_region_Invalid,le.edge_city_Invalid,le.edge_conn_speed_Invalid,le.edge_latitude_Invalid,le.edge_longitude_Invalid,le.edge_postal_code_Invalid,le.edge_two_letter_country_Invalid,le.edge_area_codes_Invalid,le.edge_in_dst_Invalid,le.sic_code_Invalid,le.domain_name_Invalid,le.isp_name_Invalid,le.homebiz_type_Invalid,le.asn_name_Invalid,le.primary_lang_Invalid,le.secondary_lang_Invalid,le.proxy_type_Invalid,le.proxy_description_Invalid,le.is_an_isp_Invalid,le.company_name_Invalid,le.ranks_Invalid,le.households_Invalid,le.women_Invalid,le.w18_34_Invalid,le.w35_49_Invalid,le.men_Invalid,le.m18_34_Invalid,le.m35_49_Invalid,le.teens_Invalid,le.kids_Invalid,le.cbsa_title_Invalid,le.cbsa_type_Invalid,le.md_title_Invalid,le.organization_name_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseFile_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),BaseFile_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),BaseFile_Fields.InvalidMessage_beg_octet1(le.beg_octet1_Invalid),BaseFile_Fields.InvalidMessage_end_octet1(le.end_octet1_Invalid),BaseFile_Fields.InvalidMessage_beg_octet2(le.beg_octet2_Invalid),BaseFile_Fields.InvalidMessage_end_octet2(le.end_octet2_Invalid),BaseFile_Fields.InvalidMessage_beg_octets34(le.beg_octets34_Invalid),BaseFile_Fields.InvalidMessage_end_octets34(le.end_octets34_Invalid),BaseFile_Fields.InvalidMessage_ip_rng_beg(le.ip_rng_beg_Invalid),BaseFile_Fields.InvalidMessage_ip_rng_end(le.ip_rng_end_Invalid),BaseFile_Fields.InvalidMessage_edge_country(le.edge_country_Invalid),BaseFile_Fields.InvalidMessage_edge_region(le.edge_region_Invalid),BaseFile_Fields.InvalidMessage_edge_city(le.edge_city_Invalid),BaseFile_Fields.InvalidMessage_edge_conn_speed(le.edge_conn_speed_Invalid),BaseFile_Fields.InvalidMessage_edge_latitude(le.edge_latitude_Invalid),BaseFile_Fields.InvalidMessage_edge_longitude(le.edge_longitude_Invalid),BaseFile_Fields.InvalidMessage_edge_postal_code(le.edge_postal_code_Invalid),BaseFile_Fields.InvalidMessage_edge_two_letter_country(le.edge_two_letter_country_Invalid),BaseFile_Fields.InvalidMessage_edge_area_codes(le.edge_area_codes_Invalid),BaseFile_Fields.InvalidMessage_edge_in_dst(le.edge_in_dst_Invalid),BaseFile_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),BaseFile_Fields.InvalidMessage_domain_name(le.domain_name_Invalid),BaseFile_Fields.InvalidMessage_isp_name(le.isp_name_Invalid),BaseFile_Fields.InvalidMessage_homebiz_type(le.homebiz_type_Invalid),BaseFile_Fields.InvalidMessage_asn_name(le.asn_name_Invalid),BaseFile_Fields.InvalidMessage_primary_lang(le.primary_lang_Invalid),BaseFile_Fields.InvalidMessage_secondary_lang(le.secondary_lang_Invalid),BaseFile_Fields.InvalidMessage_proxy_type(le.proxy_type_Invalid),BaseFile_Fields.InvalidMessage_proxy_description(le.proxy_description_Invalid),BaseFile_Fields.InvalidMessage_is_an_isp(le.is_an_isp_Invalid),BaseFile_Fields.InvalidMessage_company_name(le.company_name_Invalid),BaseFile_Fields.InvalidMessage_ranks(le.ranks_Invalid),BaseFile_Fields.InvalidMessage_households(le.households_Invalid),BaseFile_Fields.InvalidMessage_women(le.women_Invalid),BaseFile_Fields.InvalidMessage_w18_34(le.w18_34_Invalid),BaseFile_Fields.InvalidMessage_w35_49(le.w35_49_Invalid),BaseFile_Fields.InvalidMessage_men(le.men_Invalid),BaseFile_Fields.InvalidMessage_m18_34(le.m18_34_Invalid),BaseFile_Fields.InvalidMessage_m35_49(le.m35_49_Invalid),BaseFile_Fields.InvalidMessage_teens(le.teens_Invalid),BaseFile_Fields.InvalidMessage_kids(le.kids_Invalid),BaseFile_Fields.InvalidMessage_cbsa_title(le.cbsa_title_Invalid),BaseFile_Fields.InvalidMessage_cbsa_type(le.cbsa_type_Invalid),BaseFile_Fields.InvalidMessage_md_title(le.md_title_Invalid),BaseFile_Fields.InvalidMessage_organization_name(le.organization_name_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.beg_octet1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.end_octet1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.beg_octet2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.end_octet2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.beg_octets34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.end_octets34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ip_rng_beg_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ip_rng_end_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_conn_speed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_two_letter_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_area_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_in_dst_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.domain_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.isp_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.homebiz_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asn_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_lang_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_lang_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxy_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxy_description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_an_isp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ranks_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.households_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.women_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.w18_34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.w35_49_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.men_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m18_34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m35_49_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.teens_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.kids_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cbsa_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cbsa_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.md_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.organization_name_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','beg_octet1','end_octet1','beg_octet2','end_octet2','beg_octets34','end_octets34','ip_rng_beg','ip_rng_end','edge_country','edge_region','edge_city','edge_conn_speed','edge_latitude','edge_longitude','edge_postal_code','edge_two_letter_country','edge_area_codes','edge_in_dst','sic_code','domain_name','isp_name','homebiz_type','asn_name','primary_lang','secondary_lang','proxy_type','proxy_description','is_an_isp','company_name','ranks','households','women','w18_34','w35_49','men','m18_34','m35_49','teens','kids','cbsa_title','cbsa_type','md_title','organization_name','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Num','Invalid_Num','Invalid_Alph','Invalid_AlphNum','Invalid_Alph','Invalid_AlphNum','Invalid_Num','Invalid_Num','Invalid_AlphNum','Invalid_Alph','Invalid_Num','Invalid_Alph','Invalid_Num','Invalid_AlphNum','Invalid_AlphNum','Invalid_Alph','Invalid_AlphNum','Invalid_Alph','Invalid_Alph','Invalid_Alph','Invalid_Alph','Invalid_Alph','Invalid_AlphNum','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Alph','Invalid_Alph','Invalid_Alph','Invalid_AlphNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(Salt31.StrType)le.dt_first_seen,(Salt31.StrType)le.dt_last_seen,(Salt31.StrType)le.beg_octet1,(Salt31.StrType)le.end_octet1,(Salt31.StrType)le.beg_octet2,(Salt31.StrType)le.end_octet2,(Salt31.StrType)le.beg_octets34,(Salt31.StrType)le.end_octets34,(Salt31.StrType)le.ip_rng_beg,(Salt31.StrType)le.ip_rng_end,(Salt31.StrType)le.edge_country,(Salt31.StrType)le.edge_region,(Salt31.StrType)le.edge_city,(Salt31.StrType)le.edge_conn_speed,(Salt31.StrType)le.edge_latitude,(Salt31.StrType)le.edge_longitude,(Salt31.StrType)le.edge_postal_code,(Salt31.StrType)le.edge_two_letter_country,(Salt31.StrType)le.edge_area_codes,(Salt31.StrType)le.edge_in_dst,(Salt31.StrType)le.sic_code,(Salt31.StrType)le.domain_name,(Salt31.StrType)le.isp_name,(Salt31.StrType)le.homebiz_type,(Salt31.StrType)le.asn_name,(Salt31.StrType)le.primary_lang,(Salt31.StrType)le.secondary_lang,(Salt31.StrType)le.proxy_type,(Salt31.StrType)le.proxy_description,(Salt31.StrType)le.is_an_isp,(Salt31.StrType)le.company_name,(Salt31.StrType)le.ranks,(Salt31.StrType)le.households,(Salt31.StrType)le.women,(Salt31.StrType)le.w18_34,(Salt31.StrType)le.w35_49,(Salt31.StrType)le.men,(Salt31.StrType)le.m18_34,(Salt31.StrType)le.m35_49,(Salt31.StrType)le.teens,(Salt31.StrType)le.kids,(Salt31.StrType)le.cbsa_title,(Salt31.StrType)le.cbsa_type,(Salt31.StrType)le.md_title,(Salt31.StrType)le.organization_name,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,45,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    Salt31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:Invalid_Int:ALLOW'
          ,'dt_last_seen:Invalid_Int:ALLOW'
          ,'beg_octet1:Invalid_Int:ALLOW'
          ,'end_octet1:Invalid_Int:ALLOW'
          ,'beg_octet2:Invalid_Int:ALLOW'
          ,'end_octet2:Invalid_Int:ALLOW'
          ,'beg_octets34:Invalid_Int:ALLOW'
          ,'end_octets34:Invalid_Int:ALLOW'
          ,'ip_rng_beg:Invalid_Num:ALLOW'
          ,'ip_rng_end:Invalid_Num:ALLOW'
          ,'edge_country:Invalid_Alph:ALLOW'
          ,'edge_region:Invalid_AlphNum:ALLOW'
          ,'edge_city:Invalid_Alph:ALLOW'
          ,'edge_conn_speed:Invalid_AlphNum:ALLOW'
          ,'edge_latitude:Invalid_Num:ALLOW'
          ,'edge_longitude:Invalid_Num:ALLOW'
          ,'edge_postal_code:Invalid_AlphNum:ALLOW'
          ,'edge_two_letter_country:Invalid_Alph:ALLOW'
          ,'edge_area_codes:Invalid_Num:ALLOW'
          ,'edge_in_dst:Invalid_Alph:ALLOW'
          ,'sic_code:Invalid_Num:ALLOW'
          ,'domain_name:Invalid_AlphNum:ALLOW'
          ,'isp_name:Invalid_AlphNum:ALLOW'
          ,'homebiz_type:Invalid_Alph:ALLOW'
          ,'asn_name:Invalid_AlphNum:ALLOW'
          ,'primary_lang:Invalid_Alph:ALLOW'
          ,'secondary_lang:Invalid_Alph:ALLOW'
          ,'proxy_type:Invalid_Alph:ALLOW'
          ,'proxy_description:Invalid_Alph:ALLOW'
          ,'is_an_isp:Invalid_Alph:ALLOW'
          ,'company_name:Invalid_AlphNum:ALLOW'
          ,'ranks:Invalid_Num:ALLOW'
          ,'households:Invalid_Num:ALLOW'
          ,'women:Invalid_Num:ALLOW'
          ,'w18_34:Invalid_Num:ALLOW'
          ,'w35_49:Invalid_Num:ALLOW'
          ,'men:Invalid_Num:ALLOW'
          ,'m18_34:Invalid_Num:ALLOW'
          ,'m35_49:Invalid_Num:ALLOW'
          ,'teens:Invalid_Num:ALLOW'
          ,'kids:Invalid_Num:ALLOW'
          ,'cbsa_title:Invalid_Alph:ALLOW'
          ,'cbsa_type:Invalid_Alph:ALLOW'
          ,'md_title:Invalid_Alph:ALLOW'
          ,'organization_name:Invalid_AlphNum:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BaseFile_Fields.InvalidMessage_dt_first_seen(1)
          ,BaseFile_Fields.InvalidMessage_dt_last_seen(1)
          ,BaseFile_Fields.InvalidMessage_beg_octet1(1)
          ,BaseFile_Fields.InvalidMessage_end_octet1(1)
          ,BaseFile_Fields.InvalidMessage_beg_octet2(1)
          ,BaseFile_Fields.InvalidMessage_end_octet2(1)
          ,BaseFile_Fields.InvalidMessage_beg_octets34(1)
          ,BaseFile_Fields.InvalidMessage_end_octets34(1)
          ,BaseFile_Fields.InvalidMessage_ip_rng_beg(1)
          ,BaseFile_Fields.InvalidMessage_ip_rng_end(1)
          ,BaseFile_Fields.InvalidMessage_edge_country(1)
          ,BaseFile_Fields.InvalidMessage_edge_region(1)
          ,BaseFile_Fields.InvalidMessage_edge_city(1)
          ,BaseFile_Fields.InvalidMessage_edge_conn_speed(1)
          ,BaseFile_Fields.InvalidMessage_edge_latitude(1)
          ,BaseFile_Fields.InvalidMessage_edge_longitude(1)
          ,BaseFile_Fields.InvalidMessage_edge_postal_code(1)
          ,BaseFile_Fields.InvalidMessage_edge_two_letter_country(1)
          ,BaseFile_Fields.InvalidMessage_edge_area_codes(1)
          ,BaseFile_Fields.InvalidMessage_edge_in_dst(1)
          ,BaseFile_Fields.InvalidMessage_sic_code(1)
          ,BaseFile_Fields.InvalidMessage_domain_name(1)
          ,BaseFile_Fields.InvalidMessage_isp_name(1)
          ,BaseFile_Fields.InvalidMessage_homebiz_type(1)
          ,BaseFile_Fields.InvalidMessage_asn_name(1)
          ,BaseFile_Fields.InvalidMessage_primary_lang(1)
          ,BaseFile_Fields.InvalidMessage_secondary_lang(1)
          ,BaseFile_Fields.InvalidMessage_proxy_type(1)
          ,BaseFile_Fields.InvalidMessage_proxy_description(1)
          ,BaseFile_Fields.InvalidMessage_is_an_isp(1)
          ,BaseFile_Fields.InvalidMessage_company_name(1)
          ,BaseFile_Fields.InvalidMessage_ranks(1)
          ,BaseFile_Fields.InvalidMessage_households(1)
          ,BaseFile_Fields.InvalidMessage_women(1)
          ,BaseFile_Fields.InvalidMessage_w18_34(1)
          ,BaseFile_Fields.InvalidMessage_w35_49(1)
          ,BaseFile_Fields.InvalidMessage_men(1)
          ,BaseFile_Fields.InvalidMessage_m18_34(1)
          ,BaseFile_Fields.InvalidMessage_m35_49(1)
          ,BaseFile_Fields.InvalidMessage_teens(1)
          ,BaseFile_Fields.InvalidMessage_kids(1)
          ,BaseFile_Fields.InvalidMessage_cbsa_title(1)
          ,BaseFile_Fields.InvalidMessage_cbsa_type(1)
          ,BaseFile_Fields.InvalidMessage_md_title(1)
          ,BaseFile_Fields.InvalidMessage_organization_name(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.beg_octet1_ALLOW_ErrorCount
          ,le.end_octet1_ALLOW_ErrorCount
          ,le.beg_octet2_ALLOW_ErrorCount
          ,le.end_octet2_ALLOW_ErrorCount
          ,le.beg_octets34_ALLOW_ErrorCount
          ,le.end_octets34_ALLOW_ErrorCount
          ,le.ip_rng_beg_ALLOW_ErrorCount
          ,le.ip_rng_end_ALLOW_ErrorCount
          ,le.edge_country_ALLOW_ErrorCount
          ,le.edge_region_ALLOW_ErrorCount
          ,le.edge_city_ALLOW_ErrorCount
          ,le.edge_conn_speed_ALLOW_ErrorCount
          ,le.edge_latitude_ALLOW_ErrorCount
          ,le.edge_longitude_ALLOW_ErrorCount
          ,le.edge_postal_code_ALLOW_ErrorCount
          ,le.edge_two_letter_country_ALLOW_ErrorCount
          ,le.edge_area_codes_ALLOW_ErrorCount
          ,le.edge_in_dst_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.domain_name_ALLOW_ErrorCount
          ,le.isp_name_ALLOW_ErrorCount
          ,le.homebiz_type_ALLOW_ErrorCount
          ,le.asn_name_ALLOW_ErrorCount
          ,le.primary_lang_ALLOW_ErrorCount
          ,le.secondary_lang_ALLOW_ErrorCount
          ,le.proxy_type_ALLOW_ErrorCount
          ,le.proxy_description_ALLOW_ErrorCount
          ,le.is_an_isp_ALLOW_ErrorCount
          ,le.company_name_ALLOW_ErrorCount
          ,le.ranks_ALLOW_ErrorCount
          ,le.households_ALLOW_ErrorCount
          ,le.women_ALLOW_ErrorCount
          ,le.w18_34_ALLOW_ErrorCount
          ,le.w35_49_ALLOW_ErrorCount
          ,le.men_ALLOW_ErrorCount
          ,le.m18_34_ALLOW_ErrorCount
          ,le.m35_49_ALLOW_ErrorCount
          ,le.teens_ALLOW_ErrorCount
          ,le.kids_ALLOW_ErrorCount
          ,le.cbsa_title_ALLOW_ErrorCount
          ,le.cbsa_type_ALLOW_ErrorCount
          ,le.md_title_ALLOW_ErrorCount
          ,le.organization_name_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.beg_octet1_ALLOW_ErrorCount
          ,le.end_octet1_ALLOW_ErrorCount
          ,le.beg_octet2_ALLOW_ErrorCount
          ,le.end_octet2_ALLOW_ErrorCount
          ,le.beg_octets34_ALLOW_ErrorCount
          ,le.end_octets34_ALLOW_ErrorCount
          ,le.ip_rng_beg_ALLOW_ErrorCount
          ,le.ip_rng_end_ALLOW_ErrorCount
          ,le.edge_country_ALLOW_ErrorCount
          ,le.edge_region_ALLOW_ErrorCount
          ,le.edge_city_ALLOW_ErrorCount
          ,le.edge_conn_speed_ALLOW_ErrorCount
          ,le.edge_latitude_ALLOW_ErrorCount
          ,le.edge_longitude_ALLOW_ErrorCount
          ,le.edge_postal_code_ALLOW_ErrorCount
          ,le.edge_two_letter_country_ALLOW_ErrorCount
          ,le.edge_area_codes_ALLOW_ErrorCount
          ,le.edge_in_dst_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.domain_name_ALLOW_ErrorCount
          ,le.isp_name_ALLOW_ErrorCount
          ,le.homebiz_type_ALLOW_ErrorCount
          ,le.asn_name_ALLOW_ErrorCount
          ,le.primary_lang_ALLOW_ErrorCount
          ,le.secondary_lang_ALLOW_ErrorCount
          ,le.proxy_type_ALLOW_ErrorCount
          ,le.proxy_description_ALLOW_ErrorCount
          ,le.is_an_isp_ALLOW_ErrorCount
          ,le.company_name_ALLOW_ErrorCount
          ,le.ranks_ALLOW_ErrorCount
          ,le.households_ALLOW_ErrorCount
          ,le.women_ALLOW_ErrorCount
          ,le.w18_34_ALLOW_ErrorCount
          ,le.w35_49_ALLOW_ErrorCount
          ,le.men_ALLOW_ErrorCount
          ,le.m18_34_ALLOW_ErrorCount
          ,le.m35_49_ALLOW_ErrorCount
          ,le.teens_ALLOW_ErrorCount
          ,le.kids_ALLOW_ErrorCount
          ,le.cbsa_title_ALLOW_ErrorCount
          ,le.cbsa_type_ALLOW_ErrorCount
          ,le.md_title_ALLOW_ErrorCount
          ,le.organization_name_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,45,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      Salt31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    Salt31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
