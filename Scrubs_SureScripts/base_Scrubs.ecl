IMPORT ut,SALT31;
EXPORT base_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(base_Layout_base)
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 version_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 upin_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 textservicelevelchange_Invalid;
    UNSIGNED1 textservicelevel_Invalid;
    UNSIGNED1 suffixname_Invalid;
    UNSIGNED1 statelicensenumber_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 spi_Invalid;
    UNSIGNED1 specialtycodeprimary_Invalid;
    UNSIGNED1 specialitytype4_Invalid;
    UNSIGNED1 specialitytype3_Invalid;
    UNSIGNED1 specialitytype2_Invalid;
    UNSIGNED1 specialitytype1_Invalid;
    UNSIGNED1 socialsecurity_Invalid;
    UNSIGNED1 servicelevel_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 recordchange_Invalid;
    UNSIGNED1 priorauthorization_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prefixname_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 pponumber_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 phoneprimary_Invalid;
    UNSIGNED1 phonealt5qualifier_Invalid;
    UNSIGNED1 phonealt5_Invalid;
    UNSIGNED1 phonealt4qualifier_Invalid;
    UNSIGNED1 phonealt4_Invalid;
    UNSIGNED1 phonealt3qualifier_Invalid;
    UNSIGNED1 phonealt3_Invalid;
    UNSIGNED1 phonealt2qualifier_Invalid;
    UNSIGNED1 phonealt2_Invalid;
    UNSIGNED1 phonealt1qualifier_Invalid;
    UNSIGNED1 phonealt1_Invalid;
    UNSIGNED1 partneraccount_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 oldservicelevel_Invalid;
    UNSIGNED1 npilocation_Invalid;
    UNSIGNED1 npi_Invalid;
    UNSIGNED1 nid_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 mutuallydefined_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 medicarenumber_Invalid;
    UNSIGNED1 medicaidnumber_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lnpid_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 lastmodifieddate_Invalid;
    UNSIGNED1 instorencpdpid_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 fileid_Invalid;
    UNSIGNED1 fax_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 dentistlicensenumber_Invalid;
    UNSIGNED1 dea_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 clinicname_Invalid;
    UNSIGNED1 clean_clinic_name_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 best_dob_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 addressline2_Invalid;
    UNSIGNED1 addressline1_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 activestarttime_Invalid;
    UNSIGNED1 activeendtime_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(base_Layout_base)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
  END;
EXPORT FromNone(DATASET(base_Layout_base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.zipcode_Invalid := base_Fields.InValid_zipcode((SALT31.StrType)le.zipcode);
    SELF.zip_Invalid := base_Fields.InValid_zip((SALT31.StrType)le.zip);
    SELF.zip4_Invalid := base_Fields.InValid_zip4((SALT31.StrType)le.zip4);
    SELF.version_Invalid := base_Fields.InValid_version((SALT31.StrType)le.version);
    SELF.v_city_name_Invalid := base_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name);
    SELF.upin_Invalid := base_Fields.InValid_upin((SALT31.StrType)le.upin);
    SELF.unit_desig_Invalid := base_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig);
    SELF.title_Invalid := base_Fields.InValid_title((SALT31.StrType)le.title);
    SELF.textservicelevelchange_Invalid := base_Fields.InValid_textservicelevelchange((SALT31.StrType)le.textservicelevelchange);
    SELF.textservicelevel_Invalid := base_Fields.InValid_textservicelevel((SALT31.StrType)le.textservicelevel);
    SELF.suffixname_Invalid := base_Fields.InValid_suffixname((SALT31.StrType)le.suffixname);
    SELF.statelicensenumber_Invalid := base_Fields.InValid_statelicensenumber((SALT31.StrType)le.statelicensenumber);
    SELF.state_Invalid := base_Fields.InValid_state((SALT31.StrType)le.state);
    SELF.st_Invalid := base_Fields.InValid_st((SALT31.StrType)le.st);
    SELF.spi_Invalid := base_Fields.InValid_spi((SALT31.StrType)le.spi);
    SELF.specialtycodeprimary_Invalid := base_Fields.InValid_specialtycodeprimary((SALT31.StrType)le.specialtycodeprimary);
    SELF.specialitytype4_Invalid := base_Fields.InValid_specialitytype4((SALT31.StrType)le.specialitytype4);
    SELF.specialitytype3_Invalid := base_Fields.InValid_specialitytype3((SALT31.StrType)le.specialitytype3);
    SELF.specialitytype2_Invalid := base_Fields.InValid_specialitytype2((SALT31.StrType)le.specialitytype2);
    SELF.specialitytype1_Invalid := base_Fields.InValid_specialitytype1((SALT31.StrType)le.specialitytype1);
    SELF.socialsecurity_Invalid := base_Fields.InValid_socialsecurity((SALT31.StrType)le.socialsecurity);
    SELF.servicelevel_Invalid := base_Fields.InValid_servicelevel((SALT31.StrType)le.servicelevel);
    SELF.sec_range_Invalid := base_Fields.InValid_sec_range((SALT31.StrType)le.sec_range);
    SELF.recordchange_Invalid := base_Fields.InValid_recordchange((SALT31.StrType)le.recordchange);
    SELF.priorauthorization_Invalid := base_Fields.InValid_priorauthorization((SALT31.StrType)le.priorauthorization);
    SELF.prim_range_Invalid := base_Fields.InValid_prim_range((SALT31.StrType)le.prim_range);
    SELF.prim_name_Invalid := base_Fields.InValid_prim_name((SALT31.StrType)le.prim_name);
    SELF.prepped_addr2_Invalid := base_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2);
    SELF.prepped_addr1_Invalid := base_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1);
    SELF.prefixname_Invalid := base_Fields.InValid_prefixname((SALT31.StrType)le.prefixname);
    SELF.predir_Invalid := base_Fields.InValid_predir((SALT31.StrType)le.predir);
    SELF.pponumber_Invalid := base_Fields.InValid_pponumber((SALT31.StrType)le.pponumber);
    SELF.postdir_Invalid := base_Fields.InValid_postdir((SALT31.StrType)le.postdir);
    SELF.phoneprimary_Invalid := base_Fields.InValid_phoneprimary((SALT31.StrType)le.phoneprimary);
    SELF.phonealt5qualifier_Invalid := base_Fields.InValid_phonealt5qualifier((SALT31.StrType)le.phonealt5qualifier);
    SELF.phonealt5_Invalid := base_Fields.InValid_phonealt5((SALT31.StrType)le.phonealt5);
    SELF.phonealt4qualifier_Invalid := base_Fields.InValid_phonealt4qualifier((SALT31.StrType)le.phonealt4qualifier);
    SELF.phonealt4_Invalid := base_Fields.InValid_phonealt4((SALT31.StrType)le.phonealt4);
    SELF.phonealt3qualifier_Invalid := base_Fields.InValid_phonealt3qualifier((SALT31.StrType)le.phonealt3qualifier);
    SELF.phonealt3_Invalid := base_Fields.InValid_phonealt3((SALT31.StrType)le.phonealt3);
    SELF.phonealt2qualifier_Invalid := base_Fields.InValid_phonealt2qualifier((SALT31.StrType)le.phonealt2qualifier);
    SELF.phonealt2_Invalid := base_Fields.InValid_phonealt2((SALT31.StrType)le.phonealt2);
    SELF.phonealt1qualifier_Invalid := base_Fields.InValid_phonealt1qualifier((SALT31.StrType)le.phonealt1qualifier);
    SELF.phonealt1_Invalid := base_Fields.InValid_phonealt1((SALT31.StrType)le.phonealt1);
    SELF.partneraccount_Invalid := base_Fields.InValid_partneraccount((SALT31.StrType)le.partneraccount);
    SELF.p_city_name_Invalid := base_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name);
    SELF.oldservicelevel_Invalid := base_Fields.InValid_oldservicelevel((SALT31.StrType)le.oldservicelevel);
    SELF.npilocation_Invalid := base_Fields.InValid_npilocation((SALT31.StrType)le.npilocation);
    SELF.npi_Invalid := base_Fields.InValid_npi((SALT31.StrType)le.npi);
    SELF.nid_Invalid := base_Fields.InValid_nid((SALT31.StrType)le.nid);
    SELF.name_type_Invalid := base_Fields.InValid_name_type((SALT31.StrType)le.name_type);
    SELF.name_suffix_Invalid := base_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix);
    SELF.mutuallydefined_Invalid := base_Fields.InValid_mutuallydefined((SALT31.StrType)le.mutuallydefined);
    SELF.mname_Invalid := base_Fields.InValid_mname((SALT31.StrType)le.mname);
    SELF.middlename_Invalid := base_Fields.InValid_middlename((SALT31.StrType)le.middlename);
    SELF.medicarenumber_Invalid := base_Fields.InValid_medicarenumber((SALT31.StrType)le.medicarenumber);
    SELF.medicaidnumber_Invalid := base_Fields.InValid_medicaidnumber((SALT31.StrType)le.medicaidnumber);
    SELF.lot_Invalid := base_Fields.InValid_lot((SALT31.StrType)le.lot);
    SELF.lnpid_Invalid := base_Fields.InValid_lnpid((SALT31.StrType)le.lnpid);
    SELF.lname_Invalid := base_Fields.InValid_lname((SALT31.StrType)le.lname);
    SELF.lastname_Invalid := base_Fields.InValid_lastname((SALT31.StrType)le.lastname);
    SELF.lastmodifieddate_Invalid := base_Fields.InValid_lastmodifieddate((SALT31.StrType)le.lastmodifieddate);
    SELF.instorencpdpid_Invalid := base_Fields.InValid_instorencpdpid((SALT31.StrType)le.instorencpdpid);
    SELF.fname_Invalid := base_Fields.InValid_fname((SALT31.StrType)le.fname);
    SELF.firstname_Invalid := base_Fields.InValid_firstname((SALT31.StrType)le.firstname);
    SELF.fileid_Invalid := base_Fields.InValid_fileid((SALT31.StrType)le.fileid);
    SELF.fax_Invalid := base_Fields.InValid_fax((SALT31.StrType)le.fax);
    SELF.email_Invalid := base_Fields.InValid_email((SALT31.StrType)le.email);
    SELF.dt_vendor_last_reported_Invalid := base_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported_Invalid := base_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported);
    SELF.dt_last_seen_Invalid := base_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen);
    SELF.dt_first_seen_Invalid := base_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen);
    SELF.did_score_Invalid := base_Fields.InValid_did_score((SALT31.StrType)le.did_score);
    SELF.did_Invalid := base_Fields.InValid_did((SALT31.StrType)le.did);
    SELF.dentistlicensenumber_Invalid := base_Fields.InValid_dentistlicensenumber((SALT31.StrType)le.dentistlicensenumber);
    SELF.dea_Invalid := base_Fields.InValid_dea((SALT31.StrType)le.dea);
    SELF.cr_sort_sz_Invalid := base_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz);
    SELF.clinicname_Invalid := base_Fields.InValid_clinicname((SALT31.StrType)le.clinicname);
    SELF.clean_clinic_name_Invalid := base_Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name);
    SELF.city_Invalid := base_Fields.InValid_city((SALT31.StrType)le.city);
    SELF.cart_Invalid := base_Fields.InValid_cart((SALT31.StrType)le.cart);
    SELF.best_ssn_Invalid := base_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn);
    SELF.best_dob_Invalid := base_Fields.InValid_best_dob((SALT31.StrType)le.best_dob);
    SELF.bdid_score_Invalid := base_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score);
    SELF.bdid_Invalid := base_Fields.InValid_bdid((SALT31.StrType)le.bdid);
    SELF.addressline2_Invalid := base_Fields.InValid_addressline2((SALT31.StrType)le.addressline2);
    SELF.addressline1_Invalid := base_Fields.InValid_addressline1((SALT31.StrType)le.addressline1);
    SELF.addr_suffix_Invalid := base_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix);
    SELF.activestarttime_Invalid := base_Fields.InValid_activestarttime((SALT31.StrType)le.activestarttime);
    SELF.activeendtime_Invalid := base_Fields.InValid_activeendtime((SALT31.StrType)le.activeendtime);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.zipcode_Invalid << 0 ) + ( le.zip_Invalid << 3 ) + ( le.zip4_Invalid << 6 ) + ( le.version_Invalid << 9 ) + ( le.v_city_name_Invalid << 12 ) + ( le.upin_Invalid << 14 ) + ( le.unit_desig_Invalid << 17 ) + ( le.title_Invalid << 20 ) + ( le.textservicelevelchange_Invalid << 23 ) + ( le.textservicelevel_Invalid << 26 ) + ( le.suffixname_Invalid << 29 ) + ( le.statelicensenumber_Invalid << 32 ) + ( le.state_Invalid << 35 ) + ( le.st_Invalid << 38 ) + ( le.spi_Invalid << 41 ) + ( le.specialtycodeprimary_Invalid << 44 ) + ( le.specialitytype4_Invalid << 47 ) + ( le.specialitytype3_Invalid << 50 ) + ( le.specialitytype2_Invalid << 53 ) + ( le.specialitytype1_Invalid << 56 ) + ( le.socialsecurity_Invalid << 59 );
    SELF.ScrubsBits2 := ( le.servicelevel_Invalid << 0 ) + ( le.sec_range_Invalid << 3 ) + ( le.recordchange_Invalid << 6 ) + ( le.priorauthorization_Invalid << 9 ) + ( le.prim_range_Invalid << 12 ) + ( le.prim_name_Invalid << 14 ) + ( le.prepped_addr2_Invalid << 16 ) + ( le.prepped_addr1_Invalid << 18 ) + ( le.prefixname_Invalid << 20 ) + ( le.predir_Invalid << 23 ) + ( le.pponumber_Invalid << 26 ) + ( le.postdir_Invalid << 29 ) + ( le.phoneprimary_Invalid << 32 ) + ( le.phonealt5qualifier_Invalid << 35 ) + ( le.phonealt5_Invalid << 38 ) + ( le.phonealt4qualifier_Invalid << 41 ) + ( le.phonealt4_Invalid << 44 ) + ( le.phonealt3qualifier_Invalid << 47 ) + ( le.phonealt3_Invalid << 50 ) + ( le.phonealt2qualifier_Invalid << 53 ) + ( le.phonealt2_Invalid << 56 ) + ( le.phonealt1qualifier_Invalid << 59 );
    SELF.ScrubsBits3 := ( le.phonealt1_Invalid << 0 ) + ( le.partneraccount_Invalid << 3 ) + ( le.p_city_name_Invalid << 4 ) + ( le.oldservicelevel_Invalid << 6 ) + ( le.npilocation_Invalid << 9 ) + ( le.npi_Invalid << 12 ) + ( le.nid_Invalid << 15 ) + ( le.name_type_Invalid << 18 ) + ( le.name_suffix_Invalid << 21 ) + ( le.mutuallydefined_Invalid << 24 ) + ( le.mname_Invalid << 27 ) + ( le.middlename_Invalid << 29 ) + ( le.medicarenumber_Invalid << 31 ) + ( le.medicaidnumber_Invalid << 34 ) + ( le.lot_Invalid << 37 ) + ( le.lnpid_Invalid << 40 ) + ( le.lname_Invalid << 43 ) + ( le.lastname_Invalid << 46 ) + ( le.lastmodifieddate_Invalid << 49 ) + ( le.instorencpdpid_Invalid << 52 ) + ( le.fname_Invalid << 55 ) + ( le.firstname_Invalid << 58 ) + ( le.fileid_Invalid << 61 );
    SELF.ScrubsBits4 := ( le.fax_Invalid << 0 ) + ( le.email_Invalid << 3 ) + ( le.dt_vendor_last_reported_Invalid << 5 ) + ( le.dt_vendor_first_reported_Invalid << 8 ) + ( le.dt_last_seen_Invalid << 11 ) + ( le.dt_first_seen_Invalid << 14 ) + ( le.did_score_Invalid << 17 ) + ( le.did_Invalid << 20 ) + ( le.dentistlicensenumber_Invalid << 23 ) + ( le.dea_Invalid << 26 ) + ( le.cr_sort_sz_Invalid << 29 ) + ( le.clinicname_Invalid << 32 ) + ( le.clean_clinic_name_Invalid << 34 ) + ( le.city_Invalid << 36 ) + ( le.cart_Invalid << 38 ) + ( le.best_ssn_Invalid << 41 ) + ( le.best_dob_Invalid << 44 ) + ( le.bdid_score_Invalid << 47 ) + ( le.bdid_Invalid << 50 ) + ( le.addressline2_Invalid << 53 ) + ( le.addressline1_Invalid << 55 ) + ( le.addr_suffix_Invalid << 57 ) + ( le.activestarttime_Invalid << 60 );
    SELF.ScrubsBits5 := ( le.activeendtime_Invalid << 0 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,base_Layout_base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.version_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.upin_Invalid := (le.ScrubsBits1 >> 14) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 17) & 7;
    SELF.title_Invalid := (le.ScrubsBits1 >> 20) & 7;
    SELF.textservicelevelchange_Invalid := (le.ScrubsBits1 >> 23) & 7;
    SELF.textservicelevel_Invalid := (le.ScrubsBits1 >> 26) & 7;
    SELF.suffixname_Invalid := (le.ScrubsBits1 >> 29) & 7;
    SELF.statelicensenumber_Invalid := (le.ScrubsBits1 >> 32) & 7;
    SELF.state_Invalid := (le.ScrubsBits1 >> 35) & 7;
    SELF.st_Invalid := (le.ScrubsBits1 >> 38) & 7;
    SELF.spi_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.specialtycodeprimary_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.specialitytype4_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.specialitytype3_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.specialitytype2_Invalid := (le.ScrubsBits1 >> 53) & 7;
    SELF.specialitytype1_Invalid := (le.ScrubsBits1 >> 56) & 7;
    SELF.socialsecurity_Invalid := (le.ScrubsBits1 >> 59) & 7;
    SELF.servicelevel_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.recordchange_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.priorauthorization_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.prefixname_Invalid := (le.ScrubsBits2 >> 20) & 7;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 23) & 7;
    SELF.pponumber_Invalid := (le.ScrubsBits2 >> 26) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 29) & 7;
    SELF.phoneprimary_Invalid := (le.ScrubsBits2 >> 32) & 7;
    SELF.phonealt5qualifier_Invalid := (le.ScrubsBits2 >> 35) & 7;
    SELF.phonealt5_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.phonealt4qualifier_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.phonealt4_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.phonealt3qualifier_Invalid := (le.ScrubsBits2 >> 47) & 7;
    SELF.phonealt3_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF.phonealt2qualifier_Invalid := (le.ScrubsBits2 >> 53) & 7;
    SELF.phonealt2_Invalid := (le.ScrubsBits2 >> 56) & 7;
    SELF.phonealt1qualifier_Invalid := (le.ScrubsBits2 >> 59) & 7;
    SELF.phonealt1_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.partneraccount_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.oldservicelevel_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.npilocation_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.npi_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.nid_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.name_type_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.name_suffix_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.mutuallydefined_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.mname_Invalid := (le.ScrubsBits3 >> 27) & 3;
    SELF.middlename_Invalid := (le.ScrubsBits3 >> 29) & 3;
    SELF.medicarenumber_Invalid := (le.ScrubsBits3 >> 31) & 7;
    SELF.medicaidnumber_Invalid := (le.ScrubsBits3 >> 34) & 7;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 37) & 7;
    SELF.lnpid_Invalid := (le.ScrubsBits3 >> 40) & 7;
    SELF.lname_Invalid := (le.ScrubsBits3 >> 43) & 7;
    SELF.lastname_Invalid := (le.ScrubsBits3 >> 46) & 7;
    SELF.lastmodifieddate_Invalid := (le.ScrubsBits3 >> 49) & 7;
    SELF.instorencpdpid_Invalid := (le.ScrubsBits3 >> 52) & 7;
    SELF.fname_Invalid := (le.ScrubsBits3 >> 55) & 7;
    SELF.firstname_Invalid := (le.ScrubsBits3 >> 58) & 7;
    SELF.fileid_Invalid := (le.ScrubsBits3 >> 61) & 7;
    SELF.fax_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.email_Invalid := (le.ScrubsBits4 >> 3) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits4 >> 5) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits4 >> 8) & 7;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits4 >> 11) & 7;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits4 >> 14) & 7;
    SELF.did_score_Invalid := (le.ScrubsBits4 >> 17) & 7;
    SELF.did_Invalid := (le.ScrubsBits4 >> 20) & 7;
    SELF.dentistlicensenumber_Invalid := (le.ScrubsBits4 >> 23) & 7;
    SELF.dea_Invalid := (le.ScrubsBits4 >> 26) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits4 >> 29) & 7;
    SELF.clinicname_Invalid := (le.ScrubsBits4 >> 32) & 3;
    SELF.clean_clinic_name_Invalid := (le.ScrubsBits4 >> 34) & 3;
    SELF.city_Invalid := (le.ScrubsBits4 >> 36) & 3;
    SELF.cart_Invalid := (le.ScrubsBits4 >> 38) & 7;
    SELF.best_ssn_Invalid := (le.ScrubsBits4 >> 41) & 7;
    SELF.best_dob_Invalid := (le.ScrubsBits4 >> 44) & 7;
    SELF.bdid_score_Invalid := (le.ScrubsBits4 >> 47) & 7;
    SELF.bdid_Invalid := (le.ScrubsBits4 >> 50) & 7;
    SELF.addressline2_Invalid := (le.ScrubsBits4 >> 53) & 3;
    SELF.addressline1_Invalid := (le.ScrubsBits4 >> 55) & 3;
    SELF.addr_suffix_Invalid := (le.ScrubsBits4 >> 57) & 7;
    SELF.activestarttime_Invalid := (le.ScrubsBits4 >> 60) & 7;
    SELF.activeendtime_Invalid := (le.ScrubsBits5 >> 0) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=3);
    zipcode_WORDS_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=4);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
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
    version_LEFTTRIM_ErrorCount := COUNT(GROUP,h.version_Invalid=1);
    version_ALLOW_ErrorCount := COUNT(GROUP,h.version_Invalid=2);
    version_LENGTH_ErrorCount := COUNT(GROUP,h.version_Invalid=3);
    version_WORDS_ErrorCount := COUNT(GROUP,h.version_Invalid=4);
    version_Total_ErrorCount := COUNT(GROUP,h.version_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    upin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.upin_Invalid=1);
    upin_ALLOW_ErrorCount := COUNT(GROUP,h.upin_Invalid=2);
    upin_LENGTH_ErrorCount := COUNT(GROUP,h.upin_Invalid=3);
    upin_WORDS_ErrorCount := COUNT(GROUP,h.upin_Invalid=4);
    upin_Total_ErrorCount := COUNT(GROUP,h.upin_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=4);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=4);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    textservicelevelchange_LEFTTRIM_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=1);
    textservicelevelchange_ALLOW_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=2);
    textservicelevelchange_LENGTH_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=3);
    textservicelevelchange_WORDS_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=4);
    textservicelevelchange_Total_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid>0);
    textservicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=1);
    textservicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=2);
    textservicelevel_LENGTH_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=3);
    textservicelevel_WORDS_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=4);
    textservicelevel_Total_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid>0);
    suffixname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=1);
    suffixname_ALLOW_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=2);
    suffixname_LENGTH_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=3);
    suffixname_WORDS_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=4);
    suffixname_Total_ErrorCount := COUNT(GROUP,h.suffixname_Invalid>0);
    statelicensenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=1);
    statelicensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=2);
    statelicensenumber_LENGTH_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=3);
    statelicensenumber_WORDS_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=4);
    statelicensenumber_Total_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_WORDS_ErrorCount := COUNT(GROUP,h.state_Invalid=4);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=3);
    st_WORDS_ErrorCount := COUNT(GROUP,h.st_Invalid=4);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    spi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.spi_Invalid=1);
    spi_ALLOW_ErrorCount := COUNT(GROUP,h.spi_Invalid=2);
    spi_LENGTH_ErrorCount := COUNT(GROUP,h.spi_Invalid=3);
    spi_WORDS_ErrorCount := COUNT(GROUP,h.spi_Invalid=4);
    spi_Total_ErrorCount := COUNT(GROUP,h.spi_Invalid>0);
    specialtycodeprimary_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=1);
    specialtycodeprimary_ALLOW_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=2);
    specialtycodeprimary_LENGTH_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=3);
    specialtycodeprimary_WORDS_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=4);
    specialtycodeprimary_Total_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid>0);
    specialitytype4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=1);
    specialitytype4_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=2);
    specialitytype4_LENGTH_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=3);
    specialitytype4_WORDS_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=4);
    specialitytype4_Total_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid>0);
    specialitytype3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=1);
    specialitytype3_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=2);
    specialitytype3_LENGTH_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=3);
    specialitytype3_WORDS_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=4);
    specialitytype3_Total_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid>0);
    specialitytype2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=1);
    specialitytype2_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=2);
    specialitytype2_LENGTH_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=3);
    specialitytype2_WORDS_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=4);
    specialitytype2_Total_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid>0);
    specialitytype1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=1);
    specialitytype1_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=2);
    specialitytype1_LENGTH_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=3);
    specialitytype1_WORDS_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=4);
    specialitytype1_Total_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid>0);
    socialsecurity_LEFTTRIM_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=1);
    socialsecurity_ALLOW_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=2);
    socialsecurity_LENGTH_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=3);
    socialsecurity_WORDS_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=4);
    socialsecurity_Total_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid>0);
    servicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=1);
    servicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=2);
    servicelevel_LENGTH_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=3);
    servicelevel_WORDS_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=4);
    servicelevel_Total_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=4);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    recordchange_LEFTTRIM_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=1);
    recordchange_ALLOW_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=2);
    recordchange_LENGTH_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=3);
    recordchange_WORDS_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=4);
    recordchange_Total_ErrorCount := COUNT(GROUP,h.recordchange_Invalid>0);
    priorauthorization_LEFTTRIM_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=1);
    priorauthorization_ALLOW_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=2);
    priorauthorization_LENGTH_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=3);
    priorauthorization_WORDS_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=4);
    priorauthorization_Total_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_WORDS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prefixname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=1);
    prefixname_ALLOW_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=2);
    prefixname_LENGTH_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=3);
    prefixname_WORDS_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=4);
    prefixname_Total_ErrorCount := COUNT(GROUP,h.prefixname_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_WORDS_ErrorCount := COUNT(GROUP,h.predir_Invalid=4);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    pponumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=1);
    pponumber_ALLOW_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=2);
    pponumber_LENGTH_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=3);
    pponumber_WORDS_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=4);
    pponumber_Total_ErrorCount := COUNT(GROUP,h.pponumber_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_WORDS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=4);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    phoneprimary_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=1);
    phoneprimary_ALLOW_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=2);
    phoneprimary_LENGTH_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=3);
    phoneprimary_WORDS_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=4);
    phoneprimary_Total_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid>0);
    phonealt5qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=1);
    phonealt5qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=2);
    phonealt5qualifier_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=3);
    phonealt5qualifier_WORDS_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=4);
    phonealt5qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid>0);
    phonealt5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=1);
    phonealt5_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=2);
    phonealt5_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=3);
    phonealt5_WORDS_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=4);
    phonealt5_Total_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid>0);
    phonealt4qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=1);
    phonealt4qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=2);
    phonealt4qualifier_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=3);
    phonealt4qualifier_WORDS_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=4);
    phonealt4qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid>0);
    phonealt4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=1);
    phonealt4_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=2);
    phonealt4_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=3);
    phonealt4_WORDS_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=4);
    phonealt4_Total_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid>0);
    phonealt3qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=1);
    phonealt3qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=2);
    phonealt3qualifier_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=3);
    phonealt3qualifier_WORDS_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=4);
    phonealt3qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid>0);
    phonealt3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=1);
    phonealt3_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=2);
    phonealt3_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=3);
    phonealt3_WORDS_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=4);
    phonealt3_Total_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid>0);
    phonealt2qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=1);
    phonealt2qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=2);
    phonealt2qualifier_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=3);
    phonealt2qualifier_WORDS_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=4);
    phonealt2qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid>0);
    phonealt2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=1);
    phonealt2_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=2);
    phonealt2_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=3);
    phonealt2_WORDS_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=4);
    phonealt2_Total_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid>0);
    phonealt1qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=1);
    phonealt1qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=2);
    phonealt1qualifier_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=3);
    phonealt1qualifier_WORDS_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=4);
    phonealt1qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid>0);
    phonealt1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=1);
    phonealt1_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=2);
    phonealt1_LENGTH_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=3);
    phonealt1_WORDS_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=4);
    phonealt1_Total_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid>0);
    partneraccount_ALLOW_ErrorCount := COUNT(GROUP,h.partneraccount_Invalid=1);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    oldservicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=1);
    oldservicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=2);
    oldservicelevel_LENGTH_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=3);
    oldservicelevel_WORDS_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=4);
    oldservicelevel_Total_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid>0);
    npilocation_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=1);
    npilocation_ALLOW_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=2);
    npilocation_LENGTH_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=3);
    npilocation_WORDS_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=4);
    npilocation_Total_ErrorCount := COUNT(GROUP,h.npilocation_Invalid>0);
    npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_Invalid=1);
    npi_ALLOW_ErrorCount := COUNT(GROUP,h.npi_Invalid=2);
    npi_LENGTH_ErrorCount := COUNT(GROUP,h.npi_Invalid=3);
    npi_WORDS_ErrorCount := COUNT(GROUP,h.npi_Invalid=4);
    npi_Total_ErrorCount := COUNT(GROUP,h.npi_Invalid>0);
    nid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nid_Invalid=1);
    nid_ALLOW_ErrorCount := COUNT(GROUP,h.nid_Invalid=2);
    nid_LENGTH_ErrorCount := COUNT(GROUP,h.nid_Invalid=3);
    nid_WORDS_ErrorCount := COUNT(GROUP,h.nid_Invalid=4);
    nid_Total_ErrorCount := COUNT(GROUP,h.nid_Invalid>0);
    name_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    name_type_ALLOW_ErrorCount := COUNT(GROUP,h.name_type_Invalid=2);
    name_type_LENGTH_ErrorCount := COUNT(GROUP,h.name_type_Invalid=3);
    name_type_WORDS_ErrorCount := COUNT(GROUP,h.name_type_Invalid=4);
    name_type_Total_ErrorCount := COUNT(GROUP,h.name_type_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=4);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    mutuallydefined_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=1);
    mutuallydefined_ALLOW_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=2);
    mutuallydefined_LENGTH_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=3);
    mutuallydefined_WORDS_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=4);
    mutuallydefined_Total_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    middlename_ALLOW_ErrorCount := COUNT(GROUP,h.middlename_Invalid=2);
    middlename_WORDS_ErrorCount := COUNT(GROUP,h.middlename_Invalid=3);
    middlename_Total_ErrorCount := COUNT(GROUP,h.middlename_Invalid>0);
    medicarenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=1);
    medicarenumber_ALLOW_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=2);
    medicarenumber_LENGTH_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=3);
    medicarenumber_WORDS_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=4);
    medicarenumber_Total_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid>0);
    medicaidnumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=1);
    medicaidnumber_ALLOW_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=2);
    medicaidnumber_LENGTH_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=3);
    medicaidnumber_WORDS_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=4);
    medicaidnumber_Total_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=3);
    lot_WORDS_ErrorCount := COUNT(GROUP,h.lot_Invalid=4);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lnpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=2);
    lnpid_LENGTH_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=3);
    lnpid_WORDS_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=4);
    lnpid_Total_ErrorCount := COUNT(GROUP,h.lnpid_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=4);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_LENGTH_ErrorCount := COUNT(GROUP,h.lastname_Invalid=3);
    lastname_WORDS_ErrorCount := COUNT(GROUP,h.lastname_Invalid=4);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    lastmodifieddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=1);
    lastmodifieddate_ALLOW_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=2);
    lastmodifieddate_LENGTH_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=3);
    lastmodifieddate_WORDS_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=4);
    lastmodifieddate_Total_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid>0);
    instorencpdpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=1);
    instorencpdpid_ALLOW_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=2);
    instorencpdpid_LENGTH_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=3);
    instorencpdpid_WORDS_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=4);
    instorencpdpid_Total_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=4);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=2);
    firstname_LENGTH_ErrorCount := COUNT(GROUP,h.firstname_Invalid=3);
    firstname_WORDS_ErrorCount := COUNT(GROUP,h.firstname_Invalid=4);
    firstname_Total_ErrorCount := COUNT(GROUP,h.firstname_Invalid>0);
    fileid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fileid_Invalid=1);
    fileid_ALLOW_ErrorCount := COUNT(GROUP,h.fileid_Invalid=2);
    fileid_LENGTH_ErrorCount := COUNT(GROUP,h.fileid_Invalid=3);
    fileid_WORDS_ErrorCount := COUNT(GROUP,h.fileid_Invalid=4);
    fileid_Total_ErrorCount := COUNT(GROUP,h.fileid_Invalid>0);
    fax_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax_Invalid=1);
    fax_ALLOW_ErrorCount := COUNT(GROUP,h.fax_Invalid=2);
    fax_LENGTH_ErrorCount := COUNT(GROUP,h.fax_Invalid=3);
    fax_WORDS_ErrorCount := COUNT(GROUP,h.fax_Invalid=4);
    fax_Total_ErrorCount := COUNT(GROUP,h.fax_Invalid>0);
    email_LEFTTRIM_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=2);
    email_WORDS_ErrorCount := COUNT(GROUP,h.email_Invalid=3);
    email_Total_ErrorCount := COUNT(GROUP,h.email_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=4);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=4);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=4);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=4);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    did_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=2);
    did_score_LENGTH_ErrorCount := COUNT(GROUP,h.did_score_Invalid=3);
    did_score_WORDS_ErrorCount := COUNT(GROUP,h.did_score_Invalid=4);
    did_score_Total_ErrorCount := COUNT(GROUP,h.did_score_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    dentistlicensenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=1);
    dentistlicensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=2);
    dentistlicensenumber_LENGTH_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=3);
    dentistlicensenumber_WORDS_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=4);
    dentistlicensenumber_Total_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid>0);
    dea_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_Invalid=1);
    dea_ALLOW_ErrorCount := COUNT(GROUP,h.dea_Invalid=2);
    dea_LENGTH_ErrorCount := COUNT(GROUP,h.dea_Invalid=3);
    dea_WORDS_ErrorCount := COUNT(GROUP,h.dea_Invalid=4);
    dea_Total_ErrorCount := COUNT(GROUP,h.dea_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3);
    cr_sort_sz_WORDS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    clinicname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clinicname_Invalid=1);
    clinicname_ALLOW_ErrorCount := COUNT(GROUP,h.clinicname_Invalid=2);
    clinicname_WORDS_ErrorCount := COUNT(GROUP,h.clinicname_Invalid=3);
    clinicname_Total_ErrorCount := COUNT(GROUP,h.clinicname_Invalid>0);
    clean_clinic_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=1);
    clean_clinic_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=2);
    clean_clinic_name_Total_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid>0);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=3);
    cart_WORDS_ErrorCount := COUNT(GROUP,h.cart_Invalid=4);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    best_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=3);
    best_ssn_WORDS_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=4);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    best_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=1);
    best_dob_ALLOW_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=2);
    best_dob_LENGTH_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=3);
    best_dob_WORDS_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=4);
    best_dob_Total_ErrorCount := COUNT(GROUP,h.best_dob_Invalid>0);
    bdid_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=2);
    bdid_score_LENGTH_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=3);
    bdid_score_WORDS_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=4);
    bdid_score_Total_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid>0);
    bdid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_LENGTH_ErrorCount := COUNT(GROUP,h.bdid_Invalid=3);
    bdid_WORDS_ErrorCount := COUNT(GROUP,h.bdid_Invalid=4);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    addressline2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=1);
    addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=2);
    addressline2_Total_ErrorCount := COUNT(GROUP,h.addressline2_Invalid>0);
    addressline1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=1);
    addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=2);
    addressline1_Total_ErrorCount := COUNT(GROUP,h.addressline1_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=3);
    addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=4);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    activestarttime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=1);
    activestarttime_ALLOW_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=2);
    activestarttime_LENGTH_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=3);
    activestarttime_WORDS_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=4);
    activestarttime_Total_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid>0);
    activeendtime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=1);
    activeendtime_ALLOW_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=2);
    activeendtime_LENGTH_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=3);
    activeendtime_WORDS_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=4);
    activeendtime_Total_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.zipcode_Invalid,le.zip_Invalid,le.zip4_Invalid,le.version_Invalid,le.v_city_name_Invalid,le.upin_Invalid,le.unit_desig_Invalid,le.title_Invalid,le.textservicelevelchange_Invalid,le.textservicelevel_Invalid,le.suffixname_Invalid,le.statelicensenumber_Invalid,le.state_Invalid,le.st_Invalid,le.spi_Invalid,le.specialtycodeprimary_Invalid,le.specialitytype4_Invalid,le.specialitytype3_Invalid,le.specialitytype2_Invalid,le.specialitytype1_Invalid,le.socialsecurity_Invalid,le.servicelevel_Invalid,le.sec_range_Invalid,le.recordchange_Invalid,le.priorauthorization_Invalid,le.prim_range_Invalid,le.prim_name_Invalid,le.prepped_addr2_Invalid,le.prepped_addr1_Invalid,le.prefixname_Invalid,le.predir_Invalid,le.pponumber_Invalid,le.postdir_Invalid,le.phoneprimary_Invalid,le.phonealt5qualifier_Invalid,le.phonealt5_Invalid,le.phonealt4qualifier_Invalid,le.phonealt4_Invalid,le.phonealt3qualifier_Invalid,le.phonealt3_Invalid,le.phonealt2qualifier_Invalid,le.phonealt2_Invalid,le.phonealt1qualifier_Invalid,le.phonealt1_Invalid,le.partneraccount_Invalid,le.p_city_name_Invalid,le.oldservicelevel_Invalid,le.npilocation_Invalid,le.npi_Invalid,le.nid_Invalid,le.name_type_Invalid,le.name_suffix_Invalid,le.mutuallydefined_Invalid,le.mname_Invalid,le.middlename_Invalid,le.medicarenumber_Invalid,le.medicaidnumber_Invalid,le.lot_Invalid,le.lnpid_Invalid,le.lname_Invalid,le.lastname_Invalid,le.lastmodifieddate_Invalid,le.instorencpdpid_Invalid,le.fname_Invalid,le.firstname_Invalid,le.fileid_Invalid,le.fax_Invalid,le.email_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_last_seen_Invalid,le.dt_first_seen_Invalid,le.did_score_Invalid,le.did_Invalid,le.dentistlicensenumber_Invalid,le.dea_Invalid,le.cr_sort_sz_Invalid,le.clinicname_Invalid,le.clean_clinic_name_Invalid,le.city_Invalid,le.cart_Invalid,le.best_ssn_Invalid,le.best_dob_Invalid,le.bdid_score_Invalid,le.bdid_Invalid,le.addressline2_Invalid,le.addressline1_Invalid,le.addr_suffix_Invalid,le.activestarttime_Invalid,le.activeendtime_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,base_Fields.InvalidMessage_zipcode(le.zipcode_Invalid),base_Fields.InvalidMessage_zip(le.zip_Invalid),base_Fields.InvalidMessage_zip4(le.zip4_Invalid),base_Fields.InvalidMessage_version(le.version_Invalid),base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),base_Fields.InvalidMessage_upin(le.upin_Invalid),base_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),base_Fields.InvalidMessage_title(le.title_Invalid),base_Fields.InvalidMessage_textservicelevelchange(le.textservicelevelchange_Invalid),base_Fields.InvalidMessage_textservicelevel(le.textservicelevel_Invalid),base_Fields.InvalidMessage_suffixname(le.suffixname_Invalid),base_Fields.InvalidMessage_statelicensenumber(le.statelicensenumber_Invalid),base_Fields.InvalidMessage_state(le.state_Invalid),base_Fields.InvalidMessage_st(le.st_Invalid),base_Fields.InvalidMessage_spi(le.spi_Invalid),base_Fields.InvalidMessage_specialtycodeprimary(le.specialtycodeprimary_Invalid),base_Fields.InvalidMessage_specialitytype4(le.specialitytype4_Invalid),base_Fields.InvalidMessage_specialitytype3(le.specialitytype3_Invalid),base_Fields.InvalidMessage_specialitytype2(le.specialitytype2_Invalid),base_Fields.InvalidMessage_specialitytype1(le.specialitytype1_Invalid),base_Fields.InvalidMessage_socialsecurity(le.socialsecurity_Invalid),base_Fields.InvalidMessage_servicelevel(le.servicelevel_Invalid),base_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),base_Fields.InvalidMessage_recordchange(le.recordchange_Invalid),base_Fields.InvalidMessage_priorauthorization(le.priorauthorization_Invalid),base_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),base_Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),base_Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),base_Fields.InvalidMessage_prefixname(le.prefixname_Invalid),base_Fields.InvalidMessage_predir(le.predir_Invalid),base_Fields.InvalidMessage_pponumber(le.pponumber_Invalid),base_Fields.InvalidMessage_postdir(le.postdir_Invalid),base_Fields.InvalidMessage_phoneprimary(le.phoneprimary_Invalid),base_Fields.InvalidMessage_phonealt5qualifier(le.phonealt5qualifier_Invalid),base_Fields.InvalidMessage_phonealt5(le.phonealt5_Invalid),base_Fields.InvalidMessage_phonealt4qualifier(le.phonealt4qualifier_Invalid),base_Fields.InvalidMessage_phonealt4(le.phonealt4_Invalid),base_Fields.InvalidMessage_phonealt3qualifier(le.phonealt3qualifier_Invalid),base_Fields.InvalidMessage_phonealt3(le.phonealt3_Invalid),base_Fields.InvalidMessage_phonealt2qualifier(le.phonealt2qualifier_Invalid),base_Fields.InvalidMessage_phonealt2(le.phonealt2_Invalid),base_Fields.InvalidMessage_phonealt1qualifier(le.phonealt1qualifier_Invalid),base_Fields.InvalidMessage_phonealt1(le.phonealt1_Invalid),base_Fields.InvalidMessage_partneraccount(le.partneraccount_Invalid),base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),base_Fields.InvalidMessage_oldservicelevel(le.oldservicelevel_Invalid),base_Fields.InvalidMessage_npilocation(le.npilocation_Invalid),base_Fields.InvalidMessage_npi(le.npi_Invalid),base_Fields.InvalidMessage_nid(le.nid_Invalid),base_Fields.InvalidMessage_name_type(le.name_type_Invalid),base_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),base_Fields.InvalidMessage_mutuallydefined(le.mutuallydefined_Invalid),base_Fields.InvalidMessage_mname(le.mname_Invalid),base_Fields.InvalidMessage_middlename(le.middlename_Invalid),base_Fields.InvalidMessage_medicarenumber(le.medicarenumber_Invalid),base_Fields.InvalidMessage_medicaidnumber(le.medicaidnumber_Invalid),base_Fields.InvalidMessage_lot(le.lot_Invalid),base_Fields.InvalidMessage_lnpid(le.lnpid_Invalid),base_Fields.InvalidMessage_lname(le.lname_Invalid),base_Fields.InvalidMessage_lastname(le.lastname_Invalid),base_Fields.InvalidMessage_lastmodifieddate(le.lastmodifieddate_Invalid),base_Fields.InvalidMessage_instorencpdpid(le.instorencpdpid_Invalid),base_Fields.InvalidMessage_fname(le.fname_Invalid),base_Fields.InvalidMessage_firstname(le.firstname_Invalid),base_Fields.InvalidMessage_fileid(le.fileid_Invalid),base_Fields.InvalidMessage_fax(le.fax_Invalid),base_Fields.InvalidMessage_email(le.email_Invalid),base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),base_Fields.InvalidMessage_did_score(le.did_score_Invalid),base_Fields.InvalidMessage_did(le.did_Invalid),base_Fields.InvalidMessage_dentistlicensenumber(le.dentistlicensenumber_Invalid),base_Fields.InvalidMessage_dea(le.dea_Invalid),base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),base_Fields.InvalidMessage_clinicname(le.clinicname_Invalid),base_Fields.InvalidMessage_clean_clinic_name(le.clean_clinic_name_Invalid),base_Fields.InvalidMessage_city(le.city_Invalid),base_Fields.InvalidMessage_cart(le.cart_Invalid),base_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),base_Fields.InvalidMessage_best_dob(le.best_dob_Invalid),base_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),base_Fields.InvalidMessage_bdid(le.bdid_Invalid),base_Fields.InvalidMessage_addressline2(le.addressline2_Invalid),base_Fields.InvalidMessage_addressline1(le.addressline1_Invalid),base_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),base_Fields.InvalidMessage_activestarttime(le.activestarttime_Invalid),base_Fields.InvalidMessage_activeendtime(le.activeendtime_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.version_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.upin_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.textservicelevelchange_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.textservicelevel_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.suffixname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.statelicensenumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.spi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialtycodeprimary_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialitytype4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialitytype3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialitytype2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialitytype1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.socialsecurity_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.servicelevel_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.recordchange_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.priorauthorization_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prefixname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.pponumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phoneprimary_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt5qualifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt4qualifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt3qualifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt2qualifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt1qualifier_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phonealt1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.partneraccount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.oldservicelevel_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.npilocation_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.nid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mutuallydefined_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.medicarenumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.medicaidnumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lastmodifieddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.instorencpdpid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fileid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fax_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dentistlicensenumber_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dea_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clinicname_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_clinic_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.best_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addressline2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addressline1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.activestarttime_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.activeendtime_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'zipcode','zip','zip4','version','v_city_name','upin','unit_desig','title','textservicelevelchange','textservicelevel','suffixname','statelicensenumber','state','st','spi','specialtycodeprimary','specialitytype4','specialitytype3','specialitytype2','specialitytype1','socialsecurity','servicelevel','sec_range','recordchange','priorauthorization','prim_range','prim_name','prepped_addr2','prepped_addr1','prefixname','predir','pponumber','postdir','phoneprimary','phonealt5qualifier','phonealt5','phonealt4qualifier','phonealt4','phonealt3qualifier','phonealt3','phonealt2qualifier','phonealt2','phonealt1qualifier','phonealt1','partneraccount','p_city_name','oldservicelevel','npilocation','npi','nid','name_type','name_suffix','mutuallydefined','mname','middlename','medicarenumber','medicaidnumber','lot','lnpid','lname','lastname','lastmodifieddate','instorencpdpid','fname','firstname','fileid','fax','email','dt_vendor_last_reported','dt_vendor_first_reported','dt_last_seen','dt_first_seen','did_score','did','dentistlicensenumber','dea','cr_sort_sz','clinicname','clean_clinic_name','city','cart','best_ssn','best_dob','bdid_score','bdid','addressline2','addressline1','addr_suffix','activestarttime','activeendtime','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'zipcode','zip','zip4','version','v_city_name','upin','unit_desig','title','textservicelevelchange','textservicelevel','suffixname','statelicensenumber','state','st','spi','specialtycodeprimary','specialitytype4','specialitytype3','specialitytype2','specialitytype1','socialsecurity','servicelevel','sec_range','recordchange','priorauthorization','prim_range','prim_name','prepped_addr2','prepped_addr1','prefixname','predir','pponumber','postdir','phoneprimary','phonealt5qualifier','phonealt5','phonealt4qualifier','phonealt4','phonealt3qualifier','phonealt3','phonealt2qualifier','phonealt2','phonealt1qualifier','phonealt1','partneraccount','p_city_name','oldservicelevel','npilocation','npi','nid','name_type','name_suffix','mutuallydefined','mname','middlename','medicarenumber','medicaidnumber','lot','lnpid','lname','lastname','lastmodifieddate','instorencpdpid','fname','firstname','fileid','fax','email','dt_vendor_last_reported','dt_vendor_first_reported','dt_last_seen','dt_first_seen','did_score','did','dentistlicensenumber','dea','cr_sort_sz','clinicname','clean_clinic_name','city','cart','best_ssn','best_dob','bdid_score','bdid','addressline2','addressline1','addr_suffix','activestarttime','activeendtime','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.zipcode,(SALT31.StrType)le.zip,(SALT31.StrType)le.zip4,(SALT31.StrType)le.version,(SALT31.StrType)le.v_city_name,(SALT31.StrType)le.upin,(SALT31.StrType)le.unit_desig,(SALT31.StrType)le.title,(SALT31.StrType)le.textservicelevelchange,(SALT31.StrType)le.textservicelevel,(SALT31.StrType)le.suffixname,(SALT31.StrType)le.statelicensenumber,(SALT31.StrType)le.state,(SALT31.StrType)le.st,(SALT31.StrType)le.spi,(SALT31.StrType)le.specialtycodeprimary,(SALT31.StrType)le.specialitytype4,(SALT31.StrType)le.specialitytype3,(SALT31.StrType)le.specialitytype2,(SALT31.StrType)le.specialitytype1,(SALT31.StrType)le.socialsecurity,(SALT31.StrType)le.servicelevel,(SALT31.StrType)le.sec_range,(SALT31.StrType)le.recordchange,(SALT31.StrType)le.priorauthorization,(SALT31.StrType)le.prim_range,(SALT31.StrType)le.prim_name,(SALT31.StrType)le.prepped_addr2,(SALT31.StrType)le.prepped_addr1,(SALT31.StrType)le.prefixname,(SALT31.StrType)le.predir,(SALT31.StrType)le.pponumber,(SALT31.StrType)le.postdir,(SALT31.StrType)le.phoneprimary,(SALT31.StrType)le.phonealt5qualifier,(SALT31.StrType)le.phonealt5,(SALT31.StrType)le.phonealt4qualifier,(SALT31.StrType)le.phonealt4,(SALT31.StrType)le.phonealt3qualifier,(SALT31.StrType)le.phonealt3,(SALT31.StrType)le.phonealt2qualifier,(SALT31.StrType)le.phonealt2,(SALT31.StrType)le.phonealt1qualifier,(SALT31.StrType)le.phonealt1,(SALT31.StrType)le.partneraccount,(SALT31.StrType)le.p_city_name,(SALT31.StrType)le.oldservicelevel,(SALT31.StrType)le.npilocation,(SALT31.StrType)le.npi,(SALT31.StrType)le.nid,(SALT31.StrType)le.name_type,(SALT31.StrType)le.name_suffix,(SALT31.StrType)le.mutuallydefined,(SALT31.StrType)le.mname,(SALT31.StrType)le.middlename,(SALT31.StrType)le.medicarenumber,(SALT31.StrType)le.medicaidnumber,(SALT31.StrType)le.lot,(SALT31.StrType)le.lnpid,(SALT31.StrType)le.lname,(SALT31.StrType)le.lastname,(SALT31.StrType)le.lastmodifieddate,(SALT31.StrType)le.instorencpdpid,(SALT31.StrType)le.fname,(SALT31.StrType)le.firstname,(SALT31.StrType)le.fileid,(SALT31.StrType)le.fax,(SALT31.StrType)le.email,(SALT31.StrType)le.dt_vendor_last_reported,(SALT31.StrType)le.dt_vendor_first_reported,(SALT31.StrType)le.dt_last_seen,(SALT31.StrType)le.dt_first_seen,(SALT31.StrType)le.did_score,(SALT31.StrType)le.did,(SALT31.StrType)le.dentistlicensenumber,(SALT31.StrType)le.dea,(SALT31.StrType)le.cr_sort_sz,(SALT31.StrType)le.clinicname,(SALT31.StrType)le.clean_clinic_name,(SALT31.StrType)le.city,(SALT31.StrType)le.cart,(SALT31.StrType)le.best_ssn,(SALT31.StrType)le.best_dob,(SALT31.StrType)le.bdid_score,(SALT31.StrType)le.bdid,(SALT31.StrType)le.addressline2,(SALT31.StrType)le.addressline1,(SALT31.StrType)le.addr_suffix,(SALT31.StrType)le.activestarttime,(SALT31.StrType)le.activeendtime,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,90,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'zipcode:zipcode:LEFTTRIM','zipcode:zipcode:ALLOW','zipcode:zipcode:LENGTH','zipcode:zipcode:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTH','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTH','zip4:zip4:WORDS'
          ,'version:version:LEFTTRIM','version:version:ALLOW','version:version:LENGTH','version:version:WORDS'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW'
          ,'upin:upin:LEFTTRIM','upin:upin:ALLOW','upin:upin:LENGTH','upin:upin:WORDS'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW','unit_desig:unit_desig:LENGTH','unit_desig:unit_desig:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTH','title:title:WORDS'
          ,'textservicelevelchange:textservicelevelchange:LEFTTRIM','textservicelevelchange:textservicelevelchange:ALLOW','textservicelevelchange:textservicelevelchange:LENGTH','textservicelevelchange:textservicelevelchange:WORDS'
          ,'textservicelevel:textservicelevel:LEFTTRIM','textservicelevel:textservicelevel:ALLOW','textservicelevel:textservicelevel:LENGTH','textservicelevel:textservicelevel:WORDS'
          ,'suffixname:suffixname:LEFTTRIM','suffixname:suffixname:ALLOW','suffixname:suffixname:LENGTH','suffixname:suffixname:WORDS'
          ,'statelicensenumber:statelicensenumber:LEFTTRIM','statelicensenumber:statelicensenumber:ALLOW','statelicensenumber:statelicensenumber:LENGTH','statelicensenumber:statelicensenumber:WORDS'
          ,'state:state:LEFTTRIM','state:state:ALLOW','state:state:LENGTH','state:state:WORDS'
          ,'st:st:LEFTTRIM','st:st:ALLOW','st:st:LENGTH','st:st:WORDS'
          ,'spi:spi:LEFTTRIM','spi:spi:ALLOW','spi:spi:LENGTH','spi:spi:WORDS'
          ,'specialtycodeprimary:specialtycodeprimary:LEFTTRIM','specialtycodeprimary:specialtycodeprimary:ALLOW','specialtycodeprimary:specialtycodeprimary:LENGTH','specialtycodeprimary:specialtycodeprimary:WORDS'
          ,'specialitytype4:specialitytype4:LEFTTRIM','specialitytype4:specialitytype4:ALLOW','specialitytype4:specialitytype4:LENGTH','specialitytype4:specialitytype4:WORDS'
          ,'specialitytype3:specialitytype3:LEFTTRIM','specialitytype3:specialitytype3:ALLOW','specialitytype3:specialitytype3:LENGTH','specialitytype3:specialitytype3:WORDS'
          ,'specialitytype2:specialitytype2:LEFTTRIM','specialitytype2:specialitytype2:ALLOW','specialitytype2:specialitytype2:LENGTH','specialitytype2:specialitytype2:WORDS'
          ,'specialitytype1:specialitytype1:LEFTTRIM','specialitytype1:specialitytype1:ALLOW','specialitytype1:specialitytype1:LENGTH','specialitytype1:specialitytype1:WORDS'
          ,'socialsecurity:socialsecurity:LEFTTRIM','socialsecurity:socialsecurity:ALLOW','socialsecurity:socialsecurity:LENGTH','socialsecurity:socialsecurity:WORDS'
          ,'servicelevel:servicelevel:LEFTTRIM','servicelevel:servicelevel:ALLOW','servicelevel:servicelevel:LENGTH','servicelevel:servicelevel:WORDS'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTH','sec_range:sec_range:WORDS'
          ,'recordchange:recordchange:LEFTTRIM','recordchange:recordchange:ALLOW','recordchange:recordchange:LENGTH','recordchange:recordchange:WORDS'
          ,'priorauthorization:priorauthorization:LEFTTRIM','priorauthorization:priorauthorization:ALLOW','priorauthorization:priorauthorization:LENGTH','priorauthorization:priorauthorization:WORDS'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW','prim_range:prim_range:WORDS'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW'
          ,'prefixname:prefixname:LEFTTRIM','prefixname:prefixname:ALLOW','prefixname:prefixname:LENGTH','prefixname:prefixname:WORDS'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW','predir:predir:LENGTH','predir:predir:WORDS'
          ,'pponumber:pponumber:LEFTTRIM','pponumber:pponumber:ALLOW','pponumber:pponumber:LENGTH','pponumber:pponumber:WORDS'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW','postdir:postdir:LENGTH','postdir:postdir:WORDS'
          ,'phoneprimary:phoneprimary:LEFTTRIM','phoneprimary:phoneprimary:ALLOW','phoneprimary:phoneprimary:LENGTH','phoneprimary:phoneprimary:WORDS'
          ,'phonealt5qualifier:phonealt5qualifier:LEFTTRIM','phonealt5qualifier:phonealt5qualifier:ALLOW','phonealt5qualifier:phonealt5qualifier:LENGTH','phonealt5qualifier:phonealt5qualifier:WORDS'
          ,'phonealt5:phonealt5:LEFTTRIM','phonealt5:phonealt5:ALLOW','phonealt5:phonealt5:LENGTH','phonealt5:phonealt5:WORDS'
          ,'phonealt4qualifier:phonealt4qualifier:LEFTTRIM','phonealt4qualifier:phonealt4qualifier:ALLOW','phonealt4qualifier:phonealt4qualifier:LENGTH','phonealt4qualifier:phonealt4qualifier:WORDS'
          ,'phonealt4:phonealt4:LEFTTRIM','phonealt4:phonealt4:ALLOW','phonealt4:phonealt4:LENGTH','phonealt4:phonealt4:WORDS'
          ,'phonealt3qualifier:phonealt3qualifier:LEFTTRIM','phonealt3qualifier:phonealt3qualifier:ALLOW','phonealt3qualifier:phonealt3qualifier:LENGTH','phonealt3qualifier:phonealt3qualifier:WORDS'
          ,'phonealt3:phonealt3:LEFTTRIM','phonealt3:phonealt3:ALLOW','phonealt3:phonealt3:LENGTH','phonealt3:phonealt3:WORDS'
          ,'phonealt2qualifier:phonealt2qualifier:LEFTTRIM','phonealt2qualifier:phonealt2qualifier:ALLOW','phonealt2qualifier:phonealt2qualifier:LENGTH','phonealt2qualifier:phonealt2qualifier:WORDS'
          ,'phonealt2:phonealt2:LEFTTRIM','phonealt2:phonealt2:ALLOW','phonealt2:phonealt2:LENGTH','phonealt2:phonealt2:WORDS'
          ,'phonealt1qualifier:phonealt1qualifier:LEFTTRIM','phonealt1qualifier:phonealt1qualifier:ALLOW','phonealt1qualifier:phonealt1qualifier:LENGTH','phonealt1qualifier:phonealt1qualifier:WORDS'
          ,'phonealt1:phonealt1:LEFTTRIM','phonealt1:phonealt1:ALLOW','phonealt1:phonealt1:LENGTH','phonealt1:phonealt1:WORDS'
          ,'partneraccount:partneraccount:ALLOW'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW'
          ,'oldservicelevel:oldservicelevel:LEFTTRIM','oldservicelevel:oldservicelevel:ALLOW','oldservicelevel:oldservicelevel:LENGTH','oldservicelevel:oldservicelevel:WORDS'
          ,'npilocation:npilocation:LEFTTRIM','npilocation:npilocation:ALLOW','npilocation:npilocation:LENGTH','npilocation:npilocation:WORDS'
          ,'npi:npi:LEFTTRIM','npi:npi:ALLOW','npi:npi:LENGTH','npi:npi:WORDS'
          ,'nid:nid:LEFTTRIM','nid:nid:ALLOW','nid:nid:LENGTH','nid:nid:WORDS'
          ,'name_type:name_type:LEFTTRIM','name_type:name_type:ALLOW','name_type:name_type:LENGTH','name_type:name_type:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTH','name_suffix:name_suffix:WORDS'
          ,'mutuallydefined:mutuallydefined:LEFTTRIM','mutuallydefined:mutuallydefined:ALLOW','mutuallydefined:mutuallydefined:LENGTH','mutuallydefined:mutuallydefined:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:WORDS'
          ,'middlename:middlename:LEFTTRIM','middlename:middlename:ALLOW','middlename:middlename:WORDS'
          ,'medicarenumber:medicarenumber:LEFTTRIM','medicarenumber:medicarenumber:ALLOW','medicarenumber:medicarenumber:LENGTH','medicarenumber:medicarenumber:WORDS'
          ,'medicaidnumber:medicaidnumber:LEFTTRIM','medicaidnumber:medicaidnumber:ALLOW','medicaidnumber:medicaidnumber:LENGTH','medicaidnumber:medicaidnumber:WORDS'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW','lot:lot:LENGTH','lot:lot:WORDS'
          ,'lnpid:lnpid:LEFTTRIM','lnpid:lnpid:ALLOW','lnpid:lnpid:LENGTH','lnpid:lnpid:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:LENGTH','lname:lname:WORDS'
          ,'lastname:lastname:LEFTTRIM','lastname:lastname:ALLOW','lastname:lastname:LENGTH','lastname:lastname:WORDS'
          ,'lastmodifieddate:lastmodifieddate:LEFTTRIM','lastmodifieddate:lastmodifieddate:ALLOW','lastmodifieddate:lastmodifieddate:LENGTH','lastmodifieddate:lastmodifieddate:WORDS'
          ,'instorencpdpid:instorencpdpid:LEFTTRIM','instorencpdpid:instorencpdpid:ALLOW','instorencpdpid:instorencpdpid:LENGTH','instorencpdpid:instorencpdpid:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:LENGTH','fname:fname:WORDS'
          ,'firstname:firstname:LEFTTRIM','firstname:firstname:ALLOW','firstname:firstname:LENGTH','firstname:firstname:WORDS'
          ,'fileid:fileid:LEFTTRIM','fileid:fileid:ALLOW','fileid:fileid:LENGTH','fileid:fileid:WORDS'
          ,'fax:fax:LEFTTRIM','fax:fax:ALLOW','fax:fax:LENGTH','fax:fax:WORDS'
          ,'email:email:LEFTTRIM','email:email:ALLOW','email:email:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTH','dt_last_seen:dt_last_seen:WORDS'
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTH','dt_first_seen:dt_first_seen:WORDS'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW','did_score:did_score:LENGTH','did_score:did_score:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'dentistlicensenumber:dentistlicensenumber:LEFTTRIM','dentistlicensenumber:dentistlicensenumber:ALLOW','dentistlicensenumber:dentistlicensenumber:LENGTH','dentistlicensenumber:dentistlicensenumber:WORDS'
          ,'dea:dea:LEFTTRIM','dea:dea:ALLOW','dea:dea:LENGTH','dea:dea:WORDS'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTH','cr_sort_sz:cr_sort_sz:WORDS'
          ,'clinicname:clinicname:LEFTTRIM','clinicname:clinicname:ALLOW','clinicname:clinicname:WORDS'
          ,'clean_clinic_name:clean_clinic_name:LEFTTRIM','clean_clinic_name:clean_clinic_name:ALLOW'
          ,'city:city:LEFTTRIM','city:city:ALLOW'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW','cart:cart:LENGTH','cart:cart:WORDS'
          ,'best_ssn:best_ssn:LEFTTRIM','best_ssn:best_ssn:ALLOW','best_ssn:best_ssn:LENGTH','best_ssn:best_ssn:WORDS'
          ,'best_dob:best_dob:LEFTTRIM','best_dob:best_dob:ALLOW','best_dob:best_dob:LENGTH','best_dob:best_dob:WORDS'
          ,'bdid_score:bdid_score:LEFTTRIM','bdid_score:bdid_score:ALLOW','bdid_score:bdid_score:LENGTH','bdid_score:bdid_score:WORDS'
          ,'bdid:bdid:LEFTTRIM','bdid:bdid:ALLOW','bdid:bdid:LENGTH','bdid:bdid:WORDS'
          ,'addressline2:addressline2:LEFTTRIM','addressline2:addressline2:ALLOW'
          ,'addressline1:addressline1:LEFTTRIM','addressline1:addressline1:ALLOW'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTH','addr_suffix:addr_suffix:WORDS'
          ,'activestarttime:activestarttime:LEFTTRIM','activestarttime:activestarttime:ALLOW','activestarttime:activestarttime:LENGTH','activestarttime:activestarttime:WORDS'
          ,'activeendtime:activeendtime:LEFTTRIM','activeendtime:activeendtime:ALLOW','activeendtime:activeendtime:LENGTH','activeendtime:activeendtime:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,base_Fields.InvalidMessage_zipcode(1),base_Fields.InvalidMessage_zipcode(2),base_Fields.InvalidMessage_zipcode(3),base_Fields.InvalidMessage_zipcode(4)
          ,base_Fields.InvalidMessage_zip(1),base_Fields.InvalidMessage_zip(2),base_Fields.InvalidMessage_zip(3),base_Fields.InvalidMessage_zip(4)
          ,base_Fields.InvalidMessage_zip4(1),base_Fields.InvalidMessage_zip4(2),base_Fields.InvalidMessage_zip4(3),base_Fields.InvalidMessage_zip4(4)
          ,base_Fields.InvalidMessage_version(1),base_Fields.InvalidMessage_version(2),base_Fields.InvalidMessage_version(3),base_Fields.InvalidMessage_version(4)
          ,base_Fields.InvalidMessage_v_city_name(1),base_Fields.InvalidMessage_v_city_name(2)
          ,base_Fields.InvalidMessage_upin(1),base_Fields.InvalidMessage_upin(2),base_Fields.InvalidMessage_upin(3),base_Fields.InvalidMessage_upin(4)
          ,base_Fields.InvalidMessage_unit_desig(1),base_Fields.InvalidMessage_unit_desig(2),base_Fields.InvalidMessage_unit_desig(3),base_Fields.InvalidMessage_unit_desig(4)
          ,base_Fields.InvalidMessage_title(1),base_Fields.InvalidMessage_title(2),base_Fields.InvalidMessage_title(3),base_Fields.InvalidMessage_title(4)
          ,base_Fields.InvalidMessage_textservicelevelchange(1),base_Fields.InvalidMessage_textservicelevelchange(2),base_Fields.InvalidMessage_textservicelevelchange(3),base_Fields.InvalidMessage_textservicelevelchange(4)
          ,base_Fields.InvalidMessage_textservicelevel(1),base_Fields.InvalidMessage_textservicelevel(2),base_Fields.InvalidMessage_textservicelevel(3),base_Fields.InvalidMessage_textservicelevel(4)
          ,base_Fields.InvalidMessage_suffixname(1),base_Fields.InvalidMessage_suffixname(2),base_Fields.InvalidMessage_suffixname(3),base_Fields.InvalidMessage_suffixname(4)
          ,base_Fields.InvalidMessage_statelicensenumber(1),base_Fields.InvalidMessage_statelicensenumber(2),base_Fields.InvalidMessage_statelicensenumber(3),base_Fields.InvalidMessage_statelicensenumber(4)
          ,base_Fields.InvalidMessage_state(1),base_Fields.InvalidMessage_state(2),base_Fields.InvalidMessage_state(3),base_Fields.InvalidMessage_state(4)
          ,base_Fields.InvalidMessage_st(1),base_Fields.InvalidMessage_st(2),base_Fields.InvalidMessage_st(3),base_Fields.InvalidMessage_st(4)
          ,base_Fields.InvalidMessage_spi(1),base_Fields.InvalidMessage_spi(2),base_Fields.InvalidMessage_spi(3),base_Fields.InvalidMessage_spi(4)
          ,base_Fields.InvalidMessage_specialtycodeprimary(1),base_Fields.InvalidMessage_specialtycodeprimary(2),base_Fields.InvalidMessage_specialtycodeprimary(3),base_Fields.InvalidMessage_specialtycodeprimary(4)
          ,base_Fields.InvalidMessage_specialitytype4(1),base_Fields.InvalidMessage_specialitytype4(2),base_Fields.InvalidMessage_specialitytype4(3),base_Fields.InvalidMessage_specialitytype4(4)
          ,base_Fields.InvalidMessage_specialitytype3(1),base_Fields.InvalidMessage_specialitytype3(2),base_Fields.InvalidMessage_specialitytype3(3),base_Fields.InvalidMessage_specialitytype3(4)
          ,base_Fields.InvalidMessage_specialitytype2(1),base_Fields.InvalidMessage_specialitytype2(2),base_Fields.InvalidMessage_specialitytype2(3),base_Fields.InvalidMessage_specialitytype2(4)
          ,base_Fields.InvalidMessage_specialitytype1(1),base_Fields.InvalidMessage_specialitytype1(2),base_Fields.InvalidMessage_specialitytype1(3),base_Fields.InvalidMessage_specialitytype1(4)
          ,base_Fields.InvalidMessage_socialsecurity(1),base_Fields.InvalidMessage_socialsecurity(2),base_Fields.InvalidMessage_socialsecurity(3),base_Fields.InvalidMessage_socialsecurity(4)
          ,base_Fields.InvalidMessage_servicelevel(1),base_Fields.InvalidMessage_servicelevel(2),base_Fields.InvalidMessage_servicelevel(3),base_Fields.InvalidMessage_servicelevel(4)
          ,base_Fields.InvalidMessage_sec_range(1),base_Fields.InvalidMessage_sec_range(2),base_Fields.InvalidMessage_sec_range(3),base_Fields.InvalidMessage_sec_range(4)
          ,base_Fields.InvalidMessage_recordchange(1),base_Fields.InvalidMessage_recordchange(2),base_Fields.InvalidMessage_recordchange(3),base_Fields.InvalidMessage_recordchange(4)
          ,base_Fields.InvalidMessage_priorauthorization(1),base_Fields.InvalidMessage_priorauthorization(2),base_Fields.InvalidMessage_priorauthorization(3),base_Fields.InvalidMessage_priorauthorization(4)
          ,base_Fields.InvalidMessage_prim_range(1),base_Fields.InvalidMessage_prim_range(2),base_Fields.InvalidMessage_prim_range(3)
          ,base_Fields.InvalidMessage_prim_name(1),base_Fields.InvalidMessage_prim_name(2)
          ,base_Fields.InvalidMessage_prepped_addr2(1),base_Fields.InvalidMessage_prepped_addr2(2)
          ,base_Fields.InvalidMessage_prepped_addr1(1),base_Fields.InvalidMessage_prepped_addr1(2)
          ,base_Fields.InvalidMessage_prefixname(1),base_Fields.InvalidMessage_prefixname(2),base_Fields.InvalidMessage_prefixname(3),base_Fields.InvalidMessage_prefixname(4)
          ,base_Fields.InvalidMessage_predir(1),base_Fields.InvalidMessage_predir(2),base_Fields.InvalidMessage_predir(3),base_Fields.InvalidMessage_predir(4)
          ,base_Fields.InvalidMessage_pponumber(1),base_Fields.InvalidMessage_pponumber(2),base_Fields.InvalidMessage_pponumber(3),base_Fields.InvalidMessage_pponumber(4)
          ,base_Fields.InvalidMessage_postdir(1),base_Fields.InvalidMessage_postdir(2),base_Fields.InvalidMessage_postdir(3),base_Fields.InvalidMessage_postdir(4)
          ,base_Fields.InvalidMessage_phoneprimary(1),base_Fields.InvalidMessage_phoneprimary(2),base_Fields.InvalidMessage_phoneprimary(3),base_Fields.InvalidMessage_phoneprimary(4)
          ,base_Fields.InvalidMessage_phonealt5qualifier(1),base_Fields.InvalidMessage_phonealt5qualifier(2),base_Fields.InvalidMessage_phonealt5qualifier(3),base_Fields.InvalidMessage_phonealt5qualifier(4)
          ,base_Fields.InvalidMessage_phonealt5(1),base_Fields.InvalidMessage_phonealt5(2),base_Fields.InvalidMessage_phonealt5(3),base_Fields.InvalidMessage_phonealt5(4)
          ,base_Fields.InvalidMessage_phonealt4qualifier(1),base_Fields.InvalidMessage_phonealt4qualifier(2),base_Fields.InvalidMessage_phonealt4qualifier(3),base_Fields.InvalidMessage_phonealt4qualifier(4)
          ,base_Fields.InvalidMessage_phonealt4(1),base_Fields.InvalidMessage_phonealt4(2),base_Fields.InvalidMessage_phonealt4(3),base_Fields.InvalidMessage_phonealt4(4)
          ,base_Fields.InvalidMessage_phonealt3qualifier(1),base_Fields.InvalidMessage_phonealt3qualifier(2),base_Fields.InvalidMessage_phonealt3qualifier(3),base_Fields.InvalidMessage_phonealt3qualifier(4)
          ,base_Fields.InvalidMessage_phonealt3(1),base_Fields.InvalidMessage_phonealt3(2),base_Fields.InvalidMessage_phonealt3(3),base_Fields.InvalidMessage_phonealt3(4)
          ,base_Fields.InvalidMessage_phonealt2qualifier(1),base_Fields.InvalidMessage_phonealt2qualifier(2),base_Fields.InvalidMessage_phonealt2qualifier(3),base_Fields.InvalidMessage_phonealt2qualifier(4)
          ,base_Fields.InvalidMessage_phonealt2(1),base_Fields.InvalidMessage_phonealt2(2),base_Fields.InvalidMessage_phonealt2(3),base_Fields.InvalidMessage_phonealt2(4)
          ,base_Fields.InvalidMessage_phonealt1qualifier(1),base_Fields.InvalidMessage_phonealt1qualifier(2),base_Fields.InvalidMessage_phonealt1qualifier(3),base_Fields.InvalidMessage_phonealt1qualifier(4)
          ,base_Fields.InvalidMessage_phonealt1(1),base_Fields.InvalidMessage_phonealt1(2),base_Fields.InvalidMessage_phonealt1(3),base_Fields.InvalidMessage_phonealt1(4)
          ,base_Fields.InvalidMessage_partneraccount(1)
          ,base_Fields.InvalidMessage_p_city_name(1),base_Fields.InvalidMessage_p_city_name(2)
          ,base_Fields.InvalidMessage_oldservicelevel(1),base_Fields.InvalidMessage_oldservicelevel(2),base_Fields.InvalidMessage_oldservicelevel(3),base_Fields.InvalidMessage_oldservicelevel(4)
          ,base_Fields.InvalidMessage_npilocation(1),base_Fields.InvalidMessage_npilocation(2),base_Fields.InvalidMessage_npilocation(3),base_Fields.InvalidMessage_npilocation(4)
          ,base_Fields.InvalidMessage_npi(1),base_Fields.InvalidMessage_npi(2),base_Fields.InvalidMessage_npi(3),base_Fields.InvalidMessage_npi(4)
          ,base_Fields.InvalidMessage_nid(1),base_Fields.InvalidMessage_nid(2),base_Fields.InvalidMessage_nid(3),base_Fields.InvalidMessage_nid(4)
          ,base_Fields.InvalidMessage_name_type(1),base_Fields.InvalidMessage_name_type(2),base_Fields.InvalidMessage_name_type(3),base_Fields.InvalidMessage_name_type(4)
          ,base_Fields.InvalidMessage_name_suffix(1),base_Fields.InvalidMessage_name_suffix(2),base_Fields.InvalidMessage_name_suffix(3),base_Fields.InvalidMessage_name_suffix(4)
          ,base_Fields.InvalidMessage_mutuallydefined(1),base_Fields.InvalidMessage_mutuallydefined(2),base_Fields.InvalidMessage_mutuallydefined(3),base_Fields.InvalidMessage_mutuallydefined(4)
          ,base_Fields.InvalidMessage_mname(1),base_Fields.InvalidMessage_mname(2),base_Fields.InvalidMessage_mname(3)
          ,base_Fields.InvalidMessage_middlename(1),base_Fields.InvalidMessage_middlename(2),base_Fields.InvalidMessage_middlename(3)
          ,base_Fields.InvalidMessage_medicarenumber(1),base_Fields.InvalidMessage_medicarenumber(2),base_Fields.InvalidMessage_medicarenumber(3),base_Fields.InvalidMessage_medicarenumber(4)
          ,base_Fields.InvalidMessage_medicaidnumber(1),base_Fields.InvalidMessage_medicaidnumber(2),base_Fields.InvalidMessage_medicaidnumber(3),base_Fields.InvalidMessage_medicaidnumber(4)
          ,base_Fields.InvalidMessage_lot(1),base_Fields.InvalidMessage_lot(2),base_Fields.InvalidMessage_lot(3),base_Fields.InvalidMessage_lot(4)
          ,base_Fields.InvalidMessage_lnpid(1),base_Fields.InvalidMessage_lnpid(2),base_Fields.InvalidMessage_lnpid(3),base_Fields.InvalidMessage_lnpid(4)
          ,base_Fields.InvalidMessage_lname(1),base_Fields.InvalidMessage_lname(2),base_Fields.InvalidMessage_lname(3),base_Fields.InvalidMessage_lname(4)
          ,base_Fields.InvalidMessage_lastname(1),base_Fields.InvalidMessage_lastname(2),base_Fields.InvalidMessage_lastname(3),base_Fields.InvalidMessage_lastname(4)
          ,base_Fields.InvalidMessage_lastmodifieddate(1),base_Fields.InvalidMessage_lastmodifieddate(2),base_Fields.InvalidMessage_lastmodifieddate(3),base_Fields.InvalidMessage_lastmodifieddate(4)
          ,base_Fields.InvalidMessage_instorencpdpid(1),base_Fields.InvalidMessage_instorencpdpid(2),base_Fields.InvalidMessage_instorencpdpid(3),base_Fields.InvalidMessage_instorencpdpid(4)
          ,base_Fields.InvalidMessage_fname(1),base_Fields.InvalidMessage_fname(2),base_Fields.InvalidMessage_fname(3),base_Fields.InvalidMessage_fname(4)
          ,base_Fields.InvalidMessage_firstname(1),base_Fields.InvalidMessage_firstname(2),base_Fields.InvalidMessage_firstname(3),base_Fields.InvalidMessage_firstname(4)
          ,base_Fields.InvalidMessage_fileid(1),base_Fields.InvalidMessage_fileid(2),base_Fields.InvalidMessage_fileid(3),base_Fields.InvalidMessage_fileid(4)
          ,base_Fields.InvalidMessage_fax(1),base_Fields.InvalidMessage_fax(2),base_Fields.InvalidMessage_fax(3),base_Fields.InvalidMessage_fax(4)
          ,base_Fields.InvalidMessage_email(1),base_Fields.InvalidMessage_email(2),base_Fields.InvalidMessage_email(3)
          ,base_Fields.InvalidMessage_dt_vendor_last_reported(1),base_Fields.InvalidMessage_dt_vendor_last_reported(2),base_Fields.InvalidMessage_dt_vendor_last_reported(3),base_Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,base_Fields.InvalidMessage_dt_vendor_first_reported(1),base_Fields.InvalidMessage_dt_vendor_first_reported(2),base_Fields.InvalidMessage_dt_vendor_first_reported(3),base_Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,base_Fields.InvalidMessage_dt_last_seen(1),base_Fields.InvalidMessage_dt_last_seen(2),base_Fields.InvalidMessage_dt_last_seen(3),base_Fields.InvalidMessage_dt_last_seen(4)
          ,base_Fields.InvalidMessage_dt_first_seen(1),base_Fields.InvalidMessage_dt_first_seen(2),base_Fields.InvalidMessage_dt_first_seen(3),base_Fields.InvalidMessage_dt_first_seen(4)
          ,base_Fields.InvalidMessage_did_score(1),base_Fields.InvalidMessage_did_score(2),base_Fields.InvalidMessage_did_score(3),base_Fields.InvalidMessage_did_score(4)
          ,base_Fields.InvalidMessage_did(1),base_Fields.InvalidMessage_did(2),base_Fields.InvalidMessage_did(3),base_Fields.InvalidMessage_did(4)
          ,base_Fields.InvalidMessage_dentistlicensenumber(1),base_Fields.InvalidMessage_dentistlicensenumber(2),base_Fields.InvalidMessage_dentistlicensenumber(3),base_Fields.InvalidMessage_dentistlicensenumber(4)
          ,base_Fields.InvalidMessage_dea(1),base_Fields.InvalidMessage_dea(2),base_Fields.InvalidMessage_dea(3),base_Fields.InvalidMessage_dea(4)
          ,base_Fields.InvalidMessage_cr_sort_sz(1),base_Fields.InvalidMessage_cr_sort_sz(2),base_Fields.InvalidMessage_cr_sort_sz(3),base_Fields.InvalidMessage_cr_sort_sz(4)
          ,base_Fields.InvalidMessage_clinicname(1),base_Fields.InvalidMessage_clinicname(2),base_Fields.InvalidMessage_clinicname(3)
          ,base_Fields.InvalidMessage_clean_clinic_name(1),base_Fields.InvalidMessage_clean_clinic_name(2)
          ,base_Fields.InvalidMessage_city(1),base_Fields.InvalidMessage_city(2)
          ,base_Fields.InvalidMessage_cart(1),base_Fields.InvalidMessage_cart(2),base_Fields.InvalidMessage_cart(3),base_Fields.InvalidMessage_cart(4)
          ,base_Fields.InvalidMessage_best_ssn(1),base_Fields.InvalidMessage_best_ssn(2),base_Fields.InvalidMessage_best_ssn(3),base_Fields.InvalidMessage_best_ssn(4)
          ,base_Fields.InvalidMessage_best_dob(1),base_Fields.InvalidMessage_best_dob(2),base_Fields.InvalidMessage_best_dob(3),base_Fields.InvalidMessage_best_dob(4)
          ,base_Fields.InvalidMessage_bdid_score(1),base_Fields.InvalidMessage_bdid_score(2),base_Fields.InvalidMessage_bdid_score(3),base_Fields.InvalidMessage_bdid_score(4)
          ,base_Fields.InvalidMessage_bdid(1),base_Fields.InvalidMessage_bdid(2),base_Fields.InvalidMessage_bdid(3),base_Fields.InvalidMessage_bdid(4)
          ,base_Fields.InvalidMessage_addressline2(1),base_Fields.InvalidMessage_addressline2(2)
          ,base_Fields.InvalidMessage_addressline1(1),base_Fields.InvalidMessage_addressline1(2)
          ,base_Fields.InvalidMessage_addr_suffix(1),base_Fields.InvalidMessage_addr_suffix(2),base_Fields.InvalidMessage_addr_suffix(3),base_Fields.InvalidMessage_addr_suffix(4)
          ,base_Fields.InvalidMessage_activestarttime(1),base_Fields.InvalidMessage_activestarttime(2),base_Fields.InvalidMessage_activestarttime(3),base_Fields.InvalidMessage_activestarttime(4)
          ,base_Fields.InvalidMessage_activeendtime(1),base_Fields.InvalidMessage_activeendtime(2),base_Fields.InvalidMessage_activeendtime(3),base_Fields.InvalidMessage_activeendtime(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount,le.zipcode_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.version_LEFTTRIM_ErrorCount,le.version_ALLOW_ErrorCount,le.version_LENGTH_ErrorCount,le.version_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount,le.upin_LENGTH_ErrorCount,le.upin_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.textservicelevelchange_LEFTTRIM_ErrorCount,le.textservicelevelchange_ALLOW_ErrorCount,le.textservicelevelchange_LENGTH_ErrorCount,le.textservicelevelchange_WORDS_ErrorCount
          ,le.textservicelevel_LEFTTRIM_ErrorCount,le.textservicelevel_ALLOW_ErrorCount,le.textservicelevel_LENGTH_ErrorCount,le.textservicelevel_WORDS_ErrorCount
          ,le.suffixname_LEFTTRIM_ErrorCount,le.suffixname_ALLOW_ErrorCount,le.suffixname_LENGTH_ErrorCount,le.suffixname_WORDS_ErrorCount
          ,le.statelicensenumber_LEFTTRIM_ErrorCount,le.statelicensenumber_ALLOW_ErrorCount,le.statelicensenumber_LENGTH_ErrorCount,le.statelicensenumber_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.spi_LEFTTRIM_ErrorCount,le.spi_ALLOW_ErrorCount,le.spi_LENGTH_ErrorCount,le.spi_WORDS_ErrorCount
          ,le.specialtycodeprimary_LEFTTRIM_ErrorCount,le.specialtycodeprimary_ALLOW_ErrorCount,le.specialtycodeprimary_LENGTH_ErrorCount,le.specialtycodeprimary_WORDS_ErrorCount
          ,le.specialitytype4_LEFTTRIM_ErrorCount,le.specialitytype4_ALLOW_ErrorCount,le.specialitytype4_LENGTH_ErrorCount,le.specialitytype4_WORDS_ErrorCount
          ,le.specialitytype3_LEFTTRIM_ErrorCount,le.specialitytype3_ALLOW_ErrorCount,le.specialitytype3_LENGTH_ErrorCount,le.specialitytype3_WORDS_ErrorCount
          ,le.specialitytype2_LEFTTRIM_ErrorCount,le.specialitytype2_ALLOW_ErrorCount,le.specialitytype2_LENGTH_ErrorCount,le.specialitytype2_WORDS_ErrorCount
          ,le.specialitytype1_LEFTTRIM_ErrorCount,le.specialitytype1_ALLOW_ErrorCount,le.specialitytype1_LENGTH_ErrorCount,le.specialitytype1_WORDS_ErrorCount
          ,le.socialsecurity_LEFTTRIM_ErrorCount,le.socialsecurity_ALLOW_ErrorCount,le.socialsecurity_LENGTH_ErrorCount,le.socialsecurity_WORDS_ErrorCount
          ,le.servicelevel_LEFTTRIM_ErrorCount,le.servicelevel_ALLOW_ErrorCount,le.servicelevel_LENGTH_ErrorCount,le.servicelevel_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.recordchange_LEFTTRIM_ErrorCount,le.recordchange_ALLOW_ErrorCount,le.recordchange_LENGTH_ErrorCount,le.recordchange_WORDS_ErrorCount
          ,le.priorauthorization_LEFTTRIM_ErrorCount,le.priorauthorization_ALLOW_ErrorCount,le.priorauthorization_LENGTH_ErrorCount,le.priorauthorization_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prefixname_LEFTTRIM_ErrorCount,le.prefixname_ALLOW_ErrorCount,le.prefixname_LENGTH_ErrorCount,le.prefixname_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.pponumber_LEFTTRIM_ErrorCount,le.pponumber_ALLOW_ErrorCount,le.pponumber_LENGTH_ErrorCount,le.pponumber_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.phoneprimary_LEFTTRIM_ErrorCount,le.phoneprimary_ALLOW_ErrorCount,le.phoneprimary_LENGTH_ErrorCount,le.phoneprimary_WORDS_ErrorCount
          ,le.phonealt5qualifier_LEFTTRIM_ErrorCount,le.phonealt5qualifier_ALLOW_ErrorCount,le.phonealt5qualifier_LENGTH_ErrorCount,le.phonealt5qualifier_WORDS_ErrorCount
          ,le.phonealt5_LEFTTRIM_ErrorCount,le.phonealt5_ALLOW_ErrorCount,le.phonealt5_LENGTH_ErrorCount,le.phonealt5_WORDS_ErrorCount
          ,le.phonealt4qualifier_LEFTTRIM_ErrorCount,le.phonealt4qualifier_ALLOW_ErrorCount,le.phonealt4qualifier_LENGTH_ErrorCount,le.phonealt4qualifier_WORDS_ErrorCount
          ,le.phonealt4_LEFTTRIM_ErrorCount,le.phonealt4_ALLOW_ErrorCount,le.phonealt4_LENGTH_ErrorCount,le.phonealt4_WORDS_ErrorCount
          ,le.phonealt3qualifier_LEFTTRIM_ErrorCount,le.phonealt3qualifier_ALLOW_ErrorCount,le.phonealt3qualifier_LENGTH_ErrorCount,le.phonealt3qualifier_WORDS_ErrorCount
          ,le.phonealt3_LEFTTRIM_ErrorCount,le.phonealt3_ALLOW_ErrorCount,le.phonealt3_LENGTH_ErrorCount,le.phonealt3_WORDS_ErrorCount
          ,le.phonealt2qualifier_LEFTTRIM_ErrorCount,le.phonealt2qualifier_ALLOW_ErrorCount,le.phonealt2qualifier_LENGTH_ErrorCount,le.phonealt2qualifier_WORDS_ErrorCount
          ,le.phonealt2_LEFTTRIM_ErrorCount,le.phonealt2_ALLOW_ErrorCount,le.phonealt2_LENGTH_ErrorCount,le.phonealt2_WORDS_ErrorCount
          ,le.phonealt1qualifier_LEFTTRIM_ErrorCount,le.phonealt1qualifier_ALLOW_ErrorCount,le.phonealt1qualifier_LENGTH_ErrorCount,le.phonealt1qualifier_WORDS_ErrorCount
          ,le.phonealt1_LEFTTRIM_ErrorCount,le.phonealt1_ALLOW_ErrorCount,le.phonealt1_LENGTH_ErrorCount,le.phonealt1_WORDS_ErrorCount
          ,le.partneraccount_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.oldservicelevel_LEFTTRIM_ErrorCount,le.oldservicelevel_ALLOW_ErrorCount,le.oldservicelevel_LENGTH_ErrorCount,le.oldservicelevel_WORDS_ErrorCount
          ,le.npilocation_LEFTTRIM_ErrorCount,le.npilocation_ALLOW_ErrorCount,le.npilocation_LENGTH_ErrorCount,le.npilocation_WORDS_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount,le.npi_LENGTH_ErrorCount,le.npi_WORDS_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount,le.nid_LENGTH_ErrorCount,le.nid_WORDS_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount,le.name_type_LENGTH_ErrorCount,le.name_type_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.mutuallydefined_LEFTTRIM_ErrorCount,le.mutuallydefined_ALLOW_ErrorCount,le.mutuallydefined_LENGTH_ErrorCount,le.mutuallydefined_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.middlename_LEFTTRIM_ErrorCount,le.middlename_ALLOW_ErrorCount,le.middlename_WORDS_ErrorCount
          ,le.medicarenumber_LEFTTRIM_ErrorCount,le.medicarenumber_ALLOW_ErrorCount,le.medicarenumber_LENGTH_ErrorCount,le.medicarenumber_WORDS_ErrorCount
          ,le.medicaidnumber_LEFTTRIM_ErrorCount,le.medicaidnumber_ALLOW_ErrorCount,le.medicaidnumber_LENGTH_ErrorCount,le.medicaidnumber_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.lastname_LEFTTRIM_ErrorCount,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount,le.lastname_WORDS_ErrorCount
          ,le.lastmodifieddate_LEFTTRIM_ErrorCount,le.lastmodifieddate_ALLOW_ErrorCount,le.lastmodifieddate_LENGTH_ErrorCount,le.lastmodifieddate_WORDS_ErrorCount
          ,le.instorencpdpid_LEFTTRIM_ErrorCount,le.instorencpdpid_ALLOW_ErrorCount,le.instorencpdpid_LENGTH_ErrorCount,le.instorencpdpid_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.firstname_LEFTTRIM_ErrorCount,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount,le.firstname_WORDS_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount,le.fileid_LENGTH_ErrorCount,le.fileid_WORDS_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount,le.fax_LENGTH_ErrorCount,le.fax_WORDS_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount,le.email_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.dentistlicensenumber_LEFTTRIM_ErrorCount,le.dentistlicensenumber_ALLOW_ErrorCount,le.dentistlicensenumber_LENGTH_ErrorCount,le.dentistlicensenumber_WORDS_ErrorCount
          ,le.dea_LEFTTRIM_ErrorCount,le.dea_ALLOW_ErrorCount,le.dea_LENGTH_ErrorCount,le.dea_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.clinicname_LEFTTRIM_ErrorCount,le.clinicname_ALLOW_ErrorCount,le.clinicname_WORDS_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount,le.best_ssn_WORDS_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount,le.best_dob_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.addressline2_LEFTTRIM_ErrorCount,le.addressline2_ALLOW_ErrorCount
          ,le.addressline1_LEFTTRIM_ErrorCount,le.addressline1_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.activestarttime_LEFTTRIM_ErrorCount,le.activestarttime_ALLOW_ErrorCount,le.activestarttime_LENGTH_ErrorCount,le.activestarttime_WORDS_ErrorCount
          ,le.activeendtime_LEFTTRIM_ErrorCount,le.activeendtime_ALLOW_ErrorCount,le.activeendtime_LENGTH_ErrorCount,le.activeendtime_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount,le.zipcode_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.version_LEFTTRIM_ErrorCount,le.version_ALLOW_ErrorCount,le.version_LENGTH_ErrorCount,le.version_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount,le.upin_LENGTH_ErrorCount,le.upin_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.textservicelevelchange_LEFTTRIM_ErrorCount,le.textservicelevelchange_ALLOW_ErrorCount,le.textservicelevelchange_LENGTH_ErrorCount,le.textservicelevelchange_WORDS_ErrorCount
          ,le.textservicelevel_LEFTTRIM_ErrorCount,le.textservicelevel_ALLOW_ErrorCount,le.textservicelevel_LENGTH_ErrorCount,le.textservicelevel_WORDS_ErrorCount
          ,le.suffixname_LEFTTRIM_ErrorCount,le.suffixname_ALLOW_ErrorCount,le.suffixname_LENGTH_ErrorCount,le.suffixname_WORDS_ErrorCount
          ,le.statelicensenumber_LEFTTRIM_ErrorCount,le.statelicensenumber_ALLOW_ErrorCount,le.statelicensenumber_LENGTH_ErrorCount,le.statelicensenumber_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.spi_LEFTTRIM_ErrorCount,le.spi_ALLOW_ErrorCount,le.spi_LENGTH_ErrorCount,le.spi_WORDS_ErrorCount
          ,le.specialtycodeprimary_LEFTTRIM_ErrorCount,le.specialtycodeprimary_ALLOW_ErrorCount,le.specialtycodeprimary_LENGTH_ErrorCount,le.specialtycodeprimary_WORDS_ErrorCount
          ,le.specialitytype4_LEFTTRIM_ErrorCount,le.specialitytype4_ALLOW_ErrorCount,le.specialitytype4_LENGTH_ErrorCount,le.specialitytype4_WORDS_ErrorCount
          ,le.specialitytype3_LEFTTRIM_ErrorCount,le.specialitytype3_ALLOW_ErrorCount,le.specialitytype3_LENGTH_ErrorCount,le.specialitytype3_WORDS_ErrorCount
          ,le.specialitytype2_LEFTTRIM_ErrorCount,le.specialitytype2_ALLOW_ErrorCount,le.specialitytype2_LENGTH_ErrorCount,le.specialitytype2_WORDS_ErrorCount
          ,le.specialitytype1_LEFTTRIM_ErrorCount,le.specialitytype1_ALLOW_ErrorCount,le.specialitytype1_LENGTH_ErrorCount,le.specialitytype1_WORDS_ErrorCount
          ,le.socialsecurity_LEFTTRIM_ErrorCount,le.socialsecurity_ALLOW_ErrorCount,le.socialsecurity_LENGTH_ErrorCount,le.socialsecurity_WORDS_ErrorCount
          ,le.servicelevel_LEFTTRIM_ErrorCount,le.servicelevel_ALLOW_ErrorCount,le.servicelevel_LENGTH_ErrorCount,le.servicelevel_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.recordchange_LEFTTRIM_ErrorCount,le.recordchange_ALLOW_ErrorCount,le.recordchange_LENGTH_ErrorCount,le.recordchange_WORDS_ErrorCount
          ,le.priorauthorization_LEFTTRIM_ErrorCount,le.priorauthorization_ALLOW_ErrorCount,le.priorauthorization_LENGTH_ErrorCount,le.priorauthorization_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prefixname_LEFTTRIM_ErrorCount,le.prefixname_ALLOW_ErrorCount,le.prefixname_LENGTH_ErrorCount,le.prefixname_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.pponumber_LEFTTRIM_ErrorCount,le.pponumber_ALLOW_ErrorCount,le.pponumber_LENGTH_ErrorCount,le.pponumber_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.phoneprimary_LEFTTRIM_ErrorCount,le.phoneprimary_ALLOW_ErrorCount,le.phoneprimary_LENGTH_ErrorCount,le.phoneprimary_WORDS_ErrorCount
          ,le.phonealt5qualifier_LEFTTRIM_ErrorCount,le.phonealt5qualifier_ALLOW_ErrorCount,le.phonealt5qualifier_LENGTH_ErrorCount,le.phonealt5qualifier_WORDS_ErrorCount
          ,le.phonealt5_LEFTTRIM_ErrorCount,le.phonealt5_ALLOW_ErrorCount,le.phonealt5_LENGTH_ErrorCount,le.phonealt5_WORDS_ErrorCount
          ,le.phonealt4qualifier_LEFTTRIM_ErrorCount,le.phonealt4qualifier_ALLOW_ErrorCount,le.phonealt4qualifier_LENGTH_ErrorCount,le.phonealt4qualifier_WORDS_ErrorCount
          ,le.phonealt4_LEFTTRIM_ErrorCount,le.phonealt4_ALLOW_ErrorCount,le.phonealt4_LENGTH_ErrorCount,le.phonealt4_WORDS_ErrorCount
          ,le.phonealt3qualifier_LEFTTRIM_ErrorCount,le.phonealt3qualifier_ALLOW_ErrorCount,le.phonealt3qualifier_LENGTH_ErrorCount,le.phonealt3qualifier_WORDS_ErrorCount
          ,le.phonealt3_LEFTTRIM_ErrorCount,le.phonealt3_ALLOW_ErrorCount,le.phonealt3_LENGTH_ErrorCount,le.phonealt3_WORDS_ErrorCount
          ,le.phonealt2qualifier_LEFTTRIM_ErrorCount,le.phonealt2qualifier_ALLOW_ErrorCount,le.phonealt2qualifier_LENGTH_ErrorCount,le.phonealt2qualifier_WORDS_ErrorCount
          ,le.phonealt2_LEFTTRIM_ErrorCount,le.phonealt2_ALLOW_ErrorCount,le.phonealt2_LENGTH_ErrorCount,le.phonealt2_WORDS_ErrorCount
          ,le.phonealt1qualifier_LEFTTRIM_ErrorCount,le.phonealt1qualifier_ALLOW_ErrorCount,le.phonealt1qualifier_LENGTH_ErrorCount,le.phonealt1qualifier_WORDS_ErrorCount
          ,le.phonealt1_LEFTTRIM_ErrorCount,le.phonealt1_ALLOW_ErrorCount,le.phonealt1_LENGTH_ErrorCount,le.phonealt1_WORDS_ErrorCount
          ,le.partneraccount_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.oldservicelevel_LEFTTRIM_ErrorCount,le.oldservicelevel_ALLOW_ErrorCount,le.oldservicelevel_LENGTH_ErrorCount,le.oldservicelevel_WORDS_ErrorCount
          ,le.npilocation_LEFTTRIM_ErrorCount,le.npilocation_ALLOW_ErrorCount,le.npilocation_LENGTH_ErrorCount,le.npilocation_WORDS_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount,le.npi_LENGTH_ErrorCount,le.npi_WORDS_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount,le.nid_LENGTH_ErrorCount,le.nid_WORDS_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount,le.name_type_LENGTH_ErrorCount,le.name_type_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.mutuallydefined_LEFTTRIM_ErrorCount,le.mutuallydefined_ALLOW_ErrorCount,le.mutuallydefined_LENGTH_ErrorCount,le.mutuallydefined_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.middlename_LEFTTRIM_ErrorCount,le.middlename_ALLOW_ErrorCount,le.middlename_WORDS_ErrorCount
          ,le.medicarenumber_LEFTTRIM_ErrorCount,le.medicarenumber_ALLOW_ErrorCount,le.medicarenumber_LENGTH_ErrorCount,le.medicarenumber_WORDS_ErrorCount
          ,le.medicaidnumber_LEFTTRIM_ErrorCount,le.medicaidnumber_ALLOW_ErrorCount,le.medicaidnumber_LENGTH_ErrorCount,le.medicaidnumber_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.lastname_LEFTTRIM_ErrorCount,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount,le.lastname_WORDS_ErrorCount
          ,le.lastmodifieddate_LEFTTRIM_ErrorCount,le.lastmodifieddate_ALLOW_ErrorCount,le.lastmodifieddate_LENGTH_ErrorCount,le.lastmodifieddate_WORDS_ErrorCount
          ,le.instorencpdpid_LEFTTRIM_ErrorCount,le.instorencpdpid_ALLOW_ErrorCount,le.instorencpdpid_LENGTH_ErrorCount,le.instorencpdpid_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.firstname_LEFTTRIM_ErrorCount,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount,le.firstname_WORDS_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount,le.fileid_LENGTH_ErrorCount,le.fileid_WORDS_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount,le.fax_LENGTH_ErrorCount,le.fax_WORDS_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount,le.email_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.dentistlicensenumber_LEFTTRIM_ErrorCount,le.dentistlicensenumber_ALLOW_ErrorCount,le.dentistlicensenumber_LENGTH_ErrorCount,le.dentistlicensenumber_WORDS_ErrorCount
          ,le.dea_LEFTTRIM_ErrorCount,le.dea_ALLOW_ErrorCount,le.dea_LENGTH_ErrorCount,le.dea_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.clinicname_LEFTTRIM_ErrorCount,le.clinicname_ALLOW_ErrorCount,le.clinicname_WORDS_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount,le.best_ssn_WORDS_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount,le.best_dob_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.addressline2_LEFTTRIM_ErrorCount,le.addressline2_ALLOW_ErrorCount
          ,le.addressline1_LEFTTRIM_ErrorCount,le.addressline1_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.activestarttime_LEFTTRIM_ErrorCount,le.activestarttime_ALLOW_ErrorCount,le.activestarttime_LENGTH_ErrorCount,le.activestarttime_WORDS_ErrorCount
          ,le.activeendtime_LEFTTRIM_ErrorCount,le.activeendtime_ALLOW_ErrorCount,le.activeendtime_LENGTH_ErrorCount,le.activeendtime_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,334,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
