//Defines full build process
import _control, versioncontrol, header, mdr;

export Build_Base(string pversion, boolean pUseProd = false) := module
  
	shared SeedFile_AsSrc    := Update_Base(pversion,pUseProd);    
    shared SeedFile_AsHeader := as_header(SeedFile_AsSrc, true);

	VersionControl.macBuildNewLogicalFile(
        Filenames(pversion,pUseProd).Base_AsSrc.new
	   ,SeedFile_AsSrc
	   ,Build_Seed_AsSrc
	   );
    
    VersionControl.macBuildNewLogicalFile(
        Filenames(pversion,pUseProd).Base_AsHeader.new	
	   ,SeedFile_AsHeader
	   ,Build_Seed_AsHeader
	   );
       
	EXPORT ALL := sequential(
			Build_Seed_AsSrc
		   ,Promote(pversion,pUseProd).Promote_Seed_AsSrc.buildfiles.New2Built
           ,Promote(pversion,pUseProd).Promote_Seed_AsSrc.buildfiles.Built2QA
           ,Build_Seed_AsHeader
		   ,Promote(pversion,pUseProd).Promote_Seed_AsHeader.buildfiles.New2Built
           ,Promote(pversion,pUseProd).Promote_Seed_AsHeader.buildfiles.Built2QA
		   );
    
    
end;
