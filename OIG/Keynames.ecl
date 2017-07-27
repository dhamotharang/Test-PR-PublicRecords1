import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
shared lautokeytemplate 				:= Constants(pUseOtherEnvironment).autokeytemplate	;
shared LinkIDs_keytemplate 			:= Constants(pUseOtherEnvironment).keyTemplate	;

	export autokeyroot		        := versioncontrol.mBuildFilenameVersions(lautokeytemplate	,pversion);
	export name										:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'name'				,pversion);
	export namewords			    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'namewords2'	,pversion);
	export address				    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'address'			,pversion);
	export citystname			    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'citystname'	,pversion);
	export stname									:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'stname'			,pversion);	
	export zip										:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'zip'					,pversion);
	export ssn2										:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'ssn2'				,pversion);
	export payload				    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'payload'			,pversion);
  export nameb2									:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'nameb2'			,pversion);
	export addressb2			    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'addressb2'		,pversion);
	export citystnameb2		        := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'citystnameb2',pversion);
	export stnameb2				    		:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'stnameb2'		,pversion);
	export zipb2	 								:= versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'zipb2' 			,pversion);
	export LinkIDs	 							:= versioncontrol.mBuildFilenameVersions(LinkIDs_keytemplate + 'LinkIDs' 	,pversion);  
	
	export dAll_filenames :=  nameb2.dAll_filenames
														+ addressb2.dAll_filenames
														+ citystnameb2.dAll_filenames
														+ stnameb2.dAll_filenames
														+ zipb2.dAll_filenames
														+ name.dAll_filenames
														+ address.dAll_filenames
														+ namewords.dAll_filenames
														+ citystname.dAll_filenames
														+ stname.dAll_filenames
														+ zip.dAll_filenames
														+ payload.dAll_filenames
														+ ssn2.dAll_filenames
														+ LinkIDs.dAll_filenames;

end;