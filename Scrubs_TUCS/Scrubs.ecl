IMPORT ut,SALT34;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 filetype_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 vendordocumentidentifier_Invalid;
    UNSIGNED1 transferdate_Invalid;
    UNSIGNED1 currentname_firstname_Invalid;
    UNSIGNED1 currentname_middlename_Invalid;
    UNSIGNED1 currentname_middleinitial_Invalid;
    UNSIGNED1 currentname_lastname_Invalid;
    UNSIGNED1 currentname_suffix_Invalid;
    UNSIGNED1 currentname_gender_Invalid;
    UNSIGNED1 currentname_dob_mm_Invalid;
    UNSIGNED1 currentname_dob_dd_Invalid;
    UNSIGNED1 currentname_dob_yyyy_Invalid;
    UNSIGNED1 currentname_deathindicator_Invalid;
    UNSIGNED1 ssnfull_Invalid;
    UNSIGNED1 ssnfirst5digit_Invalid;
    UNSIGNED1 ssnlast4digit_Invalid;
    UNSIGNED1 consumerupdatedate_Invalid;
    UNSIGNED1 telephonenumber_Invalid;
    UNSIGNED1 citedid_Invalid;
    UNSIGNED1 fileid_Invalid;
    UNSIGNED1 publication_Invalid;
    UNSIGNED1 currentaddress_address1_Invalid;
    UNSIGNED1 currentaddress_address2_Invalid;
    UNSIGNED1 currentaddress_city_Invalid;
    UNSIGNED1 currentaddress_state_Invalid;
    UNSIGNED1 currentaddress_zipcode_Invalid;
    UNSIGNED1 currentaddress_updateddate_Invalid;
    UNSIGNED1 housenumber_Invalid;
    UNSIGNED1 streettype_Invalid;
    UNSIGNED1 streetdirection_Invalid;
    UNSIGNED1 streetname_Invalid;
    UNSIGNED1 apartmentnumber_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 zip4u_Invalid;
    UNSIGNED1 previousaddress_address1_Invalid;
    UNSIGNED1 previousaddress_address2_Invalid;
    UNSIGNED1 previousaddress_city_Invalid;
    UNSIGNED1 previousaddress_state_Invalid;
    UNSIGNED1 previousaddress_zipcode_Invalid;
    UNSIGNED1 previousaddress_updateddate_Invalid;
    UNSIGNED1 formername_firstname_Invalid;
    UNSIGNED1 formername_middlename_Invalid;
    UNSIGNED1 formername_middleinitial_Invalid;
    UNSIGNED1 formername_lastname_Invalid;
    UNSIGNED1 formername_suffix_Invalid;
    UNSIGNED1 aliasname_firstname_Invalid;
    UNSIGNED1 aliasname_middlename_Invalid;
    UNSIGNED1 aliasname_middleinitial_Invalid;
    UNSIGNED1 aliasname_lastname_Invalid;
    UNSIGNED1 aliasname_suffix_Invalid;
    UNSIGNED1 additionalname_firstname_Invalid;
    UNSIGNED1 additionalname_middlename_Invalid;
    UNSIGNED1 additionalname_middleinitial_Invalid;
    UNSIGNED1 additionalname_lastname_Invalid;
    UNSIGNED1 additionalname_suffix_Invalid;
    UNSIGNED1 aka1_Invalid;
    UNSIGNED1 aka2_Invalid;
    UNSIGNED1 aka3_Invalid;
    UNSIGNED1 recordtype_Invalid;
    UNSIGNED1 addressstandardization_Invalid;
    UNSIGNED1 filesincedate_Invalid;
    UNSIGNED1 compilationdate_Invalid;
    UNSIGNED1 birthdateind_Invalid;
    UNSIGNED1 orig_deceasedindicator_Invalid;
    UNSIGNED1 deceaseddate_Invalid;
    UNSIGNED1 addressseq_Invalid;
    UNSIGNED1 normaddress_address1_Invalid;
    UNSIGNED1 normaddress_address2_Invalid;
    UNSIGNED1 normaddress_city_Invalid;
    UNSIGNED1 normaddress_state_Invalid;
    UNSIGNED1 normaddress_zipcode_Invalid;
    UNSIGNED1 normaddress_updateddate_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 nametype_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 transferdate_unformatted_Invalid;
    UNSIGNED1 birthdate_unformatted_Invalid;
    UNSIGNED1 dob_no_conflict_Invalid;
    UNSIGNED1 updatedate_unformatted_Invalid;
    UNSIGNED1 consumerupdatedate_unformatted_Invalid;
    UNSIGNED1 filesincedate_unformatted_Invalid;
    UNSIGNED1 compilationdate_unformatted_Invalid;
    UNSIGNED1 ssn_unformatted_Invalid;
    UNSIGNED1 ssn_no_conflict_Invalid;
    UNSIGNED1 telephone_unformatted_Invalid;
    UNSIGNED1 deceasedindicator_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_field_Invalid;
    UNSIGNED1 is_current_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen);
      clean_dt_first_seen := (TYPEOF(le.dt_first_seen))Fields.Make_dt_first_seen((SALT34.StrType)le.dt_first_seen);
      clean_dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT34.StrType)clean_dt_first_seen);
      SELF.dt_first_seen := IF(withOnfail, clean_dt_first_seen, le.dt_first_seen); // ONFAIL(CLEAN)
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen);
      clean_dt_last_seen := (TYPEOF(le.dt_last_seen))Fields.Make_dt_last_seen((SALT34.StrType)le.dt_last_seen);
      clean_dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT34.StrType)clean_dt_last_seen);
      SELF.dt_last_seen := IF(withOnfail, clean_dt_last_seen, le.dt_last_seen); // ONFAIL(CLEAN)
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported);
      clean_dt_vendor_first_reported := (TYPEOF(le.dt_vendor_first_reported))Fields.Make_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported);
      clean_dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT34.StrType)clean_dt_vendor_first_reported);
      SELF.dt_vendor_first_reported := IF(withOnfail, clean_dt_vendor_first_reported, le.dt_vendor_first_reported); // ONFAIL(CLEAN)
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported);
      clean_dt_vendor_last_reported := (TYPEOF(le.dt_vendor_last_reported))Fields.Make_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported);
      clean_dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT34.StrType)clean_dt_vendor_last_reported);
      SELF.dt_vendor_last_reported := IF(withOnfail, clean_dt_vendor_last_reported, le.dt_vendor_last_reported); // ONFAIL(CLEAN)
    SELF.filetype_Invalid := Fields.InValid_filetype((SALT34.StrType)le.filetype);
      clean_filetype := (TYPEOF(le.filetype))Fields.Make_filetype((SALT34.StrType)le.filetype);
      clean_filetype_Invalid := Fields.InValid_filetype((SALT34.StrType)clean_filetype);
      SELF.filetype := IF(withOnfail, clean_filetype, le.filetype); // ONFAIL(CLEAN)
    SELF.filedate_Invalid := Fields.InValid_filedate((SALT34.StrType)le.filedate);
      clean_filedate := (TYPEOF(le.filedate))Fields.Make_filedate((SALT34.StrType)le.filedate);
      clean_filedate_Invalid := Fields.InValid_filedate((SALT34.StrType)clean_filedate);
      SELF.filedate := IF(withOnfail, clean_filedate, le.filedate); // ONFAIL(CLEAN)
    SELF.vendordocumentidentifier_Invalid := Fields.InValid_vendordocumentidentifier((SALT34.StrType)le.vendordocumentidentifier);
      clean_vendordocumentidentifier := (TYPEOF(le.vendordocumentidentifier))Fields.Make_vendordocumentidentifier((SALT34.StrType)le.vendordocumentidentifier);
      clean_vendordocumentidentifier_Invalid := Fields.InValid_vendordocumentidentifier((SALT34.StrType)clean_vendordocumentidentifier);
      SELF.vendordocumentidentifier := IF(withOnfail, clean_vendordocumentidentifier, le.vendordocumentidentifier); // ONFAIL(CLEAN)
    SELF.transferdate_Invalid := Fields.InValid_transferdate((SALT34.StrType)le.transferdate);
      clean_transferdate := (TYPEOF(le.transferdate))Fields.Make_transferdate((SALT34.StrType)le.transferdate);
      clean_transferdate_Invalid := Fields.InValid_transferdate((SALT34.StrType)clean_transferdate);
      SELF.transferdate := IF(withOnfail, clean_transferdate, le.transferdate); // ONFAIL(CLEAN)
    SELF.currentname_firstname_Invalid := Fields.InValid_currentname_firstname((SALT34.StrType)le.currentname_firstname);
      clean_currentname_firstname := (TYPEOF(le.currentname_firstname))Fields.Make_currentname_firstname((SALT34.StrType)le.currentname_firstname);
      clean_currentname_firstname_Invalid := Fields.InValid_currentname_firstname((SALT34.StrType)clean_currentname_firstname);
      SELF.currentname_firstname := IF(withOnfail, clean_currentname_firstname, le.currentname_firstname); // ONFAIL(CLEAN)
    SELF.currentname_middlename_Invalid := Fields.InValid_currentname_middlename((SALT34.StrType)le.currentname_middlename);
      clean_currentname_middlename := (TYPEOF(le.currentname_middlename))Fields.Make_currentname_middlename((SALT34.StrType)le.currentname_middlename);
      clean_currentname_middlename_Invalid := Fields.InValid_currentname_middlename((SALT34.StrType)clean_currentname_middlename);
      SELF.currentname_middlename := IF(withOnfail, clean_currentname_middlename, le.currentname_middlename); // ONFAIL(CLEAN)
    SELF.currentname_middleinitial_Invalid := Fields.InValid_currentname_middleinitial((SALT34.StrType)le.currentname_middleinitial);
      clean_currentname_middleinitial := (TYPEOF(le.currentname_middleinitial))Fields.Make_currentname_middleinitial((SALT34.StrType)le.currentname_middleinitial);
      clean_currentname_middleinitial_Invalid := Fields.InValid_currentname_middleinitial((SALT34.StrType)clean_currentname_middleinitial);
      SELF.currentname_middleinitial := IF(withOnfail, clean_currentname_middleinitial, le.currentname_middleinitial); // ONFAIL(CLEAN)
    SELF.currentname_lastname_Invalid := Fields.InValid_currentname_lastname((SALT34.StrType)le.currentname_lastname);
      clean_currentname_lastname := (TYPEOF(le.currentname_lastname))Fields.Make_currentname_lastname((SALT34.StrType)le.currentname_lastname);
      clean_currentname_lastname_Invalid := Fields.InValid_currentname_lastname((SALT34.StrType)clean_currentname_lastname);
      SELF.currentname_lastname := IF(withOnfail, clean_currentname_lastname, le.currentname_lastname); // ONFAIL(CLEAN)
    SELF.currentname_suffix_Invalid := Fields.InValid_currentname_suffix((SALT34.StrType)le.currentname_suffix);
      clean_currentname_suffix := (TYPEOF(le.currentname_suffix))Fields.Make_currentname_suffix((SALT34.StrType)le.currentname_suffix);
      clean_currentname_suffix_Invalid := Fields.InValid_currentname_suffix((SALT34.StrType)clean_currentname_suffix);
      SELF.currentname_suffix := IF(withOnfail, clean_currentname_suffix, le.currentname_suffix); // ONFAIL(CLEAN)
    SELF.currentname_gender_Invalid := Fields.InValid_currentname_gender((SALT34.StrType)le.currentname_gender);
      clean_currentname_gender := (TYPEOF(le.currentname_gender))Fields.Make_currentname_gender((SALT34.StrType)le.currentname_gender);
      clean_currentname_gender_Invalid := Fields.InValid_currentname_gender((SALT34.StrType)clean_currentname_gender);
      SELF.currentname_gender := IF(withOnfail, clean_currentname_gender, le.currentname_gender); // ONFAIL(CLEAN)
    SELF.currentname_dob_mm_Invalid := Fields.InValid_currentname_dob_mm((SALT34.StrType)le.currentname_dob_mm);
      clean_currentname_dob_mm := (TYPEOF(le.currentname_dob_mm))Fields.Make_currentname_dob_mm((SALT34.StrType)le.currentname_dob_mm);
      clean_currentname_dob_mm_Invalid := Fields.InValid_currentname_dob_mm((SALT34.StrType)clean_currentname_dob_mm);
      SELF.currentname_dob_mm := IF(withOnfail, clean_currentname_dob_mm, le.currentname_dob_mm); // ONFAIL(CLEAN)
    SELF.currentname_dob_dd_Invalid := Fields.InValid_currentname_dob_dd((SALT34.StrType)le.currentname_dob_dd);
      clean_currentname_dob_dd := (TYPEOF(le.currentname_dob_dd))Fields.Make_currentname_dob_dd((SALT34.StrType)le.currentname_dob_dd);
      clean_currentname_dob_dd_Invalid := Fields.InValid_currentname_dob_dd((SALT34.StrType)clean_currentname_dob_dd);
      SELF.currentname_dob_dd := IF(withOnfail, clean_currentname_dob_dd, le.currentname_dob_dd); // ONFAIL(CLEAN)
    SELF.currentname_dob_yyyy_Invalid := Fields.InValid_currentname_dob_yyyy((SALT34.StrType)le.currentname_dob_yyyy);
      clean_currentname_dob_yyyy := (TYPEOF(le.currentname_dob_yyyy))Fields.Make_currentname_dob_yyyy((SALT34.StrType)le.currentname_dob_yyyy);
      clean_currentname_dob_yyyy_Invalid := Fields.InValid_currentname_dob_yyyy((SALT34.StrType)clean_currentname_dob_yyyy);
      SELF.currentname_dob_yyyy := IF(withOnfail, clean_currentname_dob_yyyy, le.currentname_dob_yyyy); // ONFAIL(CLEAN)
    SELF.currentname_deathindicator_Invalid := Fields.InValid_currentname_deathindicator((SALT34.StrType)le.currentname_deathindicator);
      clean_currentname_deathindicator := (TYPEOF(le.currentname_deathindicator))Fields.Make_currentname_deathindicator((SALT34.StrType)le.currentname_deathindicator);
      clean_currentname_deathindicator_Invalid := Fields.InValid_currentname_deathindicator((SALT34.StrType)clean_currentname_deathindicator);
      SELF.currentname_deathindicator := IF(withOnfail, clean_currentname_deathindicator, le.currentname_deathindicator); // ONFAIL(CLEAN)
    SELF.ssnfull_Invalid := Fields.InValid_ssnfull((SALT34.StrType)le.ssnfull);
      clean_ssnfull := (TYPEOF(le.ssnfull))Fields.Make_ssnfull((SALT34.StrType)le.ssnfull);
      clean_ssnfull_Invalid := Fields.InValid_ssnfull((SALT34.StrType)clean_ssnfull);
      SELF.ssnfull := IF(withOnfail, clean_ssnfull, le.ssnfull); // ONFAIL(CLEAN)
    SELF.ssnfirst5digit_Invalid := Fields.InValid_ssnfirst5digit((SALT34.StrType)le.ssnfirst5digit);
      clean_ssnfirst5digit := (TYPEOF(le.ssnfirst5digit))Fields.Make_ssnfirst5digit((SALT34.StrType)le.ssnfirst5digit);
      clean_ssnfirst5digit_Invalid := Fields.InValid_ssnfirst5digit((SALT34.StrType)clean_ssnfirst5digit);
      SELF.ssnfirst5digit := IF(withOnfail, clean_ssnfirst5digit, le.ssnfirst5digit); // ONFAIL(CLEAN)
    SELF.ssnlast4digit_Invalid := Fields.InValid_ssnlast4digit((SALT34.StrType)le.ssnlast4digit);
      clean_ssnlast4digit := (TYPEOF(le.ssnlast4digit))Fields.Make_ssnlast4digit((SALT34.StrType)le.ssnlast4digit);
      clean_ssnlast4digit_Invalid := Fields.InValid_ssnlast4digit((SALT34.StrType)clean_ssnlast4digit);
      SELF.ssnlast4digit := IF(withOnfail, clean_ssnlast4digit, le.ssnlast4digit); // ONFAIL(CLEAN)
    SELF.consumerupdatedate_Invalid := Fields.InValid_consumerupdatedate((SALT34.StrType)le.consumerupdatedate);
      clean_consumerupdatedate := (TYPEOF(le.consumerupdatedate))Fields.Make_consumerupdatedate((SALT34.StrType)le.consumerupdatedate);
      clean_consumerupdatedate_Invalid := Fields.InValid_consumerupdatedate((SALT34.StrType)clean_consumerupdatedate);
      SELF.consumerupdatedate := IF(withOnfail, clean_consumerupdatedate, le.consumerupdatedate); // ONFAIL(CLEAN)
    SELF.telephonenumber_Invalid := Fields.InValid_telephonenumber((SALT34.StrType)le.telephonenumber);
      clean_telephonenumber := (TYPEOF(le.telephonenumber))Fields.Make_telephonenumber((SALT34.StrType)le.telephonenumber);
      clean_telephonenumber_Invalid := Fields.InValid_telephonenumber((SALT34.StrType)clean_telephonenumber);
      SELF.telephonenumber := IF(withOnfail, clean_telephonenumber, le.telephonenumber); // ONFAIL(CLEAN)
    SELF.citedid_Invalid := Fields.InValid_citedid((SALT34.StrType)le.citedid);
      clean_citedid := (TYPEOF(le.citedid))Fields.Make_citedid((SALT34.StrType)le.citedid);
      clean_citedid_Invalid := Fields.InValid_citedid((SALT34.StrType)clean_citedid);
      SELF.citedid := IF(withOnfail, clean_citedid, le.citedid); // ONFAIL(CLEAN)
    SELF.fileid_Invalid := Fields.InValid_fileid((SALT34.StrType)le.fileid);
      clean_fileid := (TYPEOF(le.fileid))Fields.Make_fileid((SALT34.StrType)le.fileid);
      clean_fileid_Invalid := Fields.InValid_fileid((SALT34.StrType)clean_fileid);
      SELF.fileid := IF(withOnfail, clean_fileid, le.fileid); // ONFAIL(CLEAN)
    SELF.publication_Invalid := Fields.InValid_publication((SALT34.StrType)le.publication);
      clean_publication := (TYPEOF(le.publication))Fields.Make_publication((SALT34.StrType)le.publication);
      clean_publication_Invalid := Fields.InValid_publication((SALT34.StrType)clean_publication);
      SELF.publication := IF(withOnfail, clean_publication, le.publication); // ONFAIL(CLEAN)
    SELF.currentaddress_address1_Invalid := Fields.InValid_currentaddress_address1((SALT34.StrType)le.currentaddress_address1);
      clean_currentaddress_address1 := (TYPEOF(le.currentaddress_address1))Fields.Make_currentaddress_address1((SALT34.StrType)le.currentaddress_address1);
      clean_currentaddress_address1_Invalid := Fields.InValid_currentaddress_address1((SALT34.StrType)clean_currentaddress_address1);
      SELF.currentaddress_address1 := IF(withOnfail, clean_currentaddress_address1, le.currentaddress_address1); // ONFAIL(CLEAN)
    SELF.currentaddress_address2_Invalid := Fields.InValid_currentaddress_address2((SALT34.StrType)le.currentaddress_address2);
      clean_currentaddress_address2 := (TYPEOF(le.currentaddress_address2))Fields.Make_currentaddress_address2((SALT34.StrType)le.currentaddress_address2);
      clean_currentaddress_address2_Invalid := Fields.InValid_currentaddress_address2((SALT34.StrType)clean_currentaddress_address2);
      SELF.currentaddress_address2 := IF(withOnfail, clean_currentaddress_address2, le.currentaddress_address2); // ONFAIL(CLEAN)
    SELF.currentaddress_city_Invalid := Fields.InValid_currentaddress_city((SALT34.StrType)le.currentaddress_city);
      clean_currentaddress_city := (TYPEOF(le.currentaddress_city))Fields.Make_currentaddress_city((SALT34.StrType)le.currentaddress_city);
      clean_currentaddress_city_Invalid := Fields.InValid_currentaddress_city((SALT34.StrType)clean_currentaddress_city);
      SELF.currentaddress_city := IF(withOnfail, clean_currentaddress_city, le.currentaddress_city); // ONFAIL(CLEAN)
    SELF.currentaddress_state_Invalid := Fields.InValid_currentaddress_state((SALT34.StrType)le.currentaddress_state);
      clean_currentaddress_state := (TYPEOF(le.currentaddress_state))Fields.Make_currentaddress_state((SALT34.StrType)le.currentaddress_state);
      clean_currentaddress_state_Invalid := Fields.InValid_currentaddress_state((SALT34.StrType)clean_currentaddress_state);
      SELF.currentaddress_state := IF(withOnfail, clean_currentaddress_state, le.currentaddress_state); // ONFAIL(CLEAN)
    SELF.currentaddress_zipcode_Invalid := Fields.InValid_currentaddress_zipcode((SALT34.StrType)le.currentaddress_zipcode);
      clean_currentaddress_zipcode := (TYPEOF(le.currentaddress_zipcode))Fields.Make_currentaddress_zipcode((SALT34.StrType)le.currentaddress_zipcode);
      clean_currentaddress_zipcode_Invalid := Fields.InValid_currentaddress_zipcode((SALT34.StrType)clean_currentaddress_zipcode);
      SELF.currentaddress_zipcode := IF(withOnfail, clean_currentaddress_zipcode, le.currentaddress_zipcode); // ONFAIL(CLEAN)
    SELF.currentaddress_updateddate_Invalid := Fields.InValid_currentaddress_updateddate((SALT34.StrType)le.currentaddress_updateddate);
      clean_currentaddress_updateddate := (TYPEOF(le.currentaddress_updateddate))Fields.Make_currentaddress_updateddate((SALT34.StrType)le.currentaddress_updateddate);
      clean_currentaddress_updateddate_Invalid := Fields.InValid_currentaddress_updateddate((SALT34.StrType)clean_currentaddress_updateddate);
      SELF.currentaddress_updateddate := IF(withOnfail, clean_currentaddress_updateddate, le.currentaddress_updateddate); // ONFAIL(CLEAN)
    SELF.housenumber_Invalid := Fields.InValid_housenumber((SALT34.StrType)le.housenumber);
      clean_housenumber := (TYPEOF(le.housenumber))Fields.Make_housenumber((SALT34.StrType)le.housenumber);
      clean_housenumber_Invalid := Fields.InValid_housenumber((SALT34.StrType)clean_housenumber);
      SELF.housenumber := IF(withOnfail, clean_housenumber, le.housenumber); // ONFAIL(CLEAN)
    SELF.streettype_Invalid := Fields.InValid_streettype((SALT34.StrType)le.streettype);
      clean_streettype := (TYPEOF(le.streettype))Fields.Make_streettype((SALT34.StrType)le.streettype);
      clean_streettype_Invalid := Fields.InValid_streettype((SALT34.StrType)clean_streettype);
      SELF.streettype := IF(withOnfail, clean_streettype, le.streettype); // ONFAIL(CLEAN)
    SELF.streetdirection_Invalid := Fields.InValid_streetdirection((SALT34.StrType)le.streetdirection);
      clean_streetdirection := (TYPEOF(le.streetdirection))Fields.Make_streetdirection((SALT34.StrType)le.streetdirection);
      clean_streetdirection_Invalid := Fields.InValid_streetdirection((SALT34.StrType)clean_streetdirection);
      SELF.streetdirection := IF(withOnfail, clean_streetdirection, le.streetdirection); // ONFAIL(CLEAN)
    SELF.streetname_Invalid := Fields.InValid_streetname((SALT34.StrType)le.streetname);
      clean_streetname := (TYPEOF(le.streetname))Fields.Make_streetname((SALT34.StrType)le.streetname);
      clean_streetname_Invalid := Fields.InValid_streetname((SALT34.StrType)clean_streetname);
      SELF.streetname := IF(withOnfail, clean_streetname, le.streetname); // ONFAIL(CLEAN)
    SELF.apartmentnumber_Invalid := Fields.InValid_apartmentnumber((SALT34.StrType)le.apartmentnumber);
      clean_apartmentnumber := (TYPEOF(le.apartmentnumber))Fields.Make_apartmentnumber((SALT34.StrType)le.apartmentnumber);
      clean_apartmentnumber_Invalid := Fields.InValid_apartmentnumber((SALT34.StrType)clean_apartmentnumber);
      SELF.apartmentnumber := IF(withOnfail, clean_apartmentnumber, le.apartmentnumber); // ONFAIL(CLEAN)
    SELF.city_Invalid := Fields.InValid_city((SALT34.StrType)le.city);
      clean_city := (TYPEOF(le.city))Fields.Make_city((SALT34.StrType)le.city);
      clean_city_Invalid := Fields.InValid_city((SALT34.StrType)clean_city);
      SELF.city := IF(withOnfail, clean_city, le.city); // ONFAIL(CLEAN)
    SELF.state_Invalid := Fields.InValid_state((SALT34.StrType)le.state);
      clean_state := (TYPEOF(le.state))Fields.Make_state((SALT34.StrType)le.state);
      clean_state_Invalid := Fields.InValid_state((SALT34.StrType)clean_state);
      SELF.state := IF(withOnfail, clean_state, le.state); // ONFAIL(CLEAN)
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT34.StrType)le.zipcode);
      clean_zipcode := (TYPEOF(le.zipcode))Fields.Make_zipcode((SALT34.StrType)le.zipcode);
      clean_zipcode_Invalid := Fields.InValid_zipcode((SALT34.StrType)clean_zipcode);
      SELF.zipcode := IF(withOnfail, clean_zipcode, le.zipcode); // ONFAIL(CLEAN)
    SELF.zip4u_Invalid := Fields.InValid_zip4u((SALT34.StrType)le.zip4u);
      clean_zip4u := (TYPEOF(le.zip4u))Fields.Make_zip4u((SALT34.StrType)le.zip4u);
      clean_zip4u_Invalid := Fields.InValid_zip4u((SALT34.StrType)clean_zip4u);
      SELF.zip4u := IF(withOnfail, clean_zip4u, le.zip4u); // ONFAIL(CLEAN)
    SELF.previousaddress_address1_Invalid := Fields.InValid_previousaddress_address1((SALT34.StrType)le.previousaddress_address1);
      clean_previousaddress_address1 := (TYPEOF(le.previousaddress_address1))Fields.Make_previousaddress_address1((SALT34.StrType)le.previousaddress_address1);
      clean_previousaddress_address1_Invalid := Fields.InValid_previousaddress_address1((SALT34.StrType)clean_previousaddress_address1);
      SELF.previousaddress_address1 := IF(withOnfail, clean_previousaddress_address1, le.previousaddress_address1); // ONFAIL(CLEAN)
    SELF.previousaddress_address2_Invalid := Fields.InValid_previousaddress_address2((SALT34.StrType)le.previousaddress_address2);
      clean_previousaddress_address2 := (TYPEOF(le.previousaddress_address2))Fields.Make_previousaddress_address2((SALT34.StrType)le.previousaddress_address2);
      clean_previousaddress_address2_Invalid := Fields.InValid_previousaddress_address2((SALT34.StrType)clean_previousaddress_address2);
      SELF.previousaddress_address2 := IF(withOnfail, clean_previousaddress_address2, le.previousaddress_address2); // ONFAIL(CLEAN)
    SELF.previousaddress_city_Invalid := Fields.InValid_previousaddress_city((SALT34.StrType)le.previousaddress_city);
      clean_previousaddress_city := (TYPEOF(le.previousaddress_city))Fields.Make_previousaddress_city((SALT34.StrType)le.previousaddress_city);
      clean_previousaddress_city_Invalid := Fields.InValid_previousaddress_city((SALT34.StrType)clean_previousaddress_city);
      SELF.previousaddress_city := IF(withOnfail, clean_previousaddress_city, le.previousaddress_city); // ONFAIL(CLEAN)
    SELF.previousaddress_state_Invalid := Fields.InValid_previousaddress_state((SALT34.StrType)le.previousaddress_state);
      clean_previousaddress_state := (TYPEOF(le.previousaddress_state))Fields.Make_previousaddress_state((SALT34.StrType)le.previousaddress_state);
      clean_previousaddress_state_Invalid := Fields.InValid_previousaddress_state((SALT34.StrType)clean_previousaddress_state);
      SELF.previousaddress_state := IF(withOnfail, clean_previousaddress_state, le.previousaddress_state); // ONFAIL(CLEAN)
    SELF.previousaddress_zipcode_Invalid := Fields.InValid_previousaddress_zipcode((SALT34.StrType)le.previousaddress_zipcode);
      clean_previousaddress_zipcode := (TYPEOF(le.previousaddress_zipcode))Fields.Make_previousaddress_zipcode((SALT34.StrType)le.previousaddress_zipcode);
      clean_previousaddress_zipcode_Invalid := Fields.InValid_previousaddress_zipcode((SALT34.StrType)clean_previousaddress_zipcode);
      SELF.previousaddress_zipcode := IF(withOnfail, clean_previousaddress_zipcode, le.previousaddress_zipcode); // ONFAIL(CLEAN)
    SELF.previousaddress_updateddate_Invalid := Fields.InValid_previousaddress_updateddate((SALT34.StrType)le.previousaddress_updateddate);
      clean_previousaddress_updateddate := (TYPEOF(le.previousaddress_updateddate))Fields.Make_previousaddress_updateddate((SALT34.StrType)le.previousaddress_updateddate);
      clean_previousaddress_updateddate_Invalid := Fields.InValid_previousaddress_updateddate((SALT34.StrType)clean_previousaddress_updateddate);
      SELF.previousaddress_updateddate := IF(withOnfail, clean_previousaddress_updateddate, le.previousaddress_updateddate); // ONFAIL(CLEAN)
    SELF.formername_firstname_Invalid := Fields.InValid_formername_firstname((SALT34.StrType)le.formername_firstname);
      clean_formername_firstname := (TYPEOF(le.formername_firstname))Fields.Make_formername_firstname((SALT34.StrType)le.formername_firstname);
      clean_formername_firstname_Invalid := Fields.InValid_formername_firstname((SALT34.StrType)clean_formername_firstname);
      SELF.formername_firstname := IF(withOnfail, clean_formername_firstname, le.formername_firstname); // ONFAIL(CLEAN)
    SELF.formername_middlename_Invalid := Fields.InValid_formername_middlename((SALT34.StrType)le.formername_middlename);
      clean_formername_middlename := (TYPEOF(le.formername_middlename))Fields.Make_formername_middlename((SALT34.StrType)le.formername_middlename);
      clean_formername_middlename_Invalid := Fields.InValid_formername_middlename((SALT34.StrType)clean_formername_middlename);
      SELF.formername_middlename := IF(withOnfail, clean_formername_middlename, le.formername_middlename); // ONFAIL(CLEAN)
    SELF.formername_middleinitial_Invalid := Fields.InValid_formername_middleinitial((SALT34.StrType)le.formername_middleinitial);
      clean_formername_middleinitial := (TYPEOF(le.formername_middleinitial))Fields.Make_formername_middleinitial((SALT34.StrType)le.formername_middleinitial);
      clean_formername_middleinitial_Invalid := Fields.InValid_formername_middleinitial((SALT34.StrType)clean_formername_middleinitial);
      SELF.formername_middleinitial := IF(withOnfail, clean_formername_middleinitial, le.formername_middleinitial); // ONFAIL(CLEAN)
    SELF.formername_lastname_Invalid := Fields.InValid_formername_lastname((SALT34.StrType)le.formername_lastname);
      clean_formername_lastname := (TYPEOF(le.formername_lastname))Fields.Make_formername_lastname((SALT34.StrType)le.formername_lastname);
      clean_formername_lastname_Invalid := Fields.InValid_formername_lastname((SALT34.StrType)clean_formername_lastname);
      SELF.formername_lastname := IF(withOnfail, clean_formername_lastname, le.formername_lastname); // ONFAIL(CLEAN)
    SELF.formername_suffix_Invalid := Fields.InValid_formername_suffix((SALT34.StrType)le.formername_suffix);
      clean_formername_suffix := (TYPEOF(le.formername_suffix))Fields.Make_formername_suffix((SALT34.StrType)le.formername_suffix);
      clean_formername_suffix_Invalid := Fields.InValid_formername_suffix((SALT34.StrType)clean_formername_suffix);
      SELF.formername_suffix := IF(withOnfail, clean_formername_suffix, le.formername_suffix); // ONFAIL(CLEAN)
    SELF.aliasname_firstname_Invalid := Fields.InValid_aliasname_firstname((SALT34.StrType)le.aliasname_firstname);
      clean_aliasname_firstname := (TYPEOF(le.aliasname_firstname))Fields.Make_aliasname_firstname((SALT34.StrType)le.aliasname_firstname);
      clean_aliasname_firstname_Invalid := Fields.InValid_aliasname_firstname((SALT34.StrType)clean_aliasname_firstname);
      SELF.aliasname_firstname := IF(withOnfail, clean_aliasname_firstname, le.aliasname_firstname); // ONFAIL(CLEAN)
    SELF.aliasname_middlename_Invalid := Fields.InValid_aliasname_middlename((SALT34.StrType)le.aliasname_middlename);
      clean_aliasname_middlename := (TYPEOF(le.aliasname_middlename))Fields.Make_aliasname_middlename((SALT34.StrType)le.aliasname_middlename);
      clean_aliasname_middlename_Invalid := Fields.InValid_aliasname_middlename((SALT34.StrType)clean_aliasname_middlename);
      SELF.aliasname_middlename := IF(withOnfail, clean_aliasname_middlename, le.aliasname_middlename); // ONFAIL(CLEAN)
    SELF.aliasname_middleinitial_Invalid := Fields.InValid_aliasname_middleinitial((SALT34.StrType)le.aliasname_middleinitial);
      clean_aliasname_middleinitial := (TYPEOF(le.aliasname_middleinitial))Fields.Make_aliasname_middleinitial((SALT34.StrType)le.aliasname_middleinitial);
      clean_aliasname_middleinitial_Invalid := Fields.InValid_aliasname_middleinitial((SALT34.StrType)clean_aliasname_middleinitial);
      SELF.aliasname_middleinitial := IF(withOnfail, clean_aliasname_middleinitial, le.aliasname_middleinitial); // ONFAIL(CLEAN)
    SELF.aliasname_lastname_Invalid := Fields.InValid_aliasname_lastname((SALT34.StrType)le.aliasname_lastname);
      clean_aliasname_lastname := (TYPEOF(le.aliasname_lastname))Fields.Make_aliasname_lastname((SALT34.StrType)le.aliasname_lastname);
      clean_aliasname_lastname_Invalid := Fields.InValid_aliasname_lastname((SALT34.StrType)clean_aliasname_lastname);
      SELF.aliasname_lastname := IF(withOnfail, clean_aliasname_lastname, le.aliasname_lastname); // ONFAIL(CLEAN)
    SELF.aliasname_suffix_Invalid := Fields.InValid_aliasname_suffix((SALT34.StrType)le.aliasname_suffix);
      clean_aliasname_suffix := (TYPEOF(le.aliasname_suffix))Fields.Make_aliasname_suffix((SALT34.StrType)le.aliasname_suffix);
      clean_aliasname_suffix_Invalid := Fields.InValid_aliasname_suffix((SALT34.StrType)clean_aliasname_suffix);
      SELF.aliasname_suffix := IF(withOnfail, clean_aliasname_suffix, le.aliasname_suffix); // ONFAIL(CLEAN)
    SELF.additionalname_firstname_Invalid := Fields.InValid_additionalname_firstname((SALT34.StrType)le.additionalname_firstname);
      clean_additionalname_firstname := (TYPEOF(le.additionalname_firstname))Fields.Make_additionalname_firstname((SALT34.StrType)le.additionalname_firstname);
      clean_additionalname_firstname_Invalid := Fields.InValid_additionalname_firstname((SALT34.StrType)clean_additionalname_firstname);
      SELF.additionalname_firstname := IF(withOnfail, clean_additionalname_firstname, le.additionalname_firstname); // ONFAIL(CLEAN)
    SELF.additionalname_middlename_Invalid := Fields.InValid_additionalname_middlename((SALT34.StrType)le.additionalname_middlename);
      clean_additionalname_middlename := (TYPEOF(le.additionalname_middlename))Fields.Make_additionalname_middlename((SALT34.StrType)le.additionalname_middlename);
      clean_additionalname_middlename_Invalid := Fields.InValid_additionalname_middlename((SALT34.StrType)clean_additionalname_middlename);
      SELF.additionalname_middlename := IF(withOnfail, clean_additionalname_middlename, le.additionalname_middlename); // ONFAIL(CLEAN)
    SELF.additionalname_middleinitial_Invalid := Fields.InValid_additionalname_middleinitial((SALT34.StrType)le.additionalname_middleinitial);
      clean_additionalname_middleinitial := (TYPEOF(le.additionalname_middleinitial))Fields.Make_additionalname_middleinitial((SALT34.StrType)le.additionalname_middleinitial);
      clean_additionalname_middleinitial_Invalid := Fields.InValid_additionalname_middleinitial((SALT34.StrType)clean_additionalname_middleinitial);
      SELF.additionalname_middleinitial := IF(withOnfail, clean_additionalname_middleinitial, le.additionalname_middleinitial); // ONFAIL(CLEAN)
    SELF.additionalname_lastname_Invalid := Fields.InValid_additionalname_lastname((SALT34.StrType)le.additionalname_lastname);
      clean_additionalname_lastname := (TYPEOF(le.additionalname_lastname))Fields.Make_additionalname_lastname((SALT34.StrType)le.additionalname_lastname);
      clean_additionalname_lastname_Invalid := Fields.InValid_additionalname_lastname((SALT34.StrType)clean_additionalname_lastname);
      SELF.additionalname_lastname := IF(withOnfail, clean_additionalname_lastname, le.additionalname_lastname); // ONFAIL(CLEAN)
    SELF.additionalname_suffix_Invalid := Fields.InValid_additionalname_suffix((SALT34.StrType)le.additionalname_suffix);
      clean_additionalname_suffix := (TYPEOF(le.additionalname_suffix))Fields.Make_additionalname_suffix((SALT34.StrType)le.additionalname_suffix);
      clean_additionalname_suffix_Invalid := Fields.InValid_additionalname_suffix((SALT34.StrType)clean_additionalname_suffix);
      SELF.additionalname_suffix := IF(withOnfail, clean_additionalname_suffix, le.additionalname_suffix); // ONFAIL(CLEAN)
    SELF.aka1_Invalid := Fields.InValid_aka1((SALT34.StrType)le.aka1);
      clean_aka1 := (TYPEOF(le.aka1))Fields.Make_aka1((SALT34.StrType)le.aka1);
      clean_aka1_Invalid := Fields.InValid_aka1((SALT34.StrType)clean_aka1);
      SELF.aka1 := IF(withOnfail, clean_aka1, le.aka1); // ONFAIL(CLEAN)
    SELF.aka2_Invalid := Fields.InValid_aka2((SALT34.StrType)le.aka2);
      clean_aka2 := (TYPEOF(le.aka2))Fields.Make_aka2((SALT34.StrType)le.aka2);
      clean_aka2_Invalid := Fields.InValid_aka2((SALT34.StrType)clean_aka2);
      SELF.aka2 := IF(withOnfail, clean_aka2, le.aka2); // ONFAIL(CLEAN)
    SELF.aka3_Invalid := Fields.InValid_aka3((SALT34.StrType)le.aka3);
      clean_aka3 := (TYPEOF(le.aka3))Fields.Make_aka3((SALT34.StrType)le.aka3);
      clean_aka3_Invalid := Fields.InValid_aka3((SALT34.StrType)clean_aka3);
      SELF.aka3 := IF(withOnfail, clean_aka3, le.aka3); // ONFAIL(CLEAN)
    SELF.recordtype_Invalid := Fields.InValid_recordtype((SALT34.StrType)le.recordtype);
      clean_recordtype := (TYPEOF(le.recordtype))Fields.Make_recordtype((SALT34.StrType)le.recordtype);
      clean_recordtype_Invalid := Fields.InValid_recordtype((SALT34.StrType)clean_recordtype);
      SELF.recordtype := IF(withOnfail, clean_recordtype, le.recordtype); // ONFAIL(CLEAN)
    SELF.addressstandardization_Invalid := Fields.InValid_addressstandardization((SALT34.StrType)le.addressstandardization);
      clean_addressstandardization := (TYPEOF(le.addressstandardization))Fields.Make_addressstandardization((SALT34.StrType)le.addressstandardization);
      clean_addressstandardization_Invalid := Fields.InValid_addressstandardization((SALT34.StrType)clean_addressstandardization);
      SELF.addressstandardization := IF(withOnfail, clean_addressstandardization, le.addressstandardization); // ONFAIL(CLEAN)
    SELF.filesincedate_Invalid := Fields.InValid_filesincedate((SALT34.StrType)le.filesincedate);
      clean_filesincedate := (TYPEOF(le.filesincedate))Fields.Make_filesincedate((SALT34.StrType)le.filesincedate);
      clean_filesincedate_Invalid := Fields.InValid_filesincedate((SALT34.StrType)clean_filesincedate);
      SELF.filesincedate := IF(withOnfail, clean_filesincedate, le.filesincedate); // ONFAIL(CLEAN)
    SELF.compilationdate_Invalid := Fields.InValid_compilationdate((SALT34.StrType)le.compilationdate);
      clean_compilationdate := (TYPEOF(le.compilationdate))Fields.Make_compilationdate((SALT34.StrType)le.compilationdate);
      clean_compilationdate_Invalid := Fields.InValid_compilationdate((SALT34.StrType)clean_compilationdate);
      SELF.compilationdate := IF(withOnfail, clean_compilationdate, le.compilationdate); // ONFAIL(CLEAN)
    SELF.birthdateind_Invalid := Fields.InValid_birthdateind((SALT34.StrType)le.birthdateind);
      clean_birthdateind := (TYPEOF(le.birthdateind))Fields.Make_birthdateind((SALT34.StrType)le.birthdateind);
      clean_birthdateind_Invalid := Fields.InValid_birthdateind((SALT34.StrType)clean_birthdateind);
      SELF.birthdateind := IF(withOnfail, clean_birthdateind, le.birthdateind); // ONFAIL(CLEAN)
    SELF.orig_deceasedindicator_Invalid := Fields.InValid_orig_deceasedindicator((SALT34.StrType)le.orig_deceasedindicator);
      clean_orig_deceasedindicator := (TYPEOF(le.orig_deceasedindicator))Fields.Make_orig_deceasedindicator((SALT34.StrType)le.orig_deceasedindicator);
      clean_orig_deceasedindicator_Invalid := Fields.InValid_orig_deceasedindicator((SALT34.StrType)clean_orig_deceasedindicator);
      SELF.orig_deceasedindicator := IF(withOnfail, clean_orig_deceasedindicator, le.orig_deceasedindicator); // ONFAIL(CLEAN)
    SELF.deceaseddate_Invalid := Fields.InValid_deceaseddate((SALT34.StrType)le.deceaseddate);
      clean_deceaseddate := (TYPEOF(le.deceaseddate))Fields.Make_deceaseddate((SALT34.StrType)le.deceaseddate);
      clean_deceaseddate_Invalid := Fields.InValid_deceaseddate((SALT34.StrType)clean_deceaseddate);
      SELF.deceaseddate := IF(withOnfail, clean_deceaseddate, le.deceaseddate); // ONFAIL(CLEAN)
    SELF.addressseq_Invalid := Fields.InValid_addressseq((SALT34.StrType)le.addressseq);
      clean_addressseq := (TYPEOF(le.addressseq))Fields.Make_addressseq((SALT34.StrType)le.addressseq);
      clean_addressseq_Invalid := Fields.InValid_addressseq((SALT34.StrType)clean_addressseq);
      SELF.addressseq := IF(withOnfail, clean_addressseq, le.addressseq); // ONFAIL(CLEAN)
    SELF.normaddress_address1_Invalid := Fields.InValid_normaddress_address1((SALT34.StrType)le.normaddress_address1);
      clean_normaddress_address1 := (TYPEOF(le.normaddress_address1))Fields.Make_normaddress_address1((SALT34.StrType)le.normaddress_address1);
      clean_normaddress_address1_Invalid := Fields.InValid_normaddress_address1((SALT34.StrType)clean_normaddress_address1);
      SELF.normaddress_address1 := IF(withOnfail, clean_normaddress_address1, le.normaddress_address1); // ONFAIL(CLEAN)
    SELF.normaddress_address2_Invalid := Fields.InValid_normaddress_address2((SALT34.StrType)le.normaddress_address2);
      clean_normaddress_address2 := (TYPEOF(le.normaddress_address2))Fields.Make_normaddress_address2((SALT34.StrType)le.normaddress_address2);
      clean_normaddress_address2_Invalid := Fields.InValid_normaddress_address2((SALT34.StrType)clean_normaddress_address2);
      SELF.normaddress_address2 := IF(withOnfail, clean_normaddress_address2, le.normaddress_address2); // ONFAIL(CLEAN)
    SELF.normaddress_city_Invalid := Fields.InValid_normaddress_city((SALT34.StrType)le.normaddress_city);
      clean_normaddress_city := (TYPEOF(le.normaddress_city))Fields.Make_normaddress_city((SALT34.StrType)le.normaddress_city);
      clean_normaddress_city_Invalid := Fields.InValid_normaddress_city((SALT34.StrType)clean_normaddress_city);
      SELF.normaddress_city := IF(withOnfail, clean_normaddress_city, le.normaddress_city); // ONFAIL(CLEAN)
    SELF.normaddress_state_Invalid := Fields.InValid_normaddress_state((SALT34.StrType)le.normaddress_state);
      clean_normaddress_state := (TYPEOF(le.normaddress_state))Fields.Make_normaddress_state((SALT34.StrType)le.normaddress_state);
      clean_normaddress_state_Invalid := Fields.InValid_normaddress_state((SALT34.StrType)clean_normaddress_state);
      SELF.normaddress_state := IF(withOnfail, clean_normaddress_state, le.normaddress_state); // ONFAIL(CLEAN)
    SELF.normaddress_zipcode_Invalid := Fields.InValid_normaddress_zipcode((SALT34.StrType)le.normaddress_zipcode);
      clean_normaddress_zipcode := (TYPEOF(le.normaddress_zipcode))Fields.Make_normaddress_zipcode((SALT34.StrType)le.normaddress_zipcode);
      clean_normaddress_zipcode_Invalid := Fields.InValid_normaddress_zipcode((SALT34.StrType)clean_normaddress_zipcode);
      SELF.normaddress_zipcode := IF(withOnfail, clean_normaddress_zipcode, le.normaddress_zipcode); // ONFAIL(CLEAN)
    SELF.normaddress_updateddate_Invalid := Fields.InValid_normaddress_updateddate((SALT34.StrType)le.normaddress_updateddate);
      clean_normaddress_updateddate := (TYPEOF(le.normaddress_updateddate))Fields.Make_normaddress_updateddate((SALT34.StrType)le.normaddress_updateddate);
      clean_normaddress_updateddate_Invalid := Fields.InValid_normaddress_updateddate((SALT34.StrType)clean_normaddress_updateddate);
      SELF.normaddress_updateddate := IF(withOnfail, clean_normaddress_updateddate, le.normaddress_updateddate); // ONFAIL(CLEAN)
    SELF.name_Invalid := Fields.InValid_name((SALT34.StrType)le.name);
      clean_name := (TYPEOF(le.name))Fields.Make_name((SALT34.StrType)le.name);
      clean_name_Invalid := Fields.InValid_name((SALT34.StrType)clean_name);
      SELF.name := IF(withOnfail, clean_name, le.name); // ONFAIL(CLEAN)
    SELF.nametype_Invalid := Fields.InValid_nametype((SALT34.StrType)le.nametype);
      clean_nametype := (TYPEOF(le.nametype))Fields.Make_nametype((SALT34.StrType)le.nametype);
      clean_nametype_Invalid := Fields.InValid_nametype((SALT34.StrType)clean_nametype);
      SELF.nametype := IF(withOnfail, clean_nametype, le.nametype); // ONFAIL(CLEAN)
    SELF.title_Invalid := Fields.InValid_title((SALT34.StrType)le.title);
      clean_title := (TYPEOF(le.title))Fields.Make_title((SALT34.StrType)le.title);
      clean_title_Invalid := Fields.InValid_title((SALT34.StrType)clean_title);
      SELF.title := IF(withOnfail, clean_title, le.title); // ONFAIL(CLEAN)
    SELF.fname_Invalid := Fields.InValid_fname((SALT34.StrType)le.fname);
      clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT34.StrType)le.fname);
      clean_fname_Invalid := Fields.InValid_fname((SALT34.StrType)clean_fname);
      SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.mname_Invalid := Fields.InValid_mname((SALT34.StrType)le.mname);
      clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT34.StrType)le.mname);
      clean_mname_Invalid := Fields.InValid_mname((SALT34.StrType)clean_mname);
      SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.lname_Invalid := Fields.InValid_lname((SALT34.StrType)le.lname);
      clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT34.StrType)le.lname);
      clean_lname_Invalid := Fields.InValid_lname((SALT34.StrType)clean_lname);
      SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT34.StrType)le.name_suffix);
      clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT34.StrType)le.name_suffix);
      clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT34.StrType)clean_name_suffix);
      SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT34.StrType)le.name_score);
      clean_name_score := (TYPEOF(le.name_score))Fields.Make_name_score((SALT34.StrType)le.name_score);
      clean_name_score_Invalid := Fields.InValid_name_score((SALT34.StrType)clean_name_score);
      SELF.name_score := IF(withOnfail, clean_name_score, le.name_score); // ONFAIL(CLEAN)
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT34.StrType)le.prim_range);
      clean_prim_range := (TYPEOF(le.prim_range))Fields.Make_prim_range((SALT34.StrType)le.prim_range);
      clean_prim_range_Invalid := Fields.InValid_prim_range((SALT34.StrType)clean_prim_range);
      SELF.prim_range := IF(withOnfail, clean_prim_range, le.prim_range); // ONFAIL(CLEAN)
    SELF.predir_Invalid := Fields.InValid_predir((SALT34.StrType)le.predir);
      clean_predir := (TYPEOF(le.predir))Fields.Make_predir((SALT34.StrType)le.predir);
      clean_predir_Invalid := Fields.InValid_predir((SALT34.StrType)clean_predir);
      SELF.predir := IF(withOnfail, clean_predir, le.predir); // ONFAIL(CLEAN)
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT34.StrType)le.prim_name);
      clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT34.StrType)le.prim_name);
      clean_prim_name_Invalid := Fields.InValid_prim_name((SALT34.StrType)clean_prim_name);
      SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT34.StrType)le.addr_suffix);
      clean_addr_suffix := (TYPEOF(le.addr_suffix))Fields.Make_addr_suffix((SALT34.StrType)le.addr_suffix);
      clean_addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT34.StrType)clean_addr_suffix);
      SELF.addr_suffix := IF(withOnfail, clean_addr_suffix, le.addr_suffix); // ONFAIL(CLEAN)
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT34.StrType)le.postdir);
      clean_postdir := (TYPEOF(le.postdir))Fields.Make_postdir((SALT34.StrType)le.postdir);
      clean_postdir_Invalid := Fields.InValid_postdir((SALT34.StrType)clean_postdir);
      SELF.postdir := IF(withOnfail, clean_postdir, le.postdir); // ONFAIL(CLEAN)
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig);
      clean_unit_desig := (TYPEOF(le.unit_desig))Fields.Make_unit_desig((SALT34.StrType)le.unit_desig);
      clean_unit_desig_Invalid := Fields.InValid_unit_desig((SALT34.StrType)clean_unit_desig);
      SELF.unit_desig := IF(withOnfail, clean_unit_desig, le.unit_desig); // ONFAIL(CLEAN)
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT34.StrType)le.sec_range);
      clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT34.StrType)le.sec_range);
      clean_sec_range_Invalid := Fields.InValid_sec_range((SALT34.StrType)clean_sec_range);
      SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name);
      clean_p_city_name := (TYPEOF(le.p_city_name))Fields.Make_p_city_name((SALT34.StrType)le.p_city_name);
      clean_p_city_name_Invalid := Fields.InValid_p_city_name((SALT34.StrType)clean_p_city_name);
      SELF.p_city_name := IF(withOnfail, clean_p_city_name, le.p_city_name); // ONFAIL(CLEAN)
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name);
      clean_v_city_name := (TYPEOF(le.v_city_name))Fields.Make_v_city_name((SALT34.StrType)le.v_city_name);
      clean_v_city_name_Invalid := Fields.InValid_v_city_name((SALT34.StrType)clean_v_city_name);
      SELF.v_city_name := IF(withOnfail, clean_v_city_name, le.v_city_name); // ONFAIL(CLEAN)
    SELF.st_Invalid := Fields.InValid_st((SALT34.StrType)le.st);
      clean_st := (TYPEOF(le.st))Fields.Make_st((SALT34.StrType)le.st);
      clean_st_Invalid := Fields.InValid_st((SALT34.StrType)clean_st);
      SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.zip_Invalid := Fields.InValid_zip((SALT34.StrType)le.zip);
      clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT34.StrType)le.zip);
      clean_zip_Invalid := Fields.InValid_zip((SALT34.StrType)clean_zip);
      SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT34.StrType)le.zip4);
      clean_zip4 := (TYPEOF(le.zip4))Fields.Make_zip4((SALT34.StrType)le.zip4);
      clean_zip4_Invalid := Fields.InValid_zip4((SALT34.StrType)clean_zip4);
      SELF.zip4 := IF(withOnfail, clean_zip4, le.zip4); // ONFAIL(CLEAN)
    SELF.cart_Invalid := Fields.InValid_cart((SALT34.StrType)le.cart);
      clean_cart := (TYPEOF(le.cart))Fields.Make_cart((SALT34.StrType)le.cart);
      clean_cart_Invalid := Fields.InValid_cart((SALT34.StrType)clean_cart);
      SELF.cart := IF(withOnfail, clean_cart, le.cart); // ONFAIL(CLEAN)
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT34.StrType)le.cr_sort_sz);
      clean_cr_sort_sz := (TYPEOF(le.cr_sort_sz))Fields.Make_cr_sort_sz((SALT34.StrType)le.cr_sort_sz);
      clean_cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT34.StrType)clean_cr_sort_sz);
      SELF.cr_sort_sz := IF(withOnfail, clean_cr_sort_sz, le.cr_sort_sz); // ONFAIL(CLEAN)
    SELF.lot_Invalid := Fields.InValid_lot((SALT34.StrType)le.lot);
      clean_lot := (TYPEOF(le.lot))Fields.Make_lot((SALT34.StrType)le.lot);
      clean_lot_Invalid := Fields.InValid_lot((SALT34.StrType)clean_lot);
      SELF.lot := IF(withOnfail, clean_lot, le.lot); // ONFAIL(CLEAN)
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT34.StrType)le.lot_order);
      clean_lot_order := (TYPEOF(le.lot_order))Fields.Make_lot_order((SALT34.StrType)le.lot_order);
      clean_lot_order_Invalid := Fields.InValid_lot_order((SALT34.StrType)clean_lot_order);
      SELF.lot_order := IF(withOnfail, clean_lot_order, le.lot_order); // ONFAIL(CLEAN)
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT34.StrType)le.dbpc);
      clean_dbpc := (TYPEOF(le.dbpc))Fields.Make_dbpc((SALT34.StrType)le.dbpc);
      clean_dbpc_Invalid := Fields.InValid_dbpc((SALT34.StrType)clean_dbpc);
      SELF.dbpc := IF(withOnfail, clean_dbpc, le.dbpc); // ONFAIL(CLEAN)
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT34.StrType)le.chk_digit);
      clean_chk_digit := (TYPEOF(le.chk_digit))Fields.Make_chk_digit((SALT34.StrType)le.chk_digit);
      clean_chk_digit_Invalid := Fields.InValid_chk_digit((SALT34.StrType)clean_chk_digit);
      SELF.chk_digit := IF(withOnfail, clean_chk_digit, le.chk_digit); // ONFAIL(CLEAN)
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT34.StrType)le.rec_type);
      clean_rec_type := (TYPEOF(le.rec_type))Fields.Make_rec_type((SALT34.StrType)le.rec_type);
      clean_rec_type_Invalid := Fields.InValid_rec_type((SALT34.StrType)clean_rec_type);
      SELF.rec_type := IF(withOnfail, clean_rec_type, le.rec_type); // ONFAIL(CLEAN)
    SELF.county_Invalid := Fields.InValid_county((SALT34.StrType)le.county);
      clean_county := (TYPEOF(le.county))Fields.Make_county((SALT34.StrType)le.county);
      clean_county_Invalid := Fields.InValid_county((SALT34.StrType)clean_county);
      SELF.county := IF(withOnfail, clean_county, le.county); // ONFAIL(CLEAN)
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT34.StrType)le.geo_lat);
      clean_geo_lat := (TYPEOF(le.geo_lat))Fields.Make_geo_lat((SALT34.StrType)le.geo_lat);
      clean_geo_lat_Invalid := Fields.InValid_geo_lat((SALT34.StrType)clean_geo_lat);
      SELF.geo_lat := IF(withOnfail, clean_geo_lat, le.geo_lat); // ONFAIL(CLEAN)
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT34.StrType)le.geo_long);
      clean_geo_long := (TYPEOF(le.geo_long))Fields.Make_geo_long((SALT34.StrType)le.geo_long);
      clean_geo_long_Invalid := Fields.InValid_geo_long((SALT34.StrType)clean_geo_long);
      SELF.geo_long := IF(withOnfail, clean_geo_long, le.geo_long); // ONFAIL(CLEAN)
    SELF.msa_Invalid := Fields.InValid_msa((SALT34.StrType)le.msa);
      clean_msa := (TYPEOF(le.msa))Fields.Make_msa((SALT34.StrType)le.msa);
      clean_msa_Invalid := Fields.InValid_msa((SALT34.StrType)clean_msa);
      SELF.msa := IF(withOnfail, clean_msa, le.msa); // ONFAIL(CLEAN)
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT34.StrType)le.geo_blk);
      clean_geo_blk := (TYPEOF(le.geo_blk))Fields.Make_geo_blk((SALT34.StrType)le.geo_blk);
      clean_geo_blk_Invalid := Fields.InValid_geo_blk((SALT34.StrType)clean_geo_blk);
      SELF.geo_blk := IF(withOnfail, clean_geo_blk, le.geo_blk); // ONFAIL(CLEAN)
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT34.StrType)le.geo_match);
      clean_geo_match := (TYPEOF(le.geo_match))Fields.Make_geo_match((SALT34.StrType)le.geo_match);
      clean_geo_match_Invalid := Fields.InValid_geo_match((SALT34.StrType)clean_geo_match);
      SELF.geo_match := IF(withOnfail, clean_geo_match, le.geo_match); // ONFAIL(CLEAN)
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT34.StrType)le.err_stat);
      clean_err_stat := (TYPEOF(le.err_stat))Fields.Make_err_stat((SALT34.StrType)le.err_stat);
      clean_err_stat_Invalid := Fields.InValid_err_stat((SALT34.StrType)clean_err_stat);
      SELF.err_stat := IF(withOnfail, clean_err_stat, le.err_stat); // ONFAIL(CLEAN)
    SELF.transferdate_unformatted_Invalid := Fields.InValid_transferdate_unformatted((SALT34.StrType)le.transferdate_unformatted);
      clean_transferdate_unformatted := (TYPEOF(le.transferdate_unformatted))Fields.Make_transferdate_unformatted((SALT34.StrType)le.transferdate_unformatted);
      clean_transferdate_unformatted_Invalid := Fields.InValid_transferdate_unformatted((SALT34.StrType)clean_transferdate_unformatted);
      SELF.transferdate_unformatted := IF(withOnfail, clean_transferdate_unformatted, le.transferdate_unformatted); // ONFAIL(CLEAN)
    SELF.birthdate_unformatted_Invalid := Fields.InValid_birthdate_unformatted((SALT34.StrType)le.birthdate_unformatted);
      clean_birthdate_unformatted := (TYPEOF(le.birthdate_unformatted))Fields.Make_birthdate_unformatted((SALT34.StrType)le.birthdate_unformatted);
      clean_birthdate_unformatted_Invalid := Fields.InValid_birthdate_unformatted((SALT34.StrType)clean_birthdate_unformatted);
      SELF.birthdate_unformatted := IF(withOnfail, clean_birthdate_unformatted, le.birthdate_unformatted); // ONFAIL(CLEAN)
    SELF.dob_no_conflict_Invalid := Fields.InValid_dob_no_conflict((SALT34.StrType)le.dob_no_conflict);
      clean_dob_no_conflict := (TYPEOF(le.dob_no_conflict))Fields.Make_dob_no_conflict((SALT34.StrType)le.dob_no_conflict);
      clean_dob_no_conflict_Invalid := Fields.InValid_dob_no_conflict((SALT34.StrType)clean_dob_no_conflict);
      SELF.dob_no_conflict := IF(withOnfail, clean_dob_no_conflict, le.dob_no_conflict); // ONFAIL(CLEAN)
    SELF.updatedate_unformatted_Invalid := Fields.InValid_updatedate_unformatted((SALT34.StrType)le.updatedate_unformatted);
      clean_updatedate_unformatted := (TYPEOF(le.updatedate_unformatted))Fields.Make_updatedate_unformatted((SALT34.StrType)le.updatedate_unformatted);
      clean_updatedate_unformatted_Invalid := Fields.InValid_updatedate_unformatted((SALT34.StrType)clean_updatedate_unformatted);
      SELF.updatedate_unformatted := IF(withOnfail, clean_updatedate_unformatted, le.updatedate_unformatted); // ONFAIL(CLEAN)
    SELF.consumerupdatedate_unformatted_Invalid := Fields.InValid_consumerupdatedate_unformatted((SALT34.StrType)le.consumerupdatedate_unformatted);
      clean_consumerupdatedate_unformatted := (TYPEOF(le.consumerupdatedate_unformatted))Fields.Make_consumerupdatedate_unformatted((SALT34.StrType)le.consumerupdatedate_unformatted);
      clean_consumerupdatedate_unformatted_Invalid := Fields.InValid_consumerupdatedate_unformatted((SALT34.StrType)clean_consumerupdatedate_unformatted);
      SELF.consumerupdatedate_unformatted := IF(withOnfail, clean_consumerupdatedate_unformatted, le.consumerupdatedate_unformatted); // ONFAIL(CLEAN)
    SELF.filesincedate_unformatted_Invalid := Fields.InValid_filesincedate_unformatted((SALT34.StrType)le.filesincedate_unformatted);
      clean_filesincedate_unformatted := (TYPEOF(le.filesincedate_unformatted))Fields.Make_filesincedate_unformatted((SALT34.StrType)le.filesincedate_unformatted);
      clean_filesincedate_unformatted_Invalid := Fields.InValid_filesincedate_unformatted((SALT34.StrType)clean_filesincedate_unformatted);
      SELF.filesincedate_unformatted := IF(withOnfail, clean_filesincedate_unformatted, le.filesincedate_unformatted); // ONFAIL(CLEAN)
    SELF.compilationdate_unformatted_Invalid := Fields.InValid_compilationdate_unformatted((SALT34.StrType)le.compilationdate_unformatted);
      clean_compilationdate_unformatted := (TYPEOF(le.compilationdate_unformatted))Fields.Make_compilationdate_unformatted((SALT34.StrType)le.compilationdate_unformatted);
      clean_compilationdate_unformatted_Invalid := Fields.InValid_compilationdate_unformatted((SALT34.StrType)clean_compilationdate_unformatted);
      SELF.compilationdate_unformatted := IF(withOnfail, clean_compilationdate_unformatted, le.compilationdate_unformatted); // ONFAIL(CLEAN)
    SELF.ssn_unformatted_Invalid := Fields.InValid_ssn_unformatted((SALT34.StrType)le.ssn_unformatted);
      clean_ssn_unformatted := (TYPEOF(le.ssn_unformatted))Fields.Make_ssn_unformatted((SALT34.StrType)le.ssn_unformatted);
      clean_ssn_unformatted_Invalid := Fields.InValid_ssn_unformatted((SALT34.StrType)clean_ssn_unformatted);
      SELF.ssn_unformatted := IF(withOnfail, clean_ssn_unformatted, le.ssn_unformatted); // ONFAIL(CLEAN)
    SELF.ssn_no_conflict_Invalid := Fields.InValid_ssn_no_conflict((SALT34.StrType)le.ssn_no_conflict);
      clean_ssn_no_conflict := (TYPEOF(le.ssn_no_conflict))Fields.Make_ssn_no_conflict((SALT34.StrType)le.ssn_no_conflict);
      clean_ssn_no_conflict_Invalid := Fields.InValid_ssn_no_conflict((SALT34.StrType)clean_ssn_no_conflict);
      SELF.ssn_no_conflict := IF(withOnfail, clean_ssn_no_conflict, le.ssn_no_conflict); // ONFAIL(CLEAN)
    SELF.telephone_unformatted_Invalid := Fields.InValid_telephone_unformatted((SALT34.StrType)le.telephone_unformatted);
      clean_telephone_unformatted := (TYPEOF(le.telephone_unformatted))Fields.Make_telephone_unformatted((SALT34.StrType)le.telephone_unformatted);
      clean_telephone_unformatted_Invalid := Fields.InValid_telephone_unformatted((SALT34.StrType)clean_telephone_unformatted);
      SELF.telephone_unformatted := IF(withOnfail, clean_telephone_unformatted, le.telephone_unformatted); // ONFAIL(CLEAN)
    SELF.deceasedindicator_Invalid := Fields.InValid_deceasedindicator((SALT34.StrType)le.deceasedindicator);
      clean_deceasedindicator := (TYPEOF(le.deceasedindicator))Fields.Make_deceasedindicator((SALT34.StrType)le.deceasedindicator);
      clean_deceasedindicator_Invalid := Fields.InValid_deceasedindicator((SALT34.StrType)clean_deceasedindicator);
      SELF.deceasedindicator := IF(withOnfail, clean_deceasedindicator, le.deceasedindicator); // ONFAIL(CLEAN)
    SELF.did_Invalid := Fields.InValid_did((SALT34.StrType)le.did);
      clean_did := (TYPEOF(le.did))Fields.Make_did((SALT34.StrType)le.did);
      clean_did_Invalid := Fields.InValid_did((SALT34.StrType)clean_did);
      SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_score_field_Invalid := Fields.InValid_did_score_field((SALT34.StrType)le.did_score_field);
      clean_did_score_field := (TYPEOF(le.did_score_field))Fields.Make_did_score_field((SALT34.StrType)le.did_score_field);
      clean_did_score_field_Invalid := Fields.InValid_did_score_field((SALT34.StrType)clean_did_score_field);
      SELF.did_score_field := IF(withOnfail, clean_did_score_field, le.did_score_field); // ONFAIL(CLEAN)
    SELF.is_current_Invalid := Fields.InValid_is_current((SALT34.StrType)le.is_current);
      clean_is_current := (TYPEOF(le.is_current))Fields.Make_is_current((SALT34.StrType)le.is_current);
      clean_is_current_Invalid := Fields.InValid_is_current((SALT34.StrType)clean_is_current);
      SELF.is_current := IF(withOnfail, clean_is_current, le.is_current); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 3 ) + ( le.dt_vendor_first_reported_Invalid << 6 ) + ( le.dt_vendor_last_reported_Invalid << 9 ) + ( le.filetype_Invalid << 12 ) + ( le.filedate_Invalid << 15 ) + ( le.vendordocumentidentifier_Invalid << 18 ) + ( le.transferdate_Invalid << 21 ) + ( le.currentname_firstname_Invalid << 24 ) + ( le.currentname_middlename_Invalid << 27 ) + ( le.currentname_middleinitial_Invalid << 30 ) + ( le.currentname_lastname_Invalid << 33 ) + ( le.currentname_suffix_Invalid << 36 ) + ( le.currentname_gender_Invalid << 38 ) + ( le.currentname_dob_mm_Invalid << 41 ) + ( le.currentname_dob_dd_Invalid << 44 ) + ( le.currentname_dob_yyyy_Invalid << 47 ) + ( le.currentname_deathindicator_Invalid << 50 ) + ( le.ssnfull_Invalid << 53 ) + ( le.ssnfirst5digit_Invalid << 56 ) + ( le.ssnlast4digit_Invalid << 59 );
    SELF.ScrubsBits2 := ( le.consumerupdatedate_Invalid << 0 ) + ( le.telephonenumber_Invalid << 3 ) + ( le.citedid_Invalid << 6 ) + ( le.fileid_Invalid << 9 ) + ( le.publication_Invalid << 12 ) + ( le.currentaddress_address1_Invalid << 15 ) + ( le.currentaddress_address2_Invalid << 18 ) + ( le.currentaddress_city_Invalid << 21 ) + ( le.currentaddress_state_Invalid << 24 ) + ( le.currentaddress_zipcode_Invalid << 27 ) + ( le.currentaddress_updateddate_Invalid << 30 ) + ( le.housenumber_Invalid << 33 ) + ( le.streettype_Invalid << 35 ) + ( le.streetdirection_Invalid << 38 ) + ( le.streetname_Invalid << 41 ) + ( le.apartmentnumber_Invalid << 44 ) + ( le.city_Invalid << 46 ) + ( le.state_Invalid << 49 ) + ( le.zipcode_Invalid << 52 ) + ( le.zip4u_Invalid << 55 ) + ( le.previousaddress_address1_Invalid << 58 ) + ( le.previousaddress_address2_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.previousaddress_city_Invalid << 0 ) + ( le.previousaddress_state_Invalid << 3 ) + ( le.previousaddress_zipcode_Invalid << 6 ) + ( le.previousaddress_updateddate_Invalid << 9 ) + ( le.formername_firstname_Invalid << 12 ) + ( le.formername_middlename_Invalid << 15 ) + ( le.formername_middleinitial_Invalid << 18 ) + ( le.formername_lastname_Invalid << 21 ) + ( le.formername_suffix_Invalid << 24 ) + ( le.aliasname_firstname_Invalid << 27 ) + ( le.aliasname_middlename_Invalid << 30 ) + ( le.aliasname_middleinitial_Invalid << 33 ) + ( le.aliasname_lastname_Invalid << 36 ) + ( le.aliasname_suffix_Invalid << 39 ) + ( le.additionalname_firstname_Invalid << 42 ) + ( le.additionalname_middlename_Invalid << 45 ) + ( le.additionalname_middleinitial_Invalid << 48 ) + ( le.additionalname_lastname_Invalid << 51 ) + ( le.additionalname_suffix_Invalid << 54 ) + ( le.aka1_Invalid << 57 ) + ( le.aka2_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.aka3_Invalid << 0 ) + ( le.recordtype_Invalid << 3 ) + ( le.addressstandardization_Invalid << 6 ) + ( le.filesincedate_Invalid << 9 ) + ( le.compilationdate_Invalid << 12 ) + ( le.birthdateind_Invalid << 15 ) + ( le.orig_deceasedindicator_Invalid << 18 ) + ( le.deceaseddate_Invalid << 21 ) + ( le.addressseq_Invalid << 24 ) + ( le.normaddress_address1_Invalid << 27 ) + ( le.normaddress_address2_Invalid << 30 ) + ( le.normaddress_city_Invalid << 33 ) + ( le.normaddress_state_Invalid << 36 ) + ( le.normaddress_zipcode_Invalid << 39 ) + ( le.normaddress_updateddate_Invalid << 42 ) + ( le.name_Invalid << 45 ) + ( le.nametype_Invalid << 48 ) + ( le.title_Invalid << 51 ) + ( le.fname_Invalid << 54 ) + ( le.mname_Invalid << 57 ) + ( le.lname_Invalid << 60 );
    SELF.ScrubsBits5 := ( le.name_suffix_Invalid << 0 ) + ( le.name_score_Invalid << 3 ) + ( le.prim_range_Invalid << 6 ) + ( le.predir_Invalid << 9 ) + ( le.prim_name_Invalid << 12 ) + ( le.addr_suffix_Invalid << 15 ) + ( le.postdir_Invalid << 18 ) + ( le.unit_desig_Invalid << 21 ) + ( le.sec_range_Invalid << 24 ) + ( le.p_city_name_Invalid << 27 ) + ( le.v_city_name_Invalid << 30 ) + ( le.st_Invalid << 33 ) + ( le.zip_Invalid << 36 ) + ( le.zip4_Invalid << 39 ) + ( le.cart_Invalid << 42 ) + ( le.cr_sort_sz_Invalid << 45 ) + ( le.lot_Invalid << 48 ) + ( le.lot_order_Invalid << 51 ) + ( le.dbpc_Invalid << 54 ) + ( le.chk_digit_Invalid << 57 ) + ( le.rec_type_Invalid << 60 );
    SELF.ScrubsBits6 := ( le.county_Invalid << 0 ) + ( le.geo_lat_Invalid << 3 ) + ( le.geo_long_Invalid << 6 ) + ( le.msa_Invalid << 9 ) + ( le.geo_blk_Invalid << 12 ) + ( le.geo_match_Invalid << 15 ) + ( le.err_stat_Invalid << 18 ) + ( le.transferdate_unformatted_Invalid << 21 ) + ( le.birthdate_unformatted_Invalid << 24 ) + ( le.dob_no_conflict_Invalid << 27 ) + ( le.updatedate_unformatted_Invalid << 30 ) + ( le.consumerupdatedate_unformatted_Invalid << 33 ) + ( le.filesincedate_unformatted_Invalid << 36 ) + ( le.compilationdate_unformatted_Invalid << 39 ) + ( le.ssn_unformatted_Invalid << 42 ) + ( le.ssn_no_conflict_Invalid << 45 ) + ( le.telephone_unformatted_Invalid << 48 ) + ( le.deceasedindicator_Invalid << 51 ) + ( le.did_Invalid << 54 ) + ( le.did_score_field_Invalid << 57 ) + ( le.is_current_Invalid << 60 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.filetype_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.vendordocumentidentifier_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.transferdate_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.currentname_firstname_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.currentname_middlename_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.currentname_middleinitial_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.currentname_lastname_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.currentname_suffix_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.currentname_gender_Invalid := (le.ScrubsBits1 >> 38) & 7;
    SELF.currentname_dob_mm_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.currentname_dob_dd_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.currentname_dob_yyyy_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.currentname_deathindicator_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.ssnfull_Invalid := (le.ScrubsBits1 >> 53) & 7;
    SELF.ssnfirst5digit_Invalid := (le.ScrubsBits1 >> 56) & 7;
    SELF.ssnlast4digit_Invalid := (le.ScrubsBits1 >> 59) & 7;
    SELF.consumerupdatedate_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.telephonenumber_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.citedid_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.fileid_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.publication_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.currentaddress_address1_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.currentaddress_address2_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.currentaddress_city_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.currentaddress_state_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.currentaddress_zipcode_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.currentaddress_updateddate_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.housenumber_Invalid := (le.ScrubsBits2 >> 33) & 3;
    SELF.streettype_Invalid := (le.ScrubsBits2 >> 35) & 7;
    SELF.streetdirection_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.streetname_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.apartmentnumber_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.city_Invalid := (le.ScrubsBits2 >> 46) & 7;
    SELF.state_Invalid := (le.ScrubsBits2 >> 49) & 7;
    SELF.zipcode_Invalid := (le.ScrubsBits2 >> 52) & 7;
    SELF.zip4u_Invalid := (le.ScrubsBits2 >> 55) & 7;
    SELF.previousaddress_address1_Invalid := (le.ScrubsBits2 >> 58) & 7;
    SELF.previousaddress_address2_Invalid := (le.ScrubsBits2 >> 61) & 7;
    SELF.previousaddress_city_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.previousaddress_state_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.previousaddress_zipcode_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.previousaddress_updateddate_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.formername_firstname_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.formername_middlename_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.formername_middleinitial_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.formername_lastname_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.formername_suffix_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.aliasname_firstname_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.aliasname_middlename_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.aliasname_middleinitial_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.aliasname_lastname_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.aliasname_suffix_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.additionalname_firstname_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.additionalname_middlename_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.additionalname_middleinitial_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.additionalname_lastname_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.additionalname_suffix_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.aka1_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.aka2_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.aka3_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.recordtype_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.addressstandardization_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.filesincedate_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.compilationdate_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.birthdateind_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.orig_deceasedindicator_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.deceaseddate_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.addressseq_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.normaddress_address1_Invalid := (le.ScrubsBits4 >> 27) & 7;
    SELF.normaddress_address2_Invalid := (le.ScrubsBits4 >> 30) & 7;
    SELF.normaddress_city_Invalid := (le.ScrubsBits4 >> 33) & 7;
    SELF.normaddress_state_Invalid := (le.ScrubsBits4 >> 36) & 7;
    SELF.normaddress_zipcode_Invalid := (le.ScrubsBits4 >> 39) & 7;
    SELF.normaddress_updateddate_Invalid := (le.ScrubsBits4 >> 42) & 7;
    SELF.name_Invalid := (le.ScrubsBits4 >> 45) & 7;
    SELF.nametype_Invalid := (le.ScrubsBits4 >> 48) & 7;
    SELF.title_Invalid := (le.ScrubsBits4 >> 51) & 7;
    SELF.fname_Invalid := (le.ScrubsBits4 >> 54) & 7;
    SELF.mname_Invalid := (le.ScrubsBits4 >> 57) & 7;
    SELF.lname_Invalid := (le.ScrubsBits4 >> 60) & 7;
    SELF.name_suffix_Invalid := (le.ScrubsBits5 >> 0) & 7;
    SELF.name_score_Invalid := (le.ScrubsBits5 >> 3) & 7;
    SELF.prim_range_Invalid := (le.ScrubsBits5 >> 6) & 7;
    SELF.predir_Invalid := (le.ScrubsBits5 >> 9) & 7;
    SELF.prim_name_Invalid := (le.ScrubsBits5 >> 12) & 7;
    SELF.addr_suffix_Invalid := (le.ScrubsBits5 >> 15) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits5 >> 18) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits5 >> 21) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits5 >> 24) & 7;
    SELF.p_city_name_Invalid := (le.ScrubsBits5 >> 27) & 7;
    SELF.v_city_name_Invalid := (le.ScrubsBits5 >> 30) & 7;
    SELF.st_Invalid := (le.ScrubsBits5 >> 33) & 7;
    SELF.zip_Invalid := (le.ScrubsBits5 >> 36) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits5 >> 39) & 7;
    SELF.cart_Invalid := (le.ScrubsBits5 >> 42) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits5 >> 45) & 7;
    SELF.lot_Invalid := (le.ScrubsBits5 >> 48) & 7;
    SELF.lot_order_Invalid := (le.ScrubsBits5 >> 51) & 7;
    SELF.dbpc_Invalid := (le.ScrubsBits5 >> 54) & 7;
    SELF.chk_digit_Invalid := (le.ScrubsBits5 >> 57) & 7;
    SELF.rec_type_Invalid := (le.ScrubsBits5 >> 60) & 7;
    SELF.county_Invalid := (le.ScrubsBits6 >> 0) & 7;
    SELF.geo_lat_Invalid := (le.ScrubsBits6 >> 3) & 7;
    SELF.geo_long_Invalid := (le.ScrubsBits6 >> 6) & 7;
    SELF.msa_Invalid := (le.ScrubsBits6 >> 9) & 7;
    SELF.geo_blk_Invalid := (le.ScrubsBits6 >> 12) & 7;
    SELF.geo_match_Invalid := (le.ScrubsBits6 >> 15) & 7;
    SELF.err_stat_Invalid := (le.ScrubsBits6 >> 18) & 7;
    SELF.transferdate_unformatted_Invalid := (le.ScrubsBits6 >> 21) & 7;
    SELF.birthdate_unformatted_Invalid := (le.ScrubsBits6 >> 24) & 7;
    SELF.dob_no_conflict_Invalid := (le.ScrubsBits6 >> 27) & 7;
    SELF.updatedate_unformatted_Invalid := (le.ScrubsBits6 >> 30) & 7;
    SELF.consumerupdatedate_unformatted_Invalid := (le.ScrubsBits6 >> 33) & 7;
    SELF.filesincedate_unformatted_Invalid := (le.ScrubsBits6 >> 36) & 7;
    SELF.compilationdate_unformatted_Invalid := (le.ScrubsBits6 >> 39) & 7;
    SELF.ssn_unformatted_Invalid := (le.ScrubsBits6 >> 42) & 7;
    SELF.ssn_no_conflict_Invalid := (le.ScrubsBits6 >> 45) & 7;
    SELF.telephone_unformatted_Invalid := (le.ScrubsBits6 >> 48) & 7;
    SELF.deceasedindicator_Invalid := (le.ScrubsBits6 >> 51) & 7;
    SELF.did_Invalid := (le.ScrubsBits6 >> 54) & 7;
    SELF.did_score_field_Invalid := (le.ScrubsBits6 >> 57) & 7;
    SELF.is_current_Invalid := (le.ScrubsBits6 >> 60) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=4);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=4);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=4);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=4);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    filetype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filetype_Invalid=1);
    filetype_ALLOW_ErrorCount := COUNT(GROUP,h.filetype_Invalid=2);
    filetype_LENGTH_ErrorCount := COUNT(GROUP,h.filetype_Invalid=3);
    filetype_WORDS_ErrorCount := COUNT(GROUP,h.filetype_Invalid=4);
    filetype_Total_ErrorCount := COUNT(GROUP,h.filetype_Invalid>0);
    filedate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    filedate_ALLOW_ErrorCount := COUNT(GROUP,h.filedate_Invalid=2);
    filedate_LENGTH_ErrorCount := COUNT(GROUP,h.filedate_Invalid=3);
    filedate_WORDS_ErrorCount := COUNT(GROUP,h.filedate_Invalid=4);
    filedate_Total_ErrorCount := COUNT(GROUP,h.filedate_Invalid>0);
    vendordocumentidentifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vendordocumentidentifier_Invalid=1);
    vendordocumentidentifier_ALLOW_ErrorCount := COUNT(GROUP,h.vendordocumentidentifier_Invalid=2);
    vendordocumentidentifier_LENGTH_ErrorCount := COUNT(GROUP,h.vendordocumentidentifier_Invalid=3);
    vendordocumentidentifier_WORDS_ErrorCount := COUNT(GROUP,h.vendordocumentidentifier_Invalid=4);
    vendordocumentidentifier_Total_ErrorCount := COUNT(GROUP,h.vendordocumentidentifier_Invalid>0);
    transferdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.transferdate_Invalid=1);
    transferdate_ALLOW_ErrorCount := COUNT(GROUP,h.transferdate_Invalid=2);
    transferdate_LENGTH_ErrorCount := COUNT(GROUP,h.transferdate_Invalid=3);
    transferdate_WORDS_ErrorCount := COUNT(GROUP,h.transferdate_Invalid=4);
    transferdate_Total_ErrorCount := COUNT(GROUP,h.transferdate_Invalid>0);
    currentname_firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_firstname_Invalid=1);
    currentname_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_firstname_Invalid=2);
    currentname_firstname_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_firstname_Invalid=3);
    currentname_firstname_WORDS_ErrorCount := COUNT(GROUP,h.currentname_firstname_Invalid=4);
    currentname_firstname_Total_ErrorCount := COUNT(GROUP,h.currentname_firstname_Invalid>0);
    currentname_middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_middlename_Invalid=1);
    currentname_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_middlename_Invalid=2);
    currentname_middlename_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_middlename_Invalid=3);
    currentname_middlename_WORDS_ErrorCount := COUNT(GROUP,h.currentname_middlename_Invalid=4);
    currentname_middlename_Total_ErrorCount := COUNT(GROUP,h.currentname_middlename_Invalid>0);
    currentname_middleinitial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_middleinitial_Invalid=1);
    currentname_middleinitial_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_middleinitial_Invalid=2);
    currentname_middleinitial_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_middleinitial_Invalid=3);
    currentname_middleinitial_WORDS_ErrorCount := COUNT(GROUP,h.currentname_middleinitial_Invalid=4);
    currentname_middleinitial_Total_ErrorCount := COUNT(GROUP,h.currentname_middleinitial_Invalid>0);
    currentname_lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_lastname_Invalid=1);
    currentname_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_lastname_Invalid=2);
    currentname_lastname_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_lastname_Invalid=3);
    currentname_lastname_WORDS_ErrorCount := COUNT(GROUP,h.currentname_lastname_Invalid=4);
    currentname_lastname_Total_ErrorCount := COUNT(GROUP,h.currentname_lastname_Invalid>0);
    currentname_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_suffix_Invalid=1);
    currentname_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_suffix_Invalid=2);
    currentname_suffix_WORDS_ErrorCount := COUNT(GROUP,h.currentname_suffix_Invalid=3);
    currentname_suffix_Total_ErrorCount := COUNT(GROUP,h.currentname_suffix_Invalid>0);
    currentname_gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_gender_Invalid=1);
    currentname_gender_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_gender_Invalid=2);
    currentname_gender_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_gender_Invalid=3);
    currentname_gender_WORDS_ErrorCount := COUNT(GROUP,h.currentname_gender_Invalid=4);
    currentname_gender_Total_ErrorCount := COUNT(GROUP,h.currentname_gender_Invalid>0);
    currentname_dob_mm_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_dob_mm_Invalid=1);
    currentname_dob_mm_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_dob_mm_Invalid=2);
    currentname_dob_mm_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_dob_mm_Invalid=3);
    currentname_dob_mm_WORDS_ErrorCount := COUNT(GROUP,h.currentname_dob_mm_Invalid=4);
    currentname_dob_mm_Total_ErrorCount := COUNT(GROUP,h.currentname_dob_mm_Invalid>0);
    currentname_dob_dd_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_dob_dd_Invalid=1);
    currentname_dob_dd_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_dob_dd_Invalid=2);
    currentname_dob_dd_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_dob_dd_Invalid=3);
    currentname_dob_dd_WORDS_ErrorCount := COUNT(GROUP,h.currentname_dob_dd_Invalid=4);
    currentname_dob_dd_Total_ErrorCount := COUNT(GROUP,h.currentname_dob_dd_Invalid>0);
    currentname_dob_yyyy_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_dob_yyyy_Invalid=1);
    currentname_dob_yyyy_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_dob_yyyy_Invalid=2);
    currentname_dob_yyyy_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_dob_yyyy_Invalid=3);
    currentname_dob_yyyy_WORDS_ErrorCount := COUNT(GROUP,h.currentname_dob_yyyy_Invalid=4);
    currentname_dob_yyyy_Total_ErrorCount := COUNT(GROUP,h.currentname_dob_yyyy_Invalid>0);
    currentname_deathindicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentname_deathindicator_Invalid=1);
    currentname_deathindicator_ALLOW_ErrorCount := COUNT(GROUP,h.currentname_deathindicator_Invalid=2);
    currentname_deathindicator_LENGTH_ErrorCount := COUNT(GROUP,h.currentname_deathindicator_Invalid=3);
    currentname_deathindicator_WORDS_ErrorCount := COUNT(GROUP,h.currentname_deathindicator_Invalid=4);
    currentname_deathindicator_Total_ErrorCount := COUNT(GROUP,h.currentname_deathindicator_Invalid>0);
    ssnfull_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssnfull_Invalid=1);
    ssnfull_ALLOW_ErrorCount := COUNT(GROUP,h.ssnfull_Invalid=2);
    ssnfull_LENGTH_ErrorCount := COUNT(GROUP,h.ssnfull_Invalid=3);
    ssnfull_WORDS_ErrorCount := COUNT(GROUP,h.ssnfull_Invalid=4);
    ssnfull_Total_ErrorCount := COUNT(GROUP,h.ssnfull_Invalid>0);
    ssnfirst5digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssnfirst5digit_Invalid=1);
    ssnfirst5digit_ALLOW_ErrorCount := COUNT(GROUP,h.ssnfirst5digit_Invalid=2);
    ssnfirst5digit_LENGTH_ErrorCount := COUNT(GROUP,h.ssnfirst5digit_Invalid=3);
    ssnfirst5digit_WORDS_ErrorCount := COUNT(GROUP,h.ssnfirst5digit_Invalid=4);
    ssnfirst5digit_Total_ErrorCount := COUNT(GROUP,h.ssnfirst5digit_Invalid>0);
    ssnlast4digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssnlast4digit_Invalid=1);
    ssnlast4digit_ALLOW_ErrorCount := COUNT(GROUP,h.ssnlast4digit_Invalid=2);
    ssnlast4digit_LENGTH_ErrorCount := COUNT(GROUP,h.ssnlast4digit_Invalid=3);
    ssnlast4digit_WORDS_ErrorCount := COUNT(GROUP,h.ssnlast4digit_Invalid=4);
    ssnlast4digit_Total_ErrorCount := COUNT(GROUP,h.ssnlast4digit_Invalid>0);
    consumerupdatedate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.consumerupdatedate_Invalid=1);
    consumerupdatedate_ALLOW_ErrorCount := COUNT(GROUP,h.consumerupdatedate_Invalid=2);
    consumerupdatedate_LENGTH_ErrorCount := COUNT(GROUP,h.consumerupdatedate_Invalid=3);
    consumerupdatedate_WORDS_ErrorCount := COUNT(GROUP,h.consumerupdatedate_Invalid=4);
    consumerupdatedate_Total_ErrorCount := COUNT(GROUP,h.consumerupdatedate_Invalid>0);
    telephonenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.telephonenumber_Invalid=1);
    telephonenumber_ALLOW_ErrorCount := COUNT(GROUP,h.telephonenumber_Invalid=2);
    telephonenumber_LENGTH_ErrorCount := COUNT(GROUP,h.telephonenumber_Invalid=3);
    telephonenumber_WORDS_ErrorCount := COUNT(GROUP,h.telephonenumber_Invalid=4);
    telephonenumber_Total_ErrorCount := COUNT(GROUP,h.telephonenumber_Invalid>0);
    citedid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.citedid_Invalid=1);
    citedid_ALLOW_ErrorCount := COUNT(GROUP,h.citedid_Invalid=2);
    citedid_LENGTH_ErrorCount := COUNT(GROUP,h.citedid_Invalid=3);
    citedid_WORDS_ErrorCount := COUNT(GROUP,h.citedid_Invalid=4);
    citedid_Total_ErrorCount := COUNT(GROUP,h.citedid_Invalid>0);
    fileid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fileid_Invalid=1);
    fileid_ALLOW_ErrorCount := COUNT(GROUP,h.fileid_Invalid=2);
    fileid_LENGTH_ErrorCount := COUNT(GROUP,h.fileid_Invalid=3);
    fileid_WORDS_ErrorCount := COUNT(GROUP,h.fileid_Invalid=4);
    fileid_Total_ErrorCount := COUNT(GROUP,h.fileid_Invalid>0);
    publication_LEFTTRIM_ErrorCount := COUNT(GROUP,h.publication_Invalid=1);
    publication_ALLOW_ErrorCount := COUNT(GROUP,h.publication_Invalid=2);
    publication_LENGTH_ErrorCount := COUNT(GROUP,h.publication_Invalid=3);
    publication_WORDS_ErrorCount := COUNT(GROUP,h.publication_Invalid=4);
    publication_Total_ErrorCount := COUNT(GROUP,h.publication_Invalid>0);
    currentaddress_address1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_address1_Invalid=1);
    currentaddress_address1_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_address1_Invalid=2);
    currentaddress_address1_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_address1_Invalid=3);
    currentaddress_address1_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_address1_Invalid=4);
    currentaddress_address1_Total_ErrorCount := COUNT(GROUP,h.currentaddress_address1_Invalid>0);
    currentaddress_address2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_address2_Invalid=1);
    currentaddress_address2_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_address2_Invalid=2);
    currentaddress_address2_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_address2_Invalid=3);
    currentaddress_address2_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_address2_Invalid=4);
    currentaddress_address2_Total_ErrorCount := COUNT(GROUP,h.currentaddress_address2_Invalid>0);
    currentaddress_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_city_Invalid=1);
    currentaddress_city_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_city_Invalid=2);
    currentaddress_city_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_city_Invalid=3);
    currentaddress_city_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_city_Invalid=4);
    currentaddress_city_Total_ErrorCount := COUNT(GROUP,h.currentaddress_city_Invalid>0);
    currentaddress_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_state_Invalid=1);
    currentaddress_state_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_state_Invalid=2);
    currentaddress_state_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_state_Invalid=3);
    currentaddress_state_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_state_Invalid=4);
    currentaddress_state_Total_ErrorCount := COUNT(GROUP,h.currentaddress_state_Invalid>0);
    currentaddress_zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_zipcode_Invalid=1);
    currentaddress_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_zipcode_Invalid=2);
    currentaddress_zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_zipcode_Invalid=3);
    currentaddress_zipcode_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_zipcode_Invalid=4);
    currentaddress_zipcode_Total_ErrorCount := COUNT(GROUP,h.currentaddress_zipcode_Invalid>0);
    currentaddress_updateddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentaddress_updateddate_Invalid=1);
    currentaddress_updateddate_ALLOW_ErrorCount := COUNT(GROUP,h.currentaddress_updateddate_Invalid=2);
    currentaddress_updateddate_LENGTH_ErrorCount := COUNT(GROUP,h.currentaddress_updateddate_Invalid=3);
    currentaddress_updateddate_WORDS_ErrorCount := COUNT(GROUP,h.currentaddress_updateddate_Invalid=4);
    currentaddress_updateddate_Total_ErrorCount := COUNT(GROUP,h.currentaddress_updateddate_Invalid>0);
    housenumber_ALLOW_ErrorCount := COUNT(GROUP,h.housenumber_Invalid=1);
    housenumber_LENGTH_ErrorCount := COUNT(GROUP,h.housenumber_Invalid=2);
    housenumber_WORDS_ErrorCount := COUNT(GROUP,h.housenumber_Invalid=3);
    housenumber_Total_ErrorCount := COUNT(GROUP,h.housenumber_Invalid>0);
    streettype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.streettype_Invalid=1);
    streettype_ALLOW_ErrorCount := COUNT(GROUP,h.streettype_Invalid=2);
    streettype_LENGTH_ErrorCount := COUNT(GROUP,h.streettype_Invalid=3);
    streettype_WORDS_ErrorCount := COUNT(GROUP,h.streettype_Invalid=4);
    streettype_Total_ErrorCount := COUNT(GROUP,h.streettype_Invalid>0);
    streetdirection_LEFTTRIM_ErrorCount := COUNT(GROUP,h.streetdirection_Invalid=1);
    streetdirection_ALLOW_ErrorCount := COUNT(GROUP,h.streetdirection_Invalid=2);
    streetdirection_LENGTH_ErrorCount := COUNT(GROUP,h.streetdirection_Invalid=3);
    streetdirection_WORDS_ErrorCount := COUNT(GROUP,h.streetdirection_Invalid=4);
    streetdirection_Total_ErrorCount := COUNT(GROUP,h.streetdirection_Invalid>0);
    streetname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.streetname_Invalid=1);
    streetname_ALLOW_ErrorCount := COUNT(GROUP,h.streetname_Invalid=2);
    streetname_LENGTH_ErrorCount := COUNT(GROUP,h.streetname_Invalid=3);
    streetname_WORDS_ErrorCount := COUNT(GROUP,h.streetname_Invalid=4);
    streetname_Total_ErrorCount := COUNT(GROUP,h.streetname_Invalid>0);
    apartmentnumber_ALLOW_ErrorCount := COUNT(GROUP,h.apartmentnumber_Invalid=1);
    apartmentnumber_LENGTH_ErrorCount := COUNT(GROUP,h.apartmentnumber_Invalid=2);
    apartmentnumber_WORDS_ErrorCount := COUNT(GROUP,h.apartmentnumber_Invalid=3);
    apartmentnumber_Total_ErrorCount := COUNT(GROUP,h.apartmentnumber_Invalid>0);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=3);
    city_WORDS_ErrorCount := COUNT(GROUP,h.city_Invalid=4);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_WORDS_ErrorCount := COUNT(GROUP,h.state_Invalid=4);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=3);
    zipcode_WORDS_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=4);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    zip4u_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4u_Invalid=1);
    zip4u_ALLOW_ErrorCount := COUNT(GROUP,h.zip4u_Invalid=2);
    zip4u_LENGTH_ErrorCount := COUNT(GROUP,h.zip4u_Invalid=3);
    zip4u_WORDS_ErrorCount := COUNT(GROUP,h.zip4u_Invalid=4);
    zip4u_Total_ErrorCount := COUNT(GROUP,h.zip4u_Invalid>0);
    previousaddress_address1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_address1_Invalid=1);
    previousaddress_address1_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_address1_Invalid=2);
    previousaddress_address1_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_address1_Invalid=3);
    previousaddress_address1_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_address1_Invalid=4);
    previousaddress_address1_Total_ErrorCount := COUNT(GROUP,h.previousaddress_address1_Invalid>0);
    previousaddress_address2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_address2_Invalid=1);
    previousaddress_address2_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_address2_Invalid=2);
    previousaddress_address2_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_address2_Invalid=3);
    previousaddress_address2_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_address2_Invalid=4);
    previousaddress_address2_Total_ErrorCount := COUNT(GROUP,h.previousaddress_address2_Invalid>0);
    previousaddress_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_city_Invalid=1);
    previousaddress_city_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_city_Invalid=2);
    previousaddress_city_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_city_Invalid=3);
    previousaddress_city_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_city_Invalid=4);
    previousaddress_city_Total_ErrorCount := COUNT(GROUP,h.previousaddress_city_Invalid>0);
    previousaddress_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_state_Invalid=1);
    previousaddress_state_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_state_Invalid=2);
    previousaddress_state_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_state_Invalid=3);
    previousaddress_state_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_state_Invalid=4);
    previousaddress_state_Total_ErrorCount := COUNT(GROUP,h.previousaddress_state_Invalid>0);
    previousaddress_zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_zipcode_Invalid=1);
    previousaddress_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_zipcode_Invalid=2);
    previousaddress_zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_zipcode_Invalid=3);
    previousaddress_zipcode_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_zipcode_Invalid=4);
    previousaddress_zipcode_Total_ErrorCount := COUNT(GROUP,h.previousaddress_zipcode_Invalid>0);
    previousaddress_updateddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previousaddress_updateddate_Invalid=1);
    previousaddress_updateddate_ALLOW_ErrorCount := COUNT(GROUP,h.previousaddress_updateddate_Invalid=2);
    previousaddress_updateddate_LENGTH_ErrorCount := COUNT(GROUP,h.previousaddress_updateddate_Invalid=3);
    previousaddress_updateddate_WORDS_ErrorCount := COUNT(GROUP,h.previousaddress_updateddate_Invalid=4);
    previousaddress_updateddate_Total_ErrorCount := COUNT(GROUP,h.previousaddress_updateddate_Invalid>0);
    formername_firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.formername_firstname_Invalid=1);
    formername_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.formername_firstname_Invalid=2);
    formername_firstname_LENGTH_ErrorCount := COUNT(GROUP,h.formername_firstname_Invalid=3);
    formername_firstname_WORDS_ErrorCount := COUNT(GROUP,h.formername_firstname_Invalid=4);
    formername_firstname_Total_ErrorCount := COUNT(GROUP,h.formername_firstname_Invalid>0);
    formername_middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.formername_middlename_Invalid=1);
    formername_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.formername_middlename_Invalid=2);
    formername_middlename_LENGTH_ErrorCount := COUNT(GROUP,h.formername_middlename_Invalid=3);
    formername_middlename_WORDS_ErrorCount := COUNT(GROUP,h.formername_middlename_Invalid=4);
    formername_middlename_Total_ErrorCount := COUNT(GROUP,h.formername_middlename_Invalid>0);
    formername_middleinitial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.formername_middleinitial_Invalid=1);
    formername_middleinitial_ALLOW_ErrorCount := COUNT(GROUP,h.formername_middleinitial_Invalid=2);
    formername_middleinitial_LENGTH_ErrorCount := COUNT(GROUP,h.formername_middleinitial_Invalid=3);
    formername_middleinitial_WORDS_ErrorCount := COUNT(GROUP,h.formername_middleinitial_Invalid=4);
    formername_middleinitial_Total_ErrorCount := COUNT(GROUP,h.formername_middleinitial_Invalid>0);
    formername_lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.formername_lastname_Invalid=1);
    formername_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.formername_lastname_Invalid=2);
    formername_lastname_LENGTH_ErrorCount := COUNT(GROUP,h.formername_lastname_Invalid=3);
    formername_lastname_WORDS_ErrorCount := COUNT(GROUP,h.formername_lastname_Invalid=4);
    formername_lastname_Total_ErrorCount := COUNT(GROUP,h.formername_lastname_Invalid>0);
    formername_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.formername_suffix_Invalid=1);
    formername_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.formername_suffix_Invalid=2);
    formername_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.formername_suffix_Invalid=3);
    formername_suffix_WORDS_ErrorCount := COUNT(GROUP,h.formername_suffix_Invalid=4);
    formername_suffix_Total_ErrorCount := COUNT(GROUP,h.formername_suffix_Invalid>0);
    aliasname_firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aliasname_firstname_Invalid=1);
    aliasname_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.aliasname_firstname_Invalid=2);
    aliasname_firstname_LENGTH_ErrorCount := COUNT(GROUP,h.aliasname_firstname_Invalid=3);
    aliasname_firstname_WORDS_ErrorCount := COUNT(GROUP,h.aliasname_firstname_Invalid=4);
    aliasname_firstname_Total_ErrorCount := COUNT(GROUP,h.aliasname_firstname_Invalid>0);
    aliasname_middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aliasname_middlename_Invalid=1);
    aliasname_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.aliasname_middlename_Invalid=2);
    aliasname_middlename_LENGTH_ErrorCount := COUNT(GROUP,h.aliasname_middlename_Invalid=3);
    aliasname_middlename_WORDS_ErrorCount := COUNT(GROUP,h.aliasname_middlename_Invalid=4);
    aliasname_middlename_Total_ErrorCount := COUNT(GROUP,h.aliasname_middlename_Invalid>0);
    aliasname_middleinitial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aliasname_middleinitial_Invalid=1);
    aliasname_middleinitial_ALLOW_ErrorCount := COUNT(GROUP,h.aliasname_middleinitial_Invalid=2);
    aliasname_middleinitial_LENGTH_ErrorCount := COUNT(GROUP,h.aliasname_middleinitial_Invalid=3);
    aliasname_middleinitial_WORDS_ErrorCount := COUNT(GROUP,h.aliasname_middleinitial_Invalid=4);
    aliasname_middleinitial_Total_ErrorCount := COUNT(GROUP,h.aliasname_middleinitial_Invalid>0);
    aliasname_lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aliasname_lastname_Invalid=1);
    aliasname_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.aliasname_lastname_Invalid=2);
    aliasname_lastname_LENGTH_ErrorCount := COUNT(GROUP,h.aliasname_lastname_Invalid=3);
    aliasname_lastname_WORDS_ErrorCount := COUNT(GROUP,h.aliasname_lastname_Invalid=4);
    aliasname_lastname_Total_ErrorCount := COUNT(GROUP,h.aliasname_lastname_Invalid>0);
    aliasname_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aliasname_suffix_Invalid=1);
    aliasname_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.aliasname_suffix_Invalid=2);
    aliasname_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.aliasname_suffix_Invalid=3);
    aliasname_suffix_WORDS_ErrorCount := COUNT(GROUP,h.aliasname_suffix_Invalid=4);
    aliasname_suffix_Total_ErrorCount := COUNT(GROUP,h.aliasname_suffix_Invalid>0);
    additionalname_firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additionalname_firstname_Invalid=1);
    additionalname_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.additionalname_firstname_Invalid=2);
    additionalname_firstname_LENGTH_ErrorCount := COUNT(GROUP,h.additionalname_firstname_Invalid=3);
    additionalname_firstname_WORDS_ErrorCount := COUNT(GROUP,h.additionalname_firstname_Invalid=4);
    additionalname_firstname_Total_ErrorCount := COUNT(GROUP,h.additionalname_firstname_Invalid>0);
    additionalname_middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additionalname_middlename_Invalid=1);
    additionalname_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.additionalname_middlename_Invalid=2);
    additionalname_middlename_LENGTH_ErrorCount := COUNT(GROUP,h.additionalname_middlename_Invalid=3);
    additionalname_middlename_WORDS_ErrorCount := COUNT(GROUP,h.additionalname_middlename_Invalid=4);
    additionalname_middlename_Total_ErrorCount := COUNT(GROUP,h.additionalname_middlename_Invalid>0);
    additionalname_middleinitial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additionalname_middleinitial_Invalid=1);
    additionalname_middleinitial_ALLOW_ErrorCount := COUNT(GROUP,h.additionalname_middleinitial_Invalid=2);
    additionalname_middleinitial_LENGTH_ErrorCount := COUNT(GROUP,h.additionalname_middleinitial_Invalid=3);
    additionalname_middleinitial_WORDS_ErrorCount := COUNT(GROUP,h.additionalname_middleinitial_Invalid=4);
    additionalname_middleinitial_Total_ErrorCount := COUNT(GROUP,h.additionalname_middleinitial_Invalid>0);
    additionalname_lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additionalname_lastname_Invalid=1);
    additionalname_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.additionalname_lastname_Invalid=2);
    additionalname_lastname_LENGTH_ErrorCount := COUNT(GROUP,h.additionalname_lastname_Invalid=3);
    additionalname_lastname_WORDS_ErrorCount := COUNT(GROUP,h.additionalname_lastname_Invalid=4);
    additionalname_lastname_Total_ErrorCount := COUNT(GROUP,h.additionalname_lastname_Invalid>0);
    additionalname_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additionalname_suffix_Invalid=1);
    additionalname_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.additionalname_suffix_Invalid=2);
    additionalname_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.additionalname_suffix_Invalid=3);
    additionalname_suffix_WORDS_ErrorCount := COUNT(GROUP,h.additionalname_suffix_Invalid=4);
    additionalname_suffix_Total_ErrorCount := COUNT(GROUP,h.additionalname_suffix_Invalid>0);
    aka1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka1_Invalid=1);
    aka1_ALLOW_ErrorCount := COUNT(GROUP,h.aka1_Invalid=2);
    aka1_LENGTH_ErrorCount := COUNT(GROUP,h.aka1_Invalid=3);
    aka1_WORDS_ErrorCount := COUNT(GROUP,h.aka1_Invalid=4);
    aka1_Total_ErrorCount := COUNT(GROUP,h.aka1_Invalid>0);
    aka2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka2_Invalid=1);
    aka2_ALLOW_ErrorCount := COUNT(GROUP,h.aka2_Invalid=2);
    aka2_LENGTH_ErrorCount := COUNT(GROUP,h.aka2_Invalid=3);
    aka2_WORDS_ErrorCount := COUNT(GROUP,h.aka2_Invalid=4);
    aka2_Total_ErrorCount := COUNT(GROUP,h.aka2_Invalid>0);
    aka3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka3_Invalid=1);
    aka3_ALLOW_ErrorCount := COUNT(GROUP,h.aka3_Invalid=2);
    aka3_LENGTH_ErrorCount := COUNT(GROUP,h.aka3_Invalid=3);
    aka3_WORDS_ErrorCount := COUNT(GROUP,h.aka3_Invalid=4);
    aka3_Total_ErrorCount := COUNT(GROUP,h.aka3_Invalid>0);
    recordtype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.recordtype_Invalid=1);
    recordtype_ALLOW_ErrorCount := COUNT(GROUP,h.recordtype_Invalid=2);
    recordtype_LENGTH_ErrorCount := COUNT(GROUP,h.recordtype_Invalid=3);
    recordtype_WORDS_ErrorCount := COUNT(GROUP,h.recordtype_Invalid=4);
    recordtype_Total_ErrorCount := COUNT(GROUP,h.recordtype_Invalid>0);
    addressstandardization_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressstandardization_Invalid=1);
    addressstandardization_ALLOW_ErrorCount := COUNT(GROUP,h.addressstandardization_Invalid=2);
    addressstandardization_LENGTH_ErrorCount := COUNT(GROUP,h.addressstandardization_Invalid=3);
    addressstandardization_WORDS_ErrorCount := COUNT(GROUP,h.addressstandardization_Invalid=4);
    addressstandardization_Total_ErrorCount := COUNT(GROUP,h.addressstandardization_Invalid>0);
    filesincedate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filesincedate_Invalid=1);
    filesincedate_ALLOW_ErrorCount := COUNT(GROUP,h.filesincedate_Invalid=2);
    filesincedate_LENGTH_ErrorCount := COUNT(GROUP,h.filesincedate_Invalid=3);
    filesincedate_WORDS_ErrorCount := COUNT(GROUP,h.filesincedate_Invalid=4);
    filesincedate_Total_ErrorCount := COUNT(GROUP,h.filesincedate_Invalid>0);
    compilationdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.compilationdate_Invalid=1);
    compilationdate_ALLOW_ErrorCount := COUNT(GROUP,h.compilationdate_Invalid=2);
    compilationdate_LENGTH_ErrorCount := COUNT(GROUP,h.compilationdate_Invalid=3);
    compilationdate_WORDS_ErrorCount := COUNT(GROUP,h.compilationdate_Invalid=4);
    compilationdate_Total_ErrorCount := COUNT(GROUP,h.compilationdate_Invalid>0);
    birthdateind_LEFTTRIM_ErrorCount := COUNT(GROUP,h.birthdateind_Invalid=1);
    birthdateind_ALLOW_ErrorCount := COUNT(GROUP,h.birthdateind_Invalid=2);
    birthdateind_LENGTH_ErrorCount := COUNT(GROUP,h.birthdateind_Invalid=3);
    birthdateind_WORDS_ErrorCount := COUNT(GROUP,h.birthdateind_Invalid=4);
    birthdateind_Total_ErrorCount := COUNT(GROUP,h.birthdateind_Invalid>0);
    orig_deceasedindicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_deceasedindicator_Invalid=1);
    orig_deceasedindicator_ALLOW_ErrorCount := COUNT(GROUP,h.orig_deceasedindicator_Invalid=2);
    orig_deceasedindicator_LENGTH_ErrorCount := COUNT(GROUP,h.orig_deceasedindicator_Invalid=3);
    orig_deceasedindicator_WORDS_ErrorCount := COUNT(GROUP,h.orig_deceasedindicator_Invalid=4);
    orig_deceasedindicator_Total_ErrorCount := COUNT(GROUP,h.orig_deceasedindicator_Invalid>0);
    deceaseddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=1);
    deceaseddate_ALLOW_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=2);
    deceaseddate_LENGTH_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=3);
    deceaseddate_WORDS_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=4);
    deceaseddate_Total_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid>0);
    addressseq_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=1);
    addressseq_ALLOW_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=2);
    addressseq_LENGTH_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=3);
    addressseq_WORDS_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=4);
    addressseq_Total_ErrorCount := COUNT(GROUP,h.addressseq_Invalid>0);
    normaddress_address1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_address1_Invalid=1);
    normaddress_address1_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_address1_Invalid=2);
    normaddress_address1_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_address1_Invalid=3);
    normaddress_address1_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_address1_Invalid=4);
    normaddress_address1_Total_ErrorCount := COUNT(GROUP,h.normaddress_address1_Invalid>0);
    normaddress_address2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_address2_Invalid=1);
    normaddress_address2_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_address2_Invalid=2);
    normaddress_address2_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_address2_Invalid=3);
    normaddress_address2_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_address2_Invalid=4);
    normaddress_address2_Total_ErrorCount := COUNT(GROUP,h.normaddress_address2_Invalid>0);
    normaddress_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_city_Invalid=1);
    normaddress_city_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_city_Invalid=2);
    normaddress_city_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_city_Invalid=3);
    normaddress_city_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_city_Invalid=4);
    normaddress_city_Total_ErrorCount := COUNT(GROUP,h.normaddress_city_Invalid>0);
    normaddress_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_state_Invalid=1);
    normaddress_state_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_state_Invalid=2);
    normaddress_state_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_state_Invalid=3);
    normaddress_state_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_state_Invalid=4);
    normaddress_state_Total_ErrorCount := COUNT(GROUP,h.normaddress_state_Invalid>0);
    normaddress_zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_zipcode_Invalid=1);
    normaddress_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_zipcode_Invalid=2);
    normaddress_zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_zipcode_Invalid=3);
    normaddress_zipcode_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_zipcode_Invalid=4);
    normaddress_zipcode_Total_ErrorCount := COUNT(GROUP,h.normaddress_zipcode_Invalid>0);
    normaddress_updateddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.normaddress_updateddate_Invalid=1);
    normaddress_updateddate_ALLOW_ErrorCount := COUNT(GROUP,h.normaddress_updateddate_Invalid=2);
    normaddress_updateddate_LENGTH_ErrorCount := COUNT(GROUP,h.normaddress_updateddate_Invalid=3);
    normaddress_updateddate_WORDS_ErrorCount := COUNT(GROUP,h.normaddress_updateddate_Invalid=4);
    normaddress_updateddate_Total_ErrorCount := COUNT(GROUP,h.normaddress_updateddate_Invalid>0);
    name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    name_ALLOW_ErrorCount := COUNT(GROUP,h.name_Invalid=2);
    name_LENGTH_ErrorCount := COUNT(GROUP,h.name_Invalid=3);
    name_WORDS_ErrorCount := COUNT(GROUP,h.name_Invalid=4);
    name_Total_ErrorCount := COUNT(GROUP,h.name_Invalid>0);
    nametype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    nametype_ALLOW_ErrorCount := COUNT(GROUP,h.nametype_Invalid=2);
    nametype_LENGTH_ErrorCount := COUNT(GROUP,h.nametype_Invalid=3);
    nametype_WORDS_ErrorCount := COUNT(GROUP,h.nametype_Invalid=4);
    nametype_Total_ErrorCount := COUNT(GROUP,h.nametype_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=4);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=4);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=4);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=4);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=4);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=2);
    name_score_LENGTH_ErrorCount := COUNT(GROUP,h.name_score_Invalid=3);
    name_score_WORDS_ErrorCount := COUNT(GROUP,h.name_score_Invalid=4);
    name_score_Total_ErrorCount := COUNT(GROUP,h.name_score_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_WORDS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=4);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_WORDS_ErrorCount := COUNT(GROUP,h.predir_Invalid=4);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_WORDS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=4);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=3);
    addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=4);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_WORDS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=4);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=4);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=4);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_WORDS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=4);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=4);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=3);
    st_WORDS_ErrorCount := COUNT(GROUP,h.st_Invalid=4);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=4);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=3);
    zip4_WORDS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=4);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=3);
    cart_WORDS_ErrorCount := COUNT(GROUP,h.cart_Invalid=4);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3);
    cr_sort_sz_WORDS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=3);
    lot_WORDS_ErrorCount := COUNT(GROUP,h.lot_Invalid=4);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=3);
    lot_order_WORDS_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=4);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_LENGTH_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=3);
    dbpc_WORDS_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=4);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=3);
    chk_digit_WORDS_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=4);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=3);
    rec_type_WORDS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=4);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_WORDS_ErrorCount := COUNT(GROUP,h.county_Invalid=4);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=3);
    geo_lat_WORDS_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=4);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=3);
    geo_long_WORDS_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=4);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=3);
    msa_WORDS_ErrorCount := COUNT(GROUP,h.msa_Invalid=4);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=3);
    geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=4);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=3);
    geo_match_WORDS_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=4);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=3);
    err_stat_WORDS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=4);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    transferdate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.transferdate_unformatted_Invalid=1);
    transferdate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.transferdate_unformatted_Invalid=2);
    transferdate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.transferdate_unformatted_Invalid=3);
    transferdate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.transferdate_unformatted_Invalid=4);
    transferdate_unformatted_Total_ErrorCount := COUNT(GROUP,h.transferdate_unformatted_Invalid>0);
    birthdate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.birthdate_unformatted_Invalid=1);
    birthdate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.birthdate_unformatted_Invalid=2);
    birthdate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.birthdate_unformatted_Invalid=3);
    birthdate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.birthdate_unformatted_Invalid=4);
    birthdate_unformatted_Total_ErrorCount := COUNT(GROUP,h.birthdate_unformatted_Invalid>0);
    dob_no_conflict_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dob_no_conflict_Invalid=1);
    dob_no_conflict_ALLOW_ErrorCount := COUNT(GROUP,h.dob_no_conflict_Invalid=2);
    dob_no_conflict_LENGTH_ErrorCount := COUNT(GROUP,h.dob_no_conflict_Invalid=3);
    dob_no_conflict_WORDS_ErrorCount := COUNT(GROUP,h.dob_no_conflict_Invalid=4);
    dob_no_conflict_Total_ErrorCount := COUNT(GROUP,h.dob_no_conflict_Invalid>0);
    updatedate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.updatedate_unformatted_Invalid=1);
    updatedate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.updatedate_unformatted_Invalid=2);
    updatedate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.updatedate_unformatted_Invalid=3);
    updatedate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.updatedate_unformatted_Invalid=4);
    updatedate_unformatted_Total_ErrorCount := COUNT(GROUP,h.updatedate_unformatted_Invalid>0);
    consumerupdatedate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.consumerupdatedate_unformatted_Invalid=1);
    consumerupdatedate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.consumerupdatedate_unformatted_Invalid=2);
    consumerupdatedate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.consumerupdatedate_unformatted_Invalid=3);
    consumerupdatedate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.consumerupdatedate_unformatted_Invalid=4);
    consumerupdatedate_unformatted_Total_ErrorCount := COUNT(GROUP,h.consumerupdatedate_unformatted_Invalid>0);
    filesincedate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filesincedate_unformatted_Invalid=1);
    filesincedate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.filesincedate_unformatted_Invalid=2);
    filesincedate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.filesincedate_unformatted_Invalid=3);
    filesincedate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.filesincedate_unformatted_Invalid=4);
    filesincedate_unformatted_Total_ErrorCount := COUNT(GROUP,h.filesincedate_unformatted_Invalid>0);
    compilationdate_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.compilationdate_unformatted_Invalid=1);
    compilationdate_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.compilationdate_unformatted_Invalid=2);
    compilationdate_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.compilationdate_unformatted_Invalid=3);
    compilationdate_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.compilationdate_unformatted_Invalid=4);
    compilationdate_unformatted_Total_ErrorCount := COUNT(GROUP,h.compilationdate_unformatted_Invalid>0);
    ssn_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_unformatted_Invalid=1);
    ssn_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_unformatted_Invalid=2);
    ssn_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_unformatted_Invalid=3);
    ssn_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.ssn_unformatted_Invalid=4);
    ssn_unformatted_Total_ErrorCount := COUNT(GROUP,h.ssn_unformatted_Invalid>0);
    ssn_no_conflict_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_no_conflict_Invalid=1);
    ssn_no_conflict_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_no_conflict_Invalid=2);
    ssn_no_conflict_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_no_conflict_Invalid=3);
    ssn_no_conflict_WORDS_ErrorCount := COUNT(GROUP,h.ssn_no_conflict_Invalid=4);
    ssn_no_conflict_Total_ErrorCount := COUNT(GROUP,h.ssn_no_conflict_Invalid>0);
    telephone_unformatted_LEFTTRIM_ErrorCount := COUNT(GROUP,h.telephone_unformatted_Invalid=1);
    telephone_unformatted_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_unformatted_Invalid=2);
    telephone_unformatted_LENGTH_ErrorCount := COUNT(GROUP,h.telephone_unformatted_Invalid=3);
    telephone_unformatted_WORDS_ErrorCount := COUNT(GROUP,h.telephone_unformatted_Invalid=4);
    telephone_unformatted_Total_ErrorCount := COUNT(GROUP,h.telephone_unformatted_Invalid>0);
    deceasedindicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceasedindicator_Invalid=1);
    deceasedindicator_ALLOW_ErrorCount := COUNT(GROUP,h.deceasedindicator_Invalid=2);
    deceasedindicator_LENGTH_ErrorCount := COUNT(GROUP,h.deceasedindicator_Invalid=3);
    deceasedindicator_WORDS_ErrorCount := COUNT(GROUP,h.deceasedindicator_Invalid=4);
    deceasedindicator_Total_ErrorCount := COUNT(GROUP,h.deceasedindicator_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_field_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=1);
    did_score_field_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=2);
    did_score_field_LENGTH_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=3);
    did_score_field_WORDS_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=4);
    did_score_field_Total_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid>0);
    is_current_LEFTTRIM_ErrorCount := COUNT(GROUP,h.is_current_Invalid=1);
    is_current_ALLOW_ErrorCount := COUNT(GROUP,h.is_current_Invalid=2);
    is_current_LENGTH_ErrorCount := COUNT(GROUP,h.is_current_Invalid=3);
    is_current_WORDS_ErrorCount := COUNT(GROUP,h.is_current_Invalid=4);
    is_current_Total_ErrorCount := COUNT(GROUP,h.is_current_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.filetype_Invalid,le.filedate_Invalid,le.vendordocumentidentifier_Invalid,le.transferdate_Invalid,le.currentname_firstname_Invalid,le.currentname_middlename_Invalid,le.currentname_middleinitial_Invalid,le.currentname_lastname_Invalid,le.currentname_suffix_Invalid,le.currentname_gender_Invalid,le.currentname_dob_mm_Invalid,le.currentname_dob_dd_Invalid,le.currentname_dob_yyyy_Invalid,le.currentname_deathindicator_Invalid,le.ssnfull_Invalid,le.ssnfirst5digit_Invalid,le.ssnlast4digit_Invalid,le.consumerupdatedate_Invalid,le.telephonenumber_Invalid,le.citedid_Invalid,le.fileid_Invalid,le.publication_Invalid,le.currentaddress_address1_Invalid,le.currentaddress_address2_Invalid,le.currentaddress_city_Invalid,le.currentaddress_state_Invalid,le.currentaddress_zipcode_Invalid,le.currentaddress_updateddate_Invalid,le.housenumber_Invalid,le.streettype_Invalid,le.streetdirection_Invalid,le.streetname_Invalid,le.apartmentnumber_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.zip4u_Invalid,le.previousaddress_address1_Invalid,le.previousaddress_address2_Invalid,le.previousaddress_city_Invalid,le.previousaddress_state_Invalid,le.previousaddress_zipcode_Invalid,le.previousaddress_updateddate_Invalid,le.formername_firstname_Invalid,le.formername_middlename_Invalid,le.formername_middleinitial_Invalid,le.formername_lastname_Invalid,le.formername_suffix_Invalid,le.aliasname_firstname_Invalid,le.aliasname_middlename_Invalid,le.aliasname_middleinitial_Invalid,le.aliasname_lastname_Invalid,le.aliasname_suffix_Invalid,le.additionalname_firstname_Invalid,le.additionalname_middlename_Invalid,le.additionalname_middleinitial_Invalid,le.additionalname_lastname_Invalid,le.additionalname_suffix_Invalid,le.aka1_Invalid,le.aka2_Invalid,le.aka3_Invalid,le.recordtype_Invalid,le.addressstandardization_Invalid,le.filesincedate_Invalid,le.compilationdate_Invalid,le.birthdateind_Invalid,le.orig_deceasedindicator_Invalid,le.deceaseddate_Invalid,le.addressseq_Invalid,le.normaddress_address1_Invalid,le.normaddress_address2_Invalid,le.normaddress_city_Invalid,le.normaddress_state_Invalid,le.normaddress_zipcode_Invalid,le.normaddress_updateddate_Invalid,le.name_Invalid,le.nametype_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.transferdate_unformatted_Invalid,le.birthdate_unformatted_Invalid,le.dob_no_conflict_Invalid,le.updatedate_unformatted_Invalid,le.consumerupdatedate_unformatted_Invalid,le.filesincedate_unformatted_Invalid,le.compilationdate_unformatted_Invalid,le.ssn_unformatted_Invalid,le.ssn_no_conflict_Invalid,le.telephone_unformatted_Invalid,le.deceasedindicator_Invalid,le.did_Invalid,le.did_score_field_Invalid,le.is_current_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_filetype(le.filetype_Invalid),Fields.InvalidMessage_filedate(le.filedate_Invalid),Fields.InvalidMessage_vendordocumentidentifier(le.vendordocumentidentifier_Invalid),Fields.InvalidMessage_transferdate(le.transferdate_Invalid),Fields.InvalidMessage_currentname_firstname(le.currentname_firstname_Invalid),Fields.InvalidMessage_currentname_middlename(le.currentname_middlename_Invalid),Fields.InvalidMessage_currentname_middleinitial(le.currentname_middleinitial_Invalid),Fields.InvalidMessage_currentname_lastname(le.currentname_lastname_Invalid),Fields.InvalidMessage_currentname_suffix(le.currentname_suffix_Invalid),Fields.InvalidMessage_currentname_gender(le.currentname_gender_Invalid),Fields.InvalidMessage_currentname_dob_mm(le.currentname_dob_mm_Invalid),Fields.InvalidMessage_currentname_dob_dd(le.currentname_dob_dd_Invalid),Fields.InvalidMessage_currentname_dob_yyyy(le.currentname_dob_yyyy_Invalid),Fields.InvalidMessage_currentname_deathindicator(le.currentname_deathindicator_Invalid),Fields.InvalidMessage_ssnfull(le.ssnfull_Invalid),Fields.InvalidMessage_ssnfirst5digit(le.ssnfirst5digit_Invalid),Fields.InvalidMessage_ssnlast4digit(le.ssnlast4digit_Invalid),Fields.InvalidMessage_consumerupdatedate(le.consumerupdatedate_Invalid),Fields.InvalidMessage_telephonenumber(le.telephonenumber_Invalid),Fields.InvalidMessage_citedid(le.citedid_Invalid),Fields.InvalidMessage_fileid(le.fileid_Invalid),Fields.InvalidMessage_publication(le.publication_Invalid),Fields.InvalidMessage_currentaddress_address1(le.currentaddress_address1_Invalid),Fields.InvalidMessage_currentaddress_address2(le.currentaddress_address2_Invalid),Fields.InvalidMessage_currentaddress_city(le.currentaddress_city_Invalid),Fields.InvalidMessage_currentaddress_state(le.currentaddress_state_Invalid),Fields.InvalidMessage_currentaddress_zipcode(le.currentaddress_zipcode_Invalid),Fields.InvalidMessage_currentaddress_updateddate(le.currentaddress_updateddate_Invalid),Fields.InvalidMessage_housenumber(le.housenumber_Invalid),Fields.InvalidMessage_streettype(le.streettype_Invalid),Fields.InvalidMessage_streetdirection(le.streetdirection_Invalid),Fields.InvalidMessage_streetname(le.streetname_Invalid),Fields.InvalidMessage_apartmentnumber(le.apartmentnumber_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_zip4u(le.zip4u_Invalid),Fields.InvalidMessage_previousaddress_address1(le.previousaddress_address1_Invalid),Fields.InvalidMessage_previousaddress_address2(le.previousaddress_address2_Invalid),Fields.InvalidMessage_previousaddress_city(le.previousaddress_city_Invalid),Fields.InvalidMessage_previousaddress_state(le.previousaddress_state_Invalid),Fields.InvalidMessage_previousaddress_zipcode(le.previousaddress_zipcode_Invalid),Fields.InvalidMessage_previousaddress_updateddate(le.previousaddress_updateddate_Invalid),Fields.InvalidMessage_formername_firstname(le.formername_firstname_Invalid),Fields.InvalidMessage_formername_middlename(le.formername_middlename_Invalid),Fields.InvalidMessage_formername_middleinitial(le.formername_middleinitial_Invalid),Fields.InvalidMessage_formername_lastname(le.formername_lastname_Invalid),Fields.InvalidMessage_formername_suffix(le.formername_suffix_Invalid),Fields.InvalidMessage_aliasname_firstname(le.aliasname_firstname_Invalid),Fields.InvalidMessage_aliasname_middlename(le.aliasname_middlename_Invalid),Fields.InvalidMessage_aliasname_middleinitial(le.aliasname_middleinitial_Invalid),Fields.InvalidMessage_aliasname_lastname(le.aliasname_lastname_Invalid),Fields.InvalidMessage_aliasname_suffix(le.aliasname_suffix_Invalid),Fields.InvalidMessage_additionalname_firstname(le.additionalname_firstname_Invalid),Fields.InvalidMessage_additionalname_middlename(le.additionalname_middlename_Invalid),Fields.InvalidMessage_additionalname_middleinitial(le.additionalname_middleinitial_Invalid),Fields.InvalidMessage_additionalname_lastname(le.additionalname_lastname_Invalid),Fields.InvalidMessage_additionalname_suffix(le.additionalname_suffix_Invalid),Fields.InvalidMessage_aka1(le.aka1_Invalid),Fields.InvalidMessage_aka2(le.aka2_Invalid),Fields.InvalidMessage_aka3(le.aka3_Invalid),Fields.InvalidMessage_recordtype(le.recordtype_Invalid),Fields.InvalidMessage_addressstandardization(le.addressstandardization_Invalid),Fields.InvalidMessage_filesincedate(le.filesincedate_Invalid),Fields.InvalidMessage_compilationdate(le.compilationdate_Invalid),Fields.InvalidMessage_birthdateind(le.birthdateind_Invalid),Fields.InvalidMessage_orig_deceasedindicator(le.orig_deceasedindicator_Invalid),Fields.InvalidMessage_deceaseddate(le.deceaseddate_Invalid),Fields.InvalidMessage_addressseq(le.addressseq_Invalid),Fields.InvalidMessage_normaddress_address1(le.normaddress_address1_Invalid),Fields.InvalidMessage_normaddress_address2(le.normaddress_address2_Invalid),Fields.InvalidMessage_normaddress_city(le.normaddress_city_Invalid),Fields.InvalidMessage_normaddress_state(le.normaddress_state_Invalid),Fields.InvalidMessage_normaddress_zipcode(le.normaddress_zipcode_Invalid),Fields.InvalidMessage_normaddress_updateddate(le.normaddress_updateddate_Invalid),Fields.InvalidMessage_name(le.name_Invalid),Fields.InvalidMessage_nametype(le.nametype_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_transferdate_unformatted(le.transferdate_unformatted_Invalid),Fields.InvalidMessage_birthdate_unformatted(le.birthdate_unformatted_Invalid),Fields.InvalidMessage_dob_no_conflict(le.dob_no_conflict_Invalid),Fields.InvalidMessage_updatedate_unformatted(le.updatedate_unformatted_Invalid),Fields.InvalidMessage_consumerupdatedate_unformatted(le.consumerupdatedate_unformatted_Invalid),Fields.InvalidMessage_filesincedate_unformatted(le.filesincedate_unformatted_Invalid),Fields.InvalidMessage_compilationdate_unformatted(le.compilationdate_unformatted_Invalid),Fields.InvalidMessage_ssn_unformatted(le.ssn_unformatted_Invalid),Fields.InvalidMessage_ssn_no_conflict(le.ssn_no_conflict_Invalid),Fields.InvalidMessage_telephone_unformatted(le.telephone_unformatted_Invalid),Fields.InvalidMessage_deceasedindicator(le.deceasedindicator_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score_field(le.did_score_field_Invalid),Fields.InvalidMessage_is_current(le.is_current_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filetype_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.vendordocumentidentifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.transferdate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_firstname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_middlename_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_middleinitial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_lastname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_suffix_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_gender_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_dob_mm_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_dob_dd_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_dob_yyyy_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentname_deathindicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssnfull_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssnfirst5digit_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssnlast4digit_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.consumerupdatedate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.telephonenumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.citedid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fileid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.publication_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_address1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_address2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentaddress_updateddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.housenumber_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.streettype_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.streetdirection_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.streetname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.apartmentnumber_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4u_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_address1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_address2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previousaddress_updateddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.formername_firstname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.formername_middlename_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.formername_middleinitial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.formername_lastname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.formername_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aliasname_firstname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aliasname_middlename_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aliasname_middleinitial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aliasname_lastname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aliasname_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additionalname_firstname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additionalname_middlename_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additionalname_middleinitial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additionalname_lastname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additionalname_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.recordtype_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addressstandardization_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filesincedate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.compilationdate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.birthdateind_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_deceasedindicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deceaseddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addressseq_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_address1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_address2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.normaddress_updateddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.transferdate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.birthdate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_no_conflict_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.updatedate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.consumerupdatedate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filesincedate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.compilationdate_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_no_conflict_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.telephone_unformatted_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deceasedindicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_field_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.is_current_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','filetype','filedate','vendordocumentidentifier','transferdate','currentname_firstname','currentname_middlename','currentname_middleinitial','currentname_lastname','currentname_suffix','currentname_gender','currentname_dob_mm','currentname_dob_dd','currentname_dob_yyyy','currentname_deathindicator','ssnfull','ssnfirst5digit','ssnlast4digit','consumerupdatedate','telephonenumber','citedid','fileid','publication','currentaddress_address1','currentaddress_address2','currentaddress_city','currentaddress_state','currentaddress_zipcode','currentaddress_updateddate','housenumber','streettype','streetdirection','streetname','apartmentnumber','city','state','zipcode','zip4u','previousaddress_address1','previousaddress_address2','previousaddress_city','previousaddress_state','previousaddress_zipcode','previousaddress_updateddate','formername_firstname','formername_middlename','formername_middleinitial','formername_lastname','formername_suffix','aliasname_firstname','aliasname_middlename','aliasname_middleinitial','aliasname_lastname','aliasname_suffix','additionalname_firstname','additionalname_middlename','additionalname_middleinitial','additionalname_lastname','additionalname_suffix','aka1','aka2','aka3','recordtype','addressstandardization','filesincedate','compilationdate','birthdateind','orig_deceasedindicator','deceaseddate','addressseq','normaddress_address1','normaddress_address2','normaddress_city','normaddress_state','normaddress_zipcode','normaddress_updateddate','name','nametype','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','transferdate_unformatted','birthdate_unformatted','dob_no_conflict','updatedate_unformatted','consumerupdatedate_unformatted','filesincedate_unformatted','compilationdate_unformatted','ssn_unformatted','ssn_no_conflict','telephone_unformatted','deceasedindicator','did','did_score_field','is_current','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.dt_first_seen,(SALT34.StrType)le.dt_last_seen,(SALT34.StrType)le.dt_vendor_first_reported,(SALT34.StrType)le.dt_vendor_last_reported,(SALT34.StrType)le.filetype,(SALT34.StrType)le.filedate,(SALT34.StrType)le.vendordocumentidentifier,(SALT34.StrType)le.transferdate,(SALT34.StrType)le.currentname_firstname,(SALT34.StrType)le.currentname_middlename,(SALT34.StrType)le.currentname_middleinitial,(SALT34.StrType)le.currentname_lastname,(SALT34.StrType)le.currentname_suffix,(SALT34.StrType)le.currentname_gender,(SALT34.StrType)le.currentname_dob_mm,(SALT34.StrType)le.currentname_dob_dd,(SALT34.StrType)le.currentname_dob_yyyy,(SALT34.StrType)le.currentname_deathindicator,(SALT34.StrType)le.ssnfull,(SALT34.StrType)le.ssnfirst5digit,(SALT34.StrType)le.ssnlast4digit,(SALT34.StrType)le.consumerupdatedate,(SALT34.StrType)le.telephonenumber,(SALT34.StrType)le.citedid,(SALT34.StrType)le.fileid,(SALT34.StrType)le.publication,(SALT34.StrType)le.currentaddress_address1,(SALT34.StrType)le.currentaddress_address2,(SALT34.StrType)le.currentaddress_city,(SALT34.StrType)le.currentaddress_state,(SALT34.StrType)le.currentaddress_zipcode,(SALT34.StrType)le.currentaddress_updateddate,(SALT34.StrType)le.housenumber,(SALT34.StrType)le.streettype,(SALT34.StrType)le.streetdirection,(SALT34.StrType)le.streetname,(SALT34.StrType)le.apartmentnumber,(SALT34.StrType)le.city,(SALT34.StrType)le.state,(SALT34.StrType)le.zipcode,(SALT34.StrType)le.zip4u,(SALT34.StrType)le.previousaddress_address1,(SALT34.StrType)le.previousaddress_address2,(SALT34.StrType)le.previousaddress_city,(SALT34.StrType)le.previousaddress_state,(SALT34.StrType)le.previousaddress_zipcode,(SALT34.StrType)le.previousaddress_updateddate,(SALT34.StrType)le.formername_firstname,(SALT34.StrType)le.formername_middlename,(SALT34.StrType)le.formername_middleinitial,(SALT34.StrType)le.formername_lastname,(SALT34.StrType)le.formername_suffix,(SALT34.StrType)le.aliasname_firstname,(SALT34.StrType)le.aliasname_middlename,(SALT34.StrType)le.aliasname_middleinitial,(SALT34.StrType)le.aliasname_lastname,(SALT34.StrType)le.aliasname_suffix,(SALT34.StrType)le.additionalname_firstname,(SALT34.StrType)le.additionalname_middlename,(SALT34.StrType)le.additionalname_middleinitial,(SALT34.StrType)le.additionalname_lastname,(SALT34.StrType)le.additionalname_suffix,(SALT34.StrType)le.aka1,(SALT34.StrType)le.aka2,(SALT34.StrType)le.aka3,(SALT34.StrType)le.recordtype,(SALT34.StrType)le.addressstandardization,(SALT34.StrType)le.filesincedate,(SALT34.StrType)le.compilationdate,(SALT34.StrType)le.birthdateind,(SALT34.StrType)le.orig_deceasedindicator,(SALT34.StrType)le.deceaseddate,(SALT34.StrType)le.addressseq,(SALT34.StrType)le.normaddress_address1,(SALT34.StrType)le.normaddress_address2,(SALT34.StrType)le.normaddress_city,(SALT34.StrType)le.normaddress_state,(SALT34.StrType)le.normaddress_zipcode,(SALT34.StrType)le.normaddress_updateddate,(SALT34.StrType)le.name,(SALT34.StrType)le.nametype,(SALT34.StrType)le.title,(SALT34.StrType)le.fname,(SALT34.StrType)le.mname,(SALT34.StrType)le.lname,(SALT34.StrType)le.name_suffix,(SALT34.StrType)le.name_score,(SALT34.StrType)le.prim_range,(SALT34.StrType)le.predir,(SALT34.StrType)le.prim_name,(SALT34.StrType)le.addr_suffix,(SALT34.StrType)le.postdir,(SALT34.StrType)le.unit_desig,(SALT34.StrType)le.sec_range,(SALT34.StrType)le.p_city_name,(SALT34.StrType)le.v_city_name,(SALT34.StrType)le.st,(SALT34.StrType)le.zip,(SALT34.StrType)le.zip4,(SALT34.StrType)le.cart,(SALT34.StrType)le.cr_sort_sz,(SALT34.StrType)le.lot,(SALT34.StrType)le.lot_order,(SALT34.StrType)le.dbpc,(SALT34.StrType)le.chk_digit,(SALT34.StrType)le.rec_type,(SALT34.StrType)le.county,(SALT34.StrType)le.geo_lat,(SALT34.StrType)le.geo_long,(SALT34.StrType)le.msa,(SALT34.StrType)le.geo_blk,(SALT34.StrType)le.geo_match,(SALT34.StrType)le.err_stat,(SALT34.StrType)le.transferdate_unformatted,(SALT34.StrType)le.birthdate_unformatted,(SALT34.StrType)le.dob_no_conflict,(SALT34.StrType)le.updatedate_unformatted,(SALT34.StrType)le.consumerupdatedate_unformatted,(SALT34.StrType)le.filesincedate_unformatted,(SALT34.StrType)le.compilationdate_unformatted,(SALT34.StrType)le.ssn_unformatted,(SALT34.StrType)le.ssn_no_conflict,(SALT34.StrType)le.telephone_unformatted,(SALT34.StrType)le.deceasedindicator,(SALT34.StrType)le.did,(SALT34.StrType)le.did_score_field,(SALT34.StrType)le.is_current,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,127,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTH','dt_first_seen:dt_first_seen:WORDS'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTH','dt_last_seen:dt_last_seen:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'filetype:filetype:LEFTTRIM','filetype:filetype:ALLOW','filetype:filetype:LENGTH','filetype:filetype:WORDS'
          ,'filedate:filedate:LEFTTRIM','filedate:filedate:ALLOW','filedate:filedate:LENGTH','filedate:filedate:WORDS'
          ,'vendordocumentidentifier:vendordocumentidentifier:LEFTTRIM','vendordocumentidentifier:vendordocumentidentifier:ALLOW','vendordocumentidentifier:vendordocumentidentifier:LENGTH','vendordocumentidentifier:vendordocumentidentifier:WORDS'
          ,'transferdate:transferdate:LEFTTRIM','transferdate:transferdate:ALLOW','transferdate:transferdate:LENGTH','transferdate:transferdate:WORDS'
          ,'currentname_firstname:currentname_firstname:LEFTTRIM','currentname_firstname:currentname_firstname:ALLOW','currentname_firstname:currentname_firstname:LENGTH','currentname_firstname:currentname_firstname:WORDS'
          ,'currentname_middlename:currentname_middlename:LEFTTRIM','currentname_middlename:currentname_middlename:ALLOW','currentname_middlename:currentname_middlename:LENGTH','currentname_middlename:currentname_middlename:WORDS'
          ,'currentname_middleinitial:currentname_middleinitial:LEFTTRIM','currentname_middleinitial:currentname_middleinitial:ALLOW','currentname_middleinitial:currentname_middleinitial:LENGTH','currentname_middleinitial:currentname_middleinitial:WORDS'
          ,'currentname_lastname:currentname_lastname:LEFTTRIM','currentname_lastname:currentname_lastname:ALLOW','currentname_lastname:currentname_lastname:LENGTH','currentname_lastname:currentname_lastname:WORDS'
          ,'currentname_suffix:currentname_suffix:ALLOW','currentname_suffix:currentname_suffix:LENGTH','currentname_suffix:currentname_suffix:WORDS'
          ,'currentname_gender:currentname_gender:LEFTTRIM','currentname_gender:currentname_gender:ALLOW','currentname_gender:currentname_gender:LENGTH','currentname_gender:currentname_gender:WORDS'
          ,'currentname_dob_mm:currentname_dob_mm:LEFTTRIM','currentname_dob_mm:currentname_dob_mm:ALLOW','currentname_dob_mm:currentname_dob_mm:LENGTH','currentname_dob_mm:currentname_dob_mm:WORDS'
          ,'currentname_dob_dd:currentname_dob_dd:LEFTTRIM','currentname_dob_dd:currentname_dob_dd:ALLOW','currentname_dob_dd:currentname_dob_dd:LENGTH','currentname_dob_dd:currentname_dob_dd:WORDS'
          ,'currentname_dob_yyyy:currentname_dob_yyyy:LEFTTRIM','currentname_dob_yyyy:currentname_dob_yyyy:ALLOW','currentname_dob_yyyy:currentname_dob_yyyy:LENGTH','currentname_dob_yyyy:currentname_dob_yyyy:WORDS'
          ,'currentname_deathindicator:currentname_deathindicator:LEFTTRIM','currentname_deathindicator:currentname_deathindicator:ALLOW','currentname_deathindicator:currentname_deathindicator:LENGTH','currentname_deathindicator:currentname_deathindicator:WORDS'
          ,'ssnfull:ssnfull:LEFTTRIM','ssnfull:ssnfull:ALLOW','ssnfull:ssnfull:LENGTH','ssnfull:ssnfull:WORDS'
          ,'ssnfirst5digit:ssnfirst5digit:LEFTTRIM','ssnfirst5digit:ssnfirst5digit:ALLOW','ssnfirst5digit:ssnfirst5digit:LENGTH','ssnfirst5digit:ssnfirst5digit:WORDS'
          ,'ssnlast4digit:ssnlast4digit:LEFTTRIM','ssnlast4digit:ssnlast4digit:ALLOW','ssnlast4digit:ssnlast4digit:LENGTH','ssnlast4digit:ssnlast4digit:WORDS'
          ,'consumerupdatedate:consumerupdatedate:LEFTTRIM','consumerupdatedate:consumerupdatedate:ALLOW','consumerupdatedate:consumerupdatedate:LENGTH','consumerupdatedate:consumerupdatedate:WORDS'
          ,'telephonenumber:telephonenumber:LEFTTRIM','telephonenumber:telephonenumber:ALLOW','telephonenumber:telephonenumber:LENGTH','telephonenumber:telephonenumber:WORDS'
          ,'citedid:citedid:LEFTTRIM','citedid:citedid:ALLOW','citedid:citedid:LENGTH','citedid:citedid:WORDS'
          ,'fileid:fileid:LEFTTRIM','fileid:fileid:ALLOW','fileid:fileid:LENGTH','fileid:fileid:WORDS'
          ,'publication:publication:LEFTTRIM','publication:publication:ALLOW','publication:publication:LENGTH','publication:publication:WORDS'
          ,'currentaddress_address1:currentaddress_address1:LEFTTRIM','currentaddress_address1:currentaddress_address1:ALLOW','currentaddress_address1:currentaddress_address1:LENGTH','currentaddress_address1:currentaddress_address1:WORDS'
          ,'currentaddress_address2:currentaddress_address2:LEFTTRIM','currentaddress_address2:currentaddress_address2:ALLOW','currentaddress_address2:currentaddress_address2:LENGTH','currentaddress_address2:currentaddress_address2:WORDS'
          ,'currentaddress_city:currentaddress_city:LEFTTRIM','currentaddress_city:currentaddress_city:ALLOW','currentaddress_city:currentaddress_city:LENGTH','currentaddress_city:currentaddress_city:WORDS'
          ,'currentaddress_state:currentaddress_state:LEFTTRIM','currentaddress_state:currentaddress_state:ALLOW','currentaddress_state:currentaddress_state:LENGTH','currentaddress_state:currentaddress_state:WORDS'
          ,'currentaddress_zipcode:currentaddress_zipcode:LEFTTRIM','currentaddress_zipcode:currentaddress_zipcode:ALLOW','currentaddress_zipcode:currentaddress_zipcode:LENGTH','currentaddress_zipcode:currentaddress_zipcode:WORDS'
          ,'currentaddress_updateddate:currentaddress_updateddate:LEFTTRIM','currentaddress_updateddate:currentaddress_updateddate:ALLOW','currentaddress_updateddate:currentaddress_updateddate:LENGTH','currentaddress_updateddate:currentaddress_updateddate:WORDS'
          ,'housenumber:housenumber:ALLOW','housenumber:housenumber:LENGTH','housenumber:housenumber:WORDS'
          ,'streettype:streettype:LEFTTRIM','streettype:streettype:ALLOW','streettype:streettype:LENGTH','streettype:streettype:WORDS'
          ,'streetdirection:streetdirection:LEFTTRIM','streetdirection:streetdirection:ALLOW','streetdirection:streetdirection:LENGTH','streetdirection:streetdirection:WORDS'
          ,'streetname:streetname:LEFTTRIM','streetname:streetname:ALLOW','streetname:streetname:LENGTH','streetname:streetname:WORDS'
          ,'apartmentnumber:apartmentnumber:ALLOW','apartmentnumber:apartmentnumber:LENGTH','apartmentnumber:apartmentnumber:WORDS'
          ,'city:city:LEFTTRIM','city:city:ALLOW','city:city:LENGTH','city:city:WORDS'
          ,'state:state:LEFTTRIM','state:state:ALLOW','state:state:LENGTH','state:state:WORDS'
          ,'zipcode:zipcode:LEFTTRIM','zipcode:zipcode:ALLOW','zipcode:zipcode:LENGTH','zipcode:zipcode:WORDS'
          ,'zip4u:zip4u:LEFTTRIM','zip4u:zip4u:ALLOW','zip4u:zip4u:LENGTH','zip4u:zip4u:WORDS'
          ,'previousaddress_address1:previousaddress_address1:LEFTTRIM','previousaddress_address1:previousaddress_address1:ALLOW','previousaddress_address1:previousaddress_address1:LENGTH','previousaddress_address1:previousaddress_address1:WORDS'
          ,'previousaddress_address2:previousaddress_address2:LEFTTRIM','previousaddress_address2:previousaddress_address2:ALLOW','previousaddress_address2:previousaddress_address2:LENGTH','previousaddress_address2:previousaddress_address2:WORDS'
          ,'previousaddress_city:previousaddress_city:LEFTTRIM','previousaddress_city:previousaddress_city:ALLOW','previousaddress_city:previousaddress_city:LENGTH','previousaddress_city:previousaddress_city:WORDS'
          ,'previousaddress_state:previousaddress_state:LEFTTRIM','previousaddress_state:previousaddress_state:ALLOW','previousaddress_state:previousaddress_state:LENGTH','previousaddress_state:previousaddress_state:WORDS'
          ,'previousaddress_zipcode:previousaddress_zipcode:LEFTTRIM','previousaddress_zipcode:previousaddress_zipcode:ALLOW','previousaddress_zipcode:previousaddress_zipcode:LENGTH','previousaddress_zipcode:previousaddress_zipcode:WORDS'
          ,'previousaddress_updateddate:previousaddress_updateddate:LEFTTRIM','previousaddress_updateddate:previousaddress_updateddate:ALLOW','previousaddress_updateddate:previousaddress_updateddate:LENGTH','previousaddress_updateddate:previousaddress_updateddate:WORDS'
          ,'formername_firstname:formername_firstname:LEFTTRIM','formername_firstname:formername_firstname:ALLOW','formername_firstname:formername_firstname:LENGTH','formername_firstname:formername_firstname:WORDS'
          ,'formername_middlename:formername_middlename:LEFTTRIM','formername_middlename:formername_middlename:ALLOW','formername_middlename:formername_middlename:LENGTH','formername_middlename:formername_middlename:WORDS'
          ,'formername_middleinitial:formername_middleinitial:LEFTTRIM','formername_middleinitial:formername_middleinitial:ALLOW','formername_middleinitial:formername_middleinitial:LENGTH','formername_middleinitial:formername_middleinitial:WORDS'
          ,'formername_lastname:formername_lastname:LEFTTRIM','formername_lastname:formername_lastname:ALLOW','formername_lastname:formername_lastname:LENGTH','formername_lastname:formername_lastname:WORDS'
          ,'formername_suffix:formername_suffix:LEFTTRIM','formername_suffix:formername_suffix:ALLOW','formername_suffix:formername_suffix:LENGTH','formername_suffix:formername_suffix:WORDS'
          ,'aliasname_firstname:aliasname_firstname:LEFTTRIM','aliasname_firstname:aliasname_firstname:ALLOW','aliasname_firstname:aliasname_firstname:LENGTH','aliasname_firstname:aliasname_firstname:WORDS'
          ,'aliasname_middlename:aliasname_middlename:LEFTTRIM','aliasname_middlename:aliasname_middlename:ALLOW','aliasname_middlename:aliasname_middlename:LENGTH','aliasname_middlename:aliasname_middlename:WORDS'
          ,'aliasname_middleinitial:aliasname_middleinitial:LEFTTRIM','aliasname_middleinitial:aliasname_middleinitial:ALLOW','aliasname_middleinitial:aliasname_middleinitial:LENGTH','aliasname_middleinitial:aliasname_middleinitial:WORDS'
          ,'aliasname_lastname:aliasname_lastname:LEFTTRIM','aliasname_lastname:aliasname_lastname:ALLOW','aliasname_lastname:aliasname_lastname:LENGTH','aliasname_lastname:aliasname_lastname:WORDS'
          ,'aliasname_suffix:aliasname_suffix:LEFTTRIM','aliasname_suffix:aliasname_suffix:ALLOW','aliasname_suffix:aliasname_suffix:LENGTH','aliasname_suffix:aliasname_suffix:WORDS'
          ,'additionalname_firstname:additionalname_firstname:LEFTTRIM','additionalname_firstname:additionalname_firstname:ALLOW','additionalname_firstname:additionalname_firstname:LENGTH','additionalname_firstname:additionalname_firstname:WORDS'
          ,'additionalname_middlename:additionalname_middlename:LEFTTRIM','additionalname_middlename:additionalname_middlename:ALLOW','additionalname_middlename:additionalname_middlename:LENGTH','additionalname_middlename:additionalname_middlename:WORDS'
          ,'additionalname_middleinitial:additionalname_middleinitial:LEFTTRIM','additionalname_middleinitial:additionalname_middleinitial:ALLOW','additionalname_middleinitial:additionalname_middleinitial:LENGTH','additionalname_middleinitial:additionalname_middleinitial:WORDS'
          ,'additionalname_lastname:additionalname_lastname:LEFTTRIM','additionalname_lastname:additionalname_lastname:ALLOW','additionalname_lastname:additionalname_lastname:LENGTH','additionalname_lastname:additionalname_lastname:WORDS'
          ,'additionalname_suffix:additionalname_suffix:LEFTTRIM','additionalname_suffix:additionalname_suffix:ALLOW','additionalname_suffix:additionalname_suffix:LENGTH','additionalname_suffix:additionalname_suffix:WORDS'
          ,'aka1:aka1:LEFTTRIM','aka1:aka1:ALLOW','aka1:aka1:LENGTH','aka1:aka1:WORDS'
          ,'aka2:aka2:LEFTTRIM','aka2:aka2:ALLOW','aka2:aka2:LENGTH','aka2:aka2:WORDS'
          ,'aka3:aka3:LEFTTRIM','aka3:aka3:ALLOW','aka3:aka3:LENGTH','aka3:aka3:WORDS'
          ,'recordtype:recordtype:LEFTTRIM','recordtype:recordtype:ALLOW','recordtype:recordtype:LENGTH','recordtype:recordtype:WORDS'
          ,'addressstandardization:addressstandardization:LEFTTRIM','addressstandardization:addressstandardization:ALLOW','addressstandardization:addressstandardization:LENGTH','addressstandardization:addressstandardization:WORDS'
          ,'filesincedate:filesincedate:LEFTTRIM','filesincedate:filesincedate:ALLOW','filesincedate:filesincedate:LENGTH','filesincedate:filesincedate:WORDS'
          ,'compilationdate:compilationdate:LEFTTRIM','compilationdate:compilationdate:ALLOW','compilationdate:compilationdate:LENGTH','compilationdate:compilationdate:WORDS'
          ,'birthdateind:birthdateind:LEFTTRIM','birthdateind:birthdateind:ALLOW','birthdateind:birthdateind:LENGTH','birthdateind:birthdateind:WORDS'
          ,'orig_deceasedindicator:orig_deceasedindicator:LEFTTRIM','orig_deceasedindicator:orig_deceasedindicator:ALLOW','orig_deceasedindicator:orig_deceasedindicator:LENGTH','orig_deceasedindicator:orig_deceasedindicator:WORDS'
          ,'deceaseddate:deceaseddate:LEFTTRIM','deceaseddate:deceaseddate:ALLOW','deceaseddate:deceaseddate:LENGTH','deceaseddate:deceaseddate:WORDS'
          ,'addressseq:addressseq:LEFTTRIM','addressseq:addressseq:ALLOW','addressseq:addressseq:LENGTH','addressseq:addressseq:WORDS'
          ,'normaddress_address1:normaddress_address1:LEFTTRIM','normaddress_address1:normaddress_address1:ALLOW','normaddress_address1:normaddress_address1:LENGTH','normaddress_address1:normaddress_address1:WORDS'
          ,'normaddress_address2:normaddress_address2:LEFTTRIM','normaddress_address2:normaddress_address2:ALLOW','normaddress_address2:normaddress_address2:LENGTH','normaddress_address2:normaddress_address2:WORDS'
          ,'normaddress_city:normaddress_city:LEFTTRIM','normaddress_city:normaddress_city:ALLOW','normaddress_city:normaddress_city:LENGTH','normaddress_city:normaddress_city:WORDS'
          ,'normaddress_state:normaddress_state:LEFTTRIM','normaddress_state:normaddress_state:ALLOW','normaddress_state:normaddress_state:LENGTH','normaddress_state:normaddress_state:WORDS'
          ,'normaddress_zipcode:normaddress_zipcode:LEFTTRIM','normaddress_zipcode:normaddress_zipcode:ALLOW','normaddress_zipcode:normaddress_zipcode:LENGTH','normaddress_zipcode:normaddress_zipcode:WORDS'
          ,'normaddress_updateddate:normaddress_updateddate:LEFTTRIM','normaddress_updateddate:normaddress_updateddate:ALLOW','normaddress_updateddate:normaddress_updateddate:LENGTH','normaddress_updateddate:normaddress_updateddate:WORDS'
          ,'name:name:LEFTTRIM','name:name:ALLOW','name:name:LENGTH','name:name:WORDS'
          ,'nametype:nametype:LEFTTRIM','nametype:nametype:ALLOW','nametype:nametype:LENGTH','nametype:nametype:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTH','title:title:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:LENGTH','fname:fname:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:LENGTH','mname:mname:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:LENGTH','lname:lname:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTH','name_suffix:name_suffix:WORDS'
          ,'name_score:name_score:LEFTTRIM','name_score:name_score:ALLOW','name_score:name_score:LENGTH','name_score:name_score:WORDS'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW','prim_range:prim_range:LENGTH','prim_range:prim_range:WORDS'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW','predir:predir:LENGTH','predir:predir:WORDS'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW','prim_name:prim_name:LENGTH','prim_name:prim_name:WORDS'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTH','addr_suffix:addr_suffix:WORDS'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW','postdir:postdir:LENGTH','postdir:postdir:WORDS'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW','unit_desig:unit_desig:LENGTH','unit_desig:unit_desig:WORDS'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTH','sec_range:sec_range:WORDS'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW','p_city_name:p_city_name:LENGTH','p_city_name:p_city_name:WORDS'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW','v_city_name:v_city_name:LENGTH','v_city_name:v_city_name:WORDS'
          ,'st:st:LEFTTRIM','st:st:ALLOW','st:st:LENGTH','st:st:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTH','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTH','zip4:zip4:WORDS'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW','cart:cart:LENGTH','cart:cart:WORDS'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTH','cr_sort_sz:cr_sort_sz:WORDS'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW','lot:lot:LENGTH','lot:lot:WORDS'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW','lot_order:lot_order:LENGTH','lot_order:lot_order:WORDS'
          ,'dbpc:dbpc:LEFTTRIM','dbpc:dbpc:ALLOW','dbpc:dbpc:LENGTH','dbpc:dbpc:WORDS'
          ,'chk_digit:chk_digit:LEFTTRIM','chk_digit:chk_digit:ALLOW','chk_digit:chk_digit:LENGTH','chk_digit:chk_digit:WORDS'
          ,'rec_type:rec_type:LEFTTRIM','rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTH','rec_type:rec_type:WORDS'
          ,'county:county:LEFTTRIM','county:county:ALLOW','county:county:LENGTH','county:county:WORDS'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTH','geo_lat:geo_lat:WORDS'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTH','geo_long:geo_long:WORDS'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW','msa:msa:LENGTH','msa:msa:WORDS'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTH','geo_blk:geo_blk:WORDS'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTH','geo_match:geo_match:WORDS'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTH','err_stat:err_stat:WORDS'
          ,'transferdate_unformatted:transferdate_unformatted:LEFTTRIM','transferdate_unformatted:transferdate_unformatted:ALLOW','transferdate_unformatted:transferdate_unformatted:LENGTH','transferdate_unformatted:transferdate_unformatted:WORDS'
          ,'birthdate_unformatted:birthdate_unformatted:LEFTTRIM','birthdate_unformatted:birthdate_unformatted:ALLOW','birthdate_unformatted:birthdate_unformatted:LENGTH','birthdate_unformatted:birthdate_unformatted:WORDS'
          ,'dob_no_conflict:dob_no_conflict:LEFTTRIM','dob_no_conflict:dob_no_conflict:ALLOW','dob_no_conflict:dob_no_conflict:LENGTH','dob_no_conflict:dob_no_conflict:WORDS'
          ,'updatedate_unformatted:updatedate_unformatted:LEFTTRIM','updatedate_unformatted:updatedate_unformatted:ALLOW','updatedate_unformatted:updatedate_unformatted:LENGTH','updatedate_unformatted:updatedate_unformatted:WORDS'
          ,'consumerupdatedate_unformatted:consumerupdatedate_unformatted:LEFTTRIM','consumerupdatedate_unformatted:consumerupdatedate_unformatted:ALLOW','consumerupdatedate_unformatted:consumerupdatedate_unformatted:LENGTH','consumerupdatedate_unformatted:consumerupdatedate_unformatted:WORDS'
          ,'filesincedate_unformatted:filesincedate_unformatted:LEFTTRIM','filesincedate_unformatted:filesincedate_unformatted:ALLOW','filesincedate_unformatted:filesincedate_unformatted:LENGTH','filesincedate_unformatted:filesincedate_unformatted:WORDS'
          ,'compilationdate_unformatted:compilationdate_unformatted:LEFTTRIM','compilationdate_unformatted:compilationdate_unformatted:ALLOW','compilationdate_unformatted:compilationdate_unformatted:LENGTH','compilationdate_unformatted:compilationdate_unformatted:WORDS'
          ,'ssn_unformatted:ssn_unformatted:LEFTTRIM','ssn_unformatted:ssn_unformatted:ALLOW','ssn_unformatted:ssn_unformatted:LENGTH','ssn_unformatted:ssn_unformatted:WORDS'
          ,'ssn_no_conflict:ssn_no_conflict:LEFTTRIM','ssn_no_conflict:ssn_no_conflict:ALLOW','ssn_no_conflict:ssn_no_conflict:LENGTH','ssn_no_conflict:ssn_no_conflict:WORDS'
          ,'telephone_unformatted:telephone_unformatted:LEFTTRIM','telephone_unformatted:telephone_unformatted:ALLOW','telephone_unformatted:telephone_unformatted:LENGTH','telephone_unformatted:telephone_unformatted:WORDS'
          ,'deceasedindicator:deceasedindicator:LEFTTRIM','deceasedindicator:deceasedindicator:ALLOW','deceasedindicator:deceasedindicator:LENGTH','deceasedindicator:deceasedindicator:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'did_score_field:did_score_field:LEFTTRIM','did_score_field:did_score_field:ALLOW','did_score_field:did_score_field:LENGTH','did_score_field:did_score_field:WORDS'
          ,'is_current:is_current:LEFTTRIM','is_current:is_current:ALLOW','is_current:is_current:LENGTH','is_current:is_current:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3),Fields.InvalidMessage_dt_first_seen(4)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3),Fields.InvalidMessage_dt_last_seen(4)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3),Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3),Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,Fields.InvalidMessage_filetype(1),Fields.InvalidMessage_filetype(2),Fields.InvalidMessage_filetype(3),Fields.InvalidMessage_filetype(4)
          ,Fields.InvalidMessage_filedate(1),Fields.InvalidMessage_filedate(2),Fields.InvalidMessage_filedate(3),Fields.InvalidMessage_filedate(4)
          ,Fields.InvalidMessage_vendordocumentidentifier(1),Fields.InvalidMessage_vendordocumentidentifier(2),Fields.InvalidMessage_vendordocumentidentifier(3),Fields.InvalidMessage_vendordocumentidentifier(4)
          ,Fields.InvalidMessage_transferdate(1),Fields.InvalidMessage_transferdate(2),Fields.InvalidMessage_transferdate(3),Fields.InvalidMessage_transferdate(4)
          ,Fields.InvalidMessage_currentname_firstname(1),Fields.InvalidMessage_currentname_firstname(2),Fields.InvalidMessage_currentname_firstname(3),Fields.InvalidMessage_currentname_firstname(4)
          ,Fields.InvalidMessage_currentname_middlename(1),Fields.InvalidMessage_currentname_middlename(2),Fields.InvalidMessage_currentname_middlename(3),Fields.InvalidMessage_currentname_middlename(4)
          ,Fields.InvalidMessage_currentname_middleinitial(1),Fields.InvalidMessage_currentname_middleinitial(2),Fields.InvalidMessage_currentname_middleinitial(3),Fields.InvalidMessage_currentname_middleinitial(4)
          ,Fields.InvalidMessage_currentname_lastname(1),Fields.InvalidMessage_currentname_lastname(2),Fields.InvalidMessage_currentname_lastname(3),Fields.InvalidMessage_currentname_lastname(4)
          ,Fields.InvalidMessage_currentname_suffix(1),Fields.InvalidMessage_currentname_suffix(2),Fields.InvalidMessage_currentname_suffix(3)
          ,Fields.InvalidMessage_currentname_gender(1),Fields.InvalidMessage_currentname_gender(2),Fields.InvalidMessage_currentname_gender(3),Fields.InvalidMessage_currentname_gender(4)
          ,Fields.InvalidMessage_currentname_dob_mm(1),Fields.InvalidMessage_currentname_dob_mm(2),Fields.InvalidMessage_currentname_dob_mm(3),Fields.InvalidMessage_currentname_dob_mm(4)
          ,Fields.InvalidMessage_currentname_dob_dd(1),Fields.InvalidMessage_currentname_dob_dd(2),Fields.InvalidMessage_currentname_dob_dd(3),Fields.InvalidMessage_currentname_dob_dd(4)
          ,Fields.InvalidMessage_currentname_dob_yyyy(1),Fields.InvalidMessage_currentname_dob_yyyy(2),Fields.InvalidMessage_currentname_dob_yyyy(3),Fields.InvalidMessage_currentname_dob_yyyy(4)
          ,Fields.InvalidMessage_currentname_deathindicator(1),Fields.InvalidMessage_currentname_deathindicator(2),Fields.InvalidMessage_currentname_deathindicator(3),Fields.InvalidMessage_currentname_deathindicator(4)
          ,Fields.InvalidMessage_ssnfull(1),Fields.InvalidMessage_ssnfull(2),Fields.InvalidMessage_ssnfull(3),Fields.InvalidMessage_ssnfull(4)
          ,Fields.InvalidMessage_ssnfirst5digit(1),Fields.InvalidMessage_ssnfirst5digit(2),Fields.InvalidMessage_ssnfirst5digit(3),Fields.InvalidMessage_ssnfirst5digit(4)
          ,Fields.InvalidMessage_ssnlast4digit(1),Fields.InvalidMessage_ssnlast4digit(2),Fields.InvalidMessage_ssnlast4digit(3),Fields.InvalidMessage_ssnlast4digit(4)
          ,Fields.InvalidMessage_consumerupdatedate(1),Fields.InvalidMessage_consumerupdatedate(2),Fields.InvalidMessage_consumerupdatedate(3),Fields.InvalidMessage_consumerupdatedate(4)
          ,Fields.InvalidMessage_telephonenumber(1),Fields.InvalidMessage_telephonenumber(2),Fields.InvalidMessage_telephonenumber(3),Fields.InvalidMessage_telephonenumber(4)
          ,Fields.InvalidMessage_citedid(1),Fields.InvalidMessage_citedid(2),Fields.InvalidMessage_citedid(3),Fields.InvalidMessage_citedid(4)
          ,Fields.InvalidMessage_fileid(1),Fields.InvalidMessage_fileid(2),Fields.InvalidMessage_fileid(3),Fields.InvalidMessage_fileid(4)
          ,Fields.InvalidMessage_publication(1),Fields.InvalidMessage_publication(2),Fields.InvalidMessage_publication(3),Fields.InvalidMessage_publication(4)
          ,Fields.InvalidMessage_currentaddress_address1(1),Fields.InvalidMessage_currentaddress_address1(2),Fields.InvalidMessage_currentaddress_address1(3),Fields.InvalidMessage_currentaddress_address1(4)
          ,Fields.InvalidMessage_currentaddress_address2(1),Fields.InvalidMessage_currentaddress_address2(2),Fields.InvalidMessage_currentaddress_address2(3),Fields.InvalidMessage_currentaddress_address2(4)
          ,Fields.InvalidMessage_currentaddress_city(1),Fields.InvalidMessage_currentaddress_city(2),Fields.InvalidMessage_currentaddress_city(3),Fields.InvalidMessage_currentaddress_city(4)
          ,Fields.InvalidMessage_currentaddress_state(1),Fields.InvalidMessage_currentaddress_state(2),Fields.InvalidMessage_currentaddress_state(3),Fields.InvalidMessage_currentaddress_state(4)
          ,Fields.InvalidMessage_currentaddress_zipcode(1),Fields.InvalidMessage_currentaddress_zipcode(2),Fields.InvalidMessage_currentaddress_zipcode(3),Fields.InvalidMessage_currentaddress_zipcode(4)
          ,Fields.InvalidMessage_currentaddress_updateddate(1),Fields.InvalidMessage_currentaddress_updateddate(2),Fields.InvalidMessage_currentaddress_updateddate(3),Fields.InvalidMessage_currentaddress_updateddate(4)
          ,Fields.InvalidMessage_housenumber(1),Fields.InvalidMessage_housenumber(2),Fields.InvalidMessage_housenumber(3)
          ,Fields.InvalidMessage_streettype(1),Fields.InvalidMessage_streettype(2),Fields.InvalidMessage_streettype(3),Fields.InvalidMessage_streettype(4)
          ,Fields.InvalidMessage_streetdirection(1),Fields.InvalidMessage_streetdirection(2),Fields.InvalidMessage_streetdirection(3),Fields.InvalidMessage_streetdirection(4)
          ,Fields.InvalidMessage_streetname(1),Fields.InvalidMessage_streetname(2),Fields.InvalidMessage_streetname(3),Fields.InvalidMessage_streetname(4)
          ,Fields.InvalidMessage_apartmentnumber(1),Fields.InvalidMessage_apartmentnumber(2),Fields.InvalidMessage_apartmentnumber(3)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2),Fields.InvalidMessage_city(3),Fields.InvalidMessage_city(4)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2),Fields.InvalidMessage_state(3),Fields.InvalidMessage_state(4)
          ,Fields.InvalidMessage_zipcode(1),Fields.InvalidMessage_zipcode(2),Fields.InvalidMessage_zipcode(3),Fields.InvalidMessage_zipcode(4)
          ,Fields.InvalidMessage_zip4u(1),Fields.InvalidMessage_zip4u(2),Fields.InvalidMessage_zip4u(3),Fields.InvalidMessage_zip4u(4)
          ,Fields.InvalidMessage_previousaddress_address1(1),Fields.InvalidMessage_previousaddress_address1(2),Fields.InvalidMessage_previousaddress_address1(3),Fields.InvalidMessage_previousaddress_address1(4)
          ,Fields.InvalidMessage_previousaddress_address2(1),Fields.InvalidMessage_previousaddress_address2(2),Fields.InvalidMessage_previousaddress_address2(3),Fields.InvalidMessage_previousaddress_address2(4)
          ,Fields.InvalidMessage_previousaddress_city(1),Fields.InvalidMessage_previousaddress_city(2),Fields.InvalidMessage_previousaddress_city(3),Fields.InvalidMessage_previousaddress_city(4)
          ,Fields.InvalidMessage_previousaddress_state(1),Fields.InvalidMessage_previousaddress_state(2),Fields.InvalidMessage_previousaddress_state(3),Fields.InvalidMessage_previousaddress_state(4)
          ,Fields.InvalidMessage_previousaddress_zipcode(1),Fields.InvalidMessage_previousaddress_zipcode(2),Fields.InvalidMessage_previousaddress_zipcode(3),Fields.InvalidMessage_previousaddress_zipcode(4)
          ,Fields.InvalidMessage_previousaddress_updateddate(1),Fields.InvalidMessage_previousaddress_updateddate(2),Fields.InvalidMessage_previousaddress_updateddate(3),Fields.InvalidMessage_previousaddress_updateddate(4)
          ,Fields.InvalidMessage_formername_firstname(1),Fields.InvalidMessage_formername_firstname(2),Fields.InvalidMessage_formername_firstname(3),Fields.InvalidMessage_formername_firstname(4)
          ,Fields.InvalidMessage_formername_middlename(1),Fields.InvalidMessage_formername_middlename(2),Fields.InvalidMessage_formername_middlename(3),Fields.InvalidMessage_formername_middlename(4)
          ,Fields.InvalidMessage_formername_middleinitial(1),Fields.InvalidMessage_formername_middleinitial(2),Fields.InvalidMessage_formername_middleinitial(3),Fields.InvalidMessage_formername_middleinitial(4)
          ,Fields.InvalidMessage_formername_lastname(1),Fields.InvalidMessage_formername_lastname(2),Fields.InvalidMessage_formername_lastname(3),Fields.InvalidMessage_formername_lastname(4)
          ,Fields.InvalidMessage_formername_suffix(1),Fields.InvalidMessage_formername_suffix(2),Fields.InvalidMessage_formername_suffix(3),Fields.InvalidMessage_formername_suffix(4)
          ,Fields.InvalidMessage_aliasname_firstname(1),Fields.InvalidMessage_aliasname_firstname(2),Fields.InvalidMessage_aliasname_firstname(3),Fields.InvalidMessage_aliasname_firstname(4)
          ,Fields.InvalidMessage_aliasname_middlename(1),Fields.InvalidMessage_aliasname_middlename(2),Fields.InvalidMessage_aliasname_middlename(3),Fields.InvalidMessage_aliasname_middlename(4)
          ,Fields.InvalidMessage_aliasname_middleinitial(1),Fields.InvalidMessage_aliasname_middleinitial(2),Fields.InvalidMessage_aliasname_middleinitial(3),Fields.InvalidMessage_aliasname_middleinitial(4)
          ,Fields.InvalidMessage_aliasname_lastname(1),Fields.InvalidMessage_aliasname_lastname(2),Fields.InvalidMessage_aliasname_lastname(3),Fields.InvalidMessage_aliasname_lastname(4)
          ,Fields.InvalidMessage_aliasname_suffix(1),Fields.InvalidMessage_aliasname_suffix(2),Fields.InvalidMessage_aliasname_suffix(3),Fields.InvalidMessage_aliasname_suffix(4)
          ,Fields.InvalidMessage_additionalname_firstname(1),Fields.InvalidMessage_additionalname_firstname(2),Fields.InvalidMessage_additionalname_firstname(3),Fields.InvalidMessage_additionalname_firstname(4)
          ,Fields.InvalidMessage_additionalname_middlename(1),Fields.InvalidMessage_additionalname_middlename(2),Fields.InvalidMessage_additionalname_middlename(3),Fields.InvalidMessage_additionalname_middlename(4)
          ,Fields.InvalidMessage_additionalname_middleinitial(1),Fields.InvalidMessage_additionalname_middleinitial(2),Fields.InvalidMessage_additionalname_middleinitial(3),Fields.InvalidMessage_additionalname_middleinitial(4)
          ,Fields.InvalidMessage_additionalname_lastname(1),Fields.InvalidMessage_additionalname_lastname(2),Fields.InvalidMessage_additionalname_lastname(3),Fields.InvalidMessage_additionalname_lastname(4)
          ,Fields.InvalidMessage_additionalname_suffix(1),Fields.InvalidMessage_additionalname_suffix(2),Fields.InvalidMessage_additionalname_suffix(3),Fields.InvalidMessage_additionalname_suffix(4)
          ,Fields.InvalidMessage_aka1(1),Fields.InvalidMessage_aka1(2),Fields.InvalidMessage_aka1(3),Fields.InvalidMessage_aka1(4)
          ,Fields.InvalidMessage_aka2(1),Fields.InvalidMessage_aka2(2),Fields.InvalidMessage_aka2(3),Fields.InvalidMessage_aka2(4)
          ,Fields.InvalidMessage_aka3(1),Fields.InvalidMessage_aka3(2),Fields.InvalidMessage_aka3(3),Fields.InvalidMessage_aka3(4)
          ,Fields.InvalidMessage_recordtype(1),Fields.InvalidMessage_recordtype(2),Fields.InvalidMessage_recordtype(3),Fields.InvalidMessage_recordtype(4)
          ,Fields.InvalidMessage_addressstandardization(1),Fields.InvalidMessage_addressstandardization(2),Fields.InvalidMessage_addressstandardization(3),Fields.InvalidMessage_addressstandardization(4)
          ,Fields.InvalidMessage_filesincedate(1),Fields.InvalidMessage_filesincedate(2),Fields.InvalidMessage_filesincedate(3),Fields.InvalidMessage_filesincedate(4)
          ,Fields.InvalidMessage_compilationdate(1),Fields.InvalidMessage_compilationdate(2),Fields.InvalidMessage_compilationdate(3),Fields.InvalidMessage_compilationdate(4)
          ,Fields.InvalidMessage_birthdateind(1),Fields.InvalidMessage_birthdateind(2),Fields.InvalidMessage_birthdateind(3),Fields.InvalidMessage_birthdateind(4)
          ,Fields.InvalidMessage_orig_deceasedindicator(1),Fields.InvalidMessage_orig_deceasedindicator(2),Fields.InvalidMessage_orig_deceasedindicator(3),Fields.InvalidMessage_orig_deceasedindicator(4)
          ,Fields.InvalidMessage_deceaseddate(1),Fields.InvalidMessage_deceaseddate(2),Fields.InvalidMessage_deceaseddate(3),Fields.InvalidMessage_deceaseddate(4)
          ,Fields.InvalidMessage_addressseq(1),Fields.InvalidMessage_addressseq(2),Fields.InvalidMessage_addressseq(3),Fields.InvalidMessage_addressseq(4)
          ,Fields.InvalidMessage_normaddress_address1(1),Fields.InvalidMessage_normaddress_address1(2),Fields.InvalidMessage_normaddress_address1(3),Fields.InvalidMessage_normaddress_address1(4)
          ,Fields.InvalidMessage_normaddress_address2(1),Fields.InvalidMessage_normaddress_address2(2),Fields.InvalidMessage_normaddress_address2(3),Fields.InvalidMessage_normaddress_address2(4)
          ,Fields.InvalidMessage_normaddress_city(1),Fields.InvalidMessage_normaddress_city(2),Fields.InvalidMessage_normaddress_city(3),Fields.InvalidMessage_normaddress_city(4)
          ,Fields.InvalidMessage_normaddress_state(1),Fields.InvalidMessage_normaddress_state(2),Fields.InvalidMessage_normaddress_state(3),Fields.InvalidMessage_normaddress_state(4)
          ,Fields.InvalidMessage_normaddress_zipcode(1),Fields.InvalidMessage_normaddress_zipcode(2),Fields.InvalidMessage_normaddress_zipcode(3),Fields.InvalidMessage_normaddress_zipcode(4)
          ,Fields.InvalidMessage_normaddress_updateddate(1),Fields.InvalidMessage_normaddress_updateddate(2),Fields.InvalidMessage_normaddress_updateddate(3),Fields.InvalidMessage_normaddress_updateddate(4)
          ,Fields.InvalidMessage_name(1),Fields.InvalidMessage_name(2),Fields.InvalidMessage_name(3),Fields.InvalidMessage_name(4)
          ,Fields.InvalidMessage_nametype(1),Fields.InvalidMessage_nametype(2),Fields.InvalidMessage_nametype(3),Fields.InvalidMessage_nametype(4)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3),Fields.InvalidMessage_title(4)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3),Fields.InvalidMessage_fname(4)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3),Fields.InvalidMessage_mname(4)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3),Fields.InvalidMessage_lname(4)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3),Fields.InvalidMessage_name_suffix(4)
          ,Fields.InvalidMessage_name_score(1),Fields.InvalidMessage_name_score(2),Fields.InvalidMessage_name_score(3),Fields.InvalidMessage_name_score(4)
          ,Fields.InvalidMessage_prim_range(1),Fields.InvalidMessage_prim_range(2),Fields.InvalidMessage_prim_range(3),Fields.InvalidMessage_prim_range(4)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2),Fields.InvalidMessage_predir(3),Fields.InvalidMessage_predir(4)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2),Fields.InvalidMessage_prim_name(3),Fields.InvalidMessage_prim_name(4)
          ,Fields.InvalidMessage_addr_suffix(1),Fields.InvalidMessage_addr_suffix(2),Fields.InvalidMessage_addr_suffix(3),Fields.InvalidMessage_addr_suffix(4)
          ,Fields.InvalidMessage_postdir(1),Fields.InvalidMessage_postdir(2),Fields.InvalidMessage_postdir(3),Fields.InvalidMessage_postdir(4)
          ,Fields.InvalidMessage_unit_desig(1),Fields.InvalidMessage_unit_desig(2),Fields.InvalidMessage_unit_desig(3),Fields.InvalidMessage_unit_desig(4)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3),Fields.InvalidMessage_sec_range(4)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2),Fields.InvalidMessage_p_city_name(3),Fields.InvalidMessage_p_city_name(4)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2),Fields.InvalidMessage_v_city_name(3),Fields.InvalidMessage_v_city_name(4)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2),Fields.InvalidMessage_st(3),Fields.InvalidMessage_st(4)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3),Fields.InvalidMessage_zip(4)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),Fields.InvalidMessage_zip4(3),Fields.InvalidMessage_zip4(4)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2),Fields.InvalidMessage_cart(3),Fields.InvalidMessage_cart(4)
          ,Fields.InvalidMessage_cr_sort_sz(1),Fields.InvalidMessage_cr_sort_sz(2),Fields.InvalidMessage_cr_sort_sz(3),Fields.InvalidMessage_cr_sort_sz(4)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2),Fields.InvalidMessage_lot(3),Fields.InvalidMessage_lot(4)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2),Fields.InvalidMessage_lot_order(3),Fields.InvalidMessage_lot_order(4)
          ,Fields.InvalidMessage_dbpc(1),Fields.InvalidMessage_dbpc(2),Fields.InvalidMessage_dbpc(3),Fields.InvalidMessage_dbpc(4)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2),Fields.InvalidMessage_chk_digit(3),Fields.InvalidMessage_chk_digit(4)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2),Fields.InvalidMessage_rec_type(3),Fields.InvalidMessage_rec_type(4)
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2),Fields.InvalidMessage_county(3),Fields.InvalidMessage_county(4)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2),Fields.InvalidMessage_geo_lat(3),Fields.InvalidMessage_geo_lat(4)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2),Fields.InvalidMessage_geo_long(3),Fields.InvalidMessage_geo_long(4)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2),Fields.InvalidMessage_msa(3),Fields.InvalidMessage_msa(4)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3),Fields.InvalidMessage_geo_blk(4)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2),Fields.InvalidMessage_geo_match(3),Fields.InvalidMessage_geo_match(4)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),Fields.InvalidMessage_err_stat(3),Fields.InvalidMessage_err_stat(4)
          ,Fields.InvalidMessage_transferdate_unformatted(1),Fields.InvalidMessage_transferdate_unformatted(2),Fields.InvalidMessage_transferdate_unformatted(3),Fields.InvalidMessage_transferdate_unformatted(4)
          ,Fields.InvalidMessage_birthdate_unformatted(1),Fields.InvalidMessage_birthdate_unformatted(2),Fields.InvalidMessage_birthdate_unformatted(3),Fields.InvalidMessage_birthdate_unformatted(4)
          ,Fields.InvalidMessage_dob_no_conflict(1),Fields.InvalidMessage_dob_no_conflict(2),Fields.InvalidMessage_dob_no_conflict(3),Fields.InvalidMessage_dob_no_conflict(4)
          ,Fields.InvalidMessage_updatedate_unformatted(1),Fields.InvalidMessage_updatedate_unformatted(2),Fields.InvalidMessage_updatedate_unformatted(3),Fields.InvalidMessage_updatedate_unformatted(4)
          ,Fields.InvalidMessage_consumerupdatedate_unformatted(1),Fields.InvalidMessage_consumerupdatedate_unformatted(2),Fields.InvalidMessage_consumerupdatedate_unformatted(3),Fields.InvalidMessage_consumerupdatedate_unformatted(4)
          ,Fields.InvalidMessage_filesincedate_unformatted(1),Fields.InvalidMessage_filesincedate_unformatted(2),Fields.InvalidMessage_filesincedate_unformatted(3),Fields.InvalidMessage_filesincedate_unformatted(4)
          ,Fields.InvalidMessage_compilationdate_unformatted(1),Fields.InvalidMessage_compilationdate_unformatted(2),Fields.InvalidMessage_compilationdate_unformatted(3),Fields.InvalidMessage_compilationdate_unformatted(4)
          ,Fields.InvalidMessage_ssn_unformatted(1),Fields.InvalidMessage_ssn_unformatted(2),Fields.InvalidMessage_ssn_unformatted(3),Fields.InvalidMessage_ssn_unformatted(4)
          ,Fields.InvalidMessage_ssn_no_conflict(1),Fields.InvalidMessage_ssn_no_conflict(2),Fields.InvalidMessage_ssn_no_conflict(3),Fields.InvalidMessage_ssn_no_conflict(4)
          ,Fields.InvalidMessage_telephone_unformatted(1),Fields.InvalidMessage_telephone_unformatted(2),Fields.InvalidMessage_telephone_unformatted(3),Fields.InvalidMessage_telephone_unformatted(4)
          ,Fields.InvalidMessage_deceasedindicator(1),Fields.InvalidMessage_deceasedindicator(2),Fields.InvalidMessage_deceasedindicator(3),Fields.InvalidMessage_deceasedindicator(4)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2),Fields.InvalidMessage_did(3),Fields.InvalidMessage_did(4)
          ,Fields.InvalidMessage_did_score_field(1),Fields.InvalidMessage_did_score_field(2),Fields.InvalidMessage_did_score_field(3),Fields.InvalidMessage_did_score_field(4)
          ,Fields.InvalidMessage_is_current(1),Fields.InvalidMessage_is_current(2),Fields.InvalidMessage_is_current(3),Fields.InvalidMessage_is_current(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.filetype_LEFTTRIM_ErrorCount,le.filetype_ALLOW_ErrorCount,le.filetype_LENGTH_ErrorCount,le.filetype_WORDS_ErrorCount
          ,le.filedate_LEFTTRIM_ErrorCount,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount,le.filedate_WORDS_ErrorCount
          ,le.vendordocumentidentifier_LEFTTRIM_ErrorCount,le.vendordocumentidentifier_ALLOW_ErrorCount,le.vendordocumentidentifier_LENGTH_ErrorCount,le.vendordocumentidentifier_WORDS_ErrorCount
          ,le.transferdate_LEFTTRIM_ErrorCount,le.transferdate_ALLOW_ErrorCount,le.transferdate_LENGTH_ErrorCount,le.transferdate_WORDS_ErrorCount
          ,le.currentname_firstname_LEFTTRIM_ErrorCount,le.currentname_firstname_ALLOW_ErrorCount,le.currentname_firstname_LENGTH_ErrorCount,le.currentname_firstname_WORDS_ErrorCount
          ,le.currentname_middlename_LEFTTRIM_ErrorCount,le.currentname_middlename_ALLOW_ErrorCount,le.currentname_middlename_LENGTH_ErrorCount,le.currentname_middlename_WORDS_ErrorCount
          ,le.currentname_middleinitial_LEFTTRIM_ErrorCount,le.currentname_middleinitial_ALLOW_ErrorCount,le.currentname_middleinitial_LENGTH_ErrorCount,le.currentname_middleinitial_WORDS_ErrorCount
          ,le.currentname_lastname_LEFTTRIM_ErrorCount,le.currentname_lastname_ALLOW_ErrorCount,le.currentname_lastname_LENGTH_ErrorCount,le.currentname_lastname_WORDS_ErrorCount
          ,le.currentname_suffix_ALLOW_ErrorCount,le.currentname_suffix_LENGTH_ErrorCount,le.currentname_suffix_WORDS_ErrorCount
          ,le.currentname_gender_LEFTTRIM_ErrorCount,le.currentname_gender_ALLOW_ErrorCount,le.currentname_gender_LENGTH_ErrorCount,le.currentname_gender_WORDS_ErrorCount
          ,le.currentname_dob_mm_LEFTTRIM_ErrorCount,le.currentname_dob_mm_ALLOW_ErrorCount,le.currentname_dob_mm_LENGTH_ErrorCount,le.currentname_dob_mm_WORDS_ErrorCount
          ,le.currentname_dob_dd_LEFTTRIM_ErrorCount,le.currentname_dob_dd_ALLOW_ErrorCount,le.currentname_dob_dd_LENGTH_ErrorCount,le.currentname_dob_dd_WORDS_ErrorCount
          ,le.currentname_dob_yyyy_LEFTTRIM_ErrorCount,le.currentname_dob_yyyy_ALLOW_ErrorCount,le.currentname_dob_yyyy_LENGTH_ErrorCount,le.currentname_dob_yyyy_WORDS_ErrorCount
          ,le.currentname_deathindicator_LEFTTRIM_ErrorCount,le.currentname_deathindicator_ALLOW_ErrorCount,le.currentname_deathindicator_LENGTH_ErrorCount,le.currentname_deathindicator_WORDS_ErrorCount
          ,le.ssnfull_LEFTTRIM_ErrorCount,le.ssnfull_ALLOW_ErrorCount,le.ssnfull_LENGTH_ErrorCount,le.ssnfull_WORDS_ErrorCount
          ,le.ssnfirst5digit_LEFTTRIM_ErrorCount,le.ssnfirst5digit_ALLOW_ErrorCount,le.ssnfirst5digit_LENGTH_ErrorCount,le.ssnfirst5digit_WORDS_ErrorCount
          ,le.ssnlast4digit_LEFTTRIM_ErrorCount,le.ssnlast4digit_ALLOW_ErrorCount,le.ssnlast4digit_LENGTH_ErrorCount,le.ssnlast4digit_WORDS_ErrorCount
          ,le.consumerupdatedate_LEFTTRIM_ErrorCount,le.consumerupdatedate_ALLOW_ErrorCount,le.consumerupdatedate_LENGTH_ErrorCount,le.consumerupdatedate_WORDS_ErrorCount
          ,le.telephonenumber_LEFTTRIM_ErrorCount,le.telephonenumber_ALLOW_ErrorCount,le.telephonenumber_LENGTH_ErrorCount,le.telephonenumber_WORDS_ErrorCount
          ,le.citedid_LEFTTRIM_ErrorCount,le.citedid_ALLOW_ErrorCount,le.citedid_LENGTH_ErrorCount,le.citedid_WORDS_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount,le.fileid_LENGTH_ErrorCount,le.fileid_WORDS_ErrorCount
          ,le.publication_LEFTTRIM_ErrorCount,le.publication_ALLOW_ErrorCount,le.publication_LENGTH_ErrorCount,le.publication_WORDS_ErrorCount
          ,le.currentaddress_address1_LEFTTRIM_ErrorCount,le.currentaddress_address1_ALLOW_ErrorCount,le.currentaddress_address1_LENGTH_ErrorCount,le.currentaddress_address1_WORDS_ErrorCount
          ,le.currentaddress_address2_LEFTTRIM_ErrorCount,le.currentaddress_address2_ALLOW_ErrorCount,le.currentaddress_address2_LENGTH_ErrorCount,le.currentaddress_address2_WORDS_ErrorCount
          ,le.currentaddress_city_LEFTTRIM_ErrorCount,le.currentaddress_city_ALLOW_ErrorCount,le.currentaddress_city_LENGTH_ErrorCount,le.currentaddress_city_WORDS_ErrorCount
          ,le.currentaddress_state_LEFTTRIM_ErrorCount,le.currentaddress_state_ALLOW_ErrorCount,le.currentaddress_state_LENGTH_ErrorCount,le.currentaddress_state_WORDS_ErrorCount
          ,le.currentaddress_zipcode_LEFTTRIM_ErrorCount,le.currentaddress_zipcode_ALLOW_ErrorCount,le.currentaddress_zipcode_LENGTH_ErrorCount,le.currentaddress_zipcode_WORDS_ErrorCount
          ,le.currentaddress_updateddate_LEFTTRIM_ErrorCount,le.currentaddress_updateddate_ALLOW_ErrorCount,le.currentaddress_updateddate_LENGTH_ErrorCount,le.currentaddress_updateddate_WORDS_ErrorCount
          ,le.housenumber_ALLOW_ErrorCount,le.housenumber_LENGTH_ErrorCount,le.housenumber_WORDS_ErrorCount
          ,le.streettype_LEFTTRIM_ErrorCount,le.streettype_ALLOW_ErrorCount,le.streettype_LENGTH_ErrorCount,le.streettype_WORDS_ErrorCount
          ,le.streetdirection_LEFTTRIM_ErrorCount,le.streetdirection_ALLOW_ErrorCount,le.streetdirection_LENGTH_ErrorCount,le.streetdirection_WORDS_ErrorCount
          ,le.streetname_LEFTTRIM_ErrorCount,le.streetname_ALLOW_ErrorCount,le.streetname_LENGTH_ErrorCount,le.streetname_WORDS_ErrorCount
          ,le.apartmentnumber_ALLOW_ErrorCount,le.apartmentnumber_LENGTH_ErrorCount,le.apartmentnumber_WORDS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount,le.city_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount,le.zipcode_WORDS_ErrorCount
          ,le.zip4u_LEFTTRIM_ErrorCount,le.zip4u_ALLOW_ErrorCount,le.zip4u_LENGTH_ErrorCount,le.zip4u_WORDS_ErrorCount
          ,le.previousaddress_address1_LEFTTRIM_ErrorCount,le.previousaddress_address1_ALLOW_ErrorCount,le.previousaddress_address1_LENGTH_ErrorCount,le.previousaddress_address1_WORDS_ErrorCount
          ,le.previousaddress_address2_LEFTTRIM_ErrorCount,le.previousaddress_address2_ALLOW_ErrorCount,le.previousaddress_address2_LENGTH_ErrorCount,le.previousaddress_address2_WORDS_ErrorCount
          ,le.previousaddress_city_LEFTTRIM_ErrorCount,le.previousaddress_city_ALLOW_ErrorCount,le.previousaddress_city_LENGTH_ErrorCount,le.previousaddress_city_WORDS_ErrorCount
          ,le.previousaddress_state_LEFTTRIM_ErrorCount,le.previousaddress_state_ALLOW_ErrorCount,le.previousaddress_state_LENGTH_ErrorCount,le.previousaddress_state_WORDS_ErrorCount
          ,le.previousaddress_zipcode_LEFTTRIM_ErrorCount,le.previousaddress_zipcode_ALLOW_ErrorCount,le.previousaddress_zipcode_LENGTH_ErrorCount,le.previousaddress_zipcode_WORDS_ErrorCount
          ,le.previousaddress_updateddate_LEFTTRIM_ErrorCount,le.previousaddress_updateddate_ALLOW_ErrorCount,le.previousaddress_updateddate_LENGTH_ErrorCount,le.previousaddress_updateddate_WORDS_ErrorCount
          ,le.formername_firstname_LEFTTRIM_ErrorCount,le.formername_firstname_ALLOW_ErrorCount,le.formername_firstname_LENGTH_ErrorCount,le.formername_firstname_WORDS_ErrorCount
          ,le.formername_middlename_LEFTTRIM_ErrorCount,le.formername_middlename_ALLOW_ErrorCount,le.formername_middlename_LENGTH_ErrorCount,le.formername_middlename_WORDS_ErrorCount
          ,le.formername_middleinitial_LEFTTRIM_ErrorCount,le.formername_middleinitial_ALLOW_ErrorCount,le.formername_middleinitial_LENGTH_ErrorCount,le.formername_middleinitial_WORDS_ErrorCount
          ,le.formername_lastname_LEFTTRIM_ErrorCount,le.formername_lastname_ALLOW_ErrorCount,le.formername_lastname_LENGTH_ErrorCount,le.formername_lastname_WORDS_ErrorCount
          ,le.formername_suffix_LEFTTRIM_ErrorCount,le.formername_suffix_ALLOW_ErrorCount,le.formername_suffix_LENGTH_ErrorCount,le.formername_suffix_WORDS_ErrorCount
          ,le.aliasname_firstname_LEFTTRIM_ErrorCount,le.aliasname_firstname_ALLOW_ErrorCount,le.aliasname_firstname_LENGTH_ErrorCount,le.aliasname_firstname_WORDS_ErrorCount
          ,le.aliasname_middlename_LEFTTRIM_ErrorCount,le.aliasname_middlename_ALLOW_ErrorCount,le.aliasname_middlename_LENGTH_ErrorCount,le.aliasname_middlename_WORDS_ErrorCount
          ,le.aliasname_middleinitial_LEFTTRIM_ErrorCount,le.aliasname_middleinitial_ALLOW_ErrorCount,le.aliasname_middleinitial_LENGTH_ErrorCount,le.aliasname_middleinitial_WORDS_ErrorCount
          ,le.aliasname_lastname_LEFTTRIM_ErrorCount,le.aliasname_lastname_ALLOW_ErrorCount,le.aliasname_lastname_LENGTH_ErrorCount,le.aliasname_lastname_WORDS_ErrorCount
          ,le.aliasname_suffix_LEFTTRIM_ErrorCount,le.aliasname_suffix_ALLOW_ErrorCount,le.aliasname_suffix_LENGTH_ErrorCount,le.aliasname_suffix_WORDS_ErrorCount
          ,le.additionalname_firstname_LEFTTRIM_ErrorCount,le.additionalname_firstname_ALLOW_ErrorCount,le.additionalname_firstname_LENGTH_ErrorCount,le.additionalname_firstname_WORDS_ErrorCount
          ,le.additionalname_middlename_LEFTTRIM_ErrorCount,le.additionalname_middlename_ALLOW_ErrorCount,le.additionalname_middlename_LENGTH_ErrorCount,le.additionalname_middlename_WORDS_ErrorCount
          ,le.additionalname_middleinitial_LEFTTRIM_ErrorCount,le.additionalname_middleinitial_ALLOW_ErrorCount,le.additionalname_middleinitial_LENGTH_ErrorCount,le.additionalname_middleinitial_WORDS_ErrorCount
          ,le.additionalname_lastname_LEFTTRIM_ErrorCount,le.additionalname_lastname_ALLOW_ErrorCount,le.additionalname_lastname_LENGTH_ErrorCount,le.additionalname_lastname_WORDS_ErrorCount
          ,le.additionalname_suffix_LEFTTRIM_ErrorCount,le.additionalname_suffix_ALLOW_ErrorCount,le.additionalname_suffix_LENGTH_ErrorCount,le.additionalname_suffix_WORDS_ErrorCount
          ,le.aka1_LEFTTRIM_ErrorCount,le.aka1_ALLOW_ErrorCount,le.aka1_LENGTH_ErrorCount,le.aka1_WORDS_ErrorCount
          ,le.aka2_LEFTTRIM_ErrorCount,le.aka2_ALLOW_ErrorCount,le.aka2_LENGTH_ErrorCount,le.aka2_WORDS_ErrorCount
          ,le.aka3_LEFTTRIM_ErrorCount,le.aka3_ALLOW_ErrorCount,le.aka3_LENGTH_ErrorCount,le.aka3_WORDS_ErrorCount
          ,le.recordtype_LEFTTRIM_ErrorCount,le.recordtype_ALLOW_ErrorCount,le.recordtype_LENGTH_ErrorCount,le.recordtype_WORDS_ErrorCount
          ,le.addressstandardization_LEFTTRIM_ErrorCount,le.addressstandardization_ALLOW_ErrorCount,le.addressstandardization_LENGTH_ErrorCount,le.addressstandardization_WORDS_ErrorCount
          ,le.filesincedate_LEFTTRIM_ErrorCount,le.filesincedate_ALLOW_ErrorCount,le.filesincedate_LENGTH_ErrorCount,le.filesincedate_WORDS_ErrorCount
          ,le.compilationdate_LEFTTRIM_ErrorCount,le.compilationdate_ALLOW_ErrorCount,le.compilationdate_LENGTH_ErrorCount,le.compilationdate_WORDS_ErrorCount
          ,le.birthdateind_LEFTTRIM_ErrorCount,le.birthdateind_ALLOW_ErrorCount,le.birthdateind_LENGTH_ErrorCount,le.birthdateind_WORDS_ErrorCount
          ,le.orig_deceasedindicator_LEFTTRIM_ErrorCount,le.orig_deceasedindicator_ALLOW_ErrorCount,le.orig_deceasedindicator_LENGTH_ErrorCount,le.orig_deceasedindicator_WORDS_ErrorCount
          ,le.deceaseddate_LEFTTRIM_ErrorCount,le.deceaseddate_ALLOW_ErrorCount,le.deceaseddate_LENGTH_ErrorCount,le.deceaseddate_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTH_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.normaddress_address1_LEFTTRIM_ErrorCount,le.normaddress_address1_ALLOW_ErrorCount,le.normaddress_address1_LENGTH_ErrorCount,le.normaddress_address1_WORDS_ErrorCount
          ,le.normaddress_address2_LEFTTRIM_ErrorCount,le.normaddress_address2_ALLOW_ErrorCount,le.normaddress_address2_LENGTH_ErrorCount,le.normaddress_address2_WORDS_ErrorCount
          ,le.normaddress_city_LEFTTRIM_ErrorCount,le.normaddress_city_ALLOW_ErrorCount,le.normaddress_city_LENGTH_ErrorCount,le.normaddress_city_WORDS_ErrorCount
          ,le.normaddress_state_LEFTTRIM_ErrorCount,le.normaddress_state_ALLOW_ErrorCount,le.normaddress_state_LENGTH_ErrorCount,le.normaddress_state_WORDS_ErrorCount
          ,le.normaddress_zipcode_LEFTTRIM_ErrorCount,le.normaddress_zipcode_ALLOW_ErrorCount,le.normaddress_zipcode_LENGTH_ErrorCount,le.normaddress_zipcode_WORDS_ErrorCount
          ,le.normaddress_updateddate_LEFTTRIM_ErrorCount,le.normaddress_updateddate_ALLOW_ErrorCount,le.normaddress_updateddate_LENGTH_ErrorCount,le.normaddress_updateddate_WORDS_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_LENGTH_ErrorCount,le.name_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTH_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.transferdate_unformatted_LEFTTRIM_ErrorCount,le.transferdate_unformatted_ALLOW_ErrorCount,le.transferdate_unformatted_LENGTH_ErrorCount,le.transferdate_unformatted_WORDS_ErrorCount
          ,le.birthdate_unformatted_LEFTTRIM_ErrorCount,le.birthdate_unformatted_ALLOW_ErrorCount,le.birthdate_unformatted_LENGTH_ErrorCount,le.birthdate_unformatted_WORDS_ErrorCount
          ,le.dob_no_conflict_LEFTTRIM_ErrorCount,le.dob_no_conflict_ALLOW_ErrorCount,le.dob_no_conflict_LENGTH_ErrorCount,le.dob_no_conflict_WORDS_ErrorCount
          ,le.updatedate_unformatted_LEFTTRIM_ErrorCount,le.updatedate_unformatted_ALLOW_ErrorCount,le.updatedate_unformatted_LENGTH_ErrorCount,le.updatedate_unformatted_WORDS_ErrorCount
          ,le.consumerupdatedate_unformatted_LEFTTRIM_ErrorCount,le.consumerupdatedate_unformatted_ALLOW_ErrorCount,le.consumerupdatedate_unformatted_LENGTH_ErrorCount,le.consumerupdatedate_unformatted_WORDS_ErrorCount
          ,le.filesincedate_unformatted_LEFTTRIM_ErrorCount,le.filesincedate_unformatted_ALLOW_ErrorCount,le.filesincedate_unformatted_LENGTH_ErrorCount,le.filesincedate_unformatted_WORDS_ErrorCount
          ,le.compilationdate_unformatted_LEFTTRIM_ErrorCount,le.compilationdate_unformatted_ALLOW_ErrorCount,le.compilationdate_unformatted_LENGTH_ErrorCount,le.compilationdate_unformatted_WORDS_ErrorCount
          ,le.ssn_unformatted_LEFTTRIM_ErrorCount,le.ssn_unformatted_ALLOW_ErrorCount,le.ssn_unformatted_LENGTH_ErrorCount,le.ssn_unformatted_WORDS_ErrorCount
          ,le.ssn_no_conflict_LEFTTRIM_ErrorCount,le.ssn_no_conflict_ALLOW_ErrorCount,le.ssn_no_conflict_LENGTH_ErrorCount,le.ssn_no_conflict_WORDS_ErrorCount
          ,le.telephone_unformatted_LEFTTRIM_ErrorCount,le.telephone_unformatted_ALLOW_ErrorCount,le.telephone_unformatted_LENGTH_ErrorCount,le.telephone_unformatted_WORDS_ErrorCount
          ,le.deceasedindicator_LEFTTRIM_ErrorCount,le.deceasedindicator_ALLOW_ErrorCount,le.deceasedindicator_LENGTH_ErrorCount,le.deceasedindicator_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTH_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.is_current_LEFTTRIM_ErrorCount,le.is_current_ALLOW_ErrorCount,le.is_current_LENGTH_ErrorCount,le.is_current_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.filetype_LEFTTRIM_ErrorCount,le.filetype_ALLOW_ErrorCount,le.filetype_LENGTH_ErrorCount,le.filetype_WORDS_ErrorCount
          ,le.filedate_LEFTTRIM_ErrorCount,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount,le.filedate_WORDS_ErrorCount
          ,le.vendordocumentidentifier_LEFTTRIM_ErrorCount,le.vendordocumentidentifier_ALLOW_ErrorCount,le.vendordocumentidentifier_LENGTH_ErrorCount,le.vendordocumentidentifier_WORDS_ErrorCount
          ,le.transferdate_LEFTTRIM_ErrorCount,le.transferdate_ALLOW_ErrorCount,le.transferdate_LENGTH_ErrorCount,le.transferdate_WORDS_ErrorCount
          ,le.currentname_firstname_LEFTTRIM_ErrorCount,le.currentname_firstname_ALLOW_ErrorCount,le.currentname_firstname_LENGTH_ErrorCount,le.currentname_firstname_WORDS_ErrorCount
          ,le.currentname_middlename_LEFTTRIM_ErrorCount,le.currentname_middlename_ALLOW_ErrorCount,le.currentname_middlename_LENGTH_ErrorCount,le.currentname_middlename_WORDS_ErrorCount
          ,le.currentname_middleinitial_LEFTTRIM_ErrorCount,le.currentname_middleinitial_ALLOW_ErrorCount,le.currentname_middleinitial_LENGTH_ErrorCount,le.currentname_middleinitial_WORDS_ErrorCount
          ,le.currentname_lastname_LEFTTRIM_ErrorCount,le.currentname_lastname_ALLOW_ErrorCount,le.currentname_lastname_LENGTH_ErrorCount,le.currentname_lastname_WORDS_ErrorCount
          ,le.currentname_suffix_ALLOW_ErrorCount,le.currentname_suffix_LENGTH_ErrorCount,le.currentname_suffix_WORDS_ErrorCount
          ,le.currentname_gender_LEFTTRIM_ErrorCount,le.currentname_gender_ALLOW_ErrorCount,le.currentname_gender_LENGTH_ErrorCount,le.currentname_gender_WORDS_ErrorCount
          ,le.currentname_dob_mm_LEFTTRIM_ErrorCount,le.currentname_dob_mm_ALLOW_ErrorCount,le.currentname_dob_mm_LENGTH_ErrorCount,le.currentname_dob_mm_WORDS_ErrorCount
          ,le.currentname_dob_dd_LEFTTRIM_ErrorCount,le.currentname_dob_dd_ALLOW_ErrorCount,le.currentname_dob_dd_LENGTH_ErrorCount,le.currentname_dob_dd_WORDS_ErrorCount
          ,le.currentname_dob_yyyy_LEFTTRIM_ErrorCount,le.currentname_dob_yyyy_ALLOW_ErrorCount,le.currentname_dob_yyyy_LENGTH_ErrorCount,le.currentname_dob_yyyy_WORDS_ErrorCount
          ,le.currentname_deathindicator_LEFTTRIM_ErrorCount,le.currentname_deathindicator_ALLOW_ErrorCount,le.currentname_deathindicator_LENGTH_ErrorCount,le.currentname_deathindicator_WORDS_ErrorCount
          ,le.ssnfull_LEFTTRIM_ErrorCount,le.ssnfull_ALLOW_ErrorCount,le.ssnfull_LENGTH_ErrorCount,le.ssnfull_WORDS_ErrorCount
          ,le.ssnfirst5digit_LEFTTRIM_ErrorCount,le.ssnfirst5digit_ALLOW_ErrorCount,le.ssnfirst5digit_LENGTH_ErrorCount,le.ssnfirst5digit_WORDS_ErrorCount
          ,le.ssnlast4digit_LEFTTRIM_ErrorCount,le.ssnlast4digit_ALLOW_ErrorCount,le.ssnlast4digit_LENGTH_ErrorCount,le.ssnlast4digit_WORDS_ErrorCount
          ,le.consumerupdatedate_LEFTTRIM_ErrorCount,le.consumerupdatedate_ALLOW_ErrorCount,le.consumerupdatedate_LENGTH_ErrorCount,le.consumerupdatedate_WORDS_ErrorCount
          ,le.telephonenumber_LEFTTRIM_ErrorCount,le.telephonenumber_ALLOW_ErrorCount,le.telephonenumber_LENGTH_ErrorCount,le.telephonenumber_WORDS_ErrorCount
          ,le.citedid_LEFTTRIM_ErrorCount,le.citedid_ALLOW_ErrorCount,le.citedid_LENGTH_ErrorCount,le.citedid_WORDS_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount,le.fileid_LENGTH_ErrorCount,le.fileid_WORDS_ErrorCount
          ,le.publication_LEFTTRIM_ErrorCount,le.publication_ALLOW_ErrorCount,le.publication_LENGTH_ErrorCount,le.publication_WORDS_ErrorCount
          ,le.currentaddress_address1_LEFTTRIM_ErrorCount,le.currentaddress_address1_ALLOW_ErrorCount,le.currentaddress_address1_LENGTH_ErrorCount,le.currentaddress_address1_WORDS_ErrorCount
          ,le.currentaddress_address2_LEFTTRIM_ErrorCount,le.currentaddress_address2_ALLOW_ErrorCount,le.currentaddress_address2_LENGTH_ErrorCount,le.currentaddress_address2_WORDS_ErrorCount
          ,le.currentaddress_city_LEFTTRIM_ErrorCount,le.currentaddress_city_ALLOW_ErrorCount,le.currentaddress_city_LENGTH_ErrorCount,le.currentaddress_city_WORDS_ErrorCount
          ,le.currentaddress_state_LEFTTRIM_ErrorCount,le.currentaddress_state_ALLOW_ErrorCount,le.currentaddress_state_LENGTH_ErrorCount,le.currentaddress_state_WORDS_ErrorCount
          ,le.currentaddress_zipcode_LEFTTRIM_ErrorCount,le.currentaddress_zipcode_ALLOW_ErrorCount,le.currentaddress_zipcode_LENGTH_ErrorCount,le.currentaddress_zipcode_WORDS_ErrorCount
          ,le.currentaddress_updateddate_LEFTTRIM_ErrorCount,le.currentaddress_updateddate_ALLOW_ErrorCount,le.currentaddress_updateddate_LENGTH_ErrorCount,le.currentaddress_updateddate_WORDS_ErrorCount
          ,le.housenumber_ALLOW_ErrorCount,le.housenumber_LENGTH_ErrorCount,le.housenumber_WORDS_ErrorCount
          ,le.streettype_LEFTTRIM_ErrorCount,le.streettype_ALLOW_ErrorCount,le.streettype_LENGTH_ErrorCount,le.streettype_WORDS_ErrorCount
          ,le.streetdirection_LEFTTRIM_ErrorCount,le.streetdirection_ALLOW_ErrorCount,le.streetdirection_LENGTH_ErrorCount,le.streetdirection_WORDS_ErrorCount
          ,le.streetname_LEFTTRIM_ErrorCount,le.streetname_ALLOW_ErrorCount,le.streetname_LENGTH_ErrorCount,le.streetname_WORDS_ErrorCount
          ,le.apartmentnumber_ALLOW_ErrorCount,le.apartmentnumber_LENGTH_ErrorCount,le.apartmentnumber_WORDS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount,le.city_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount,le.zipcode_WORDS_ErrorCount
          ,le.zip4u_LEFTTRIM_ErrorCount,le.zip4u_ALLOW_ErrorCount,le.zip4u_LENGTH_ErrorCount,le.zip4u_WORDS_ErrorCount
          ,le.previousaddress_address1_LEFTTRIM_ErrorCount,le.previousaddress_address1_ALLOW_ErrorCount,le.previousaddress_address1_LENGTH_ErrorCount,le.previousaddress_address1_WORDS_ErrorCount
          ,le.previousaddress_address2_LEFTTRIM_ErrorCount,le.previousaddress_address2_ALLOW_ErrorCount,le.previousaddress_address2_LENGTH_ErrorCount,le.previousaddress_address2_WORDS_ErrorCount
          ,le.previousaddress_city_LEFTTRIM_ErrorCount,le.previousaddress_city_ALLOW_ErrorCount,le.previousaddress_city_LENGTH_ErrorCount,le.previousaddress_city_WORDS_ErrorCount
          ,le.previousaddress_state_LEFTTRIM_ErrorCount,le.previousaddress_state_ALLOW_ErrorCount,le.previousaddress_state_LENGTH_ErrorCount,le.previousaddress_state_WORDS_ErrorCount
          ,le.previousaddress_zipcode_LEFTTRIM_ErrorCount,le.previousaddress_zipcode_ALLOW_ErrorCount,le.previousaddress_zipcode_LENGTH_ErrorCount,le.previousaddress_zipcode_WORDS_ErrorCount
          ,le.previousaddress_updateddate_LEFTTRIM_ErrorCount,le.previousaddress_updateddate_ALLOW_ErrorCount,le.previousaddress_updateddate_LENGTH_ErrorCount,le.previousaddress_updateddate_WORDS_ErrorCount
          ,le.formername_firstname_LEFTTRIM_ErrorCount,le.formername_firstname_ALLOW_ErrorCount,le.formername_firstname_LENGTH_ErrorCount,le.formername_firstname_WORDS_ErrorCount
          ,le.formername_middlename_LEFTTRIM_ErrorCount,le.formername_middlename_ALLOW_ErrorCount,le.formername_middlename_LENGTH_ErrorCount,le.formername_middlename_WORDS_ErrorCount
          ,le.formername_middleinitial_LEFTTRIM_ErrorCount,le.formername_middleinitial_ALLOW_ErrorCount,le.formername_middleinitial_LENGTH_ErrorCount,le.formername_middleinitial_WORDS_ErrorCount
          ,le.formername_lastname_LEFTTRIM_ErrorCount,le.formername_lastname_ALLOW_ErrorCount,le.formername_lastname_LENGTH_ErrorCount,le.formername_lastname_WORDS_ErrorCount
          ,le.formername_suffix_LEFTTRIM_ErrorCount,le.formername_suffix_ALLOW_ErrorCount,le.formername_suffix_LENGTH_ErrorCount,le.formername_suffix_WORDS_ErrorCount
          ,le.aliasname_firstname_LEFTTRIM_ErrorCount,le.aliasname_firstname_ALLOW_ErrorCount,le.aliasname_firstname_LENGTH_ErrorCount,le.aliasname_firstname_WORDS_ErrorCount
          ,le.aliasname_middlename_LEFTTRIM_ErrorCount,le.aliasname_middlename_ALLOW_ErrorCount,le.aliasname_middlename_LENGTH_ErrorCount,le.aliasname_middlename_WORDS_ErrorCount
          ,le.aliasname_middleinitial_LEFTTRIM_ErrorCount,le.aliasname_middleinitial_ALLOW_ErrorCount,le.aliasname_middleinitial_LENGTH_ErrorCount,le.aliasname_middleinitial_WORDS_ErrorCount
          ,le.aliasname_lastname_LEFTTRIM_ErrorCount,le.aliasname_lastname_ALLOW_ErrorCount,le.aliasname_lastname_LENGTH_ErrorCount,le.aliasname_lastname_WORDS_ErrorCount
          ,le.aliasname_suffix_LEFTTRIM_ErrorCount,le.aliasname_suffix_ALLOW_ErrorCount,le.aliasname_suffix_LENGTH_ErrorCount,le.aliasname_suffix_WORDS_ErrorCount
          ,le.additionalname_firstname_LEFTTRIM_ErrorCount,le.additionalname_firstname_ALLOW_ErrorCount,le.additionalname_firstname_LENGTH_ErrorCount,le.additionalname_firstname_WORDS_ErrorCount
          ,le.additionalname_middlename_LEFTTRIM_ErrorCount,le.additionalname_middlename_ALLOW_ErrorCount,le.additionalname_middlename_LENGTH_ErrorCount,le.additionalname_middlename_WORDS_ErrorCount
          ,le.additionalname_middleinitial_LEFTTRIM_ErrorCount,le.additionalname_middleinitial_ALLOW_ErrorCount,le.additionalname_middleinitial_LENGTH_ErrorCount,le.additionalname_middleinitial_WORDS_ErrorCount
          ,le.additionalname_lastname_LEFTTRIM_ErrorCount,le.additionalname_lastname_ALLOW_ErrorCount,le.additionalname_lastname_LENGTH_ErrorCount,le.additionalname_lastname_WORDS_ErrorCount
          ,le.additionalname_suffix_LEFTTRIM_ErrorCount,le.additionalname_suffix_ALLOW_ErrorCount,le.additionalname_suffix_LENGTH_ErrorCount,le.additionalname_suffix_WORDS_ErrorCount
          ,le.aka1_LEFTTRIM_ErrorCount,le.aka1_ALLOW_ErrorCount,le.aka1_LENGTH_ErrorCount,le.aka1_WORDS_ErrorCount
          ,le.aka2_LEFTTRIM_ErrorCount,le.aka2_ALLOW_ErrorCount,le.aka2_LENGTH_ErrorCount,le.aka2_WORDS_ErrorCount
          ,le.aka3_LEFTTRIM_ErrorCount,le.aka3_ALLOW_ErrorCount,le.aka3_LENGTH_ErrorCount,le.aka3_WORDS_ErrorCount
          ,le.recordtype_LEFTTRIM_ErrorCount,le.recordtype_ALLOW_ErrorCount,le.recordtype_LENGTH_ErrorCount,le.recordtype_WORDS_ErrorCount
          ,le.addressstandardization_LEFTTRIM_ErrorCount,le.addressstandardization_ALLOW_ErrorCount,le.addressstandardization_LENGTH_ErrorCount,le.addressstandardization_WORDS_ErrorCount
          ,le.filesincedate_LEFTTRIM_ErrorCount,le.filesincedate_ALLOW_ErrorCount,le.filesincedate_LENGTH_ErrorCount,le.filesincedate_WORDS_ErrorCount
          ,le.compilationdate_LEFTTRIM_ErrorCount,le.compilationdate_ALLOW_ErrorCount,le.compilationdate_LENGTH_ErrorCount,le.compilationdate_WORDS_ErrorCount
          ,le.birthdateind_LEFTTRIM_ErrorCount,le.birthdateind_ALLOW_ErrorCount,le.birthdateind_LENGTH_ErrorCount,le.birthdateind_WORDS_ErrorCount
          ,le.orig_deceasedindicator_LEFTTRIM_ErrorCount,le.orig_deceasedindicator_ALLOW_ErrorCount,le.orig_deceasedindicator_LENGTH_ErrorCount,le.orig_deceasedindicator_WORDS_ErrorCount
          ,le.deceaseddate_LEFTTRIM_ErrorCount,le.deceaseddate_ALLOW_ErrorCount,le.deceaseddate_LENGTH_ErrorCount,le.deceaseddate_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTH_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.normaddress_address1_LEFTTRIM_ErrorCount,le.normaddress_address1_ALLOW_ErrorCount,le.normaddress_address1_LENGTH_ErrorCount,le.normaddress_address1_WORDS_ErrorCount
          ,le.normaddress_address2_LEFTTRIM_ErrorCount,le.normaddress_address2_ALLOW_ErrorCount,le.normaddress_address2_LENGTH_ErrorCount,le.normaddress_address2_WORDS_ErrorCount
          ,le.normaddress_city_LEFTTRIM_ErrorCount,le.normaddress_city_ALLOW_ErrorCount,le.normaddress_city_LENGTH_ErrorCount,le.normaddress_city_WORDS_ErrorCount
          ,le.normaddress_state_LEFTTRIM_ErrorCount,le.normaddress_state_ALLOW_ErrorCount,le.normaddress_state_LENGTH_ErrorCount,le.normaddress_state_WORDS_ErrorCount
          ,le.normaddress_zipcode_LEFTTRIM_ErrorCount,le.normaddress_zipcode_ALLOW_ErrorCount,le.normaddress_zipcode_LENGTH_ErrorCount,le.normaddress_zipcode_WORDS_ErrorCount
          ,le.normaddress_updateddate_LEFTTRIM_ErrorCount,le.normaddress_updateddate_ALLOW_ErrorCount,le.normaddress_updateddate_LENGTH_ErrorCount,le.normaddress_updateddate_WORDS_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_LENGTH_ErrorCount,le.name_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTH_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.transferdate_unformatted_LEFTTRIM_ErrorCount,le.transferdate_unformatted_ALLOW_ErrorCount,le.transferdate_unformatted_LENGTH_ErrorCount,le.transferdate_unformatted_WORDS_ErrorCount
          ,le.birthdate_unformatted_LEFTTRIM_ErrorCount,le.birthdate_unformatted_ALLOW_ErrorCount,le.birthdate_unformatted_LENGTH_ErrorCount,le.birthdate_unformatted_WORDS_ErrorCount
          ,le.dob_no_conflict_LEFTTRIM_ErrorCount,le.dob_no_conflict_ALLOW_ErrorCount,le.dob_no_conflict_LENGTH_ErrorCount,le.dob_no_conflict_WORDS_ErrorCount
          ,le.updatedate_unformatted_LEFTTRIM_ErrorCount,le.updatedate_unformatted_ALLOW_ErrorCount,le.updatedate_unformatted_LENGTH_ErrorCount,le.updatedate_unformatted_WORDS_ErrorCount
          ,le.consumerupdatedate_unformatted_LEFTTRIM_ErrorCount,le.consumerupdatedate_unformatted_ALLOW_ErrorCount,le.consumerupdatedate_unformatted_LENGTH_ErrorCount,le.consumerupdatedate_unformatted_WORDS_ErrorCount
          ,le.filesincedate_unformatted_LEFTTRIM_ErrorCount,le.filesincedate_unformatted_ALLOW_ErrorCount,le.filesincedate_unformatted_LENGTH_ErrorCount,le.filesincedate_unformatted_WORDS_ErrorCount
          ,le.compilationdate_unformatted_LEFTTRIM_ErrorCount,le.compilationdate_unformatted_ALLOW_ErrorCount,le.compilationdate_unformatted_LENGTH_ErrorCount,le.compilationdate_unformatted_WORDS_ErrorCount
          ,le.ssn_unformatted_LEFTTRIM_ErrorCount,le.ssn_unformatted_ALLOW_ErrorCount,le.ssn_unformatted_LENGTH_ErrorCount,le.ssn_unformatted_WORDS_ErrorCount
          ,le.ssn_no_conflict_LEFTTRIM_ErrorCount,le.ssn_no_conflict_ALLOW_ErrorCount,le.ssn_no_conflict_LENGTH_ErrorCount,le.ssn_no_conflict_WORDS_ErrorCount
          ,le.telephone_unformatted_LEFTTRIM_ErrorCount,le.telephone_unformatted_ALLOW_ErrorCount,le.telephone_unformatted_LENGTH_ErrorCount,le.telephone_unformatted_WORDS_ErrorCount
          ,le.deceasedindicator_LEFTTRIM_ErrorCount,le.deceasedindicator_ALLOW_ErrorCount,le.deceasedindicator_LENGTH_ErrorCount,le.deceasedindicator_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTH_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.is_current_LEFTTRIM_ErrorCount,le.is_current_ALLOW_ErrorCount,le.is_current_LENGTH_ErrorCount,le.is_current_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,505,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
