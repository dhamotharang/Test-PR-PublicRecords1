import tools;
EXPORT keynames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfileprefix		          := _Constants(pUseOtherEnvironment).prefix	;

	export specificities_debug      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3_PlatForm::@version@::specificities_debug'    ,pversion );// key::BIPV2_LGID3_PlatForm::LGID3::Debug::specificities_debug'
	export match_sample_debug       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3_PlatForm::@version@::match_sample_debug'     ,pversion );// key::BIPV2_LGID3_PlatForm::LGID3::Debug::match_sample_debug';
	export patched_candidates       := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3_PlatForm::@version@::patched_candidates'     ,pversion );// key::BIPV2_LGID3_PlatForm::LGID3::Datafile::patched_candidates';
	export match_candidates_debug   := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::key::BIPV2_LGID3_PlatForm::@version@::match_candidates_debug' ,pversion );// key::BIPV2_LGID3_PlatForm::LGID3::Debug::match_candidates_debug';
	
  export dall_filenames := 
      match_candidates_debug.dall_filenames
    + specificities_debug   .dall_filenames
    + match_sample_debug    .dall_filenames
    + patched_candidates    .dall_filenames
    ;
    
end;
