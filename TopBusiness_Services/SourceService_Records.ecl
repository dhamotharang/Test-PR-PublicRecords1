//NOTE: The coding in this attribute needs to be kept in sync with the datasets in
//      iesp.topbusinesssourcedoc.t_TopBusinessSourceDocRecord

import BIPV2,iesp;

export SourceService_Records(
	dataset(TopBusiness_Services.SourceService_Layouts.InputLayout) indata,
	BIPV2.mod_sources.iParams inmod,
	TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions) := function
	
	FETCH_LEVEL := inoptions.fetch_Level;
	
	//Transform to non iesp record structure
	indataRecs := PROJECT(indata,TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																				SELF.DotID 	:= LEFT.BusinessIds.DotID,
																				SELF.EmpID 	:= LEFT.BusinessIds.EmpID,
																				SELF.POWID 	:= LEFT.BusinessIds.POWID,
																				SELF.ProxID	:= LEFT.BusinessIds.ProxID,
																				SELF.SeleID	:= LEFT.BusinessIds.SeleID,
																				SELF.OrgID	:= LEFT.BusinessIds.OrgID,
																				SELF.UltID	:= LEFT.BusinessIds.UltID,
																				SELF.NameInfo := Left.Name,
																				SELF.AddressInfo := Left.Address,
																				// If both a section and source are passed, the source takes
																				// precedence, so in these cases the section is blaked out.
																				SELF.Section := IF(LEFT.Source = '',LEFT.Section,''),
																				SELF := LEFT));
	
 
	// First, dedup the input requests by linkids, idvalues, section and source
	deduped_sources := dedup(indataRecs,
														#expand(BIPV2.IDmacros.mac_ListAllLinkids()),
														IdValue,IdType,Section,Source,all);

	// ******************************* 
	// Get each type of SOURCE documents using the values in the linkids or idvalue

	// Default/Other Directories. This is the default scenario for all sources that do not have their own
	// source specific logic.
	// call the BIP Bus header kfetch if needed and use that to pass into otherSource_records
	//
	ds_empty_bhKfetchCall := dataset([],BIPV2.Key_BH_Linking_Ids.kfetchOutRec);
	other_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptOther(source));
	ds_linkids_only := PROJECT(other_source_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																		SELF := LEFT,
																		SELF := []));
	bhRecs := IF (EXISTS(ds_linkids_only), 
	             BIPV2.Key_BH_Linking_Ids.kfetch(ds_linkids_only,FETCH_LEVEL,
	                      ,,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit,TRUE)
								,ds_empty_bhKfetchCall);
	other_docs := CHOOSEN(TopBusiness_Services.OtherSource_Records(other_source_docids,inoptions,TRUE,bhRecs)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_OTHER_GROUP);
  other_prepared := PROJECT(other_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
	
	// AIRCRAFT 
	aircraft_source_docids := deduped_sources(SourceServiceInfo.IncludeRptAircraft(source,section));
	aircraft_docs := CHOOSEN(TopBusiness_Services.AircraftSource_Records(aircraft_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FAA_RECORD);
	aircraft_prepared := PROJECT(aircraft_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.Aircrafts := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
	
	// Amidir License 
	amidir_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptAmidir(source,section));
	amidir_docs := CHOOSEN(TopBusiness_Services.AmidirSource_Records(amidir_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_AMSLIC_RECORD);
	amidir_prepared := PROJECT(amidir_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
	// AMS License 
	ams_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptAMS(source,section));
	ams_docs := CHOOSEN(TopBusiness_Services.AMSSource_Records(ams_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_AMSLIC_RECORD);
	ams_prepared := PROJECT(ams_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.AMSLicenses := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
	// ATF, Alcohol, Tobacco and Firearms
	atf_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptATF(source,section));
	atf_docs := CHOOSEN(TopBusiness_Services.ATFSource_Records(atf_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FIREARM_RECORD);
  atf_prepared := PROJECT(atf_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.AtfRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));

	// BANKRUPTCY
	bankruptcy_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptBankruptcy(source,section));
	bankruptcy_docs := CHOOSEN(TopBusiness_Services.BankruptcySource_Records(bankruptcy_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_BK_RECORD);
  bankruptcy_prepared := PROJECT(bankruptcy_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.BankruptcyReportRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
	
	// BBB Member
	bbbMember_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptBBBMember(source,section));
	bbbMember_docs := CHOOSEN(TopBusiness_Services.BBBSource_Records(bbbMember_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_BBB_RECORD);
  bbbMember_prepared := PROJECT(bbbMember_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
	
	// BBB Non Member
	bbbNonMember_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptBBBNonMember(source,section));
	bbbNonMember_docs := CHOOSEN(TopBusiness_Services.BBBNonMemSource_Records(bbbNonMember_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_BBB_RECORD);
  bbbNonMember_prepared := PROJECT(bbbNonMember_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
 	// Business Registrations
	busreg_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptBusReg(source,section));
	busreg_docs := CHOOSEN(TopBusiness_Services.BusinessRegSource_Records(busreg_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_BK_RECORD);
  busreg_prepared := PROJECT(busreg_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.BusinessRegistrationRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
	// Calbus 
	calbus_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCalbus(source,section));
	calbus_docs     := CHOOSEN(TopBusiness_Services.CalbusSource_Records(calbus_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CALBUS_RECORD);
	calbus_prepared := PROJECT(calbus_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));

	// CA Sales Tax 
	catax_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCASalesTax(source,section));
	catax_docs     := CHOOSEN(TopBusiness_Services.CASalesTaxSource_Records(catax_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CATAX_RECORD);
	catax_prepared := PROJECT(catax_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
	// CNLD Facilities 
	cnld_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCNLDFacility(source,section));
	cnld_docs     := CHOOSEN(TopBusiness_Services.CNLDFacilitySource_Records(cnld_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CNLD_RECORD);
	cnld_prepared := PROJECT(cnld_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.CNLDFacilities := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
	
	// CORPORATIONS - source= multiple "C*" codes, source_docid = corp_key+'//'+ corp_process_date
	corp_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCorp(source,section));
	corp_docs     := CHOOSEN(TopBusiness_Services.CorporationSource_Records(corp_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CORP_RECORD);
	corp_prepared := PROJECT(corp_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.CorporateFilings := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
  
  // CORTERA - source= 'RR' source_docid=link_id
	cortera_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCortera(source,section));
	cortera_docs     := CHOOSEN(TopBusiness_Services.CorteraSource_Records(cortera_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CORTERA_RECORD);
	cortera_prepared := PROJECT(cortera_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.CorteraRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));																						
	
	// Crash Carrier
	crash_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptCrash(source,section));
	crash_docs     := CHOOSEN(TopBusiness_Services.CrashCarrierSource_Records(crash_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_CRASH_RECORD);
	crash_prepared := PROJECT(crash_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.CrashCarriers := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));

  // DCA (AKA LNCA) 
	dca_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptDCA(source,section));
	dca_docs     := CHOOSEN(TopBusiness_Services.dcaSource_Records(dca_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_DCA_RECORD);
	dca_prepared := PROJECT(dca_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.DcaRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

  // DEA (Drug Engforcement Administration) - source=DA, source_docid=dea_registration_number
	dea_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptDEA(source,section));
	dea_docs     := CHOOSEN(TopBusiness_Services.DEASource_Records(dea_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_DEA_RECORD);
	dea_prepared := PROJECT(dea_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.DeaRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

	// Diversity certification
	div_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptDiversityCert(source,section));
	div_docs     := CHOOSEN(TopBusiness_Services.DiversityCertSource_Records(div_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_DIVCERT_RECORD);
	div_prepared := PROJECT(div_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.DiversityCertRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
  // DUN & BRADSTREET FEIN - source='DN',  source_docid=tmsid
	dnbfein_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptDNBFein(source,section));
	dnbfein_docs     := CHOOSEN(TopBusiness_Services.dnbfeinSource_Records(dnbfein_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FEIN_RECORD);
	dnbfein_prepared := PROJECT(dnbfein_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.FeinRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

	// EXPERIAN BUSINESS REPORTS (EBR) - source='ER',  source_docid=file_number+'//'+process_date,
	ebr_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptEBR(source,section));
	ebr_docs     := CHOOSEN(TopBusiness_Services.EBRSource_Records(ebr_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_EBR_RECORD);
	ebr_prepared := PROJECT(ebr_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.EbrRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		
	
	// EXPERIAN CRDB
	expcrdb_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptEXPCrdb(source,section));
	expcrdb_docs     := CHOOSEN(TopBusiness_Services.ExperianCRDBSource_Records(expcrdb_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_EXPCRDB_RECORD);
	expcrdb_prepared := PROJECT(expcrdb_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.ExpCRDBRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		
																						
	// EXPERIAN FEIN - source='E5','E6'
	expfein_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptEXPFein(source,section));
	expfein_docs     := CHOOSEN(TopBusiness_Services.ExperianFeinSource_Records(expfein_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_EBR_RECORD);
	expfein_prepared := PROJECT(expfein_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.ExpFeinRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		

  // FICTITIOUS BUSINESS NAMES (FBNs) - source_docid = tmsid(38?)+ '//' + rmsid(35?)
	fbn_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptFBN(source,section));
	fbn_docs     := CHOOSEN(TopBusiness_Services.FBNSource_Records(fbn_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FBN_RECORD);
	fbn_prepared := PROJECT(fbn_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.FbnRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		

  // FCC Licenses
	fcc_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptFCC(source,section));
	fcc_docs     := CHOOSEN(TopBusiness_Services.FCCSource_Records(fcc_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FCC_RECORD);
	fcc_prepared := PROJECT(fcc_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.FccRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

	// FDIC
	fdic_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptFDIC(source,section));
	fdic_docs     := CHOOSEN(TopBusiness_Services.FDICSource_Records(fdic_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FDIC_RECORD);
	fdic_prepared := PROJECT(fdic_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																																										
	// FORECLOSURE
	forec_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptForeclosure(source,section));
	forec_docs := CHOOSEN(TopBusiness_Services.ForeclosureNODSource_Records(forec_source_docids,inoptions,false,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FOREC_RECORD);
	forec_prepared := PROJECT(forec_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.Foreclosures := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
	// Franchise
	frandx_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptFrandx(source,section));
	frandx_docs := CHOOSEN(TopBusiness_Services.FranchiseSource_Records(frandx_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FRANDX_RECORD);
  frandx_prepared := PROJECT(frandx_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.FranchiseRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																			
	// Gong - Phone
	gong_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptGong(source,section));
	gong_docs := CHOOSEN(TopBusiness_Services.GongSource_Records(gong_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_GONG_RECORD);
  gong_prepared := PROJECT(gong_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.GongRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																					
	// GSA
	gsa_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptGSA(source,section));
	gsa_docs := CHOOSEN(TopBusiness_Services.GSASource_Records(gsa_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_GSA_RECORD);
  gsa_prepared := PROJECT(gsa_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));																					
																					
  //IA State Tax
	iatax_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptIASalesTax(source,section));
	iatax_docs     := CHOOSEN(TopBusiness_Services.IASalesTaxSource_Records(iatax_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_IATAX_RECORD);
	iatax_prepared := PROJECT(iatax_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																					
	// InfoUSA_ABIUS
	infoUSA_abius_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptInfoUSA_ABIUS(source,section));
	infoUSA_abius_docs := CHOOSEN(TopBusiness_Services.InfoUSA_ABIUSSource_Records(infoUSA_abius_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_USABIZ_RECORD);
  infoUSA_abius_prepared := PROJECT(infousa_abius_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
	// InfoUSA_Deadco
	infoUSA_deadco_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptInfoUSA_deadco(source,section));
	infoUSA_deadco_docs := CHOOSEN(TopBusiness_Services.InfoUSA_DeadcoSource_Records(infoUSA_deadco_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_DEADCO_RECORD);
  infoUSA_deadco_prepared := PROJECT(infousa_deadco_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));

	
		// Insurance Certification
	insCert_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptInsuranceCert(source,section));
	insCert_docs := CHOOSEN(TopBusiness_Services.InsuranceCertSource_Records(insCert_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_INSCERT_RECORD);
  insCert_prepared := PROJECT(insCert_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.InsuranceCertRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
	// IRS 5500
	irs5500_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptIRS5500(source,section));
	irs5500_docs := CHOOSEN(TopBusiness_Services.IRS5500Source_Records(irs5500_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_IRS5500_RECORD);
  irs5500_prepared := PROJECT(irs5500_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
	
	// IRS 990 - Non Profit
	irs990_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptIRS990(source,section));
	irs990_docs := CHOOSEN(TopBusiness_Services.IRS990Source_Records(irs990_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_IRS990_RECORD);
  irs990_prepared := PROJECT(irs990_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
	// LABOR ACTIONS WHD
	labor_actions_whd_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptLaborActionsWHD(source,section));
	labor_actions_whd_docs := CHOOSEN(TopBusiness_Services.LaborActionsWHDSource_Records(labor_actions_whd_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_LNJ_RECORD);
	labor_actions_whd_prepared := PROJECT(labor_actions_whd_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));			
	
	// LIENS & JUDGMENTS source=xx(multiple), source_docid=tmsid
	lien_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptLiens(source,section));
	lien_docs := CHOOSEN(TopBusiness_Services.LienSource_Records(lien_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_LNJ_RECORD);
	lien_prepared := PROJECT(lien_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.liensjudgments := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		
																						
	// Mississippi Workers Compensation
	MSWorkersComp_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptMSWorkersComp(source,section));
	MSWorkersComp_docs := CHOOSEN(TopBusiness_Services.MSWorkSource_Records(MSWorkersComp_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_MSWORK_RECORD);
	MSWorkersComp_prepared := PROJECT(MSWorkersComp_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left), 
																						self.acctno := 'SINGLE',
																						self := []));																								

	// MOTOR VEHICLE REGISTRATIONS (MVRs) - source=multiple values
	mvr_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptMVR(source,section));
	mvr_docs := CHOOSEN(TopBusiness_Services.MotorVehicleSource_Records(mvr_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_MVR_RECORD);
	mvr_prepared := PROJECT(mvr_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.MotorVehicles := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));
																						
	// Natural Disaster Readiness
	ndr_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptNaturalDisaster_Readiness(source,section));
	ndr_docs := CHOOSEN(TopBusiness_Services.NDRSource_Records(ndr_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_NDR_RECORD);
	ndr_prepared := PROJECT(ndr_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));																							
																						
	// NCPDP (National Council for prescription Drug Program)
	ncpdp_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptNCPDP(source,section));
	ncpdp_docs := CHOOSEN(TopBusiness_Services.NcpdpSource_Records(ncpdp_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_NCPDP_RECORD);
	ncpdp_prepared := PROJECT(ncpdp_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
	// NOTICE OF DEFAULT(NOD) 
	nod_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptNod(source,section));
	nod_docs := CHOOSEN(TopBusiness_Services.ForeclosureNODSource_Records(nod_source_docids,inoptions,false,true)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_FOREC_RECORD);
	nod_prepared := PROJECT(nod_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.NoticeOfDefaults := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

	// Oregon Workers Compensation
	ORWorkersComp_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptORWorkersComp(source,section));
	ORWorkersComp_docs := CHOOSEN(TopBusiness_Services.ORWorkSource_Records(ORWorkersComp_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_WORKERSCOMP_RECORD);
	ORWorkersComp_prepared := PROJECT(ORWorkersComp_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left), 
																						self.acctno := 'SINGLE',
																						self := []));				
	// OIG 
	oig_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptOIG(source,section));
	oig_docs := CHOOSEN(TopBusiness_Services.OIGSource_Records(oig_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_OIG_RECORD);
	oig_prepared := PROJECT(oig_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(LEFT),
																						self.acctno := 'SINGLE',
																						self := []));	
	// Oshair 
	oshair_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptOshair(source,section));
	oshair_docs := CHOOSEN(TopBusiness_Services.OshairSource_Records(oshair_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_OSHAIR_RECORD);
	oshair_prepared := PROJECT(oshair_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OSHAReportRecords := dataset(LEFT),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
	// PROFESSIONAL LICENSES -
	prolic_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptProlic(source,section));
	prolic_docs := CHOOSEN(TopBusiness_Services.ProfLicenseSource_Records(prolic_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_PROFLIC_RECORD);
	prolic_prepared := PROJECT(prolic_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.ProlicRecords := dataset(LEFT),
																						self.acctno := 'SINGLE',
																						self := []));			
							
	// REAL PROPERTY (includes Assessments, Deeds & Mortgages); 
	property_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptProperty(source,section));
	property_docs := CHOOSEN(TopBusiness_Services.PropertySource_Records(property_source_docids,inoptions,,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_PROP_RECORD);
	property_prepared := PROJECT(property_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.PropertyReportRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		
																						
	// SEC Broker/Dealer
	secbd_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptSEC_Broker_Dealer(source,section));
	secbd_docs := CHOOSEN(TopBusiness_Services.SEC_BDSource_Records(secbd_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_SEC_RECORD);
	secbd_prepared := PROJECT(secbd_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));																							
																						
	// SHEILA GRECO 
	sgreco_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptSheilaGreco(source,section));
	sgreco_docs := CHOOSEN(TopBusiness_Services.SheilaGrecoSource_Records(sgreco_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_SHEILA_RECORD);
	sgreco_prepared := PROJECT(sgreco_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.SheilaGrecoRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
	// SPOKE 
	spoke_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptSpoke(source,section));	
	spoke_docs := CHOOSEN(TopBusiness_Services.SpokeSource_Records(spoke_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_SPOKE_RECORD);
	spoke_prepared := PROJECT(spoke_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));		
																						
	// TXBUS 
	txbus_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptTxbus(source,section));	
	txbus_docs := CHOOSEN(TopBusiness_Services.TXBUSSource_Records(txbus_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_TXBUS_RECORD);
	txbus_prepared := PROJECT(txbus_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));									

	// UCC - source=multiple values, source_docid== trim(tmsid,left,right)
	ucc_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptUCCs(source,section));
	ucc_docs := CHOOSEN(TopBusiness_Services.UCCSource_Records(ucc_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_UCC_RECORD);
	ucc_prepared := PROJECT(ucc_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.UCCFilings := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	

	// WATERCRAFT - source=multiple values, source_docid = watercraft_key(30)+ '//' + sequence_key(30)
	watercraft_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptWatercraft(source,section));
	watercraft_docs := CHOOSEN(TopBusiness_Services.WatercraftSource_Records(watercraft_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_WC_RECORD);
	watercraft_prepared := PROJECT(watercraft_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.Watercrafts := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
																						
	// Workers Compensation
	workersCompensation_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptWorkersCompensation(source,section));
	workersCompensation_docs     := CHOOSEN(TopBusiness_Services.WorkersCompensationSource_Records(workersCompensation_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_WORKERSCOMP_RECORD);
	workersCompensation_prepared := PROJECT(workersCompensation_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.WorkCompInsuranceCertRecords := dataset(left), 
																						// self.OtherSourceRecords := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));				
 
 	// YellowPages
	yellowpage_source_docids := deduped_sources(TopBusiness_Services.SourceServiceInfo.IncludeRptYellowPages(source,section));
	yellowpage_docs := CHOOSEN(TopBusiness_Services.YellowPagesSource_Records(yellowpage_source_docids,inoptions,false)
																						.SourceView_Recs,iesp.Constants.TOPBUSINESS.MAX_COUNT_YP_RECORD);
	yellowpage_prepared := PROJECT(yellowpage_docs,transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
																						self.YellowPages := dataset(left),
																						self.acctno := 'SINGLE',
																						self := []));	
	
	// As of now, many sources are placed into the othersourceRecords in the ouput dataset, combine and limit 
	// the total amount to not exceed the dataset max limit.
	allOther_prepared := CHOOSEN(other_prepared
																+ amidir_prepared 
																+ bbbMember_prepared
																+ bbbNonMember_prepared
																+ calbus_prepared
																+ catax_prepared
																+ fdic_prepared															
																+ gsa_prepared																
																+ iatax_prepared
																+ infoUSA_abius_prepared
																+	infoUSA_deadco_prepared
																+ irs5500_prepared
																+ irs990_prepared
																+ labor_actions_whd_prepared
																+ msWorkersComp_prepared
																+	ncpdp_prepared
																+	ndr_prepared
																+ orWorkersComp_prepared
																+ oig_prepared
																+ secbd_prepared
																+ spoke_prepared
																+ txbus_prepared
																,iesp.Constants.TOPBUSINESS.MAX_COUNT_OTHER_RECORD);

 // Add together all the prepared sources
 all_prepared := aircraft_prepared
		+ allOther_prepared
  	+ ams_prepared
		+ atf_prepared      
		+ bankruptcy_prepared
		+ busreg_prepared
		+ cnld_prepared
		+ corp_prepared    
		+ cortera_prepared
    + crash_prepared
    + dca_prepared         
    + dea_prepared  
		+ div_prepared
		+ dnbfein_prepared     
		+ ebr_prepared  
		+ expcrdb_prepared
		+ expfein_prepared
		+ fbn_prepared
		+ fcc_prepared
		+ forec_prepared
		+ frandx_prepared
		+ gong_prepared
		+ insCert_prepared
		+ lien_prepared        
		+ mvr_prepared         
		+ nod_prepared
		+ oshair_prepared
    + prolic_prepared     
		+ property_prepared    	
		+ sgreco_prepared   
		+ ucc_prepared        
		+ watercraft_prepared  
		+ workersCompensation_prepared
		+ yellowpage_prepared
		;

	rollup_acctno := rollup(sort(all_prepared,acctno),
		left.acctno = right.acctno,
		transform(TopBusiness_Services.SourceService_Layouts.OutputLayout,
			self.Aircrafts  := left.Aircrafts + right.Aircrafts,
			self.AMSLicenses := left.AMSLicenses + right.AMSLicenses,
			self.AtfRecords := left.AtfRecords + right.AtfRecords,
			self.BankruptcyReportRecords := left.BankruptcyReportRecords + right.BankruptcyReportRecords,
			self.BusinessRegistrationRecords := left.BusinessRegistrationRecords + right.BusinessRegistrationRecords,
			self.CNLDFacilities := left.CNLDFacilities + right.CNLDFacilities,	
			self.CorporateFilings := left.CorporateFilings + right.CorporateFilings,
			self.CorteraRecords := left.CorteraRecords + right.CorteraRecords;
			self.CrashCarriers := left.CrashCarriers + right.CrashCarriers,
			self.DcaRecords := left.DcaRecords + right.DcaRecords,
			self.DeaRecords := left.DeaRecords + right.DeaRecords,
			self.DiversityCertRecords := left.DiversityCertRecords + right.DiversityCertRecords,
			self.FeinRecords := left.FeinRecords + right.FeinRecords,
			self.EbrRecords := left.EbrRecords + right.EbrRecords,
			self.ExpCRDBRecords := left.ExpCRDBRecords + right.ExpCRDBRecords,
			self.ExpFeinRecords := left.ExpFeinRecords + right.ExpFeinRecords,
			self.FbnRecords := left.FbnRecords + right.FbnRecords,
			self.FccRecords := left.FccRecords + right.FccRecords,
			self.FranchiseRecords := left.FranchiseRecords + right.FranchiseRecords,
			self.Foreclosures := left.Foreclosures + right.Foreclosures,
			self.GongRecords  := left.GongRecords + right.GongRecords,
			self.InsuranceCertRecords := left.InsuranceCertRecords + right.InsuranceCertRecords,
      self.LiensJudgments := left.LiensJudgments + right.LiensJudgments,
      self.MotorVehicles := left.MotorVehicles + right.MotorVehicles,
			self.NoticeOfDefaults := left.NoticeOfDefaults + right.NoticeOfDefaults,
			self.ProlicRecords := left.ProlicRecords + right.ProlicRecords,
			self.OSHAReportRecords := left.OSHAReportRecords + right.OSHAReportRecords,
	    self.OtherSourceRecords := left.OtherSourceRecords + right.OtherSourceRecords,
			self.PropertyReportRecords := left.PropertyReportRecords + right.PropertyReportRecords,
			self.SheilaGrecoRecords := left.SheilaGrecoRecords + right.SheilaGrecoRecords,
			self.UCCFilings := left.UCCFilings + right.UCCFilings,
			self.Watercrafts := left.Watercrafts + right.Watercrafts,
			self.WorkCompInsuranceCertRecords := left.WorkCompInsuranceCertRecords + right.WorkCompInsuranceCertRecords,
			self.YellowPages := left.YellowPages + right.YellowPages,
		  self := left,
			SELF := []));

  // For debugging, uncomment the lies below as needed
  // output(indata,                          named('indata'));
	// output(indataRecs,										 	named('indataRecs'));
	// output(inmod);
	// output(deduped_sources,          			named('deduped_sources'));

	// output(allOther_prepared,							named('allOther_prepared'));
  // output(aircraft_source_docids,         named('aircraft_source_docids'));
	// output(aircraft_docs,                  named('aircraft_docs'));
	// output(aircraft_prepared,              named('aircraft_prepared'));
	// output(ams_source_docids,              named('ams_source_docids'));
	// output(ams_docs,                       named('ams_docs'));
	// output(ams_prepared,                   named('ams_prepared'));
  // output(atf_source_docids,              named('atf_source_docids'));
	// output(atf_docs,                       named('atf_docs'));
	// output(atf_prepared,                   named('atf_prepared'));
	// output(bankruptcy_source_docids,       named('bankruptcy_source_docids'));
	// output(bankruptcy_docs,                named('bankruptcy_docs'));
	// output(bankruptcy_prepared,            named('bankruptcy_prepared'));
	// output(bbbMember_source_docids,        named('bbbMember_source_docids'));
	// output(bbbMember_docs,                 named('bbbMember_docs'));
	// output(bbbMember_prepared,             named('bbbMember_prepared'));
	// output(bbbNonMember_source_docids,     named('bbbNonMember_source_docids'));
	// output(bbbNonMember_docs,              named('bbbNonMember_docs'));
	// output(bbbNonMember_prepared,          named('bbbNonMember_prepared'));
	// output(busreg_source_docids,       		named('busreg_source_docids'));
	// output(busreg_docs,                		named('busreg_docs'));
	// output(busreg_prepared,            		named('busreg_prepared'));
	// output(catax_source_docids,            named('catax_source_docids'));
	// output(catax_docs,                     named('catax_docs'));
	// output(catax_prepared,                 named('catax_prepared'));
	// output(cnld_source_docids,             named('cnld_source_docids'));
	// output(cnld_docs,                      named('cnld_docs'));
	// output(cnld_prepared,                  named('cnld_prepared'));
  // output(corp_source_docids,             named('corp_source_docids'));
	// output(corp_docs,                      named('corp_docs'));
	// output(corp_prepared,                  named('corp_prepared'));
	// output(cortera_source_docids,             named('cortera_source_docids'));
	// output(cortera_docs,                      named('cortera_docs'));
	// output(cortera_prepared,                  named('cortera_prepared'));
	// output(crash_source_docids,             named('crash_source_docids'));
	// output(crash_docs,                      named('crash_docs'));
	// output(crash_prepared,                  named('crash_prepared'));
	// output(dca_source_docids,              named('dca_source_docids'));
	// output(dca_docs,                       named('dca_docs'));
	// output(dca_prepared,                   named('dca_prepared'));
	// output(dea_source_docids,              named('dea_source_docids'));
	// output(dea_docs,                       named('dea_docs'));
	// output(dea_prepared,                   named('dea_prepared'));
	// output(div_source_docids,              named('div_source_docids'));
	// output(div_docs,                       named('div_docs'));
	// output(div_prepared,                   named('div_prepared'));
	// output(dnbfein_source_docids,          named('dnbfein_source_docids'));
	// output(dnbfein_docs,                   named('dnbfein_docs'));
	// output(dnbfein_prepared,               named('dnbfein_prepared'));
  // output(ebr_source_docids,              named('ebr_source_docids'));
	// output(ebr_docs,                       named('ebr_docs'));
	// output(ebr_prepared,                   named('ebr_prepared'));	
	// output(expcrdb_source_docids,          named('expcrdb_source_docids'));
	// output(expcrdb_docs,                   named('expcrdb_docs'));
	// output(expcrdb_prepared,               named('expcrdb_prepared'));
	// output(expfein_source_docids,          named('expfein_source_docids'));
	// output(expfein_docs,                   named('expfein_docs'));
	// output(expfein_prepared,               named('expfein_prepared'));
	// output(fbn_source_docids,              named('fbn_source_docids'));
	// output(fbn_docs,                       named('fbn_docs'));
	// output(fbn_prepared,                   named('fbn_prepared'));
	// output(fcc_source_docids,             	named('fcc_source_docids'));
	// output(fcc_docs,                      	named('fcc_docs'));
	// output(fcc_prepared,                  	named('fcc_prepared'));
	// output(fdic_source_docids,            	named('fdic_source_docids'));
	// output(fdic_docs,                     	named('fdic_docs'));
	// output(fdic_prepared,                 	named('fdic_prepared'));	
	// output(forec_source_docids,            named('forec_source_docids'));
	// output(forec_docs,                     named('forec_docs'));
	// output(forec_prepared,                 named('forec_prepared'));
	// output(frandx_source_docids,           named('frandx_source_docids'));
	// output(frandx_docs,                    named('frandx_docs'));
	// output(frandx_prepared,                named('frandx_prepared'));
	// output(gong_source_docids,           	named('gong_source_docids'));
	// output(gong_docs,                    	named('gong_docs'));
	// output(gong_prepared,                	named('gong_prepared'));
	// output(gsa_source_docids,           		named('gsa_source_docids'));
	// output(gsa_docs,                    		named('gsa_docs'));
	// output(gsa_prepared,                		named('gsa_prepared'));	
	// output(iatax_source_docids,            named('iatax_source_docids'));
	// output(iatax_docs,                     named('iatax_docs'));
	// output(iatax_prepared,                 named('iatax_prepared'));	
  // OUTPUT(infoUSA_deadco_source_docids,   NAMED('infoUSA_deadco_source_docids'));
  // OUTPUT(infoUSA_deadco_docs,            NAMED('infoUSA_deadco_docs'));
  // OUTPUT(infoUSA_deadco_prepared,        NAMED('infoUSA_deadco_prepared'));
	// output(insCert_source_docids,         	named('insCert_source_docids'));
	// output(insCert_docs,                  	named('insCert_docs'));
	// output(insCert_prepared,              	named('insCert_prepared'));
	// output(irs5500_source_docids,         	named('irs5500_source_docids'));
	// output(irs5500_docs,                  	named('irs5500_docs'));
	// output(irs5500_prepared,              	named('irs5500_prepared'));
	// output(irs990_source_docids,         	named('irs990_source_docids'));
	// output(irs990_docs,                  	named('irs990_docs'));
	// output(irs990_prepared,              	named('irs990_prepared'));
	// output(lien_source_docids,             named('lien_source_docids'));
	// output(lien_docs,                      named('lien_docs'));
	// output(lien_prepared,                  named('lien_prepared'));
	// output(MSWorkersComp_source_docids, 		named('MSWorkersComp_source_docids'));
	// output(MSWorkersComp_docs,          		named('MSWorkersComp_docs'));
	// output(MSWorkersComp_prepared,      		named('MSWorkersComp_prepared'));		
	// output(mvr_source_docids,              named('mvr_source_docids'));
	// output(choosen(mvr_docs,500),          named('mvr_docs'));
	// output(mvr_prepared,                   named('mvr_prepared'));
	// output(ncpdp_source_docids, 						named('ncpdp_source_docids'));
	// output(ncpdp_docs,          						named('ncpdp_docs'));
	// output(ncpdp_prepared,      						named('ncpdp_prepared'));	
	// output(ndr_source_docids, 							named('ndr_source_docids'));
	// output(ndr_docs,          							named('ndr_docs'));
	// output(ndr_prepared,      							named('ndr_prepared'));	
	// output(nod_source_docids,            	named('nod_source_docids'));
	// output(nod_docs,                       named('nod_docs'));
	// output(nod_prepared,                 	named('nod_prepared'));
	// output(ORWorkersComp_source_docids, 		named('ORWorkersComp_source_docids'));
	// output(ORWorkersComp_docs,          		named('ORWorkersComp_docs'));
	// output(ORWorkersComp_prepared,      		named('ORWorkersComp_prepared'));	
	// output(oshair_source_docids,						named('oshair_source_docids'));
	// output(oshair_docs,										named('oshair_docs'));
	// output(oshair_prepared,								named('oshair_prepared'));
	// output(other_source_docids,						named('other_source_docids'));
	// output(other_docs,											named('other_docs'));
	// output(other_prepared,									named('other_prepared'));
  // output(prolic_source_docids,           named('prolic_source_docids'));
	// output(prolic_docs,                    named('prolic_docs'));
	// output(prolic_prepared,                named('prolic_prepared'));
  // output(property_source_docids,         named('property_source_docids'));
	// output(property_docs,                  named('property_docs'));
	// output(property_prepared,              named('property_prepared'));
	// output(secbd_source_docids,            named('secbd_source_docids'));
	// output(secbd_docs,                     named('secbd_docs'));
	// output(secbd_prepared,                 named('secbd_prepared'));	
	// output(sgreco_source_docids,           named('sgreco_source_docids'));
	// output(sgreco_docs,                    named('sgreco_docs'));
	// output(sgreco_prepared,                named('sgreco_prepared'));
	// output(spoke_source_docids,            named('spoke_source_docids'));
	// output(spoke_docs,                     named('spoke_docs'));
	// output(spoke_prepared,                 named('spoke_prepared'));
	// output(txbus_source_docids,           	named('txbus_source_docids'));
	// output(txbus_docs,                     named('txbus_docs'));
	// output(txbus_prepared,                 named('txbus_prepared'));
	// output(ucc_source_docids,              named('ucc_source_docids'));
	// output(ucc_docs,                       named('ucc_docs'));
	// output(ucc_prepared,                   named('ucc_prepared'));
  // output(watercraft_source_docids,       named('watercraft_source_docids'));
	// output(watercraft_docs,                named('watercraft_docs'));
	// output(watercraft_prepared,            named('watercraft_prepared'));
	// output(workersCompensation_source_docids, named('workersCompensation_source_docids'));
	// output(workersCompensation_docs,          named('workersCompensation_docs'));
	// output(workersCompensation_prepared,      named('workersCompensation_prepared'));
	// output(yellowpage_source_docids,       named('yellowpage_source_docids'));
	// output(yellowpage_docs,                named('yellowpage_docs'));
	// output(yellowpage_prepared,            named('yellowpage_prepared'));
  // output(all_prepared,                   named('all_prepared'));
	// output(attach_acctno,                  named('attach_acctno'));
	// output(rollup_acctno,                  named('rollup_acctno'));

	return rollup_acctno;
	
end;