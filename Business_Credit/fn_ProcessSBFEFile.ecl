IMPORT	Business_Credit;
/***********************************/
/* Create the Denormalized Sets    */
/***********************************/
EXPORT	fn_ProcessSBFEFile(STRING	filename, STRING	filedate)	:=	FUNCTION
	// FILL IS with AD, PN, TI and MS segments
	Business_Credit.Layouts.IndividualOwnerLayout_Virtual	tDeNormISwithAD(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.AD_Virtual)	rChild)	:= TRANSFORM
		SELF.address	:=	lParent.address+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.IndividualOwnerLayout_Virtual	tDeNormISwithPN(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.PN_Virtual)	rChild)	:= TRANSFORM
		SELF.phone		:=	lParent.phone+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.IndividualOwnerLayout_Virtual	tDeNormISwithTI(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.TI_Virtual)	rChild)	:= TRANSFORM
		SELF.taxID		:=	lParent.taxID+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.IndividualOwnerLayout_Virtual	tDeNormISwithMS(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MS_Virtual)	rChild)	:= TRANSFORM
		SELF.memberSpecific	:=	lParent.memberSpecific+rChild;
		SELF								:=	lParent;
	END;	
	Business_Credit.Layouts.IndividualOwnerLayout_Virtual	tDeNormISwithDF(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.DF_Virtual)	rChild)	:= TRANSFORM
		SELF.DigitalFootprint	:=	lParent.digitalfootprint+rChild;
		SELF								:=	lParent;
	END;
	// FILL BS with AD, PN, BI, TI and MS segments
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithAD(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.AD_Virtual)	rChild)	:= TRANSFORM
		SELF.address	:=	lParent.address+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithPN(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.PN_Virtual)	rChild)	:= TRANSFORM
		SELF.phone		:=	lParent.phone+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithBI(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.BI_Virtual)	rChild)	:= TRANSFORM
		SELF.businessIndustryClassification	:=	lParent.businessIndustryClassification+rChild;
		SELF																:=	lParent;
	END;
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithTI(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.TI_Virtual)	rChild)	:= TRANSFORM
		SELF.taxID	:=	lParent.taxID+rChild;
		SELF				:=	lParent;
	END;
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithMS(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MS_Virtual)	rChild)	:= TRANSFORM
		SELF.memberSpecific	:=	lParent.memberSpecific+rChild;
		SELF								:=	lParent;
	END;	
	Business_Credit.Layouts.BusinessOwnerLayout_Virtual	tDeNormBSwithDF(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.DF_Virtual)	rChild)	:= TRANSFORM
		SELF.DigitalFootprint	:=	lParent.digitalfootprint+rChild;
		SELF								:=	lParent;
	END;
	// Fill MD with CT, MT, MR, MC, and DM
	Business_Credit.Layouts.MemberProcessingDataLayout_Virtual	tDeNormMDwithCT(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.CT_Virtual)	rChild)	:= TRANSFORM
		SELF.MerchantCTSegment	:=	lParent.MerchantCTSegment+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.MemberProcessingDataLayout_Virtual	tDeNormMDwithMT(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MT_Virtual)	rChild)	:= TRANSFORM
		SELF.MerchantChargebackSegment	:=	lParent.MerchantChargebackSegment+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.MemberProcessingDataLayout_Virtual	tDeNormMDwithMR(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MR_Virtual)	rChild)	:= TRANSFORM
		SELF.MerchantRefundSegment	:=	lParent.MerchantRefundSegment+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.MemberProcessingDataLayout_Virtual	tDeNormMDwithMC(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MC_Virtual)	rChild)	:= TRANSFORM
		SELF.MemberMCSegment	:=	lParent.MemberMCSegment+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.MemberProcessingDataLayout_Virtual	tDeNormMDwithDM(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.DM_Virtual)	rChild)	:= TRANSFORM
		SELF.MemberDMSegment	:=	lParent.MemberDMSegment+rChild;
		SELF								:=	lParent;
	END;
	// FILL AB with MA, AD, AH, PN, TI, IS, BS, BI, CL and MS segments
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithMA(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																							RECORDOF(Business_Credit.Layouts.MA_Virtual)	rChild)	:= TRANSFORM
		SELF.masterAccount	:=	lParent.masterAccount+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithAD(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.AD_Virtual)	rChild)	:= TRANSFORM
		SELF.address	:=	lParent.address+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithAH(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.AH_Virtual)	rChild)	:= TRANSFORM
		SELF.history	:=	lParent.history+rChild;
		SELF					:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithPN(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.PN_Virtual)	rChild)	:= TRANSFORM
		SELF.phone	:=	lParent.phone+rChild;
		SELF				:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithTI(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.TI_Virtual)	rChild)	:= TRANSFORM
		SELF.taxID	:=	lParent.taxID+rChild;
		SELF				:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithIS(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual)	rChild)	:= TRANSFORM
		SELF.individualOwner	:=	lParent.individualOwner+rChild;
		SELF									:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithBS(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual)	rChild)	:= TRANSFORM
		SELF.businessOwner	:=	lParent.businessOwner+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithBI(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)						lParent, 
																									RECORDOF(Business_Credit.Layouts.BI_Virtual)	rChild)	:= TRANSFORM
		SELF.businessIndustryClassification	:=	lParent.businessIndustryClassification+rChild;
		SELF																:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithCL(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)						lParent, 
																									RECORDOF(Business_Credit.Layouts.CL_Virtual)	rChild)	:= TRANSFORM
		SELF.collateral	:=	lParent.collateral+rChild;
		SELF						:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithMS(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MS_Virtual)	rChild)	:= TRANSFORM
		SELF.memberSpecific	:=	lParent.memberSpecific+rChild;
		SELF								:=	lParent;
	END;	
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithDF(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.DF_Virtual)	rChild)	:= TRANSFORM
		SELF.DigitalFootprint	:=	lParent.digitalfootprint+rChild;
		SELF								:=	lParent;
	END;
	Business_Credit.Layouts.AccountDataLayout_Virtual	tDeNormABwithMD(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)	lParent, 
																									RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual)	rChild)	:= TRANSFORM
		SELF.MerchantProcessingData	:=	lParent.MerchantProcessingData+rChild;
		SELF								:=	lParent;
	END;
	/******************/
	/* Build our file */
	/******************/

	// FILL IS with AD, PN, TI and MS segments
	get_IS					:=	PROJECT(Files(filename).IS_Virtual,TRANSFORM(RECORDOF(Business_Credit.Layouts.IndividualOwnerLayout_Virtual),SELF:=LEFT,SELF:=[]));
	fill_IS_with_AD	:=	DENORMALIZE(
												SORT(DISTRIBUTE(get_IS,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).AddressSegment_AD_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormISwithAD(LEFT,RIGHT),
												LOCAL
											);
	fill_IS_with_PN	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_IS_with_AD,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).PhoneNumberSegment_PN_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormISwithPN(LEFT,RIGHT),
												LOCAL
											);
	fill_IS_with_TI	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_IS_with_PN,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).TaxID_SSNSegment_TI_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormISwithTI(LEFT,RIGHT),
												LOCAL
											);
	fill_IS_with_MS				:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_IS_with_TI,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MemberSpecificSegment_MS_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormISwithMS(LEFT,RIGHT),
												LOCAL
											);
	parent_IS				:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_IS_with_MS,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).DigitalFootPrintSegment_DF_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormISwithDF(LEFT,RIGHT),
												LOCAL
											);
											

	// FILL BS with AD, PN, BI, TI, MS, and DF segments
	get_BS					:=	PROJECT(Files(filename).BS_Virtual,TRANSFORM(RECORDOF(Business_Credit.Layouts.BusinessOwnerLayout_Virtual),SELF:=LEFT,SELF:=[]));
	fill_BS_with_AD	:=	DENORMALIZE(
												SORT(DISTRIBUTE(get_BS,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).AddressSegment_AD_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithAD(LEFT,RIGHT),
												LOCAL
											);
	fill_BS_with_PN	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_BS_with_AD,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).PhoneNumberSegment_PN_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithPN(LEFT,RIGHT),
												LOCAL
											);
	fill_BS_with_BI	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_BS_with_PN,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).BusinessIndustryIdentifierSegment_BI_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithBI(LEFT,RIGHT),
												LOCAL
											);
	fill_BS_with_TI	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_BS_with_BI,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).TaxID_SSNSegment_TI_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithTI(LEFT,RIGHT),
												LOCAL
											);
	
	fill_BS_with_MS				:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_BS_with_TI,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MemberSpecificSegment_MS_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithMS(LEFT,RIGHT),
												LOCAL
											);
	parent_BS				:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_BS_with_MS,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).DigitalFootPrintSegment_DF_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormBSwithDF(LEFT,RIGHT),
												LOCAL
											);	
// Fill MD with CT, MT, MR, MC, and DM
	get_MD					:=	PROJECT(Files(filename).MD_Virtual,TRANSFORM(RECORDOF(Business_Credit.Layouts.MemberProcessingDataLayout_Virtual),SELF:=LEFT,SELF:=[]));
	fill_MD_with_CT	:=	DENORMALIZE(
												SORT(DISTRIBUTE(get_MD,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MerchantCardTransaction_CT_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormMDwithCT(LEFT,RIGHT),
												LOCAL
											);
	fill_MD_with_MT	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_MD_with_CT,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MerchantChargeback_MT_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormMDwithMT(LEFT,RIGHT),
												LOCAL
											);
	fill_MD_with_MR	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_MD_with_MT,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MerchantRefund_MR_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormMDwithMR(LEFT,RIGHT),
												LOCAL
											);
	fill_MD_with_MC	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_MD_with_MR,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MerchantClassificationCode_MC_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormMDwithMC(LEFT,RIGHT),
												LOCAL
											);
	parent_MD	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_MD_with_MC,HASH((UNSIGNED)file_sequence_number,__filename)),(UNSIGNED)file_sequence_number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MerchantDestinationMedia_DM_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.file_sequence_number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormMDwithDM(LEFT,RIGHT),
												LOCAL
											);	
	// FILL AB with MA, AD, AH, PN, TI, IS, BS, BI, CL and MS segments
	// DF-17760	SBFE Account Number Leading Zeros and Creation of "Original Account Number"
	get_AB					:=	PROJECT(Files(filename).AB_Virtual,
												TRANSFORM(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual),
													SELF.Original_Contract_Account_Number	:=	LEFT.Contract_Account_Number;
													SELF.Contract_Account_Number					:=	fn_removeLeadingZeros(LEFT.Contract_Account_Number);
													SELF:=LEFT,
													SELF:=[]
												)
											);
	fill_AB_with_MA	:=	DENORMALIZE(
												SORT(DISTRIBUTE(get_AB,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MA_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithMA(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_AD	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_MA,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).AD_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithAD(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_AH	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_AD,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).AH_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithAH(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_PN	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_AH,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).PN_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithPN(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_TI	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_PN,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).TI_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithTI(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_IS	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_TI,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(parent_IS,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithIS(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_BS	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_IS,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(parent_BS,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithBS(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_BI	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_BS,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).BI_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithBI(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_CL	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_BI,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).CL_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithCL(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_MS	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_CL,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).MS_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithMS(LEFT,RIGHT),
												LOCAL
											);
	fill_AB_with_DF	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_MS,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(Files(filename).DF_Virtual,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithDF(LEFT,RIGHT),
												LOCAL
											);	
	parent_AB	:=	DENORMALIZE(
												SORT(DISTRIBUTE(fill_AB_with_DF,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL), 
												SORT(DISTRIBUTE(parent_MD,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,(UNSIGNED)file_sequence_number,LOCAL), 
													(UNSIGNED)LEFT.File_Sequence_Number	=	(UNSIGNED)RIGHT.Parent_Sequence_Number	AND
																		LEFT.__filename						=						RIGHT.__filename,
												tDeNormABwithMD(LEFT,RIGHT),
												LOCAL
											);	
	
	// FILL AB with FA and AA Segments
	Base_AB					:=	JOIN(
												SORT(DISTRIBUTE(parent_AB,HASH((UNSIGNED)Parent_Sequence_Number,__filename)),(UNSIGNED)Parent_Sequence_Number,__filename,LOCAL),
												SORT(DISTRIBUTE(Files(filename).AA_Virtual,HASH((UNSIGNED)File_Sequence_Number,__filename)),(UNSIGNED)File_Sequence_Number,__filename,LOCAL),
													(UNSIGNED)LEFT.Parent_Sequence_Number	=	(UNSIGNED)RIGHT.File_Sequence_Number	AND
																		LEFT.__filename							=						RIGHT.__filename,
													TRANSFORM(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual),
														SELF.portfolioHeader	:=	RIGHT;
														SELF.fileHeader				:=	Files(filename).FA_Virtual(__filename=LEFT.__filename)[1];
														SELF.process_date			:=	filedate;
														SELF.active						:=	TRUE;
														SELF									:=	LEFT;
														SELF									:=	[];
													),
												SMART,
												LOCAL
											);
	dSlimSBFEFile	:=	Business_Credit.fn_SlimSBFEFile(Base_AB);//:PERSIST(PersistNames.fnProcessSBFEFile);
	dCleanRawData	:=	Business_Credit.fn_cleanRawData(dSlimSBFEFile);
	dFillSBFEID		:=	Business_Credit.fn_GetSBFEID(dCleanRawData);
	RETURN	dFillSBFEID;
END;
