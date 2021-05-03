IMPORT Salt31;
EXPORT RawFile_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(RawFile_Layout_IP_Metadata)
    UNSIGNED1 ip_rng_beg_Invalid;
    UNSIGNED1 ip_rng_end_Invalid;
    UNSIGNED1 edge_country_Invalid;
    UNSIGNED1 edge_region_Invalid;
    UNSIGNED1 edge_city_Invalid;
    UNSIGNED1 edge_conn_speed_Invalid;
    UNSIGNED1 edge_metro_code_Invalid;
    UNSIGNED1 edge_latitude_Invalid;
    UNSIGNED1 edge_longitude_Invalid;
    UNSIGNED1 edge_postal_code_Invalid;
    UNSIGNED1 edge_country_code_Invalid;
    UNSIGNED1 edge_region_code_Invalid;
    UNSIGNED1 edge_city_code_Invalid;
    UNSIGNED1 edge_continent_code_Invalid;
    UNSIGNED1 edge_two_letter_country_Invalid;
    UNSIGNED1 edge_internal_code_Invalid;
    UNSIGNED1 edge_area_codes_Invalid;
    UNSIGNED1 edge_country_conf_Invalid;
    UNSIGNED1 edge_region_conf_Invalid;
    UNSIGNED1 edge_city_conf_Invalid;
    UNSIGNED1 edge_postal_conf_Invalid;
    UNSIGNED1 edge_gmt_offset_Invalid;
    UNSIGNED1 edge_in_dst_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 domain_name_Invalid;
    UNSIGNED1 isp_name_Invalid;
    UNSIGNED1 homebiz_TYPE_Invalid;
    UNSIGNED1 asn_Invalid;
    UNSIGNED1 asn_name_Invalid;
    UNSIGNED1 primary_lang_Invalid;
    UNSIGNED1 secondary_lang_Invalid;
    UNSIGNED1 proxy_TYPE_Invalid;
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
    UNSIGNED1 naics_code_Invalid;
    UNSIGNED1 cbsa_code_Invalid;
    UNSIGNED1 cbsa_title_Invalid;
    UNSIGNED1 cbsa_TYPE_Invalid;
    UNSIGNED1 csa_code_Invalid;
    UNSIGNED1 csa_title_Invalid;
    UNSIGNED1 md_code_Invalid;
    UNSIGNED1 md_title_Invalid;
    UNSIGNED1 organization_name_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RawFile_Layout_IP_Metadata)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(RawFile_Layout_IP_Metadata) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ip_rng_beg_Invalid := RawFile_Fields.InValid_ip_rng_beg((Salt31.StrType)le.ip_rng_beg);
    SELF.ip_rng_end_Invalid := RawFile_Fields.InValid_ip_rng_end((Salt31.StrType)le.ip_rng_end);
    SELF.edge_country_Invalid := RawFile_Fields.InValid_edge_country((Salt31.StrType)le.edge_country);
    SELF.edge_region_Invalid := RawFile_Fields.InValid_edge_region((Salt31.StrType)le.edge_region);
    SELF.edge_city_Invalid := RawFile_Fields.InValid_edge_city((Salt31.StrType)le.edge_city);
    SELF.edge_conn_speed_Invalid := RawFile_Fields.InValid_edge_conn_speed((Salt31.StrType)le.edge_conn_speed);
    SELF.edge_metro_code_Invalid := RawFile_Fields.InValid_edge_metro_code((Salt31.StrType)le.edge_metro_code);
    SELF.edge_latitude_Invalid := RawFile_Fields.InValid_edge_latitude((Salt31.StrType)le.edge_latitude);
    SELF.edge_longitude_Invalid := RawFile_Fields.InValid_edge_longitude((Salt31.StrType)le.edge_longitude);
    SELF.edge_postal_code_Invalid := RawFile_Fields.InValid_edge_postal_code((Salt31.StrType)le.edge_postal_code);
    SELF.edge_country_code_Invalid := RawFile_Fields.InValid_edge_country_code((Salt31.StrType)le.edge_country_code);
    SELF.edge_region_code_Invalid := RawFile_Fields.InValid_edge_region_code((Salt31.StrType)le.edge_region_code);
    SELF.edge_city_code_Invalid := RawFile_Fields.InValid_edge_city_code((Salt31.StrType)le.edge_city_code);
    SELF.edge_continent_code_Invalid := RawFile_Fields.InValid_edge_continent_code((Salt31.StrType)le.edge_continent_code);
    SELF.edge_two_letter_country_Invalid := RawFile_Fields.InValid_edge_two_letter_country((Salt31.StrType)le.edge_two_letter_country);
    SELF.edge_internal_code_Invalid := RawFile_Fields.InValid_edge_internal_code((Salt31.StrType)le.edge_internal_code);
    SELF.edge_area_codes_Invalid := RawFile_Fields.InValid_edge_area_codes((Salt31.StrType)le.edge_area_codes);
    SELF.edge_country_conf_Invalid := RawFile_Fields.InValid_edge_country_conf((Salt31.StrType)le.edge_country_conf);
    SELF.edge_region_conf_Invalid := RawFile_Fields.InValid_edge_region_conf((Salt31.StrType)le.edge_region_conf);
    SELF.edge_city_conf_Invalid := RawFile_Fields.InValid_edge_city_conf((Salt31.StrType)le.edge_city_conf);
    SELF.edge_postal_conf_Invalid := RawFile_Fields.InValid_edge_postal_conf((Salt31.StrType)le.edge_postal_conf);
    SELF.edge_gmt_offset_Invalid := RawFile_Fields.InValid_edge_gmt_offset((Salt31.StrType)le.edge_gmt_offset);
    SELF.edge_in_dst_Invalid := RawFile_Fields.InValid_edge_in_dst((Salt31.StrType)le.edge_in_dst);
    SELF.sic_code_Invalid := 0;//RawFile_Fields.InValid_sic_code((Salt31.StrType)le.sic_code);
    SELF.domain_name_Invalid := RawFile_Fields.InValid_domain_name((Salt31.StrType)le.domain_name);
    SELF.isp_name_Invalid := RawFile_Fields.InValid_isp_name((Salt31.StrType)le.isp_name);
    SELF.homebiz_TYPE_Invalid := RawFile_Fields.InValid_homebiz_TYPE((Salt31.StrType)le.homebiz_TYPE);
    SELF.asn_Invalid := RawFile_Fields.InValid_asn((Salt31.StrType)le.asn);
    SELF.asn_name_Invalid := RawFile_Fields.InValid_asn_name((Salt31.StrType)le.asn_name);
    SELF.primary_lang_Invalid := RawFile_Fields.InValid_primary_lang((Salt31.StrType)le.primary_lang);
    SELF.secondary_lang_Invalid := RawFile_Fields.InValid_secondary_lang((Salt31.StrType)le.secondary_lang);
    SELF.proxy_TYPE_Invalid := RawFile_Fields.InValid_proxy_TYPE((Salt31.StrType)le.proxy_TYPE);
    SELF.proxy_description_Invalid := RawFile_Fields.InValid_proxy_description((Salt31.StrType)le.proxy_description);
    SELF.is_an_isp_Invalid := RawFile_Fields.InValid_is_an_isp((Salt31.StrType)le.is_an_isp);
    SELF.company_name_Invalid := RawFile_Fields.InValid_company_name((Salt31.StrType)le.company_name);
    SELF.ranks_Invalid := RawFile_Fields.InValid_ranks((Salt31.StrType)le.ranks);
    SELF.households_Invalid := RawFile_Fields.InValid_households((Salt31.StrType)le.households);
    SELF.women_Invalid := RawFile_Fields.InValid_women((Salt31.StrType)le.women);
    SELF.w18_34_Invalid := RawFile_Fields.InValid_w18_34((Salt31.StrType)le.w18_34);
    SELF.w35_49_Invalid := RawFile_Fields.InValid_w35_49((Salt31.StrType)le.w35_49);
    SELF.men_Invalid := RawFile_Fields.InValid_men((Salt31.StrType)le.men);
    SELF.m18_34_Invalid := RawFile_Fields.InValid_m18_34((Salt31.StrType)le.m18_34);
    SELF.m35_49_Invalid := RawFile_Fields.InValid_m35_49((Salt31.StrType)le.m35_49);
    SELF.teens_Invalid := RawFile_Fields.InValid_teens((Salt31.StrType)le.teens);
    SELF.kids_Invalid := RawFile_Fields.InValid_kids((Salt31.StrType)le.kids);
    SELF.naics_code_Invalid := RawFile_Fields.InValid_naics_code((Salt31.StrType)le.naics_code);
    SELF.cbsa_code_Invalid := RawFile_Fields.InValid_cbsa_code((Salt31.StrType)le.cbsa_code);
    SELF.cbsa_title_Invalid := RawFile_Fields.InValid_cbsa_title((Salt31.StrType)le.cbsa_title);
    SELF.cbsa_TYPE_Invalid := RawFile_Fields.InValid_cbsa_TYPE((Salt31.StrType)le.cbsa_TYPE);
    SELF.csa_code_Invalid := RawFile_Fields.InValid_csa_code((Salt31.StrType)le.csa_code);
    SELF.csa_title_Invalid := RawFile_Fields.InValid_csa_title((Salt31.StrType)le.csa_title);
    SELF.md_code_Invalid := RawFile_Fields.InValid_md_code((Salt31.StrType)le.md_code);
    SELF.md_title_Invalid := RawFile_Fields.InValid_md_title((Salt31.StrType)le.md_title);
    SELF.organization_name_Invalid := RawFile_Fields.InValid_organization_name((Salt31.StrType)le.organization_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RawFile_Layout_IP_Metadata);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ip_rng_beg_Invalid << 0 ) + ( le.ip_rng_end_Invalid << 1 ) + ( le.edge_country_Invalid << 2 ) + ( le.edge_region_Invalid << 3 ) + ( le.edge_city_Invalid << 4 ) + ( le.edge_conn_speed_Invalid << 5 ) + ( le.edge_metro_code_Invalid << 6 ) + ( le.edge_latitude_Invalid << 7 ) + ( le.edge_longitude_Invalid << 8 ) + ( le.edge_postal_code_Invalid << 9 ) + ( le.edge_country_code_Invalid << 10 ) + ( le.edge_region_code_Invalid << 11 ) + ( le.edge_city_code_Invalid << 12 ) + ( le.edge_continent_code_Invalid << 13 ) + ( le.edge_two_letter_country_Invalid << 14 ) + ( le.edge_internal_code_Invalid << 15 ) + ( le.edge_area_codes_Invalid << 16 ) + ( le.edge_country_conf_Invalid << 17 ) + ( le.edge_region_conf_Invalid << 18 ) + ( le.edge_city_conf_Invalid << 19 ) + ( le.edge_postal_conf_Invalid << 20 ) + ( le.edge_gmt_offset_Invalid << 21 ) + ( le.edge_in_dst_Invalid << 22 ) + ( le.sic_code_Invalid << 23 ) + ( le.domain_name_Invalid << 24 ) + ( le.isp_name_Invalid << 25 ) + ( le.homebiz_TYPE_Invalid << 26 ) + ( le.asn_Invalid << 27 ) + ( le.asn_name_Invalid << 28 ) + ( le.primary_lang_Invalid << 29 ) + ( le.secondary_lang_Invalid << 30 ) + ( le.proxy_TYPE_Invalid << 31 ) + ( le.proxy_description_Invalid << 32 ) + ( le.is_an_isp_Invalid << 33 ) + ( le.company_name_Invalid << 34 ) + ( le.ranks_Invalid << 35 ) + ( le.households_Invalid << 36 ) + ( le.women_Invalid << 37 ) + ( le.w18_34_Invalid << 38 ) + ( le.w35_49_Invalid << 39 ) + ( le.men_Invalid << 40 ) + ( le.m18_34_Invalid << 41 ) + ( le.m35_49_Invalid << 42 ) + ( le.teens_Invalid << 43 ) + ( le.kids_Invalid << 44 ) + ( le.naics_code_Invalid << 45 ) + ( le.cbsa_code_Invalid << 46 ) + ( le.cbsa_title_Invalid << 47 ) + ( le.cbsa_TYPE_Invalid << 48 ) + ( le.csa_code_Invalid << 49 ) + ( le.csa_title_Invalid << 50 ) + ( le.md_code_Invalid << 51 ) + ( le.md_title_Invalid << 52 ) + ( le.organization_name_Invalid << 53 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RawFile_Layout_IP_Metadata);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ip_rng_beg_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ip_rng_end_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.edge_country_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.edge_region_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.edge_city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.edge_conn_speed_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.edge_metro_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.edge_latitude_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.edge_longitude_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.edge_postal_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.edge_country_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.edge_region_code_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.edge_city_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.edge_continent_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.edge_two_letter_country_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.edge_internal_code_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.edge_area_codes_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.edge_country_conf_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.edge_region_conf_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.edge_city_conf_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.edge_postal_conf_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.edge_gmt_offset_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.edge_in_dst_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.domain_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.isp_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.homebiz_TYPE_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.asn_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.asn_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.primary_lang_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.secondary_lang_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.proxy_TYPE_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.proxy_description_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.is_an_isp_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.ranks_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.households_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.women_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.w18_34_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.w35_49_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.men_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.m18_34_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.m35_49_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.teens_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.kids_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.naics_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.cbsa_code_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.cbsa_title_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.cbsa_TYPE_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.csa_code_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.csa_title_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.md_code_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.md_title_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.organization_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ip_rng_beg_ALLOW_ErrorCount := COUNT(GROUP,h.ip_rng_beg_Invalid=1);
    ip_rng_end_ALLOW_ErrorCount := COUNT(GROUP,h.ip_rng_end_Invalid=1);
    edge_country_ALLOW_ErrorCount := COUNT(GROUP,h.edge_country_Invalid=1);
    edge_region_ALLOW_ErrorCount := COUNT(GROUP,h.edge_region_Invalid=1);
    edge_city_ALLOW_ErrorCount := COUNT(GROUP,h.edge_city_Invalid=1);
    edge_conn_speed_ALLOW_ErrorCount := COUNT(GROUP,h.edge_conn_speed_Invalid=1);
    edge_metro_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_metro_code_Invalid=1);
    edge_latitude_ALLOW_ErrorCount := COUNT(GROUP,h.edge_latitude_Invalid=1);
    edge_longitude_ALLOW_ErrorCount := COUNT(GROUP,h.edge_longitude_Invalid=1);
    edge_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_postal_code_Invalid=1);
    edge_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_country_code_Invalid=1);
    edge_region_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_region_code_Invalid=1);
    edge_city_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_city_code_Invalid=1);
    edge_continent_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_continent_code_Invalid=1);
    edge_two_letter_country_ALLOW_ErrorCount := COUNT(GROUP,h.edge_two_letter_country_Invalid=1);
    edge_internal_code_ALLOW_ErrorCount := COUNT(GROUP,h.edge_internal_code_Invalid=1);
    edge_area_codes_ALLOW_ErrorCount := COUNT(GROUP,h.edge_area_codes_Invalid=1);
    edge_country_conf_ALLOW_ErrorCount := COUNT(GROUP,h.edge_country_conf_Invalid=1);
    edge_region_conf_ALLOW_ErrorCount := COUNT(GROUP,h.edge_region_conf_Invalid=1);
    edge_city_conf_ALLOW_ErrorCount := COUNT(GROUP,h.edge_city_conf_Invalid=1);
    edge_postal_conf_ALLOW_ErrorCount := COUNT(GROUP,h.edge_postal_conf_Invalid=1);
    edge_gmt_offset_ALLOW_ErrorCount := COUNT(GROUP,h.edge_gmt_offset_Invalid=1);
    edge_in_dst_ALLOW_ErrorCount := COUNT(GROUP,h.edge_in_dst_Invalid=1);
    sic_code_ALLOW_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    domain_name_ALLOW_ErrorCount := COUNT(GROUP,h.domain_name_Invalid=1);
    isp_name_ALLOW_ErrorCount := COUNT(GROUP,h.isp_name_Invalid=1);
    homebiz_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.homebiz_TYPE_Invalid=1);
    asn_ALLOW_ErrorCount := COUNT(GROUP,h.asn_Invalid=1);
    asn_name_ALLOW_ErrorCount := COUNT(GROUP,h.asn_name_Invalid=1);
    primary_lang_ALLOW_ErrorCount := COUNT(GROUP,h.primary_lang_Invalid=1);
    secondary_lang_ALLOW_ErrorCount := COUNT(GROUP,h.secondary_lang_Invalid=1);
    proxy_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.proxy_TYPE_Invalid=1);
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
    naics_code_ALLOW_ErrorCount := COUNT(GROUP,h.naics_code_Invalid=1);
    cbsa_code_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_code_Invalid=1);
    cbsa_title_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_title_Invalid=1);
    cbsa_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_TYPE_Invalid=1);
    csa_code_ALLOW_ErrorCount := COUNT(GROUP,h.csa_code_Invalid=1);
    csa_title_ALLOW_ErrorCount := COUNT(GROUP,h.csa_title_Invalid=1);
    md_code_ALLOW_ErrorCount := COUNT(GROUP,h.md_code_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ip_rng_beg_Invalid,le.ip_rng_end_Invalid,le.edge_country_Invalid,le.edge_region_Invalid,le.edge_city_Invalid,le.edge_conn_speed_Invalid,le.edge_metro_code_Invalid,le.edge_latitude_Invalid,le.edge_longitude_Invalid,le.edge_postal_code_Invalid,le.edge_country_code_Invalid,le.edge_region_code_Invalid,le.edge_city_code_Invalid,le.edge_continent_code_Invalid,le.edge_two_letter_country_Invalid,le.edge_internal_code_Invalid,le.edge_area_codes_Invalid,le.edge_country_conf_Invalid,le.edge_region_conf_Invalid,le.edge_city_conf_Invalid,le.edge_postal_conf_Invalid,le.edge_gmt_offset_Invalid,le.edge_in_dst_Invalid,le.sic_code_Invalid,le.domain_name_Invalid,le.isp_name_Invalid,le.homebiz_TYPE_Invalid,le.asn_Invalid,le.asn_name_Invalid,le.primary_lang_Invalid,le.secondary_lang_Invalid,le.proxy_TYPE_Invalid,le.proxy_description_Invalid,le.is_an_isp_Invalid,le.company_name_Invalid,le.ranks_Invalid,le.households_Invalid,le.women_Invalid,le.w18_34_Invalid,le.w35_49_Invalid,le.men_Invalid,le.m18_34_Invalid,le.m35_49_Invalid,le.teens_Invalid,le.kids_Invalid,le.naics_code_Invalid,le.cbsa_code_Invalid,le.cbsa_title_Invalid,le.cbsa_TYPE_Invalid,le.csa_code_Invalid,le.csa_title_Invalid,le.md_code_Invalid,le.md_title_Invalid,le.organization_name_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RawFile_Fields.InvalidMessage_ip_rng_beg(le.ip_rng_beg_Invalid),RawFile_Fields.InvalidMessage_ip_rng_end(le.ip_rng_end_Invalid),RawFile_Fields.InvalidMessage_edge_country(le.edge_country_Invalid),RawFile_Fields.InvalidMessage_edge_region(le.edge_region_Invalid),RawFile_Fields.InvalidMessage_edge_city(le.edge_city_Invalid),RawFile_Fields.InvalidMessage_edge_conn_speed(le.edge_conn_speed_Invalid),RawFile_Fields.InvalidMessage_edge_metro_code(le.edge_metro_code_Invalid),RawFile_Fields.InvalidMessage_edge_latitude(le.edge_latitude_Invalid),RawFile_Fields.InvalidMessage_edge_longitude(le.edge_longitude_Invalid),RawFile_Fields.InvalidMessage_edge_postal_code(le.edge_postal_code_Invalid),RawFile_Fields.InvalidMessage_edge_country_code(le.edge_country_code_Invalid),RawFile_Fields.InvalidMessage_edge_region_code(le.edge_region_code_Invalid),RawFile_Fields.InvalidMessage_edge_city_code(le.edge_city_code_Invalid),RawFile_Fields.InvalidMessage_edge_continent_code(le.edge_continent_code_Invalid),RawFile_Fields.InvalidMessage_edge_two_letter_country(le.edge_two_letter_country_Invalid),RawFile_Fields.InvalidMessage_edge_internal_code(le.edge_internal_code_Invalid),RawFile_Fields.InvalidMessage_edge_area_codes(le.edge_area_codes_Invalid),RawFile_Fields.InvalidMessage_edge_country_conf(le.edge_country_conf_Invalid),RawFile_Fields.InvalidMessage_edge_region_conf(le.edge_region_conf_Invalid),RawFile_Fields.InvalidMessage_edge_city_conf(le.edge_city_conf_Invalid),RawFile_Fields.InvalidMessage_edge_postal_conf(le.edge_postal_conf_Invalid),RawFile_Fields.InvalidMessage_edge_gmt_offset(le.edge_gmt_offset_Invalid),RawFile_Fields.InvalidMessage_edge_in_dst(le.edge_in_dst_Invalid),RawFile_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),RawFile_Fields.InvalidMessage_domain_name(le.domain_name_Invalid),RawFile_Fields.InvalidMessage_isp_name(le.isp_name_Invalid),RawFile_Fields.InvalidMessage_homebiz_TYPE(le.homebiz_TYPE_Invalid),RawFile_Fields.InvalidMessage_asn(le.asn_Invalid),RawFile_Fields.InvalidMessage_asn_name(le.asn_name_Invalid),RawFile_Fields.InvalidMessage_primary_lang(le.primary_lang_Invalid),RawFile_Fields.InvalidMessage_secondary_lang(le.secondary_lang_Invalid),RawFile_Fields.InvalidMessage_proxy_TYPE(le.proxy_TYPE_Invalid),RawFile_Fields.InvalidMessage_proxy_description(le.proxy_description_Invalid),RawFile_Fields.InvalidMessage_is_an_isp(le.is_an_isp_Invalid),RawFile_Fields.InvalidMessage_company_name(le.company_name_Invalid),RawFile_Fields.InvalidMessage_ranks(le.ranks_Invalid),RawFile_Fields.InvalidMessage_households(le.households_Invalid),RawFile_Fields.InvalidMessage_women(le.women_Invalid),RawFile_Fields.InvalidMessage_w18_34(le.w18_34_Invalid),RawFile_Fields.InvalidMessage_w35_49(le.w35_49_Invalid),RawFile_Fields.InvalidMessage_men(le.men_Invalid),RawFile_Fields.InvalidMessage_m18_34(le.m18_34_Invalid),RawFile_Fields.InvalidMessage_m35_49(le.m35_49_Invalid),RawFile_Fields.InvalidMessage_teens(le.teens_Invalid),RawFile_Fields.InvalidMessage_kids(le.kids_Invalid),RawFile_Fields.InvalidMessage_naics_code(le.naics_code_Invalid),RawFile_Fields.InvalidMessage_cbsa_code(le.cbsa_code_Invalid),RawFile_Fields.InvalidMessage_cbsa_title(le.cbsa_title_Invalid),RawFile_Fields.InvalidMessage_cbsa_TYPE(le.cbsa_TYPE_Invalid),RawFile_Fields.InvalidMessage_csa_code(le.csa_code_Invalid),RawFile_Fields.InvalidMessage_csa_title(le.csa_title_Invalid),RawFile_Fields.InvalidMessage_md_code(le.md_code_Invalid),RawFile_Fields.InvalidMessage_md_title(le.md_title_Invalid),RawFile_Fields.InvalidMessage_organization_name(le.organization_name_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ip_rng_beg_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ip_rng_end_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_conn_speed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_metro_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_region_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_city_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_continent_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_two_letter_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_internal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_area_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_country_conf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_region_conf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_city_conf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_postal_conf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_gmt_offset_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.edge_in_dst_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.domain_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.isp_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.homebiz_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asn_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_lang_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_lang_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxy_TYPE_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.naics_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cbsa_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cbsa_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cbsa_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.csa_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.csa_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.md_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.md_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.organization_name_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ip_rng_beg','ip_rng_end','edge_country','edge_region','edge_city','edge_conn_speed','edge_metro_code','edge_latitude','edge_longitude','edge_postal_code','edge_country_code','edge_region_code','edge_city_code','edge_continent_code','edge_two_letter_country','edge_internal_code','edge_area_codes','edge_country_conf','edge_region_conf','edge_city_conf','edge_postal_conf','edge_gmt_offset','edge_in_dst','sic_code','domain_name','isp_name','homebiz_TYPE','asn','asn_name','primary_lang','secondary_lang','proxy_TYPE','proxy_description','is_an_isp','company_name','ranks','households','women','w18_34','w35_49','men','m18_34','m35_49','teens','kids','naics_code','cbsa_code','cbsa_title','cbsa_TYPE','csa_code','csa_title','md_code','md_title','organization_name','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Int','Invalid_Num','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Char','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(Salt31.StrType)le.ip_rng_beg,(Salt31.StrType)le.ip_rng_end,(Salt31.StrType)le.edge_country,(Salt31.StrType)le.edge_region,(Salt31.StrType)le.edge_city,(Salt31.StrType)le.edge_conn_speed,(Salt31.StrType)le.edge_metro_code,(Salt31.StrType)le.edge_latitude,(Salt31.StrType)le.edge_longitude,(Salt31.StrType)le.edge_postal_code,(Salt31.StrType)le.edge_country_code,(Salt31.StrType)le.edge_region_code,(Salt31.StrType)le.edge_city_code,(Salt31.StrType)le.edge_continent_code,(Salt31.StrType)le.edge_two_letter_country,(Salt31.StrType)le.edge_internal_code,(Salt31.StrType)le.edge_area_codes,(Salt31.StrType)le.edge_country_conf,(Salt31.StrType)le.edge_region_conf,(Salt31.StrType)le.edge_city_conf,(Salt31.StrType)le.edge_postal_conf,(Salt31.StrType)le.edge_gmt_offset,(Salt31.StrType)le.edge_in_dst,/* (Salt31.StrType)le.sic_code, */(Salt31.StrType)le.domain_name,(Salt31.StrType)le.isp_name,(Salt31.StrType)le.homebiz_TYPE,(Salt31.StrType)le.asn,(Salt31.StrType)le.asn_name,(Salt31.StrType)le.primary_lang,(Salt31.StrType)le.secondary_lang,(Salt31.StrType)le.proxy_TYPE,(Salt31.StrType)le.proxy_description,(Salt31.StrType)le.is_an_isp,(Salt31.StrType)le.company_name,(Salt31.StrType)le.ranks,(Salt31.StrType)le.households,(Salt31.StrType)le.women,(Salt31.StrType)le.w18_34,(Salt31.StrType)le.w35_49,(Salt31.StrType)le.men,(Salt31.StrType)le.m18_34,(Salt31.StrType)le.m35_49,(Salt31.StrType)le.teens,(Salt31.StrType)le.kids,(Salt31.StrType)le.naics_code,(Salt31.StrType)le.cbsa_code,(Salt31.StrType)le.cbsa_title,(Salt31.StrType)le.cbsa_TYPE,(Salt31.StrType)le.csa_code,(Salt31.StrType)le.csa_title,(Salt31.StrType)le.md_code,(Salt31.StrType)le.md_title,(Salt31.StrType)le.organization_name,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,54,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    Salt31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ip_rng_beg:Invalid_Int:ALLOW'
          ,'ip_rng_end:Invalid_Int:ALLOW'
          ,'edge_country:Invalid_Char:ALLOW'
          ,'edge_region:Invalid_Char:ALLOW'
          ,'edge_city:Invalid_Char:ALLOW'
          ,'edge_conn_speed:Invalid_Char:ALLOW'
          ,'edge_metro_code:Invalid_Int:ALLOW'
          ,'edge_latitude:Invalid_Num:ALLOW'
          ,'edge_longitude:Invalid_Num:ALLOW'
          ,'edge_postal_code:Invalid_Char:ALLOW'
          ,'edge_country_code:Invalid_Int:ALLOW'
          ,'edge_region_code:Invalid_Int:ALLOW'
          ,'edge_city_code:Invalid_Int:ALLOW'
          ,'edge_continent_code:Invalid_Int:ALLOW'
          ,'edge_two_letter_country:Invalid_Char:ALLOW'
          ,'edge_internal_code:Invalid_Int:ALLOW'
          ,'edge_area_codes:Invalid_Num:ALLOW'
          ,'edge_country_conf:Invalid_Int:ALLOW'
          ,'edge_region_conf:Invalid_Int:ALLOW'
          ,'edge_city_conf:Invalid_Int:ALLOW'
          ,'edge_postal_conf:Invalid_Int:ALLOW'
          ,'edge_gmt_offset:Invalid_Num:ALLOW'
          ,'edge_in_dst:Invalid_Char:ALLOW'
          ,'sic_code:Invalid_Num:ALLOW'
          ,'domain_name:Invalid_Char:ALLOW'
          ,'isp_name:Invalid_Char:ALLOW'
          ,'homebiz_TYPE:Invalid_Char:ALLOW'
          ,'asn:Invalid_Int:ALLOW'
          ,'asn_name:Invalid_Char:ALLOW'
          ,'primary_lang:Invalid_Char:ALLOW'
          ,'secondary_lang:Invalid_Char:ALLOW'
          ,'proxy_TYPE:Invalid_Char:ALLOW'
          ,'proxy_description:Invalid_Char:ALLOW'
          ,'is_an_isp:Invalid_Char:ALLOW'
          ,'company_name:Invalid_Char:ALLOW'
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
          ,'naics_code:Invalid_Int:ALLOW'
          ,'cbsa_code:Invalid_Int:ALLOW'
          ,'cbsa_title:Invalid_Char:ALLOW'
          ,'cbsa_TYPE:Invalid_Char:ALLOW'
          ,'csa_code:Invalid_Int:ALLOW'
          ,'csa_title:Invalid_Char:ALLOW'
          ,'md_code:Invalid_Int:ALLOW'
          ,'md_title:Invalid_Char:ALLOW'
          ,'organization_name:Invalid_Char:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,RawFile_Fields.InvalidMessage_ip_rng_beg(1)
          ,RawFile_Fields.InvalidMessage_ip_rng_end(1)
          ,RawFile_Fields.InvalidMessage_edge_country(1)
          ,RawFile_Fields.InvalidMessage_edge_region(1)
          ,RawFile_Fields.InvalidMessage_edge_city(1)
          ,RawFile_Fields.InvalidMessage_edge_conn_speed(1)
          ,RawFile_Fields.InvalidMessage_edge_metro_code(1)
          ,RawFile_Fields.InvalidMessage_edge_latitude(1)
          ,RawFile_Fields.InvalidMessage_edge_longitude(1)
          ,RawFile_Fields.InvalidMessage_edge_postal_code(1)
          ,RawFile_Fields.InvalidMessage_edge_country_code(1)
          ,RawFile_Fields.InvalidMessage_edge_region_code(1)
          ,RawFile_Fields.InvalidMessage_edge_city_code(1)
          ,RawFile_Fields.InvalidMessage_edge_continent_code(1)
          ,RawFile_Fields.InvalidMessage_edge_two_letter_country(1)
          ,RawFile_Fields.InvalidMessage_edge_internal_code(1)
          ,RawFile_Fields.InvalidMessage_edge_area_codes(1)
          ,RawFile_Fields.InvalidMessage_edge_country_conf(1)
          ,RawFile_Fields.InvalidMessage_edge_region_conf(1)
          ,RawFile_Fields.InvalidMessage_edge_city_conf(1)
          ,RawFile_Fields.InvalidMessage_edge_postal_conf(1)
          ,RawFile_Fields.InvalidMessage_edge_gmt_offset(1)
          ,RawFile_Fields.InvalidMessage_edge_in_dst(1)
          ,RawFile_Fields.InvalidMessage_sic_code(1)
          ,RawFile_Fields.InvalidMessage_domain_name(1)
          ,RawFile_Fields.InvalidMessage_isp_name(1)
          ,RawFile_Fields.InvalidMessage_homebiz_TYPE(1)
          ,RawFile_Fields.InvalidMessage_asn(1)
          ,RawFile_Fields.InvalidMessage_asn_name(1)
          ,RawFile_Fields.InvalidMessage_primary_lang(1)
          ,RawFile_Fields.InvalidMessage_secondary_lang(1)
          ,RawFile_Fields.InvalidMessage_proxy_TYPE(1)
          ,RawFile_Fields.InvalidMessage_proxy_description(1)
          ,RawFile_Fields.InvalidMessage_is_an_isp(1)
          ,RawFile_Fields.InvalidMessage_company_name(1)
          ,RawFile_Fields.InvalidMessage_ranks(1)
          ,RawFile_Fields.InvalidMessage_households(1)
          ,RawFile_Fields.InvalidMessage_women(1)
          ,RawFile_Fields.InvalidMessage_w18_34(1)
          ,RawFile_Fields.InvalidMessage_w35_49(1)
          ,RawFile_Fields.InvalidMessage_men(1)
          ,RawFile_Fields.InvalidMessage_m18_34(1)
          ,RawFile_Fields.InvalidMessage_m35_49(1)
          ,RawFile_Fields.InvalidMessage_teens(1)
          ,RawFile_Fields.InvalidMessage_kids(1)
          ,RawFile_Fields.InvalidMessage_naics_code(1)
          ,RawFile_Fields.InvalidMessage_cbsa_code(1)
          ,RawFile_Fields.InvalidMessage_cbsa_title(1)
          ,RawFile_Fields.InvalidMessage_cbsa_TYPE(1)
          ,RawFile_Fields.InvalidMessage_csa_code(1)
          ,RawFile_Fields.InvalidMessage_csa_title(1)
          ,RawFile_Fields.InvalidMessage_md_code(1)
          ,RawFile_Fields.InvalidMessage_md_title(1)
          ,RawFile_Fields.InvalidMessage_organization_name(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ip_rng_beg_ALLOW_ErrorCount
          ,le.ip_rng_end_ALLOW_ErrorCount
          ,le.edge_country_ALLOW_ErrorCount
          ,le.edge_region_ALLOW_ErrorCount
          ,le.edge_city_ALLOW_ErrorCount
          ,le.edge_conn_speed_ALLOW_ErrorCount
          ,le.edge_metro_code_ALLOW_ErrorCount
          ,le.edge_latitude_ALLOW_ErrorCount
          ,le.edge_longitude_ALLOW_ErrorCount
          ,le.edge_postal_code_ALLOW_ErrorCount
          ,le.edge_country_code_ALLOW_ErrorCount
          ,le.edge_region_code_ALLOW_ErrorCount
          ,le.edge_city_code_ALLOW_ErrorCount
          ,le.edge_continent_code_ALLOW_ErrorCount
          ,le.edge_two_letter_country_ALLOW_ErrorCount
          ,le.edge_internal_code_ALLOW_ErrorCount
          ,le.edge_area_codes_ALLOW_ErrorCount
          ,le.edge_country_conf_ALLOW_ErrorCount
          ,le.edge_region_conf_ALLOW_ErrorCount
          ,le.edge_city_conf_ALLOW_ErrorCount
          ,le.edge_postal_conf_ALLOW_ErrorCount
          ,le.edge_gmt_offset_ALLOW_ErrorCount
          ,le.edge_in_dst_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.domain_name_ALLOW_ErrorCount
          ,le.isp_name_ALLOW_ErrorCount
          ,le.homebiz_TYPE_ALLOW_ErrorCount
          ,le.asn_ALLOW_ErrorCount
          ,le.asn_name_ALLOW_ErrorCount
          ,le.primary_lang_ALLOW_ErrorCount
          ,le.secondary_lang_ALLOW_ErrorCount
          ,le.proxy_TYPE_ALLOW_ErrorCount
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
          ,le.naics_code_ALLOW_ErrorCount
          ,le.cbsa_code_ALLOW_ErrorCount
          ,le.cbsa_title_ALLOW_ErrorCount
          ,le.cbsa_TYPE_ALLOW_ErrorCount
          ,le.csa_code_ALLOW_ErrorCount
          ,le.csa_title_ALLOW_ErrorCount
          ,le.md_code_ALLOW_ErrorCount
          ,le.md_title_ALLOW_ErrorCount
          ,le.organization_name_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ip_rng_beg_ALLOW_ErrorCount
          ,le.ip_rng_end_ALLOW_ErrorCount
          ,le.edge_country_ALLOW_ErrorCount
          ,le.edge_region_ALLOW_ErrorCount
          ,le.edge_city_ALLOW_ErrorCount
          ,le.edge_conn_speed_ALLOW_ErrorCount
          ,le.edge_metro_code_ALLOW_ErrorCount
          ,le.edge_latitude_ALLOW_ErrorCount
          ,le.edge_longitude_ALLOW_ErrorCount
          ,le.edge_postal_code_ALLOW_ErrorCount
          ,le.edge_country_code_ALLOW_ErrorCount
          ,le.edge_region_code_ALLOW_ErrorCount
          ,le.edge_city_code_ALLOW_ErrorCount
          ,le.edge_continent_code_ALLOW_ErrorCount
          ,le.edge_two_letter_country_ALLOW_ErrorCount
          ,le.edge_internal_code_ALLOW_ErrorCount
          ,le.edge_area_codes_ALLOW_ErrorCount
          ,le.edge_country_conf_ALLOW_ErrorCount
          ,le.edge_region_conf_ALLOW_ErrorCount
          ,le.edge_city_conf_ALLOW_ErrorCount
          ,le.edge_postal_conf_ALLOW_ErrorCount
          ,le.edge_gmt_offset_ALLOW_ErrorCount
          ,le.edge_in_dst_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.domain_name_ALLOW_ErrorCount
          ,le.isp_name_ALLOW_ErrorCount
          ,le.homebiz_TYPE_ALLOW_ErrorCount
          ,le.asn_ALLOW_ErrorCount
          ,le.asn_name_ALLOW_ErrorCount
          ,le.primary_lang_ALLOW_ErrorCount
          ,le.secondary_lang_ALLOW_ErrorCount
          ,le.proxy_TYPE_ALLOW_ErrorCount
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
          ,le.naics_code_ALLOW_ErrorCount
          ,le.cbsa_code_ALLOW_ErrorCount
          ,le.cbsa_title_ALLOW_ErrorCount
          ,le.cbsa_TYPE_ALLOW_ErrorCount
          ,le.csa_code_ALLOW_ErrorCount
          ,le.csa_title_ALLOW_ErrorCount
          ,le.md_code_ALLOW_ErrorCount
          ,le.md_title_ALLOW_ErrorCount
          ,le.organization_name_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,54,Into(LEFT,COUNTER));
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
