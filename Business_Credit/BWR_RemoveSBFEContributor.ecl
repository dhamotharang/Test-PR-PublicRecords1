#OPTION('multiplePersistInstances',FALSE);
IMPORT	STD,	VersionControl, tools;

//	Use this WU to remove Contributors from SBFE.  
// 1. Copy this code to a builder window
// 2. Update SBFE_Contributor_Number_Set with the SBFE_Contributor_Number(s) to remove.
// 3. Run
SBFE_Contributor_Number_Set	:=	[
	'0047050111WBS0106',
	'0142140114SCG0114',
	'0136130111LCW0114',
	'0003010111FIA0102'
];

fn_RemoveSBFEContributor()	:=	FUNCTION

	dDenorm				:=	Business_Credit.Files().Denormalized;
	dActive				:=	Business_Credit.Files().Active;
	dLinkIds			:=	Business_Credit.Files().LinkIDs;
	dSBFEIDCache	:=	Business_Credit.Files().SBFEIDCache;

	dDenormFiltered			:=	dDenorm(portfolioHeader.Sbfe_Contributor_Number NOT IN SBFE_Contributor_Number_Set);
	dActiveFiltered			:=	dActive(portfolioHeader.Sbfe_Contributor_Number NOT IN SBFE_Contributor_Number_Set);
	dLinkIdsFiltered		:=	dLinkIds(Sbfe_Contributor_Number NOT IN SBFE_Contributor_Number_Set);
	dSBFEIDFiltered			:=	dSBFEIDCache(Sbfe_Contributor_Number NOT IN SBFE_Contributor_Number_Set);

	newDenormVersion		:=	(STRING)VersionControl.fGetFilenameVersion(Business_Credit.Filenames().Base.denormalized.QA)+'_Filtered';
	newDenormFilename		:=	Business_Credit.Filenames(newDenormVersion).Base.denormalized.new;
	newActiveVersion		:=	(STRING)VersionControl.fGetFilenameVersion(Business_Credit.Filenames().out.active.QA)+'_Filtered';
	newActiveFilename		:=	Business_Credit.Filenames(newActiveVersion).out.active.new;
	newLinkIdsVersion		:=	(STRING)VersionControl.fGetFilenameVersion(Business_Credit.Filenames().out.linkids.QA)+'_Filtered';
	newLinkIdsFilename	:=	Business_Credit.Filenames(newLinkIdsVersion).out.linkids.new;
	newSBFEIDFilename		:=	Business_Credit.Filenames().SBFEIDCache+'::'+workunit+'_Filtered';

	VersionControl.macBuildNewLogicalFile(newDenormFilename		,dDenormFiltered	,Build_Denormalized_File	,TRUE);
	VersionControl.macBuildNewLogicalFile(newActiveFilename		,dActiveFiltered	,Build_Active_File				,TRUE);
	VersionControl.macBuildNewLogicalFile(newLinkIdsFilename	,dLinkIdsFiltered	,Build_LinkIDs_File				,TRUE);
	VersionControl.macBuildNewLogicalFile(newSBFEIDFilename		,dSBFEIDFiltered	,Build_SBFEID_File				,TRUE);

	RETURN	SEQUENTIAL(
						Build_Denormalized_File
						,Business_Credit.Promote(newDenormVersion, 'base').buildfiles.New2Built
						,Business_Credit.Promote(newDenormVersion, 'base').buildfiles.Built2QA
						,Build_Active_File
						,Business_Credit.Promote(newActiveVersion, 'active').buildfiles.New2Built
						,Business_Credit.Promote(newActiveVersion, 'active').buildfiles.Built2QA
						,Build_LinkIDs_File
						,Business_Credit.Promote(newLinkIdsVersion, 'linkids').buildfiles.New2Built
						,Business_Credit.Promote(newLinkIdsVersion, 'linkids').buildfiles.Built2QA
						,Build_SBFEID_File
						,FileServices.StartSuperFileTransaction()
						,FileServices.ClearSuperFile(Business_Credit.Filenames().SBFEIDCache,TRUE)
						,FileServices.AddSuperFile(Business_Credit.Filenames().SBFEIDCache,newSBFEIDFilename)
						,FileServices.FinishSuperFileTransaction()
					);
END;

fn_RemoveSBFEContributor();