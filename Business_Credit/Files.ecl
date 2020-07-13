IMPORT	tools, ut;
EXPORT Files(	STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE

	EXPORT	FileHeaderSegment_FA :=  DATASET(pFilename, Business_Credit.Layouts.FileHeaderSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier= Constants().FA);
	EXPORT	HeaderSegment_AA :=  DATASET(pFilename, Business_Credit.Layouts.HeaderSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AA);
	EXPORT	AccountBaseSegment_AB :=  DATASET(pFilename, Business_Credit.Layouts.AccountBaseSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AB);
	EXPORT	MasterAccountContractSegment_MA :=  DATASET(pFilename, Business_Credit.Layouts.MasterAccountContractSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MA);
	EXPORT	AddressSegment_AD :=  DATASET(pFilename, Business_Credit.Layouts.AddressSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier= Constants().AD);
	EXPORT	PhoneNumberSegment_PN := DATASET(pFilename, Business_Credit.Layouts.PhoneNumberSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().PN);
	EXPORT	TaxID_SSNSegment_TI := DATASET(pFilename, Business_Credit.Layouts.TaxID_SSNSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().TI);
	EXPORT	IndividualGuarantorOwnerSegment_IS := DATASET(pFilename, Business_Credit.Layouts.IndividualGuarantorOwnerSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().IS);
	EXPORT	BusinessGuarantorOwnerSegment_BS := DATASET(pFilename, Business_Credit.Layouts.BusinessGuarantorOwnerSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().BS);
	EXPORT	BusinessIndustryIdentifierSegment_BI := DATASET(pFilename, Business_Credit.Layouts.BusinessIndustryIdentifierSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().BI); 
	EXPORT	CollateralSegment_CL := DATASET(pFilename, Business_Credit.Layouts.CollateralSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().CL);
	EXPORT	MemberSpecificSegment_MS := DATASET(pFilename, Business_Credit.Layouts.MemberSpecificSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MS);
	EXPORT	AccountModificationHistorySegment_AH := DATASET(pFilename, Business_Credit.Layouts.AccountModificationHistorySegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AH);
	EXPORT	DigitalFootPrintSegment_DF := DATASET(pFilename, Business_Credit.Layouts.DigitalFootPrintSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().DF);
	EXPORT	MerchantProcessingDataSegment_MD := DATASET(pFilename, Business_Credit.Layouts.MerchantProcessingDataSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MD);
	EXPORT	MerchantCardTransaction_CT := DATASET(pFilename, Business_Credit.Layouts.MerchantCardTransaction, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().CT);
	EXPORT	MerchantChargeback_MT := DATASET(pFilename, Business_Credit.Layouts.MerchantChargeback, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MT);
	EXPORT	MerchantRefund_MR := DATASET(pFilename, Business_Credit.Layouts.MerchantRefund, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MR);
	EXPORT	MerchantClassificationCode_MC := DATASET(pFilename, Business_Credit.Layouts.MerchantClassificationCode, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MC);
	EXPORT	MerchantDestinationMedia_DM := DATASET(pFilename, Business_Credit.Layouts.MerchantDestinationMedia, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().DM);
	EXPORT	FileFooterTrailerSegment_FZ := DATASET(pFilename, Business_Credit.Layouts.FileFooterTrailerSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().FZ);
	EXPORT	TrailerSegment_ZZ := DATASET(pFilename, Business_Credit.Layouts.TrailerSegment, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().ZZ);

	EXPORT	FA	:=	FileHeaderSegment_FA;
	EXPORT	AA	:=	HeaderSegment_AA;
	EXPORT	AB	:=	AccountBaseSegment_AB;
	EXPORT	MA	:=	MasterAccountContractSegment_MA;
	EXPORT	AD	:=	AddressSegment_AD;
	EXPORT	PN	:=	PhoneNumberSegment_PN;
	EXPORT	TI	:=	TaxID_SSNSegment_TI;
	EXPORT	IS	:=	IndividualGuarantorOwnerSegment_IS;
	EXPORT	BS	:=	BusinessGuarantorOwnerSegment_BS;
	EXPORT	BI	:=	BusinessIndustryIdentifierSegment_BI; 
	EXPORT	CL	:=	CollateralSegment_CL;
	EXPORT	MS	:=	MemberSpecificSegment_MS;
	EXPORT	AH	:=	AccountModificationHistorySegment_AH;
	EXPORT	DF	:=	DigitalFootPrintSegment_DF;
	EXPORT	MD	:=	MerchantProcessingDataSegment_MD;
	EXPORT	CT	:=	MerchantCardTransaction_CT;
	EXPORT	MT	:=	MerchantChargeback_MT;
	EXPORT	MR	:=	MerchantRefund_MR;
	EXPORT	MC	:=	MerchantClassificationCode_MC;
	EXPORT	DM	:=	MerchantDestinationMedia_DM;
	EXPORT	ZZ	:=	TrailerSegment_ZZ;
	EXPORT	FZ	:=	FileFooterTrailerSegment_FZ;

	EXPORT	FileHeaderSegment_FA_Virtual :=  DATASET(pFilename, Business_Credit.Layouts.FA_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier= Constants().FA);
	EXPORT	HeaderSegment_AA_Virtual :=  DATASET(pFilename, Business_Credit.Layouts.AA_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AA);
	EXPORT	AccountBaseSegment_AB_Virtual :=  DATASET(pFilename, Business_Credit.Layouts.AB_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AB);
	EXPORT	MasterAccountContractSegment_MA_Virtual :=  DATASET(pFilename, Business_Credit.Layouts.MA_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MA);
	EXPORT	AddressSegment_AD_Virtual :=  DATASET(pFilename, Business_Credit.Layouts.AD_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier= Constants().AD);
	EXPORT	PhoneNumberSegment_PN_Virtual := DATASET(pFilename, Business_Credit.Layouts.PN_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().PN);
	EXPORT	TaxID_SSNSegment_TI_Virtual := DATASET(pFilename, Business_Credit.Layouts.TI_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().TI);
	EXPORT	IndividualGuarantorOwnerSegment_IS_Virtual := DATASET(pFilename, Business_Credit.Layouts.IS_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().IS);
	EXPORT	BusinessGuarantorOwnerSegment_BS_Virtual := DATASET(pFilename, Business_Credit.Layouts.BS_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().BS);
	EXPORT	BusinessIndustryIdentifierSegment_BI_Virtual := DATASET(pFilename, Business_Credit.Layouts.BI_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().BI); 
	EXPORT	CollateralSegment_CL_Virtual := DATASET(pFilename, Business_Credit.Layouts.CL_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().CL);
	EXPORT	MemberSpecificSegment_MS_Virtual := DATASET(pFilename, Business_Credit.Layouts.MS_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MS);
	EXPORT	AccountModificationHistorySegment_AH_Virtual := DATASET(pFilename, Business_Credit.Layouts.AH_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().AH);
	EXPORT	DigitalFootPrintSegment_DF_Virtual := DATASET(pFilename, Business_Credit.Layouts.DF_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().DF);
	EXPORT	MerchantProcessingDataSegment_MD_Virtual := DATASET(pFilename, Business_Credit.Layouts.MD_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MD);
	EXPORT	MerchantCardTransaction_CT_Virtual := DATASET(pFilename, Business_Credit.Layouts.CT_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().CT);
	EXPORT	MerchantChargeback_MT_Virtual := DATASET(pFilename, Business_Credit.Layouts.MT_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MT);
	EXPORT	MerchantRefund_MR_Virtual := DATASET(pFilename, Business_Credit.Layouts.MR_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MR);
	EXPORT	MerchantClassificationCode_MC_Virtual := DATASET(pFilename, Business_Credit.Layouts.MC_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().MC);
	EXPORT	MerchantDestinationMedia_DM_Virtual := DATASET(pFilename, Business_Credit.Layouts.DM_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().DM);
	EXPORT	TrailerSegment_ZZ_Virtual := DATASET(pFilename, Business_Credit.Layouts.ZZ_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().ZZ);
	EXPORT	FileFooterTrailerSegment_FZ_Virtual := DATASET(pFilename, Business_Credit.Layouts.FZ_Virtual, CSV(HEADING(0), SEPARATOR(['\t']), QUOTE(''))) (Segment_Identifier = Constants().FZ);

	EXPORT	FA_Virtual	:=	FileHeaderSegment_FA_Virtual;
	EXPORT	AA_Virtual	:=	HeaderSegment_AA_Virtual;
	EXPORT	AB_Virtual	:=	AccountBaseSegment_AB_Virtual;
	EXPORT	MA_Virtual	:=	MasterAccountContractSegment_MA_Virtual;
	EXPORT	AD_Virtual	:=	AddressSegment_AD_Virtual;
	EXPORT	PN_Virtual	:=	PhoneNumberSegment_PN_Virtual;
	EXPORT	TI_Virtual	:=	TaxID_SSNSegment_TI_Virtual;
	EXPORT	IS_Virtual	:=	IndividualGuarantorOwnerSegment_IS_Virtual;
	EXPORT	BS_Virtual	:=	BusinessGuarantorOwnerSegment_BS_Virtual;
	EXPORT	BI_Virtual	:=	BusinessIndustryIdentifierSegment_BI_Virtual; 
	EXPORT	CL_Virtual	:=	CollateralSegment_CL_Virtual;
	EXPORT	MS_Virtual	:=	MemberSpecificSegment_MS_Virtual;
	EXPORT	AH_Virtual	:=	AccountModificationHistorySegment_AH_Virtual;
	EXPORT	DF_Virtual	:=	DigitalFootPrintSegment_DF_Virtual;
	EXPORT	MD_Virtual	:=	MerchantProcessingDataSegment_MD_Virtual;
	EXPORT	CT_Virtual	:=	MerchantCardTransaction_CT_Virtual;
	EXPORT	MT_Virtual	:=	MerchantChargeback_MT_Virtual;
	EXPORT	MR_Virtual	:=	MerchantRefund_MR_Virtual;
	EXPORT	MC_Virtual	:=	MerchantClassificationCode_MC_Virtual;
	EXPORT	DM_Virtual	:=	MerchantDestinationMedia_DM_Virtual;
	EXPORT	ZZ_Virtual	:=	TrailerSegment_ZZ_Virtual;
	EXPORT	FZ_Virtual	:=	FileFooterTrailerSegment_FZ_Virtual;

	EXPORT	Quarantined_SBFE_Contributor_Number_Set	:=	[
		'0047050111WBS0106'
		,'0018050111DFS0106'	//	DF-17472
	];

	EXPORT	Denormalized			:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Base.Denormalized.QA,pFilename)
																,Business_Credit.Layouts.AccountDataLayout,THOR,__compressed__)
																(portfolioHeader.SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	Active						:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.Active.QA,pFilename)
																,Business_Credit.Layouts.AccountDataLayout,THOR,__compressed__)
																(portfolioHeader.SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	LinkIDs						:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.LinkIDs.QA,pFilename)
																,Business_Credit.Layouts.SBFEAccountLayout,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	BIClassification	:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.BIClassification.QA,pFilename)
																,Business_Credit.Layouts.rBIClassification,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	businessOwner			:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.businessOwner.QA,pFilename)
																,Business_Credit.Layouts.rBusinessOwner,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	collateral				:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.collateral.QA,pFilename)
																,Business_Credit.Layouts.rCollateral,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	history						:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.history.QA,pFilename)
																,Business_Credit.Layouts.rHistory,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	individualOwner		:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.individualOwner.QA,pFilename)
																,Business_Credit.Layouts.rIndividualOwner,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	masterAccount			:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.masterAccount.QA,pFilename)
																,Business_Credit.Layouts.rMasterAccount,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	memberSpecific		:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.memberSpecific.QA,pFilename)
																,Business_Credit.Layouts.rMemberSpecific,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	digitalfootprint	:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.digitalfootprint.QA,pFilename)
																,Business_Credit.Layouts.rDigitalFootprint,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	merchantprocessing	:=	DATASET(
																IF(pFilename='',Filenames(,pUseProd).Out.merchantprocessing.QA,pFilename)
																,Business_Credit.Layouts.rMerchantProcessing,THOR,__compressed__)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);	
	EXPORT	SBFEIDCache				:=	IF(pFilename<>'',
																	DATASET(pFilename,Business_Credit.Layouts.rSBFEIDCache,THOR,__compressed__),
																	IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames().SBFEIDCache) <> 0),
																		DATASET(Filenames().SBFEIDCache,Business_Credit.Layouts.rSBFEIDCache,THOR,__compressed__),
																		DATASET([],Business_Credit.Layouts.rSBFEIDCache)
																	)
																)
																(SBFE_Contributor_Number NOT IN Quarantined_SBFE_Contributor_Number_Set);
	EXPORT	SBFEAddressCache	:=	IF(pFilename<>'',
																	DATASET(pFilename,Business_Credit.Layouts.rCleanAddrCache,THOR,__compressed__),
																	IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames().AddressCache) <> 0),
																		DATASET(Filenames().AddressCache,Business_Credit.Layouts.rCleanAddrCache,THOR,__compressed__),
																		DATASET([],Business_Credit.Layouts.rCleanAddrCache)
																	)
																);
	EXPORT	releaseDate				:=	IF(pFilename<>'',
																	DATASET(pFilename,Business_Credit.Layouts.rReleaseDate,THOR,__compressed__),
																	IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(,pUseProd).out.ReleaseDate.QA) <> 0),
																		DATASET(Filenames(,pUseProd).out.ReleaseDate.QA,Business_Credit.Layouts.rReleaseDate,THOR,__compressed__),
																		DATASET([],Business_Credit.Layouts.rReleaseDate)
																	)
																);
	EXPORT	mapSBFEContributorNumber	:=	DATASET([
																								// Old								New
																					{'0109050115STL0108','0109050114STL0108'},
																					{'0031060111TOE0108','0031060114TOE0108'},
																					{'0019040111PNC0104','0019040111SBL0104'},
																					{'0097070115ODS0111','0097070141ODS0111'},
																					{'0011010111STB0104','0011010111AFS0104'},
																					{'0040070115NCL0109','0040070114NCL0109'},
																					{'0045090115PLC0111','0045090114PLC0111'},
																					{'0092060115SBS0108','0092060141SBS0108'},
																					{'0144140111ZAZ0114','0144140141CSH0114'},
																					{'0115120115HLE0113','0115120114HLE0113'},
																					{'0065050115FBL0105','0065050141FBL0105'},
																					{'0115120115HRE0113','0115120114HRE0113'},
																					{'0115120115KRE0113','0115120114KRE0113'},
																					{'0108050115SLL0113','0108050114SLL0113'},
																					{'0069030111BCU0106','0069030112BCU0106'},
																					{'0115120115KLE0113','0115120114KLE0113'},
																					{'0136130115LCW0114','0136130141LCW0114'},
																					{'0073080111MBL0108','0073080112MBL0108'},
																					{'0082100113FCB0111','0082100112FCB0111'},
																					{'0132110115NWA0114','0132110141NWA0114'},
																					{'0098040113ACU0109','0098040112ACU0109'},
																					{'0110050115DLP0113','0110050115SLI0113'},
																					{'0130130115FBS0114','0130130141FBS0114'},
																					{'0153140114GBC0114','0153140141GBC0114'},
																					{'0119050111TDB0104','0119050111RRV0104'},
																					{'0061080111OFF0109','0061080115OFF0109'},
																					{'0040070115NLP0110','0040070114NLP0110'},
																					{'0064070111EVB0108','0064070111COM0108'},
																					{'0111130115FTL0113','0111130141FTL0113'},
																					{'0149140114FCP0114','0149140141FCP0114'},
																					{'0104080111UVS0110','0104080112UVS0110'},
																					{'0031060111COM0106','0031060114COM0106'},
																					{'0010010111ALS0102','0010010111AFS0102'},	//	Bug: 196005 
																					{'0009010115REF0101','0009150115REF0101'},	//	DF-17138
																					{'001904011101PNC04','0019040111SBL0104'}	//	DF-17902
																				],Business_Credit.Layouts.rMapSBFEContributorNumber);
END;