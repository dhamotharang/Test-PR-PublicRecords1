IMPORT doxie, doxie_cbrs, doxie_cbrs_raw, LN_PropertyV2_Services;
doxie_cbrs.mac_Selection_Declare()

UNSIGNED3 get_Count(BOOLEAN included, UNSIGNED3 max_val, UNSIGNED3 count_shown, UNSIGNED3 count_simple) :=
  IF(NOT included OR (count_shown >= max_val),
     count_simple,
     count_shown);

EXPORT count_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                         doxie.IDataAccess mod_access,
                         UNSIGNED1 ofac_version = 1,
                         BOOLEAN include_ofac = FALSE,
                         real global_watchlist_threshold = 0.8
                         ) := DATASET([{
  get_Count(
    Include_CorporationFilings_val,
    Max_CorporationFilings_val,
    COUNT(doxie_cbrs.Corporation_Filings_records_prs_max(bdids)),
    doxie_cbrs_raw.Corporation_Filings(bdids).record_count(TRUE)),
  get_Count(
    Include_BusinessRegistrations_val,
    Max_BusinessRegistrations_val,
    doxie_cbrs.business_registration_records_prs_max(bdids).records_count,
    doxie_cbrs_raw.business_registrations(bdids).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.property_records_prs_byAddress(bdids)),
  (UNSIGNED3)COUNT(doxie_cbrs.property_records_prs_byBDID(bdids)),
  (UNSIGNED3)COUNT(LN_PropertyV2_Services.Embed_records(TRUE,,bdids,,,isPeopleWise)),
  get_Count(
    Include_Liens_val,
    Max_Liens_val,
    COUNT(doxie_cbrs.liens_v2_records_prs_max(bdids)),
    doxie_cbrs_raw.liens_v2(bdids,,,,mod_access.application_type).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.lien_records_prs(bdids)),
  (UNSIGNED3)COUNT(doxie_cbrs.judgement_records_prs(bdids)),
  (UNSIGNED3)COUNT(doxie_cbrs.bankruptcy_records_prs(bdids)),
  (UNSIGNED3)COUNT(doxie_cbrs.Patriot_records(ofac_version, include_ofac, global_watchlist_threshold)),
  get_Count(
    Include_UCCFilings_val,
    Max_UCCFilings_val,
    COUNT(doxie_cbrs.UCC_v2_Records_prs_max(bdids)),
    doxie_cbrs_raw.UCC_v2(bdids).record_count(TRUE)),
  get_Count(
    Include_UCCFilings_val,
    Max_UCCFilings_val,
    COUNT(doxie_cbrs.UCC_records_prs_max(bdids)),
    doxie_cbrs_raw.UCC_v2(bdids,Include_UCCFilings_val,Max_UCCFilings_val).legacy_count),
  get_Count(
    Include_AssociatedPeople_val,
    Max_AssociatedPeople_val,
    COUNT(doxie_cbrs.contact_records_prs_max(bdids)),
    doxie_Cbrs_Raw.contacts(bdids,,,mod_access.application_type).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.Associated_Business_records_prs(bdids,mod_access)),
  get_Count(
    Include_AssociatedBusinesses_val,
    max_AssociatedBusinesses_val,
    COUNT(doxie_cbrs.Associated_Business_byContact_records_max(bdids)),
    doxie_cbrs_raw.Associated_Business_byContact(bdids).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.DNB_records(bdids,mod_access)),
  get_Count(
    Include_InternetDomains_val,
    max_InternetDomains_val,
    COUNT(doxie_cbrs.Internet_Domains_records_max(bdids)),
    doxie_cbrs_raw.Internet_Domains(bdids).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.proflic_records_prs(bdids,mod_access)),
  (UNSIGNED3)COUNT(doxie_cbrs.BBB_records_prs(bdids)),
  (UNSIGNED3)COUNT(doxie_cbrs.BBB_records_prs(bdids)(bdid <> doxie_cbrs.subject_BDID)),
  get_Count(
    Include_BBB_val,
    Max_BBB_val,
    COUNT(doxie_cbrs.BBB_NM_records_prs_max(bdids)),
    doxie_cbrs_raw.BBB_NM(bdids).record_count(TRUE)),
  get_Count(
    Include_BBB_val,
    Max_BBB_val,
    COUNT(doxie_cbrs.BBB_NM_records_prs_max(bdids)(bdid <> doxie_cbrs.subject_BDID)),
    doxie_cbrs_raw.BBB_NM(bdids(bdid <> doxie_cbrs.subject_BDID)).record_count(TRUE)),
  (UNSIGNED3)COUNT(doxie_cbrs.others_at_address_records(bdids)),
  get_Count(
    Return_ReversePhone_val, //a little different since no direct key count
    Max_ReverseLookup_val,
    sum(doxie_cbrs.reverse_lookup_records_prs_max(bdids,mod_access), COUNT(listed_name_children)),
    COUNT(doxie_cbrs.reverse_lookup_records(bdids,mod_access,Include_ReversePhone_val))),
  get_Count(
    Include_NameVariations_val,
    Max_NameVariations_val,
    COUNT(doxie_cbrs.name_variation_records_max(bdids)),
    doxie_cbrs_raw.name_variations().record_count(TRUE)),
  get_Count(
    Include_YellowPages_val,
    Max_YellowPages_val,
    COUNT(doxie_cbrs.YellowPages_records_prs_max(bdids)),
    doxie_cbrs_raw.YellowPage(bdids).record_count(TRUE)),
  IF(doxie.DataRestriction.EBR,
    0,
    get_Count(
      Include_EBRSummary_val,
      Max_EBRSummary_val,
      COUNT(doxie_cbrs.EBR_Summary_records_prs_max(bdids)),
      doxie_Cbrs_raw.EBR_Summary(bdids).record_count(TRUE))),
  get_Count(
    Include_MotorVehicles_val,
    Max_MotorVehicles_val,
    COUNT(doxie_cbrs.motor_vehicle_records_prs_max(bdids,mod_access)),
    COUNT(doxie_cbrs.motor_vehicle_records_prs(bdids,mod_access))),
  
  }], {
  UNSIGNED3 corporation_filings_count,
  UNSIGNED3 business_registration_count,
  UNSIGNED3 property_count;
  UNSIGNED3 property_owned_count;
  UNSIGNED3 property2_count;
  UNSIGNED3 lien_v2_count,
  UNSIGNED3 lien_count,
  UNSIGNED3 judgement_count,
  UNSIGNED3 bankruptcy_count,
  UNSIGNED3 patriot_count,
  UNSIGNED3 ucc_v2_count,
  UNSIGNED3 ucc_count,
  UNSIGNED3 contact_count,
  UNSIGNED3 associated_business_count,
  UNSIGNED3 associated_byContact_count,
  UNSIGNED3 dnb_count,
  UNSIGNED3 Internet_Domains_count,
  UNSIGNED3 professional_license_count,
  UNSIGNED3 BBB_count,
  UNSIGNED3 BBB_AssociatesOnly_count,
  UNSIGNED3 BBB_NonMember_count,
  UNSIGNED3 BBB_NonMember_AssociatesOnly_count,
  UNSIGNED3 others_at_address_count,
  UNSIGNED3 reverse_lookup_count,
  UNSIGNED3 name_variation_count,
  UNSIGNED3 YellowPages_count,
  UNSIGNED3 EBR_summary_count,
  UNSIGNED3 vehicle_count
  });
