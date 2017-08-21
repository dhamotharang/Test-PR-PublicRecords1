IMPORT Salt31;
EXPORT BaseFile_Fields := MODULE


// Processing for each FieldType
EXPORT Salt31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alph','Invalid_AlphNum','Invalid_Int','Invalid_Num');
EXPORT FieldTypeNum(Salt31.StrType fn) := CASE(fn,'Invalid_Alph' => 1,'Invalid_AlphNum' => 2,'Invalid_Int' => 3,'Invalid_Num' => 4,0);

EXPORT MakeFT_Invalid_Alph(Salt31.StrType s0) := FUNCTION
  s1 := Salt31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ/-\\\'_#, '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alph(Salt31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(Salt31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ/-\\\'_#, '))));
EXPORT InValidMessageFT_Invalid_Alph(UNSIGNED1 wh) := CHOOSE(wh,Salt31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ/-\\\'_#, '),Salt31.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AlphNum(Salt31.StrType s0) := FUNCTION
  s1 := Salt31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-.\\\'_#, '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphNum(Salt31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(Salt31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-.\\\'_#, '))));
EXPORT InValidMessageFT_Invalid_AlphNum(UNSIGNED1 wh) := CHOOSE(wh,Salt31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-.\\\'_#, '),Salt31.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Int(Salt31.StrType s0) := FUNCTION
  s1 := Salt31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Int(Salt31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(Salt31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Int(UNSIGNED1 wh) := CHOOSE(wh,Salt31.HygieneErrors.NotInChars('0123456789'),Salt31.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num(Salt31.StrType s0) := FUNCTION
  s1 := Salt31.stringfilter(s0,'0123456789/-.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(Salt31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(Salt31.StringFilter(s,'0123456789/-.'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,Salt31.HygieneErrors.NotInChars('0123456789/-.'),Salt31.HygieneErrors.Good);


EXPORT Salt31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','beg_octet1','end_octet1','beg_octet2','end_octet2','beg_octets34','end_octets34','ip_rng_beg','ip_rng_end','edge_country','edge_region','edge_city','edge_conn_speed','edge_metro_code','edge_latitude','edge_longitude','edge_postal_code','edge_country_code','edge_region_code','edge_city_code','edge_continent_code','edge_two_letter_country','edge_internal_code','edge_area_codes','edge_country_conf','edge_region_conf','edge_city_conf','edge_postal_conf','edge_gmt_offset','edge_in_dst','sic_code','domain_name','isp_name','homebiz_type','asn','asn_name','primary_lang','secondary_lang','proxy_type','proxy_description','is_an_isp','company_name','ranks','households','women','w18_34','w35_49','men','m18_34','m35_49','teens','kids','naics_code','cbsa_code','cbsa_title','cbsa_type','csa_code','csa_title','md_code','md_title','organization_name','generated_rec','is_current');
EXPORT FieldNum(Salt31.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'beg_octet1' => 2,'end_octet1' => 3,'beg_octet2' => 4,'end_octet2' => 5,'beg_octets34' => 6,'end_octets34' => 7,'ip_rng_beg' => 8,'ip_rng_end' => 9,'edge_country' => 10,'edge_region' => 11,'edge_city' => 12,'edge_conn_speed' => 13,'edge_metro_code' => 14,'edge_latitude' => 15,'edge_longitude' => 16,'edge_postal_code' => 17,'edge_country_code' => 18,'edge_region_code' => 19,'edge_city_code' => 20,'edge_continent_code' => 21,'edge_two_letter_country' => 22,'edge_internal_code' => 23,'edge_area_codes' => 24,'edge_country_conf' => 25,'edge_region_conf' => 26,'edge_city_conf' => 27,'edge_postal_conf' => 28,'edge_gmt_offset' => 29,'edge_in_dst' => 30,'sic_code' => 31,'domain_name' => 32,'isp_name' => 33,'homebiz_type' => 34,'asn' => 35,'asn_name' => 36,'primary_lang' => 37,'secondary_lang' => 38,'proxy_type' => 39,'proxy_description' => 40,'is_an_isp' => 41,'company_name' => 42,'ranks' => 43,'households' => 44,'women' => 45,'w18_34' => 46,'w35_49' => 47,'men' => 48,'m18_34' => 49,'m35_49' => 50,'teens' => 51,'kids' => 52,'naics_code' => 53,'cbsa_code' => 54,'cbsa_title' => 55,'cbsa_type' => 56,'csa_code' => 57,'csa_title' => 58,'md_code' => 59,'md_title' => 60,'organization_name' => 61,'generated_rec' => 62,'is_current' => 63,0);

//Individual field level validation


EXPORT Make_dt_first_seen(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_dt_first_seen(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_dt_last_seen(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_dt_last_seen(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_beg_octet1(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_beg_octet1(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_beg_octet1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_end_octet1(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_end_octet1(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_end_octet1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_beg_octet2(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_beg_octet2(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_beg_octet2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_end_octet2(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_end_octet2(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_end_octet2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_beg_octets34(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_beg_octets34(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_beg_octets34(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_end_octets34(Salt31.StrType s0) := MakeFT_Invalid_Int(s0);
EXPORT InValid_end_octets34(Salt31.StrType s) := InValidFT_Invalid_Int(s);
EXPORT InValidMessage_end_octets34(UNSIGNED1 wh) := InValidMessageFT_Invalid_Int(wh);


EXPORT Make_ip_rng_beg(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ip_rng_beg(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ip_rng_beg(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_ip_rng_end(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ip_rng_end(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ip_rng_end(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_edge_country(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_edge_country(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_edge_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_edge_region(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_edge_region(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_edge_region(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_edge_city(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_edge_city(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_edge_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_edge_conn_speed(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_edge_conn_speed(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_edge_conn_speed(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_edge_metro_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_metro_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_metro_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_latitude(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_edge_latitude(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_edge_latitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_edge_longitude(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_edge_longitude(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_edge_longitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_edge_postal_code(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_edge_postal_code(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_edge_postal_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_edge_country_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_country_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_country_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_region_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_region_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_region_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_city_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_city_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_city_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_continent_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_continent_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_continent_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_two_letter_country(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_edge_two_letter_country(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_edge_two_letter_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_edge_internal_code(Salt31.StrType s0) := s0;
EXPORT InValid_edge_internal_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_internal_code(UNSIGNED1 wh) := '';


EXPORT Make_edge_area_codes(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_edge_area_codes(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_edge_area_codes(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_edge_country_conf(Salt31.StrType s0) := s0;
EXPORT InValid_edge_country_conf(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_country_conf(UNSIGNED1 wh) := '';


EXPORT Make_edge_region_conf(Salt31.StrType s0) := s0;
EXPORT InValid_edge_region_conf(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_region_conf(UNSIGNED1 wh) := '';


EXPORT Make_edge_city_conf(Salt31.StrType s0) := s0;
EXPORT InValid_edge_city_conf(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_city_conf(UNSIGNED1 wh) := '';


EXPORT Make_edge_postal_conf(Salt31.StrType s0) := s0;
EXPORT InValid_edge_postal_conf(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_postal_conf(UNSIGNED1 wh) := '';


EXPORT Make_edge_gmt_offset(Salt31.StrType s0) := s0;
EXPORT InValid_edge_gmt_offset(Salt31.StrType s) := 0;
EXPORT InValidMessage_edge_gmt_offset(UNSIGNED1 wh) := '';


EXPORT Make_edge_in_dst(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_edge_in_dst(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_edge_in_dst(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_sic_code(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sic_code(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_domain_name(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_domain_name(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_domain_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_isp_name(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_isp_name(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_isp_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_homebiz_type(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_homebiz_type(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_homebiz_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_asn(Salt31.StrType s0) := s0;
EXPORT InValid_asn(Salt31.StrType s) := 0;
EXPORT InValidMessage_asn(UNSIGNED1 wh) := '';


EXPORT Make_asn_name(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_asn_name(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_asn_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_primary_lang(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_primary_lang(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_primary_lang(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_secondary_lang(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_secondary_lang(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_secondary_lang(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_proxy_type(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_proxy_type(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_proxy_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_proxy_description(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_proxy_description(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_proxy_description(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_is_an_isp(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_is_an_isp(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_is_an_isp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_company_name(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_company_name(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_ranks(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ranks(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ranks(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_households(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_households(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_households(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_women(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_women(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_women(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_w18_34(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_w18_34(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_w18_34(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_w35_49(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_w35_49(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_w35_49(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_men(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_men(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_men(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_m18_34(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_m18_34(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_m18_34(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_m35_49(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_m35_49(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_m35_49(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_teens(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_teens(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_teens(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_kids(Salt31.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_kids(Salt31.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_kids(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_naics_code(Salt31.StrType s0) := s0;
EXPORT InValid_naics_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_naics_code(UNSIGNED1 wh) := '';


EXPORT Make_cbsa_code(Salt31.StrType s0) := s0;
EXPORT InValid_cbsa_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_cbsa_code(UNSIGNED1 wh) := '';


EXPORT Make_cbsa_title(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_cbsa_title(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_cbsa_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_cbsa_type(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_cbsa_type(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_cbsa_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_csa_code(Salt31.StrType s0) := s0;
EXPORT InValid_csa_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_csa_code(UNSIGNED1 wh) := '';


EXPORT Make_csa_title(Salt31.StrType s0) := s0;
EXPORT InValid_csa_title(Salt31.StrType s) := 0;
EXPORT InValidMessage_csa_title(UNSIGNED1 wh) := '';


EXPORT Make_md_code(Salt31.StrType s0) := s0;
EXPORT InValid_md_code(Salt31.StrType s) := 0;
EXPORT InValidMessage_md_code(UNSIGNED1 wh) := '';


EXPORT Make_md_title(Salt31.StrType s0) := MakeFT_Invalid_Alph(s0);
EXPORT InValid_md_title(Salt31.StrType s) := InValidFT_Invalid_Alph(s);
EXPORT InValidMessage_md_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alph(wh);


EXPORT Make_organization_name(Salt31.StrType s0) := MakeFT_Invalid_AlphNum(s0);
EXPORT InValid_organization_name(Salt31.StrType s) := InValidFT_Invalid_AlphNum(s);
EXPORT InValidMessage_organization_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphNum(wh);


EXPORT Make_generated_rec(Salt31.StrType s0) := s0;
EXPORT InValid_generated_rec(Salt31.StrType s) := 0;
EXPORT InValidMessage_generated_rec(UNSIGNED1 wh) := '';


EXPORT Make_is_current(Salt31.StrType s0) := s0;
EXPORT InValid_is_current(Salt31.StrType s) := 0;
EXPORT InValidMessage_is_current(UNSIGNED1 wh) := '';

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT Salt31,Scrubs_IP_Metadata;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_beg_octet1;
    BOOLEAN Diff_end_octet1;
    BOOLEAN Diff_beg_octet2;
    BOOLEAN Diff_end_octet2;
    BOOLEAN Diff_beg_octets34;
    BOOLEAN Diff_end_octets34;
    BOOLEAN Diff_ip_rng_beg;
    BOOLEAN Diff_ip_rng_end;
    BOOLEAN Diff_edge_country;
    BOOLEAN Diff_edge_region;
    BOOLEAN Diff_edge_city;
    BOOLEAN Diff_edge_conn_speed;
    BOOLEAN Diff_edge_metro_code;
    BOOLEAN Diff_edge_latitude;
    BOOLEAN Diff_edge_longitude;
    BOOLEAN Diff_edge_postal_code;
    BOOLEAN Diff_edge_country_code;
    BOOLEAN Diff_edge_region_code;
    BOOLEAN Diff_edge_city_code;
    BOOLEAN Diff_edge_continent_code;
    BOOLEAN Diff_edge_two_letter_country;
    BOOLEAN Diff_edge_internal_code;
    BOOLEAN Diff_edge_area_codes;
    BOOLEAN Diff_edge_country_conf;
    BOOLEAN Diff_edge_region_conf;
    BOOLEAN Diff_edge_city_conf;
    BOOLEAN Diff_edge_postal_conf;
    BOOLEAN Diff_edge_gmt_offset;
    BOOLEAN Diff_edge_in_dst;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_domain_name;
    BOOLEAN Diff_isp_name;
    BOOLEAN Diff_homebiz_type;
    BOOLEAN Diff_asn;
    BOOLEAN Diff_asn_name;
    BOOLEAN Diff_primary_lang;
    BOOLEAN Diff_secondary_lang;
    BOOLEAN Diff_proxy_type;
    BOOLEAN Diff_proxy_description;
    BOOLEAN Diff_is_an_isp;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_ranks;
    BOOLEAN Diff_households;
    BOOLEAN Diff_women;
    BOOLEAN Diff_w18_34;
    BOOLEAN Diff_w35_49;
    BOOLEAN Diff_men;
    BOOLEAN Diff_m18_34;
    BOOLEAN Diff_m35_49;
    BOOLEAN Diff_teens;
    BOOLEAN Diff_kids;
    BOOLEAN Diff_naics_code;
    BOOLEAN Diff_cbsa_code;
    BOOLEAN Diff_cbsa_title;
    BOOLEAN Diff_cbsa_type;
    BOOLEAN Diff_csa_code;
    BOOLEAN Diff_csa_title;
    BOOLEAN Diff_md_code;
    BOOLEAN Diff_md_title;
    BOOLEAN Diff_organization_name;
    BOOLEAN Diff_generated_rec;
    BOOLEAN Diff_is_current;
    UNSIGNED Num_Diffs;
    Salt31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_beg_octet1 := le.beg_octet1 <> ri.beg_octet1;
    SELF.Diff_end_octet1 := le.end_octet1 <> ri.end_octet1;
    SELF.Diff_beg_octet2 := le.beg_octet2 <> ri.beg_octet2;
    SELF.Diff_end_octet2 := le.end_octet2 <> ri.end_octet2;
    SELF.Diff_beg_octets34 := le.beg_octets34 <> ri.beg_octets34;
    SELF.Diff_end_octets34 := le.end_octets34 <> ri.end_octets34;
    SELF.Diff_ip_rng_beg := le.ip_rng_beg <> ri.ip_rng_beg;
    SELF.Diff_ip_rng_end := le.ip_rng_end <> ri.ip_rng_end;
    SELF.Diff_edge_country := le.edge_country <> ri.edge_country;
    SELF.Diff_edge_region := le.edge_region <> ri.edge_region;
    SELF.Diff_edge_city := le.edge_city <> ri.edge_city;
    SELF.Diff_edge_conn_speed := le.edge_conn_speed <> ri.edge_conn_speed;
    SELF.Diff_edge_metro_code := le.edge_metro_code <> ri.edge_metro_code;
    SELF.Diff_edge_latitude := le.edge_latitude <> ri.edge_latitude;
    SELF.Diff_edge_longitude := le.edge_longitude <> ri.edge_longitude;
    SELF.Diff_edge_postal_code := le.edge_postal_code <> ri.edge_postal_code;
    SELF.Diff_edge_country_code := le.edge_country_code <> ri.edge_country_code;
    SELF.Diff_edge_region_code := le.edge_region_code <> ri.edge_region_code;
    SELF.Diff_edge_city_code := le.edge_city_code <> ri.edge_city_code;
    SELF.Diff_edge_continent_code := le.edge_continent_code <> ri.edge_continent_code;
    SELF.Diff_edge_two_letter_country := le.edge_two_letter_country <> ri.edge_two_letter_country;
    SELF.Diff_edge_internal_code := le.edge_internal_code <> ri.edge_internal_code;
    SELF.Diff_edge_area_codes := le.edge_area_codes <> ri.edge_area_codes;
    SELF.Diff_edge_country_conf := le.edge_country_conf <> ri.edge_country_conf;
    SELF.Diff_edge_region_conf := le.edge_region_conf <> ri.edge_region_conf;
    SELF.Diff_edge_city_conf := le.edge_city_conf <> ri.edge_city_conf;
    SELF.Diff_edge_postal_conf := le.edge_postal_conf <> ri.edge_postal_conf;
    SELF.Diff_edge_gmt_offset := le.edge_gmt_offset <> ri.edge_gmt_offset;
    SELF.Diff_edge_in_dst := le.edge_in_dst <> ri.edge_in_dst;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_domain_name := le.domain_name <> ri.domain_name;
    SELF.Diff_isp_name := le.isp_name <> ri.isp_name;
    SELF.Diff_homebiz_type := le.homebiz_type <> ri.homebiz_type;
    SELF.Diff_asn := le.asn <> ri.asn;
    SELF.Diff_asn_name := le.asn_name <> ri.asn_name;
    SELF.Diff_primary_lang := le.primary_lang <> ri.primary_lang;
    SELF.Diff_secondary_lang := le.secondary_lang <> ri.secondary_lang;
    SELF.Diff_proxy_type := le.proxy_type <> ri.proxy_type;
    SELF.Diff_proxy_description := le.proxy_description <> ri.proxy_description;
    SELF.Diff_is_an_isp := le.is_an_isp <> ri.is_an_isp;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_ranks := le.ranks <> ri.ranks;
    SELF.Diff_households := le.households <> ri.households;
    SELF.Diff_women := le.women <> ri.women;
    SELF.Diff_w18_34 := le.w18_34 <> ri.w18_34;
    SELF.Diff_w35_49 := le.w35_49 <> ri.w35_49;
    SELF.Diff_men := le.men <> ri.men;
    SELF.Diff_m18_34 := le.m18_34 <> ri.m18_34;
    SELF.Diff_m35_49 := le.m35_49 <> ri.m35_49;
    SELF.Diff_teens := le.teens <> ri.teens;
    SELF.Diff_kids := le.kids <> ri.kids;
    SELF.Diff_naics_code := le.naics_code <> ri.naics_code;
    SELF.Diff_cbsa_code := le.cbsa_code <> ri.cbsa_code;
    SELF.Diff_cbsa_title := le.cbsa_title <> ri.cbsa_title;
    SELF.Diff_cbsa_type := le.cbsa_type <> ri.cbsa_type;
    SELF.Diff_csa_code := le.csa_code <> ri.csa_code;
    SELF.Diff_csa_title := le.csa_title <> ri.csa_title;
    SELF.Diff_md_code := le.md_code <> ri.md_code;
    SELF.Diff_md_title := le.md_title <> ri.md_title;
    SELF.Diff_organization_name := le.organization_name <> ri.organization_name;
    SELF.Diff_generated_rec := le.generated_rec <> ri.generated_rec;
    SELF.Diff_is_current := le.is_current <> ri.is_current;
    SELF.Val := (Salt31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_beg_octet1,1,0)+ IF( SELF.Diff_end_octet1,1,0)+ IF( SELF.Diff_beg_octet2,1,0)+ IF( SELF.Diff_end_octet2,1,0)+ IF( SELF.Diff_beg_octets34,1,0)+ IF( SELF.Diff_end_octets34,1,0)+ IF( SELF.Diff_ip_rng_beg,1,0)+ IF( SELF.Diff_ip_rng_end,1,0)+ IF( SELF.Diff_edge_country,1,0)+ IF( SELF.Diff_edge_region,1,0)+ IF( SELF.Diff_edge_city,1,0)+ IF( SELF.Diff_edge_conn_speed,1,0)+ IF( SELF.Diff_edge_metro_code,1,0)+ IF( SELF.Diff_edge_latitude,1,0)+ IF( SELF.Diff_edge_longitude,1,0)+ IF( SELF.Diff_edge_postal_code,1,0)+ IF( SELF.Diff_edge_country_code,1,0)+ IF( SELF.Diff_edge_region_code,1,0)+ IF( SELF.Diff_edge_city_code,1,0)+ IF( SELF.Diff_edge_continent_code,1,0)+ IF( SELF.Diff_edge_two_letter_country,1,0)+ IF( SELF.Diff_edge_internal_code,1,0)+ IF( SELF.Diff_edge_area_codes,1,0)+ IF( SELF.Diff_edge_country_conf,1,0)+ IF( SELF.Diff_edge_region_conf,1,0)+ IF( SELF.Diff_edge_city_conf,1,0)+ IF( SELF.Diff_edge_postal_conf,1,0)+ IF( SELF.Diff_edge_gmt_offset,1,0)+ IF( SELF.Diff_edge_in_dst,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_domain_name,1,0)+ IF( SELF.Diff_isp_name,1,0)+ IF( SELF.Diff_homebiz_type,1,0)+ IF( SELF.Diff_asn,1,0)+ IF( SELF.Diff_asn_name,1,0)+ IF( SELF.Diff_primary_lang,1,0)+ IF( SELF.Diff_secondary_lang,1,0)+ IF( SELF.Diff_proxy_type,1,0)+ IF( SELF.Diff_proxy_description,1,0)+ IF( SELF.Diff_is_an_isp,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_ranks,1,0)+ IF( SELF.Diff_households,1,0)+ IF( SELF.Diff_women,1,0)+ IF( SELF.Diff_w18_34,1,0)+ IF( SELF.Diff_w35_49,1,0)+ IF( SELF.Diff_men,1,0)+ IF( SELF.Diff_m18_34,1,0)+ IF( SELF.Diff_m35_49,1,0)+ IF( SELF.Diff_teens,1,0)+ IF( SELF.Diff_kids,1,0)+ IF( SELF.Diff_naics_code,1,0)+ IF( SELF.Diff_cbsa_code,1,0)+ IF( SELF.Diff_cbsa_title,1,0)+ IF( SELF.Diff_cbsa_type,1,0)+ IF( SELF.Diff_csa_code,1,0)+ IF( SELF.Diff_csa_title,1,0)+ IF( SELF.Diff_md_code,1,0)+ IF( SELF.Diff_md_title,1,0)+ IF( SELF.Diff_organization_name,1,0)+ IF( SELF.Diff_generated_rec,1,0)+ IF( SELF.Diff_is_current,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_beg_octet1 := COUNT(GROUP,%Closest%.Diff_beg_octet1);
    Count_Diff_end_octet1 := COUNT(GROUP,%Closest%.Diff_end_octet1);
    Count_Diff_beg_octet2 := COUNT(GROUP,%Closest%.Diff_beg_octet2);
    Count_Diff_end_octet2 := COUNT(GROUP,%Closest%.Diff_end_octet2);
    Count_Diff_beg_octets34 := COUNT(GROUP,%Closest%.Diff_beg_octets34);
    Count_Diff_end_octets34 := COUNT(GROUP,%Closest%.Diff_end_octets34);
    Count_Diff_ip_rng_beg := COUNT(GROUP,%Closest%.Diff_ip_rng_beg);
    Count_Diff_ip_rng_end := COUNT(GROUP,%Closest%.Diff_ip_rng_end);
    Count_Diff_edge_country := COUNT(GROUP,%Closest%.Diff_edge_country);
    Count_Diff_edge_region := COUNT(GROUP,%Closest%.Diff_edge_region);
    Count_Diff_edge_city := COUNT(GROUP,%Closest%.Diff_edge_city);
    Count_Diff_edge_conn_speed := COUNT(GROUP,%Closest%.Diff_edge_conn_speed);
    Count_Diff_edge_metro_code := COUNT(GROUP,%Closest%.Diff_edge_metro_code);
    Count_Diff_edge_latitude := COUNT(GROUP,%Closest%.Diff_edge_latitude);
    Count_Diff_edge_longitude := COUNT(GROUP,%Closest%.Diff_edge_longitude);
    Count_Diff_edge_postal_code := COUNT(GROUP,%Closest%.Diff_edge_postal_code);
    Count_Diff_edge_country_code := COUNT(GROUP,%Closest%.Diff_edge_country_code);
    Count_Diff_edge_region_code := COUNT(GROUP,%Closest%.Diff_edge_region_code);
    Count_Diff_edge_city_code := COUNT(GROUP,%Closest%.Diff_edge_city_code);
    Count_Diff_edge_continent_code := COUNT(GROUP,%Closest%.Diff_edge_continent_code);
    Count_Diff_edge_two_letter_country := COUNT(GROUP,%Closest%.Diff_edge_two_letter_country);
    Count_Diff_edge_internal_code := COUNT(GROUP,%Closest%.Diff_edge_internal_code);
    Count_Diff_edge_area_codes := COUNT(GROUP,%Closest%.Diff_edge_area_codes);
    Count_Diff_edge_country_conf := COUNT(GROUP,%Closest%.Diff_edge_country_conf);
    Count_Diff_edge_region_conf := COUNT(GROUP,%Closest%.Diff_edge_region_conf);
    Count_Diff_edge_city_conf := COUNT(GROUP,%Closest%.Diff_edge_city_conf);
    Count_Diff_edge_postal_conf := COUNT(GROUP,%Closest%.Diff_edge_postal_conf);
    Count_Diff_edge_gmt_offset := COUNT(GROUP,%Closest%.Diff_edge_gmt_offset);
    Count_Diff_edge_in_dst := COUNT(GROUP,%Closest%.Diff_edge_in_dst);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_domain_name := COUNT(GROUP,%Closest%.Diff_domain_name);
    Count_Diff_isp_name := COUNT(GROUP,%Closest%.Diff_isp_name);
    Count_Diff_homebiz_type := COUNT(GROUP,%Closest%.Diff_homebiz_type);
    Count_Diff_asn := COUNT(GROUP,%Closest%.Diff_asn);
    Count_Diff_asn_name := COUNT(GROUP,%Closest%.Diff_asn_name);
    Count_Diff_primary_lang := COUNT(GROUP,%Closest%.Diff_primary_lang);
    Count_Diff_secondary_lang := COUNT(GROUP,%Closest%.Diff_secondary_lang);
    Count_Diff_proxy_type := COUNT(GROUP,%Closest%.Diff_proxy_type);
    Count_Diff_proxy_description := COUNT(GROUP,%Closest%.Diff_proxy_description);
    Count_Diff_is_an_isp := COUNT(GROUP,%Closest%.Diff_is_an_isp);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_ranks := COUNT(GROUP,%Closest%.Diff_ranks);
    Count_Diff_households := COUNT(GROUP,%Closest%.Diff_households);
    Count_Diff_women := COUNT(GROUP,%Closest%.Diff_women);
    Count_Diff_w18_34 := COUNT(GROUP,%Closest%.Diff_w18_34);
    Count_Diff_w35_49 := COUNT(GROUP,%Closest%.Diff_w35_49);
    Count_Diff_men := COUNT(GROUP,%Closest%.Diff_men);
    Count_Diff_m18_34 := COUNT(GROUP,%Closest%.Diff_m18_34);
    Count_Diff_m35_49 := COUNT(GROUP,%Closest%.Diff_m35_49);
    Count_Diff_teens := COUNT(GROUP,%Closest%.Diff_teens);
    Count_Diff_kids := COUNT(GROUP,%Closest%.Diff_kids);
    Count_Diff_naics_code := COUNT(GROUP,%Closest%.Diff_naics_code);
    Count_Diff_cbsa_code := COUNT(GROUP,%Closest%.Diff_cbsa_code);
    Count_Diff_cbsa_title := COUNT(GROUP,%Closest%.Diff_cbsa_title);
    Count_Diff_cbsa_type := COUNT(GROUP,%Closest%.Diff_cbsa_type);
    Count_Diff_csa_code := COUNT(GROUP,%Closest%.Diff_csa_code);
    Count_Diff_csa_title := COUNT(GROUP,%Closest%.Diff_csa_title);
    Count_Diff_md_code := COUNT(GROUP,%Closest%.Diff_md_code);
    Count_Diff_md_title := COUNT(GROUP,%Closest%.Diff_md_title);
    Count_Diff_organization_name := COUNT(GROUP,%Closest%.Diff_organization_name);
    Count_Diff_generated_rec := COUNT(GROUP,%Closest%.Diff_generated_rec);
    Count_Diff_is_current := COUNT(GROUP,%Closest%.Diff_is_current);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
