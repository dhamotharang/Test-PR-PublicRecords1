IMPORT doxie, data_services;

EXPORT Names(string file_version = doxie.Version_SuperKey):= MODULE

  // Keys
  SHARED string prefix                  :=  data_services.data_location.prefix('Mari') + 'thor_data400::key::proflic_mari::';

  EXPORT i_regulatory_actions_delta_rid_logical := prefix + file_version + '::regulatory_actions::delta_rid';
  EXPORT i_regulatory_actions_delta_rid_super   := prefix + 'qa'         + '::regulatory_actions::delta_rid';

  EXPORT i_disciplinary_actions_delta_rid_logical := prefix + file_version + '::disciplinary_actions::delta_rid';
  EXPORT i_disciplinary_actions_delta_rid_super   := prefix + 'qa'         + '::disciplinary_actions::delta_rid';

  EXPORT i_individual_detail_delta_rid_logical := prefix + file_version + '::individual_detail::delta_rid';
  EXPORT i_individual_detail_delta_rid_super   := prefix + 'qa'         + '::individual_detail::delta_rid';

  EXPORT i_search_delta_rid_logical := prefix + file_version + '::search::delta_rid';
  EXPORT i_search_delta_rid_super   := prefix + 'qa'         + '::search::delta_rid';

  EXPORT i_fcra_search_delta_rid_logical := prefix + 'fcra::' + file_version + '::search::delta_rid';
  EXPORT i_fcra_search_delta_rid_super   := prefix + 'fcra::qa'   + '::search::delta_rid';

END;