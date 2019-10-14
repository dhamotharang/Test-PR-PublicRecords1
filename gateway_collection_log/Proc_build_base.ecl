IMPORT	VersionControl,	ut, STD;
EXPORT	proc_build_base(STRING	pVersion	,
												Constants.buildType	pBuildType	=	Constants.buildType.Daily)	:=	MODULE

	//May individual gateway files and add it here															
	EXPORT	dGateway_sources			:=	Map_GatewayLog_Targus();

  //Build the base file
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.new,dGateway_sources,GatewayCollection_BuildFile,TRUE);

                                                                                    
	EXPORT	full_build	:=SEQUENTIAL(
                                    IF(NOTHOR( STD.File.GetSuperFileSubCount(Filenames(pVersion).Input.Sprayed)
                                              +STD.File.GetSuperFileSubCount(Filenames(pVersion).Input.Using))>0,
                                      SEQUENTIAL(
                                                 Promote(pversion).inputfiles.Sprayed2Using
                                                ,GatewayCollection_BuildFile
                                                ,Promote(pversion).Inputfiles.Using2Used
                                                ),output('No Sprayed file, skipping GatewayCollection.proc_build_base().All attribute'))
                                    ,Promote(pversion, 'base').buildfiles.New2Built
                                    ,Promote(pversion, 'base').buildfiles.Built2QA	
                                  );
				

	EXPORT	ALL	:= IF(VersionControl.IsValidVersion(pversion)
		                ,full_build
		                ,output('No Valid version parameter passed, skipping GatewayCollection.proc_build_base().All attribute')
	                 );
END;

//Test Build
// Gateway_sources := Map_GatewayLog_Targus();
// Create logical file but don't add to SF
// testbase := output(Gateway_sources,,'~thor_data400::base::wsgateway_collectionreportLogsTestVersion_' + pversion,overwrite,compressed);
// sequential(testbase);