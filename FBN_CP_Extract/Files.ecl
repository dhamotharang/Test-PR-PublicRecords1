import versioncontrol;

export Files(string pversion = '') := module
  
	 //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
	
	export Base :=
	module

		versioncontrol.macBuildFileVersions(Filenames(pversion).Experian.base.ExpFilingBase, 	FBN_CP_Extract.Layouts.Out.Filing, 	ExpFilingBase);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Experian.base.ExpNamesBase, 	FBN_CP_Extract.Layouts.Out.Name, 		ExpNamesBase);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Florida.base.FLFilingBase, 		FBN_CP_Extract.Layouts.Out.Filing, 	FLFilingBase);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Florida.base.FLNamesBase, 		FBN_CP_Extract.Layouts.Out.Name, 		FLNamesBase);
	                                                      
	end;  
	
	export Tables :=
	module

		export Location 	:= 	dataset('~thor_data400::lookup::'+pversion[1..8]+'::fbn_experian::locationcode_table',FBN_CP_Extract.Layouts.Tables.Location,CSV(SEPARATOR(['|']), heading(1), TERMINATOR(['\r\n', '\n'])));
		export Court			:=	dataset('~thor_data400::lookup::fbn_experian::CourtCode_table',FBN_CP_Extract.Layouts.Tables.Court,CSV(SEPARATOR([',']), heading(1), TERMINATOR(['\r\n', '\n'])));
	                                                      
	end;  
end;