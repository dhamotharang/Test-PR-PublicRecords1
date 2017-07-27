import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate				  := Constants(pUseOtherEnvironment).keyTemplate			;
	shared lautokeytemplate 		:= Constants(pUseOtherEnvironment).autokeytemplate	;
	
	export autokeyroot		      := versioncontrol.mBuildFilenameVersions(lautokeytemplate									,pversion);
	export address				      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'address'			,pversion);
	export addressb2			      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'addressb2'		,pversion);
	export citystname			      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'citystname'	,pversion);
	export citystnameb2		      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'citystnameb2',pversion);
	export name						      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'name'				,pversion);
	export nameb2					      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'nameb2'			,pversion);
	export namewords2			      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'namewords2'	,pversion);
	export payload				      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'payload'			,pversion);
	export phone2					      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'phone2'			,pversion);
	export phoneb2				      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'phoneb2'			,pversion);
	export stname					      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'stname'			,pversion);
	export stnameb2				      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'stnameb2'		,pversion);
	export zip						      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'zip'					,pversion);
	export zipb2	 				      := versioncontrol.mBuildFilenameVersions(lautokeytemplate + 'zipb2' 			,pversion);
	
	export Bdid						      := versioncontrol.mBuildFilenameVersions(lkeyTemplate			+ 'bdid'				,pversion);
	export Did						      := versioncontrol.mBuildFilenameVersions(lkeyTemplate			+ 'did'					,pversion);
	export UniqueID						  := versioncontrol.mBuildFilenameVersions(lkeyTemplate			+ 'UniqueID'		,pversion);
	export LinkIDs						  := versioncontrol.mBuildFilenameVersions(lkeyTemplate			+ 'LinkIDs'			,pversion);

	export dAll_filenames :=  Bdid.dAll_filenames
													+ address.dAll_filenames
													+ addressb2.dAll_filenames
													+ citystname.dAll_filenames
													+ citystnameb2.dAll_filenames
													+ name.dAll_filenames
													+ nameb2.dAll_filenames
													+ namewords2.dAll_filenames
													+ payload.dAll_filenames
													+ phone2.dAll_filenames
													+ phoneb2.dAll_filenames
													+ stname.dAll_filenames
													+ stnameb2.dAll_filenames
													+ zip.dAll_filenames
													+ zipb2.dAll_filenames
													+ Did.dAll_filenames
													+ UniqueID.dAll_filenames
													+ LinkIDs.dAll_filenames;

end;