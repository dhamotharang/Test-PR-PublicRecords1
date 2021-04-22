IMPORT data_services, doxie;

string prefix := data_services.data_location.prefix ('mari') + 'thor_data400::key';

EXPORT names(string file_version = doxie.version_superkey) := MODULE

  EXPORT i_disciplinary_actions := prefix + '::proflic_mari::' + doxie.version_superkey + '::disciplinary_actions';
  EXPORT i_individual_detail := prefix + '::proflic_mari::' + doxie.version_superkey + '::individual_detail';
  EXPORT i_license_number := prefix + '::proflic_mari::' + doxie.version_superkey + '::license_nbr';
  EXPORT i_link_ids := prefix + '::proflic_mari::' + doxie.version_superkey + '::linkids';
  EXPORT i_nmls_id := prefix + '::proflic_mari::' + doxie.version_superkey + '::nmls_id';
  EXPORT i_regulatory_actions := prefix + '::proflic_mari::' + doxie.version_superkey + '::regulatory_actions';
  EXPORT i_ssn_taxid := prefix + '::proflic_mari::' + doxie.version_superkey + '::ssn_taxid';
  EXPORT i_did := prefix + '::proflic_mari::' + doxie.version_superkey + '::did';
  EXPORT i_did_fcra := prefix + '::proflic_mari::fcra::' + doxie.version_superkey + '::did';
  EXPORT i_bdid := prefix + '::proflic_mari::' + doxie.version_superkey + '::bdid';
  EXPORT i_mari_payload := prefix + '::proflic_mari::' + doxie.version_superkey + '::rid';
  EXPORT i_autokey_payload := prefix + '::proflic_mari::autokey::' + doxie.version_superkey + '::payload';

  // these are to be gone soon...
  EXPORT i_regulatory_actions_delta_rid_logical := prefix + file_version + '::regulatory_actions::delta_rid';
  EXPORT i_regulatory_actions_delta_rid_super   := prefix + 'qa' + '::regulatory_actions::delta_rid';

  EXPORT i_disciplinary_actions_delta_rid_logical := prefix + file_version + '::disciplinary_actions::delta_rid';
  EXPORT i_disciplinary_actions_delta_rid_super   := prefix + 'qa' + '::disciplinary_actions::delta_rid';

  EXPORT i_individual_detail_delta_rid_logical := prefix + file_version + '::individual_detail::delta_rid';
  EXPORT i_individual_detail_delta_rid_super   := prefix + 'qa' + '::individual_detail::delta_rid';

  EXPORT i_search_delta_rid_logical := prefix + file_version + '::search::delta_rid';
  EXPORT i_search_delta_rid_super   := prefix + 'qa' + '::search::delta_rid';

  EXPORT i_fcra_search_delta_rid_logical := prefix + 'fcra::' + file_version + '::search::delta_rid';
  EXPORT i_fcra_search_delta_rid_super   := prefix + 'fcra::qa' + '::search::delta_rid';

END;
