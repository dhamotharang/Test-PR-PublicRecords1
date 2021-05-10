IMPORT data_services, doxie;

STRING prefix := data_services.data_location.prefix ('mari') + 'thor_data400::key::proflic_mari::';

EXPORT names(string file_version = doxie.version_superkey) := MODULE

  EXPORT i_disciplinary_actions := prefix + file_version + '::disciplinary_actions';
  EXPORT i_individual_detail := prefix + file_version + '::individual_detail';
  EXPORT i_license_number := prefix + file_version + '::license_nbr';
  EXPORT i_link_ids := prefix + file_version + '::linkids';
  EXPORT i_nmls_id := prefix + file_version + '::nmls_id';
  EXPORT i_regulatory_actions := prefix + file_version + '::regulatory_actions';
  EXPORT i_ssn_taxid := prefix + file_version + '::ssn_taxid';
  EXPORT i_did := prefix + file_version + '::did';
  EXPORT i_did_fcra := prefix + 'fcra::' + file_version + '::did';
  EXPORT i_bdid := prefix + file_version + '::bdid';
  EXPORT i_mari_payload := prefix + file_version + '::rid';
  EXPORT i_autokey_payload := prefix + 'autokey::' + file_version + '::payload';

  // these are to be gone soon...
  EXPORT i_regulatory_actions_delta_rid_logical := prefix + file_version + '::regulatory_actions::delta_rid';
  EXPORT i_regulatory_actions_delta_rid_super := prefix + 'qa' + '::regulatory_actions::delta_rid';

  EXPORT i_disciplinary_actions_delta_rid_logical := prefix + file_version + '::disciplinary_actions::delta_rid';
  EXPORT i_disciplinary_actions_delta_rid_super := prefix + 'qa' + '::disciplinary_actions::delta_rid';

  EXPORT i_individual_detail_delta_rid_logical := prefix + file_version + '::individual_detail::delta_rid';
  EXPORT i_individual_detail_delta_rid_super := prefix + 'qa' + '::individual_detail::delta_rid';

  EXPORT i_search_delta_rid_logical := prefix + file_version + '::search::delta_rid';
  EXPORT i_search_delta_rid_super := prefix + 'qa' + '::search::delta_rid';

  EXPORT i_fcra_search_delta_rid_logical := prefix + 'fcra::' + file_version + '::search::delta_rid';
  EXPORT i_fcra_search_delta_rid_super := prefix + 'fcra::qa' + '::search::delta_rid';

END;
