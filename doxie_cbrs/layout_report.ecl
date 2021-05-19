IMPORT $, doxie_crs, ebr_services, iesp, irs5500, liens_superior, LN_PropertyV2_Services;

recbesr := $.layouts.best_info_record; // doxie_cbrs.fn_best_information
reccompverr := RECORDOF(iesp.share.t_CompanyVerification);
recphonesumr := RECORDOF(iesp.phonesummary.t_PhoneSummaryRecord); //doxie.fn_get_phone_summary
recupcr := $.layouts.upcr_record; // doxie_cbrs.ultimate_parent_information
recnmvr := $.layouts.name_variation_record; // doxie_cbrs.name_variations_base
recadvr := $.layouts.addr_variation_record; // doxie_cbrs.address_variations_base
recphvr := $.layouts.phone_variation_record; // doxie_cbrs.phone_variations_base
recdcar := $.layouts.dca_slim_record; // doxie_cbrs.DCA_records_trimmed
recsalr := $.layouts.sales_record; // doxie_cbrs.sales_records_trimmed
recindr := $.layouts.industry_info_slim_record; // doxie_cbrs.industry_information_records_trimmed
recidnr := $.layouts.id_num_record; // doxie_cbrs.ID_Number_records_base
recbnkr := $.layouts.bankruptcy_slim_record; // doxie_cbrs.bankruptcy_records_trimmed
recbnkr_v2 := $.layouts.bankruptcy_slim_record_v2; // doxie_cbrs.bankruptcy_records_trimmed_v2
recljur := $.layouts.lj_ucc_record_slim;
recljur_v2 := $.layouts.lj_ucc_record_slim_v2;
recprfr := $.layouts.profile_record;
recprfr_v2 := $.layouts.profile_record_v2; // doxie_cbrs.profile_records_v2 -> doxie_cbrs.Corporation_Filings_records_v2
recragr := $.layouts.registered_agent_record; // doxie_cbrs.registered_agents_records
recbrer := $.layout_business_registration_records; // doxie_cbrs.business_registration_records_prs_max -> .. -> doxie_cbrs_raw.business_registrations
recconr := $.layout_contact.slim_rec_with_titles; // doxie_cbrs.contactrecords_prs_trimmed -> doxie_cbrs.contactrecords_standardized
recexer := $.layout_contact.exec_with_titles_rec; // doxie_cbrs.executives_records -> doxie_cbrs.contact_records -> doxie_cbrs.contact_records_raw 
recpror := $.layout_property_records; // doxie_cbrs.property_records
recpror_v2 := LN_PropertyV2_Services.layouts.out_wider; // doxie_cbrs.property_records_v2 -> LN_PropertyV2_Services.Embed_records
recnodr := $.layouts.foreclosure_record; // doxie_cbrs.foreclosure_records
recforr := $.layouts.foreclosure_record;  // doxie_cbrs.foreclosure_records
recmvrr := $.layouts.mvr_record; // doxie_cbrs.Motor_Vehicle_Records_trimmed -> .. -> Doxie_Raw.Veh_Raw
recmvrr_v2 := $.layouts.mvr_record_v2; // doxie_cbrs.Motor_Vehicle_Records_trimmed_v2 -> .. -> VehicleV2_Services.Functions.GetVehicleReport
recwctr := $.layouts.watercraft_record; // doxie_cbrs.Watercraft_Records_trimmed 
recairr := $.layouts.faa_record; // // doxie_cbrs.Aircraft_Records_trimmed
recidor := $.layouts.internet_domains_slim_record;// doxie_cbrs.Internet_Domains_records_trimmed

recplir := $.layout_proflic.slim_rec; // doxie_cbrs.proflic_records_trimmed -> doxie_cbrs.proflic_records_dayton
recsupr := liens_superior.Layout_Liens_Superior_LNI;
recbasr := $.layout_business_associates.slim_rec; // doxie_cbrs.business_associates_records_trimmed
recebrr := ebr_services.Layout_EBR_Report; // doxie_cbrs.experian_business_reports_trimmed -> doxie_cbrs.experian_business_reports_raw
recirsr := irs5500.layout_irs5500_base; // doxie_cbrs.IRS5500_records_trimmed -> doxie_cbrs.IRS5500_records
recdnbr := $.layouts.dnb_record; // doxie_cbrs.dnb_records
recsancr := iesp.enhancedbizreport.t_EnhancedBizReportSanction; //  doxie.Ingenix_Business_records
recsdivcert := iesp.diversitycertification.t_DiversityCertificationRecord;
recsriskmetric := iesp.riskmetrics.t_RiskMetricsRecord;
recslabor := iesp.laboraction_WHD.t_LaborActionWHDRecord;
recsnatdis := iesp.naturaldisaster.t_NaturalDisasterRecord;
recslnca := iesp.lncafirmographics.t_LNCARecord;
recsequi := iesp.gateway_inviewreport.t_InviewReportResponse;
recsrcr := $.layout_report_src.source_counts; 
recflag := $.layout_report_src.source_flags;
recMoreCounts := $.layout_report_src.source_counts_more;

EXPORT layout_report := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
  DATASET(recbesr) Best_Information;
  DATASET(reccompverr) Company_Verification {xpath('CompanyVerification'), MAXCOUNT(doxie_crs.constants.max_verification)};
  DATASET(recphonesumr) Phone_Summary{xpath('PhoneSummary'), MAXCOUNT(doxie_crs.constants.max_phone_summary)};
  DATASET(recupcr) Ultimate_Parent_Information;
  DATASET(recnmvr) Name_Variations;
  DATASET(recadvr) Address_Variations;
  DATASET(recphvr) Phone_Variations;
  DATASET(recdcar) Parent_Company;
  DATASET(recsalr) Sales;
  DATASET(recindr) Industry_Information;
  DATASET(recidnr) ID_Numbers;
  DATASET(recbnkr) Bankruptcy;
  DATASET(recbnkr_v2) Bankruptcy_v2;
  DATASET(recljur) Liens_Judgments;
  DATASET(recljur_v2) Liens_Judgments_v2;
  DATASET(recprfr) Profile_Information;
  DATASET(recprfr_v2) Profile_Information_v2;
  
  DATASET(recbrer) Business_Registrations;
  DATASET(recragr) Registered_Agents;
  DATASET(recconr) Contacts;
  DATASET(recexer) Executives;
  //Only LEXIS no FARES
  DATASET(recpror) Property;
  DATASET(recpror_v2) Property_v2;
  DATASET(recnodr) NoticeOfDefaults{xpath('NoticesOfDefaults/NoticeOfDefaults')};
  DATASET(recforr) Foreclosures{xpath('Foreclosures/Foreclosure')};
  DATASET(recmvrr) Motor_Vehicles; // GCL - 20051026
  DATASET(recmvrr_v2) Motor_Vehicles_v2;
  DATASET(recwctr) Watercrafts; // GCL - 20051026
  DATASET(recairr) Aircrafts; // GCL - 20051026
  DATASET(recidor) Internet;
  DATASET(recplir) Professional_Licenses;
  DATASET(recsupr) Superior_Liens;
  DATASET(recbasr) Business_Associates;
  DATASET(recebrr) Experian_Business_Reports;
  DATASET(recirsr) IRS5500;
  DATASET(recdnbr) DNB;
  DATASET(recsancr) Business_Sanctions{xpath('BusinessSanctions/BusinessSanction')};
  DATASET(recsdivcert) DiversityCertification{xpath('DiversityCertifications/DiversityCertification')};
  DATASET(recsriskmetric) RiskMetrics{xpath('RiskMetrics/RiskMetric')};
  DATASET(recslabor) LaborActionWHD{xpath('LaborActionsWHD/LaborActionWHD')};
  DATASET(recsnatdis) NaturalDisaster{xpath('NaturalDisasters/NaturalDisaster')};
  DATASET(recslnca) LNCAFirmographics{xpath('LNCAFirmographics/LNCAFirmographic')};
  
  DATASET(recsequi) EquifaxBusinessReport{xpath('EquifaxBusinessReport')};
  DATASET(recsrcr) Source_Counts; // TODO: why this is a dataset and not just a row?
  DATASET(recflag) SOURCE_FLAGS;
  DATASET(recMoreCounts) Source_Counts_more;
END;


