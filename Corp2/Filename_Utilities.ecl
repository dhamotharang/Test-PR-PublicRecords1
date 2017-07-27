import versioncontrol;
export Filename_Utilities :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Utilities
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		versioncontrol.macInputFilenameUtilities(Filenames.Input.Corp	, Corp		);
		versioncontrol.macInputFilenameUtilities(Filenames.Input.Cont	, Cont		);
		versioncontrol.macInputFilenameUtilities(Filenames.Input.Events	, Events	);
		versioncontrol.macInputFilenameUtilities(Filenames.Input.Stock	, Stock		);
		versioncontrol.macInputFilenameUtilities(Filenames.Input.AR		, AR		);
		                                                                          
	end;
	
	         
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Utilities
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		versioncontrol.macBuildFilenameUtilities(Filenames.Base.Corp	, Corp		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Base.Cont	, Cont		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Base.Events	, Events	);
		versioncontrol.macBuildFilenameUtilities(Filenames.Base.Stock	, Stock		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Base.AR		, AR		);
                                                                             
	end;

	//////////////////////////////////////////////////////////////////
	// -- Output Filename Utilities
	//////////////////////////////////////////////////////////////////
	export Out :=
	module
	
		versioncontrol.macBuildFilenameUtilities(Filenames.Out.Corp		, Corp		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Out.Cont		, Cont		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Out.Events	, Events	);
		versioncontrol.macBuildFilenameUtilities(Filenames.Out.Stock	, Stock		);
		versioncontrol.macBuildFilenameUtilities(Filenames.Out.AR		, AR		);
                                                                             
	end;
	
	export RoxieKeys :=
	module
	
		export Corp :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.Corp.Bdid		,Bdid		);
			versioncontrol.macBuildFilenameUtilities(keynames.Corp.BdidPl	,BdidPl		);
			versioncontrol.macBuildFilenameUtilities(keynames.Corp.CorpKey	,CorpKey	);
			versioncontrol.macBuildFilenameUtilities(keynames.Corp.NameAddr	,NameAddr	);
			versioncontrol.macBuildFilenameUtilities(keynames.Corp.StCharter,StCharter	);
																								   
		end;
		
		export Cont :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.Cont.Did		,Did		);
			versioncontrol.macBuildFilenameUtilities(keynames.Cont.Bdid		,Bdid		);
			versioncontrol.macBuildFilenameUtilities(keynames.Cont.CorpKey	,CorpKey	);
			versioncontrol.macBuildFilenameUtilities(keynames.Cont.NameAddr	,NameAddr	);
																								  
		end;

		export Events :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.Events.Bdid		,Bdid		);
			versioncontrol.macBuildFilenameUtilities(keynames.Events.CorpKey	,CorpKey	);
																								   
		end;

		export Stock :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.Stock.Bdid	,Bdid		);
			versioncontrol.macBuildFilenameUtilities(keynames.Stock.CorpKey	,CorpKey	);
																								   
		end;

		export AR :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.AR.Bdid		,Bdid		);
			versioncontrol.macBuildFilenameUtilities(keynames.AR.CorpKey	,CorpKey	);
																							   
		end;
		
		export Autokeys :=
		module

			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.Address		,Address		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.CityStName	,CityStName		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.Name			,Name			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.Phone		,Phone			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.SSN			,SSN			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.StName		,StName			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.Zip			,Zip			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.Payload		,Payload		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.AddressB		,AddressB		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.CityStNameB	,CityStNameB	);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.NameB		,NameB			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.NameWords	,NameWords		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.PhoneB		,PhoneB			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.FEIN			,FEIN			);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.StNameB		,StNameB		);
			versioncontrol.macBuildFilenameUtilities(keynames.Autokeys.ZipB			,ZipB			);
																					 		   
		end;

	end;


end;