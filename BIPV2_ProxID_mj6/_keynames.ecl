import tools;
EXPORT _keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfileprefix		          := _Constants(pUseOtherEnvironment).prefix	;
	export attribute_matches        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::attribute_matches'      ,pversion );
	export match_candidates_debug   := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::match_candidates_debug' ,pversion );
	export specificities_debug      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::specificities_debug'    ,pversion );
	export match_sample_debug       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::match_sample_debug'     ,pversion );
	export patched_candidates       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::patched_candidates'     ,pversion );
	export in_data                  := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::proxid::BIPV2_ProxID_mj6::@version@::in_data'                ,pversion );
	export dall_filenames := 
      attribute_matches     .dall_filenames
    + match_candidates_debug.dall_filenames
    + specificities_debug   .dall_filenames
    + match_sample_debug    .dall_filenames
    + patched_candidates    .dall_filenames
    + in_data               .dall_filenames
    ;
    
end;
