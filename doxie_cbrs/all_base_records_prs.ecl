IMPORT Business_Header, doxie, doxie_cbrs, doxie_crs, iesp, liens_superior;

doxie_cbrs.mac_Selection_Declare()

// NOTE: This attribute is referenced several times as "record of". Per Ricardo, we are
// calling this ONE attribute an exception due to this fact and have left the
// mod_access defaulted here. With future plans of modifying the "record of" references
// in the various attributes and removing this default also.
EXPORT all_base_records_prs(
  DATASET(doxie_cbrs.layout_references) bdids = DATASET([],doxie_cbrs.layout_references),
  doxie.IDataAccess mod_access = MODULE(doxie.IDataAccess) END
) := FUNCTION

//
// SL based limits for a Report, where possible
//
#STORED('MaxNameVariations',100);
#STORED('MaxPhoneVariations',100);
#STORED('MaxAddressVariations',100);
#STORED('MaxProfessionalLicenses',50);
#STORED('MaxAssociatedPeople',500);
#STORED('MaxInternetDomains',50);
#STORED('MaxBankruptcies',50);
#STORED('MaxProperties',150);
#STORED('MaxMotorVehicles',50); // GCL - 20051026
#STORED('MaxWatercrafts',50); // GCL - 20051026
#STORED('MaxAircrafts',50); // GCL - 20051026
#STORED('MaxExecutives',200);
#STORED('MaxDCA',50);
#STORED('MaxSales',50);
#STORED('MaxIndustryInformation',100);
#STORED('MaxUCCFilings',100); // 100 UCCs
#STORED('MaxLiensJudgmentsUCC',100); // 100 LJs - doesn't affect UCC see MaxUCCFilings
#STORED('MaxParentCompany',50);
#STORED('MaxRegisteredAgents',50);
#STORED('MaxCompanyIDnumbers',100);
#STORED('MaxBusinessAssociates',150);
#STORED('MaxExperianBusinessReports',25);
#STORED('MaxIRS5500',50);

name_table := DEDUP(table(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),company_name),{company_name,name_source_id}));
addr_table := DEDUP(table(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),state,zip,prim_name,prim_range,sec_range),{state,zip,prim_name,prim_range,sec_range,addr_source_id}));
phone_table := DEDUP(table(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),phone),{phone,phone_source_id}));
is_knowx := mod_access.isConsumer();
SHARED con := doxie_crs.constants;

//***** MY RECORDSETS
temp_besr := CHOOSEN(doxie_cbrs.fn_best_information(bdids,FALSE),1);

rec_besr := doxie_cbrs.layouts.best_info_record;
rec_besr add_bdid(temp_besr l) := TRANSFORM
  SELF.bdid := business_header.stored_bdid_val; //FIX --
  SELF.name_source_id := 0;
  SELF.addr_source_id := 0;
  SELF.phone_source_id := 0;
  SELF := l;
END;
rec_besr add_name_source_id(rec_besr l, name_table r) := TRANSFORM
  SELF.name_source_id := r.name_source_id;
  SELF := l;
END;
rec_besr add_addr_source_id(rec_besr l, addr_table r) := TRANSFORM
  SELF.addr_source_id := r.addr_source_id;
  SELF := l;
END;
rec_besr add_phone_source_id(rec_besr l, phone_table r) := TRANSFORM
  SELF.phone_source_id := r.phone_source_id;
  SELF := l;
END;

besr := JOIN(JOIN(JOIN(PROJECT(temp_besr,add_bdid(LEFT)),name_table,
                       LEFT.company_name=RIGHT.company_name,
                       add_name_source_id(LEFT,RIGHT),LEFT OUTER),addr_table,
                       LEFT.state=RIGHT.state AND
                       LEFT.zip=RIGHT.zip AND
                       LEFT.prim_name=RIGHT.prim_name AND
                       LEFT.prim_range=RIGHT.prim_range AND
                       LEFT.sec_range=RIGHT.sec_range,
                       add_addr_source_id(LEFT,RIGHT),LEFT OUTER),phone_table,
                       LEFT.phone=RIGHT.phone,
                       add_phone_source_id(LEFT,RIGHT),LEFT OUTER);

// FIX -- move this to an appropriate place
BOOLEAN bdids_Derived := FALSE : STORED('bdidsDerived');

upcr := doxie_cbrs.ultimate_parent_information(bdids)((multibdid OR bdids_Derived) AND (fromDCA));
//Phone summary and company verification from business instant id
biid := doxie_cbrs.getBizReportBDIDs(mod_access).biid; //Business InstantId Search.
phonesumr := CHOOSEN(doxie.fn_get_phone_summary(biid),con.max_phone_summary);
compverr := CHOOSEN(doxie.fn_get_company_verification(biid),con.max_verification);
nmvr := doxie_cbrs.name_variations_base(bdids);
advr := doxie_cbrs.address_variations_base(bdids);
phvr := doxie_cbrs.phone_variations_base(bdids);
idnr := doxie_cbrs.ID_Number_records_base(bdids);
bnkr := doxie_cbrs.bankruptcy_records_trimmed(bdids);
bnkr_v2 := doxie_cbrs.bankruptcy_records_trimmed_v2(bdids, mod_access.ssn_mask);
ljur := doxie_cbrs.Liens_Judgments_UCC_records_trimmed(bdids, mod_access.ssn_mask);
ljur_v2 := doxie_cbrs.Liens_Judgments_UCC_records_trimmed_v2(bdids,mod_access.ssn_mask);
prfr := doxie_cbrs.profile_records(bdids);
prfr_v2 := doxie_cbrs.profile_records_v2(bdids);

ragr := doxie_cbrs.registered_agents_records(bdids);
exer := doxie_cbrs.executives_records(bdids);
conr := doxie_cbrs.contact_records_prs_trimmed(bdids);
// reuse what was done for profile report
pre_pror := doxie_cbrs.property_records(bdids)(Include_Properties_val AND byBDID);
pror := CHOOSEN(IF(doxie.DataRestriction.Fares,pre_pror(ln_fares_id[1] <>'R'),pre_pror),Max_Properties_val);
pror_v2 := doxie_cbrs.property_records_v2(bdids);
nodr := doxie_cbrs.foreclosure_records(bdids,TRUE);
forr := doxie_cbrs.foreclosure_records(bdids,FALSE);
mvrr := doxie_cbrs.Motor_Vehicle_Records_trimmed(bdids); // GCL - 20051026
mvrr_v2 := doxie_cbrs.Motor_Vehicle_Records_trimmed_v2(bdids);
wctr := doxie_cbrs.Watercraft_Records_trimmed(bdids); // GCL - 20051026
airr := doxie_cbrs.Aircraft_Records_trimmed(bdids); // GCL - 20051026
idor := doxie_cbrs.Internet_Domains_records_trimmed(bdids);
plir := doxie_cbrs.proflic_records_trimmed(bdids);
brer := doxie_cbrs.business_registration_records_prs_max(bdids);

// DCA data
dcar := doxie_cbrs.DCA_records_trimmed(bdids); // parent company section - dca data
salr := doxie_cbrs.sales_records_trimmed(bdids); // dca data
indr := doxie_cbrs.industry_information_records_trimmed(bdids); // dca data

basr := doxie_cbrs.business_associates_records_trimmed(bdids, mod_access); 
dnbr := doxie_cbrs.dnb_records(bdids, mod_access)(Include_DunBradstreetRecords_val);
ebrr := doxie_cbrs.experian_business_reports_trimmed(bdids);
irsr := doxie_cbrs.IRS5500_records_trimmed(bdids);
sancr := doxie.Ingenix_Business_records(bdids).records;
srcr := doxie_cbrs.count_records_prs_dayton(bdids, mod_access);
divcert := doxie_cbrs.diversity_cert_records(bdids);
riskMet := doxie_cbrs.risk_metrics_records(bdids);
laborAct := doxie_cbrs.laborActions_WHD_records(bdids);
natdis := doxie_cbrs.natural_disaster_records(bdids);
lncar := doxie_cbrs.lnca_hierarchy_records(bdids);

// add in the counts for the sections

doxie_cbrs.layout_report_src.source_counts add_sect_counts(doxie_cbrs.layout_source_counts L) := TRANSFORM
  SELF.Name_Variations_Section := nmvr.records_count;
  SELF.Address_Variations_Section := advr.records_count;
  SELF.Phone_Variations_Section := phvr.records_count;
  SELF.Parent_Company_Section := dcar.records_count;
  SELF.Sales_Section := salr.records_count;
  SELF.Industry_Information_Section := indr.records_count;
  SELF.ID_Numbers_Section := idnr.records_count;
  SELF.Bankruptcy_Section := bnkr.records_count;
  SELF.Bankruptcy_Section_v2 := bnkr_v2.records_count;
  SELF.Liens_Judgments_Section := ljur.records_count;
  SELF.Liens_Judgments_Section_v2 := ljur_v2.records_count;
  SELF.Profile_Information_Section := prfr.records_count;
  SELF.Profile_Information_Section_v2 := prfr_v2.records_count;
  SELF.Business_Registration_Section := brer.records_count;
  SELF.Registered_Agents_Section := ragr.records_count;
  SELF.Contacts_Section := conr.records_count;
  SELF.Executives_Section := exer.records_count;
  SELF.Property_Section := COUNT(pror); // Same as Report Returns for now.
  SELF.Property_Section_v2 := COUNT(pror_v2.recs_trimmed);
  SELF.MotorVehicle_Section := IF(NOT is_knowx,mvrr.records_count,0); // GCL - 20051026
  SELF.MotorVehicle_Section_v2 := IF(NOT is_knowx,mvrr_v2.records_count,0);
  SELF.Watercraft_Section := IF(NOT is_knowx,wctr.records_count,0); // GCL - 20051026
  SELF.Aircraft_Section := IF(NOT is_knowx,airr.records_count,0); // GCL - 20051026
  SELF.Internet_Section := idor.records_count;
  SELF.Professional_Licenses_Section := plir.records_count;
  SELF.Business_Associates_Section := basr.records_count;
  SELF.Experian_Business_Reports_Section := IF(NOT is_knowx,ebrr.records_count,0);
  SELF.IRS5500_Section := irsr.records_count;
  SELF.DNB_Section := COUNT(dnbr);
  SELF.DiversityCertification_Section := divcert.records_count;
  SELF.RiskMetrics_Section := riskMet.records_count;
  SELF.LaborActionWHD_Section := laborAct.records_count;
  SELF.NaturalDisaster_Section := natdis.records_count;
  SELF.LNCAFirmographics_Section := lncar.records_count;
  SELF.EquifaxBusinessReport_Section := 0; // a place holder for external callers
  SELF := L;
END;
 
srcr_plus_sections := PROJECT(srcr,add_sect_counts(LEFT))(Include_SourceCounts_val);

doxie_cbrs.layout_report_src.source_counts_more add_sect_more(srcr L) := TRANSFORM
  SELF.Name_Variations_Section_more := nmvr.records_count > Max_NameVariations_val;
  SELF.Address_Variations_Section_more := advr.records_count > Max_AddressVariations_val;
  SELF.Phone_Variations_Section_more := phvr.records_count > Max_PhoneVariations_val;
  SELF.Parent_Company_Section_more := dcar.records_count > Max_ParentCompany_val;
  SELF.Sales_Section_more := salr.records_count > Max_Sales_val;
  SELF.Industry_Information_Section_more := indr.records_count > Max_IndustryInfo_val;
  SELF.ID_Numbers_Section_more := idnr.records_count > Max_CompanyIDnumbers_val; // no MAX value defined.
  SELF.Bankruptcy_Section_more := bnkr.records_count > Max_Bankruptcies_val;
  SELF.Bankruptcy_Section_V2_more := bnkr_v2.records_count > Max_BankruptciesV2_val;
  SELF.Liens_Judgments_Section_more := ljur.records_count > Max_LiensJudgmentsUCC_val;
  SELF.Liens_Judgments_Section_v2_more := ljur_v2.records_count > Max_LiensJudgmentsUCCV2_val;
  SELF.Profile_Information_Section_more := prfr.records_count > Max_CorporationFilings_val;
  SELF.Profile_Information_Section_v2_more := prfr_v2.records_count > Max_CorporationFilings_val;
  SELF.Business_Registration_Section_more := brer.records_count > Max_BusinessRegistrations_val;
  SELF.Registered_Agents_Section_more := ragr.records_count > Max_RegisteredAgents_val;
  SELF.Contacts_Section_more := conr.records_count > Max_AssociatedPeople_val;
  SELF.Executives_Section_more := exer.records_count > Max_Executives_val;
  SELF.Property_Section_more := COUNT(pror) > Max_Properties_val;
  SELF.Property_Section_v2_more := COUNT(pror_v2.all_recs) > Max_PropertiesV2_val;
  SELF.MotorVehicle_Section_more := IF(NOT is_knowx,mvrr.records_count,0) > Max_MotorVehicles_val;
  SELF.MotorVehicle_Section_v2_more := IF(NOT is_knowx,mvrr_v2.records_count_nolimit,0) > Max_MotorVehicles_val;
  SELF.Watercraft_Section_more := IF(NOT is_knowx,wctr.records_count,0) > Max_Watercrafts_val;
  SELF.Aircraft_Section_more := IF(NOT is_knowx,airr.records_count,0) > Max_Aircrafts_val;
  SELF.Internet_Section_more := idor.records_count > Max_InternetDomains_val;
  SELF.Professional_Licenses_Section_more := plir.records_count > Max_ProfessionalLicenses_val;
  SELF.Business_Associates_Section_more := basr.records_count > Max_BusinessAssociates_val;
  SELF.Experian_Business_Reports_Section_more := IF(NOT is_knowx,ebrr.records_count,0) > Max_Experian_Business_Reports_val;
  SELF.IRS5500_Section_more := irsr.records_count > Max_IRS5500_val;
  SELF.DNB_Section_more := COUNT(dnbr) > Max_CompanyIDnumbers_val;
  SELF.DiversityCertification_Section_more := divcert.records_count > Max_DiversityCert_val;
  SELF.RiskMetrics_Section_more := RiskMet.records_count > Max_RiskMetrics_val;
  SELF.LaborActionWHD_Section_more := laboract.records_count > Max_LaborActWHD_val;
  SELF.NaturalDisaster_Section_more := natdis.records_count > Max_NatDisReady_val;
  SELF := L;
END;

srcr_more_section := PROJECT(srcr, add_sect_more(LEFT))(Include_SourceCounts_val);

doxie_cbrs.layout_report_src.source_flags into_flags(srcr L, INTEGER C) := TRANSFORM
  SELF.field_present := CHOOSE(C,
    IF (L.FINDER != 0,'FINDER', SKIP),
    IF (L.DNB != 0, 'DNB', SKIP),
    IF (L.EXPERIAN_BUSINESS_REPORTS != 0 AND NOT is_knowx, 'EXPERIAN_BUSINESS_DATA', SKIP),
    IF (L.IRS5500 != 0, 'IRS', SKIP),
    IF (L.CORPORATE_FILINGS != 0, 'CORPORATE_FILINGS', SKIP),
    IF (L.CORPORATE_FILINGS_V2 != 0, 'CORPORATE_FILINGS_V2', SKIP),
    IF (L.BANKRUPTCY != 0, 'BANKRUPTCY', SKIP),
    IF (L.BANKRUPTCY_v2 != 0, 'BANKRUPTCY_V2', SKIP),
    IF (L.UCCS != 0, 'UCCS', SKIP),
    IF (L.UCCS_v2 != 0, 'UCCS_V2', SKIP),
    IF (L.LIENS_JUDGMENTS != 0, 'LIENS_JUDGMENTS', SKIP),
    IF (L.LIENS_JUDGMENTS_v2 != 0, 'LIENS_JUDGMENTS_V2', SKIP),
    IF (L.CONTACTS != 0, 'CONTACTS', SKIP),
    IF (l.PROPERTY != 0, 'PROPERTY', SKIP),
    IF (l.PROPERTY_V2 != 0, 'PROPERTY_V2', SKIP),
    IF (L.INTERNET != 0, 'INTERNET', SKIP),
    IF (L.PROFESSIONAL_LICENSES != 0, 'PROFESSIONAL_LICENSES', SKIP),
    IF (L.BUSINESS_REGISTRATIONS != 0, 'BUSINESS_REGISTRATIONS', SKIP),
    IF (L.NOTICE_OF_DEFAULTS != 0, 'NOTICE_OF_DEFAULTS', SKIP),
    IF (L.FORECLOSURES != 0, 'FORECLOSURES', SKIP),
    IF (L.BUSINESS_SANCTIONS != 0, 'BUSINESS_SANCTIONS', SKIP),
    IF (nmvr.records_count > 0, 'NAME_VARIATIONS', SKIP),
    IF (advr.records_count > 0, 'ADDRESS_VARIATIONS', SKIP),
    IF (phvr.records_count > 0, 'PHONE_VARIATIONS', SKIP),
    IF (idnr.records_count > 0, 'ID_NUMBERS', SKIP),
    IF (ljur.records_count > 0, 'LIENS_JUDGMENTS_UCCS', SKIP),
    IF (ljur_v2.records_count > 0, 'LIENS_JUDGMENTS_UCCS_V2', SKIP),
    IF (prfr.records_count > 0, 'PROFILE_INFORMATION', SKIP),
    IF (prfr_v2.records_count > 0, 'PROFILE_INFORMATION_V2', SKIP),
    IF (ragr.records_count > 0, 'REGISTERED_AGENTS', SKIP),
    IF (ragr.records_count > 0, 'REGISTERED_AGENTS_V2', SKIP),
    IF (mvrr.records_count > 0, 'MOTOR_VEHICLES', SKIP), // GCL - 20051026
    IF (mvrr_v2.records_count > 0, 'MOTOR_VEHICLES_V2', SKIP),
    IF (wctr.records_count > 0, 'WATERCRAFTS', SKIP), // GCL - 20051026
    IF (airr.records_count > 0, 'AIRCRAFTS', SKIP), // GCL - 20051026
    SKIP);
END;

//recflags1 := normalize(srcr,18,into_flags(LEFT,COUNTER));
recflags1 := NORMALIZE(srcr,35,into_flags(LEFT,COUNTER))(Include_SourceFlags_val); // GCL - 20051026

//***** SYNTAX REQUIRES THAT I CREATE A NAME FOR THE LAYOUT OF SOME (CANNOT ASSIGN TABLE OF UNNAMED...)
mac_give_name(r, outr) := MACRO
  #uniquename(rec)
  #uniquename(renameit)
  %rec% := RECORDOF(r);
  %rec% %renameit%(r l) := TRANSFORM
    SELF := l;
  END;
  outr := PROJECT(r, %renameit%(LEFT));
ENDMACRO;

mac_give_name(nmvr.records, nmvr_named)
mac_give_name(advr.records, advr_named)
mac_give_name(phvr.records, phvr_named)
mac_give_name(bnkr.records, bnkr_named)
mac_give_name(idor.records, idor_named)
mac_give_name(srcr_plus_sections, srcr_named)
mac_give_name(srcr_more_section, srcr_more_section_named)
//mac_give_name(srcn, srcn_named)

//***** THEIR LAYOUTS
recbesr := RECORDOF(besr);
rec_verification := RECORDOF(iesp.share.t_CompanyVerification);
rec_phone_summary := RECORDOF(iesp.instantid.t_CompanyNameAddress);
recupcr := RECORDOF(upcr);
recsrcr := RECORDOF(srcr_named);
recnmvr := RECORDOF(nmvr_named);
recadvr := RECORDOF(advr_named);
recphvr := RECORDOF(phvr_named);
recidnr := RECORDOF(idnr.records);
recbnkr := RECORDOF(bnkr_named);
recbnkr_v2 := RECORDOF(bnkr_v2.records);
recljur := RECORDOF(ljur.records);
recljur_v2 := RECORDOF(ljur_v2.records);
recprfr := RECORDOF(prfr.records);
recprfr_v2 := RECORDOF(prfr_v2.records);
recragr := RECORDOF(ragr.records);
recexer := RECORDOF(exer.records);
recconr := RECORDOF(conr.records);
recpror := RECORDOF(pror); // using profile attribute
recpror_v2 := RECORDOF(pror_v2.all_recs);
recnodr := RECORDOF(nodr.records);
recforr := RECORDOF(forr.records);
recmvrr := RECORDOF(mvrr.records); // GCL - 20051026
recmvrr_v2 := RECORDOF(mvrr_v2.records);
recwctr := RECORDOF(wctr.records); // GCL - 20051026
recairr := RECORDOF(airr.records); // GCL - 20051026
recidor := RECORDOF(idor_named);
recplir := RECORDOF(plir.records);
recdcar := RECORDOF(dcar.records);
recsalr := RECORDOF(salr.records);
recindr := RECORDOF(indr.records);
recsupr := liens_superior.Layout_Liens_Superior_LNI;
recbasr := RECORDOF(basr.records);
recdnbr := RECORDOF(dnbr);
recebrr := RECORDOF(ebrr.records);
recirsr := RECORDOF(irsr.records);
recbrer := RECORDOF(brer.records);
recsancr := RECORDOF(sancr);
recsdivcert := iesp.diversitycertification.t_DiversityCertificationRecord;
recsriskmetric := iesp.riskmetrics.t_RiskMetricsRecord;
recslabor := iesp.laboraction_WHD.t_LaborActionWHDRecord;
recsnatdis := iesp.naturaldisaster.t_NaturalDisasterRecord;
recslnca := iesp.lncafirmographics.t_LNCARecord;
recsequi := iesp.gateway_inviewreport.t_InviewReportResponse;
recflag := RECORDOF(recflags1);
recMoreCounts := RECORDOF(srcr_more_section_named);


//***** THE COMBINED LAYOUT
rec := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
  DATASET(recbesr) Best_Information;
  DATASET(rec_verification) Company_Verification {xpath('CompanyVerification'), MAXCOUNT(con.max_verification)};
  DATASET(rec_phone_summary) Phone_Summary{xpath('PhoneSummary'), MAXCOUNT(con.max_phone_summary)};
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
  DATASET(recsancr)Business_Sanctions{xpath('BusinessSanctions/BusinessSanction')};
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


//***** PROJECT THEM IN
nada := DATASET([0], {UNSIGNED1 a});
rec getall(nada l) := TRANSFORM
  SELF.Best_Information := GLOBAL(GROUP(besr));
  SELF.Company_Verification := IF(Include_BusinessRpt_Verification_val, GLOBAL(compverr));
  SELF.Phone_Summary := IF(Include_BusinessRpt_PhoneSummary_val, GLOBAL(phonesumr));
  SELF.Ultimate_Parent_Information := GLOBAL(upcr);
  SELF.Name_Variations := GLOBAL(nmvr_named);
  SELF.Address_Variations := GLOBAL(advr_named);
  SELF.Phone_Variations := GLOBAL(phvr_named);
  SELF.Parent_Company := GLOBAL(dcar.records);
  SELF.Sales := GLOBAL(salr.records);
  SELF.Industry_Information := GLOBAL(indr.records);
  SELF.ID_Numbers := GLOBAL(idnr.records);
  SELF.Bankruptcy := GLOBAL(bnkr_named);
  SELF.Bankruptcy_v2 := GLOBAL(bnkr_v2.records);
  SELF.Liens_Judgments := GLOBAL(ljur.records);
  SELF.Liens_Judgments_v2 := GLOBAL(ljur_v2.records);
  SELF.Profile_Information := GLOBAL(prfr.records);
  SELF.Profile_Information_v2 := GLOBAL(prfr_v2.records);
  SELF.Business_Registrations := GLOBAL(brer.records);
  SELF.Registered_Agents := GLOBAL(ragr.records);
  SELF.Contacts := GLOBAL(conr.records);
  SELF.Executives := GLOBAL(exer.records);
  SELF.Property := GLOBAL(pror);
  SELF.Property_v2 := GLOBAL(pror_v2.all_recs);
  SELF.NoticeOfDefaults := IF(Include_NoticeOfDefaults_val,GLOBAL(nodr.records));
  SELF.Foreclosures := IF(Include_Foreclosures_val,GLOBAL(forr.records));
  SELF.Motor_Vehicles := IF(NOT is_knowx,GLOBAL(mvrr.records)); // GCL - 20051026
  SELF.Motor_Vehicles_v2 := IF(NOT is_knowx,GLOBAL(UNGROUP(mvrr_v2.records)));
  SELF.Watercrafts := IF(NOT is_knowx,GLOBAL(wctr.records)); // GCL - 20051026
  SELF.Aircrafts := IF(NOT is_knowx,GLOBAL(airr.records)); // GCL - 20051026
  SELF.Internet := GLOBAL(idor_named);
  SELF.Professional_Licenses := GLOBAL(plir.records);
  SELF.Superior_Liens := DATASET([],liens_superior.Layout_Liens_Superior_LNI);
  SELF.Business_Associates := GLOBAL(basr.records);
  SELF.Experian_Business_Reports := IF(NOT is_knowx,GLOBAL(ebrr.records));
  SELF.IRS5500 := GLOBAL(irsr.records);
  SELF.DNB := GLOBAL(dnbr);
  SELF.Business_Sanctions := IF(Include_Sanctions_val, GLOBAL(sancr));
  SELF.DiversityCertification := IF(Include_DiversityCert_val,GLOBAL(divcert.records));
  SELF.RiskMetrics := IF(Include_RiskMetrics_val,GLOBAL(riskmet.records));
  SELF.LaborActionWHD := IF(Include_LaborActWHD_val,GLOBAL(laboract.records));
  SELF.NaturalDisaster := IF(Include_NatDisReady_val,GLOBAL(natdis.records));
  SELF.LNCAFirmographics := IF(Include_LNCA_val,GLOBAL(lncar.records));
  SELF.EquifaxBusinessReport := []; // supposed to be filled in by external caller.
  SELF.Source_Counts := GLOBAL(srcr_named);
  SELF.SOURCE_FLAGS := GLOBAL(recflags1);
  SELF.Source_Counts_more := GLOBAL(srcr_more_section_named);
  SELF := [];
END;

res := PROJECT(nada, getall(LEFT));

RETURN res;

/*
  Work in progress, will be deleted later...
  doxie_cbrs.layout_report.outrec xt() := TRANSFORM
    SELF.Best_Information := GLOBAL(GROUP(besr));
    SELF.Company_Verification := IF(Include_BusinessRpt_Verification_val, GLOBAL(compverr));
    SELF.Phone_Summary := IF(Include_BusinessRpt_PhoneSummary_val, GLOBAL(phonesumr));
    SELF.Ultimate_Parent_Information := GLOBAL(upcr);
    SELF.Name_Variations := GLOBAL(nmvr_named);
    SELF.Address_Variations := GLOBAL(advr_named);
    SELF.Phone_Variations := GLOBAL(phvr_named);
    SELF.Parent_Company := GLOBAL(dcar.records);
    // SELF.Sales := GLOBAL(salr.records);
    SELF.Industry_Information := GLOBAL(indr.records);
    SELF.ID_Numbers := GLOBAL(idnr.records);
    SELF.Bankruptcy := GLOBAL(bnkr_named);
    SELF.Bankruptcy_v2 := GLOBAL(bnkr_v2.records);
    SELF.Liens_Judgments := GLOBAL(ljur.records);
    SELF.Liens_Judgments_v2 := GLOBAL(ljur_v2.records);
    SELF.Profile_Information := GLOBAL(prfr.records);
    SELF.Profile_Information_v2 := GLOBAL(prfr_v2.records);
    // SELF.Business_Registrations := GLOBAL(brer.records);
    // SELF.Registered_Agents := GLOBAL(ragr.records);
    // SELF.Contacts := GLOBAL(conr.records);
    // SELF.Executives := GLOBAL(exer.records);
    // SELF.Property := GLOBAL(pror);
    // SELF.Property_v2 := GLOBAL(pror_v2.all_recs);
    // SELF.NoticeOfDefaults := IF(Include_NoticeOfDefaults_val,GLOBAL(nodr.records));
    // SELF.Foreclosures := IF(Include_Foreclosures_val,GLOBAL(forr.records));
    // SELF.Motor_Vehicles := IF(NOT is_knowx,GLOBAL(mvrr.records)); // GCL - 20051026
    // SELF.Motor_Vehicles_v2 := IF(NOT is_knowx,GLOBAL(UNGROUP(mvrr_v2.records)));
    // SELF.Watercrafts := IF(NOT is_knowx,GLOBAL(wctr.records)); // GCL - 20051026
    // SELF.Aircrafts := IF(NOT is_knowx,GLOBAL(airr.records)); // GCL - 20051026
    // SELF.Internet := GLOBAL(idor_named);
    // SELF.Professional_Licenses := GLOBAL(plir.records);
    // SELF.Superior_Liens := DATASET([],liens_superior.Layout_Liens_Superior_LNI);
    // SELF.Business_Associates := GLOBAL(basr.records);
    // SELF.Experian_Business_Reports := IF(NOT is_knowx,GLOBAL(ebrr.records));
    // SELF.IRS5500 := GLOBAL(irsr.records);
    // SELF.DNB := GLOBAL(dnbr);
    // SELF.Business_Sanctions := IF(Include_Sanctions_val, GLOBAL(sancr));
    // SELF.DiversityCertification := IF(Include_DiversityCert_val,GLOBAL(divcert.records));
    // SELF.RiskMetrics := IF(Include_RiskMetrics_val,GLOBAL(riskmet.records));
    // SELF.LaborActionWHD := IF(Include_LaborActWHD_val,GLOBAL(laboract.records));
    // SELF.NaturalDisaster := IF(Include_NatDisReady_val,GLOBAL(natdis.records));
    // SELF.LNCAFirmographics := IF(Include_LNCA_val,GLOBAL(lncar.records));
    // SELF.EquifaxBusinessReport := []; // supposed to be filled in by external caller.
    // SELF.Source_Counts := GLOBAL(srcr_named);
    // SELF.SOURCE_FLAGS := GLOBAL(recflags1);
    // SELF.Source_Counts_more := GLOBAL(srcr_more_section_named);
    SELF := [];
  END;
  res := DATASET([xt()]);
  RETURN res;
*/
END;                           

