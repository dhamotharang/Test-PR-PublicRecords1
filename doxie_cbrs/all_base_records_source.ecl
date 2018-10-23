IMPORT doxie_crs, doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

//
// Limit the amount of source docs until we can figure out how to return them all
//
#stored('MaxNameVariations',100);
#stored('MaxPhoneVariations',100);
#stored('MaxAddressVariations',100);
#stored('MaxProfessionalLicenses',50);
#stored('MaxAssociatedPeople',150);
#stored('MaxInternetDomains',50);
#stored('MaxBankruptcies',50);
#stored('MaxProperties',100);
#stored('MaxMotorVehicles',100);
#stored('MaxWatercrafts',100);
#stored('MaxAircrafts',100);
#stored('MaxExperianBusinessReports',25);
#stored('MaxExecutives',50);
#stored('MaxDCA',50);
#stored('MaxSales',50);
#stored('MaxIndustryInformation',100);
#stored('MaxUCCFilings',100);  // 100 UCCs
#stored('MaxLiensJudgmentsUCC',100); // 100 LJs - doesn't affect UCC see MaxUCCFilings
#stored('MaxParentCompany',50);	
#stored('MaxRegisteredAgents',50);
#stored('MaxCompanyIDnumbers',100);
#stored('MaxBusinessAssociates',50);
#stored('MaxIRS5500',50);
#stored('MaxIRSNonP',50);
#stored('MaxFDIC',50);
#stored('MaxBBBMember',50);
#stored('MaxBBBNonMember',50);
#stored('MaxCASalesTax',50);
#stored('MaxIASalesTax',50);
#stored('MaxMSWorkComp',50);
#stored('MaxORWorkComp',50);

EXPORT all_base_records_source(DATASET(doxie_cbrs.layout_references) bdids = dataset([],doxie_cbrs.layout_references), STRING6 SSNMask = 'NONE') := FUNCTION
	
//***** RECORDSETS
//
// FINDER
//
hdrr := doxie_cbrs.header_records_raw(bdids)(Include_Finder_val or 
										Include_NameVariations_val or 
										Include_AddressVariations_val or 
										Include_PhoneVariations_val or
										Include_CompanyIDNumbers_val);				
	
//	
// DNB										
//
dnbr := doxie_cbrs.DNB_records(bdids)(Include_DunBradstreetRecords_val or 
										Include_CompanyIDnumbers_val);
	
//	
// CORPORATE_FILINGS										
//
corr := choosen(doxie_cbrs.Corporation_Filings_records(bdids)(Include_CorporationFilings_val or
										Include_CompanyIDnumbers_val or
										Include_CompanyProfile_val),
			Max_CorporationFilings_val);
										
rarr := doxie_cbrs.registered_agents_records_raw(bdids)(Include_RegisteredAgents_val);

crpr := choosen(sort(dedup(corr + rarr, ALL),corp_state_origin), Max_CompanyIDnumbers_val);

//	
// CORPORATE_FILINGS_V2										
//
corr_v2 := choosen(doxie_cbrs.Corporation_Filings_records_v2(bdids).source_view(Max_CorporationFilings_val)(Include_CorporationFilingsV2_val or
										Include_CompanyIDnumbersV2_val or
										Include_CompanyProfileV2_val),
			Max_CorporationFilings_val);

rarr_v2 := doxie_cbrs.registered_agents_records_raw_v2(bdids)(Include_RegisteredAgentsV2_val);
										
crpr_v2 := choosen(sort(dedup(corr_v2 + rarr_v2, ALL),corp_state_origin), Max_CompanyIDnumbers_val);

//
// BANKRUPTCY										
//
bnkr := choosen(doxie_cbrs.bankruptcy_records(bdids)(Include_Bankruptcies_val),
			Max_Bankruptcies_val);

//
// BANKRUPTCY	_V2									
//
bnkr_v2 := choosen(doxie_cbrs.bankruptcy_records_v2(bdids).source_view(Max_Bankruptcies_val)(Include_BankruptciesV2_val),
			Max_Bankruptcies_val);

//
// UCC
//
uccr := choosen(doxie_cbrs.UCC_Records(bdids,SSNMask)(Include_UCCFilings_val or 
										Include_LiensJudgmentsUCC_val),
				Max_UCCFilings_val);

//
// UCC_V2
//
uccr_v2 := choosen(doxie_cbrs.UCC_Records_v2(bdids,SSNMask).source_view(Max_UCCFilings_val)(Include_UCCFilingsV2_val or 
										Include_LiensJudgmentsUCCV2_val),
				Max_UCCFilings_val);

//										
// LIENS_JUDGMENTS										
//
ljr  := choosen(doxie_cbrs.Liens_Judments_records(bdids)(Include_LiensJudgments_val or
										Include_LiensJudgmentsUCC_val or
										Include_CompanyIDNumbers_val),
				Max_LiensJudgmentsUCC_val);

//										
// LIENS_JUDGMENTS_V2
//
ljr_v2  := choosen(doxie_cbrs.Liens_Judments_records_v2(bdids,SSNMask).source_view(Max_LiensJudgmentsUCC_val)(Include_LiensJudgmentsV2_val or
										Include_LiensJudgmentsUCCV2_val or
										Include_CompanyIDNumbers_val),
				Max_LiensJudgmentsUCC_val);
	
//
// IRS 5500
//
irs5500 := choosen(doxie_cbrs.IRS5500_records(bdids)(Include_CompanyIDNumbers_val or
                    Include_IRS5500_val),
                   Max_IRS5500_val);
									 
//
// IRS Non Profit
//
irsnonpr := choosen(doxie_cbrs.IRSNonP_records(bdids)(Include_CompanyIDNumbers_val or
                    Include_IRSNonP_val),
                   Max_IRSNonP_val);
									 
//
// FDIC
//
fdicr := choosen(doxie_cbrs.FDIC_member_records(bdids)(Include_FDIC_val),
                   Max_FDIC_val);

//
// BBBMember
//
bbbmemberr := choosen(doxie_cbrs.BBBMember_member_records(bdids)(Include_BBBMember_val),
                   Max_BBBMember_val);

//
// BBBNonMember
//
bbbnonmemberr := choosen(doxie_cbrs.BBBNonMember_member_records(bdids)(Include_BBBNonMember_val),
                   Max_BBBNonMember_val);

//
// CASalesTax
//
casalestaxr := choosen(doxie_cbrs.CASalesTax_member_records(bdids)(Include_CASalesTax_val),
                   Max_CASalesTax_val);

//
// IASalesTax
//
iasalestaxr := choosen(doxie_cbrs.IASalesTax_member_records(bdids)(Include_IASalesTax_val),
                   Max_IASalesTax_val);

//
// MSWorkComp
//
msworkcompr := choosen(doxie_cbrs.MSWorkComp_member_records(bdids)(Include_MSWorkComp_val),
                   Max_MSWorkComp_val);

//
// ORWorkComp
//
orworkcompr := choosen(doxie_cbrs.ORWorkComp_member_records(bdids)(Include_ORWorkComp_val),
                   Max_ORWorkComp_val);

//	
// CONTACTS
//
conr := choosen(sort(doxie_cbrs.contact_records_standardized(bdids)(Include_AssociatedPeople_val),lname,fname),
				Max_AssociatedPeople_val);

//
// PROPERTY
//
pror := choosen(doxie_cbrs.property_records(bdids)(Include_Properties_val and byBDID),Max_Properties_val);

//
// PROPERTY_V2
//
pror_v2_assess := choosen(doxie_cbrs.property_records_source(bdids).assessments(Include_PropertiesV2_val),Max_PropertiesV2_val);
pror_v2_deed := choosen(doxie_cbrs.property_records_source(bdids).deeds(Include_PropertiesV2_val),Max_PropertiesV2_val);

//
// INTERNET
//
idor := choosen(doxie_cbrs.Internet_Domains_records(bdids)(Include_InternetDomains_val),Max_InternetDomains_val);

//
// PROFESSIONAL_LICENSES
//
plir := choosen(doxie_cbrs.proflic_records_dayton(bdids)(Include_ProfessionalLicenses_val),Max_ProfessionalLicenses_val);

//
// MOTOR_VEHICLES
//
mvrr := choosen(doxie_cbrs.motor_vehicle_records_dayton(bdids)(Include_Bus_DPPA AND Include_MotorVehicles_val),Max_MotorVehicles_val);

//
// MOTOR_VEHICLES_V2
//
mvrr_v2 := choosen(doxie_cbrs.motor_vehicle_records_v2(bdids).source_view(Max_MotorVehicles_val)(Include_Bus_DPPA AND Include_MotorVehiclesV2_val),Max_MotorVehicles_val);

//
// WATERCRAFTS
//
wtcr := choosen(doxie_cbrs.watercraft_records(bdids)(Include_Bus_DPPA AND Include_Watercrafts_val),Max_Watercrafts_val);

//
// AIRCRAFTS
//
airr := choosen(doxie_cbrs.aircraft_records(bdids)(Include_Aircrafts_val),Max_Aircrafts_val);

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
nodr := choosen(doxie_cbrs.foreclosure_records(bdids,true).records (Include_NoticeOfDefaults_val),Max_NoticeOfDefaults_val);

//
// FORECLOSURES
//
forr := choosen(doxie_cbrs.foreclosure_records(bdids,false).records (Include_Foreclosures_val),Max_Foreclosures_val);

//
// BUSINESS_ASSOCIATES
//
//basr := choosen(doxie_cbrs.business_associates_records(Include_BusinessAssociates_val),Max_BusinessAssociates_val);

//
// BUSINESS REGISTRATIONS
//
brer_count := count(doxie_cbrs.business_registration_records_prs(bdids)(Include_BusinessRegistrations_val));

//
// BUSINESS SANCTIONS
//
sancsr_count			:= count(doxie.Ingenix_Business_records(bdids).records (Include_Sanctions_val)) ;

//***** SYNTAX REQUIRES THAT I CREATE A NAME FOR THE LAYOUT OF SOME (CANNOT ASSIGN TABLE OF UNNAMED...)
mac_give_name(r, outr) := macro
	#uniquename(rec)
	#uniquename(renameit)
	%rec% := recordof(r);
	%rec% %renameit%(r l) := transform
		self := l;
	end;
	outr := project(r, %renameit%(left));
endmacro;


mac_give_name(bnkr, bnkr_named)
mac_give_name(idor, idor_named)
mac_give_name(hdrr, hdrr_named)

temprec := record
	unsigned3 FINDER,
	unsigned3 DNB,
	unsigned3 CORPORATE_FILINGS,
	unsigned3 CORPORATE_FILINGS_V2,
	unsigned3 BANKRUPTCY,
	unsigned3 BANKRUPTCY_V2,
	unsigned3 UCCS,
	unsigned3 UCCS_V2,
	unsigned3 LIENS_JUDGMENTS,
	unsigned3 LIENS_JUDGMENTS_V2,
	unsigned3 IRS5500,
	unsigned3 IRSNONP,
	unsigned3 FDIC,
	unsigned3 BBBMember,
	unsigned3 BBBNonMember,
	unsigned3 CASalesTax,
	unsigned3 IASalesTax,
	unsigned3 MSWorkComp,
	unsigned3 ORWorkComp,
	unsigned3 CONTACTS,
	unsigned3 PROPERTY,
	unsigned3 PROPERTY_V2,
	unsigned3 INTERNET,
	unsigned3 PROFESSIONAL_LICENSES,
	unsigned3 BUSINESS_REGISTRATIONS,
	unsigned3 MOTOR_VEHICLES,
	unsigned3 MOTOR_VEHICLES_V2,
	unsigned3 WATERCRAFTS,
	unsigned3 AIRCRAFTS,
	unsigned3 EXPERIAN_BUSINESS_REPORTS,
	unsigned3 SUPERIOR_LIENS,
	unsigned3 NOTICE_OF_DEFAULTS,
	unsigned3 FORECLOSURES,
	unsigned3 BUSINESS_SANCTIONS
end;

srcr := project(dataset([{0}],{unsigned _a}),transform(temprec,
	self.FINDER                       := count(hdrr_named),
	self.DNB                          := count(dnbr),
	self.CORPORATE_FILINGS            := count(crpr),
	self.CORPORATE_FILINGS_V2         := count(crpr_v2),
	self.BANKRUPTCY                   := count(bnkr_named),
	self.BANKRUPTCY_V2                := count(bnkr_v2),
	self.UCCS                         := count(uccr),
	self.UCCS_V2                      := count(uccr_v2),
	self.LIENS_JUDGMENTS              := count(ljr),
	self.LIENS_JUDGMENTS_V2           := count(ljr_v2),
	self.IRS5500                      := count(irs5500),
	self.IRSNONP                      := count(irsnonpr),
	self.FDIC                         := count(fdicr),
	self.BBBMEMBER                    := count(bbbmemberr),
	self.BBBNONMEMBER                 := count(bbbnonmemberr),
	self.CASALESTAX                   := count(casalestaxr),
	self.IASALESTAX                   := count(iasalestaxr),
	self.MSWORKCOMP                   := count(msworkcompr),
	self.ORWORKCOMP                   := count(orworkcompr),
	self.CONTACTS                     := count(conr),
	self.PROPERTY                     := count(pror),
	self.PROPERTY_V2                  := count(pror_v2_assess) +
	                                     count(pror_v2_deed),
	self.INTERNET                     := count(idor_named),
	self.PROFESSIONAL_LICENSES        := count(plir),
	self.BUSINESS_REGISTRATIONS       := brer_count                              , // NEED TO STANDARDIZE
	self.MOTOR_VEHICLES               := count(mvrr),
	self.MOTOR_VEHICLES_V2            := count(mvrr_v2),
	self.WATERCRAFTS                  := count(wtcr),
	self.AIRCRAFTS                    := count(airr),
	self.EXPERIAN_BUSINESS_REPORTS    := count(ebrr),
	self.SUPERIOR_LIENS               := 0                                       , // NEED TO REMOVE
	self.NOTICE_OF_DEFAULTS           := count(nodr)                             , // NEED TO STANDARDIZE
	self.FORECLOSURES                 := count(forr)                             , // NEED TO STANDARDIZE
	self.BUSINESS_SANCTIONS           := sancsr_count                            , // NEED TO STANDARDIZE
	self := []));

mac_give_name(srcr, srcr_named)

//***** THEIR LAYOUTS
recsrcr := recordof(srcr_named);
rechdrr := recordof(hdrr_named);
recdnbr := recordof(dnbr);
reccorr := recordof(crpr);
reccorr_v2 := recordof(crpr_v2);
recbnkr := recordof(bnkr_named);
recbnkr_v2 := recordof(bnkr_v2);
recuccr := recordof(uccr);
recuccr_v2 := recordof(uccr_v2);
recljr  := recordof(ljr);
recljr_v2 := recordof(ljr_v2);
recconr := recordof(conr);
recpror := recordof(pror);
recpror_v2_assess := recordof(pror_v2_assess);
recpror_v2_deed := recordof(pror_v2_deed);
recnodr := recordof(nodr);
recforr := recordof(forr);
recidor := recordof(idor_named);
recplir := recordof(plir);
recmvrr := recordof(mvrr);
recmvrr_v2 := recordof(mvrr_v2);
recwtcr := recordof(wtcr);
recairr := recordof(airr);
recebrr := recordof(ebrr);
recirs  := recordof(irs5500);
recirsn := recordof(irsnonpr);
//recsupr := recordof(supr);
//recbasr := recordof(basr);
recfdicr         := recordof(fdicr);
recbbbmemberr    := recordof(bbbmemberr);
recbbbnonmemberr := recordof(bbbnonmemberr);
reccasalestaxr   := recordof(casalestaxr);
reciasalestaxr   := recordof(iasalestaxr);
recmsworkcompr   := recordof(msworkcompr);
recorworkcompr   := recordof(orworkcompr);

//***** THE COMBINED LAYOUT
rec := record, maxlength(doxie_crs.maxlength_report)
	dataset(rechdrr) FINDER;
	dataset(recdnbr) DNB;
	dataset(reccorr) CORPORATE_FILINGS;
	dataset(reccorr_v2) CORPORATE_FILINGS_V2;
	dataset(recbnkr) BANKRUPTCY;
	dataset(recbnkr_v2) BANKRUPTCY_V2;
	dataset(recuccr) UCCS;
	dataset(recuccr_v2) UCCS_V2;
	dataset(recljr)  LIENS_JUDGMENTS;
	dataset(recljr_v2) LIENS_JUDGMENTS_V2;
	dataset(recconr) CONTACTS;
	dataset(recpror) PROPERTY;
	dataset(recpror_v2_assess) PROPERTY_V2_ASSESS;
	dataset(recpror_v2_deed) PROPERTY_V2_DEED;
	dataset(recnodr) NOTICE_OF_DEFAULTS{xpath('NoticesOfDefaults/NoticeOfDefaults')};
	dataset(recforr) FORECLOSURES{xpath('ForeclosureDocuments/ForeclosureDocument')};
	dataset(recidor) INTERNET;
	dataset(recplir) PROFESSIONAL_LICENSES;
	dataset(recmvrr) MOTOR_VEHICLES;
	dataset(recmvrr_V2) MOTOR_VEHICLES_V2;
	dataset(recwtcr) WATERCRAFTS;
	dataset(recairr) AIRCRAFTS;
	dataset(recebrr) EXPERIAN_BUSINESS_REPORTS;
	dataset(recirs)  IRS_5500;
	dataset(recirsn) IRS_NON_PROFIT;
	dataset(recfdicr) FDIC;
	dataset(recbbbmemberr) BBBMember;
	dataset(recbbbnonmemberr) BBBNonMember;
	dataset(reccasalestaxr) CASalesTax;
	dataset(reciasalestaxr) IASalesTax;
	dataset(recmsworkcompr) MSWorkComp;
	dataset(recorworkcompr) ORWorkComp;
//	dataset(recbasr) BUSINESS_ASSOCIATES;
	dataset(recsrcr) SOURCE_COUNTS;
end;

//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});
rec getall(nada l) := transform
	self.FINDER 				:= global(hdrr_named);
	self.DNB 					:= global(dnbr);
	self.CORPORATE_FILINGS 		:= global(crpr);
	self.CORPORATE_FILINGS_V2 := global(crpr_v2);
	self.BANKRUPTCY 			:= global(bnkr_named);
	self.BANKRUPTCY_V2 			:= global(bnkr_v2);
	self.UCCS 				:= global(uccr);
	self.UCCS_V2 				:= global(uccr_v2);
	self.LIENS_JUDGMENTS 		:= global(ljr);
	self.LIENS_JUDGMENTS_V2 := global(ljr_v2);
	self.CONTACTS 				:= global(conr);
	self.PROPERTY 				:= global(pror);
	self.PROPERTY_V2_ASSESS 				:= global(pror_v2_assess);
	self.PROPERTY_V2_DEED 				:= global(pror_v2_deed);
	self.NOTICE_OF_DEFAULTS := global(nodr);
	self.FORECLOSURES       := global(forr);
	self.INTERNET 				:= global(idor_named);
	self.PROFESSIONAL_LICENSES 	:= global(plir);
	self.MOTOR_VEHICLES     := global(mvrr);
	self.MOTOR_VEHICLES_V2 := global(ungroup(mvrr_v2));
	self.WATERCRAFTS        := global(wtcr);
	self.AIRCRAFTS          := global(airr);
	self.EXPERIAN_BUSINESS_REPORTS := global(ebrr);
	self.IRS_5500           := global(irs5500);
	self.IRS_NON_PROFIT     := global(irsnonpr);
	self.FDIC               := global(fdicr);
	self.BBBMember          := global(bbbmemberr);
	self.BBBNonMember       := global(bbbnonmemberr);
	self.CASalesTax         := global(casalestaxr);
	self.IASalesTax         := global(iasalestaxr);
	self.MSWorkComp         := global(msworkcompr);
	self.ORWorkComp         := global(orworkcompr);
//	self.BUSINESS_ASSOCIATES	:= global(basr);
	self.SOURCE_COUNTS 			:= global(srcr_named);	
end;

// need a dummy set of allowable sections/sources that can be asked for
return project(nada, getall(left));
END;
