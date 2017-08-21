IMPORT SALT36;
EXPORT RawFile_hygiene(dataset(RawFile_layout_IP_Metadata) h) := MODULE
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ip_rng_beg_pcnt := AVE(GROUP,IF(h.ip_rng_beg = (TYPEOF(h.ip_rng_beg))'',0,100));
    maxlength_ip_rng_beg := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_rng_beg)));
    avelength_ip_rng_beg := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_rng_beg)),h.ip_rng_beg<>(typeof(h.ip_rng_beg))'');
    populated_ip_rng_end_pcnt := AVE(GROUP,IF(h.ip_rng_end = (TYPEOF(h.ip_rng_end))'',0,100));
    maxlength_ip_rng_end := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_rng_end)));
    avelength_ip_rng_end := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_rng_end)),h.ip_rng_end<>(typeof(h.ip_rng_end))'');
    populated_edge_country_pcnt := AVE(GROUP,IF(h.edge_country = (TYPEOF(h.edge_country))'',0,100));
    maxlength_edge_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country)));
    avelength_edge_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country)),h.edge_country<>(typeof(h.edge_country))'');
    populated_edge_region_pcnt := AVE(GROUP,IF(h.edge_region = (TYPEOF(h.edge_region))'',0,100));
    maxlength_edge_region := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region)));
    avelength_edge_region := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region)),h.edge_region<>(typeof(h.edge_region))'');
    populated_edge_city_pcnt := AVE(GROUP,IF(h.edge_city = (TYPEOF(h.edge_city))'',0,100));
    maxlength_edge_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city)));
    avelength_edge_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city)),h.edge_city<>(typeof(h.edge_city))'');
    populated_edge_conn_speed_pcnt := AVE(GROUP,IF(h.edge_conn_speed = (TYPEOF(h.edge_conn_speed))'',0,100));
    maxlength_edge_conn_speed := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_conn_speed)));
    avelength_edge_conn_speed := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_conn_speed)),h.edge_conn_speed<>(typeof(h.edge_conn_speed))'');
    populated_edge_metro_code_pcnt := AVE(GROUP,IF(h.edge_metro_code = (TYPEOF(h.edge_metro_code))'',0,100));
    maxlength_edge_metro_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_metro_code)));
    avelength_edge_metro_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_metro_code)),h.edge_metro_code<>(typeof(h.edge_metro_code))'');
    populated_edge_latitude_pcnt := AVE(GROUP,IF(h.edge_latitude = (TYPEOF(h.edge_latitude))'',0,100));
    maxlength_edge_latitude := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_latitude)));
    avelength_edge_latitude := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_latitude)),h.edge_latitude<>(typeof(h.edge_latitude))'');
    populated_edge_longitude_pcnt := AVE(GROUP,IF(h.edge_longitude = (TYPEOF(h.edge_longitude))'',0,100));
    maxlength_edge_longitude := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_longitude)));
    avelength_edge_longitude := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_longitude)),h.edge_longitude<>(typeof(h.edge_longitude))'');
    populated_edge_postal_code_pcnt := AVE(GROUP,IF(h.edge_postal_code = (TYPEOF(h.edge_postal_code))'',0,100));
    maxlength_edge_postal_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_postal_code)));
    avelength_edge_postal_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_postal_code)),h.edge_postal_code<>(typeof(h.edge_postal_code))'');
    populated_edge_country_code_pcnt := AVE(GROUP,IF(h.edge_country_code = (TYPEOF(h.edge_country_code))'',0,100));
    maxlength_edge_country_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country_code)));
    avelength_edge_country_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country_code)),h.edge_country_code<>(typeof(h.edge_country_code))'');
    populated_edge_region_code_pcnt := AVE(GROUP,IF(h.edge_region_code = (TYPEOF(h.edge_region_code))'',0,100));
    maxlength_edge_region_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region_code)));
    avelength_edge_region_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region_code)),h.edge_region_code<>(typeof(h.edge_region_code))'');
    populated_edge_city_code_pcnt := AVE(GROUP,IF(h.edge_city_code = (TYPEOF(h.edge_city_code))'',0,100));
    maxlength_edge_city_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city_code)));
    avelength_edge_city_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city_code)),h.edge_city_code<>(typeof(h.edge_city_code))'');
    populated_edge_continent_code_pcnt := AVE(GROUP,IF(h.edge_continent_code = (TYPEOF(h.edge_continent_code))'',0,100));
    maxlength_edge_continent_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_continent_code)));
    avelength_edge_continent_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_continent_code)),h.edge_continent_code<>(typeof(h.edge_continent_code))'');
    populated_edge_two_letter_country_pcnt := AVE(GROUP,IF(h.edge_two_letter_country = (TYPEOF(h.edge_two_letter_country))'',0,100));
    maxlength_edge_two_letter_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_two_letter_country)));
    avelength_edge_two_letter_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_two_letter_country)),h.edge_two_letter_country<>(typeof(h.edge_two_letter_country))'');
    populated_edge_internal_code_pcnt := AVE(GROUP,IF(h.edge_internal_code = (TYPEOF(h.edge_internal_code))'',0,100));
    maxlength_edge_internal_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_internal_code)));
    avelength_edge_internal_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_internal_code)),h.edge_internal_code<>(typeof(h.edge_internal_code))'');
    populated_edge_area_codes_pcnt := AVE(GROUP,IF(h.edge_area_codes = (TYPEOF(h.edge_area_codes))'',0,100));
    maxlength_edge_area_codes := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_area_codes)));
    avelength_edge_area_codes := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_area_codes)),h.edge_area_codes<>(typeof(h.edge_area_codes))'');
    populated_edge_country_conf_pcnt := AVE(GROUP,IF(h.edge_country_conf = (TYPEOF(h.edge_country_conf))'',0,100));
    maxlength_edge_country_conf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country_conf)));
    avelength_edge_country_conf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_country_conf)),h.edge_country_conf<>(typeof(h.edge_country_conf))'');
    populated_edge_region_conf_pcnt := AVE(GROUP,IF(h.edge_region_conf = (TYPEOF(h.edge_region_conf))'',0,100));
    maxlength_edge_region_conf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region_conf)));
    avelength_edge_region_conf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_region_conf)),h.edge_region_conf<>(typeof(h.edge_region_conf))'');
    populated_edge_city_conf_pcnt := AVE(GROUP,IF(h.edge_city_conf = (TYPEOF(h.edge_city_conf))'',0,100));
    maxlength_edge_city_conf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city_conf)));
    avelength_edge_city_conf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_city_conf)),h.edge_city_conf<>(typeof(h.edge_city_conf))'');
    populated_edge_postal_conf_pcnt := AVE(GROUP,IF(h.edge_postal_conf = (TYPEOF(h.edge_postal_conf))'',0,100));
    maxlength_edge_postal_conf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_postal_conf)));
    avelength_edge_postal_conf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_postal_conf)),h.edge_postal_conf<>(typeof(h.edge_postal_conf))'');
    populated_edge_gmt_offset_pcnt := AVE(GROUP,IF(h.edge_gmt_offset = (TYPEOF(h.edge_gmt_offset))'',0,100));
    maxlength_edge_gmt_offset := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_gmt_offset)));
    avelength_edge_gmt_offset := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_gmt_offset)),h.edge_gmt_offset<>(typeof(h.edge_gmt_offset))'');
    populated_edge_in_dst_pcnt := AVE(GROUP,IF(h.edge_in_dst = (TYPEOF(h.edge_in_dst))'',0,100));
    maxlength_edge_in_dst := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_in_dst)));
    avelength_edge_in_dst := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.edge_in_dst)),h.edge_in_dst<>(typeof(h.edge_in_dst))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_domain_name_pcnt := AVE(GROUP,IF(h.domain_name = (TYPEOF(h.domain_name))'',0,100));
    maxlength_domain_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.domain_name)));
    avelength_domain_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.domain_name)),h.domain_name<>(typeof(h.domain_name))'');
    populated_isp_name_pcnt := AVE(GROUP,IF(h.isp_name = (TYPEOF(h.isp_name))'',0,100));
    maxlength_isp_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.isp_name)));
    avelength_isp_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.isp_name)),h.isp_name<>(typeof(h.isp_name))'');
    populated_homebiz_TYPE_pcnt := AVE(GROUP,IF(h.homebiz_TYPE = (TYPEOF(h.homebiz_TYPE))'',0,100));
    maxlength_homebiz_TYPE := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.homebiz_TYPE)));
    avelength_homebiz_TYPE := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.homebiz_TYPE)),h.homebiz_TYPE<>(typeof(h.homebiz_TYPE))'');
    populated_asn_pcnt := AVE(GROUP,IF(h.asn = (TYPEOF(h.asn))'',0,100));
    maxlength_asn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.asn)));
    avelength_asn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.asn)),h.asn<>(typeof(h.asn))'');
    populated_asn_name_pcnt := AVE(GROUP,IF(h.asn_name = (TYPEOF(h.asn_name))'',0,100));
    maxlength_asn_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.asn_name)));
    avelength_asn_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.asn_name)),h.asn_name<>(typeof(h.asn_name))'');
    populated_primary_lang_pcnt := AVE(GROUP,IF(h.primary_lang = (TYPEOF(h.primary_lang))'',0,100));
    maxlength_primary_lang := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_lang)));
    avelength_primary_lang := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_lang)),h.primary_lang<>(typeof(h.primary_lang))'');
    populated_secondary_lang_pcnt := AVE(GROUP,IF(h.secondary_lang = (TYPEOF(h.secondary_lang))'',0,100));
    maxlength_secondary_lang := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.secondary_lang)));
    avelength_secondary_lang := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.secondary_lang)),h.secondary_lang<>(typeof(h.secondary_lang))'');
    populated_proxy_TYPE_pcnt := AVE(GROUP,IF(h.proxy_TYPE = (TYPEOF(h.proxy_TYPE))'',0,100));
    maxlength_proxy_TYPE := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.proxy_TYPE)));
    avelength_proxy_TYPE := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.proxy_TYPE)),h.proxy_TYPE<>(typeof(h.proxy_TYPE))'');
    populated_proxy_description_pcnt := AVE(GROUP,IF(h.proxy_description = (TYPEOF(h.proxy_description))'',0,100));
    maxlength_proxy_description := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.proxy_description)));
    avelength_proxy_description := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.proxy_description)),h.proxy_description<>(typeof(h.proxy_description))'');
    populated_is_an_isp_pcnt := AVE(GROUP,IF(h.is_an_isp = (TYPEOF(h.is_an_isp))'',0,100));
    maxlength_is_an_isp := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_an_isp)));
    avelength_is_an_isp := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_an_isp)),h.is_an_isp<>(typeof(h.is_an_isp))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_ranks_pcnt := AVE(GROUP,IF(h.ranks = (TYPEOF(h.ranks))'',0,100));
    maxlength_ranks := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ranks)));
    avelength_ranks := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ranks)),h.ranks<>(typeof(h.ranks))'');
    populated_households_pcnt := AVE(GROUP,IF(h.households = (TYPEOF(h.households))'',0,100));
    maxlength_households := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.households)));
    avelength_households := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.households)),h.households<>(typeof(h.households))'');
    populated_women_pcnt := AVE(GROUP,IF(h.women = (TYPEOF(h.women))'',0,100));
    maxlength_women := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.women)));
    avelength_women := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.women)),h.women<>(typeof(h.women))'');
    populated_w18_34_pcnt := AVE(GROUP,IF(h.w18_34 = (TYPEOF(h.w18_34))'',0,100));
    maxlength_w18_34 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.w18_34)));
    avelength_w18_34 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.w18_34)),h.w18_34<>(typeof(h.w18_34))'');
    populated_w35_49_pcnt := AVE(GROUP,IF(h.w35_49 = (TYPEOF(h.w35_49))'',0,100));
    maxlength_w35_49 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.w35_49)));
    avelength_w35_49 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.w35_49)),h.w35_49<>(typeof(h.w35_49))'');
    populated_men_pcnt := AVE(GROUP,IF(h.men = (TYPEOF(h.men))'',0,100));
    maxlength_men := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.men)));
    avelength_men := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.men)),h.men<>(typeof(h.men))'');
    populated_m18_34_pcnt := AVE(GROUP,IF(h.m18_34 = (TYPEOF(h.m18_34))'',0,100));
    maxlength_m18_34 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.m18_34)));
    avelength_m18_34 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.m18_34)),h.m18_34<>(typeof(h.m18_34))'');
    populated_m35_49_pcnt := AVE(GROUP,IF(h.m35_49 = (TYPEOF(h.m35_49))'',0,100));
    maxlength_m35_49 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.m35_49)));
    avelength_m35_49 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.m35_49)),h.m35_49<>(typeof(h.m35_49))'');
    populated_teens_pcnt := AVE(GROUP,IF(h.teens = (TYPEOF(h.teens))'',0,100));
    maxlength_teens := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.teens)));
    avelength_teens := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.teens)),h.teens<>(typeof(h.teens))'');
    populated_kids_pcnt := AVE(GROUP,IF(h.kids = (TYPEOF(h.kids))'',0,100));
    maxlength_kids := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.kids)));
    avelength_kids := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.kids)),h.kids<>(typeof(h.kids))'');
    populated_naics_code_pcnt := AVE(GROUP,IF(h.naics_code = (TYPEOF(h.naics_code))'',0,100));
    maxlength_naics_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics_code)));
    avelength_naics_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics_code)),h.naics_code<>(typeof(h.naics_code))'');
    populated_cbsa_code_pcnt := AVE(GROUP,IF(h.cbsa_code = (TYPEOF(h.cbsa_code))'',0,100));
    maxlength_cbsa_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_code)));
    avelength_cbsa_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_code)),h.cbsa_code<>(typeof(h.cbsa_code))'');
    populated_cbsa_title_pcnt := AVE(GROUP,IF(h.cbsa_title = (TYPEOF(h.cbsa_title))'',0,100));
    maxlength_cbsa_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_title)));
    avelength_cbsa_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_title)),h.cbsa_title<>(typeof(h.cbsa_title))'');
    populated_cbsa_TYPE_pcnt := AVE(GROUP,IF(h.cbsa_TYPE = (TYPEOF(h.cbsa_TYPE))'',0,100));
    maxlength_cbsa_TYPE := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_TYPE)));
    avelength_cbsa_TYPE := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.cbsa_TYPE)),h.cbsa_TYPE<>(typeof(h.cbsa_TYPE))'');
    populated_csa_code_pcnt := AVE(GROUP,IF(h.csa_code = (TYPEOF(h.csa_code))'',0,100));
    maxlength_csa_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.csa_code)));
    avelength_csa_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.csa_code)),h.csa_code<>(typeof(h.csa_code))'');
    populated_csa_title_pcnt := AVE(GROUP,IF(h.csa_title = (TYPEOF(h.csa_title))'',0,100));
    maxlength_csa_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.csa_title)));
    avelength_csa_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.csa_title)),h.csa_title<>(typeof(h.csa_title))'');
    populated_md_code_pcnt := AVE(GROUP,IF(h.md_code = (TYPEOF(h.md_code))'',0,100));
    maxlength_md_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.md_code)));
    avelength_md_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.md_code)),h.md_code<>(typeof(h.md_code))'');
    populated_md_title_pcnt := AVE(GROUP,IF(h.md_title = (TYPEOF(h.md_title))'',0,100));
    maxlength_md_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.md_title)));
    avelength_md_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.md_title)),h.md_title<>(typeof(h.md_title))'');
    populated_organization_name_pcnt := AVE(GROUP,IF(h.organization_name = (TYPEOF(h.organization_name))'',0,100));
    maxlength_organization_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.organization_name)));
    avelength_organization_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.organization_name)),h.organization_name<>(typeof(h.organization_name))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ip_rng_beg_pcnt *   0.00 / 100 + T.Populated_ip_rng_end_pcnt *   0.00 / 100 + T.Populated_edge_country_pcnt *   0.00 / 100 + T.Populated_edge_region_pcnt *   0.00 / 100 + T.Populated_edge_city_pcnt *   0.00 / 100 + T.Populated_edge_conn_speed_pcnt *   0.00 / 100 + T.Populated_edge_metro_code_pcnt *   0.00 / 100 + T.Populated_edge_latitude_pcnt *   0.00 / 100 + T.Populated_edge_longitude_pcnt *   0.00 / 100 + T.Populated_edge_postal_code_pcnt *   0.00 / 100 + T.Populated_edge_country_code_pcnt *   0.00 / 100 + T.Populated_edge_region_code_pcnt *   0.00 / 100 + T.Populated_edge_city_code_pcnt *   0.00 / 100 + T.Populated_edge_continent_code_pcnt *   0.00 / 100 + T.Populated_edge_two_letter_country_pcnt *   0.00 / 100 + T.Populated_edge_internal_code_pcnt *   0.00 / 100 + T.Populated_edge_area_codes_pcnt *   0.00 / 100 + T.Populated_edge_country_conf_pcnt *   0.00 / 100 + T.Populated_edge_region_conf_pcnt *   0.00 / 100 + T.Populated_edge_city_conf_pcnt *   0.00 / 100 + T.Populated_edge_postal_conf_pcnt *   0.00 / 100 + T.Populated_edge_gmt_offset_pcnt *   0.00 / 100 + T.Populated_edge_in_dst_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_domain_name_pcnt *   0.00 / 100 + T.Populated_isp_name_pcnt *   0.00 / 100 + T.Populated_homebiz_TYPE_pcnt *   0.00 / 100 + T.Populated_asn_pcnt *   0.00 / 100 + T.Populated_asn_name_pcnt *   0.00 / 100 + T.Populated_primary_lang_pcnt *   0.00 / 100 + T.Populated_secondary_lang_pcnt *   0.00 / 100 + T.Populated_proxy_TYPE_pcnt *   0.00 / 100 + T.Populated_proxy_description_pcnt *   0.00 / 100 + T.Populated_is_an_isp_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_ranks_pcnt *   0.00 / 100 + T.Populated_households_pcnt *   0.00 / 100 + T.Populated_women_pcnt *   0.00 / 100 + T.Populated_w18_34_pcnt *   0.00 / 100 + T.Populated_w35_49_pcnt *   0.00 / 100 + T.Populated_men_pcnt *   0.00 / 100 + T.Populated_m18_34_pcnt *   0.00 / 100 + T.Populated_m35_49_pcnt *   0.00 / 100 + T.Populated_teens_pcnt *   0.00 / 100 + T.Populated_kids_pcnt *   0.00 / 100 + T.Populated_naics_code_pcnt *   0.00 / 100 + T.Populated_cbsa_code_pcnt *   0.00 / 100 + T.Populated_cbsa_title_pcnt *   0.00 / 100 + T.Populated_cbsa_TYPE_pcnt *   0.00 / 100 + T.Populated_csa_code_pcnt *   0.00 / 100 + T.Populated_csa_title_pcnt *   0.00 / 100 + T.Populated_md_code_pcnt *   0.00 / 100 + T.Populated_md_title_pcnt *   0.00 / 100 + T.Populated_organization_name_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ip_rng_beg','ip_rng_end','edge_country','edge_region','edge_city','edge_conn_speed','edge_metro_code','edge_latitude','edge_longitude','edge_postal_code','edge_country_code','edge_region_code','edge_city_code','edge_continent_code','edge_two_letter_country','edge_internal_code','edge_area_codes','edge_country_conf','edge_region_conf','edge_city_conf','edge_postal_conf','edge_gmt_offset','edge_in_dst','sic_code','domain_name','isp_name','homebiz_TYPE','asn','asn_name','primary_lang','secondary_lang','proxy_TYPE','proxy_description','is_an_isp','company_name','ranks','households','women','w18_34','w35_49','men','m18_34','m35_49','teens','kids','naics_code','cbsa_code','cbsa_title','cbsa_TYPE','csa_code','csa_title','md_code','md_title','organization_name');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ip_rng_beg_pcnt,le.populated_ip_rng_end_pcnt,le.populated_edge_country_pcnt,le.populated_edge_region_pcnt,le.populated_edge_city_pcnt,le.populated_edge_conn_speed_pcnt,le.populated_edge_metro_code_pcnt,le.populated_edge_latitude_pcnt,le.populated_edge_longitude_pcnt,le.populated_edge_postal_code_pcnt,le.populated_edge_country_code_pcnt,le.populated_edge_region_code_pcnt,le.populated_edge_city_code_pcnt,le.populated_edge_continent_code_pcnt,le.populated_edge_two_letter_country_pcnt,le.populated_edge_internal_code_pcnt,le.populated_edge_area_codes_pcnt,le.populated_edge_country_conf_pcnt,le.populated_edge_region_conf_pcnt,le.populated_edge_city_conf_pcnt,le.populated_edge_postal_conf_pcnt,le.populated_edge_gmt_offset_pcnt,le.populated_edge_in_dst_pcnt,le.populated_sic_code_pcnt,le.populated_domain_name_pcnt,le.populated_isp_name_pcnt,le.populated_homebiz_TYPE_pcnt,le.populated_asn_pcnt,le.populated_asn_name_pcnt,le.populated_primary_lang_pcnt,le.populated_secondary_lang_pcnt,le.populated_proxy_TYPE_pcnt,le.populated_proxy_description_pcnt,le.populated_is_an_isp_pcnt,le.populated_company_name_pcnt,le.populated_ranks_pcnt,le.populated_households_pcnt,le.populated_women_pcnt,le.populated_w18_34_pcnt,le.populated_w35_49_pcnt,le.populated_men_pcnt,le.populated_m18_34_pcnt,le.populated_m35_49_pcnt,le.populated_teens_pcnt,le.populated_kids_pcnt,le.populated_naics_code_pcnt,le.populated_cbsa_code_pcnt,le.populated_cbsa_title_pcnt,le.populated_cbsa_TYPE_pcnt,le.populated_csa_code_pcnt,le.populated_csa_title_pcnt,le.populated_md_code_pcnt,le.populated_md_title_pcnt,le.populated_organization_name_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ip_rng_beg,le.maxlength_ip_rng_end,le.maxlength_edge_country,le.maxlength_edge_region,le.maxlength_edge_city,le.maxlength_edge_conn_speed,le.maxlength_edge_metro_code,le.maxlength_edge_latitude,le.maxlength_edge_longitude,le.maxlength_edge_postal_code,le.maxlength_edge_country_code,le.maxlength_edge_region_code,le.maxlength_edge_city_code,le.maxlength_edge_continent_code,le.maxlength_edge_two_letter_country,le.maxlength_edge_internal_code,le.maxlength_edge_area_codes,le.maxlength_edge_country_conf,le.maxlength_edge_region_conf,le.maxlength_edge_city_conf,le.maxlength_edge_postal_conf,le.maxlength_edge_gmt_offset,le.maxlength_edge_in_dst,le.maxlength_sic_code,le.maxlength_domain_name,le.maxlength_isp_name,le.maxlength_homebiz_TYPE,le.maxlength_asn,le.maxlength_asn_name,le.maxlength_primary_lang,le.maxlength_secondary_lang,le.maxlength_proxy_TYPE,le.maxlength_proxy_description,le.maxlength_is_an_isp,le.maxlength_company_name,le.maxlength_ranks,le.maxlength_households,le.maxlength_women,le.maxlength_w18_34,le.maxlength_w35_49,le.maxlength_men,le.maxlength_m18_34,le.maxlength_m35_49,le.maxlength_teens,le.maxlength_kids,le.maxlength_naics_code,le.maxlength_cbsa_code,le.maxlength_cbsa_title,le.maxlength_cbsa_TYPE,le.maxlength_csa_code,le.maxlength_csa_title,le.maxlength_md_code,le.maxlength_md_title,le.maxlength_organization_name);
  SELF.avelength := CHOOSE(C,le.avelength_ip_rng_beg,le.avelength_ip_rng_end,le.avelength_edge_country,le.avelength_edge_region,le.avelength_edge_city,le.avelength_edge_conn_speed,le.avelength_edge_metro_code,le.avelength_edge_latitude,le.avelength_edge_longitude,le.avelength_edge_postal_code,le.avelength_edge_country_code,le.avelength_edge_region_code,le.avelength_edge_city_code,le.avelength_edge_continent_code,le.avelength_edge_two_letter_country,le.avelength_edge_internal_code,le.avelength_edge_area_codes,le.avelength_edge_country_conf,le.avelength_edge_region_conf,le.avelength_edge_city_conf,le.avelength_edge_postal_conf,le.avelength_edge_gmt_offset,le.avelength_edge_in_dst,le.avelength_sic_code,le.avelength_domain_name,le.avelength_isp_name,le.avelength_homebiz_TYPE,le.avelength_asn,le.avelength_asn_name,le.avelength_primary_lang,le.avelength_secondary_lang,le.avelength_proxy_TYPE,le.avelength_proxy_description,le.avelength_is_an_isp,le.avelength_company_name,le.avelength_ranks,le.avelength_households,le.avelength_women,le.avelength_w18_34,le.avelength_w35_49,le.avelength_men,le.avelength_m18_34,le.avelength_m35_49,le.avelength_teens,le.avelength_kids,le.avelength_naics_code,le.avelength_cbsa_code,le.avelength_cbsa_title,le.avelength_cbsa_TYPE,le.avelength_csa_code,le.avelength_csa_title,le.avelength_md_code,le.avelength_md_title,le.avelength_organization_name);
END;
EXPORT invSummary := NORMALIZE(summary0, 54, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.ip_rng_beg),TRIM((SALT36.StrType)le.ip_rng_end),TRIM((SALT36.StrType)le.edge_country),TRIM((SALT36.StrType)le.edge_region),TRIM((SALT36.StrType)le.edge_city),TRIM((SALT36.StrType)le.edge_conn_speed),IF (le.edge_metro_code <> 0,TRIM((SALT36.StrType)le.edge_metro_code), ''),TRIM((SALT36.StrType)le.edge_latitude),TRIM((SALT36.StrType)le.edge_longitude),TRIM((SALT36.StrType)le.edge_postal_code),IF (le.edge_country_code <> 0,TRIM((SALT36.StrType)le.edge_country_code), ''),IF (le.edge_region_code <> 0,TRIM((SALT36.StrType)le.edge_region_code), ''),IF (le.edge_city_code <> 0,TRIM((SALT36.StrType)le.edge_city_code), ''),IF (le.edge_continent_code <> 0,TRIM((SALT36.StrType)le.edge_continent_code), ''),TRIM((SALT36.StrType)le.edge_two_letter_country),IF (le.edge_internal_code <> 0,TRIM((SALT36.StrType)le.edge_internal_code), ''),TRIM((SALT36.StrType)le.edge_area_codes),IF (le.edge_country_conf <> 0,TRIM((SALT36.StrType)le.edge_country_conf), ''),IF (le.edge_region_conf <> 0,TRIM((SALT36.StrType)le.edge_region_conf), ''),IF (le.edge_city_conf <> 0,TRIM((SALT36.StrType)le.edge_city_conf), ''),IF (le.edge_postal_conf <> 0,TRIM((SALT36.StrType)le.edge_postal_conf), ''),IF (le.edge_gmt_offset <> 0,TRIM((SALT36.StrType)le.edge_gmt_offset), ''),TRIM((SALT36.StrType)le.edge_in_dst),TRIM((SALT36.StrType)le.sic_code),TRIM((SALT36.StrType)le.domain_name),TRIM((SALT36.StrType)le.isp_name),TRIM((SALT36.StrType)le.homebiz_TYPE),IF (le.asn <> 0,TRIM((SALT36.StrType)le.asn), ''),TRIM((SALT36.StrType)le.asn_name),TRIM((SALT36.StrType)le.primary_lang),TRIM((SALT36.StrType)le.secondary_lang),TRIM((SALT36.StrType)le.proxy_TYPE),TRIM((SALT36.StrType)le.proxy_description),TRIM((SALT36.StrType)le.is_an_isp),TRIM((SALT36.StrType)le.company_name),TRIM((SALT36.StrType)le.ranks),TRIM((SALT36.StrType)le.households),TRIM((SALT36.StrType)le.women),TRIM((SALT36.StrType)le.w18_34),TRIM((SALT36.StrType)le.w35_49),TRIM((SALT36.StrType)le.men),TRIM((SALT36.StrType)le.m18_34),TRIM((SALT36.StrType)le.m35_49),TRIM((SALT36.StrType)le.teens),TRIM((SALT36.StrType)le.kids),IF (le.naics_code <> 0,TRIM((SALT36.StrType)le.naics_code), ''),IF (le.cbsa_code <> 0,TRIM((SALT36.StrType)le.cbsa_code), ''),TRIM((SALT36.StrType)le.cbsa_title),TRIM((SALT36.StrType)le.cbsa_TYPE),IF (le.csa_code <> 0,TRIM((SALT36.StrType)le.csa_code), ''),TRIM((SALT36.StrType)le.csa_title),IF (le.md_code <> 0,TRIM((SALT36.StrType)le.md_code), ''),TRIM((SALT36.StrType)le.md_title),TRIM((SALT36.StrType)le.organization_name)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,54,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 54);
  SELF.FldNo2 := 1 + (C % 54);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.ip_rng_beg),TRIM((SALT36.StrType)le.ip_rng_end),TRIM((SALT36.StrType)le.edge_country),TRIM((SALT36.StrType)le.edge_region),TRIM((SALT36.StrType)le.edge_city),TRIM((SALT36.StrType)le.edge_conn_speed),IF (le.edge_metro_code <> 0,TRIM((SALT36.StrType)le.edge_metro_code), ''),TRIM((SALT36.StrType)le.edge_latitude),TRIM((SALT36.StrType)le.edge_longitude),TRIM((SALT36.StrType)le.edge_postal_code),IF (le.edge_country_code <> 0,TRIM((SALT36.StrType)le.edge_country_code), ''),IF (le.edge_region_code <> 0,TRIM((SALT36.StrType)le.edge_region_code), ''),IF (le.edge_city_code <> 0,TRIM((SALT36.StrType)le.edge_city_code), ''),IF (le.edge_continent_code <> 0,TRIM((SALT36.StrType)le.edge_continent_code), ''),TRIM((SALT36.StrType)le.edge_two_letter_country),IF (le.edge_internal_code <> 0,TRIM((SALT36.StrType)le.edge_internal_code), ''),TRIM((SALT36.StrType)le.edge_area_codes),IF (le.edge_country_conf <> 0,TRIM((SALT36.StrType)le.edge_country_conf), ''),IF (le.edge_region_conf <> 0,TRIM((SALT36.StrType)le.edge_region_conf), ''),IF (le.edge_city_conf <> 0,TRIM((SALT36.StrType)le.edge_city_conf), ''),IF (le.edge_postal_conf <> 0,TRIM((SALT36.StrType)le.edge_postal_conf), ''),IF (le.edge_gmt_offset <> 0,TRIM((SALT36.StrType)le.edge_gmt_offset), ''),TRIM((SALT36.StrType)le.edge_in_dst),TRIM((SALT36.StrType)le.sic_code),TRIM((SALT36.StrType)le.domain_name),TRIM((SALT36.StrType)le.isp_name),TRIM((SALT36.StrType)le.homebiz_TYPE),IF (le.asn <> 0,TRIM((SALT36.StrType)le.asn), ''),TRIM((SALT36.StrType)le.asn_name),TRIM((SALT36.StrType)le.primary_lang),TRIM((SALT36.StrType)le.secondary_lang),TRIM((SALT36.StrType)le.proxy_TYPE),TRIM((SALT36.StrType)le.proxy_description),TRIM((SALT36.StrType)le.is_an_isp),TRIM((SALT36.StrType)le.company_name),TRIM((SALT36.StrType)le.ranks),TRIM((SALT36.StrType)le.households),TRIM((SALT36.StrType)le.women),TRIM((SALT36.StrType)le.w18_34),TRIM((SALT36.StrType)le.w35_49),TRIM((SALT36.StrType)le.men),TRIM((SALT36.StrType)le.m18_34),TRIM((SALT36.StrType)le.m35_49),TRIM((SALT36.StrType)le.teens),TRIM((SALT36.StrType)le.kids),IF (le.naics_code <> 0,TRIM((SALT36.StrType)le.naics_code), ''),IF (le.cbsa_code <> 0,TRIM((SALT36.StrType)le.cbsa_code), ''),TRIM((SALT36.StrType)le.cbsa_title),TRIM((SALT36.StrType)le.cbsa_TYPE),IF (le.csa_code <> 0,TRIM((SALT36.StrType)le.csa_code), ''),TRIM((SALT36.StrType)le.csa_title),IF (le.md_code <> 0,TRIM((SALT36.StrType)le.md_code), ''),TRIM((SALT36.StrType)le.md_title),TRIM((SALT36.StrType)le.organization_name)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.ip_rng_beg),TRIM((SALT36.StrType)le.ip_rng_end),TRIM((SALT36.StrType)le.edge_country),TRIM((SALT36.StrType)le.edge_region),TRIM((SALT36.StrType)le.edge_city),TRIM((SALT36.StrType)le.edge_conn_speed),IF (le.edge_metro_code <> 0,TRIM((SALT36.StrType)le.edge_metro_code), ''),TRIM((SALT36.StrType)le.edge_latitude),TRIM((SALT36.StrType)le.edge_longitude),TRIM((SALT36.StrType)le.edge_postal_code),IF (le.edge_country_code <> 0,TRIM((SALT36.StrType)le.edge_country_code), ''),IF (le.edge_region_code <> 0,TRIM((SALT36.StrType)le.edge_region_code), ''),IF (le.edge_city_code <> 0,TRIM((SALT36.StrType)le.edge_city_code), ''),IF (le.edge_continent_code <> 0,TRIM((SALT36.StrType)le.edge_continent_code), ''),TRIM((SALT36.StrType)le.edge_two_letter_country),IF (le.edge_internal_code <> 0,TRIM((SALT36.StrType)le.edge_internal_code), ''),TRIM((SALT36.StrType)le.edge_area_codes),IF (le.edge_country_conf <> 0,TRIM((SALT36.StrType)le.edge_country_conf), ''),IF (le.edge_region_conf <> 0,TRIM((SALT36.StrType)le.edge_region_conf), ''),IF (le.edge_city_conf <> 0,TRIM((SALT36.StrType)le.edge_city_conf), ''),IF (le.edge_postal_conf <> 0,TRIM((SALT36.StrType)le.edge_postal_conf), ''),IF (le.edge_gmt_offset <> 0,TRIM((SALT36.StrType)le.edge_gmt_offset), ''),TRIM((SALT36.StrType)le.edge_in_dst),TRIM((SALT36.StrType)le.sic_code),TRIM((SALT36.StrType)le.domain_name),TRIM((SALT36.StrType)le.isp_name),TRIM((SALT36.StrType)le.homebiz_TYPE),IF (le.asn <> 0,TRIM((SALT36.StrType)le.asn), ''),TRIM((SALT36.StrType)le.asn_name),TRIM((SALT36.StrType)le.primary_lang),TRIM((SALT36.StrType)le.secondary_lang),TRIM((SALT36.StrType)le.proxy_TYPE),TRIM((SALT36.StrType)le.proxy_description),TRIM((SALT36.StrType)le.is_an_isp),TRIM((SALT36.StrType)le.company_name),TRIM((SALT36.StrType)le.ranks),TRIM((SALT36.StrType)le.households),TRIM((SALT36.StrType)le.women),TRIM((SALT36.StrType)le.w18_34),TRIM((SALT36.StrType)le.w35_49),TRIM((SALT36.StrType)le.men),TRIM((SALT36.StrType)le.m18_34),TRIM((SALT36.StrType)le.m35_49),TRIM((SALT36.StrType)le.teens),TRIM((SALT36.StrType)le.kids),IF (le.naics_code <> 0,TRIM((SALT36.StrType)le.naics_code), ''),IF (le.cbsa_code <> 0,TRIM((SALT36.StrType)le.cbsa_code), ''),TRIM((SALT36.StrType)le.cbsa_title),TRIM((SALT36.StrType)le.cbsa_TYPE),IF (le.csa_code <> 0,TRIM((SALT36.StrType)le.csa_code), ''),TRIM((SALT36.StrType)le.csa_title),IF (le.md_code <> 0,TRIM((SALT36.StrType)le.md_code), ''),TRIM((SALT36.StrType)le.md_title),TRIM((SALT36.StrType)le.organization_name)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),54*54,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ip_rng_beg'}
      ,{2,'ip_rng_end'}
      ,{3,'edge_country'}
      ,{4,'edge_region'}
      ,{5,'edge_city'}
      ,{6,'edge_conn_speed'}
      ,{7,'edge_metro_code'}
      ,{8,'edge_latitude'}
      ,{9,'edge_longitude'}
      ,{10,'edge_postal_code'}
      ,{11,'edge_country_code'}
      ,{12,'edge_region_code'}
      ,{13,'edge_city_code'}
      ,{14,'edge_continent_code'}
      ,{15,'edge_two_letter_country'}
      ,{16,'edge_internal_code'}
      ,{17,'edge_area_codes'}
      ,{18,'edge_country_conf'}
      ,{19,'edge_region_conf'}
      ,{20,'edge_city_conf'}
      ,{21,'edge_postal_conf'}
      ,{22,'edge_gmt_offset'}
      ,{23,'edge_in_dst'}
      ,{24,'sic_code'}
      ,{25,'domain_name'}
      ,{26,'isp_name'}
      ,{27,'homebiz_TYPE'}
      ,{28,'asn'}
      ,{29,'asn_name'}
      ,{30,'primary_lang'}
      ,{31,'secondary_lang'}
      ,{32,'proxy_TYPE'}
      ,{33,'proxy_description'}
      ,{34,'is_an_isp'}
      ,{35,'company_name'}
      ,{36,'ranks'}
      ,{37,'households'}
      ,{38,'women'}
      ,{39,'w18_34'}
      ,{40,'w35_49'}
      ,{41,'men'}
      ,{42,'m18_34'}
      ,{43,'m35_49'}
      ,{44,'teens'}
      ,{45,'kids'}
      ,{46,'naics_code'}
      ,{47,'cbsa_code'}
      ,{48,'cbsa_title'}
      ,{49,'cbsa_TYPE'}
      ,{50,'csa_code'}
      ,{51,'csa_title'}
      ,{52,'md_code'}
      ,{53,'md_title'}
      ,{54,'organization_name'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RawFile_Fields.InValid_ip_rng_beg((SALT36.StrType)le.ip_rng_beg),
    RawFile_Fields.InValid_ip_rng_end((SALT36.StrType)le.ip_rng_end),
    RawFile_Fields.InValid_edge_country((SALT36.StrType)le.edge_country),
    RawFile_Fields.InValid_edge_region((SALT36.StrType)le.edge_region),
    RawFile_Fields.InValid_edge_city((SALT36.StrType)le.edge_city),
    RawFile_Fields.InValid_edge_conn_speed((SALT36.StrType)le.edge_conn_speed),
    RawFile_Fields.InValid_edge_metro_code((SALT36.StrType)le.edge_metro_code),
    RawFile_Fields.InValid_edge_latitude((SALT36.StrType)le.edge_latitude),
    RawFile_Fields.InValid_edge_longitude((SALT36.StrType)le.edge_longitude),
    RawFile_Fields.InValid_edge_postal_code((SALT36.StrType)le.edge_postal_code),
    RawFile_Fields.InValid_edge_country_code((SALT36.StrType)le.edge_country_code),
    RawFile_Fields.InValid_edge_region_code((SALT36.StrType)le.edge_region_code),
    RawFile_Fields.InValid_edge_city_code((SALT36.StrType)le.edge_city_code),
    RawFile_Fields.InValid_edge_continent_code((SALT36.StrType)le.edge_continent_code),
    RawFile_Fields.InValid_edge_two_letter_country((SALT36.StrType)le.edge_two_letter_country),
    RawFile_Fields.InValid_edge_internal_code((SALT36.StrType)le.edge_internal_code),
    RawFile_Fields.InValid_edge_area_codes((SALT36.StrType)le.edge_area_codes),
    RawFile_Fields.InValid_edge_country_conf((SALT36.StrType)le.edge_country_conf),
    RawFile_Fields.InValid_edge_region_conf((SALT36.StrType)le.edge_region_conf),
    RawFile_Fields.InValid_edge_city_conf((SALT36.StrType)le.edge_city_conf),
    RawFile_Fields.InValid_edge_postal_conf((SALT36.StrType)le.edge_postal_conf),
    RawFile_Fields.InValid_edge_gmt_offset((SALT36.StrType)le.edge_gmt_offset),
    RawFile_Fields.InValid_edge_in_dst((SALT36.StrType)le.edge_in_dst),
    RawFile_Fields.InValid_sic_code((SALT36.StrType)le.sic_code),
    RawFile_Fields.InValid_domain_name((SALT36.StrType)le.domain_name),
    RawFile_Fields.InValid_isp_name((SALT36.StrType)le.isp_name),
    RawFile_Fields.InValid_homebiz_TYPE((SALT36.StrType)le.homebiz_TYPE),
    RawFile_Fields.InValid_asn((SALT36.StrType)le.asn),
    RawFile_Fields.InValid_asn_name((SALT36.StrType)le.asn_name),
    RawFile_Fields.InValid_primary_lang((SALT36.StrType)le.primary_lang),
    RawFile_Fields.InValid_secondary_lang((SALT36.StrType)le.secondary_lang),
    RawFile_Fields.InValid_proxy_TYPE((SALT36.StrType)le.proxy_TYPE),
    RawFile_Fields.InValid_proxy_description((SALT36.StrType)le.proxy_description),
    RawFile_Fields.InValid_is_an_isp((SALT36.StrType)le.is_an_isp),
    RawFile_Fields.InValid_company_name((SALT36.StrType)le.company_name),
    RawFile_Fields.InValid_ranks((SALT36.StrType)le.ranks),
    RawFile_Fields.InValid_households((SALT36.StrType)le.households),
    RawFile_Fields.InValid_women((SALT36.StrType)le.women),
    RawFile_Fields.InValid_w18_34((SALT36.StrType)le.w18_34),
    RawFile_Fields.InValid_w35_49((SALT36.StrType)le.w35_49),
    RawFile_Fields.InValid_men((SALT36.StrType)le.men),
    RawFile_Fields.InValid_m18_34((SALT36.StrType)le.m18_34),
    RawFile_Fields.InValid_m35_49((SALT36.StrType)le.m35_49),
    RawFile_Fields.InValid_teens((SALT36.StrType)le.teens),
    RawFile_Fields.InValid_kids((SALT36.StrType)le.kids),
    RawFile_Fields.InValid_naics_code((SALT36.StrType)le.naics_code),
    RawFile_Fields.InValid_cbsa_code((SALT36.StrType)le.cbsa_code),
    RawFile_Fields.InValid_cbsa_title((SALT36.StrType)le.cbsa_title),
    RawFile_Fields.InValid_cbsa_TYPE((SALT36.StrType)le.cbsa_TYPE),
    RawFile_Fields.InValid_csa_code((SALT36.StrType)le.csa_code),
    RawFile_Fields.InValid_csa_title((SALT36.StrType)le.csa_title),
    RawFile_Fields.InValid_md_code((SALT36.StrType)le.md_code),
    RawFile_Fields.InValid_md_title((SALT36.StrType)le.md_title),
    RawFile_Fields.InValid_organization_name((SALT36.StrType)le.organization_name),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,54,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RawFile_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Int','Invalid_Num','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Int','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Int','Invalid_Int','Invalid_Char','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Int','Invalid_Char','Invalid_Char');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RawFile_Fields.InValidMessage_ip_rng_beg(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_ip_rng_end(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_country(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_region(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_city(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_conn_speed(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_metro_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_latitude(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_longitude(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_postal_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_country_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_region_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_city_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_continent_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_two_letter_country(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_internal_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_area_codes(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_country_conf(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_region_conf(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_city_conf(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_postal_conf(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_gmt_offset(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_edge_in_dst(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_domain_name(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_isp_name(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_homebiz_TYPE(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_asn(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_asn_name(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_primary_lang(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_secondary_lang(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_proxy_TYPE(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_proxy_description(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_is_an_isp(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_ranks(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_households(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_women(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_w18_34(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_w35_49(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_men(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_m18_34(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_m35_49(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_teens(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_kids(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_naics_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_cbsa_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_cbsa_title(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_cbsa_TYPE(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_csa_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_csa_title(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_md_code(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_md_title(TotalErrors.ErrorNum),RawFile_Fields.InValidMessage_organization_name(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
