IMPORT PromoteSupers, roxiekeybuild, PRTE2_Neighborhood;

//Key Files - Keys are metadata so they are copies of Prod. Most are empty.
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'aca_institutions_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'neighborhoodstats::geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'businesses_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'sex_offender_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'schools::geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'colleges::geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'fbi_cius_city::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'fire_department_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'law_enforcement_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'geolink_to_geolink::geolink_dist_100th');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'geoblk_latlon');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'geoblk_info_geolink');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neighborhood', 'crime::geolink');