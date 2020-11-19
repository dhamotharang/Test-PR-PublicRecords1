IMPORT doxie_cbrs;

EXPORT layout_report := RECORDOF(doxie_cbrs.all_base_records_prs());

  /*
  
  WORK IN PROGRESS: WILL BE DELETED LATER.

  ----->>> DONE:
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
  recprfr_v2 := $.layouts.profile_record_v2; // doxie_cbrs.profile_records_v2 -> doxie_cbrs.Corporation_Filings_records_v2q
  
  ----->>> TO BE DONE:
  recsrcr := $.layouts.souce_counts; 
  
  recbrer := RECORD // doxie_cbrs.business_registration_records_prs_max -> .. -> doxie_cbrs_raw.business_registrations
    UNSIGNED1 level;
    doxie_cbrs.layout_business_registration_records;
  END;

  recragr := RECORD // doxie_cbrs.registered_agents_records -> .. -> doxie_cbrs.Corporation_Filings_records
    Corp.Layout_Corp_Base.bdid;
    Corp.Layout_Corporate_Direct_Corp_In.corp_ra_name;
    Corp.Layout_Corp_Base.dt_last_seen;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    QSTRING5 zip;
    QSTRING4 zip4;
  END;

  contactrec := doxie_cbrs.layout_contacts_standardized;
  company_title_rec := RECORD
    contactrec.company_title;
    contactrec.bdid;
    contactrec.company_name;
  END;
  recconr := RECORD // doxie_cbrs.contactrecords_prs_trimmed -> doxie_cbrs.contactrecords_standardized
    contactrec.bdid;
    contactrec.did;
    contactrec.dt_last_seen;
    STRING9 ssn;
    contactrec.fname;
    contactrec.mname;
    contactrec.lname;
    contactrec.name_suffix;
    contactrec.prim_range;
    contactrec.predir;
    contactrec.prim_name;
    contactrec.addr_suffix;
    contactrec.postdir;
    contactrec.unit_desig;
    contactrec.sec_range;
    contactrec.city;
    contactrec.state;
    STRING5 zip;
    STRING4 zip4;
    DATASET(company_title_rec) company_titles {MAXCOUNT(25)};
  END;

  // safe to use doxie_cbrs.layout_contacts_standardized (instead of doxie_cbrs.layout_contacts) below.
  // diff: zip, zip4, phone, company_zip, company_zip4, company_phone, company_fein

  execrec := doxie_cbrs.layout_contacts;
  exect_title_rec := RECORD
    execrec.company_title;
    execrec.bdid;
    execrec.company_name;
  END;
  exec_record_base := RECORD
    execrec.bdid;
    execrec.did;
    execrec.dt_last_seen;
    execrec.fname;
    execrec.mname;
    execrec.lname;
    execrec.name_suffix;
  END;
  recexer := RECORD // doxie_cbrs.executives_records -> doxie_cbrs.contact_records -> doxie_cbrs.contact_records_raw 
    exec_record_base;
    DATASET(exect_title_rec) company_titles {MAXCOUNT(25)};
    UNSIGNED2 title_rank;
  END;

  recpror := RECORD // doxie_cbrs.property_records
    doxie_cbrs.layout_property_records;
  END;

  recpror_v2 := RECORD // doxie_cbrs.property_records_v2 -> LN_PropertyV2_Services.Embed_records
    LN_PropertyV2_Services.layouts.out_wider;
  END;

  recnodr := RECORD // doxie_cbrs.foreclosure_records
    iesp.foreclosure.t_ForeclosureReportRecord;
    BOOLEAN foreclosed;
  END;

  recforr := RECORD // doxie_cbrs.foreclosure_records
    iesp.foreclosure.t_ForeclosureReportRecord;
    BOOLEAN foreclosed;
  END;

  recmvrr := RECORD, MAXLENGTH(doxie_crs.maxlength_mv) // doxie_cbrs.Motor_Vehicle_Records_trimmed -> .. -> Doxie_Raw.Veh_Raw
    Doxie.Layout_VehicleSearch;
  END;
  recmvrr_v2 := RECORD // doxie_cbrs.Motor_Vehicle_Records_trimmed_v2 -> .. -> VehicleV2_Services.Functions.GetVehicleReport
    VehicleV2_Services.Layouts.Layout_Report_Batch_New;
  END;

  recwctr := RECORD, MAXLENGTH(doxie_crs.maxlength_wc) // doxie_cbrs.Watercraft_Records_trimmed -> .. -> Doxie_Raw.AirCraft_Raw
    watercraftV2_Services.layouts.report_out;
  END;

  recairr := RECORD, MAXLENGTH(doxie_crs.maxlength_ac) // doxie_cbrs.Aircraft_Records_trimmed
    doxie_crs.layout_Faa_Aircraft_records;
  END;

  intrec := domains.Layout_Whois_Base;
  recidor := RECORD //  doxie_cbrs.Internet_Domains_records_trimmed
    intrec.bdid;
    intrec.domain_name;
  END;

  plicrec := RECORD
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base - [global_sid, record_sid];
  END;
  recplir := RECORD // doxie_cbrs.proflic_records_trimmed -> doxie_cbrs.proflic_records_dayton
    plicrec.bdid;
    plicrec.did;
    plicrec.profession_or_board;
    plicrec.license_type;
    plicrec.company_name;
    plicrec.orig_name;
    plicrec.license_obtained_by;
    plicrec.board_action_indicator;
    plicrec.status;
    plicrec.source_st;
    plicrec.license_number;
    plicrec.orig_license_number;
    plicrec.orig_addr_1;
    plicrec.orig_addr_2;
    plicrec.orig_addr_3;
    plicrec.orig_addr_4;
    plicrec.orig_city;
    plicrec.orig_st;
    plicrec.orig_zip;
    // Added fields are below.
    plicrec.best_ssn;
    plicrec.date_last_seen;
    plicrec.status_effective_dt;
    plicrec.fname;
    plicrec.mname;
    plicrec.lname;
    plicrec.name_suffix;
    plicrec.title;
    plicrec.prim_name;
    plicrec.prim_range;
    plicrec.predir;
    plicrec.postdir;
    plicrec.suffix;
    plicrec.unit_desig;
    plicrec.sec_range;
    plicrec.st;
    plicrec.v_city_name;
    plicrec.zip;
    plicrec.zip4;
    plicrec.county_name;
    plicrec.phone;
    plicrec.additional_phone;
    plicrec.sex;
    plicrec.dob;
    plicrec.issue_date;
    plicrec.expiration_date;
    plicrec.last_renewal_date;
    plicrec.misc_occupation;
    plicrec.misc_practice_hours;
    plicrec.misc_practice_type;
    plicrec.misc_email;
    plicrec.misc_fax;
    plicrec.Action_complaint_violation_dt;
    plicrec.Action_effective_dt;
    plicrec.Action_Posting_Status_dt;
    plicrec.action_record_type;
    plicrec.Action_complaint_violation_desc;
    plicrec.Action_desc;
    plicrec.action_status;
    plicrec.education_continuing_education;
    plicrec.education_1_school_attended;
    plicrec.education_1_degree;
    plicrec.education_1_curriculum;
    plicrec.education_1_dates_attended;
    plicrec.education_2_school_attended;
    plicrec.education_2_degree;
    plicrec.education_2_curriculum;
    plicrec.education_2_dates_attended;
    plicrec.education_3_school_attended;
    plicrec.education_3_degree;
    plicrec.education_3_curriculum;
    plicrec.education_3_dates_attended;
    plicrec.additional_licensing_specifics;
    plicrec.personal_pob_desc;
    plicrec.personal_race_desc;
  END;

  recsupr := liens_superior.Layout_Liens_Superior_LNI;

  recbasr := RECORD // doxie_cbrs.business_associates_records_trimmed
    UNSIGNED6 bdid := 0; 
    QSTRING120 company_name;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    STRING5 zip := '';
    STRING4 zip4 := '';
  END;

  recebrr := RECORD // doxie_cbrs.experian_business_reports_trimmed -> doxie_cbrs.experian_business_reports_raw
    ebr_services.Layout_EBR_Report;
  END;

  recirsr := RECORD // doxie_cbrs.IRS5500_records_trimmed -> doxie_cbrs.IRS5500_records
    RECORDOF(irs5500.key_irs5500_BDID);
  END;

  dnbrec := RECORD
    DNB.Layout_DNB_Base -[global_sid, record_sid]; 
  END;
  recdnbr := RECORD // doxie_cbrs.dnb_records
    RECORDOF(dnbrec);
    STRING15 structure_type_decoded;
    STRING30 type_of_establishment_decoded;
    STRING5 owns_rents_decoded;
  END;

  recsancr := iesp.enhancedbizreport.t_EnhancedBizReportSanction; //  doxie.Ingenix_Business_records
  recsdivcert := iesp.diversitycertification.t_DiversityCertificationRecord;
  recsriskmetric := iesp.riskmetrics.t_RiskMetricsRecord;
  recslabor := iesp.laboraction_WHD.t_LaborActionWHDRecord;
  recsnatdis := iesp.naturaldisaster.t_NaturalDisasterRecord;
  recslnca := iesp.lncafirmographics.t_LNCARecord;
  recsequi := iesp.gateway_inviewreport.t_InviewReportResponse;

  EXPORT outrec := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
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

END;
*/

