import versioncontrol;

export Create_Supers(
	
	 dataset(versioncontrol.layout_versions.inputs) pInputFilenames	= filenames().input.dAll_filenames
	,dataset(versioncontrol.layout_versions.builds) pBuildFilenames	= filenames().dAll_filenames

) :=
		 versioncontrol.mUtilities.createallsupers(pInputFilenames,pBuildFilenames);
