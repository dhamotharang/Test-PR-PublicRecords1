import tools;

EXPORT filenames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		  := _Config(pUseOtherEnvironment).OldFileTemplate	  ;

	export Suppression      := tools.mod_FilenamesBuild(lfileprefix /*+ 'data'*/	     ,pversion);

  export dall_filenames := 
      Suppression           .dall_filenames
    ;
    

end;