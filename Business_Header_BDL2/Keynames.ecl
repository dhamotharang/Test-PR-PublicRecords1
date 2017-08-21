/////////////////////////////////////////////////////////////////////////////////////////
// -- The keys are now a mix of the old naming convention, and the new naming convention
// -- The superfiles are the old naming convention, and the logical keys are the new to 
// -- match the Busines headers naming convention
/////////////////////////////////////////////////////////////////////////////////////////

import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lRoot				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files + 'key::business_header_BDL2::';
	shared lversion			:= '@version@::'											;

	export lmatch_candidates_debug		:= lRoot + lversion	+ 'match_candidates_debug::BDID'				;
	export lmatch_sample_debug				:= lRoot + lversion	+ 'match_sample_debug::Conf.BDID1.BDID2';
	export lspecificities_debug				:= lRoot + lversion	+ 'specificities_debug'									;
	export lpatched_candidates				:= lRoot + lversion	+ 'patched_candidates::BDID'						;
                                                   
	export match_candidates_debug		:= versioncontrol.mBuildFilenameVersions(lmatch_candidates_debug	,lversiondate);
	export match_sample_debug				:= versioncontrol.mBuildFilenameVersions(lmatch_sample_debug			,lversiondate);
	export specificities_debug			:= versioncontrol.mBuildFilenameVersions(lspecificities_debug			,lversiondate);
	export patched_candidates				:= versioncontrol.mBuildFilenameVersions(lpatched_candidates			,lversiondate);
	                                                                 
	export dAll_filenames := 
			match_candidates_debug.dAll_filenames
		+ match_sample_debug.dAll_filenames
		+ specificities_debug.dAll_filenames
		+ patched_candidates.dAll_filenames
		; 

	export dAll_filenames_build := 
			match_candidates_debug.dAll_filenames
		+ match_sample_debug.dAll_filenames
		+ specificities_debug.dAll_filenames
		; 

end;