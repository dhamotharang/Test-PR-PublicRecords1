import tools;

EXPORT filenames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		  := _Config(pUseOtherEnvironment).OldFileTemplate	  ;

	export Suppression            := tools.mod_FilenamesBuild(lfileprefix 	          ,pversion);
	export Hierarchy_Suppression  := tools.mod_FilenamesBuild(lfileprefix + 'hrchy::' ,pversion);

  export dall_filenames := 
      Suppression           .dall_filenames
    + Hierarchy_Suppression .dall_filenames
    ;
    

end;