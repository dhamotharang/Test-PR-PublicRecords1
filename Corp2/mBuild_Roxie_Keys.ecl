import doxie, VersionControl, corp2_services;

export mBuild_Roxie_Keys :=
module

	export Corp :=
	module

		VersionControl.macBuildNewLogicalKey(Keys.Corp.Bdid		,Keynames.Corp.Bdid		,BuildBdidKey		);
		VersionControl.macBuildNewLogicalKey(Keys.Corp.BdidPl	,Keynames.Corp.BdidPl	,BuildBdidPlKey		);	
		VersionControl.macBuildNewLogicalKey(Keys.Corp.CorpKey	,Keynames.Corp.CorpKey	,BuildCorpKey		);	
		VersionControl.macBuildNewLogicalKey(Keys.Corp.NameAddr	,Keynames.Corp.NameAddr	,BuildNameAddrKey	);	
		VersionControl.macBuildNewLogicalKey(Keys.Corp.StCharter,Keynames.Corp.StCharter,BuildStCharterKey	);                                                                                                                                            
		
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

		VersionControl.macBuildNewLogicalKey(Keys.Cont.Bdid		,Keynames.Cont.Bdid		,BuildBdidKey		);
		VersionControl.macBuildNewLogicalKey(Keys.Cont.CorpKey	,Keynames.Cont.CorpKey	,BuildCorpKey		);	
		VersionControl.macBuildNewLogicalKey(Keys.Cont.NameAddr	,Keynames.Cont.NameAddr	,BuildNameAddrKey	);
		VersionControl.macBuildNewLogicalKey(keys.cont.Did		,Keynames.Cont.Did		,BuildDidKey 		);
                                                                              
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

		VersionControl.macBuildNewLogicalKey(Keys.Events.Bdid		,Keynames.Events.Bdid		,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys.Events.CorpKey	,Keynames.Events.CorpKey	,BuildCorpKey	);	
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
            ,BuildCorpKey
		);

	end;

	export Stock :=
	module

		VersionControl.macBuildNewLogicalKey(Keys.Stock.Bdid	,Keynames.Stock.Bdid	,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys.Stock.CorpKey	,Keynames.Stock.CorpKey	,BuildCorpKey	);	
                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
            ,BuildCorpKey
		);
                            
	end;

	export AR :=
	module

		VersionControl.macBuildNewLogicalKey(Keys.AR.Bdid		,Keynames.AR.Bdid		,BuildBdidKey	);
		VersionControl.macBuildNewLogicalKey(Keys.AR.CorpKey	,Keynames.AR.CorpKey	,BuildCorpKey	);	
                                                                              
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
		),
		corp2_services.BWR_buildautokeyB
		,Promote.Roxiekeys.New2Built
	);

end;