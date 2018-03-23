IMPORT	OKC_Probate,	VersionControl, STD;
EXPORT	Proc_OKC_Probate_buildfiles(STRING	pVersion	=	(STRING)STD.Date.Today())	:=	MODULE

	//Build Probate base raw file
	EXPORT	dProbateBase								:=	OKC_Probate.Build_Probate_Base(pVersion);
	//Process build file for death_master
	EXPORT	dProbateDeathMaster	:=	OKC_Probate.map_probate_to_V3(pVersion);

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).base.okcprobate.new			,dProbateBase								,Build_OKCProbateBase_File								,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.deathmasterv3.new	,dProbateDeathMaster	,Build_OKCProbateDeathMaster_File	,TRUE);
	
	EXPORT	full_build	:=
				SEQUENTIAL(
					Promote(pversion).inputfiles.Sprayed2Using
					,Build_OKCProbateBase_File
					,Promote(pversion).Inputfiles.Using2Used
					,Promote(pversion, 'base').buildfiles.New2Built
					,Promote(pversion, 'base').buildfiles.Built2QA	
					,Build_OKCProbateDeathMaster_File
					,Promote(pversion, 'out').buildfiles.New2Built
					,Promote(pversion, 'out').buildfiles.Built2QA
				);

	EXPORT	ALL	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping OKC_Probate.Proc_OKC_Probate_buildfiles().All attribute')
	);
END;