//Defines full build process
import _control, versioncontrol;

export Build_Base
(
  string pversion,
  boolean pUseProd = false,
  boolean pIsFull = false
  // ,dataset(Layouts.Base)	pBaseFile = Files().base.qa
  
) := module
   
	export build_base := INQL_TMX.Update_Base(pversion, pUseProd, pIsFull);

	VersionControl.macBuildNewLogicalFile
  ( 
      INQL_TMX.Filenames(pversion, pUseProd, pIsFull).base.new,
      build_base,
      Build_Base_File
  );
																																
	export full_build :=
		sequential
    (
			Build_Base_File,
			INQL_TMX.Promote(pversion, pUseProd, pIsFull).buildfiles.New2Built,
			INQL_TMX.Promote(pversion, pUseProd, pIsFull).buildfiles.Built2qa
		);

	export All :=
		if (VersionControl.IsValidVersion(pversion),
        full_build,
        output('Build_Base - No Valid version parameter passed, TMX.Build_Base atribute...')
		);

end;