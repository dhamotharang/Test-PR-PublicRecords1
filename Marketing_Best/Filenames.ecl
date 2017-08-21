/////////////////////////////////////////////////////////////////////////////////////////
// -- The keys are now a mix of the old naming convention, and the new naming convention
// -- The superfiles are the old naming convention, and the logical files are the new
/////////////////////////////////////////////////////////////////////////////////////////

import doxie, versioncontrol, business_header;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	//////////////////////////////////////////////////////////////////
	// -- Versions, root keynames, Date
	//////////////////////////////////////////////////////////////////
	shared lversiondate	:= pversion;
	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;

	shared lOldRoot			:= lthor + 'base::'	+ _Dataset().Name + '_';
	shared lNewRoot			:= lthor + 'base::'	+ _Dataset().Name + '::@version@::';

	export old :=
	module
		export AllRoot								:= lOldRoot + 'All'								;
		export RestrictedRoot					:= lOldRoot + 'Restricted'				;
		export Titles_AllRoot					:= lOldRoot + 'Titles_All'				;
		export Titles_RestrictedRoot	:= lOldRoot + 'Titles_Restricted'	;
  end;

	export new :=
	module
		export AllRoot								:= lNewRoot + 'All'								;
		export RestrictedRoot					:= lNewRoot + 'Restricted'				;
		export Titles_AllRoot					:= lNewRoot + 'Titles_All'				;
		export Titles_RestrictedRoot	:= lNewRoot + 'Titles_Restricted'	;
	end;

	export Best_All						:= versioncontrol.mBuildFilenameVersionsOld(Old.AllRoot								,lversiondate	,New.AllRoot								);
	export Best_Restricted		:= versioncontrol.mBuildFilenameVersionsOld(Old.RestrictedRoot				,lversiondate	,New.RestrictedRoot					);
	export Titles_All					:= versioncontrol.mBuildFilenameVersionsOld(Old.Titles_AllRoot				,lversiondate	,New.Titles_AllRoot					);
	export Titles_Restricted	:= versioncontrol.mBuildFilenameVersionsOld(Old.Titles_RestrictedRoot	,lversiondate	,New.Titles_RestrictedRoot	);
																																							                                  
	export dAll_filenames :=
			Best_All.dAll_filenames
		+ Best_Restricted.dAll_filenames
		+ Titles_All.dAll_filenames
		+ Titles_Restricted.dAll_filenames
		; 

end;