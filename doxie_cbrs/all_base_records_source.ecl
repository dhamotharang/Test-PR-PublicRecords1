IMPORT doxie, doxie_cbrs, doxie_crs;
doxie_cbrs.mac_Selection_Declare()

//
// Limit the amount of source docs until we can figure out how to return them all
//
#STORED('MaxNameVariations',100);
#STORED('MaxPhoneVariations',100);
#STORED('MaxAddressVariations',100);
#STORED('MaxProfessionalLicenses',50);
#STORED('MaxAssociatedPeople',150);
#STORED('MaxInternetDomains',50);
#STORED('MaxBankruptcies',50);
#STORED('MaxProperties',100);
#STORED('MaxMotorVehicles',100);
#STORED('MaxWatercrafts',100);
#STORED('MaxAircrafts',100);
#STORED('MaxExperianBusinessReports',25);
#STORED('MaxExecutives',50);
#STORED('MaxDCA',50);
#STORED('MaxSales',50);
#STORED('MaxIndustryInformation',100);
#STORED('MaxUCCFilings',100); // 100 UCCs
#STORED('MaxLiensJudgmentsUCC',100); // 100 LJs - doesn't affect UCC see MaxUCCFilings
#STORED('MaxParentCompany',50);
#STORED('MaxRegisteredAgents',50);
#STORED('MaxCompanyIDnumbers',100);
#STORED('MaxBusinessAssociates',50);
#STORED('MaxIRS5500',50);
#STORED('MaxIRSNonP',50);
#STORED('MaxFDIC',50);
#STORED('MaxBBBMember',50);
#STORED('MaxBBBNonMember',50);
#STORED('MaxCASalesTax',50);
#STORED('MaxIASalesTax',50);
#STORED('MaxMSWorkComp',50);
#STORED('MaxORWorkComp',50);

EXPORT all_base_records_source(
  DATASET(doxie_cbrs.layout_references) bdids, 
  doxie.IDataAccess mod_access
  ) := FUNCTION
  
//***** RECORDSETS
//
// FINDER
//
hdrr := doxie_cbrs.header_records_raw(bdids)(Include_Finder_val OR
                    Include_NameVariations_val OR
                    Include_AddressVariations_val OR
                    Include_PhoneVariations_val OR
                    Include_CompanyIDNumbers_val);
  
//
// DNB
//
dnbr := doxie_cbrs.DNB_records(bdids, mod_access)(Include_DunBradstreetRecords_val OR
                    Include_CompanyIDnumbers_val);
  
//
// CORPORATE_FILINGS
//
corr := CHOOSEN(doxie_cbrs.Corporation_Filings_records(bdids)(Include_CorporationFilings_val OR
                    Include_CompanyIDnumbers_val OR
                    Include_CompanyProfile_val),
      Max_CorporationFilings_val);
                    
rarr := doxie_cbrs.registered_agents_records_raw(bdids)(Include_RegisteredAgents_val);

crpr := CHOOSEN(SORT(DEDUP(corr + rarr, ALL),corp_state_origin), Max_CompanyIDnumbers_val);

//
// CORPORATE_FILINGS_V2
//
corr_v2 := CHOOSEN(doxie_cbrs.Corporation_Filings_records_v2(bdids).source_view(Max_CorporationFilings_val)(Include_CorporationFilingsV2_val OR
                    Include_CompanyIDnumbersV2_val OR
                    Include_CompanyProfileV2_val),
      Max_CorporationFilings_val);

rarr_v2 := doxie_cbrs.registered_agents_records_raw_v2(bdids)(Include_RegisteredAgentsV2_val);
                    
crpr_v2 := CHOOSEN(SORT(DEDUP(corr_v2 + rarr_v2, ALL),corp_state_origin), Max_CompanyIDnumbers_val);

//
// BANKRUPTCY
//
bnkr := CHOOSEN(doxie_cbrs.bankruptcy_records(bdids)(Include_Bankruptcies_val),
      Max_Bankruptcies_val);

//
// BANKRUPTCY _V2
//
bnkr_v2 := CHOOSEN(doxie_cbrs.bankruptcy_records_v2(bdids).source_view(Max_Bankruptcies_val)(Include_BankruptciesV2_val),
      Max_Bankruptcies_val);

//
// UCC
//
uccr := CHOOSEN(doxie_cbrs.UCC_Records(bdids,mod_access.ssn_mask)(Include_UCCFilings_val OR
                    Include_LiensJudgmentsUCC_val),
        Max_UCCFilings_val);

//
// UCC_V2
//
uccr_v2 := CHOOSEN(doxie_cbrs.UCC_Records_v2(bdids,mod_access.ssn_mask).source_view(Max_UCCFilings_val)(Include_UCCFilingsV2_val OR
                    Include_LiensJudgmentsUCCV2_val),
        Max_UCCFilings_val);

//
// LIENS_JUDGMENTS
//
ljr := CHOOSEN(doxie_cbrs.Liens_Judments_records(bdids)(Include_LiensJudgments_val OR
                    Include_LiensJudgmentsUCC_val OR
                    Include_CompanyIDNumbers_val),
        Max_LiensJudgmentsUCC_val);

//
// LIENS_JUDGMENTS_V2
//
ljr_v2 := CHOOSEN(doxie_cbrs.Liens_Judments_records_v2(bdids,mod_access.ssn_mask).source_view(Max_LiensJudgmentsUCC_val)(Include_LiensJudgmentsV2_val OR
                    Include_LiensJudgmentsUCCV2_val OR
                    Include_CompanyIDNumbers_val),
        Max_LiensJudgmentsUCC_val);
  
//
// IRS 5500
//
irs5500 := CHOOSEN(doxie_cbrs.IRS5500_records(bdids)(Include_CompanyIDNumbers_val OR
                    Include_IRS5500_val),
                   Max_IRS5500_val);
                   
//
// IRS Non Profit
//
irsnonpr := CHOOSEN(doxie_cbrs.IRSNonP_records(bdids)(Include_CompanyIDNumbers_val OR
                    Include_IRSNonP_val),
                   Max_IRSNonP_val);
                   
//
// FDIC
//
fdicr := CHOOSEN(doxie_cbrs.FDIC_member_records(bdids)(Include_FDIC_val),
                   Max_FDIC_val);

//
// BBBMember
//
bbbmemberr := CHOOSEN(doxie_cbrs.BBBMember_member_records(bdids)(Include_BBBMember_val),
                   Max_BBBMember_val);

//
// BBBNonMember
//
bbbnonmemberr := CHOOSEN(doxie_cbrs.BBBNonMember_member_records(bdids)(Include_BBBNonMember_val),
                   Max_BBBNonMember_val);

//
// CASalesTax
//
casalestaxr := CHOOSEN(doxie_cbrs.CASalesTax_member_records(bdids)(Include_CASalesTax_val),
                   Max_CASalesTax_val);

//
// IASalesTax
//
iasalestaxr := CHOOSEN(doxie_cbrs.IASalesTax_member_records(bdids)(Include_IASalesTax_val),
                   Max_IASalesTax_val);

//
// MSWorkComp
//
msworkcompr := CHOOSEN(doxie_cbrs.MSWorkComp_member_records(bdids)(Include_MSWorkComp_val),
                   Max_MSWorkComp_val);

//
// ORWorkComp
//
orworkcompr := CHOOSEN(doxie_cbrs.ORWorkComp_member_records(bdids)(Include_ORWorkComp_val),
                   Max_ORWorkComp_val);

//
// CONTACTS
//
conr := CHOOSEN(SORT(doxie_cbrs.contact_records_standardized(bdids)(Include_AssociatedPeople_val),lname,fname),
        Max_AssociatedPeople_val);

//
// PROPERTY
//
pror := CHOOSEN(doxie_cbrs.property_records(bdids)(Include_Properties_val AND byBDID),Max_Properties_val);

//
// PROPERTY_V2
//
pror_v2_assess := CHOOSEN(doxie_cbrs.property_records_source(bdids).assessments(Include_PropertiesV2_val),Max_PropertiesV2_val);
pror_v2_deed := CHOOSEN(doxie_cbrs.property_records_source(bdids).deeds(Include_PropertiesV2_val),Max_PropertiesV2_val);

//
// INTERNET
//
idor := CHOOSEN(doxie_cbrs.Internet_Domains_records(bdids)(Include_InternetDomains_val),Max_InternetDomains_val);

//
// PROFESSIONAL_LICENSES
//
plir := CHOOSEN(doxie_cbrs.proflic_records_dayton(bdids)(Include_ProfessionalLicenses_val),Max_ProfessionalLicenses_val);

//
// MOTOR_VEHICLES
//
mvrr := CHOOSEN(doxie_cbrs.motor_vehicle_records_dayton(bdids)(Include_Bus_DPPA AND Include_MotorVehicles_val),Max_MotorVehicles_val);

//
// MOTOR_VEHICLES_V2
//
mvrr_v2 := CHOOSEN(doxie_cbrs.motor_vehicle_records_v2(bdids).source_view(Max_MotorVehicles_val)(Include_Bus_DPPA AND Include_MotorVehiclesV2_val),Max_MotorVehicles_val);

//
// WATERCRAFTS
//
wtcr := CHOOSEN(doxie_cbrs.watercraft_records(bdids)(Include_Bus_DPPA AND Include_Watercrafts_val),Max_Watercrafts_val);

//
// AIRCRAFTS
//
airr := CHOOSEN(doxie_cbrs.aircraft_records(bdids)(Include_Aircrafts_val),Max_Aircrafts_val);

//
// EXPERIAN_BUSINESS_REPORTS
//
ebrr_1 := doxie_cbrs.experian_business_reports_raw(bdids,Include_Experian_Business_Reports_val,Max_Experian_Business_Reports_val).records;
// ebrr_2 := choosen(doxie_cbrs.experian_business_reports_raw((Include_UCCFilings_val or
                    // Include_LiensJudgmentsUCC_val) and
                    // exists(ucc_filing_recs)),
        // Max_UCCFilings_val - count(uccr));
// ebrr_3 := choosen(doxie_cbrs.experian_business_reports_raw((Include_LiensJudgments_val or
                    // Include_LiensJudgmentsUCC_val) and
                    // (exists(tax_lien_recs) or exists(judgment_recs))),
        // Max_LiensJudgmentsUCC_val - count(ljr));
// ebrr := dedup(sort(ebrr_1 + ebrr_2,file_number),file_number);
ebrr := ebrr_1;

//
// NOTICE OF DEFAULTS
//
nodr := CHOOSEN(doxie_cbrs.foreclosure_records(bdids,TRUE).records (Include_NoticeOfDefaults_val),Max_NoticeOfDefaults_val);

//
// FORECLOSURES
//
forr := CHOOSEN(doxie_cbrs.foreclosure_records(bdids,FALSE).records (Include_Foreclosures_val),Max_Foreclosures_val);

//
// BUSINESS_ASSOCIATES
//
//basr := choosen(doxie_cbrs.business_associates_records(Include_BusinessAssociates_val),Max_BusinessAssociates_val);

//
// BUSINESS REGISTRATIONS
//
brer_count := COUNT(doxie_cbrs.business_registration_records_prs(bdids)(Include_BusinessRegistrations_val));

//
// BUSINESS SANCTIONS
//
sancsr_count := COUNT(doxie.Ingenix_Business_records(bdids).records (Include_Sanctions_val)) ;

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

mac_give_name(bnkr, bnkr_named)
mac_give_name(idor, idor_named)
mac_give_name(hdrr, hdrr_named)

srcr := PROJECT(DATASET([{0}],{UNSIGNED _a}),TRANSFORM(doxie_cbrs.layout_source_counts,
  SELF.FINDER := COUNT(hdrr_named),
  SELF.DNB := COUNT(dnbr),
  SELF.CORPORATE_FILINGS := COUNT(crpr),
  SELF.CORPORATE_FILINGS_V2 := COUNT(crpr_v2),
  SELF.BANKRUPTCY := COUNT(bnkr_named),
  SELF.BANKRUPTCY_V2 := COUNT(bnkr_v2),
  SELF.UCCS := COUNT(uccr),
  SELF.UCCS_V2 := COUNT(uccr_v2),
  SELF.LIENS_JUDGMENTS := COUNT(ljr),
  SELF.LIENS_JUDGMENTS_V2 := COUNT(ljr_v2),
  SELF.IRS5500 := COUNT(irs5500),
  SELF.IRSNONP := COUNT(irsnonpr),
  SELF.FDIC := COUNT(fdicr),
  SELF.BBBMEMBER := COUNT(bbbmemberr),
  SELF.BBBNONMEMBER := COUNT(bbbnonmemberr),
  SELF.CASALESTAX := COUNT(casalestaxr),
  SELF.IASALESTAX := COUNT(iasalestaxr),
  SELF.MSWORKCOMP := COUNT(msworkcompr),
  SELF.ORWORKCOMP := COUNT(orworkcompr),
  SELF.CONTACTS := COUNT(conr),
  SELF.PROPERTY := COUNT(pror),
  SELF.PROPERTY_V2 := COUNT(pror_v2_assess) + COUNT(pror_v2_deed),
  SELF.INTERNET := COUNT(idor_named),
  SELF.PROFESSIONAL_LICENSES := COUNT(plir),
  SELF.BUSINESS_REGISTRATIONS := brer_count , // NEED TO STANDARDIZE
  SELF.MOTOR_VEHICLES := COUNT(mvrr),
  SELF.MOTOR_VEHICLES_V2 := COUNT(mvrr_v2),
  SELF.WATERCRAFTS := COUNT(wtcr),
  SELF.AIRCRAFTS := COUNT(airr),
  SELF.EXPERIAN_BUSINESS_REPORTS := COUNT(ebrr),
  SELF.SUPERIOR_LIENS := 0 , // NEED TO REMOVE
  SELF.NOTICE_OF_DEFAULTS := COUNT(nodr) , // NEED TO STANDARDIZE
  SELF.FORECLOSURES := COUNT(forr) , // NEED TO STANDARDIZE
  SELF.BUSINESS_SANCTIONS := sancsr_count , // NEED TO STANDARDIZE
  SELF := []));

mac_give_name(srcr, srcr_named)

//***** PROJECT THEM IN
nada := DATASET([0], {UNSIGNED1 a});
doxie_cbrs.layout_source getall(nada l) := TRANSFORM
  SELF.FINDER := GLOBAL(hdrr_named);
  SELF.DNB := GLOBAL(dnbr);
  SELF.CORPORATE_FILINGS := GLOBAL(crpr);
  SELF.CORPORATE_FILINGS_V2 := GLOBAL(crpr_v2);
  SELF.BANKRUPTCY := GLOBAL(bnkr_named);
  SELF.BANKRUPTCY_V2 := GLOBAL(bnkr_v2);
  SELF.UCCS := GLOBAL(uccr);
  SELF.UCCS_V2 := GLOBAL(uccr_v2);
  SELF.LIENS_JUDGMENTS := GLOBAL(ljr);
  SELF.LIENS_JUDGMENTS_V2 := GLOBAL(ljr_v2);
  SELF.CONTACTS := GLOBAL(conr);
  SELF.PROPERTY := GLOBAL(pror);
  SELF.PROPERTY_V2_ASSESS := GLOBAL(pror_v2_assess);
  SELF.PROPERTY_V2_DEED := GLOBAL(pror_v2_deed);
  SELF.NOTICE_OF_DEFAULTS := GLOBAL(nodr);
  SELF.FORECLOSURES := GLOBAL(forr);
  SELF.INTERNET := GLOBAL(idor_named);
  SELF.PROFESSIONAL_LICENSES := GLOBAL(plir);
  SELF.MOTOR_VEHICLES := GLOBAL(mvrr);
  SELF.MOTOR_VEHICLES_V2 := GLOBAL(UNGROUP(mvrr_v2));
  SELF.WATERCRAFTS := GLOBAL(wtcr);
  SELF.AIRCRAFTS := GLOBAL(airr);
  SELF.EXPERIAN_BUSINESS_REPORTS := GLOBAL(ebrr);
  SELF.IRS_5500 := GLOBAL(irs5500);
  SELF.IRS_NON_PROFIT := GLOBAL(irsnonpr);
  SELF.FDIC := GLOBAL(fdicr);
  SELF.BBBMember := GLOBAL(bbbmemberr);
  SELF.BBBNonMember := GLOBAL(bbbnonmemberr);
  SELF.CASalesTax := GLOBAL(casalestaxr);
  SELF.IASalesTax := GLOBAL(iasalestaxr);
  SELF.MSWorkComp := GLOBAL(msworkcompr);
  SELF.ORWorkComp := GLOBAL(orworkcompr);
// self.BUSINESS_ASSOCIATES := global(basr);
  SELF.SOURCE_COUNTS := GLOBAL(srcr_named);
END;

// need a dummy set of allowable sections/sources that can be asked for
RETURN PROJECT(nada, getall(LEFT));
END;
