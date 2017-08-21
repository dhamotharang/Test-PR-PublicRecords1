//***************************************************************************************
// If the SBFE ID Cache File ever gets deleted you can run this code to recreate the file
//***************************************************************************************

dDenorm	:=	SORT(DISTRIBUTE(Business_Credit.Files().Denormalized,
							HASH(	portfolioHeader.Sbfe_Contributor_Number,Original_Contract_Account_Number)),
										portfolioHeader.Sbfe_Contributor_Number,Original_Contract_Account_Number,portfolioHeader.cycle_end_date,LOCAL);

Business_Credit.Layouts.rSBFEIDCache	tContributorCustomer(dDenorm	pInput)	:=	TRANSFORM
	SELF.Sbfe_Contributor_Number					:=	TRIM(pInput.portfolioHeader.Sbfe_Contributor_Number,LEFT,RIGHT);
	SELF.Original_Contract_Account_Number	:=	TRIM(pInput.Original_Contract_Account_Number,LEFT,RIGHT);
	SELF.sbfe_id													:=	pInput.sbfe_id;
END;

dSBFEID				:=	PROJECT(dDenorm,tContributorCustomer(LEFT));
dSBFEIDDedup	:=	DEDUP(SORT(DISTRIBUTE(dSBFEID(sbfe_id>0),
										HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
													Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
													Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL);

basefilename		:=	Business_Credit.Filenames().SBFEIDCache;
logicalfilename	:=	basefilename+'::'+workunit;

SEQUENTIAL(
	OUTPUT(dSBFEIDDedup,,logicalfilename,OVERWRITE,__compressed__),
	FileServices.StartSuperFileTransaction(),
	FileServices.ClearSuperFile(basefilename),
	FileServices.AddSuperFile(basefilename,logicalfilename),
	FileServices.FinishSuperFileTransaction()
);

