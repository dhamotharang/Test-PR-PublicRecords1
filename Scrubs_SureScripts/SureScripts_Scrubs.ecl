IMPORT ut,SALT31;
EXPORT SureScripts_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(SureScripts_Layout_SureScripts)
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 best_dob_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 spi_Invalid;
    UNSIGNED1 dea_Invalid;
    UNSIGNED1 statelicensenumber_Invalid;
    UNSIGNED1 specialtycodeprimary_Invalid;
    UNSIGNED1 prefixname_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 suffixname_Invalid;
    UNSIGNED1 clinicname_Invalid;
    UNSIGNED1 addressline1_Invalid;
    UNSIGNED1 addressline2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 phoneprimary_Invalid;
    UNSIGNED1 fax_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 phonealt1_Invalid;
    UNSIGNED1 phonealt1qualifier_Invalid;
    UNSIGNED1 phonealt2_Invalid;
    UNSIGNED1 phonealt2qualifier_Invalid;
    UNSIGNED1 phonealt3_Invalid;
    UNSIGNED1 phonealt3qualifier_Invalid;
    UNSIGNED1 phonealt4_Invalid;
    UNSIGNED1 phonealt4qualifier_Invalid;
    UNSIGNED1 phonealt5_Invalid;
    UNSIGNED1 phonealt5qualifier_Invalid;
    UNSIGNED1 activestarttime_Invalid;
    UNSIGNED1 activeendtime_Invalid;
    UNSIGNED1 servicelevel_Invalid;
    UNSIGNED1 partneraccount_Invalid;
    UNSIGNED1 lastmodifieddate_Invalid;
    UNSIGNED1 recordchange_Invalid;
    UNSIGNED1 oldservicelevel_Invalid;
    UNSIGNED1 textservicelevel_Invalid;
    UNSIGNED1 textservicelevelchange_Invalid;
    UNSIGNED1 version_Invalid;
    UNSIGNED1 npi_Invalid;
    UNSIGNED1 npilocation_Invalid;
    UNSIGNED1 specialitytype1_Invalid;
    UNSIGNED1 specialitytype2_Invalid;
    UNSIGNED1 specialitytype3_Invalid;
    UNSIGNED1 specialitytype4_Invalid;
    UNSIGNED1 fileid_Invalid;
    UNSIGNED1 medicarenumber_Invalid;
    UNSIGNED1 medicaidnumber_Invalid;
    UNSIGNED1 dentistlicensenumber_Invalid;
    UNSIGNED1 upin_Invalid;
    UNSIGNED1 pponumber_Invalid;
    UNSIGNED1 socialsecurity_Invalid;
    UNSIGNED1 priorauthorization_Invalid;
    UNSIGNED1 mutuallydefined_Invalid;
    UNSIGNED1 instorencpdpid_Invalid;
    UNSIGNED1 spec_code_Invalid;
    UNSIGNED1 spec_desc_Invalid;
    UNSIGNED1 activity_code_Invalid;
    UNSIGNED1 practice_type_code_Invalid;
    UNSIGNED1 practice_type_desc_Invalid;
    UNSIGNED1 taxonomy_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 source_rid_Invalid;
    UNSIGNED1 lnpid_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 nid_Invalid;
    UNSIGNED1 clean_clinic_name_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(SureScripts_Layout_SureScripts)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(SureScripts_Layout_SureScripts) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := SureScripts_Fields.InValid_did((SALT31.StrType)le.did);
    SELF.did_score_Invalid := SureScripts_Fields.InValid_did_score((SALT31.StrType)le.did_score);
    SELF.bdid_Invalid := SureScripts_Fields.InValid_bdid((SALT31.StrType)le.bdid);
    SELF.bdid_score_Invalid := SureScripts_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score);
    SELF.best_dob_Invalid := SureScripts_Fields.InValid_best_dob((SALT31.StrType)le.best_dob);
    SELF.best_ssn_Invalid := SureScripts_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn);
    SELF.spi_Invalid := SureScripts_Fields.InValid_spi((SALT31.StrType)le.spi);
    SELF.dea_Invalid := SureScripts_Fields.InValid_dea((SALT31.StrType)le.dea);
    SELF.statelicensenumber_Invalid := SureScripts_Fields.InValid_statelicensenumber((SALT31.StrType)le.statelicensenumber);
    SELF.specialtycodeprimary_Invalid := SureScripts_Fields.InValid_specialtycodeprimary((SALT31.StrType)le.specialtycodeprimary);
    SELF.prefixname_Invalid := SureScripts_Fields.InValid_prefixname((SALT31.StrType)le.prefixname);
    SELF.lastname_Invalid := SureScripts_Fields.InValid_lastname((SALT31.StrType)le.lastname);
    SELF.firstname_Invalid := SureScripts_Fields.InValid_firstname((SALT31.StrType)le.firstname);
    SELF.middlename_Invalid := SureScripts_Fields.InValid_middlename((SALT31.StrType)le.middlename);
    SELF.suffixname_Invalid := SureScripts_Fields.InValid_suffixname((SALT31.StrType)le.suffixname);
    SELF.clinicname_Invalid := SureScripts_Fields.InValid_clinicname((SALT31.StrType)le.clinicname);
    SELF.addressline1_Invalid := SureScripts_Fields.InValid_addressline1((SALT31.StrType)le.addressline1);
    SELF.addressline2_Invalid := SureScripts_Fields.InValid_addressline2((SALT31.StrType)le.addressline2);
    SELF.city_Invalid := SureScripts_Fields.InValid_city((SALT31.StrType)le.city);
    SELF.state_Invalid := SureScripts_Fields.InValid_state((SALT31.StrType)le.state);
    SELF.zipcode_Invalid := SureScripts_Fields.InValid_zipcode((SALT31.StrType)le.zipcode);
    SELF.phoneprimary_Invalid := SureScripts_Fields.InValid_phoneprimary((SALT31.StrType)le.phoneprimary);
    SELF.fax_Invalid := SureScripts_Fields.InValid_fax((SALT31.StrType)le.fax);
    SELF.email_Invalid := SureScripts_Fields.InValid_email((SALT31.StrType)le.email);
    SELF.phonealt1_Invalid := SureScripts_Fields.InValid_phonealt1((SALT31.StrType)le.phonealt1);
    SELF.phonealt1qualifier_Invalid := SureScripts_Fields.InValid_phonealt1qualifier((SALT31.StrType)le.phonealt1qualifier);
    SELF.phonealt2_Invalid := SureScripts_Fields.InValid_phonealt2((SALT31.StrType)le.phonealt2);
    SELF.phonealt2qualifier_Invalid := SureScripts_Fields.InValid_phonealt2qualifier((SALT31.StrType)le.phonealt2qualifier);
    SELF.phonealt3_Invalid := SureScripts_Fields.InValid_phonealt3((SALT31.StrType)le.phonealt3);
    SELF.phonealt3qualifier_Invalid := SureScripts_Fields.InValid_phonealt3qualifier((SALT31.StrType)le.phonealt3qualifier);
    SELF.phonealt4_Invalid := SureScripts_Fields.InValid_phonealt4((SALT31.StrType)le.phonealt4);
    SELF.phonealt4qualifier_Invalid := SureScripts_Fields.InValid_phonealt4qualifier((SALT31.StrType)le.phonealt4qualifier);
    SELF.phonealt5_Invalid := SureScripts_Fields.InValid_phonealt5((SALT31.StrType)le.phonealt5);
    SELF.phonealt5qualifier_Invalid := SureScripts_Fields.InValid_phonealt5qualifier((SALT31.StrType)le.phonealt5qualifier);
    SELF.activestarttime_Invalid := SureScripts_Fields.InValid_activestarttime((SALT31.StrType)le.activestarttime);
    SELF.activeendtime_Invalid := SureScripts_Fields.InValid_activeendtime((SALT31.StrType)le.activeendtime);
    SELF.servicelevel_Invalid := SureScripts_Fields.InValid_servicelevel((SALT31.StrType)le.servicelevel);
    SELF.partneraccount_Invalid := SureScripts_Fields.InValid_partneraccount((SALT31.StrType)le.partneraccount);
    SELF.lastmodifieddate_Invalid := SureScripts_Fields.InValid_lastmodifieddate((SALT31.StrType)le.lastmodifieddate);
    SELF.recordchange_Invalid := SureScripts_Fields.InValid_recordchange((SALT31.StrType)le.recordchange);
    SELF.oldservicelevel_Invalid := SureScripts_Fields.InValid_oldservicelevel((SALT31.StrType)le.oldservicelevel);
    SELF.textservicelevel_Invalid := SureScripts_Fields.InValid_textservicelevel((SALT31.StrType)le.textservicelevel);
    SELF.textservicelevelchange_Invalid := SureScripts_Fields.InValid_textservicelevelchange((SALT31.StrType)le.textservicelevelchange);
    SELF.version_Invalid := SureScripts_Fields.InValid_version((SALT31.StrType)le.version);
    SELF.npi_Invalid := SureScripts_Fields.InValid_npi((SALT31.StrType)le.npi);
    SELF.npilocation_Invalid := SureScripts_Fields.InValid_npilocation((SALT31.StrType)le.npilocation);
    SELF.specialitytype1_Invalid := SureScripts_Fields.InValid_specialitytype1((SALT31.StrType)le.specialitytype1);
    SELF.specialitytype2_Invalid := SureScripts_Fields.InValid_specialitytype2((SALT31.StrType)le.specialitytype2);
    SELF.specialitytype3_Invalid := SureScripts_Fields.InValid_specialitytype3((SALT31.StrType)le.specialitytype3);
    SELF.specialitytype4_Invalid := SureScripts_Fields.InValid_specialitytype4((SALT31.StrType)le.specialitytype4);
    SELF.fileid_Invalid := SureScripts_Fields.InValid_fileid((SALT31.StrType)le.fileid);
    SELF.medicarenumber_Invalid := SureScripts_Fields.InValid_medicarenumber((SALT31.StrType)le.medicarenumber);
    SELF.medicaidnumber_Invalid := SureScripts_Fields.InValid_medicaidnumber((SALT31.StrType)le.medicaidnumber);
    SELF.dentistlicensenumber_Invalid := SureScripts_Fields.InValid_dentistlicensenumber((SALT31.StrType)le.dentistlicensenumber);
    SELF.upin_Invalid := SureScripts_Fields.InValid_upin((SALT31.StrType)le.upin);
    SELF.pponumber_Invalid := SureScripts_Fields.InValid_pponumber((SALT31.StrType)le.pponumber);
    SELF.socialsecurity_Invalid := SureScripts_Fields.InValid_socialsecurity((SALT31.StrType)le.socialsecurity);
    SELF.priorauthorization_Invalid := SureScripts_Fields.InValid_priorauthorization((SALT31.StrType)le.priorauthorization);
    SELF.mutuallydefined_Invalid := SureScripts_Fields.InValid_mutuallydefined((SALT31.StrType)le.mutuallydefined);
    SELF.instorencpdpid_Invalid := SureScripts_Fields.InValid_instorencpdpid((SALT31.StrType)le.instorencpdpid);
    SELF.spec_code_Invalid := SureScripts_Fields.InValid_spec_code((SALT31.StrType)le.spec_code);
    SELF.spec_desc_Invalid := SureScripts_Fields.InValid_spec_desc((SALT31.StrType)le.spec_desc);
    SELF.activity_code_Invalid := SureScripts_Fields.InValid_activity_code((SALT31.StrType)le.activity_code);
    SELF.practice_type_code_Invalid := SureScripts_Fields.InValid_practice_type_code((SALT31.StrType)le.practice_type_code);
    SELF.practice_type_desc_Invalid := SureScripts_Fields.InValid_practice_type_desc((SALT31.StrType)le.practice_type_desc);
    SELF.taxonomy_Invalid := SureScripts_Fields.InValid_taxonomy((SALT31.StrType)le.taxonomy);
    SELF.src_Invalid := SureScripts_Fields.InValid_src((SALT31.StrType)le.src);
    SELF.dt_vendor_first_reported_Invalid := SureScripts_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := SureScripts_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := SureScripts_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := SureScripts_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen);
    SELF.record_type_Invalid := SureScripts_Fields.InValid_record_type((SALT31.StrType)le.record_type);
    SELF.source_rid_Invalid := SureScripts_Fields.InValid_source_rid((SALT31.StrType)le.source_rid);
    SELF.lnpid_Invalid := SureScripts_Fields.InValid_lnpid((SALT31.StrType)le.lnpid);
    SELF.title_Invalid := SureScripts_Fields.InValid_title((SALT31.StrType)le.title);
    SELF.fname_Invalid := SureScripts_Fields.InValid_fname((SALT31.StrType)le.fname);
    SELF.mname_Invalid := SureScripts_Fields.InValid_mname((SALT31.StrType)le.mname);
    SELF.lname_Invalid := SureScripts_Fields.InValid_lname((SALT31.StrType)le.lname);
    SELF.name_suffix_Invalid := SureScripts_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix);
    SELF.name_type_Invalid := SureScripts_Fields.InValid_name_type((SALT31.StrType)le.name_type);
    SELF.nid_Invalid := SureScripts_Fields.InValid_nid((SALT31.StrType)le.nid);
    SELF.clean_clinic_name_Invalid := SureScripts_Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name);
    SELF.prepped_addr1_Invalid := SureScripts_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1);
    SELF.prepped_addr2_Invalid := SureScripts_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2);
    SELF.prim_range_Invalid := SureScripts_Fields.InValid_prim_range((SALT31.StrType)le.prim_range);
    SELF.predir_Invalid := SureScripts_Fields.InValid_predir((SALT31.StrType)le.predir);
    SELF.prim_name_Invalid := SureScripts_Fields.InValid_prim_name((SALT31.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := SureScripts_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix);
    SELF.postdir_Invalid := SureScripts_Fields.InValid_postdir((SALT31.StrType)le.postdir);
    SELF.unit_desig_Invalid := SureScripts_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig);
    SELF.sec_range_Invalid := SureScripts_Fields.InValid_sec_range((SALT31.StrType)le.sec_range);
    SELF.p_city_name_Invalid := SureScripts_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := SureScripts_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name);
    SELF.st_Invalid := SureScripts_Fields.InValid_st((SALT31.StrType)le.st);
    SELF.zip_Invalid := SureScripts_Fields.InValid_zip((SALT31.StrType)le.zip);
    SELF.zip4_Invalid := SureScripts_Fields.InValid_zip4((SALT31.StrType)le.zip4);
    SELF.cart_Invalid := SureScripts_Fields.InValid_cart((SALT31.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := SureScripts_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := SureScripts_Fields.InValid_lot((SALT31.StrType)le.lot);
    SELF.lot_order_Invalid := SureScripts_Fields.InValid_lot_order((SALT31.StrType)le.lot_order);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.did_Invalid << 0 ) + ( le.did_score_Invalid << 2 ) + ( le.bdid_Invalid << 4 ) + ( le.bdid_score_Invalid << 6 ) + ( le.best_dob_Invalid << 8 ) + ( le.best_ssn_Invalid << 10 ) + ( le.spi_Invalid << 12 ) + ( le.dea_Invalid << 14 ) + ( le.statelicensenumber_Invalid << 16 ) + ( le.specialtycodeprimary_Invalid << 18 ) + ( le.prefixname_Invalid << 20 ) + ( le.lastname_Invalid << 22 ) + ( le.firstname_Invalid << 24 ) + ( le.middlename_Invalid << 26 ) + ( le.suffixname_Invalid << 28 ) + ( le.clinicname_Invalid << 30 ) + ( le.addressline1_Invalid << 32 ) + ( le.addressline2_Invalid << 34 ) + ( le.city_Invalid << 36 ) + ( le.state_Invalid << 38 ) + ( le.zipcode_Invalid << 40 ) + ( le.phoneprimary_Invalid << 42 ) + ( le.fax_Invalid << 44 ) + ( le.email_Invalid << 46 ) + ( le.phonealt1_Invalid << 48 ) + ( le.phonealt1qualifier_Invalid << 50 ) + ( le.phonealt2_Invalid << 52 ) + ( le.phonealt2qualifier_Invalid << 54 ) + ( le.phonealt3_Invalid << 56 ) + ( le.phonealt3qualifier_Invalid << 58 ) + ( le.phonealt4_Invalid << 60 ) + ( le.phonealt4qualifier_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.phonealt5_Invalid << 0 ) + ( le.phonealt5qualifier_Invalid << 2 ) + ( le.activestarttime_Invalid << 4 ) + ( le.activeendtime_Invalid << 6 ) + ( le.servicelevel_Invalid << 8 ) + ( le.partneraccount_Invalid << 10 ) + ( le.lastmodifieddate_Invalid << 12 ) + ( le.recordchange_Invalid << 14 ) + ( le.oldservicelevel_Invalid << 16 ) + ( le.textservicelevel_Invalid << 18 ) + ( le.textservicelevelchange_Invalid << 20 ) + ( le.version_Invalid << 22 ) + ( le.npi_Invalid << 24 ) + ( le.npilocation_Invalid << 26 ) + ( le.specialitytype1_Invalid << 28 ) + ( le.specialitytype2_Invalid << 30 ) + ( le.specialitytype3_Invalid << 32 ) + ( le.specialitytype4_Invalid << 34 ) + ( le.fileid_Invalid << 36 ) + ( le.medicarenumber_Invalid << 38 ) + ( le.medicaidnumber_Invalid << 40 ) + ( le.dentistlicensenumber_Invalid << 42 ) + ( le.upin_Invalid << 44 ) + ( le.pponumber_Invalid << 46 ) + ( le.socialsecurity_Invalid << 48 ) + ( le.priorauthorization_Invalid << 50 ) + ( le.mutuallydefined_Invalid << 52 ) + ( le.instorencpdpid_Invalid << 54 ) + ( le.spec_code_Invalid << 57 ) + ( le.spec_desc_Invalid << 59 ) + ( le.activity_code_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.practice_type_code_Invalid << 0 ) + ( le.practice_type_desc_Invalid << 2 ) + ( le.taxonomy_Invalid << 4 ) + ( le.src_Invalid << 6 ) + ( le.dt_vendor_first_reported_Invalid << 8 ) + ( le.dt_vendor_last_reported_Invalid << 10 ) + ( le.dt_first_seen_Invalid << 12 ) + ( le.dt_last_seen_Invalid << 14 ) + ( le.record_type_Invalid << 16 ) + ( le.source_rid_Invalid << 18 ) + ( le.lnpid_Invalid << 20 ) + ( le.title_Invalid << 22 ) + ( le.fname_Invalid << 24 ) + ( le.mname_Invalid << 26 ) + ( le.lname_Invalid << 28 ) + ( le.name_suffix_Invalid << 30 ) + ( le.name_type_Invalid << 32 ) + ( le.nid_Invalid << 34 ) + ( le.clean_clinic_name_Invalid << 36 ) + ( le.prepped_addr1_Invalid << 38 ) + ( le.prepped_addr2_Invalid << 40 ) + ( le.prim_range_Invalid << 42 ) + ( le.predir_Invalid << 44 ) + ( le.prim_name_Invalid << 46 ) + ( le.addr_suffix_Invalid << 48 ) + ( le.postdir_Invalid << 50 ) + ( le.unit_desig_Invalid << 52 ) + ( le.sec_range_Invalid << 54 ) + ( le.p_city_name_Invalid << 56 ) + ( le.v_city_name_Invalid << 58 ) + ( le.st_Invalid << 60 ) + ( le.zip_Invalid << 62 );
    SELF.ScrubsBits4 := ( le.zip4_Invalid << 0 ) + ( le.cart_Invalid << 2 ) + ( le.cr_sort_sz_Invalid << 4 ) + ( le.lot_Invalid << 6 ) + ( le.lot_order_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,SureScripts_Layout_SureScripts);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.best_dob_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.spi_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.dea_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.statelicensenumber_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.specialtycodeprimary_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.prefixname_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.middlename_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.suffixname_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.clinicname_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.addressline1_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.addressline2_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.phoneprimary_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.fax_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.email_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.phonealt1_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.phonealt1qualifier_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.phonealt2_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.phonealt2qualifier_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.phonealt3_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.phonealt3qualifier_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.phonealt4_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.phonealt4qualifier_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.phonealt5_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.phonealt5qualifier_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.activestarttime_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.activeendtime_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.servicelevel_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.partneraccount_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.lastmodifieddate_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.recordchange_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.oldservicelevel_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.textservicelevel_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.textservicelevelchange_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.version_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.npi_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.npilocation_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.specialitytype1_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.specialitytype2_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.specialitytype3_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.specialitytype4_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.fileid_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.medicarenumber_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.medicaidnumber_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.dentistlicensenumber_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.upin_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.pponumber_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.socialsecurity_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.priorauthorization_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.mutuallydefined_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.instorencpdpid_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.spec_code_Invalid := (le.ScrubsBits2 >> 57) & 3;
    SELF.spec_desc_Invalid := (le.ScrubsBits2 >> 59) & 3;
    SELF.activity_code_Invalid := (le.ScrubsBits2 >> 61) & 3;
    SELF.practice_type_code_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.practice_type_desc_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.taxonomy_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.src_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.record_type_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.source_rid_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.lnpid_Invalid := (le.ScrubsBits3 >> 20) & 3;
    SELF.title_Invalid := (le.ScrubsBits3 >> 22) & 3;
    SELF.fname_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.mname_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.lname_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits3 >> 30) & 3;
    SELF.name_type_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.nid_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.clean_clinic_name_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits3 >> 40) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 42) & 3;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 44) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 46) & 3;
    SELF.addr_suffix_Invalid := (le.ScrubsBits3 >> 48) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 50) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits3 >> 52) & 3;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 54) & 3;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 56) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits3 >> 58) & 3;
    SELF.st_Invalid := (le.ScrubsBits3 >> 60) & 3;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 62) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.cart_Invalid := (le.ScrubsBits4 >> 2) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.lot_Invalid := (le.ScrubsBits4 >> 6) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits4 >> 8) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=2);
    did_score_Total_ErrorCount := COUNT(GROUP,h.did_score_Invalid>0);
    bdid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    bdid_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=2);
    bdid_score_Total_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid>0);
    best_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=1);
    best_dob_ALLOW_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=2);
    best_dob_Total_ErrorCount := COUNT(GROUP,h.best_dob_Invalid>0);
    best_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    spi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.spi_Invalid=1);
    spi_ALLOW_ErrorCount := COUNT(GROUP,h.spi_Invalid=2);
    spi_Total_ErrorCount := COUNT(GROUP,h.spi_Invalid>0);
    dea_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_Invalid=1);
    dea_ALLOW_ErrorCount := COUNT(GROUP,h.dea_Invalid=2);
    dea_Total_ErrorCount := COUNT(GROUP,h.dea_Invalid>0);
    statelicensenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=1);
    statelicensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid=2);
    statelicensenumber_Total_ErrorCount := COUNT(GROUP,h.statelicensenumber_Invalid>0);
    specialtycodeprimary_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=1);
    specialtycodeprimary_ALLOW_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid=2);
    specialtycodeprimary_Total_ErrorCount := COUNT(GROUP,h.specialtycodeprimary_Invalid>0);
    prefixname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=1);
    prefixname_ALLOW_ErrorCount := COUNT(GROUP,h.prefixname_Invalid=2);
    prefixname_Total_ErrorCount := COUNT(GROUP,h.prefixname_Invalid>0);
    lastname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    firstname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=2);
    firstname_Total_ErrorCount := COUNT(GROUP,h.firstname_Invalid>0);
    middlename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    middlename_ALLOW_ErrorCount := COUNT(GROUP,h.middlename_Invalid=2);
    middlename_Total_ErrorCount := COUNT(GROUP,h.middlename_Invalid>0);
    suffixname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=1);
    suffixname_ALLOW_ErrorCount := COUNT(GROUP,h.suffixname_Invalid=2);
    suffixname_Total_ErrorCount := COUNT(GROUP,h.suffixname_Invalid>0);
    clinicname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clinicname_Invalid=1);
    clinicname_ALLOW_ErrorCount := COUNT(GROUP,h.clinicname_Invalid=2);
    clinicname_Total_ErrorCount := COUNT(GROUP,h.clinicname_Invalid>0);
    addressline1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=1);
    addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=2);
    addressline1_Total_ErrorCount := COUNT(GROUP,h.addressline1_Invalid>0);
    addressline2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=1);
    addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=2);
    addressline2_Total_ErrorCount := COUNT(GROUP,h.addressline2_Invalid>0);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    phoneprimary_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=1);
    phoneprimary_ALLOW_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid=2);
    phoneprimary_Total_ErrorCount := COUNT(GROUP,h.phoneprimary_Invalid>0);
    fax_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax_Invalid=1);
    fax_ALLOW_ErrorCount := COUNT(GROUP,h.fax_Invalid=2);
    fax_Total_ErrorCount := COUNT(GROUP,h.fax_Invalid>0);
    email_LEFTTRIM_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=2);
    email_Total_ErrorCount := COUNT(GROUP,h.email_Invalid>0);
    phonealt1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=1);
    phonealt1_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid=2);
    phonealt1_Total_ErrorCount := COUNT(GROUP,h.phonealt1_Invalid>0);
    phonealt1qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=1);
    phonealt1qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid=2);
    phonealt1qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt1qualifier_Invalid>0);
    phonealt2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=1);
    phonealt2_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid=2);
    phonealt2_Total_ErrorCount := COUNT(GROUP,h.phonealt2_Invalid>0);
    phonealt2qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=1);
    phonealt2qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid=2);
    phonealt2qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt2qualifier_Invalid>0);
    phonealt3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=1);
    phonealt3_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid=2);
    phonealt3_Total_ErrorCount := COUNT(GROUP,h.phonealt3_Invalid>0);
    phonealt3qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=1);
    phonealt3qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid=2);
    phonealt3qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt3qualifier_Invalid>0);
    phonealt4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=1);
    phonealt4_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid=2);
    phonealt4_Total_ErrorCount := COUNT(GROUP,h.phonealt4_Invalid>0);
    phonealt4qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=1);
    phonealt4qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid=2);
    phonealt4qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt4qualifier_Invalid>0);
    phonealt5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=1);
    phonealt5_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid=2);
    phonealt5_Total_ErrorCount := COUNT(GROUP,h.phonealt5_Invalid>0);
    phonealt5qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=1);
    phonealt5qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid=2);
    phonealt5qualifier_Total_ErrorCount := COUNT(GROUP,h.phonealt5qualifier_Invalid>0);
    activestarttime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=1);
    activestarttime_ALLOW_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid=2);
    activestarttime_Total_ErrorCount := COUNT(GROUP,h.activestarttime_Invalid>0);
    activeendtime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=1);
    activeendtime_ALLOW_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid=2);
    activeendtime_Total_ErrorCount := COUNT(GROUP,h.activeendtime_Invalid>0);
    servicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=1);
    servicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid=2);
    servicelevel_Total_ErrorCount := COUNT(GROUP,h.servicelevel_Invalid>0);
    partneraccount_LEFTTRIM_ErrorCount := COUNT(GROUP,h.partneraccount_Invalid=1);
    partneraccount_ALLOW_ErrorCount := COUNT(GROUP,h.partneraccount_Invalid=2);
    partneraccount_Total_ErrorCount := COUNT(GROUP,h.partneraccount_Invalid>0);
    lastmodifieddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=1);
    lastmodifieddate_ALLOW_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid=2);
    lastmodifieddate_Total_ErrorCount := COUNT(GROUP,h.lastmodifieddate_Invalid>0);
    recordchange_LEFTTRIM_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=1);
    recordchange_ALLOW_ErrorCount := COUNT(GROUP,h.recordchange_Invalid=2);
    recordchange_Total_ErrorCount := COUNT(GROUP,h.recordchange_Invalid>0);
    oldservicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=1);
    oldservicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid=2);
    oldservicelevel_Total_ErrorCount := COUNT(GROUP,h.oldservicelevel_Invalid>0);
    textservicelevel_LEFTTRIM_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=1);
    textservicelevel_ALLOW_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid=2);
    textservicelevel_Total_ErrorCount := COUNT(GROUP,h.textservicelevel_Invalid>0);
    textservicelevelchange_LEFTTRIM_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=1);
    textservicelevelchange_ALLOW_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid=2);
    textservicelevelchange_Total_ErrorCount := COUNT(GROUP,h.textservicelevelchange_Invalid>0);
    version_LEFTTRIM_ErrorCount := COUNT(GROUP,h.version_Invalid=1);
    version_ALLOW_ErrorCount := COUNT(GROUP,h.version_Invalid=2);
    version_Total_ErrorCount := COUNT(GROUP,h.version_Invalid>0);
    npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_Invalid=1);
    npi_ALLOW_ErrorCount := COUNT(GROUP,h.npi_Invalid=2);
    npi_Total_ErrorCount := COUNT(GROUP,h.npi_Invalid>0);
    npilocation_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=1);
    npilocation_ALLOW_ErrorCount := COUNT(GROUP,h.npilocation_Invalid=2);
    npilocation_Total_ErrorCount := COUNT(GROUP,h.npilocation_Invalid>0);
    specialitytype1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=1);
    specialitytype1_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid=2);
    specialitytype1_Total_ErrorCount := COUNT(GROUP,h.specialitytype1_Invalid>0);
    specialitytype2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=1);
    specialitytype2_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid=2);
    specialitytype2_Total_ErrorCount := COUNT(GROUP,h.specialitytype2_Invalid>0);
    specialitytype3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=1);
    specialitytype3_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid=2);
    specialitytype3_Total_ErrorCount := COUNT(GROUP,h.specialitytype3_Invalid>0);
    specialitytype4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=1);
    specialitytype4_ALLOW_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid=2);
    specialitytype4_Total_ErrorCount := COUNT(GROUP,h.specialitytype4_Invalid>0);
    fileid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fileid_Invalid=1);
    fileid_ALLOW_ErrorCount := COUNT(GROUP,h.fileid_Invalid=2);
    fileid_Total_ErrorCount := COUNT(GROUP,h.fileid_Invalid>0);
    medicarenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=1);
    medicarenumber_ALLOW_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid=2);
    medicarenumber_Total_ErrorCount := COUNT(GROUP,h.medicarenumber_Invalid>0);
    medicaidnumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=1);
    medicaidnumber_ALLOW_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid=2);
    medicaidnumber_Total_ErrorCount := COUNT(GROUP,h.medicaidnumber_Invalid>0);
    dentistlicensenumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=1);
    dentistlicensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid=2);
    dentistlicensenumber_Total_ErrorCount := COUNT(GROUP,h.dentistlicensenumber_Invalid>0);
    upin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.upin_Invalid=1);
    upin_ALLOW_ErrorCount := COUNT(GROUP,h.upin_Invalid=2);
    upin_Total_ErrorCount := COUNT(GROUP,h.upin_Invalid>0);
    pponumber_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=1);
    pponumber_ALLOW_ErrorCount := COUNT(GROUP,h.pponumber_Invalid=2);
    pponumber_Total_ErrorCount := COUNT(GROUP,h.pponumber_Invalid>0);
    socialsecurity_LEFTTRIM_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=1);
    socialsecurity_ALLOW_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid=2);
    socialsecurity_Total_ErrorCount := COUNT(GROUP,h.socialsecurity_Invalid>0);
    priorauthorization_LEFTTRIM_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=1);
    priorauthorization_ALLOW_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid=2);
    priorauthorization_Total_ErrorCount := COUNT(GROUP,h.priorauthorization_Invalid>0);
    mutuallydefined_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=1);
    mutuallydefined_ALLOW_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid=2);
    mutuallydefined_Total_ErrorCount := COUNT(GROUP,h.mutuallydefined_Invalid>0);
    instorencpdpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=1);
    instorencpdpid_ALLOW_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=2);
    instorencpdpid_LENGTH_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=3);
    instorencpdpid_WORDS_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid=4);
    instorencpdpid_Total_ErrorCount := COUNT(GROUP,h.instorencpdpid_Invalid>0);
    spec_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.spec_code_Invalid=1);
    spec_code_ALLOW_ErrorCount := COUNT(GROUP,h.spec_code_Invalid=2);
    spec_code_Total_ErrorCount := COUNT(GROUP,h.spec_code_Invalid>0);
    spec_desc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.spec_desc_Invalid=1);
    spec_desc_ALLOW_ErrorCount := COUNT(GROUP,h.spec_desc_Invalid=2);
    spec_desc_Total_ErrorCount := COUNT(GROUP,h.spec_desc_Invalid>0);
    activity_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.activity_code_Invalid=1);
    activity_code_ALLOW_ErrorCount := COUNT(GROUP,h.activity_code_Invalid=2);
    activity_code_Total_ErrorCount := COUNT(GROUP,h.activity_code_Invalid>0);
    practice_type_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.practice_type_code_Invalid=1);
    practice_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.practice_type_code_Invalid=2);
    practice_type_code_Total_ErrorCount := COUNT(GROUP,h.practice_type_code_Invalid>0);
    practice_type_desc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.practice_type_desc_Invalid=1);
    practice_type_desc_ALLOW_ErrorCount := COUNT(GROUP,h.practice_type_desc_Invalid=2);
    practice_type_desc_Total_ErrorCount := COUNT(GROUP,h.practice_type_desc_Invalid>0);
    taxonomy_LEFTTRIM_ErrorCount := COUNT(GROUP,h.taxonomy_Invalid=1);
    taxonomy_ALLOW_ErrorCount := COUNT(GROUP,h.taxonomy_Invalid=2);
    taxonomy_Total_ErrorCount := COUNT(GROUP,h.taxonomy_Invalid>0);
    src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    record_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=2);
    record_type_Total_ErrorCount := COUNT(GROUP,h.record_type_Invalid>0);
    source_rid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=1);
    source_rid_ALLOW_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=2);
    source_rid_Total_ErrorCount := COUNT(GROUP,h.source_rid_Invalid>0);
    lnpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=2);
    lnpid_Total_ErrorCount := COUNT(GROUP,h.lnpid_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    name_type_ALLOW_ErrorCount := COUNT(GROUP,h.name_type_Invalid=2);
    name_type_Total_ErrorCount := COUNT(GROUP,h.name_type_Invalid>0);
    nid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nid_Invalid=1);
    nid_ALLOW_ErrorCount := COUNT(GROUP,h.nid_Invalid=2);
    nid_Total_ErrorCount := COUNT(GROUP,h.nid_Invalid>0);
    clean_clinic_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=1);
    clean_clinic_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=2);
    clean_clinic_name_Total_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.did_Invalid,le.did_score_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.best_dob_Invalid,le.best_ssn_Invalid,le.spi_Invalid,le.dea_Invalid,le.statelicensenumber_Invalid,le.specialtycodeprimary_Invalid,le.prefixname_Invalid,le.lastname_Invalid,le.firstname_Invalid,le.middlename_Invalid,le.suffixname_Invalid,le.clinicname_Invalid,le.addressline1_Invalid,le.addressline2_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.phoneprimary_Invalid,le.fax_Invalid,le.email_Invalid,le.phonealt1_Invalid,le.phonealt1qualifier_Invalid,le.phonealt2_Invalid,le.phonealt2qualifier_Invalid,le.phonealt3_Invalid,le.phonealt3qualifier_Invalid,le.phonealt4_Invalid,le.phonealt4qualifier_Invalid,le.phonealt5_Invalid,le.phonealt5qualifier_Invalid,le.activestarttime_Invalid,le.activeendtime_Invalid,le.servicelevel_Invalid,le.partneraccount_Invalid,le.lastmodifieddate_Invalid,le.recordchange_Invalid,le.oldservicelevel_Invalid,le.textservicelevel_Invalid,le.textservicelevelchange_Invalid,le.version_Invalid,le.npi_Invalid,le.npilocation_Invalid,le.specialitytype1_Invalid,le.specialitytype2_Invalid,le.specialitytype3_Invalid,le.specialitytype4_Invalid,le.fileid_Invalid,le.medicarenumber_Invalid,le.medicaidnumber_Invalid,le.dentistlicensenumber_Invalid,le.upin_Invalid,le.pponumber_Invalid,le.socialsecurity_Invalid,le.priorauthorization_Invalid,le.mutuallydefined_Invalid,le.instorencpdpid_Invalid,le.spec_code_Invalid,le.spec_desc_Invalid,le.activity_code_Invalid,le.practice_type_code_Invalid,le.practice_type_desc_Invalid,le.taxonomy_Invalid,le.src_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.record_type_Invalid,le.source_rid_Invalid,le.lnpid_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_type_Invalid,le.nid_Invalid,le.clean_clinic_name_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,SureScripts_Fields.InvalidMessage_did(le.did_Invalid),SureScripts_Fields.InvalidMessage_did_score(le.did_score_Invalid),SureScripts_Fields.InvalidMessage_bdid(le.bdid_Invalid),SureScripts_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),SureScripts_Fields.InvalidMessage_best_dob(le.best_dob_Invalid),SureScripts_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),SureScripts_Fields.InvalidMessage_spi(le.spi_Invalid),SureScripts_Fields.InvalidMessage_dea(le.dea_Invalid),SureScripts_Fields.InvalidMessage_statelicensenumber(le.statelicensenumber_Invalid),SureScripts_Fields.InvalidMessage_specialtycodeprimary(le.specialtycodeprimary_Invalid),SureScripts_Fields.InvalidMessage_prefixname(le.prefixname_Invalid),SureScripts_Fields.InvalidMessage_lastname(le.lastname_Invalid),SureScripts_Fields.InvalidMessage_firstname(le.firstname_Invalid),SureScripts_Fields.InvalidMessage_middlename(le.middlename_Invalid),SureScripts_Fields.InvalidMessage_suffixname(le.suffixname_Invalid),SureScripts_Fields.InvalidMessage_clinicname(le.clinicname_Invalid),SureScripts_Fields.InvalidMessage_addressline1(le.addressline1_Invalid),SureScripts_Fields.InvalidMessage_addressline2(le.addressline2_Invalid),SureScripts_Fields.InvalidMessage_city(le.city_Invalid),SureScripts_Fields.InvalidMessage_state(le.state_Invalid),SureScripts_Fields.InvalidMessage_zipcode(le.zipcode_Invalid),SureScripts_Fields.InvalidMessage_phoneprimary(le.phoneprimary_Invalid),SureScripts_Fields.InvalidMessage_fax(le.fax_Invalid),SureScripts_Fields.InvalidMessage_email(le.email_Invalid),SureScripts_Fields.InvalidMessage_phonealt1(le.phonealt1_Invalid),SureScripts_Fields.InvalidMessage_phonealt1qualifier(le.phonealt1qualifier_Invalid),SureScripts_Fields.InvalidMessage_phonealt2(le.phonealt2_Invalid),SureScripts_Fields.InvalidMessage_phonealt2qualifier(le.phonealt2qualifier_Invalid),SureScripts_Fields.InvalidMessage_phonealt3(le.phonealt3_Invalid),SureScripts_Fields.InvalidMessage_phonealt3qualifier(le.phonealt3qualifier_Invalid),SureScripts_Fields.InvalidMessage_phonealt4(le.phonealt4_Invalid),SureScripts_Fields.InvalidMessage_phonealt4qualifier(le.phonealt4qualifier_Invalid),SureScripts_Fields.InvalidMessage_phonealt5(le.phonealt5_Invalid),SureScripts_Fields.InvalidMessage_phonealt5qualifier(le.phonealt5qualifier_Invalid),SureScripts_Fields.InvalidMessage_activestarttime(le.activestarttime_Invalid),SureScripts_Fields.InvalidMessage_activeendtime(le.activeendtime_Invalid),SureScripts_Fields.InvalidMessage_servicelevel(le.servicelevel_Invalid),SureScripts_Fields.InvalidMessage_partneraccount(le.partneraccount_Invalid),SureScripts_Fields.InvalidMessage_lastmodifieddate(le.lastmodifieddate_Invalid),SureScripts_Fields.InvalidMessage_recordchange(le.recordchange_Invalid),SureScripts_Fields.InvalidMessage_oldservicelevel(le.oldservicelevel_Invalid),SureScripts_Fields.InvalidMessage_textservicelevel(le.textservicelevel_Invalid),SureScripts_Fields.InvalidMessage_textservicelevelchange(le.textservicelevelchange_Invalid),SureScripts_Fields.InvalidMessage_version(le.version_Invalid),SureScripts_Fields.InvalidMessage_npi(le.npi_Invalid),SureScripts_Fields.InvalidMessage_npilocation(le.npilocation_Invalid),SureScripts_Fields.InvalidMessage_specialitytype1(le.specialitytype1_Invalid),SureScripts_Fields.InvalidMessage_specialitytype2(le.specialitytype2_Invalid),SureScripts_Fields.InvalidMessage_specialitytype3(le.specialitytype3_Invalid),SureScripts_Fields.InvalidMessage_specialitytype4(le.specialitytype4_Invalid),SureScripts_Fields.InvalidMessage_fileid(le.fileid_Invalid),SureScripts_Fields.InvalidMessage_medicarenumber(le.medicarenumber_Invalid),SureScripts_Fields.InvalidMessage_medicaidnumber(le.medicaidnumber_Invalid),SureScripts_Fields.InvalidMessage_dentistlicensenumber(le.dentistlicensenumber_Invalid),SureScripts_Fields.InvalidMessage_upin(le.upin_Invalid),SureScripts_Fields.InvalidMessage_pponumber(le.pponumber_Invalid),SureScripts_Fields.InvalidMessage_socialsecurity(le.socialsecurity_Invalid),SureScripts_Fields.InvalidMessage_priorauthorization(le.priorauthorization_Invalid),SureScripts_Fields.InvalidMessage_mutuallydefined(le.mutuallydefined_Invalid),SureScripts_Fields.InvalidMessage_instorencpdpid(le.instorencpdpid_Invalid),SureScripts_Fields.InvalidMessage_spec_code(le.spec_code_Invalid),SureScripts_Fields.InvalidMessage_spec_desc(le.spec_desc_Invalid),SureScripts_Fields.InvalidMessage_activity_code(le.activity_code_Invalid),SureScripts_Fields.InvalidMessage_practice_type_code(le.practice_type_code_Invalid),SureScripts_Fields.InvalidMessage_practice_type_desc(le.practice_type_desc_Invalid),SureScripts_Fields.InvalidMessage_taxonomy(le.taxonomy_Invalid),SureScripts_Fields.InvalidMessage_src(le.src_Invalid),SureScripts_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),SureScripts_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),SureScripts_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),SureScripts_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),SureScripts_Fields.InvalidMessage_record_type(le.record_type_Invalid),SureScripts_Fields.InvalidMessage_source_rid(le.source_rid_Invalid),SureScripts_Fields.InvalidMessage_lnpid(le.lnpid_Invalid),SureScripts_Fields.InvalidMessage_title(le.title_Invalid),SureScripts_Fields.InvalidMessage_fname(le.fname_Invalid),SureScripts_Fields.InvalidMessage_mname(le.mname_Invalid),SureScripts_Fields.InvalidMessage_lname(le.lname_Invalid),SureScripts_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),SureScripts_Fields.InvalidMessage_name_type(le.name_type_Invalid),SureScripts_Fields.InvalidMessage_nid(le.nid_Invalid),SureScripts_Fields.InvalidMessage_clean_clinic_name(le.clean_clinic_name_Invalid),SureScripts_Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),SureScripts_Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),SureScripts_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),SureScripts_Fields.InvalidMessage_predir(le.predir_Invalid),SureScripts_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),SureScripts_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),SureScripts_Fields.InvalidMessage_postdir(le.postdir_Invalid),SureScripts_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),SureScripts_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),SureScripts_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),SureScripts_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),SureScripts_Fields.InvalidMessage_st(le.st_Invalid),SureScripts_Fields.InvalidMessage_zip(le.zip_Invalid),SureScripts_Fields.InvalidMessage_zip4(le.zip4_Invalid),SureScripts_Fields.InvalidMessage_cart(le.cart_Invalid),SureScripts_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),SureScripts_Fields.InvalidMessage_lot(le.lot_Invalid),SureScripts_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.best_dob_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.spi_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.statelicensenumber_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialtycodeprimary_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prefixname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.suffixname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clinicname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addressline1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addressline2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phoneprimary_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fax_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt1qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt2qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt3_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt3qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt4qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt5_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phonealt5qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.activestarttime_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.activeendtime_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.servicelevel_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.partneraccount_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lastmodifieddate_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.recordchange_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.oldservicelevel_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.textservicelevel_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.textservicelevelchange_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.version_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npilocation_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialitytype1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialitytype2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialitytype3_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialitytype4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fileid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.medicarenumber_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.medicaidnumber_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dentistlicensenumber_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.upin_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.pponumber_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.socialsecurity_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.priorauthorization_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.mutuallydefined_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.instorencpdpid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.spec_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.spec_desc_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.activity_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.practice_type_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.practice_type_desc_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.taxonomy_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.source_rid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.nid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_clinic_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.did,(SALT31.StrType)le.did_score,(SALT31.StrType)le.bdid,(SALT31.StrType)le.bdid_score,(SALT31.StrType)le.best_dob,(SALT31.StrType)le.best_ssn,(SALT31.StrType)le.spi,(SALT31.StrType)le.dea,(SALT31.StrType)le.statelicensenumber,(SALT31.StrType)le.specialtycodeprimary,(SALT31.StrType)le.prefixname,(SALT31.StrType)le.lastname,(SALT31.StrType)le.firstname,(SALT31.StrType)le.middlename,(SALT31.StrType)le.suffixname,(SALT31.StrType)le.clinicname,(SALT31.StrType)le.addressline1,(SALT31.StrType)le.addressline2,(SALT31.StrType)le.city,(SALT31.StrType)le.state,(SALT31.StrType)le.zipcode,(SALT31.StrType)le.phoneprimary,(SALT31.StrType)le.fax,(SALT31.StrType)le.email,(SALT31.StrType)le.phonealt1,(SALT31.StrType)le.phonealt1qualifier,(SALT31.StrType)le.phonealt2,(SALT31.StrType)le.phonealt2qualifier,(SALT31.StrType)le.phonealt3,(SALT31.StrType)le.phonealt3qualifier,(SALT31.StrType)le.phonealt4,(SALT31.StrType)le.phonealt4qualifier,(SALT31.StrType)le.phonealt5,(SALT31.StrType)le.phonealt5qualifier,(SALT31.StrType)le.activestarttime,(SALT31.StrType)le.activeendtime,(SALT31.StrType)le.servicelevel,(SALT31.StrType)le.partneraccount,(SALT31.StrType)le.lastmodifieddate,(SALT31.StrType)le.recordchange,(SALT31.StrType)le.oldservicelevel,(SALT31.StrType)le.textservicelevel,(SALT31.StrType)le.textservicelevelchange,(SALT31.StrType)le.version,(SALT31.StrType)le.npi,(SALT31.StrType)le.npilocation,(SALT31.StrType)le.specialitytype1,(SALT31.StrType)le.specialitytype2,(SALT31.StrType)le.specialitytype3,(SALT31.StrType)le.specialitytype4,(SALT31.StrType)le.fileid,(SALT31.StrType)le.medicarenumber,(SALT31.StrType)le.medicaidnumber,(SALT31.StrType)le.dentistlicensenumber,(SALT31.StrType)le.upin,(SALT31.StrType)le.pponumber,(SALT31.StrType)le.socialsecurity,(SALT31.StrType)le.priorauthorization,(SALT31.StrType)le.mutuallydefined,(SALT31.StrType)le.instorencpdpid,(SALT31.StrType)le.spec_code,(SALT31.StrType)le.spec_desc,(SALT31.StrType)le.activity_code,(SALT31.StrType)le.practice_type_code,(SALT31.StrType)le.practice_type_desc,(SALT31.StrType)le.taxonomy,(SALT31.StrType)le.src,(SALT31.StrType)le.dt_vendor_first_reported,(SALT31.StrType)le.dt_vendor_last_reported,(SALT31.StrType)le.dt_first_seen,(SALT31.StrType)le.dt_last_seen,(SALT31.StrType)le.record_type,(SALT31.StrType)le.source_rid,(SALT31.StrType)le.lnpid,(SALT31.StrType)le.title,(SALT31.StrType)le.fname,(SALT31.StrType)le.mname,(SALT31.StrType)le.lname,(SALT31.StrType)le.name_suffix,(SALT31.StrType)le.name_type,(SALT31.StrType)le.nid,(SALT31.StrType)le.clean_clinic_name,(SALT31.StrType)le.prepped_addr1,(SALT31.StrType)le.prepped_addr2,(SALT31.StrType)le.prim_range,(SALT31.StrType)le.predir,(SALT31.StrType)le.prim_name,(SALT31.StrType)le.addr_suffix,(SALT31.StrType)le.postdir,(SALT31.StrType)le.unit_desig,(SALT31.StrType)le.sec_range,(SALT31.StrType)le.p_city_name,(SALT31.StrType)le.v_city_name,(SALT31.StrType)le.st,(SALT31.StrType)le.zip,(SALT31.StrType)le.zip4,(SALT31.StrType)le.cart,(SALT31.StrType)le.cr_sort_sz,(SALT31.StrType)le.lot,(SALT31.StrType)le.lot_order,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,100,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'did:did:LEFTTRIM','did:did:ALLOW'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW'
          ,'bdid:bdid:LEFTTRIM','bdid:bdid:ALLOW'
          ,'bdid_score:bdid_score:LEFTTRIM','bdid_score:bdid_score:ALLOW'
          ,'best_dob:best_dob:LEFTTRIM','best_dob:best_dob:ALLOW'
          ,'best_ssn:best_ssn:LEFTTRIM','best_ssn:best_ssn:ALLOW'
          ,'spi:spi:LEFTTRIM','spi:spi:ALLOW'
          ,'dea:dea:LEFTTRIM','dea:dea:ALLOW'
          ,'statelicensenumber:statelicensenumber:LEFTTRIM','statelicensenumber:statelicensenumber:ALLOW'
          ,'specialtycodeprimary:specialtycodeprimary:LEFTTRIM','specialtycodeprimary:specialtycodeprimary:ALLOW'
          ,'prefixname:prefixname:LEFTTRIM','prefixname:prefixname:ALLOW'
          ,'lastname:lastname:LEFTTRIM','lastname:lastname:ALLOW'
          ,'firstname:firstname:LEFTTRIM','firstname:firstname:ALLOW'
          ,'middlename:middlename:LEFTTRIM','middlename:middlename:ALLOW'
          ,'suffixname:suffixname:LEFTTRIM','suffixname:suffixname:ALLOW'
          ,'clinicname:clinicname:LEFTTRIM','clinicname:clinicname:ALLOW'
          ,'addressline1:addressline1:LEFTTRIM','addressline1:addressline1:ALLOW'
          ,'addressline2:addressline2:LEFTTRIM','addressline2:addressline2:ALLOW'
          ,'city:city:LEFTTRIM','city:city:ALLOW'
          ,'state:state:LEFTTRIM','state:state:ALLOW'
          ,'zipcode:zipcode:LEFTTRIM','zipcode:zipcode:ALLOW'
          ,'phoneprimary:phoneprimary:LEFTTRIM','phoneprimary:phoneprimary:ALLOW'
          ,'fax:fax:LEFTTRIM','fax:fax:ALLOW'
          ,'email:email:LEFTTRIM','email:email:ALLOW'
          ,'phonealt1:phonealt1:LEFTTRIM','phonealt1:phonealt1:ALLOW'
          ,'phonealt1qualifier:phonealt1qualifier:LEFTTRIM','phonealt1qualifier:phonealt1qualifier:ALLOW'
          ,'phonealt2:phonealt2:LEFTTRIM','phonealt2:phonealt2:ALLOW'
          ,'phonealt2qualifier:phonealt2qualifier:LEFTTRIM','phonealt2qualifier:phonealt2qualifier:ALLOW'
          ,'phonealt3:phonealt3:LEFTTRIM','phonealt3:phonealt3:ALLOW'
          ,'phonealt3qualifier:phonealt3qualifier:LEFTTRIM','phonealt3qualifier:phonealt3qualifier:ALLOW'
          ,'phonealt4:phonealt4:LEFTTRIM','phonealt4:phonealt4:ALLOW'
          ,'phonealt4qualifier:phonealt4qualifier:LEFTTRIM','phonealt4qualifier:phonealt4qualifier:ALLOW'
          ,'phonealt5:phonealt5:LEFTTRIM','phonealt5:phonealt5:ALLOW'
          ,'phonealt5qualifier:phonealt5qualifier:LEFTTRIM','phonealt5qualifier:phonealt5qualifier:ALLOW'
          ,'activestarttime:activestarttime:LEFTTRIM','activestarttime:activestarttime:ALLOW'
          ,'activeendtime:activeendtime:LEFTTRIM','activeendtime:activeendtime:ALLOW'
          ,'servicelevel:servicelevel:LEFTTRIM','servicelevel:servicelevel:ALLOW'
          ,'partneraccount:partneraccount:LEFTTRIM','partneraccount:partneraccount:ALLOW'
          ,'lastmodifieddate:lastmodifieddate:LEFTTRIM','lastmodifieddate:lastmodifieddate:ALLOW'
          ,'recordchange:recordchange:LEFTTRIM','recordchange:recordchange:ALLOW'
          ,'oldservicelevel:oldservicelevel:LEFTTRIM','oldservicelevel:oldservicelevel:ALLOW'
          ,'textservicelevel:textservicelevel:LEFTTRIM','textservicelevel:textservicelevel:ALLOW'
          ,'textservicelevelchange:textservicelevelchange:LEFTTRIM','textservicelevelchange:textservicelevelchange:ALLOW'
          ,'version:version:LEFTTRIM','version:version:ALLOW'
          ,'npi:npi:LEFTTRIM','npi:npi:ALLOW'
          ,'npilocation:npilocation:LEFTTRIM','npilocation:npilocation:ALLOW'
          ,'specialitytype1:specialitytype1:LEFTTRIM','specialitytype1:specialitytype1:ALLOW'
          ,'specialitytype2:specialitytype2:LEFTTRIM','specialitytype2:specialitytype2:ALLOW'
          ,'specialitytype3:specialitytype3:LEFTTRIM','specialitytype3:specialitytype3:ALLOW'
          ,'specialitytype4:specialitytype4:LEFTTRIM','specialitytype4:specialitytype4:ALLOW'
          ,'fileid:fileid:LEFTTRIM','fileid:fileid:ALLOW'
          ,'medicarenumber:medicarenumber:LEFTTRIM','medicarenumber:medicarenumber:ALLOW'
          ,'medicaidnumber:medicaidnumber:LEFTTRIM','medicaidnumber:medicaidnumber:ALLOW'
          ,'dentistlicensenumber:dentistlicensenumber:LEFTTRIM','dentistlicensenumber:dentistlicensenumber:ALLOW'
          ,'upin:upin:LEFTTRIM','upin:upin:ALLOW'
          ,'pponumber:pponumber:LEFTTRIM','pponumber:pponumber:ALLOW'
          ,'socialsecurity:socialsecurity:LEFTTRIM','socialsecurity:socialsecurity:ALLOW'
          ,'priorauthorization:priorauthorization:LEFTTRIM','priorauthorization:priorauthorization:ALLOW'
          ,'mutuallydefined:mutuallydefined:LEFTTRIM','mutuallydefined:mutuallydefined:ALLOW'
          ,'instorencpdpid:instorencpdpid:LEFTTRIM','instorencpdpid:instorencpdpid:ALLOW','instorencpdpid:instorencpdpid:LENGTH','instorencpdpid:instorencpdpid:WORDS'
          ,'spec_code:spec_code:LEFTTRIM','spec_code:spec_code:ALLOW'
          ,'spec_desc:spec_desc:LEFTTRIM','spec_desc:spec_desc:ALLOW'
          ,'activity_code:activity_code:LEFTTRIM','activity_code:activity_code:ALLOW'
          ,'practice_type_code:practice_type_code:LEFTTRIM','practice_type_code:practice_type_code:ALLOW'
          ,'practice_type_desc:practice_type_desc:LEFTTRIM','practice_type_desc:practice_type_desc:ALLOW'
          ,'taxonomy:taxonomy:LEFTTRIM','taxonomy:taxonomy:ALLOW'
          ,'src:src:LEFTTRIM','src:src:ALLOW'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW'
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW'
          ,'record_type:record_type:LEFTTRIM','record_type:record_type:ALLOW'
          ,'source_rid:source_rid:LEFTTRIM','source_rid:source_rid:ALLOW'
          ,'lnpid:lnpid:LEFTTRIM','lnpid:lnpid:ALLOW'
          ,'title:title:LEFTTRIM','title:title:ALLOW'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW'
          ,'name_type:name_type:LEFTTRIM','name_type:name_type:ALLOW'
          ,'nid:nid:LEFTTRIM','nid:nid:ALLOW'
          ,'clean_clinic_name:clean_clinic_name:LEFTTRIM','clean_clinic_name:clean_clinic_name:ALLOW'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW'
          ,'st:st:LEFTTRIM','st:st:ALLOW'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,SureScripts_Fields.InvalidMessage_did(1),SureScripts_Fields.InvalidMessage_did(2)
          ,SureScripts_Fields.InvalidMessage_did_score(1),SureScripts_Fields.InvalidMessage_did_score(2)
          ,SureScripts_Fields.InvalidMessage_bdid(1),SureScripts_Fields.InvalidMessage_bdid(2)
          ,SureScripts_Fields.InvalidMessage_bdid_score(1),SureScripts_Fields.InvalidMessage_bdid_score(2)
          ,SureScripts_Fields.InvalidMessage_best_dob(1),SureScripts_Fields.InvalidMessage_best_dob(2)
          ,SureScripts_Fields.InvalidMessage_best_ssn(1),SureScripts_Fields.InvalidMessage_best_ssn(2)
          ,SureScripts_Fields.InvalidMessage_spi(1),SureScripts_Fields.InvalidMessage_spi(2)
          ,SureScripts_Fields.InvalidMessage_dea(1),SureScripts_Fields.InvalidMessage_dea(2)
          ,SureScripts_Fields.InvalidMessage_statelicensenumber(1),SureScripts_Fields.InvalidMessage_statelicensenumber(2)
          ,SureScripts_Fields.InvalidMessage_specialtycodeprimary(1),SureScripts_Fields.InvalidMessage_specialtycodeprimary(2)
          ,SureScripts_Fields.InvalidMessage_prefixname(1),SureScripts_Fields.InvalidMessage_prefixname(2)
          ,SureScripts_Fields.InvalidMessage_lastname(1),SureScripts_Fields.InvalidMessage_lastname(2)
          ,SureScripts_Fields.InvalidMessage_firstname(1),SureScripts_Fields.InvalidMessage_firstname(2)
          ,SureScripts_Fields.InvalidMessage_middlename(1),SureScripts_Fields.InvalidMessage_middlename(2)
          ,SureScripts_Fields.InvalidMessage_suffixname(1),SureScripts_Fields.InvalidMessage_suffixname(2)
          ,SureScripts_Fields.InvalidMessage_clinicname(1),SureScripts_Fields.InvalidMessage_clinicname(2)
          ,SureScripts_Fields.InvalidMessage_addressline1(1),SureScripts_Fields.InvalidMessage_addressline1(2)
          ,SureScripts_Fields.InvalidMessage_addressline2(1),SureScripts_Fields.InvalidMessage_addressline2(2)
          ,SureScripts_Fields.InvalidMessage_city(1),SureScripts_Fields.InvalidMessage_city(2)
          ,SureScripts_Fields.InvalidMessage_state(1),SureScripts_Fields.InvalidMessage_state(2)
          ,SureScripts_Fields.InvalidMessage_zipcode(1),SureScripts_Fields.InvalidMessage_zipcode(2)
          ,SureScripts_Fields.InvalidMessage_phoneprimary(1),SureScripts_Fields.InvalidMessage_phoneprimary(2)
          ,SureScripts_Fields.InvalidMessage_fax(1),SureScripts_Fields.InvalidMessage_fax(2)
          ,SureScripts_Fields.InvalidMessage_email(1),SureScripts_Fields.InvalidMessage_email(2)
          ,SureScripts_Fields.InvalidMessage_phonealt1(1),SureScripts_Fields.InvalidMessage_phonealt1(2)
          ,SureScripts_Fields.InvalidMessage_phonealt1qualifier(1),SureScripts_Fields.InvalidMessage_phonealt1qualifier(2)
          ,SureScripts_Fields.InvalidMessage_phonealt2(1),SureScripts_Fields.InvalidMessage_phonealt2(2)
          ,SureScripts_Fields.InvalidMessage_phonealt2qualifier(1),SureScripts_Fields.InvalidMessage_phonealt2qualifier(2)
          ,SureScripts_Fields.InvalidMessage_phonealt3(1),SureScripts_Fields.InvalidMessage_phonealt3(2)
          ,SureScripts_Fields.InvalidMessage_phonealt3qualifier(1),SureScripts_Fields.InvalidMessage_phonealt3qualifier(2)
          ,SureScripts_Fields.InvalidMessage_phonealt4(1),SureScripts_Fields.InvalidMessage_phonealt4(2)
          ,SureScripts_Fields.InvalidMessage_phonealt4qualifier(1),SureScripts_Fields.InvalidMessage_phonealt4qualifier(2)
          ,SureScripts_Fields.InvalidMessage_phonealt5(1),SureScripts_Fields.InvalidMessage_phonealt5(2)
          ,SureScripts_Fields.InvalidMessage_phonealt5qualifier(1),SureScripts_Fields.InvalidMessage_phonealt5qualifier(2)
          ,SureScripts_Fields.InvalidMessage_activestarttime(1),SureScripts_Fields.InvalidMessage_activestarttime(2)
          ,SureScripts_Fields.InvalidMessage_activeendtime(1),SureScripts_Fields.InvalidMessage_activeendtime(2)
          ,SureScripts_Fields.InvalidMessage_servicelevel(1),SureScripts_Fields.InvalidMessage_servicelevel(2)
          ,SureScripts_Fields.InvalidMessage_partneraccount(1),SureScripts_Fields.InvalidMessage_partneraccount(2)
          ,SureScripts_Fields.InvalidMessage_lastmodifieddate(1),SureScripts_Fields.InvalidMessage_lastmodifieddate(2)
          ,SureScripts_Fields.InvalidMessage_recordchange(1),SureScripts_Fields.InvalidMessage_recordchange(2)
          ,SureScripts_Fields.InvalidMessage_oldservicelevel(1),SureScripts_Fields.InvalidMessage_oldservicelevel(2)
          ,SureScripts_Fields.InvalidMessage_textservicelevel(1),SureScripts_Fields.InvalidMessage_textservicelevel(2)
          ,SureScripts_Fields.InvalidMessage_textservicelevelchange(1),SureScripts_Fields.InvalidMessage_textservicelevelchange(2)
          ,SureScripts_Fields.InvalidMessage_version(1),SureScripts_Fields.InvalidMessage_version(2)
          ,SureScripts_Fields.InvalidMessage_npi(1),SureScripts_Fields.InvalidMessage_npi(2)
          ,SureScripts_Fields.InvalidMessage_npilocation(1),SureScripts_Fields.InvalidMessage_npilocation(2)
          ,SureScripts_Fields.InvalidMessage_specialitytype1(1),SureScripts_Fields.InvalidMessage_specialitytype1(2)
          ,SureScripts_Fields.InvalidMessage_specialitytype2(1),SureScripts_Fields.InvalidMessage_specialitytype2(2)
          ,SureScripts_Fields.InvalidMessage_specialitytype3(1),SureScripts_Fields.InvalidMessage_specialitytype3(2)
          ,SureScripts_Fields.InvalidMessage_specialitytype4(1),SureScripts_Fields.InvalidMessage_specialitytype4(2)
          ,SureScripts_Fields.InvalidMessage_fileid(1),SureScripts_Fields.InvalidMessage_fileid(2)
          ,SureScripts_Fields.InvalidMessage_medicarenumber(1),SureScripts_Fields.InvalidMessage_medicarenumber(2)
          ,SureScripts_Fields.InvalidMessage_medicaidnumber(1),SureScripts_Fields.InvalidMessage_medicaidnumber(2)
          ,SureScripts_Fields.InvalidMessage_dentistlicensenumber(1),SureScripts_Fields.InvalidMessage_dentistlicensenumber(2)
          ,SureScripts_Fields.InvalidMessage_upin(1),SureScripts_Fields.InvalidMessage_upin(2)
          ,SureScripts_Fields.InvalidMessage_pponumber(1),SureScripts_Fields.InvalidMessage_pponumber(2)
          ,SureScripts_Fields.InvalidMessage_socialsecurity(1),SureScripts_Fields.InvalidMessage_socialsecurity(2)
          ,SureScripts_Fields.InvalidMessage_priorauthorization(1),SureScripts_Fields.InvalidMessage_priorauthorization(2)
          ,SureScripts_Fields.InvalidMessage_mutuallydefined(1),SureScripts_Fields.InvalidMessage_mutuallydefined(2)
          ,SureScripts_Fields.InvalidMessage_instorencpdpid(1),SureScripts_Fields.InvalidMessage_instorencpdpid(2),SureScripts_Fields.InvalidMessage_instorencpdpid(3),SureScripts_Fields.InvalidMessage_instorencpdpid(4)
          ,SureScripts_Fields.InvalidMessage_spec_code(1),SureScripts_Fields.InvalidMessage_spec_code(2)
          ,SureScripts_Fields.InvalidMessage_spec_desc(1),SureScripts_Fields.InvalidMessage_spec_desc(2)
          ,SureScripts_Fields.InvalidMessage_activity_code(1),SureScripts_Fields.InvalidMessage_activity_code(2)
          ,SureScripts_Fields.InvalidMessage_practice_type_code(1),SureScripts_Fields.InvalidMessage_practice_type_code(2)
          ,SureScripts_Fields.InvalidMessage_practice_type_desc(1),SureScripts_Fields.InvalidMessage_practice_type_desc(2)
          ,SureScripts_Fields.InvalidMessage_taxonomy(1),SureScripts_Fields.InvalidMessage_taxonomy(2)
          ,SureScripts_Fields.InvalidMessage_src(1),SureScripts_Fields.InvalidMessage_src(2)
          ,SureScripts_Fields.InvalidMessage_dt_vendor_first_reported(1),SureScripts_Fields.InvalidMessage_dt_vendor_first_reported(2)
          ,SureScripts_Fields.InvalidMessage_dt_vendor_last_reported(1),SureScripts_Fields.InvalidMessage_dt_vendor_last_reported(2)
          ,SureScripts_Fields.InvalidMessage_dt_first_seen(1),SureScripts_Fields.InvalidMessage_dt_first_seen(2)
          ,SureScripts_Fields.InvalidMessage_dt_last_seen(1),SureScripts_Fields.InvalidMessage_dt_last_seen(2)
          ,SureScripts_Fields.InvalidMessage_record_type(1),SureScripts_Fields.InvalidMessage_record_type(2)
          ,SureScripts_Fields.InvalidMessage_source_rid(1),SureScripts_Fields.InvalidMessage_source_rid(2)
          ,SureScripts_Fields.InvalidMessage_lnpid(1),SureScripts_Fields.InvalidMessage_lnpid(2)
          ,SureScripts_Fields.InvalidMessage_title(1),SureScripts_Fields.InvalidMessage_title(2)
          ,SureScripts_Fields.InvalidMessage_fname(1),SureScripts_Fields.InvalidMessage_fname(2)
          ,SureScripts_Fields.InvalidMessage_mname(1),SureScripts_Fields.InvalidMessage_mname(2)
          ,SureScripts_Fields.InvalidMessage_lname(1),SureScripts_Fields.InvalidMessage_lname(2)
          ,SureScripts_Fields.InvalidMessage_name_suffix(1),SureScripts_Fields.InvalidMessage_name_suffix(2)
          ,SureScripts_Fields.InvalidMessage_name_type(1),SureScripts_Fields.InvalidMessage_name_type(2)
          ,SureScripts_Fields.InvalidMessage_nid(1),SureScripts_Fields.InvalidMessage_nid(2)
          ,SureScripts_Fields.InvalidMessage_clean_clinic_name(1),SureScripts_Fields.InvalidMessage_clean_clinic_name(2)
          ,SureScripts_Fields.InvalidMessage_prepped_addr1(1),SureScripts_Fields.InvalidMessage_prepped_addr1(2)
          ,SureScripts_Fields.InvalidMessage_prepped_addr2(1),SureScripts_Fields.InvalidMessage_prepped_addr2(2)
          ,SureScripts_Fields.InvalidMessage_prim_range(1),SureScripts_Fields.InvalidMessage_prim_range(2)
          ,SureScripts_Fields.InvalidMessage_predir(1),SureScripts_Fields.InvalidMessage_predir(2)
          ,SureScripts_Fields.InvalidMessage_prim_name(1),SureScripts_Fields.InvalidMessage_prim_name(2)
          ,SureScripts_Fields.InvalidMessage_addr_suffix(1),SureScripts_Fields.InvalidMessage_addr_suffix(2)
          ,SureScripts_Fields.InvalidMessage_postdir(1),SureScripts_Fields.InvalidMessage_postdir(2)
          ,SureScripts_Fields.InvalidMessage_unit_desig(1),SureScripts_Fields.InvalidMessage_unit_desig(2)
          ,SureScripts_Fields.InvalidMessage_sec_range(1),SureScripts_Fields.InvalidMessage_sec_range(2)
          ,SureScripts_Fields.InvalidMessage_p_city_name(1),SureScripts_Fields.InvalidMessage_p_city_name(2)
          ,SureScripts_Fields.InvalidMessage_v_city_name(1),SureScripts_Fields.InvalidMessage_v_city_name(2)
          ,SureScripts_Fields.InvalidMessage_st(1),SureScripts_Fields.InvalidMessage_st(2)
          ,SureScripts_Fields.InvalidMessage_zip(1),SureScripts_Fields.InvalidMessage_zip(2)
          ,SureScripts_Fields.InvalidMessage_zip4(1),SureScripts_Fields.InvalidMessage_zip4(2)
          ,SureScripts_Fields.InvalidMessage_cart(1),SureScripts_Fields.InvalidMessage_cart(2)
          ,SureScripts_Fields.InvalidMessage_cr_sort_sz(1),SureScripts_Fields.InvalidMessage_cr_sort_sz(2)
          ,SureScripts_Fields.InvalidMessage_lot(1),SureScripts_Fields.InvalidMessage_lot(2)
          ,SureScripts_Fields.InvalidMessage_lot_order(1),SureScripts_Fields.InvalidMessage_lot_order(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount
          ,le.spi_LEFTTRIM_ErrorCount,le.spi_ALLOW_ErrorCount
          ,le.dea_LEFTTRIM_ErrorCount,le.dea_ALLOW_ErrorCount
          ,le.statelicensenumber_LEFTTRIM_ErrorCount,le.statelicensenumber_ALLOW_ErrorCount
          ,le.specialtycodeprimary_LEFTTRIM_ErrorCount,le.specialtycodeprimary_ALLOW_ErrorCount
          ,le.prefixname_LEFTTRIM_ErrorCount,le.prefixname_ALLOW_ErrorCount
          ,le.lastname_LEFTTRIM_ErrorCount,le.lastname_ALLOW_ErrorCount
          ,le.firstname_LEFTTRIM_ErrorCount,le.firstname_ALLOW_ErrorCount
          ,le.middlename_LEFTTRIM_ErrorCount,le.middlename_ALLOW_ErrorCount
          ,le.suffixname_LEFTTRIM_ErrorCount,le.suffixname_ALLOW_ErrorCount
          ,le.clinicname_LEFTTRIM_ErrorCount,le.clinicname_ALLOW_ErrorCount
          ,le.addressline1_LEFTTRIM_ErrorCount,le.addressline1_ALLOW_ErrorCount
          ,le.addressline2_LEFTTRIM_ErrorCount,le.addressline2_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount
          ,le.phoneprimary_LEFTTRIM_ErrorCount,le.phoneprimary_ALLOW_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount
          ,le.phonealt1_LEFTTRIM_ErrorCount,le.phonealt1_ALLOW_ErrorCount
          ,le.phonealt1qualifier_LEFTTRIM_ErrorCount,le.phonealt1qualifier_ALLOW_ErrorCount
          ,le.phonealt2_LEFTTRIM_ErrorCount,le.phonealt2_ALLOW_ErrorCount
          ,le.phonealt2qualifier_LEFTTRIM_ErrorCount,le.phonealt2qualifier_ALLOW_ErrorCount
          ,le.phonealt3_LEFTTRIM_ErrorCount,le.phonealt3_ALLOW_ErrorCount
          ,le.phonealt3qualifier_LEFTTRIM_ErrorCount,le.phonealt3qualifier_ALLOW_ErrorCount
          ,le.phonealt4_LEFTTRIM_ErrorCount,le.phonealt4_ALLOW_ErrorCount
          ,le.phonealt4qualifier_LEFTTRIM_ErrorCount,le.phonealt4qualifier_ALLOW_ErrorCount
          ,le.phonealt5_LEFTTRIM_ErrorCount,le.phonealt5_ALLOW_ErrorCount
          ,le.phonealt5qualifier_LEFTTRIM_ErrorCount,le.phonealt5qualifier_ALLOW_ErrorCount
          ,le.activestarttime_LEFTTRIM_ErrorCount,le.activestarttime_ALLOW_ErrorCount
          ,le.activeendtime_LEFTTRIM_ErrorCount,le.activeendtime_ALLOW_ErrorCount
          ,le.servicelevel_LEFTTRIM_ErrorCount,le.servicelevel_ALLOW_ErrorCount
          ,le.partneraccount_LEFTTRIM_ErrorCount,le.partneraccount_ALLOW_ErrorCount
          ,le.lastmodifieddate_LEFTTRIM_ErrorCount,le.lastmodifieddate_ALLOW_ErrorCount
          ,le.recordchange_LEFTTRIM_ErrorCount,le.recordchange_ALLOW_ErrorCount
          ,le.oldservicelevel_LEFTTRIM_ErrorCount,le.oldservicelevel_ALLOW_ErrorCount
          ,le.textservicelevel_LEFTTRIM_ErrorCount,le.textservicelevel_ALLOW_ErrorCount
          ,le.textservicelevelchange_LEFTTRIM_ErrorCount,le.textservicelevelchange_ALLOW_ErrorCount
          ,le.version_LEFTTRIM_ErrorCount,le.version_ALLOW_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount
          ,le.npilocation_LEFTTRIM_ErrorCount,le.npilocation_ALLOW_ErrorCount
          ,le.specialitytype1_LEFTTRIM_ErrorCount,le.specialitytype1_ALLOW_ErrorCount
          ,le.specialitytype2_LEFTTRIM_ErrorCount,le.specialitytype2_ALLOW_ErrorCount
          ,le.specialitytype3_LEFTTRIM_ErrorCount,le.specialitytype3_ALLOW_ErrorCount
          ,le.specialitytype4_LEFTTRIM_ErrorCount,le.specialitytype4_ALLOW_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount
          ,le.medicarenumber_LEFTTRIM_ErrorCount,le.medicarenumber_ALLOW_ErrorCount
          ,le.medicaidnumber_LEFTTRIM_ErrorCount,le.medicaidnumber_ALLOW_ErrorCount
          ,le.dentistlicensenumber_LEFTTRIM_ErrorCount,le.dentistlicensenumber_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount
          ,le.pponumber_LEFTTRIM_ErrorCount,le.pponumber_ALLOW_ErrorCount
          ,le.socialsecurity_LEFTTRIM_ErrorCount,le.socialsecurity_ALLOW_ErrorCount
          ,le.priorauthorization_LEFTTRIM_ErrorCount,le.priorauthorization_ALLOW_ErrorCount
          ,le.mutuallydefined_LEFTTRIM_ErrorCount,le.mutuallydefined_ALLOW_ErrorCount
          ,le.instorencpdpid_LEFTTRIM_ErrorCount,le.instorencpdpid_ALLOW_ErrorCount,le.instorencpdpid_LENGTH_ErrorCount,le.instorencpdpid_WORDS_ErrorCount
          ,le.spec_code_LEFTTRIM_ErrorCount,le.spec_code_ALLOW_ErrorCount
          ,le.spec_desc_LEFTTRIM_ErrorCount,le.spec_desc_ALLOW_ErrorCount
          ,le.activity_code_LEFTTRIM_ErrorCount,le.activity_code_ALLOW_ErrorCount
          ,le.practice_type_code_LEFTTRIM_ErrorCount,le.practice_type_code_ALLOW_ErrorCount
          ,le.practice_type_desc_LEFTTRIM_ErrorCount,le.practice_type_desc_ALLOW_ErrorCount
          ,le.taxonomy_LEFTTRIM_ErrorCount,le.taxonomy_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount
          ,le.spi_LEFTTRIM_ErrorCount,le.spi_ALLOW_ErrorCount
          ,le.dea_LEFTTRIM_ErrorCount,le.dea_ALLOW_ErrorCount
          ,le.statelicensenumber_LEFTTRIM_ErrorCount,le.statelicensenumber_ALLOW_ErrorCount
          ,le.specialtycodeprimary_LEFTTRIM_ErrorCount,le.specialtycodeprimary_ALLOW_ErrorCount
          ,le.prefixname_LEFTTRIM_ErrorCount,le.prefixname_ALLOW_ErrorCount
          ,le.lastname_LEFTTRIM_ErrorCount,le.lastname_ALLOW_ErrorCount
          ,le.firstname_LEFTTRIM_ErrorCount,le.firstname_ALLOW_ErrorCount
          ,le.middlename_LEFTTRIM_ErrorCount,le.middlename_ALLOW_ErrorCount
          ,le.suffixname_LEFTTRIM_ErrorCount,le.suffixname_ALLOW_ErrorCount
          ,le.clinicname_LEFTTRIM_ErrorCount,le.clinicname_ALLOW_ErrorCount
          ,le.addressline1_LEFTTRIM_ErrorCount,le.addressline1_ALLOW_ErrorCount
          ,le.addressline2_LEFTTRIM_ErrorCount,le.addressline2_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount
          ,le.zipcode_LEFTTRIM_ErrorCount,le.zipcode_ALLOW_ErrorCount
          ,le.phoneprimary_LEFTTRIM_ErrorCount,le.phoneprimary_ALLOW_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount
          ,le.phonealt1_LEFTTRIM_ErrorCount,le.phonealt1_ALLOW_ErrorCount
          ,le.phonealt1qualifier_LEFTTRIM_ErrorCount,le.phonealt1qualifier_ALLOW_ErrorCount
          ,le.phonealt2_LEFTTRIM_ErrorCount,le.phonealt2_ALLOW_ErrorCount
          ,le.phonealt2qualifier_LEFTTRIM_ErrorCount,le.phonealt2qualifier_ALLOW_ErrorCount
          ,le.phonealt3_LEFTTRIM_ErrorCount,le.phonealt3_ALLOW_ErrorCount
          ,le.phonealt3qualifier_LEFTTRIM_ErrorCount,le.phonealt3qualifier_ALLOW_ErrorCount
          ,le.phonealt4_LEFTTRIM_ErrorCount,le.phonealt4_ALLOW_ErrorCount
          ,le.phonealt4qualifier_LEFTTRIM_ErrorCount,le.phonealt4qualifier_ALLOW_ErrorCount
          ,le.phonealt5_LEFTTRIM_ErrorCount,le.phonealt5_ALLOW_ErrorCount
          ,le.phonealt5qualifier_LEFTTRIM_ErrorCount,le.phonealt5qualifier_ALLOW_ErrorCount
          ,le.activestarttime_LEFTTRIM_ErrorCount,le.activestarttime_ALLOW_ErrorCount
          ,le.activeendtime_LEFTTRIM_ErrorCount,le.activeendtime_ALLOW_ErrorCount
          ,le.servicelevel_LEFTTRIM_ErrorCount,le.servicelevel_ALLOW_ErrorCount
          ,le.partneraccount_LEFTTRIM_ErrorCount,le.partneraccount_ALLOW_ErrorCount
          ,le.lastmodifieddate_LEFTTRIM_ErrorCount,le.lastmodifieddate_ALLOW_ErrorCount
          ,le.recordchange_LEFTTRIM_ErrorCount,le.recordchange_ALLOW_ErrorCount
          ,le.oldservicelevel_LEFTTRIM_ErrorCount,le.oldservicelevel_ALLOW_ErrorCount
          ,le.textservicelevel_LEFTTRIM_ErrorCount,le.textservicelevel_ALLOW_ErrorCount
          ,le.textservicelevelchange_LEFTTRIM_ErrorCount,le.textservicelevelchange_ALLOW_ErrorCount
          ,le.version_LEFTTRIM_ErrorCount,le.version_ALLOW_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount
          ,le.npilocation_LEFTTRIM_ErrorCount,le.npilocation_ALLOW_ErrorCount
          ,le.specialitytype1_LEFTTRIM_ErrorCount,le.specialitytype1_ALLOW_ErrorCount
          ,le.specialitytype2_LEFTTRIM_ErrorCount,le.specialitytype2_ALLOW_ErrorCount
          ,le.specialitytype3_LEFTTRIM_ErrorCount,le.specialitytype3_ALLOW_ErrorCount
          ,le.specialitytype4_LEFTTRIM_ErrorCount,le.specialitytype4_ALLOW_ErrorCount
          ,le.fileid_LEFTTRIM_ErrorCount,le.fileid_ALLOW_ErrorCount
          ,le.medicarenumber_LEFTTRIM_ErrorCount,le.medicarenumber_ALLOW_ErrorCount
          ,le.medicaidnumber_LEFTTRIM_ErrorCount,le.medicaidnumber_ALLOW_ErrorCount
          ,le.dentistlicensenumber_LEFTTRIM_ErrorCount,le.dentistlicensenumber_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount
          ,le.pponumber_LEFTTRIM_ErrorCount,le.pponumber_ALLOW_ErrorCount
          ,le.socialsecurity_LEFTTRIM_ErrorCount,le.socialsecurity_ALLOW_ErrorCount
          ,le.priorauthorization_LEFTTRIM_ErrorCount,le.priorauthorization_ALLOW_ErrorCount
          ,le.mutuallydefined_LEFTTRIM_ErrorCount,le.mutuallydefined_ALLOW_ErrorCount
          ,le.instorencpdpid_LEFTTRIM_ErrorCount,le.instorencpdpid_ALLOW_ErrorCount,le.instorencpdpid_LENGTH_ErrorCount,le.instorencpdpid_WORDS_ErrorCount
          ,le.spec_code_LEFTTRIM_ErrorCount,le.spec_code_ALLOW_ErrorCount
          ,le.spec_desc_LEFTTRIM_ErrorCount,le.spec_desc_ALLOW_ErrorCount
          ,le.activity_code_LEFTTRIM_ErrorCount,le.activity_code_ALLOW_ErrorCount
          ,le.practice_type_code_LEFTTRIM_ErrorCount,le.practice_type_code_ALLOW_ErrorCount
          ,le.practice_type_desc_LEFTTRIM_ErrorCount,le.practice_type_desc_ALLOW_ErrorCount
          ,le.taxonomy_LEFTTRIM_ErrorCount,le.taxonomy_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,202,Into(LEFT,COUNTER));
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
