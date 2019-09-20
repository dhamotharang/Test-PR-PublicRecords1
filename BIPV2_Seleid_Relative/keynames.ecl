import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfileprefix  := _Constants(pUseOtherEnvironment).prefix	;
	export specs        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_Seleid_Relative::@version@::specificities'      ,pversion );
	export mc           := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_Seleid_Relative::@version@::match_candidates'   ,pversion );
	export assoc        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_Seleid_Relative::@version@::seleid::rel::assoc' ,pversion );
	
  export dall_filenames :=
        specs     .dall_filenames
      + mc        .dall_filenames
      + assoc     .dall_filenames
    ;
end;