IMPORT AID,BIPV2;
EXPORT Layouts := MODULE

 EXPORT raw := RECORD

  STRING17  file_key;
  STRING6   date_updated;
  STRING2   type_instituon_code;
  STRING2   head_office_branch_codes;
  STRING9   routing_number_MICR;
  STRING11  routing_number_fractional;
  STRING158 institution_name_full;
  STRING50  institution_name_abbreviated;
  STRING40  street_address;
  STRING30  city_town;
  STRING2   state;
  STRING5   zip_code;
  STRING4   zip_4;
  STRING40  mail_address;
  STRING30  mail_city_town;
  STRING2   mail_state;
  STRING5   mail_zip_code;
  STRING4   mail_zip_4;
  STRING30  branch_office_name;
  STRING9   head_office_routing_number;
  STRING3   phone_number_area_code;
  STRING7   phone_number;
  STRING5   phone_number_extension;
  STRING3   fax_area_code;
  STRING7   fax_number;
  STRING5   fax_extension;
  STRING13  head_office_asset_size;
  STRING6   federal_reserve_district_code;
  STRING8   year_2000_date_last_updated;
  STRING17  head_office_file_key;
  STRING28  routing_number_type;
  STRING7   filler1;
  STRING4   filler2;
  STRING1   routing_number_status;
  STRING10  employer_tax_id;
  STRING8   institution_identifier;
  STRING65  filler3;

 END;

 EXPORT base := RECORD
  
  UNSIGNED8 rcid;
  STRING8   process_date;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
	STRING1   current_record;
    
  STRING17  file_key;
  STRING6   date_updated;
  STRING2   type_instituon_code;
  STRING2   head_office_branch_codes;
  STRING9   routing_number_MICR;
  STRING11  routing_number_fractional;
  STRING158 institution_name_full;
  STRING50  institution_name_abbreviated;
  STRING40  street_address;
  STRING30  city_town;
  STRING2   state;
  STRING5   zip_code;
  STRING4   zip_4;
  STRING40  mail_address;
  STRING30  mail_city_town;
  STRING2   mail_state;
  STRING5   mail_zip_code;
  STRING4   mail_zip_4;
  STRING30  branch_office_name;
  STRING9   head_office_routing_number;
  STRING3   phone_number_area_code;
  STRING7   phone_number;
  STRING5   phone_number_extension;
  STRING3   fax_area_code;
  STRING7   fax_number;
  STRING5   fax_extension;
  STRING13  head_office_asset_size;
  STRING6   federal_reserve_district_code;
  STRING8   year_2000_date_last_updated;
  STRING17  head_office_file_key;
  STRING28  routing_number_type;
  STRING1   routing_number_status;
  STRING10  employer_tax_id;
  STRING8   institution_identifier;

  STRING8   s_date_updated;
  STRING8   s_year_2000_date_last_updated;
  AID.Common.xAID  RawAID;
	STRING1   address_type;
  STRING10  prim_range;
  STRING2   predir;
  STRING28  prim_name;
  STRING4   addr_suffix;
  STRING2   postdir;
  STRING10  unit_desig;
  STRING8   sec_range;
  STRING25  p_city_name;
  STRING25  v_city_name;
  STRING2   st;
  STRING5   zip;
  STRING4   zip4;
  STRING4   cart;
  STRING1   cr_sort_sz;
  STRING4   lot;
  STRING1   lot_order;
  STRING2   dpbc;
  STRING1   chk_digit;
  STRING2   rec_type;
  STRING5   county;
  STRING2   ace_fips_st;
  STRING3   fips_county;
  STRING10  geo_lat;
  STRING11  geo_long;
  STRING4   msa;
  STRING7   geo_blk;
  STRING1   geo_match;
  STRING4   err_stat;
  BIPV2.IDlayouts.l_xlink_ids;
  UNSIGNED8 source_rec_id;
  
 END;

 EXPORT Base_WithRT := RECORD
  base;
  UNSIGNED1 __Tpe;
 END;

 EXPORT base_rtn := RECORD

  STRING9   routing_number_MICR;
  STRING2   state;
  STRING30  city_town;
  STRING5   zip_code;
  STRING40  street_address;
  STRING4   zip_4;
  STRING11  routing_number_fractional;
  STRING2   head_office_branch_codes;
  STRING158 institution_name_full;
  STRING50  institution_name_abbreviated;
  STRING40  mail_address;
  STRING30  mail_city_town;
  STRING2   mail_state;
  STRING5   mail_zip_code;
  STRING4   mail_zip_4;
  STRING30  branch_office_name;
  STRING9   head_office_routing_number;
  STRING3   phone_number_area_code;
  STRING7   phone_number;
  STRING5   phone_number_extension;

 END;
 
END;