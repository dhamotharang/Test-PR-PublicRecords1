IMPORT	Business_Credit;
EXPORT	fn_SlimSBFEFile(DATASET(RECORDOF(Business_Credit.Layouts.AccountDataLayout_Virtual)) pInput) := FUNCTION
	
	Layouts.AccountDataLayout	tAccountDataLayout(Layouts.AccountDataLayout_Virtual	pAccountData)	:=	TRANSFORM
		Layouts.MA	tMasterAccount(Layouts.MA_Virtual	pMA)	:=	TRANSFORM
			SELF	:=	pMA;
		END;
		Layouts.AD	tAddress(Layouts.AD_Virtual	pAD)	:=	TRANSFORM
			SELF	:=	pAD;
		END;
		Layouts.AH	tHistory(Layouts.AH_Virtual	pAH)	:=	TRANSFORM
			SELF	:=	pAH;
		END;
		Layouts.PN	tPhone(Layouts.PN_Virtual	pPN)	:=	TRANSFORM
			SELF	:=	pPN;
		END;
		Layouts.TI	tTaxID(Layouts.TI_Virtual	pTI)	:=	TRANSFORM
			SELF	:=	pTI;
		END;
		Layouts.BI	tBusinessIndustryClassification(Layouts.BI_Virtual	pBI)	:=	TRANSFORM
			SELF	:=	pBI;
		END;
		Layouts.CL	tCollateral(Layouts.CL_Virtual	pCL)	:=	TRANSFORM
			SELF	:=	pCL;
		END;
		Layouts.MS	tMemberSpecific(Layouts.MS_Virtual	pMS)	:=	TRANSFORM
			SELF	:=	pMS;
		END;
		Layouts.AA	tPortfolioHeader(Layouts.AA_Virtual	pAA)	:=	TRANSFORM
			SELF	:=	pAA;
		END;
		Layouts.FA	tFileHeader(Layouts.FA_Virtual	pFA)	:=	TRANSFORM
			SELF	:=	pFA;
		END;
		Layouts.IndividualOwnerLayout	tIndividualOwner(Layouts.IndividualOwnerLayout_Virtual	pIndividualOwner)	:=	TRANSFORM
			SELF.address				:=	PROJECT(pIndividualOwner.address,tAddress(LEFT));
			SELF.phone					:=	PROJECT(pIndividualOwner.phone,tPhone(LEFT));
			SELF.taxID					:=	PROJECT(pIndividualOwner.taxID,tTaxID(LEFT));
			SELF.memberSpecific	:=	PROJECT(pIndividualOwner.memberSpecific,tMemberSpecific(LEFT));
			SELF								:=	pIndividualOwner;
		END;
		Layouts.BusinessOwnerLayout	tBusinessOwner(Layouts.BusinessOwnerLayout_Virtual	BusinessOwner)	:=	TRANSFORM
			SELF.address												:=	PROJECT(BusinessOwner.address,tAddress(LEFT));
			SELF.phone													:=	PROJECT(BusinessOwner.phone,tPhone(LEFT));
			SELF.businessIndustryClassification	:=	PROJECT(BusinessOwner.businessIndustryClassification,tBusinessIndustryClassification(LEFT));
			SELF.taxID													:=	PROJECT(BusinessOwner.taxID,tTaxID(LEFT));
			SELF.memberSpecific									:=	PROJECT(BusinessOwner.memberSpecific,tMemberSpecific(LEFT));
			SELF																:=	BusinessOwner;
		END;
		
		SELF.masterAccount									:=	PROJECT(pAccountData.masterAccount,tMasterAccount(LEFT));
		SELF.address												:=	PROJECT(pAccountData.address,tAddress(LEFT));
		SELF.history												:=	PROJECT(pAccountData.history,tHistory(LEFT));
		SELF.phone													:=	PROJECT(pAccountData.phone,tPhone(LEFT));
		SELF.taxID													:=	PROJECT(pAccountData.taxID,tTaxID(LEFT));
		SELF.individualOwner								:=	PROJECT(pAccountData.individualOwner,tIndividualOwner(LEFT));
		SELF.businessOwner									:=	PROJECT(pAccountData.businessOwner,tBusinessOwner(LEFT));
		SELF.businessIndustryClassification	:=	PROJECT(pAccountData.businessIndustryClassification,tBusinessIndustryClassification(LEFT));
		SELF.collateral											:=	PROJECT(pAccountData.collateral,tCollateral(LEFT));
		SELF.memberSpecific									:=	PROJECT(pAccountData.memberSpecific,tMemberSpecific(LEFT));
		SELF.portfolioHeader								:=	PROJECT(pAccountData.portfolioHeader,tPortfolioHeader(LEFT));
		SELF.fileHeader											:=	PROJECT(pAccountData.fileHeader,tFileHeader(LEFT));
		SELF																:=	pAccountData;
	END;

	dAccountDataLayout	:=	PROJECT(pInput,tAccountDataLayout(LEFT));

	RETURN dAccountDataLayout;
END;
