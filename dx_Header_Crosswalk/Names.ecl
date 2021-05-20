IMPORT data_services;
IMPORT doxie;

EXPORT names := MODULE

  // Use data_sevices to properly identify Dali server
  SHARED STRING str_location := data_services.data_location.prefix('header_crosswalk');

  EXPORT STRING str_prefix := str_location + 'key::header_crosswalk::';

  // Use doxie to properly identify default sf version
  SHARED STRING str_sf_infix := doxie.Version_SuperKey;

  // Superfile Suffixes
  EXPORT STRING str_suffix_lnpid_2_lexid := '::lnpid_2_lexid';
  EXPORT STRING str_suffix_lexid_2_lnpid := '::lexid_2_lnpid';
  EXPORT STRING str_suffix_lexid_2_seleid := '::lexid_2_seleid';
  EXPORT STRING str_suffix_seleid_2_lexid := '::seleid_2_lexid';
  EXPORT STRING str_suffix_seleid_2_lnpid := '::seleid_2_lnpid';
  EXPORT STRING str_suffix_lnpid_2_seleid := '::lnpid_2_seleid';

  // Keynames
  EXPORT STRING str_lnpid_2_lexid := str_prefix + str_sf_infix + str_suffix_lnpid_2_lexid;
  EXPORT STRING str_lexid_2_lnpid := str_prefix + str_sf_infix + str_suffix_lexid_2_lnpid;
  EXPORT STRING str_lexid_2_seleid := str_prefix + str_sf_infix + str_suffix_lexid_2_seleid;
  EXPORT STRING str_seleid_2_lexid := str_prefix + str_sf_infix + str_suffix_seleid_2_lexid;
  EXPORT STRING str_seleid_2_lnpid := str_prefix + str_sf_infix + str_suffix_seleid_2_lnpid;
  EXPORT STRING str_lnpid_2_seleid := str_prefix + str_sf_infix + str_suffix_lnpid_2_seleid;

END;