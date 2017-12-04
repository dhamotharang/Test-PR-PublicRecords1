import MDR;

EXPORT SourceServiceInfo := MODULE

	EXPORT AircraftSectionSources := [
		MDR.sourceTools.set_Aircrafts
	];
	
	EXPORT AssociateSectionSources := [
	];
	
	EXPORT BankruptcySectionSources := [
		 MDR.sourceTools.set_Bk                
	];
	
	EXPORT BestSectionSources := [
	];
	
	EXPORT ConnectedBusSectionSources := [
			MDR.sourceTools.set_Fbnv2
	];
	
	EXPORT ContactSectionSources := [
	];
	
	EXPORT CorpSectionSources := [
		 MDR.sourceTools.set_CorpV2,
		 MDR.sourceTools.set_Business_Registration
	];
	
	EXPORT FinanceSectionSources := [
			MDR.sourceTools.set_Dunn_Bradstreet_Fein,
			MDR.sourceTools.set_DCA,
			MDR.SourceTools.set_EBR,
			MDR.SourceTools.set_Sheila_Greco
	];
	
	EXPORT IndustrySectionSources := [
	];
	
	EXPORT LicenseSectionSources := [
		 MDR.sourceTools.set_Atf,
		 MDR.sourceTools.set_Dea,
		 MDR.sourceTools.set_FCC_Radio_Licenses,
		 MDR.sourceTools.set_Professional_License,
		 MDR.sourceTools.set_AMS
	];
	
	EXPORT LienSectionSources := [
			MDR.sourceTools.set_Liens_V2
	];
	
	EXPORT MVRSectionSources := [
			MDR.sourceTools.set_Vehicles
	];
	
	EXPORT OpSitesSectionSources := [
	];
	
	EXPORT ParentSectionSources := [
	];
	
	EXPORT PropertySectionSources := [
		MDR.sourceTools.set_property,
		MDR.sourceTools.set_Foreclosures,
		MDR.sourceTools.set_Foreclosures_Delinquent
	];
	
	EXPORT RegAgentSectionSources := [
	];
	
	EXPORT SourceSectionSources := [
			MDR.sourceTools.set_Aircrafts,
			MDR.sourceTools.set_AMIDIR,
			MDR.sourceTools.set_AMS,
			MDR.sourceTools.set_Atf,
			MDR.sourceTools.set_BBB_Member,
			MDR.sourceTools.set_BBB_Non_Member,
			MDR.sourceTools.set_Bk,
			MDR.sourceTools.set_Business_Registration,
			MDR.sourceTools.set_CA_Sales_Tax,
			MDR.sourceTools.set_Calbus,
			MDR.sourceTools.set_CNLD_Facilities,
			MDR.sourceTools.set_CorpV2,
			MDR.sourceTools.set_Cortera,
			MDR.sourceTools.set_CrashCarrier,
			MDR.sourceTools.set_DCA,
			MDR.sourceTools.set_Dea,
			MDR.sourceTools.set_Diversity_Cert,
			MDR.sourceTools.set_Dunn_Bradstreet_Fein,
			MDR.SourceTools.set_EBR, 
			MDR.SourceTools.set_Experian_CRDB,
			MDR.SourceTools.set_Experian_FEIN,
			MDR.sourceTools.set_Fbnv2,
			MDR.sourceTools.set_FCC_Radio_Licenses,
			MDR.sourceTools.set_FDIC,
			MDR.sourceTools.set_Foreclosures,
			MDR.sourceTools.set_Foreclosures_Delinquent,
			MDR.sourceTools.set_Frandx,
			MDR.sourceTools.set_GSA,
			MDR.sourceTools.set_Gong,
			MDR.sourceTools.set_IA_Sales_Tax,
			MDR.sourceTools.set_Insurance_Certification,
			MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ,
			MDR.sourceTools.set_INFOUSA_DEAD_COMPANIES,
			MDR.sourceTools.set_IRS_5500,
			MDR.sourceTools.set_IRS_Non_Profit,
			MDR.sourceTools.set_LaborActions_WHD,
			MDR.sourceTools.set_Liens_V2,
			MDR.sourceTools.set_MS_Worker_Comp,				
			MDR.sourceTools.set_NaturalDisaster_Readiness,				
			MDR.sourceTools.set_NCPDP,						
			MDR.sourceTools.set_OIG,
			MDR.sourceTools.set_OR_Worker_Comp,			
			MDR.sourceTools.set_OSHAIR,
			MDR.sourceTools.set_Professional_License,
			MDR.sourceTools.set_property,			
			MDR.sourceTools.set_SEC_Broker_Dealer,
			MDR.sourceTools.set_Sheila_Greco,
			MDR.sourceTools.set_Spoke,
			MDR.sourceTools.set_Txbus,
			MDR.sourceTools.set_UCCS,
			MDR.sourceTools.set_Vehicles,
			MDR.sourceTools.set_WC,
			MDR.sourceTools.set_Workers_Compensation,
			MDR.sourceTools.set_Yellow_Pages
	];
	
	EXPORT UCCSectionSources := [
		MDR.sourceTools.set_UCCS
	];
	
	EXPORT URLSectionSources := [
	];
	
	EXPORT WatercraftSectionSources := [
		MDR.sourceTools.set_WC
	];
	
	EXPORT DefaultSectionSources := [];
		
	SHARED sectionToCheck(string sectionName) := FUNCTION
			Section := MAP(sectionName = TopBusiness_Services.Constants.AircraftSectionName => AircraftSectionSources,
										 sectionName = TopBusiness_Services.Constants.AssociateSectionName => AssociateSectionSources,
										 sectionName = TopBusiness_Services.Constants.BankruptcySectionName => BankruptcySectionSources,
										 sectionName = TopBusiness_Services.Constants.BestSectionName => BestSectionSources,
										 sectionName = TopBusiness_Services.Constants.ConnectedBusSectionName => ConnectedBusSectionSources,
										 sectionName = TopBusiness_Services.Constants.ContactSectionName => ContactSectionSources,
										 sectionName = TopBusiness_Services.Constants.CorpSectionName => CorpSectionSources,
										 sectionName = TopBusiness_Services.Constants.FinanceSectionName => FinanceSectionSources,
										 sectionName = TopBusiness_Services.Constants.IndustrySectionName => IndustrySectionSources,
										 sectionName = TopBusiness_Services.Constants.LicenseSectionName =>LicenseSectionSources,
										 sectionName = TopBusiness_Services.Constants.LienSectionName => LienSectionSources,
										 sectionName = TopBusiness_Services.Constants.MVRSectionName => MVRSectionSources,
										 sectionName = TopBusiness_Services.Constants.OpSitesSectionName => OpSitesSectionSources,
										 sectionName = TopBusiness_Services.Constants.ParentSectionName => ParentSectionSources,
										 sectionName = TopBusiness_Services.Constants.PropertySectionName => PropertySectionSources,
										 sectionName = TopBusiness_Services.Constants.RegAgentSectionName => RegAgentSectionSources,
										 sectionName = TopBusiness_Services.Constants.SourceSectionName => SourceSectionSources,
										 sectionName = TopBusiness_Services.Constants.UCCSectionName => UCCSectionSources,
										 sectionName = TopBusiness_Services.Constants.URLSectionName => URLSectionSources,
										 sectionName = TopBusiness_Services.Constants.WatercraftSectionName => WatercraftSectionSources,
										 DefaultSectionSources);
			RETURN(Section);							 
	END;
			
	EXPORT IncludeRptAircraft(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsAircrafts(source) or
						MDR.sourceTools.set_Aircrafts[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptAmidir(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsAmidir(source) or
						MDR.sourceTools.set_Amidir[1] in sectionToCheck(section));
	END;

	EXPORT IncludeRptAMS(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsAMS(source) or
						MDR.sourceTools.set_AMS[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptATF(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsATF(source) or
						MDR.sourceTools.set_Atf[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptBankruptcy(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsBankruptcy(source) or
						MDR.sourceTools.set_Bk[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptBBBMember(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsBBB_Member(source) or
						MDR.sourceTools.set_BBB_Member[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptBBBNonMember(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsBBB_Non_Member(source) or
						MDR.sourceTools.set_BBB_Non_Member[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptBusReg(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsBusiness_Registration(source) or
						MDR.sourceTools.set_Business_Registration[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCalbus(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCalbus(source) or
						MDR.sourceTools.set_Calbus[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCASalesTax(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCA_Sales_Tax(source) or
						MDR.sourceTools.set_CA_Sales_Tax[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCorp(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCorpV2(source) or
						MDR.sourceTools.set_CorpV2[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCNLDFacility(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCNLD_Facilities(source) or
						MDR.sourceTools.set_CNLD_Facilities[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCortera(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCortera(source) or
						MDR.sourceTools.set_Cortera[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptCrash(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsCrashCarrier(source) or
						MDR.sourceTools.set_CrashCarrier[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptDCA(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsDCA(source) or
						MDR.sourceTools.set_DCA[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptDEA(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsDea(source) or
						MDR.sourceTools.set_Dea[1] in sectionToCheck(section));
	END;
		
	EXPORT IncludeRptDiversityCert(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsDiversity_Cert(source) or
						MDR.sourceTools.set_Diversity_Cert[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptDNBFein(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(source) or
						MDR.sourceTools.set_Dunn_Bradstreet_Fein[1] in sectionToCheck(section));
	END;
		
	EXPORT IncludeRptEBR(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsEBR(source) or
						MDR.sourceTools.set_EBR[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptEXPCRDB(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsExperian_CRDB(source) or
						MDR.sourceTools.set_Experian_CRDB[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptEXPFein(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsExperian_FEIN(source) or
						MDR.sourceTools.set_Experian_FEIN[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptFBN(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsFBNV2(source) or
						MDR.sourceTools.set_Fbnv2[1] in sectionToCheck(section));
	END;
			
	EXPORT IncludeRptFCC(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsFCC_Radio_Licenses(source) or
						MDR.sourceTools.set_FCC_Radio_Licenses[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptFDIC(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsFDIC(source) or
						MDR.sourceTools.set_FDIC[1] in sectionToCheck(section));
	END;	
	
	EXPORT IncludeRptForeclosure(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsForeclosures(source) or
						MDR.sourceTools.set_Foreclosures[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptFrandx(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsFrandx(source) or
						MDR.sourceTools.set_Frandx[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptGSA(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsGSA(source) or
						MDR.sourceTools.set_GSA[1] in sectionToCheck(section));
	END;	
	
	EXPORT IncludeRptGong(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsGong(source) or
						MDR.sourceTools.set_Gong[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptIASalesTax(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsIA_Sales_Tax(source) or
						MDR.sourceTools.set_IA_Sales_Tax[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptInfoUSA_ABIUS(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ(source) or
						MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptInfoUSA_Deadco(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(source) or
						MDR.sourceTools.set_INFOUSA_DEAD_COMPANIES[1] in sectionToCheck(section));
	END;

	EXPORT IncludeRptInsuranceCert(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsInsurance_Certification(source) or
						MDR.sourceTools.set_Insurance_Certification[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptIRS5500(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsIRS_5500(source) or
						MDR.sourceTools.set_IRS_5500[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptIRS990(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsIRS_Non_Profit(source) or
						MDR.sourceTools.set_IRS_Non_Profit[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptLaborActionsWHD(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsLaborActions_WHD(source) or
						MDR.sourceTools.set_LaborActions_WHD[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptLiens(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsLiens(source) or
						MDR.sourceTools.set_Liens_v2[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptMSWorkersComp(string source, string section) := FUNCTION
			RETURN(MDR.sourceTools.SourceIsMS_Worker_Comp(source) or
						 MDR.sourceTools.set_MS_Worker_Comp[1] in sectionToCheck(section));
	END;		
	
	EXPORT IncludeRptMVR(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsVehicle(source) or
						MDR.sourceTools.set_Vehicles[1] in sectionToCheck(section));
	END;

	EXPORT IncludeRptNaturalDisaster_Readiness(string source, string section) := FUNCTION
	 RETURN(MDR.sourceTools.SourceIsNaturalDisaster_Readiness(source) or
					MDR.sourceTools.set_NaturalDisaster_Readiness[1] in sectionToCheck(section));
	END;

	EXPORT IncludeRptNCPDP(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsNCPDP(source) or
						MDR.sourceTools.set_NCPDP[1] in sectionToCheck(section));
	END;		
	
	EXPORT IncludeRptNOD(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsForeclosures_Delinquent(source) or
						MDR.sourceTools.set_Foreclosures_Delinquent[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptOIG(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsOIG(source) or
						MDR.sourceTools.set_OIG[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptORWorkersComp(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsOR_Worker_Comp(source) or
						MDR.sourceTools.set_OR_Worker_Comp[1] in sectionToCheck(section));
	END;	
	
	EXPORT IncludeRptOshair(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsOSHAIR(source) or
						MDR.sourceTools.set_OSHAIR[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptOther(string source) := FUNCTION
		 RETURN(source != '' AND source not in SourceSectionSources);
	END;
				
	EXPORT IncludeRptProlic(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsProfessional_License(source) or
						MDR.sourceTools.set_Professional_License[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptProperty(string source, string section) := FUNCTION
	 RETURN(MDR.sourceTools.SourceIsProperty(source) or
					MDR.sourceTools.set_property[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptSEC_Broker_Dealer(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsSEC_Broker_Dealer(source) or
						MDR.sourceTools.set_SEC_Broker_Dealer[1] in sectionToCheck(section));
	END;
			
	EXPORT IncludeRptSheilaGreco(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsSheila_Greco(source) or
						MDR.sourceTools.set_Sheila_Greco[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptSpoke(string source, string section) := FUNCTION
		 RETURN (MDR.sourceTools.SourceIsSpoke(source) or
						MDR.sourceTools.set_Spoke[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptTxbus(string source, string section) := FUNCTION
		 RETURN (MDR.sourceTools.SourceIsTxbus(source) or
						MDR.sourceTools.set_Txbus[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptUCCs(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsUCCS(source) or
						MDR.sourceTools.set_UCCS[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptWatercraft(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsWC(source) or
						MDR.sourceTools.set_WC[1] in sectionToCheck(section));
	END;
		
	EXPORT IncludeRptYellowPages(string source, string section) := FUNCTION
		 RETURN(MDR.sourceTools.SourceIsYellow_Pages(source) or
						MDR.sourceTools.set_Yellow_Pages[1] in sectionToCheck(section));
	END;
	
	EXPORT IncludeRptWorkersCompensation(string source, string section) := FUNCTION
			RETURN(MDR.sourceTools.SourceIsWorkers_Compensation(source) or
						 MDR.sourceTools.set_Workers_Compensation[1] in sectionToCheck(section));
	END;
		
END;