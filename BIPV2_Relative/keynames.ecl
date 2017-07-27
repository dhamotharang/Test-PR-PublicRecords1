import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfileprefix  := _Constants(pUseOtherEnvironment).prefix	;

	export assoc        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::bipv2_relative::@version@::assoc'      ,pversion );

	export dall_filenames := 
      assoc     .dall_filenames
    ;
    
end;