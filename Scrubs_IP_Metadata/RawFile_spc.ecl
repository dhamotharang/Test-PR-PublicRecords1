MODULE:Scrubs_IP_Metadata
FILENAME:IP_Metadata
NAMESCOPE:RawFile

FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;\'"()!+,@|#?)
FIELDTYPE:Invalid_Int:ALLOW(0123456789.)
FIELDTYPE:Invalid_Num:ALLOW(0123456789/-.?)

FIELD:ip_rng_beg:LIKE(Invalid_Int):TYPE(STRING20):0,0
FIELD:ip_rng_end:LIKE(Invalid_Int):TYPE(STRING20):0,0
FIELD:edge_country:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:edge_region:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:edge_city:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:edge_conn_speed:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:edge_metro_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_latitude:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:edge_longitude:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:edge_postal_code:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:edge_country_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_region_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_city_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_continent_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_two_letter_country:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:edge_internal_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_area_codes:LIKE(Invalid_Num):TYPE(STRING20):0,0
FIELD:edge_country_conf:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_region_conf:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_city_conf:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_postal_conf:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:edge_gmt_offset:LIKE(Invalid_Num):TYPE(INTEGER8):0,0
FIELD:edge_in_dst:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:sic_code:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:domain_name:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:isp_name:LIKE(Invalid_Char):TYPE(STRING200):0,0
FIELD:homebiz_TYPE:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:asn:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:asn_name:LIKE(Invalid_Char):TYPE(STRING200):0,0
FIELD:primary_lang:LIKE(Invalid_Char):TYPE(STRING40):0,0
FIELD:secondary_lang:LIKE(Invalid_Char):TYPE(STRING105):0,0
FIELD:proxy_TYPE:LIKE(Invalid_Char):TYPE(STRING15):0,0
FIELD:proxy_description:LIKE(Invalid_Char):TYPE(STRING15):0,0
FIELD:is_an_isp:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:company_name:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:ranks:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:households:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:women:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:w18_34:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:w35_49:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:men:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:m18_34:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:m35_49:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:teens:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:kids:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:naics_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:cbsa_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:cbsa_title:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:cbsa_TYPE:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:csa_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:csa_title:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:md_code:LIKE(Invalid_Int):TYPE(UNSIGNED8):0,0
FIELD:md_title:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:organization_name:LIKE(Invalid_Char):TYPE(STRING100):0,0

