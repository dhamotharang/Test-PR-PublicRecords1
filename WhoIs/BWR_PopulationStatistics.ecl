﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','WhoIs.BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT WhoIs,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  WhoIs.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* did_field */,/* did_score_field */,/* process_date_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* date_vendor_first_reported_field */,/* date_vendor_last_reported_field */,/* clean_cname_field */,/* current_rec_field */,/* dotid_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,/* clean_title_field */,/* clean_fname_field */,/* clean_mname_field */,/* clean_lname_field */,/* clean_name_suffix_field */,/* clean_name_score_field */,/* rawaid_field */,/* append_prep_address_situs_field */,/* append_prep_address_last_situs_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* emailtype_field */,/* rawtext_field */,/* email_field */,/* name_field */,/* organization_field */,/* street1_field */,/* street2_field */,/* street3_field */,/* street4_field */,/* city_field */,/* state_field */,/* postalcode_field */,/* country_field */,/* fax_field */,/* faxext_field */,/* phone_field */,/* phoneext_field */,/* domainname_field */,/* registrarname_field */,/* contactemail_field */,/* whoisserver_field */,/* nameservers_field */,/* createddate_field */,/* updateddate_field */,/* expiresdate_field */,/* standardregcreateddate_field */,/* standardregupdateddate_field */,/* standardregexpiresdate_field */,/* status_field */,/* audit_auditupdateddate_field */,/* registrant_rawtext_field */,/* registrant_email_field */,/* registrant_name_field */,/* registrant_organization_field */,/* registrant_street1_field */,/* registrant_street2_field */,/* registrant_street3_field */,/* registrant_street4_field */,/* registrant_city_field */,/* registrant_state_field */,/* registrant_postalcode_field */,/* registrant_country_field */,/* registrant_fax_field */,/* registrant_faxext_field */,/* registrant_phone_field */,/* registrant_phoneext_field */,/* administrativecontact_rawtext_field */,/* administrativecontact_email_field */,/* administrativecontact_name_field */,/* administrativecontact_organization_field */,/* administrativecontact_street1_field */,/* administrativecontact_street2_field */,/* administrativecontact_street3_field */,/* administrativecontact_street4_field */,/* administrativecontact_city_field */,/* administrativecontact_state_field */,/* administrativecontact_postalcode_field */,/* administrativecontact_country_field */,/* administrativecontact_fax_field */,/* administrativecontact_faxext_field */,/* administrativecontact_phone_field */,/* administrativecontact_phoneext_field */,/* billingcontact_rawtext_field */,/* billingcontact_email_field */,/* billingcontact_name_field */,/* billingcontact_organization_field */,/* billingcontact_street1_field */,/* billingcontact_street2_field */,/* billingcontact_street3_field */,/* billingcontact_street4_field */,/* billingcontact_city_field */,/* billingcontact_state_field */,/* billingcontact_postalcode_field */,/* billingcontact_country_field */,/* billingcontact_fax_field */,/* billingcontact_faxext_field */,/* billingcontact_phone_field */,/* billingcontact_phoneext_field */,/* technicalcontact_rawtext_field */,/* technicalcontact_email_field */,/* technicalcontact_name_field */,/* technicalcontact_organization_field */,/* technicalcontact_street1_field */,/* technicalcontact_street2_field */,/* technicalcontact_street3_field */,/* technicalcontact_street4_field */,/* technicalcontact_city_field */,/* technicalcontact_state_field */,/* technicalcontact_postalcode_field */,/* technicalcontact_country_field */,/* technicalcontact_fax_field */,/* technicalcontact_faxext_field */,/* technicalcontact_phone_field */,/* technicalcontact_phoneext_field */,/* zonecontact_rawtext_field */,/* zonecontact_email_field */,/* zonecontact_name_field */,/* zonecontact_organization_field */,/* zonecontact_street1_field */,/* zonecontact_street2_field */,/* zonecontact_street3_field */,/* zonecontact_street4_field */,/* zonecontact_city_field */,/* zonecontact_state_field */,/* zonecontact_postalcode_field */,/* zonecontact_country_field */,/* zonecontact_fax_field */,/* zonecontact_faxext_field */,/* zonecontact_phone_field */,/* zonecontact_phoneext_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
