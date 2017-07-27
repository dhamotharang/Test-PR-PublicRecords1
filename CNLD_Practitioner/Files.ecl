import versioncontrol;
export Files(string pversion = '') := module

   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macInputFileVersions(Filenames(pversion).input, layouts.Input, Input,'CSV',,'\n',',',1,40000);
   
   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macBuildFileVersions(Filenames(pversion).Base, layouts.Base, Base);
	 
   //////////////////////////////////////////////////////////////////
   // -- KeyBuild File
   //////////////////////////////////////////////////////////////////
   versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild);
	 
	 end;