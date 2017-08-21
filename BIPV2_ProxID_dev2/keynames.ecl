import tools;
EXPORT keynames(string pversion = '') :=
module

	export attribute_matches        := tools.mod_FilenamesBuild('~thor_data400::key::proxid::BIPV2_ProxID_dev2::@version@::attribute_matches'      ,pversion );
	export match_candidates_debug   := tools.mod_FilenamesBuild('~thor_data400::key::proxid::BIPV2_ProxID_dev2::@version@::match_candidates_debug' ,pversion );
	export specificities_debug      := tools.mod_FilenamesBuild('~thor_data400::key::proxid::BIPV2_ProxID_dev2::@version@::specificities_debug'    ,pversion );
	export match_sample_debug       := tools.mod_FilenamesBuild('~thor_data400::key::proxid::BIPV2_ProxID_dev2::@version@::match_sample_debug'     ,pversion );
	export patched_candidates       := tools.mod_FilenamesBuild('~thor_data400::key::proxid::BIPV2_ProxID_dev2::@version@::patched_candidates'     ,pversion );

	export dall_filenames := 
      attribute_matches.dall_filenames
    + match_candidates_debug.dall_filenames
    + specificities_debug.dall_filenames
    + match_sample_debug.dall_filenames
    + patched_candidates.dall_filenames
    ;
    
end;