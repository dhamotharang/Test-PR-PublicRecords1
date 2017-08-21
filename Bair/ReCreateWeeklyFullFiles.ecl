import VersionControl;

EXPORT ReCreateWeeklyFullFiles(string version, boolean pUseProd = false) := module

	export ReCreate_GroupAccess := module

		GroupAccess_base 	:= Bair.files().group_access_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Bair.Filenames(version, pUseProd).event_group_access_Base.new
																		,GroupAccess_base
																		,Build_GroupAccess_base
																		);
		export bld	:=  
									sequential(				
											 Build_GroupAccess_base
											,Bair.Promote.promote_group_access(version, pUseProd).buildfiles.New2Built
											,bair.Build_Keys.Build_Keys_group_access(version).group_access_All
											,bair.Promote.promote_group_access(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_DataProvider := module

		DataProvider_base 		:= Bair.files().DataProvider_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Filenames(version, pUseProd).event_dbo_data_provider_Base.new
																		,DataProvider_base
																		,Build_DataProvider_base
																		);
		export bld	:=  
									sequential(				
											 Build_DataProvider_base
											,bair.Promote.promote_DataProvider(version, pUseProd).buildfiles.New2Built
											,bair.Build_Keys.Build_Keys_DataProvider(version).DataProvider_All
											,bair.Promote.promote_DataProvider(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_AgencyCfsTypeLookup := module

		AgencyCfsLookup_Base 		:= Bair.files().AgencyCfsLookup_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Filenames(version, pUseProd).cfs_dbo_AgencyCfsTypeLookup_Base.new
																		,AgencyCfsLookup_Base
																		,Build_AgencyCfsLookup_Base
																		);
		export bld	:=  
									sequential(				
											 Build_AgencyCfsLookup_Base
											,Promote.promote_AgencyCfsLookup(version, pUseProd).buildfiles.New2Built
											,bair.Promote.promote_AgencyCfsLookup(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_AgencyCrimeTypeLookup := module

		AgencyCrimeLookup_Base 		:= Bair.files().AgencyCrimeLookup_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Filenames(version, pUseProd).event_dbo_AgencyCrimeTypeLookup_Base.new
																		,AgencyCrimeLookup_Base
																		,Build_AgencyCrimeLookup_Base
																		);
		export bld :=  
									sequential(				
											 Build_AgencyCrimeLookup_Base
											,bair.Promote.promote_AgencyCrimeLookup(version, pUseProd).buildfiles.New2Built
											,bair.Promote.promote_AgencyCrimeLookup(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_Classification := module

		Classification_Base 		:= Bair.files().Classification_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																					 Filenames(version, pUseProd).Classification_base.new
																				 	,Classification_Base
																					,Build_Classification_Base
																					);
		export bld	:=  
									sequential(				
											 Build_Classification_Base
											,bair.Promote.promote_Classification(version, pUseProd).buildfiles.New2Built
											,bair.Build_Keys.Build_Keys_Classification(version).Classification_All
											,bair.Promote.promote_Classification(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_DataProviderLoc := module

		DataProviderLoc_Base 		:= Bair.files().DataProviderLoc_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Filenames(version, pUseProd).event_dbo_data_provider_location_Base.new
																		,DataProviderLoc_Base
																		,Build_DataProviderLoc_Base
																		);
		export bld	:=  
									sequential(				
											 Build_DataProviderLoc_Base
											,bair.Promote.promote_DataProviderLoc(version, pUseProd).buildfiles.New2Built
											,bair.Promote.promote_DataProviderLoc(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export ReCreate_DataProviderImp := module

		DataProviderImp_Base 		:= Bair.files().DataProviderImp_Base.Built;
								 
		VersionControl.macBuildNewLogicalFile(
																		 Filenames(version, pUseProd).event_dbo_data_provider_import_Base.new
																		,DataProviderImp_Base
																		,Build_DataProviderImp_Base
																		);
		export bld	:=  
									sequential(				
											 Build_DataProviderImp_Base
											,bair.Promote.promote_DataProviderImp(version, pUseProd).buildfiles.New2Built
											,bair.Promote.promote_DataProviderImp(version,pUseProd).buildfiles.Built2QA
											);
	end;
	
	export create_all := parallel(
													ReCreate_GroupAccess.bld,
													ReCreate_DataProvider.bld,
													ReCreate_AgencyCfsTypeLookup.bld,
													ReCreate_AgencyCrimeTypeLookup.bld,
													ReCreate_Classification.bld,
													ReCreate_DataProviderLoc.bld,
													ReCreate_DataProviderImp.bld
											);
	
end;