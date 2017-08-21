/////////////////////////////////////////////////////////////////////////////////////////
// -- The keys are now a mix of the old naming convention, and the new naming convention
// -- The superfiles are the old naming convention, and the logical files are the new
/////////////////////////////////////////////////////////////////////////////////////////

import versioncontrol, business_header;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	
	//////////////////////////////////////////////////////////////////
	// -- Versions, root keynames, Date
	//////////////////////////////////////////////////////////////////
	shared lversiondate	:= pversion														;

	shared lRoot			:= _dataset(pUseOtherEnvironment).thor_cluster_Files + 'key::'	+ _Dataset().Name + '::@version@::';

	export BdidRoot										:= lRoot + 'Bdid'										;
	export bdid_MrktResRoot						:= lRoot + 'bdid_MrktRes'						;
	export title_bdid_didRoot					:= lRoot + 'title_bdid_did'					;
	export Title_bdid_did_MrktResRoot	:= lRoot + 'Title_bdid_did_MrktRes'	;

	export Bdid										:= versioncontrol.mBuildFilenameVersions(BdidRoot										,lversiondate	);
	export bdid_MrktRes						:= versioncontrol.mBuildFilenameVersions(bdid_MrktResRoot						,lversiondate	);
	export title_bdid_did					:= versioncontrol.mBuildFilenameVersions(title_bdid_didRoot					,lversiondate	);
	export Title_bdid_did_MrktRes	:= versioncontrol.mBuildFilenameVersions(Title_bdid_did_MrktResRoot	,lversiondate	);
																																							                                  
	export dAll_filenames := 
			Bdid.dAll_filenames
		+ bdid_MrktRes.dAll_filenames
		+ title_bdid_did.dAll_filenames
		+ Title_bdid_did_MrktRes.dAll_filenames
		; 

end;