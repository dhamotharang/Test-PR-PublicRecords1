import Address, header_services, ut, utility_business, VersionControl;

export Build_Util_Bus_base (string pversion) := module
	
	//**** Filtered Business Utility records from the Utility file.
    dUtilBusRecs := utilfile.fn_util_base(utilfile.file_util.full_base);
	
	//**** Adding choicepoint business utility data.
	cp_utility_bus_base := utility_business.Files().base.built;

	dUtilBusBase := dUtilBusRecs + cp_utility_bus_base;

	export create_base := dUtilBusBase;
		
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.new	,create_base	,Build_Base_File	);
	
	export full_build := 
				sequential(
					Build_Base_File
					,Promote(pversion).Base.New2Built
					,Promote(pversion).Base.built2qa
				);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,sequential(full_build)		
		,output('No Valid version parameter passed, skipping UtilFile.build_Util_bus_base atribute')
	);
		
end;
