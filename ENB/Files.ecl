import versioncontrol;
export Files(string pversion = '') :=
module
   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macInputFileVersions(Filenames(pversion).input  ,layouts.Input.Sprayed  ,Input);
   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
	 export Base :=
	 module

		 versioncontrol.macBuildFileVersions(Filenames(pversion).Base.Companies  ,layouts.Base.Companies  , Companies   );
		 versioncontrol.macBuildFileVersions(Filenames(pversion).Base.Contacts   ,layouts.Base.Contacts   , Contacts    );
	                                                                                                    
	 end;
end;
