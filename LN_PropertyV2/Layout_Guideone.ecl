export Layout_Guideone := module 
export in_ := record 
string policy ;
string lastname ;
string firstname ;
string mid ;
string suff;
string ssn ;
string mailing_addr ;
string mailing_city ;
string mailing_st ;
string mailing_zip; 
string prop_street_addr;
string prop_city;
string prop_st ;
string prop_zip ;
string coverage_A; 
end; 
export base := RECORD
  string10 policy;
  string20 lastname;
  string20 firstname;
  string20 mid;
  string5 suff;
  string9 ssn;
  string100 mailing_addr;
  string50 mailing_city;
  string2 mailing_st;
  string5 mailing_zip;
  string100 prop_street_addr;
  string50  prop_city;
  string2 prop_st;
  string5 prop_zip;
  string10 coverage_a;
  integer8 rawaid; //
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 ln_fares_id;
  string8 process_date;
  string2 source_code;
string5 Source,
string1 vendor_source_flag, 
string KeyScore,
string Total_Score,
string Type_,
string100 INDV_STR_ADDR_DATA,
string50 INDV_CITY_ADDR_DATA,
string2 INDV_STATE_ADDR_DATA,
string5 INDV_ZIP_ADDR_DATA,
string30 INDV_CNTY_NAME,
string10 NDV_CNSS_TRCT,
string8 LIVING_AREA_SQFTG,
string30 NUM_OF_STORIES,
string5 NUM_OF_BDRMS,
string8 NUM_OF_BATHS,
string3 NUM_OF_FIREPLACES,
string1 POOL_IND,
string1 AC_IND,
string3 QA_OF_STRUCT_CD,
string1 FIREPLACE_IND,
string5 NUM_OF_UNITS,
string5 NUM_OF_ROOMS,
string8 NUM_OF_FULL_BATHS,
string2 NUM_OF_HALF_BATHS,
string5 NUM_OF_BATH_FIXTURES,
string4 YY_BUILT,
string4 EFCTV_YY_BUILT,
string10 BLDG_SQFTG,
string8 GROUND_FLR_SQFTG,
string8 BASEMENT_SQFTG,
string8 GARAGE_SQFTG,
string3 Air_conditioning_type_code ,
string3 Basement_finish_type ,
string3 Exterior_wall_type ,
string15 Fireplace_type ,
string3 Floor_type ,
string3 Foundation_type ,
string15 Frame_type ,
string3 Garage_Carport_type ,
string3 Heating_type ,
string3 Fuel_type ,
string4 Land_use_code ,
string15 Parking_type ,
string3 Pool_type ,
string3 Property_type_code, 
string3 Roof_cover_type ,
string3 Sewer_type ,
string15 Stories_type ,
string5 Style_type ,
string3 Construction_type ,
string3 Water_type ,
string250 LEGAL_DESC,
string45 PARCEL_NUM,
string5 FIPS_CD,
string45 APN_NUM,
string7 BLCK_NUM,
string7 LOT_NUM,
string40 SUBDIVISION_NAME,
string30 TOWNSHIP ,
string30 MUNI_NAME,
string7 SECTN,
string25 ZONING_DESC,
string5 LOC_OF_INFLUENCE_CD,
string3 PROP_TYP_CD,
string11 LATITUDE,
string11 LONGITUDE,
string20 LOT_SIZE,
string10 LOT_FRNT_FTG,
string10 LOT_DEPTH_FTG,
string10 ACRES,
string11 TOT_ASSESSED_VAL,
string11 TOT_CALC_VAL,
string11 TOT_MKT_VAL,
string11 TOT_LAND_VAL,
string11 MKT_LAND_VAL,
string11 ASSESSED_LAND_VAL,
string11 IMPRV_VAL,
string4 ASSESSED_YY,
string18 TAX_CD,
string4 TAX_BILING_YY,
string1 HOMESTEAD_EXEMPS_IND,
string13 TAX_AMT,
udecimal5_2 PCT_IMPRVD,
string49 MTG_CO_NAME , 
string11 LOAN_AMT ,
string5 LOAN_TYP_CD  ,
string5 INTEREST_RATE_TYP_CD,
string8 RCRD_DTE,
string8 SALES_DTE,
string20 DOC_NUM,
string11 SALES_AMT,
string3 SALES_TYP_CD,
string1 SALE_FULL_PART, 
string2 lf := '\r\n' 
 END;

// integers to string 

export base_final := RECORD
  string10 policy;
  string20 lastname;
  string20 firstname;
  string20 mid;
  string5 suff;
  string9 ssn;
  string100 mailing_addr;
  string50 mailing_city;
  string2 mailing_st;
  string5 mailing_zip;
  string100 prop_street_addr;
  string50  prop_city;
  string2 prop_st;
  string5 prop_zip;
  string10 coverage_a;
  string25 rawaid; //
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 ln_fares_id;
  string8 process_date;
  string2 source_code;
string5 Source,
string1 vendor_source_flag, 
string KeyScore,
string Total_Score,
string Type_,
string100 INDV_STR_ADDR_DATA,
string50 INDV_CITY_ADDR_DATA,
string2 INDV_STATE_ADDR_DATA,
string5 INDV_ZIP_ADDR_DATA,
string30 INDV_CNTY_NAME,
string10 NDV_CNSS_TRCT,
string8 LIVING_AREA_SQFTG,
string30 NUM_OF_STORIES,
string5 NUM_OF_BDRMS,
string8 NUM_OF_BATHS,
string3 NUM_OF_FIREPLACES,
string1 POOL_IND,
string1 AC_IND,
string3 QA_OF_STRUCT_CD,
string1 FIREPLACE_IND,
string5 NUM_OF_UNITS,
string5 NUM_OF_ROOMS,
string8 NUM_OF_FULL_BATHS,
string2 NUM_OF_HALF_BATHS,
string5 NUM_OF_BATH_FIXTURES,
string4 YY_BUILT,
string4 EFCTV_YY_BUILT,
string10 BLDG_SQFTG,
string8 GROUND_FLR_SQFTG,
string8 BASEMENT_SQFTG,
string8 GARAGE_SQFTG,
string3 Air_conditioning_type_code ,
string3 Basement_finish_type ,
string3 Exterior_wall_type ,
string15 Fireplace_type ,
string3 Floor_type ,
string3 Foundation_type ,
string15 Frame_type ,
string3 Garage_Carport_type ,
string3 Heating_type ,
string3 Fuel_type ,
string4 Land_use_code ,
string15 Parking_type ,
string3 Pool_type ,
string3 Property_type_code, 
string3 Roof_cover_type ,
string3 Sewer_type ,
string15 Stories_type ,
string5 Style_type ,
string3 Construction_type ,
string3 Water_type ,
string250 LEGAL_DESC,
string45 PARCEL_NUM,
string5 FIPS_CD,
string45 APN_NUM,
string7 BLCK_NUM,
string7 LOT_NUM,
string40 SUBDIVISION_NAME,
string30 TOWNSHIP ,
string30 MUNI_NAME,
string7 SECTN,
string25 ZONING_DESC,
string5 LOC_OF_INFLUENCE_CD,
string3 PROP_TYP_CD,
string11 LATITUDE,
string11 LONGITUDE,
string20 LOT_SIZE,
string10 LOT_FRNT_FTG,
string10 LOT_DEPTH_FTG,
string10 ACRES,
string11 TOT_ASSESSED_VAL,
string11 TOT_CALC_VAL,
string11 TOT_MKT_VAL,
string11 TOT_LAND_VAL,
string11 MKT_LAND_VAL,
string11 ASSESSED_LAND_VAL,
string11 IMPRV_VAL,
string4 ASSESSED_YY,
string18 TAX_CD,
string4 TAX_BILING_YY,
string1 HOMESTEAD_EXEMPS_IND,
string13 TAX_AMT,
string25 PCT_IMPRVD,
string49 MTG_CO_NAME , 
string11 LOAN_AMT ,
string5 LOAN_TYP_CD  ,
string5 INTEREST_RATE_TYP_CD,
string8 RCRD_DTE,
string8 SALES_DTE,
string20 DOC_NUM,
string11 SALES_AMT,
string3 SALES_TYP_CD,
string1 SALE_FULL_PART, 
string2 lf := '\r\n' 
 END;
end; 