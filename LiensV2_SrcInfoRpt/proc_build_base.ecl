IMPORT	LiensV2_SrcInfoRpt,	VersionControl,	ut,	STD;
EXPORT	proc_build_base(STRING	pVersion	=	(STRING)STD.Date.Today())	:=	MODULE

	EXPORT	dSuppressedJurisdictions	:=	LiensV2_SrcInfoRpt.fn_SuppressedJurisdictions(Filenames().Input.srcinforpt.Using);

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.SuppressedJurisdictions.new	,dSuppressedJurisdictions	,Build_SuppressedJurisdictions_File	,TRUE);
	                                                                                      
	EXPORT	full_build	:=
				SEQUENTIAL(
					Promote(pversion).inputfiles.Sprayed2Using
					,Build_SuppressedJurisdictions_File
					,Promote(pversion).Inputfiles.Using2Used
					,Promote(pversion, 'base').buildfiles.New2Built
					,Promote(pversion, 'base').buildfiles.Built2QA	
				);

	EXPORT	ALL	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping LiensV2_SrcInfoRpt.proc_build_base().All attribute')
	);
END;