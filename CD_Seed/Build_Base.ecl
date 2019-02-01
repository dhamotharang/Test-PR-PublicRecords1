//Defines full build process
import _control, versioncontrol, header, mdr;

export Build_Base(string pversion, boolean pUseProd = false) := module
  
	shared SeedFile_AsSrc := Update_Base(pversion,pUseProd);

	VersionControl.macBuildNewLogicalFile(
        Filenames(pversion,pUseProd).Base_AsSrc.new
	   ,SeedFile_AsSrc
	   ,Build_Seed_AsSrc
	   );
       
	EXPORT ALL := sequential(
			Build_Seed_AsSrc
		   ,Promote(pversion,pUseProd).Promote_Seed_AsSrc.buildfiles.New2Built
           ,Promote(pversion,pUseProd).Promote_Seed_AsSrc.buildfiles.Built2QA          
		   );  
    
end;
