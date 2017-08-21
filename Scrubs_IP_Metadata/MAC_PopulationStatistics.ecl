EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ip_rng_beg = '',Input_ip_rng_end = '',Input_edge_country = '',Input_edge_region = '',Input_edge_city = '',Input_edge_conn_speed = '',Input_edge_metro_code = '',Input_edge_latitude = '',Input_edge_longitude = '',Input_edge_postal_code = '',Input_edge_country_code = '',Input_edge_region_code = '',Input_edge_city_code = '',Input_edge_continent_code = '',Input_edge_two_letter_country = '',Input_edge_internal_code = '',Input_edge_area_codes = '',Input_edge_country_conf = '',Input_edge_region_conf = '',Input_edge_city_conf = '',Input_edge_postal_conf = '',Input_edge_gmt_offset = '',Input_edge_in_dst = '',Input_sic_code = '',Input_domain_name = '',Input_isp_name = '',Input_homebiz_TYPE = '',Input_asn = '',Input_asn_name = '',Input_primary_lang = '',Input_secondary_lang = '',Input_proxy_TYPE = '',Input_proxy_description = '',Input_is_an_isp = '',Input_company_name = '',Input_ranks = '',Input_households = '',Input_women = '',Input_w18_34 = '',Input_w35_49 = '',Input_men = '',Input_m18_34 = '',Input_m35_49 = '',Input_teens = '',Input_kids = '',Input_naics_code = '',Input_cbsa_code = '',Input_cbsa_title = '',Input_cbsa_TYPE = '',Input_csa_code = '',Input_csa_title = '',Input_md_code = '',Input_md_title = '',Input_organization_name = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_IP_Metadata;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ip_rng_beg)='' )
      '' 
    #ELSE
        IF( le.Input_ip_rng_beg = (TYPEOF(le.Input_ip_rng_beg))'','',':ip_rng_beg')
    #END
+    #IF( #TEXT(Input_ip_rng_end)='' )
      '' 
    #ELSE
        IF( le.Input_ip_rng_end = (TYPEOF(le.Input_ip_rng_end))'','',':ip_rng_end')
    #END
+    #IF( #TEXT(Input_edge_country)='' )
      '' 
    #ELSE
        IF( le.Input_edge_country = (TYPEOF(le.Input_edge_country))'','',':edge_country')
    #END
+    #IF( #TEXT(Input_edge_region)='' )
      '' 
    #ELSE
        IF( le.Input_edge_region = (TYPEOF(le.Input_edge_region))'','',':edge_region')
    #END
+    #IF( #TEXT(Input_edge_city)='' )
      '' 
    #ELSE
        IF( le.Input_edge_city = (TYPEOF(le.Input_edge_city))'','',':edge_city')
    #END
+    #IF( #TEXT(Input_edge_conn_speed)='' )
      '' 
    #ELSE
        IF( le.Input_edge_conn_speed = (TYPEOF(le.Input_edge_conn_speed))'','',':edge_conn_speed')
    #END
+    #IF( #TEXT(Input_edge_metro_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_metro_code = (TYPEOF(le.Input_edge_metro_code))'','',':edge_metro_code')
    #END
+    #IF( #TEXT(Input_edge_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_edge_latitude = (TYPEOF(le.Input_edge_latitude))'','',':edge_latitude')
    #END
+    #IF( #TEXT(Input_edge_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_edge_longitude = (TYPEOF(le.Input_edge_longitude))'','',':edge_longitude')
    #END
+    #IF( #TEXT(Input_edge_postal_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_postal_code = (TYPEOF(le.Input_edge_postal_code))'','',':edge_postal_code')
    #END
+    #IF( #TEXT(Input_edge_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_country_code = (TYPEOF(le.Input_edge_country_code))'','',':edge_country_code')
    #END
+    #IF( #TEXT(Input_edge_region_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_region_code = (TYPEOF(le.Input_edge_region_code))'','',':edge_region_code')
    #END
+    #IF( #TEXT(Input_edge_city_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_city_code = (TYPEOF(le.Input_edge_city_code))'','',':edge_city_code')
    #END
+    #IF( #TEXT(Input_edge_continent_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_continent_code = (TYPEOF(le.Input_edge_continent_code))'','',':edge_continent_code')
    #END
+    #IF( #TEXT(Input_edge_two_letter_country)='' )
      '' 
    #ELSE
        IF( le.Input_edge_two_letter_country = (TYPEOF(le.Input_edge_two_letter_country))'','',':edge_two_letter_country')
    #END
+    #IF( #TEXT(Input_edge_internal_code)='' )
      '' 
    #ELSE
        IF( le.Input_edge_internal_code = (TYPEOF(le.Input_edge_internal_code))'','',':edge_internal_code')
    #END
+    #IF( #TEXT(Input_edge_area_codes)='' )
      '' 
    #ELSE
        IF( le.Input_edge_area_codes = (TYPEOF(le.Input_edge_area_codes))'','',':edge_area_codes')
    #END
+    #IF( #TEXT(Input_edge_country_conf)='' )
      '' 
    #ELSE
        IF( le.Input_edge_country_conf = (TYPEOF(le.Input_edge_country_conf))'','',':edge_country_conf')
    #END
+    #IF( #TEXT(Input_edge_region_conf)='' )
      '' 
    #ELSE
        IF( le.Input_edge_region_conf = (TYPEOF(le.Input_edge_region_conf))'','',':edge_region_conf')
    #END
+    #IF( #TEXT(Input_edge_city_conf)='' )
      '' 
    #ELSE
        IF( le.Input_edge_city_conf = (TYPEOF(le.Input_edge_city_conf))'','',':edge_city_conf')
    #END
+    #IF( #TEXT(Input_edge_postal_conf)='' )
      '' 
    #ELSE
        IF( le.Input_edge_postal_conf = (TYPEOF(le.Input_edge_postal_conf))'','',':edge_postal_conf')
    #END
+    #IF( #TEXT(Input_edge_gmt_offset)='' )
      '' 
    #ELSE
        IF( le.Input_edge_gmt_offset = (TYPEOF(le.Input_edge_gmt_offset))'','',':edge_gmt_offset')
    #END
+    #IF( #TEXT(Input_edge_in_dst)='' )
      '' 
    #ELSE
        IF( le.Input_edge_in_dst = (TYPEOF(le.Input_edge_in_dst))'','',':edge_in_dst')
    #END
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
+    #IF( #TEXT(Input_domain_name)='' )
      '' 
    #ELSE
        IF( le.Input_domain_name = (TYPEOF(le.Input_domain_name))'','',':domain_name')
    #END
+    #IF( #TEXT(Input_isp_name)='' )
      '' 
    #ELSE
        IF( le.Input_isp_name = (TYPEOF(le.Input_isp_name))'','',':isp_name')
    #END
+    #IF( #TEXT(Input_homebiz_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_homebiz_TYPE = (TYPEOF(le.Input_homebiz_TYPE))'','',':homebiz_TYPE')
    #END
+    #IF( #TEXT(Input_asn)='' )
      '' 
    #ELSE
        IF( le.Input_asn = (TYPEOF(le.Input_asn))'','',':asn')
    #END
+    #IF( #TEXT(Input_asn_name)='' )
      '' 
    #ELSE
        IF( le.Input_asn_name = (TYPEOF(le.Input_asn_name))'','',':asn_name')
    #END
+    #IF( #TEXT(Input_primary_lang)='' )
      '' 
    #ELSE
        IF( le.Input_primary_lang = (TYPEOF(le.Input_primary_lang))'','',':primary_lang')
    #END
+    #IF( #TEXT(Input_secondary_lang)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_lang = (TYPEOF(le.Input_secondary_lang))'','',':secondary_lang')
    #END
+    #IF( #TEXT(Input_proxy_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_proxy_TYPE = (TYPEOF(le.Input_proxy_TYPE))'','',':proxy_TYPE')
    #END
+    #IF( #TEXT(Input_proxy_description)='' )
      '' 
    #ELSE
        IF( le.Input_proxy_description = (TYPEOF(le.Input_proxy_description))'','',':proxy_description')
    #END
+    #IF( #TEXT(Input_is_an_isp)='' )
      '' 
    #ELSE
        IF( le.Input_is_an_isp = (TYPEOF(le.Input_is_an_isp))'','',':is_an_isp')
    #END
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
+    #IF( #TEXT(Input_ranks)='' )
      '' 
    #ELSE
        IF( le.Input_ranks = (TYPEOF(le.Input_ranks))'','',':ranks')
    #END
+    #IF( #TEXT(Input_households)='' )
      '' 
    #ELSE
        IF( le.Input_households = (TYPEOF(le.Input_households))'','',':households')
    #END
+    #IF( #TEXT(Input_women)='' )
      '' 
    #ELSE
        IF( le.Input_women = (TYPEOF(le.Input_women))'','',':women')
    #END
+    #IF( #TEXT(Input_w18_34)='' )
      '' 
    #ELSE
        IF( le.Input_w18_34 = (TYPEOF(le.Input_w18_34))'','',':w18_34')
    #END
+    #IF( #TEXT(Input_w35_49)='' )
      '' 
    #ELSE
        IF( le.Input_w35_49 = (TYPEOF(le.Input_w35_49))'','',':w35_49')
    #END
+    #IF( #TEXT(Input_men)='' )
      '' 
    #ELSE
        IF( le.Input_men = (TYPEOF(le.Input_men))'','',':men')
    #END
+    #IF( #TEXT(Input_m18_34)='' )
      '' 
    #ELSE
        IF( le.Input_m18_34 = (TYPEOF(le.Input_m18_34))'','',':m18_34')
    #END
+    #IF( #TEXT(Input_m35_49)='' )
      '' 
    #ELSE
        IF( le.Input_m35_49 = (TYPEOF(le.Input_m35_49))'','',':m35_49')
    #END
+    #IF( #TEXT(Input_teens)='' )
      '' 
    #ELSE
        IF( le.Input_teens = (TYPEOF(le.Input_teens))'','',':teens')
    #END
+    #IF( #TEXT(Input_kids)='' )
      '' 
    #ELSE
        IF( le.Input_kids = (TYPEOF(le.Input_kids))'','',':kids')
    #END
+    #IF( #TEXT(Input_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_naics_code = (TYPEOF(le.Input_naics_code))'','',':naics_code')
    #END
+    #IF( #TEXT(Input_cbsa_code)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_code = (TYPEOF(le.Input_cbsa_code))'','',':cbsa_code')
    #END
+    #IF( #TEXT(Input_cbsa_title)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_title = (TYPEOF(le.Input_cbsa_title))'','',':cbsa_title')
    #END
+    #IF( #TEXT(Input_cbsa_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_TYPE = (TYPEOF(le.Input_cbsa_TYPE))'','',':cbsa_TYPE')
    #END
+    #IF( #TEXT(Input_csa_code)='' )
      '' 
    #ELSE
        IF( le.Input_csa_code = (TYPEOF(le.Input_csa_code))'','',':csa_code')
    #END
+    #IF( #TEXT(Input_csa_title)='' )
      '' 
    #ELSE
        IF( le.Input_csa_title = (TYPEOF(le.Input_csa_title))'','',':csa_title')
    #END
+    #IF( #TEXT(Input_md_code)='' )
      '' 
    #ELSE
        IF( le.Input_md_code = (TYPEOF(le.Input_md_code))'','',':md_code')
    #END
+    #IF( #TEXT(Input_md_title)='' )
      '' 
    #ELSE
        IF( le.Input_md_title = (TYPEOF(le.Input_md_title))'','',':md_title')
    #END
+    #IF( #TEXT(Input_organization_name)='' )
      '' 
    #ELSE
        IF( le.Input_organization_name = (TYPEOF(le.Input_organization_name))'','',':organization_name')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
