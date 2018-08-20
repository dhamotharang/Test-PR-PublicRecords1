import doxie, business_header, doxie_cbrs_raw, LN_PropertyV2_Services;
doxie_cbrs.mac_Selection_Declare()

unsigned3 get_Count(boolean included, unsigned3 max_val, unsigned3 count_shown, unsigned3 count_simple) :=
	if(not included or (count_shown >= max_val),
		 count_simple,
		 count_shown);

export count_records_prs(dataset(doxie_cbrs.layout_references) bdids, unsigned1 ofac_version = 1, boolean include_ofac = false, real global_watchlist_threshold = 0.8) := dataset([{
	get_Count(
		Include_CorporationFilings_val,
		Max_CorporationFilings_val,
		count(doxie_cbrs.Corporation_Filings_records_prs_max(bdids)),
		doxie_cbrs_raw.Corporation_Filings(bdids).record_count(true)),
	get_Count(
		Include_BusinessRegistrations_val,
		Max_BusinessRegistrations_val,
		doxie_cbrs.business_registration_records_prs_max(bdids).records_count,
		doxie_cbrs_raw.business_registrations(bdids).record_count(true)),
	(unsigned3)count(doxie_cbrs.property_records_prs_byAddress(bdids)),
	(unsigned3)count(doxie_cbrs.property_records_prs_byBDID(bdids)),
	(unsigned3)count(LN_PropertyV2_Services.Embed_records(true,,bdids,,,isPeopleWise)),
	get_Count(
		Include_Liens_val,
		Max_Liens_val,
		count(doxie_cbrs.liens_v2_records_prs_max(bdids)),
		doxie_cbrs_raw.liens_v2(bdids,,,,application_type_value).record_count(true)),
	(unsigned3)count(doxie_cbrs.lien_records_prs(bdids)),
	(unsigned3)count(doxie_cbrs.judgement_records_prs(bdids)),
	(unsigned3)count(doxie_cbrs.bankruptcy_records_prs(bdids)),
	(unsigned3)count(doxie_cbrs.Patriot_records(ofac_version, include_ofac, global_watchlist_threshold)),
	get_Count(
		Include_UCCFilings_val,
		Max_UCCFilings_val,
		count(doxie_cbrs.UCC_v2_Records_prs_max(bdids)),
		doxie_cbrs_raw.UCC_v2(bdids).record_count(true)),
	get_Count(
		Include_UCCFilings_val,
		Max_UCCFilings_val,
		count(doxie_cbrs.UCC_records_prs_max(bdids)),
		doxie_cbrs_raw.UCC_v2(bdids,Include_UCCFilings_val,Max_UCCFilings_val).legacy_count),
	get_Count( 
		Include_AssociatedPeople_val,
		Max_AssociatedPeople_val,
		count(doxie_cbrs.contact_records_prs_max(bdids)), 
		doxie_Cbrs_Raw.contacts(bdids,,,application_type_value).record_count(true)),
	(unsigned3)count(doxie_cbrs.Associated_Business_records_prs(bdids)),
	get_Count(
		Include_AssociatedBusinesses_val,
		max_AssociatedBusinesses_val,
		count(doxie_cbrs.Associated_Business_byContact_records_max(bdids)),
		doxie_cbrs_raw.Associated_Business_byContact(bdids).record_count(true)),
	(unsigned3)count(doxie_cbrs.DNB_records(bdids)),
	get_Count(
		Include_InternetDomains_val,
		max_InternetDomains_val,
		count(doxie_cbrs.Internet_Domains_records_max(bdids)),
		doxie_cbrs_raw.Internet_Domains(bdids).record_count(true)),
	(unsigned3)count(doxie_cbrs.proflic_records_prs(bdids)),
	(unsigned3)count(doxie_cbrs.BBB_records_prs(bdids)),
	(unsigned3)count(doxie_cbrs.BBB_records_prs(bdids)(bdid <> doxie_cbrs.subject_BDID)),
	get_Count(
		Include_BBB_val,
		Max_BBB_val,
		count(doxie_cbrs.BBB_NM_records_prs_max(bdids)),
		doxie_cbrs_raw.BBB_NM(bdids).record_count(true)),
	get_Count(
		Include_BBB_val,
		Max_BBB_val,
		count(doxie_cbrs.BBB_NM_records_prs_max(bdids)(bdid <> doxie_cbrs.subject_BDID)),
		doxie_cbrs_raw.BBB_NM(bdids(bdid <> doxie_cbrs.subject_BDID)).record_count(true)),
	(unsigned3)count(doxie_cbrs.others_at_address_records(bdids)),
	get_Count(
		Return_ReversePhone_val, //a little different since no direct key count
		Max_ReverseLookup_val,
		sum(doxie_cbrs.reverse_lookup_records_prs_max(bdids), count(listed_name_children)),
		count(doxie_cbrs.reverse_lookup_records(bdids))),
	get_Count(
		Include_NameVariations_val,
		Max_NameVariations_val,
		count(doxie_cbrs.name_variation_records_max(bdids)),
		doxie_cbrs_raw.name_variations().record_count(true)),
	get_Count(
		Include_YellowPages_val,
		Max_YellowPages_val,
		count(doxie_cbrs.YellowPages_records_prs_max(bdids)),
		doxie_cbrs_raw.YellowPage(bdids).record_count(true)),
	if(doxie.DataRestriction.EBR,
		0,
		get_Count(
			Include_EBRSummary_val,
			Max_EBRSummary_val,
			count(doxie_cbrs.EBR_Summary_records_prs_max(bdids)),
			doxie_Cbrs_raw.EBR_Summary(bdids).record_count(true))),
	get_Count(
		Include_MotorVehicles_val,
		Max_MotorVehicles_val,
		count(doxie_cbrs.motor_vehicle_records_prs_max(bdids)),
		count(doxie_cbrs.motor_vehicle_records_prs(bdids))),
	
	}], {
	unsigned3 corporation_filings_count,
	unsigned3 business_registration_count,
	unsigned3 property_count;
	unsigned3 property_owned_count;
	unsigned3 property2_count;
	unsigned3 lien_v2_count,
	unsigned3 lien_count,
	unsigned3 judgement_count,
	unsigned3 bankruptcy_count,
	unsigned3 patriot_count,
	unsigned3 ucc_v2_count,
	unsigned3 ucc_count,
	unsigned3 contact_count,
	unsigned3 associated_business_count,
	unsigned3 associated_byContact_count,
	unsigned3 dnb_count,
	unsigned3 Internet_Domains_count,
	unsigned3 professional_license_count,
	unsigned3 BBB_count,
	unsigned3 BBB_AssociatesOnly_count,
	unsigned3 BBB_NonMember_count,
	unsigned3 BBB_NonMember_AssociatesOnly_count,
	unsigned3 others_at_address_count,
	unsigned3 reverse_lookup_count,
	unsigned3 name_variation_count,
	unsigned3 YellowPages_count,
	unsigned3 EBR_summary_count,
	unsigned3 vehicle_count
	});