import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfileprefix		          := _Constants(pUseOtherEnvironment).prefix	;
	export attribute_matches        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::attribute_matches'      ,pversion );
	export match_candidates_debug   := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::match_candidates_debug' ,pversion );
	export specificities_debug      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::specificities_debug'    ,pversion );
	export match_sample_debug       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::match_sample_debug'     ,pversion );
	export patched_candidates       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::patched_candidates'     ,pversion );
	export in_data                  := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::in_data'                ,pversion );
	export match_history            := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID::@version@::match_history'          ,pversion );

	export dall_filenames := 
      attribute_matches     .dall_filenames
    + match_candidates_debug.dall_filenames
    + specificities_debug   .dall_filenames
    + match_sample_debug    .dall_filenames
    + patched_candidates    .dall_filenames
    + in_data               .dall_filenames
    + match_history         .dall_filenames
    ;
    
end;
