import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	//shared lkeyTemplate			:= Constants(pUseOtherEnvironment).keyTemplate			;
   	shared lautokeytemplate 		:= Constants(pUseOtherEnvironment).autokeytemplate	;
	export autokeyroot		        := versioncontrol.mBuildFilenameVersions(lautokeytemplate	,pversion);
	export namewords			    := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'namewords2'	,pversion);
	export payload				    := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'payload'			,pversion);
 	export nameb2					:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'nameb2'			,pversion);
	export stnameb2				    := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'stnameb2'		,pversion);
	export addressb2			    := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'addressb2'		,pversion);
	export zipb2	 				:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'zipb2' 			,pversion);
	export citystnameb2		        := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'citystnameb2',pversion);
	export dAll_filenames := 
		  nameb2.dAll_filenames
		+ namewords.dAll_filenames
		+ stnameb2.dAll_filenames
		+ payload.dAll_filenames
		+ addressb2.dAll_filenames
		+ zipb2.dAll_filenames
		+ citystnameb2.dAll_filenames;
end;