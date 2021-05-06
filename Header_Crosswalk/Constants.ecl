IMPORT _Control;

EXPORT Constants := MODULE

  // LNPID
  EXPORT SET OF STRING set_lnpid_tier1 := ['CORE','CORE_DEAONLY','CORE_LICONLY', 'CORE_NPIONLY','NO_IDENTIFIER','OLD'];
  EXPORT SET OF STRING set_lnpid_tier2 := ['CURRENT_FRAG','CURRENT_FRAG_DEA','CURRENT_FRAG_LIC','CURRENT_FRAG_NPI','OLD_FRAG','OLD_FRAG_DEA','OLD_FRAG_LIC','OLD_FRAG_NPI'];

  EXPORT STRING str_lnpid_segmentation := '~foreign::10.194.152.52:7070::thor::healthcare_provider_header::segmentation_general::current';

  // Email list
  EXPORT STRING str_default_email_list := 'matheus.depaulo@lexisnexisrisk.com,ashish.tiwari@lexisnexisrisk.com';
  EXPORT STRING str_orbit_email_list := 'Anantha.Venkatachalam@lexisnexis.com,' + str_default_email_list;

  // Key copying
  EXPORT STRING str_copy_sf := '~thor::header_crosswalk::copy_log';

  EXPORT STRING str_alpha_target := 'hthor_prod_eclcc';
  EXPORT STRING str_alpha_esp := _Control.IPAddress.aprod_thor_esp;
  EXPORT STRING str_hc_target := 'hthor_hc_mdm_production_alpha';
  EXPORT STRING str_hc_esp := '10.194.42.29';

  // DOPS and ORBIT
  EXPORT STRING str_orbit_masterbuild := 'HeaderCrosswalk';
  EXPORT STRING str_orbit_build := 'Header Crosswalk Build';
  EXPORT STRING str_orbit_platforms := 'Production NonFCRA';
  EXPORT STRING str_dops_dataset := 'HeaderCrosswalkKeys';
  EXPORT STRING str_dops_non_fcra_environment := 'N';
  EXPORT STRING str_dops_hc_environment := 'H';

  // Build Summary
  EXPORT STRING str_build_summary_sf := '~thor::header_crosswalk::build_summary';

END;