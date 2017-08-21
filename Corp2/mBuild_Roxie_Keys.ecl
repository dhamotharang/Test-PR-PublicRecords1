import doxie, VersionControl, corp2_services;

export mBuild_Roxie_Keys(const string pversion) :=
module
	
	export Corp :=
	module

		VersionControl.macBuildNewLogicalKey(Keys(pversion).Corp.Bdid.New			,BuildBdidKey				);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Corp.BdidPl.New		,BuildBdidPlKey			);	
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Corp.CorpKey.New	,BuildCorpKey				);	
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Corp.NameAddr.New	,BuildNameAddrKey		);	
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Corp.StCharter.New,BuildStCharterKey	);                                                                                                                                            
		
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildBdidPlKey
			,BuildCorpKey
			,BuildNameAddrKey
			,BuildStCharterKey
		);
			
	end;

	export Cont :=
	module

		VersionControl.macBuildNewLogicalKey(Keys(pversion).Cont.Bdid.New			,BuildBdidKey			);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Cont.CorpKey.New	,BuildCorpKey			);	
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Cont.NameAddr.New	,BuildNameAddrKey	);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).cont.Did.New			,BuildDidKey 			);
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
			,BuildNameAddrKey
			,BuildDidKey
		);

	end;

	export Events :=
	module

		VersionControl.macBuildNewLogicalKey(Keys(pversion).Events.Bdid.New			,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Events.CorpKey.New	,BuildCorpKey	);	
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);

	end;

	export Stock :=
	module

		VersionControl.macBuildNewLogicalKey(Keys(pversion).Stock.Bdid.New		,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).Stock.CorpKey.New	,BuildCorpKey	);	
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);
                            
	end;

	export AR :=
	module

		VersionControl.macBuildNewLogicalKey(Keys(pversion).AR.Bdid.New			,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys(pversion).AR.CorpKey.New	,BuildCorpKey	);	
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);
	end;

	export Build_All :=
	sequential(
		parallel(
			 Corp.Build_All
			,Cont.Build_All
		),
		parallel(
			 Events.Build_All
			,Stock.Build_All
			,Ar.Build_All
		)
		,VersionControl.mUtilities.createsupers(Keynames().dall_filenames)
		,corp2_services.BWR_buildautokeyB(pversion)
		,Promote(pversion,'key').New2Built
	);

end;