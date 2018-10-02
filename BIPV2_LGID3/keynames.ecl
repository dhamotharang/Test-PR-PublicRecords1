import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfileprefix		          := _Constants(pUseOtherEnvironment).prefix	;

	export specificities_debug      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3::@version@::specificities_debug'    ,pversion );// key::BIPV2_LGID3::LGID3::Debug::specificities_debug'
	export match_sample_debug       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3::@version@::match_sample_debug'     ,pversion );// key::BIPV2_LGID3::LGID3::Debug::match_sample_debug';
	export patched_candidates       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3::@version@::patched_candidates'     ,pversion );// key::BIPV2_LGID3::LGID3::Datafile::patched_candidates';
	export match_candidates_debug   := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3::@version@::match_candidates_debug' ,pversion );// key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug';
	export attribute_matches        := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3::@version@::attribute_matches'      ,pversion );// key::BIPV2_LGID3::LGID3::Datafile::attribute_matches';
	
  export dall_filenames := 
      match_candidates_debug .dall_filenames
    + specificities_debug    .dall_filenames
    + match_sample_debug     .dall_filenames
    + patched_candidates     .dall_filenames
    + attribute_matches      .dall_filenames
    ;
    
end;
