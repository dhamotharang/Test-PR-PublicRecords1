import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfileprefix  := _Constants(pUseOtherEnvironment).prefix	;
	export assoc        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_Seleid_Relative::@version@::seleid::rel::assoc'      ,pversion );
	export dall_filenames :=
      assoc     .dall_filenames
    ;
end;