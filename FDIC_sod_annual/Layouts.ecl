import Address, BIPV2;
export Layouts :=
module

  shared max_size := _Constants().max_record_size;

	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
		export SprayedOLD := RECORD
			UNSIGNED	FDICcertificateNumber;										//CERT
			STRING72 	InstitutionName;													//NAME
			UNSIGNED 	OfficeNumber;															//BRNUM
			REAL 			BranchUniqueIDNumber;											//UNINUMBR
			STRING72 	AddressBranch;														//ADDRESSBR
			STRING72 	AddressInstitution;												//ADDRESS
			REAL 			Asset;																		//ASSET
			BOOLEAN		BranchDesignation;												//BKBR
			STRING2 	InstitutionClass;													//BKCLASS
			BOOLEAN 	MainOfficeDesignation; 										//BKMO
			UNSIGNED 	SODRegionBookNumber;											//BOOK
			STRING3 	CENCODES;																	//BRCENM
			BOOLEAN 	BranchDomicileIndicator;									//BRHQRT
			UNSIGNED 	BranchServiceType;												//BRSERTYP
			STRING2		OfficeType;																//BRTYPE
			STRING6 	ReportDateYRMO;														//CALLYM
			STRING8 	ReportDateYRMODY;													//CALLYMD
			UNSIGNED 	InstitutionCoreBaseStatArea; 							//CBSA
			STRING120 BranchMetroDivisionName;									//CBSA_DIV_NAMB
			STRING120 InstitutionMetroDivisionName;							//CBSA_DIV_NAME
			UNSIGNED 	InstitutionMetroStatArea;									//CBSA_METRO
			STRING120 InstitutionMetroStatAreaName; 						//CBSA_METRO_NAME
			STRING120 BranchMetroStatAreaName;									//CBSA_METRO_NAMEB
			UNSIGNED 	BranchMetroStatArea;											//CBSA_METROB
			UNSIGNED 	BranchCoreBasedStatArea;									//CBSABR
			STRING40 	BranchCoreBasedStatAreaName;							//CBSANAMB
			STRING120 InstitutionCoreBasedAreaName;							//CBSANAME
			UNSIGNED 	CENCODEconsolestimatednondep;  						//CENCODE
			STRING28 	CharterAgentName;													//CHRTAGNN
			STRING5		CharterAgentCode;													//CHRTAGNT
			STRING30	InstitutionHQCity;												//CITY
			STRING30 	BranchUSPSCity;														//CITY2BR
			STRING30 	InstitutionHQUSPSCity;										//CITY2M
			STRING30 	BranchReportedCity;												//CITYBR
			STRING25 	BankHoldingCompanyCity;										//CITYHCR
			UNSIGNED 	ClassNumber;															//CLCODE
			UNSIGNED 	FIPSCMSACodeMainOffice;										//CMSA
			UNSIGNED 	FIPSCMSACodeBranch;												//CMSABR
			STRING60 	FIPSCMSANameBranch;											  //CMSANAMB
			STRING60 	FIPSCMSANameMainOffice;										//CMSANAME
			STRING56 	FIPSCountryName;													//CNTRYNA
			STRING56 	FIPSCountryNameBranch;										//CNTRYNAB
			STRING36 	CountyNameBranch;													//CNTYNAMB
			STRING60 	CountyNameInstitution;									  //CNTYNAME
			UNSIGNED 	CountyNumberInstitution;									//CNTYNUM
			UNSIGNED 	CountyNumberBranch;												//CNTYNUMB
			UNSIGNED 	InstitutionCombinedStatisticalArea;				//CSA
			UNSIGNED 	BranchCombinedStatisticalArea;						//CSABR
			STRING120 BranchCombinedStatAreaName;								//CSNAMBR
			STRING120 InstitutionCombinedStatAreaName;					//CSANAME
			BOOLEAN  	NewBrickandMortar;												//DENOVO
			REAL 			TotalDomesticDeposits;										//DEPDOM
			REAL 			TotalDomesticDepforInstituions;						//DEPSUM
			REAL 			BranchDepositsInThousands;								//DEPSUMBR
			BOOLEAN 	InstitutionMetroDivision; 						    //DIVISION                       
			BOOLEAN 	BranchMetroDivision;											//DIVISIONBR
			UNSIGNED 	OTSDocketNumber;													//DOCKET
			REAL 			EscrowAccountTFR;													//ESCROW
			UNSIGNED 	FDICRegionNumber;													//FDICDBS
			STRING13 	FDICRegionName;						 								//FDICNAME
			UNSIGNED 	FRBDistrictNumber;												//FED
			BOOLEAN		FedCharter;																//FEDCHRTR
			STRING13 	FederalReserveDistrictName;								//FEDNAME
			BOOLEAN 	CallReport;																//FORMCFR
			BOOLEAN 	CallReportBranch;													//F0RMCFRB
			BOOLEAN 	TFRReport;																//FORMTFR
			BOOLEAN 	TFRReportBranch;													//FORMTFRB
			BOOLEAN 	MultiBankHoldingCompany;						 			//HCTMULT
			BOOLEAN 	NoBankHoldingCompany;											//HCTNONE
			BOOLEAN 	OneBankHoldingCompany;										//HCTONE
			BOOLEAN 	InternationalBankingActEntity;						//IBA
			STRING5 	PrimaryInsuranceFund;											//INSAGNT1
			BOOLEAN 	InsuredInstitution;												//INSALL
			REAL 			DemandDepInInsuredBranches;								//INSBRDD
			REAL 			TimeandSaveDepositinInsuredBranches;			//INSERTS
			BOOLEAN 	InsuredCommercialBank;										//INSCOML
			BOOLEAN 	InsuredFDIC;															//INSFDIC
			BOOLEAN 	InsuredSavingsInstitution;								//INSSAVE
			BOOLEAN 	InstitutionMetroDivisions;								//METRO
			BOOLEAN 	BranchMetroDivisions;											//METROBR
			BOOLEAN 	InstitutionMicroDivisions;								//MICRO
			BOOLEAN 	BranchMicroDivisions;											//MICROBR
			UNSIGNED 	MSACodeInstitution;												//MSA
			UNSIGNED 	MSACodeBranch;														//MSABR
			STRING60 	MSANameBranch;														//MSANAMEBR
			STRING60 	MSANameInstitution;												//MSANAME
			STRING72 	BranchName;																//NAMEBR
			STRING72 	FullInstitutionName;											//NAMEFULL
			STRING95 	RegulatoryHighHoldNameBHC;								//NAMEHCR
			UNSIGNED 	InstitutionNewEnglandCntyMetroAreas; 			//NECMA
			UNSIGNED 	BranchNewEnglandCntyMetroAreas; 					//NECMABR
			STRING30 	BranchNewEnglandCntyMetroAreasname; 			//NECNAMB
			STRING30 	InstitutionNewEnglandCntyMetroAreasname; 	//NECNAME
			BOOLEAN 	OAKAR;																		//OAKAR
			UNSIGNED 	OCCDistrictNumber;												//OCCDIST
			STRING18 	OCCRegionName;														//OCCNAME
			BOOLEAN 	USBranchofForeignInstitution;							//OI
			STRING25 	OTSRegionName;														//OTSREGNM
			UNSIGNED 	OTSNumber;																//OTSREGNO
			UNSIGNED 	PlaceCodeNumber;													//PLACENUM
			STRING10	QBPRegionName;														//QBPNAME
			UNSIGNED 	QBPRegionNumber; 													//QBPCOML
			STRING10 	DataSourceIdentifier;											//RECTYPE
			STRING5 	PrimaryFederalRegulator;									//REGAGNT
			STRING13 	BranchFDICRegionName;											//REGNAMBR
			UNSIGNED 	BranchFDICRegionNumber;										//REGNUMBR
			STRING20 	ReportDate;																//REPDTE
			UNSIGNED 	FRBIDnumberbandholdingco;									//RSSDHCR
			UNSIGNED	FRBIDnumber;															//RSSDID
			BOOLEAN		SASSER;																		//SASSER
			STRING22 	IndustrySpecializationDescr;							//SPECDESC
			UNSIGNED 	IndustrySpecializationGroup;							//SPECGRP
			STRING2		StateCode;																//STALP
			STRING2 	BranchStateCode;													//STALPBR
			STRING2 	BHCStateCode;															//STALPHCR
			BOOLEAN 	StateCharter;															//STCHRTR
			UNSIGNED 	InstitutionStateandCountyNumber;  				//STCNTY
			UNSIGNED 	BranchStateandCountyNumber;								//STCNTYBR
			STRING40 	InstitutionHQStateName;										//STNAME
			STRING40 	BranchStateName;													//STNAMEBR
			UNSIGNED 	InstitutionStateNumber;										//STNUM
			UNSIGNED 	BranchStateNumber;												//STNUMBR
			BOOLEAN 	Assets100Mto300M;													//SZ100T3
			BOOLEAN 	Assetsover10B;														//SZ10BP
			BOOLEAN 	Assets1Bto3B;															//SZ1BT3B
			BOOLEAN 	Assetsunder25M;														//SZ25
			BOOLEAN 	Assets25Mto50M;														//SZ25T50
			BOOLEAN 	Assets300Mto500M;													//SZ300T5
			BOOLEAN 	Assets3Bto10B;														//SZ3BT10B
			BOOLEAN 	Assets500Mto1B;														//SZ500T1B
			BOOLEAN 	Assets50Mto100M;													//SZ50T100
			UNSIGNED 	AssetSizeIndicatior;											//SZASSET
			BOOLEAN 	UnitBank;																	//UNIT
			BOOLEAN 	DomesticInstitution;											//USA
			STRING5 	InstitutionZIPCode;												//ZIP
			STRING5 	BranchZIPCode;														//ZIPBR
		END;
		
		export sprayed := RECORD
			UNSIGNED	FDICcertificateNumber;										//CERT
			STRING72  InstitutionName;													//NAME
			UNSIGNED  OfficeNumber;															//BRNUM
			REAL 	 		BranchUniqueIDNumber;											//UNINUMBR
			STRING72 	AddressBranch;														//ADDRESSBR
			STRING72 	AddressInstitution;												//ADDRESS
			REAL 			Asset;																		//ASSET
			BOOLEAN		BranchDesignation;												//BKBR
			STRING2 	InstitutionClass;													//BKCLASS
			BOOLEAN 	MainOfficeDesignation;						 				//BKMO
			UNSIGNED 	SODRegionBookNumber;											//BOOK
			STRING3 	CENCODES;																	//BRCENM
			BOOLEAN 	BranchDomicileIndicator;									//BPHQRT
			UNSIGNED 	BranchServiceType;												//BRSERTYP
			STRING2		OfficeType;																//BRTYPE
			STRING6 	ReportDateYRMO;														//CALLYM
			STRING8 	ReportDateYRMODY;													//CALLYMD
			UNSIGNED 	InstitutionCoreBaseStatArea; 							//CBSA
			STRING120 BranchMetroDivisionName;									//CBSA_DIV_NAMB
			STRING120 InstitutionMetroDivisionName;							//CBSA_DIV_NAME
			UNSIGNED 	InstitutionMetroStatArea;									//CBSA_METRO
			STRING120 InstitutionMetroStatAreaName; 						//CBSA_METRO_NAME
			STRING120 BranchMetroStatAreaName;									//CBSA_METRO_NAMEB
			UNSIGNED 	BranchMetroStatArea;											//CBSA_METROB
			UNSIGNED 	BranchCoreBasedStatArea;									//CBSABR
			STRING40 	BranchCoreBasedStatAreaName;							//CBSANAMB
			STRING120 InstitutionCoreBasedAreaName;							//CBSANAME
			UNSIGNED 	CENCODEconsolestimatednondep; 						//CENCODE
			STRING28 	CharterAgentName;													//CHRTAGNN
			STRING5		CharterAgentCode;													//CHRTAGNT
			STRING30	InstitutionHQCity;												//CITY
			STRING30 	BranchUSPSCity;														//CITY2BR
			STRING30 	InstitutionHQUSPSCity;										//CITY2M
			STRING30 	BranchReportedCity;												//CITYBR
			STRING25 	BankHoldingCompanyCity;										//CITYHCR
			UNSIGNED 	ClassNumber;															//CLCODE
			UNSIGNED 	FIPSCMSACodeMainOffice;										//CMSA
			UNSIGNED 	FIPSCMSACodeBranch;												//CMSABR
			STRING60 	FIPSCMSANameBranch;											  //CMSANAMB
			STRING60 	FIPSCMSANameMainOffice;										//CMSANAME
			STRING56 	FIPSCountryName;													//CNTRYNA
			STRING56 	FIPSCountryNameBranch;										//CNTRYNAB
			STRING36 	CountyNameBranch;													//CNTYNAMB
			STRING60 	CountyNameInstitution;									  //CNTYNAME
			UNSIGNED 	CountyNumberInstitution;									//CNTYNUM
			UNSIGNED 	CountyNumberBranch;												//CNTYNUMB
			UNSIGNED 	InstitutionCombinedStatisticalArea;				//CSA
			UNSIGNED 	BranchCombinedStatisticalArea;						//CSABR
			STRING120 BranchCombinedStatAreaName;								//CSNAMBR
			STRING120 InstitutionCombinedStatAreaName;					//CSANAME
			BOOLEAN  	NewBrickandMortar;												//DENOVO
			REAL 			TotalDomesticDeposits;										//DEPDOM
			REAL 			TotalDomesticDepforInstituions;						//DEPSUM
			REAL 			BranchDepositsInThousands;								//DEPSUMBR
			BOOLEAN 	InstitutionMetroDivision;     					  //DIVISION                       
			BOOLEAN 	BranchMetroDivision;											//DIVISIONBR
			UNSIGNED 	OTSDocketNumber;													//DOCKET
			REAL 			EscrowAccountTFR;													//ESCROW
			UNSIGNED 	FDICRegionNumber;													//FDICDBS
			STRING13 	FDICRegionName; 													//FDICNAME
			UNSIGNED 	FRBDistrictNumber;												//FED
			BOOLEAN		FedCharter;																//FEDCHRTR
			STRING13 	FederalReserveDistrictName;								//FEDNAME
			BOOLEAN 	CallReport;																//FORMCFR
			BOOLEAN 	CallReportBranch;													//F0RMCFRB
			BOOLEAN 	TFRReport;																//FORMTFR
			BOOLEAN 	TFRReportBranch;													//FORMTFRB
			BOOLEAN 	MultiBankHoldingCompany; 									//HCTMULT
			BOOLEAN 	NoBankHoldingCompany;											//HCTNONE
			BOOLEAN 	OneBankHoldingCompany;										//HCTONE
			BOOLEAN 	InternationalBankingActEntity;						//IBA
			STRING5 	PrimaryInsuranceFund;											//INSAGNT1
			BOOLEAN 	InsuredInstitution;												//INSALL
			REAL 			DemandDepInInsuredBranches;								//INSBRDD
			REAL 			TimeandSaveDepositinInsuredBranches; 			//INSERTS
			BOOLEAN 	InsuredCommercialBank;										//INSCOML
			BOOLEAN 	InsuredFDIC;															//INSFDIC
			BOOLEAN 	InsuredSavingsInstitution;								//INSSAVE
			BOOLEAN 	InstitutionMetroDivisions; 								//METRO
			BOOLEAN 	BranchMetroDivisions;											//METROBR
			BOOLEAN 	InstitutionMicroDivisions;								//MICRO
			BOOLEAN 	BranchMicroDivisions;											//MICROBR
			UNSIGNED 	MSACodeInstitution;												//MSA
			UNSIGNED 	MSACodeBranch;														//MSABR
			STRING60 	MSANameBranch;														//MSANAMEBR
			STRING60 	MSANameInstitution;												//MSANAME
			STRING72 	BranchName;																//NAMEBR
			STRING72 	FullInstitutionName;											//NAMEFULL
			STRING95 	RegulatoryHighHoldNameBHC;								//NAMEHCR
			UNSIGNED 	InstitutionNewEnglandCntyMetroAreas; 			//NECMA
			UNSIGNED 	BranchNewEnglandCntyMetroAreas;						//NECMABR
			STRING30 	BranchNewEnglandCntyMetroAreasname;  			//NECNAMB
			STRING30 	InstitutionNewEnglandCntyMetroAreasname;  //NECNAME
			BOOLEAN 	OAKAR;																		//OAKAR
			UNSIGNED 	OCCDistrictNumber;												//OCCDIST
			STRING18 	OCCRegionName;														//OCCNAME
			BOOLEAN 	USBranchofForeignInstitution;							//OI
			STRING25 	OTSRegionName;														//OTSREGNM
			UNSIGNED 	OTSNumber;																//OTSREGNO
			UNSIGNED 	PlaceCodeNumber;													//PLACENUM
			STRING10 	QBPRegionName;														//QBPNAME
			UNSIGNED 	QBPRegionNumber; 													//QBPCOML
			STRING10 	DataSourceIdentifier;											//RECTYPE
			STRING5 	PrimaryFederalRegulator;									//REGAGNT
			STRING13 	BranchFDICRegionName;											//REGNAMBR
			UNSIGNED 	BranchFDICRegionNumber;										//REGNUMBR
			STRING20 	ReportDate;																//REPDTE
			UNSIGNED 	FRBIDnumberbandholdingco;									//RSSDHCR
			UNSIGNED 	FRBIDnumber;															//RSSDID
			BOOLEAN 	SASSER;																		//SASSER
			STRING22 	IndustrySpecializationDescr;							//SPECDESC
			UNSIGNED 	IndustrySpecializationGroup;							//SPECGRP
			STRING2		StateCode;																//STALP
			STRING2 	BranchStateCode;													//STALPBR
			STRING2 	BHCStateCode;															//STALPHCR
			BOOLEAN 	StateCharter;															//STCHRTR
			UNSIGNED 	InstitutionStateandCountyNumber;  				//STCNTY
			UNSIGNED 	BranchStateandCountyNumber;								//STCNTYBR
			STRING40 	InstitutionHQStateName;										//STNAME
			STRING40 	BranchStateName;													//STNAMEBR
			UNSIGNED 	InstitutionStateNumber;										//STNUM
			UNSIGNED 	BranchStateNumber;												//STNUMBR
			BOOLEAN 	Assets100Mto300M;													//SZ100T3
			BOOLEAN 	Assetsover10B;														//SZ10BP
			BOOLEAN 	Assets1Bto3B;															//SZ1BT3B
			BOOLEAN 	Assetsunder25M;														//SZ25
			BOOLEAN 	Assets25Mto50M;														//SZ25T50
			BOOLEAN 	Assets300Mto500M;													//SZ300T5
			BOOLEAN 	Assets3Bto10B;														//SZ3BT10B
			BOOLEAN 	Assets500Mto1B;														//SZ500T1B
			BOOLEAN 	Assets50Mto100M;													//SZ50T100
			UNSIGNED 	AssetSizeIndicatior;											//SZASSET
			BOOLEAN 	UnitBank;																	//UNIT
			BOOLEAN 	DomesticInstitution;											//USA
			STRING5 	InstitutionZIPCode;												//ZIP
			STRING5 	BranchZIPCode;														//ZIPBR
		END;
			
		export Fixed := 
		record
			UNSIGNED8	FDICcertificateNumber;										//CERT
			STRING72 	InstitutionName;													//NAME
			UNSIGNED8	OfficeNumber;															//BRNUM
			REAL8		 	BranchUniqueIDNumber;											//UNINUMBR
			STRING72	AddressBranch;														//ADDRESSBR
			STRING72 	AddressInstitution;												//ADDRESS
			REAL8		  Asset;																		//ASSET
			BOOLEAN		BranchDesignation;												//BKBR
			STRING2 	InstitutionClass;													//BKCLASS
			BOOLEAN 	MainOfficeDesignation; 										//BKMO
			UNSIGNED8 SODRegionBookNumber;											//BOOK
			STRING3 	CENCODES;																	//BRCENM
			BOOLEAN 	BranchDomicileIndicator;									//BPHQRT
			UNSIGNED8 BranchServiceType;												//BRSERTYP
			STRING2		OfficeType;																//BRTYPE
			STRING6 	ReportDateYRMO;														//CALLYM
			STRING8 	ReportDateYRMODY;													//CALLYMD
			UNSIGNED8 InstitutionCoreBaseStatArea;		 				  //CBSA
			STRING120 BranchMetroDivisionName;									//CBSA_DIV_NAMB
			STRING120 InstitutionMetroDivisionName;							//CBSA_DIV_NAME
			UNSIGNED8 InstitutionMetroStatArea;									//CBSA_METRO
			STRING120 InstitutionMetroStatAreaName; 						//CBSA_METRO_NAME
			STRING120 BranchMetroStatAreaName;									//CBSA_METRO_NAMEB
			UNSIGNED8 BranchMetroStatArea;											//CBSA_METROB
			UNSIGNED8 BranchCoreBasedStatArea;									//CBSABR
			STRING40 	BranchCoreBasedStatAreaName;							//CBSANAMB
			STRING120 InstitutionCoreBasedAreaName;							//CBSANAME
			UNSIGNED8 CENCODEconsolestimatednondep;						  //CENCODE
			STRING28 	CharterAgentName;													//CHRTAGNN
			STRING5		CharterAgentCode;													//CHRTAGNT
			STRING30	InstitutionHQCity;												//CITY
			STRING30 	BranchUSPSCity;														//CITY2BR
			STRING30 	InstitutionHQUSPSCity;										//CITY2M
			STRING30 	BranchReportedCity;												//CITYBR
			STRING25 	BankHoldingCompanyCity;										//CITYHCR
			UNSIGNED8 ClassNumber;															//CLCODE
			UNSIGNED8 FIPSCMSACodeMainOffice;										//CMSA
			UNSIGNED8 FIPSCMSACodeBranch;												//CMSABR
			STRING60 	FIPSCMSANameBranch;											  //CMSANAMB
			STRING60 	FIPSCMSANameMainOffice;										//CMSANAME
			STRING56 	FIPSCountryName;													//CNTRYNA
			STRING56 	FIPSCountryNameBranch;										//CNTRYNAB
			STRING36 	CountyNameBranch;													//CNTYNAMB
			STRING60 	CountyNameInstitution;									  //CNTYNAME
			UNSIGNED8 CountyNumberInstitution;									//CNTYNUM
			UNSIGNED8 CountyNumberBranch;												//CNTYNUMB
			UNSIGNED8 InstitutionCombinedStatisticalArea;				//CSA
			UNSIGNED8 BranchCombinedStatisticalArea;						//CSABR
			STRING120 BranchCombinedStatAreaName;								//CSNAMBR
			STRING120 InstitutionCombinedStatAreaName;					//CSANAME
			BOOLEAN  	NewBrickandMortar;												//DENOVO
			REAL8 		TotalDomesticDeposits;										//DEPDOM
			REAL8 		TotalDomesticDepforInstituions;						//DEPSUM
			REAL8 		BranchDepositsInThousands;								//DEPSUMBR
			BOOLEAN 	InstitutionMetroDivision; 					      //DIVISION                       
			BOOLEAN 	BranchMetroDivision;											//DIVISIONBR
			UNSIGNED8 OTSDocketNumber;													//DOCKET
			REAL8 		EscrowAccountTFR;													//ESCROW
			UNSIGNED8 FDICRegionNumber;													//FDICDBS
			STRING13 	FDICRegionName; 													//FDICNAME
			UNSIGNED8 FRBDistrictNumber;												//FED
			BOOLEAN		FedCharter;																//FEDCHRTR
			STRING13 	FederalReserveDistrictName;								//FEDNAME
			BOOLEAN 	CallReport;																//FORMCFR
			BOOLEAN 	CallReportBranch;													//F0RMCFRB
			BOOLEAN 	TFRReport;																//FORMTFR
			BOOLEAN 	TFRReportBranch;													//FORMTFRB
			BOOLEAN 	MultiBankHoldingCompany; 									//HCTMULT
			BOOLEAN 	NoBankHoldingCompany;											//HCTNONE
			BOOLEAN 	OneBankHoldingCompany;										//HCTONE
			BOOLEAN 	InternationalBankingActEntity;						//IBA
			STRING5 	PrimaryInsuranceFund;											//INSAGNT1
			BOOLEAN 	InsuredInstitution;												//INSALL
			REAL8 		DemandDepInInsuredBranches;								//INSBRDD
			REAL8 		TimeandSaveDepositinInsuredBranches; 			//INSERTS
			BOOLEAN 	InsuredCommercialBank;										//INSCOML
			BOOLEAN 	InsuredFDIC;															//INSFDIC
			BOOLEAN 	InsuredSavingsInstitution;								//INSSAVE
			BOOLEAN 	InstitutionMetroDivisions; 								//METRO
			BOOLEAN 	BranchMetroDivisions;											//METROBR
			BOOLEAN 	InstitutionMicroDivisions;								//MICRO
			BOOLEAN 	BranchMicroDivisions;											//MICROBR
			UNSIGNED8 MSACodeInstitution;												//MSA
			UNSIGNED8 MSACodeBranch;														//MSABR
			STRING60 	MSANameBranch;														//MSANAMEBR
			STRING60 	MSANameInstitution;												//MSANAME
			STRING72 	BranchName;																//NAMEBR
			STRING72 	FullInstitutionName;											//NAMEFULL
			STRING95 	RegulatoryHighHoldNameBHC;								//NAMEHCR
			UNSIGNED8 InstitutionNewEnglandCntyMetroAreas; 			//NECMA
			UNSIGNED8 BranchNewEnglandCntyMetroAreas; 					//NECMABR
			STRING30 	BranchNewEnglandCntyMetroAreasname;  			//NECNAMB
			STRING30 	InstitutionNewEnglandCntyMetroAreasname;  //NECNAME
			BOOLEAN 	OAKAR;																		//OAKAR
			UNSIGNED8 OCCDistrictNumber;												//OCCDIST
			STRING18 	OCCRegionName;														//OCCNAME
			BOOLEAN 	USBranchofForeignInstitution;							//OI
			STRING25 	OTSRegionName;														//OTSREGNM
			UNSIGNED8 OTSNumber;																//OTSREGNO
			UNSIGNED8 PlaceCodeNumber;													//PLACENUM
			STRING10 	QBPRegionName;														//QBPNAME
			UNSIGNED8 QBPRegionNumber; 													//QBPCOML
			STRING10 	DataSourceIdentifier;											//RECTYPE
			STRING5 	PrimaryFederalRegulator;									//REGAGNT
			STRING13 	BranchFDICRegionName;											//REGNAMBR
			UNSIGNED8 BranchFDICRegionNumber;										//REGNUMBR
			STRING20 	ReportDate;																//REPDTE
			UNSIGNED8 FRBIDnumberbandholdingco;									//RSSDHCR
			UNSIGNED8 FRBIDnumber;															//RSSDID
			BOOLEAN 	SASSER;																		//SASSER
			STRING22 	IndustrySpecializationDescr;							//SPECDESC
			UNSIGNED8 IndustrySpecializationGroup;							//SPECGRP
			STRING2		StateCode;																//STALP
			STRING2 	BranchStateCode;													//STALPBR
			STRING2 	BHCStateCode;															//STALPHCR
			BOOLEAN 	StateCharter;															//STCHRTR
			UNSIGNED8 InstitutionStateandCountyNumber;				  //STCNTY
			UNSIGNED8 BranchStateandCountyNumber;								//STCNTYBR
			STRING40 	InstitutionHQStateName;										//STNAME
			STRING40 	BranchStateName;													//STNAMEBR
			UNSIGNED8 InstitutionStateNumber;										//STNUM
			UNSIGNED8 BranchStateNumber;												//STNUMBR
			BOOLEAN 	Assets100Mto300M;													//SZ100T3
			BOOLEAN 	Assetsover10B;														//SZ10BP
			BOOLEAN 	Assets1Bto3B;															//SZ1BT3B
			BOOLEAN 	Assetsunder25M;														//SZ25
			BOOLEAN 	Assets25Mto50M;														//SZ25T50
			BOOLEAN 	Assets300Mto500M;													//SZ300T5
			BOOLEAN 	Assets3Bto10B;														//SZ3BT10B
			BOOLEAN 	Assets500Mto1B;														//SZ500T1B
			BOOLEAN 	Assets50Mto100M;													//SZ50T100
			UNSIGNED8 AssetSizeIndicatior;											//SZASSET
			BOOLEAN 	UnitBank;																	//UNIT
			BOOLEAN		DomesticInstitution;											//USA
			STRING5 	InstitutionZIPCode;												//ZIP
			STRING5 	BranchZIPCode;														//ZIPBR
		end;
		
	end; //of input module

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base := RECORD
		UNSIGNED6														Did											:= 0; //used by autokey.mac_useFakeIDs 
		UNSIGNED1														Did_score								:= 0; //used by autokey.mac_useFakeIDs

		UNSIGNED6														Bdid										:= 0;
		UNSIGNED1														Bdid_score							:= 0;
				
		BIPV2.IDlayouts.l_xlink_ids; // Added for BIPV2
				
		UNSIGNED8 unique_id;
				
		Input.sprayed												rawfields;
		STRING8 ReportDateNew;
		UNSIGNED Branchuniqueidinteger;																	
		Address.Layout_Clean182_fips	FormattedInstitutionAddr;
		Address.Layout_Clean182_fips	FormattedBranchAddr;
		STRING1	RecordType;
		UNSIGNED4 													dt_vendor_first_reported		;
		UNSIGNED4 													dt_vendor_last_reported			;		
		UNSIGNED8 													Institutionaid 	:= 0;
		UNSIGNED8 													Institutionaceaid 	:= 0;
		UNSIGNED8 													Branchaid 				:= 0;
		UNSIGNED8 													Branchaceaid 				:= 0;				
  END;
		
	
	///////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
  		UNSIGNED6														Did											:= 0; //used by autokey.mac_useFakeIDs 
			UNSIGNED1														Did_score								:= 0; //used by autokey.mac_useFakeIDs
			UNSIGNED6														Bdid										:= 0;
			UNSIGNED1														Bdid_score							:= 0;
			BIPV2.IDlayouts.l_xlink_ids; // Added for BIPV2
			UNSIGNED8 													unique_id;
			Input.fixed													rawfields										;
			STRING8 														ReportDateNew;
			UNSIGNED 														Branchuniqueidinteger;																	
			Address.Layout_Clean182_fips				FormattedInstitutionAddr;
			Address.Layout_Clean182_fips				FormattedBranchAddr;
			STRING1															RecordType;
			UNSIGNED4 													dt_vendor_first_reported		;
			UNSIGNED4 													dt_vendor_last_reported			;		
			UNSIGNED8 													Institutionaid 	:= 0;
			UNSIGNED8 													Institutionaceaid 	:= 0;
			UNSIGNED8 													Branchaid 				:= 0;
			UNSIGNED8 													Branchaceaid 				:= 0;
	end;
			
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

		export StandardizeInput := Base;
				    	
		export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state		 					;
			string25		p_city_name				;
			string10		phone		  		    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids; // Added for BIPV2
	  end;
	
		export aid_prep :=
		record
				string100			InstitutionAddress1		;
				string50			InstitutionAddress2		;
				string100			BranchAddress1				;
				string50			BranchAddress2				;
				Base							;
		end;
							
		export Unique_Id := 
		record
					Base									;
		end;
	End; //of module temporary
end;