IMPORT doxie_crs, liens_superior, iesp, ut;

doxie_cbrs.mac_Selection_Declare()

EXPORT all_base_records_prs(DATASET(doxie_cbrs.layout_references) bdids = DATASET([],doxie_cbrs.layout_references), STRING6 SSNMask = 'NONE') 
			:= FUNCTION

//
// SL based limits for a Report, where possible
//
#stored('MaxNameVariations',100);
#stored('MaxPhoneVariations',100);
#stored('MaxAddressVariations',100);
#stored('MaxProfessionalLicenses',50);
#stored('MaxAssociatedPeople',500);
#stored('MaxInternetDomains',50);
#stored('MaxBankruptcies',50);
#stored('MaxProperties',150);
#stored('MaxMotorVehicles',50); // GCL - 20051026
#stored('MaxWatercrafts',50); // GCL - 20051026
#stored('MaxAircrafts',50); // GCL - 20051026
#stored('MaxExecutives',200);
#stored('MaxDCA',50);
#stored('MaxSales',50);
#stored('MaxIndustryInformation',100);
#stored('MaxUCCFilings',100);  // 100 UCCs
#stored('MaxLiensJudgmentsUCC',100); // 100 LJs - doesn't affect UCC see MaxUCCFilings
#stored('MaxParentCompany',50);	
#stored('MaxRegisteredAgents',50);
#stored('MaxCompanyIDnumbers',100);
#stored('MaxBusinessAssociates',150);
#stored('MaxExperianBusinessReports',25);
#stored('MaxIRS5500',50);

name_table := dedup(table(sort(doxie_cbrs.fn_getBaseRecs(bdids,false),company_name),{company_name,name_source_id}));
addr_table := dedup(table(sort(doxie_cbrs.fn_getBaseRecs(bdids,false),state,zip,prim_name,prim_range,sec_range),{state,zip,prim_name,prim_range,sec_range,addr_source_id}));
phone_table := dedup(table(sort(doxie_cbrs.fn_getBaseRecs(bdids,false),phone),{phone,phone_source_id}));
is_knowx := ut.IndustryClass.is_knowx;	
shared con := doxie_crs.constants;

//***** MY RECORDSETS
temp_besr := choosen(doxie_cbrs.fn_best_information(bdids,false),1);

rec_besr := record
	temp_besr;
	unsigned name_source_id;
	unsigned addr_source_id;
	unsigned phone_source_id;
end;
rec_besr add_bdid(temp_besr l) := transform
	self.bdid := business_header.stored_bdid_val;         //FIX -- 
	self.name_source_id := 0;
	self.addr_source_id := 0;
	self.phone_source_id := 0;
	self := l;
end;
rec_besr add_name_source_id(rec_besr l, name_table r) := transform
	self.name_source_id := r.name_source_id;
	self := l;
end;
rec_besr add_addr_source_id(rec_besr l, addr_table r) := transform
	self.addr_source_id := r.addr_source_id;
	self := l;
end;
rec_besr add_phone_source_id(rec_besr l, phone_table r) := transform
	self.phone_source_id := r.phone_source_id;
	self := l;
end;

besr := join(join(join(project(temp_besr,add_bdid(left)),name_table,
											 left.company_name=right.company_name,
											 add_name_source_id(left,right),left outer),addr_table,
											 left.state=right.state and
											 left.zip=right.zip and
											 left.prim_name=right.prim_name and
											 left.prim_range=right.prim_range and
											 left.sec_range=right.sec_range,
											 add_addr_source_id(left,right),left outer),phone_table,
											 left.phone=right.phone,
											 add_phone_source_id(left,right),left outer);

// FIX -- move this to an appropriate place
boolean bdids_Derived :=  false : stored('bdidsDerived');

upcr := doxie_cbrs.ultimate_parent_information(bdids)((multibdid or bdids_Derived) and (fromDCA));

//Phone summary and company verification from business instant id
biid := doxie_cbrs.getBizReportBDIDs().biid; //Business InstantId Search.
phone_summary := choosen(doxie.fn_get_phone_summary(biid),con.max_phone_summary);
verification := choosen(doxie.fn_get_company_verification(biid),con.max_verification);
nmvr := doxie_cbrs.name_variations_base(bdids);
advr := doxie_cbrs.address_variations_base(bdids);
phvr := doxie_cbrs.phone_variations_base(bdids);
idnr := doxie_cbrs.ID_Number_records_base(bdids);

bnkr := doxie_cbrs.bankruptcy_records_trimmed(bdids);
bnkr_v2 := doxie_cbrs.bankruptcy_records_trimmed_v2(bdids, SSNMask);
ljur := doxie_cbrs.Liens_Judgments_UCC_records_trimmed(bdids, SSNMask);
ljur_v2 := doxie_cbrs.Liens_Judgments_UCC_records_trimmed_v2(bdids,SSNMask);

prfr := doxie_cbrs.profile_records(bdids);
prfr_v2 := doxie_cbrs.profile_records_v2(bdids);
ragr := doxie_cbrs.registered_agents_records(bdids);
exer := doxie_cbrs.executives_records(bdids);
conr := doxie_cbrs.contact_records_prs_trimmed(bdids);
// reuse what was done for profile report
pre_pror := doxie_cbrs.property_records(bdids)(Include_Properties_val and byBDID);
pror := choosen(if(doxie.DataRestriction.Fares,pre_pror(ln_fares_id[1] <>'R'),pre_pror),Max_Properties_val);
pror_v2 := doxie_cbrs.property_records_v2(bdids);
nodr := doxie_cbrs.foreclosure_records(bdids,true);
forr := doxie_cbrs.foreclosure_records(bdids,false);
mvrr := doxie_cbrs.Motor_Vehicle_Records_trimmed(bdids); // GCL - 20051026
mvrr_v2 := doxie_cbrs.Motor_Vehicle_Records_trimmed_v2(bdids);
wctr := doxie_cbrs.Watercraft_Records_trimmed(bdids); // GCL - 20051026
airr := doxie_cbrs.Aircraft_Records_trimmed(bdids); // GCL - 20051026
idor := doxie_cbrs.Internet_Domains_records_trimmed(bdids);
plir := doxie_cbrs.proflic_records_trimmed(bdids);
brer := doxie_cbrs.business_registration_records_prs_max(bdids);  

// DCA data
dcar := doxie_cbrs.DCA_records_trimmed(bdids);  // parent company section - dca data
salr := doxie_cbrs.sales_records_trimmed(bdids); // dca data
indr := doxie_cbrs.industry_information_records_trimmed(bdids);  // dca data

basr := doxie_cbrs.business_associates_records_trimmed(bdids); 
dnbr := doxie_cbrs.dnb_records(bdids)(Include_DunBradstreetRecords_val);
ebrr := doxie_cbrs.experian_business_reports_trimmed(bdids); 
irsr := doxie_cbrs.IRS5500_records_trimmed(bdids);
sancr := doxie.Ingenix_Business_records(bdids).records;
srcr := doxie_cbrs.count_records_prs_dayton(bdids,SSNMask);
divcert := doxie_cbrs.diversity_cert_records(bdids);
riskMet := doxie_cbrs.risk_metrics_records(bdids);
laborAct := doxie_cbrs.laborActions_WHD_records(bdids);
natdis := doxie_cbrs.natural_disaster_records(bdids);
lncar := doxie_cbrs.lnca_hierarchy_records(bdids);

// add in the counts for the sections
layout_plus_sec := record
	srcr;
	unsigned3 Name_Variations_Section := 0;
	unsigned3 Address_Variations_Section := 0;
	unsigned3 Phone_Variations_Section := 0;	
	unsigned3 Parent_Company_Section := 0;
	unsigned3 Sales_Section := 0;
	unsigned3 Industry_Information_Section := 0;
	unsigned3 ID_Numbers_Section := 0;
	unsigned3 Bankruptcy_Section := 0;
	unsigned3 Bankruptcy_Section_v2 := 0;
	unsigned3 Liens_Judgments_Section := 0;
	unsigned3 Liens_Judgments_Section_v2 := 0;
	unsigned3 Profile_Information_Section := 0;
	unsigned3 Profile_Information_Section_v2 := 0;
	unsigned3 Business_Registration_Section := 0;
	unsigned3 Registered_Agents_Section := 0;
	unsigned3 Contacts_Section := 0;
	unsigned3 Executives_Section := 0;
	unsigned3 Property_Section := 0;  
	unsigned3 Property_Section_v2 := 0;
	unsigned3 MotorVehicle_Section := 0; // GCL - 20051026
	unsigned3 MotorVehicle_Section_v2 := 0;
	unsigned3 Watercraft_Section := 0; // GCL - 20051026
	unsigned3 Aircraft_Section := 0; // GCL - 20051026
	unsigned3 Internet_Section := 0;
	unsigned3 Professional_Licenses_Section := 0;	
	unsigned3 Superior_Liens_Section := 0;
	unsigned3 Business_Associates_Section := 0;
	unsigned3 Experian_Business_Reports_Section := 0;
	unsigned3 IRS5500_Section := 0;	
	unsigned3 DNB_Section := 0;
	unsigned3 DiversityCertification_Section := 0;
	unsigned3 RiskMetrics_Section := 0;
	unsigned3 LaborActionWHD_Section := 0;
	unsigned3 NaturalDisaster_Section := 0;
	unsigned3 LNCAFirmographics_Section := 0;
	unsigned3 EquifaxBusinessReport_Section := 0; // a place holder for external callers
end;

layout_plus_sec add_sect_counts(srcr L) := TRANSFORM
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
	SELF.Property_Section := count(pror);  // Same as Report Returns for now.
	SELF.Property_Section_v2 := count(pror_v2.recs_trimmed);
	SELF.MotorVehicle_Section := IF(NOT is_knowx,mvrr.records_count,0); // GCL - 20051026
	SELF.MotorVehicle_Section_v2 := IF(NOT is_knowx,mvrr_v2.records_count,0);
	SELF.Watercraft_Section := IF(NOT is_knowx,wctr.records_count,0); // GCL - 20051026
	SELF.Aircraft_Section := IF(NOT is_knowx,airr.records_count,0); // GCL - 20051026
	SELF.Internet_Section := idor.records_count;
	SELF.Professional_Licenses_Section := plir.records_count;	
	SELF.Business_Associates_Section := basr.records_count;
	SELF.Experian_Business_Reports_Section := IF(NOT is_knowx,ebrr.records_count,0);	                                                                
	SELF.IRS5500_Section := irsr.records_count;
	SELF.DNB_Section := count(dnbr);
	SELF.DiversityCertification_Section := divcert.records_count;
	SELF.RiskMetrics_Section := riskMet.records_count;
	SELF.LaborActionWHD_Section := laborAct.records_count;
	SELF.NaturalDisaster_Section := natdis.records_count;
	SELF.LNCAFirmographics_Section := lncar.records_count;
	SELF.EquifaxBusinessReport_Section := 0; // a place holder for external callers
	SELF := L;
END;
 
srcr_plus_sections := project(srcr,add_sect_counts(LEFT))(Include_SourceCounts_val);

layout_sections_more := record
	BOOLEAN   Name_Variations_Section_more := FALSE;
	BOOLEAN   Address_Variations_Section_more := FALSE;
	BOOLEAN   Phone_Variations_Section_more := FALSE;
	BOOLEAN   Parent_Company_Section_more := FALSE;
	BOOLEAN   Sales_Section_more := FALSE;
	BOOLEAN   Industry_Information_Section_more := FALSE;
	BOOLEAN   ID_Numbers_Section_more  := FALSE;
	BOOLEAN   Bankruptcy_Section_more := FALSE;
	BOOLEAN   Bankruptcy_Section_v2_more := FALSE;
	BOOLEAN   Liens_Judgments_Section_more := FALSE;
	BOOLEAN   Liens_Judgments_Section_v2_more := FALSE;
	BOOLEAN   Profile_Information_Section_more := FALSE;
	BOOLEAN   Profile_Information_Section_v2_more := FALSE;
	BOOLEAN   Business_Registration_Section_more := FALSE;
	BOOLEAN   Registered_Agents_Section_more := FALSE;
	BOOLEAN   Contacts_Section_more := FALSE;
	BOOLEAN   Executives_Section_more := FALSE;
	BOOLEAN   Property_Section_more := FALSE;
	BOOLEAN   Property_Section_v2_more := FALSE;
	BOOLEAN   MotorVehicle_Section_more := FALSE;
	BOOLEAN   MotorVehicle_Section_v2_more := FALSE;
	BOOLEAN   Watercraft_Section_more := FALSE;
	BOOLEAN   Aircraft_Section_more := FALSE;
	BOOLEAN   Internet_Section_more := FALSE;
	BOOLEAN   Professional_Licenses_Section_more := FALSE;
	BOOLEAN   Superior_Liens_Section_more := FALSE;
	BOOLEAN   Business_Associates_Section_more := FALSE;
	BOOLEAN   Experian_Business_Reports_Section_more := FALSE;
	BOOLEAN   IRS5500_Section_more := FALSE;		
	BOOLEAN   DNB_Section_more := FALSE;
	BOOLEAN   DiversityCertification_Section_more := FALSE;
	BOOLEAN   RiskMetrics_Section_more := FALSE;
	BOOLEAN   LaborActionWHD_Section_more := FALSE;
	BOOLEAN   NaturalDisaster_Section_more := FALSE;
	BOOLEAN   LNCAFirmographics_Section_more := FALSE;
	BOOLEAN   EquifaxBusinessReport_Section_more := FALSE;
end;

layout_sections_more add_sect_more(srcr L) := TRANSFORM
	SELF.Name_Variations_Section_more := nmvr.records_count > Max_NameVariations_val;
	SELF.Address_Variations_Section_more := advr.records_count > Max_AddressVariations_val;
	SELF.Phone_Variations_Section_more := phvr.records_count > Max_PhoneVariations_val;
	SELF.Parent_Company_Section_more := dcar.records_count > Max_ParentCompany_val;
	SELF.Sales_Section_more := salr.records_count > Max_Sales_val;
	SELF.Industry_Information_Section_more := indr.records_count > Max_IndustryInfo_val; 
	SELF.ID_Numbers_Section_more := idnr.records_count > Max_CompanyIDnumbers_val; // no max value defined.
	SELF.Bankruptcy_Section_more := bnkr.records_count > Max_Bankruptcies_val;
	SELF.Bankruptcy_Section_V2_more := bnkr_v2.records_count > Max_BankruptciesV2_val;
	SELF.Liens_Judgments_Section_more := ljur.records_count > Max_LiensJudgmentsUCC_val;
	SELF.Liens_Judgments_Section_v2_more :=  ljur_v2.records_count > Max_LiensJudgmentsUCCV2_val;
	SELF.Profile_Information_Section_more := prfr.records_count > Max_CorporationFilings_val;
	SELF.Profile_Information_Section_v2_more := prfr_v2.records_count > Max_CorporationFilings_val;
	SELF.Business_Registration_Section_more := brer.records_count > Max_BusinessRegistrations_val;
	SELF.Registered_Agents_Section_more := ragr.records_count > Max_RegisteredAgents_val;
	SELF.Contacts_Section_more := conr.records_count > Max_AssociatedPeople_val;
	SELF.Executives_Section_more :=  exer.records_count > Max_Executives_val;
	SELF.Property_Section_more := count(pror) > Max_Properties_val;
	SELF.Property_Section_v2_more := count(pror_v2.all_recs) > Max_PropertiesV2_val;
	SELF.MotorVehicle_Section_more := IF(NOT is_knowx,mvrr.records_count,0) > Max_MotorVehicles_val;
	SELF.MotorVehicle_Section_v2_more := IF(NOT is_knowx,mvrr_v2.records_count_nolimit,0) > Max_MotorVehicles_val;
	SELF.Watercraft_Section_more := IF(NOT is_knowx,wctr.records_count,0) > Max_Watercrafts_val;
	SELF.Aircraft_Section_more := IF(NOT is_knowx,airr.records_count,0) > Max_Aircrafts_val;
	SELF.Internet_Section_more := idor.records_count > Max_InternetDomains_val;
	SELF.Professional_Licenses_Section_more  := plir.records_count > Max_ProfessionalLicenses_val;
	SELF.Business_Associates_Section_more := basr.records_count > Max_BusinessAssociates_val;
	SELF.Experian_Business_Reports_Section_more := IF(NOT is_knowx,ebrr.records_count,0) > Max_Experian_Business_Reports_val;	                                                                
	SELF.IRS5500_Section_more := irsr.records_count > Max_IRS5500_val;
	SELF.DNB_Section_more :=  count(dnbr) > Max_CompanyIDnumbers_val; 
	SELF.DiversityCertification_Section_more := divcert.records_count > Max_DiversityCert_val;
	SELF.RiskMetrics_Section_more := RiskMet.records_count > Max_RiskMetrics_val;
	SELF.LaborActionWHD_Section_more := laboract.records_count > Max_LaborActWHD_val;
	SELF.NaturalDisaster_Section_more := natdis.records_count > Max_NatDisReady_val;
	SELF := L;
END;


srcr_more_section := project(srcr, add_sect_more(LEFT))(Include_SourceCounts_val);

layout_flag := record
	string	field_present;
end;

layout_flag into_flags(srcr L, integer C) := transform
	self.field_present := choose(C,
						if (L.FINDER != 0,'FINDER', skip),
						if (L.DNB != 0, 'DNB', skip),
						if (L.EXPERIAN_BUSINESS_REPORTS != 0 and not is_knowx, 'EXPERIAN_BUSINESS_DATA', skip),
						if (L.IRS5500 != 0, 'IRS', skip),
						if (L.CORPORATE_FILINGS != 0, 'CORPORATE_FILINGS', skip),
						if (L.CORPORATE_FILINGS_V2 != 0, 'CORPORATE_FILINGS_V2', skip),
						if (L.BANKRUPTCY != 0, 'BANKRUPTCY', skip),
						if (L.BANKRUPTCY_v2 != 0, 'BANKRUPTCY_V2', skip),
						if (L.UCCS != 0, 'UCCS', skip),
						if (L.UCCS_v2 != 0, 'UCCS_V2', skip),
						if (L.LIENS_JUDGMENTS != 0, 'LIENS_JUDGMENTS', skip),
						if (L.LIENS_JUDGMENTS_v2 != 0, 'LIENS_JUDGMENTS_V2', skip),
						if (L.CONTACTS != 0, 'CONTACTS', skip),
						if (l.PROPERTY != 0, 'PROPERTY', skip),
						if (l.PROPERTY_V2 != 0, 'PROPERTY_V2', skip),
						if (L.INTERNET != 0, 'INTERNET', skip),
						if (L.PROFESSIONAL_LICENSES != 0, 'PROFESSIONAL_LICENSES', skip),
						if (L.BUSINESS_REGISTRATIONS != 0, 'BUSINESS_REGISTRATIONS', skip),
						if (L.NOTICE_OF_DEFAULTS != 0, 'NOTICE_OF_DEFAULTS', skip),
						if (L.FORECLOSURES != 0, 'FORECLOSURES', skip),
						if (L.BUSINESS_SANCTIONS != 0, 'BUSINESS_SANCTIONS', skip),
						if (nmvr.records_count > 0, 'NAME_VARIATIONS', skip),
						if (advr.records_count > 0, 'ADDRESS_VARIATIONS', skip),
						if (phvr.records_count > 0, 'PHONE_VARIATIONS', skip),
						if (idnr.records_count > 0, 'ID_NUMBERS', skip),
						if (ljur.records_count > 0, 'LIENS_JUDGMENTS_UCCS', skip),
						if (ljur_v2.records_count > 0, 'LIENS_JUDGMENTS_UCCS_V2', skip),
						if (prfr.records_count > 0, 'PROFILE_INFORMATION', skip),
						if (prfr_v2.records_count > 0, 'PROFILE_INFORMATION_V2', skip),
						if (ragr.records_count > 0, 'REGISTERED_AGENTS', skip),
						if (ragr.records_count > 0, 'REGISTERED_AGENTS_V2', skip),
						if (mvrr.records_count > 0, 'MOTOR_VEHICLES', skip), // GCL - 20051026
						if (mvrr_v2.records_count > 0, 'MOTOR_VEHICLES_V2', skip),
						if (wctr.records_count > 0, 'WATERCRAFTS', skip), // GCL - 20051026
						if (airr.records_count > 0, 'AIRCRAFTS', skip), // GCL - 20051026
						skip);
end;

//recflags1 := normalize(srcr,18,into_flags(LEFT,COUNTER));
recflags1 := normalize(srcr,35,into_flags(LEFT,COUNTER))(Include_SourceFlags_val); // GCL - 20051026


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


mac_give_name(nmvr.records, nmvr_named)
mac_give_name(advr.records, advr_named)
mac_give_name(phvr.records, phvr_named)
mac_give_name(bnkr.records, bnkr_named)
mac_give_name(idor.records, idor_named)
mac_give_name(srcr_plus_sections, srcr_named)
mac_give_name(srcr_more_section, srcr_more_section_named)
//mac_give_name(srcn, srcn_named)


//***** THEIR LAYOUTS
recbesr := recordof(besr);
rec_verification := recordof(iesp.share.t_CompanyVerification);
rec_phone_summary := recordof(iesp.instantid.t_CompanyNameAddress);
recupcr := recordof(upcr);
recsrcr := recordof(srcr_named);
recnmvr := recordof(nmvr_named);
recadvr := recordof(advr_named);
recphvr := recordof(phvr_named);
recidnr := recordof(idnr.records);
recbnkr := recordof(bnkr_named);
recbnkr_v2 := recordof(bnkr_v2.records);
recljur := recordof(ljur.records);
recljur_v2 := recordof(ljur_v2.records);
recprfr := recordof(prfr.records);
recprfr_v2 := recordof(prfr_v2.records);
recragr := recordof(ragr.records);
recexer := recordof(exer.records);
recconr := recordof(conr.records);
recpror := recordof(pror);  // using profile attribute
recpror_v2 := recordof(pror_v2.all_recs);
recnodr := recordof(nodr.records);
recforr := recordof(forr.records);
recmvrr := recordof(mvrr.records); // GCL - 20051026
recmvrr_v2 := recordof(mvrr_v2.records);
recwctr := recordof(wctr.records); // GCL - 20051026
recairr := recordof(airr.records); // GCL - 20051026
recidor := recordof(idor_named);
recplir := recordof(plir.records);
recdcar := recordof(dcar.records);
recsalr := recordof(salr.records);
recindr := recordof(indr.records);
recsupr := liens_superior.Layout_Liens_Superior_LNI;
recbasr := recordof(basr.records);
recdnbr := recordof(dnbr);
recebrr := recordof(ebrr.records);
recirsr := recordof(irsr.records);
recbrer := recordof(brer.records);
recsancr := recordof(sancr);
recsdivcert := iesp.diversitycertification.t_DiversityCertificationRecord;
recsriskmetric := iesp.riskmetrics.t_RiskMetricsRecord;
recslabor := iesp.laboraction_WHD.t_LaborActionWHDRecord;
recsnatdis := iesp.naturaldisaster.t_NaturalDisasterRecord;
recslnca := iesp.lncafirmographics.t_LNCARecord;
recsequi := iesp.gateway_inviewreport.t_InviewReportResponse;
recflag := recordof(recflags1);
recMoreCounts := recordof(srcr_more_section_named);


//***** THE COMBINED LAYOUT
rec := record, maxlength(doxie_crs.maxlength_report)
	dataset(recbesr) Best_Information;	
	dataset(rec_verification) Company_Verification {xpath('CompanyVerification'), maxcount(con.max_verification)};
 	dataset(rec_phone_summary) Phone_Summary{xpath('PhoneSummary'), maxcount(con.max_phone_summary)};
	dataset(recupcr) Ultimate_Parent_Information;
	dataset(recnmvr) Name_Variations;
	dataset(recadvr) Address_Variations;
	dataset(recphvr) Phone_Variations;	
	dataset(recdcar) Parent_Company;
	dataset(recsalr) Sales;
	dataset(recindr) Industry_Information;
	dataset(recidnr) ID_Numbers;
	dataset(recbnkr) Bankruptcy;
	dataset(recbnkr_v2) Bankruptcy_v2;
	dataset(recljur) Liens_Judgments;
	dataset(recljur_v2) Liens_Judgments_v2;
	dataset(recprfr) Profile_Information;
	dataset(recprfr_v2) Profile_Information_v2;
	dataset(recbrer) Business_Registrations;
	dataset(recragr) Registered_Agents;
	dataset(recconr) Contacts;
	dataset(recexer) Executives;
	//Only LEXIS no FARES
	dataset(recpror) Property;
	dataset(recpror_v2) Property_v2;
	dataset(recnodr) NoticeOfDefaults{xpath('NoticesOfDefaults/NoticeOfDefaults')};
	dataset(recforr) Foreclosures{xpath('Foreclosures/Foreclosure')};
	dataset(recmvrr) Motor_Vehicles; // GCL - 20051026
	dataset(recmvrr_v2) Motor_Vehicles_v2;
	dataset(recwctr) Watercrafts; // GCL - 20051026
	dataset(recairr) Aircrafts; // GCL - 20051026
	dataset(recidor) Internet;
	dataset(recplir) Professional_Licenses;
	dataset(recsupr) Superior_Liens;
	dataset(recbasr) Business_Associates;
	dataset(recebrr) Experian_Business_Reports;
	dataset(recirsr) IRS5500;
	dataset(recdnbr) DNB;
	dataset(recsancr)Business_Sanctions{xpath('BusinessSanctions/BusinessSanction')};
  dataset(recsdivcert) DiversityCertification{xpath('DiversityCertifications/DiversityCertification')};	
	dataset(recsriskmetric) RiskMetrics{xpath('RiskMetrics/RiskMetric')};
	dataset(recslabor) LaborActionWHD{xpath('LaborActionsWHD/LaborActionWHD')};
	dataset(recsnatdis) NaturalDisaster{xpath('NaturalDisasters/NaturalDisaster')};
	dataset(recslnca) LNCAFirmographics{xpath('LNCAFirmographics/LNCAFirmographic')};
	dataset(recsequi) EquifaxBusinessReport{xpath('EquifaxBusinessReport')};
	dataset(recsrcr) Source_Counts;	// TODO: why this is a dataset and not just a row?
	dataset(recflag) SOURCE_FLAGS;
	dataset(recMoreCounts) Source_Counts_more; 
end;


//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});
rec getall(nada l) := transform
	self.Best_Information 		:= global(group(besr));	
	self.Company_Verification := if(Include_BusinessRpt_Verification_val, global(verification));
 	self.Phone_Summary := if(Include_BusinessRpt_PhoneSummary_val, global(phone_summary));
	self.Ultimate_Parent_Information := global(upcr);
	self.Name_Variations 		:= global(nmvr_named);	
	self.Address_Variations 		:= global(advr_named);
	self.Phone_Variations 		:= global(phvr_named);	
	self.Parent_Company 		:= global(dcar.records);
	self.Sales 				:= global(salr.records);
	self.Industry_Information 	:= global(indr.records);
	self.ID_Numbers 			:= global(idnr.records);	
	self.Bankruptcy 			:= global(bnkr_named);
	self.Bankruptcy_v2 			:= global(bnkr_v2.records);
	self.Liens_Judgments 		:= global(ljur.records);
	self.Liens_Judgments_v2 := global(ljur_v2.records);
	self.Profile_Information 	  := global(prfr.records);
	self.Profile_Information_v2 := global(prfr_v2.records);
	self.Business_Registrations := global(brer.records);
	self.Registered_Agents 		:= global(ragr.records);
	self.Contacts 				:= global(conr.records);
	self.Executives 			:= global(exer.records);
	self.Property 				:= global(pror);
	self.Property_v2      := global(pror_v2.all_recs);
	self.NoticeOfDefaults := IF(Include_NoticeOfDefaults_val,global(nodr.records));
	self.Foreclosures     := IF(Include_Foreclosures_val,global(forr.records));
	self.Motor_Vehicles   := IF(NOT is_knowx,global(mvrr.records)); // GCL - 20051026
	self.Motor_Vehicles_v2 := IF(NOT is_knowx,global(ungroup(mvrr_v2.records)));
	self.Watercrafts      := IF(NOT is_knowx,global(wctr.records)); // GCL - 20051026
	self.Aircrafts        := IF(NOT is_knowx,global(airr.records)); // GCL - 20051026
	self.Internet 				:= global(idor_named);
	self.Professional_Licenses 	:= global(plir.records);
	self.Superior_Liens			:= dataset([],liens_superior.Layout_Liens_Superior_LNI);
	self.Business_Associates	:= global(basr.records);
	self.Experian_Business_Reports := IF(NOT is_knowx,global(ebrr.records));
	self.IRS5500 := global(irsr.records);
	self.DNB							:= global(dnbr);
	self.Business_Sanctions		:= if(Include_Sanctions_val, global(sancr));
	self.DiversityCertification := IF(Include_DiversityCert_val,global(divcert.records));
	self.RiskMetrics     				:= IF(Include_RiskMetrics_val,global(riskmet.records));
	self.LaborActionWHD   			:= IF(Include_LaborActWHD_val,global(laboract.records));
	self.NaturalDisaster  			:= IF(Include_NatDisReady_val,global(natdis.records));
	self.LNCAFirmographics  		:= IF(Include_LNCA_val,global(lncar.records));
	self.EquifaxBusinessReport	:= []; // supposed to be filled in by external caller.
	self.Source_Counts 			:= global(srcr_named);
	self.SOURCE_FLAGS				:= global(recflags1);
	self.Source_Counts_more := global(srcr_more_section_named);
	self := [];
end;

res := project(nada, getall(left));

return res;

END;