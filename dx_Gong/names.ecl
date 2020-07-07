IMPORT data_services, doxie;

EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

  SHARED string prefix        :=  data_services.data_location.prefix('Gong') + 'thor_data400::key::';
  SHARED string postfix       := IF (file_version != '', '_' + file_version, '');

  EXPORT i_phone              := prefix + 'gong_phone'           + postfix;
  EXPORT i_czsslf             := prefix + 'gong_czsslf'          + postfix; //TODO: delete
  EXPORT i_lczf               := prefix + 'gong_lczf'            + postfix; //TODO: delete
  EXPORT i_address_current    := prefix + 'gong_address_current' + postfix;
  EXPORT i_surname_count      := prefix + 'gong_surnamecnt'      + postfix;
  EXPORT i_phone10            := prefix + 'cbrs.phone10_gong'    + postfix;
  EXPORT i_npa                := prefix + 'gong::' + IF(file_version='', '@version@', file_version) + '::npa'; // different superfile name pattern
  EXPORT i_zip                := prefix + 'gong::' + IF(file_version='', '@version@', file_version) + '::zip'; // different superfile name pattern
  EXPORT i_scoring_attributes := prefix + 'gong_scoring'         + postfix;

  // history keys
  EXPORT i_history_address       := prefix + 'gong_history_address'       + postfix;
  EXPORT i_history_phone         := prefix + 'gong_history_phone'         + postfix;
  EXPORT i_history_did           := prefix + 'gong_history_did'           + postfix;
  EXPORT i_history_hhid          := prefix + 'gong_history_hhid'          + postfix;
  EXPORT i_history_bdid          := prefix + 'gong_hist_bdid'             + postfix;
  EXPORT i_history_name          := prefix + 'gong_history_name'          + postfix;
  EXPORT i_history_zip_name      := prefix + 'gong_history_zip_name'      + postfix;
  EXPORT i_history_npa_nxx_line  := prefix + 'gong_history_npa_nxx_line'  + postfix;
  EXPORT i_history_surname       := prefix + 'gong_history::' + IF(file_version='', '@version@', file_version) + '::surnames';
  EXPORT i_history_wdtg          := prefix + 'gong_history_wdtg'          + postfix;
  EXPORT i_history_companyname   := prefix + 'gong_history_companyname'   + postfix;
  EXPORT i_history_city_st_name  := prefix + 'gong_history_city_st_name'  + postfix;
  EXPORT i_history_clean_name    := prefix + 'gong_history_cleanname'     + postfix;
  EXPORT i_history_wild_name_zip := prefix + 'gong_history_wild_name_zip' + postfix;
  EXPORT i_history_LinkIDs       := prefix + 'gong_history_linkids'       + postfix;

  // FCRA Keys
  EXPORT i_history_address_fcra  := prefix + 'gong_history::fcra::' + IF(file_version='', '@version@', file_version) + '::address';
  EXPORT i_history_phone_fcra    := prefix + 'gong_history::fcra::' + IF(file_version='', '@version@', file_version) + '::phone';
  EXPORT i_history_did_fcra      := prefix + 'gong_history::fcra::' + IF(file_version='', '@version@', file_version) + '::did';

  EXPORT i_did                   := prefix + 'gong_did'                   + postfix;
  EXPORT i_hhid                  := prefix + 'gong_hhid'                  + postfix;
  EXPORT i_cn                    := prefix + 'gong_cn'                    + postfix;
  EXPORT i_cn_to_company         := prefix + 'gong_cn_to_company'         + postfix;
  EXPORT i_phone_table           := prefix + 'phone_table_v2'             + postfix;
  EXPORT i_phone_table_ft_fcra   := prefix + 'business_header::filtered::fcra::' + IF(file_version='', '@version@', file_version) + '::hri::phone10_v2';

END;
