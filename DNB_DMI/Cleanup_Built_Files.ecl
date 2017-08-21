import tools;

export Cleanup_Built_Files(

	 string																					pversion								//version to delete
	,boolean																				pIsTesting			= true		//just output dataset of files to delete, no deletion performed
	,string																					pFilter					= ''			//regex to filter the dataset passed in
	,boolean																				pNotFilter			= false		//Negate the filter?
	,string																					keydatasetname	= 'DNB'
	,dataset(tools.Layout_FilenameVersions.builds)	pFilenames			= DNB_DMI.Filenames	(pversion).dall_filenames
																																	+ DNB_DMI.Keynames	(pversion,,keydatasetname).dall_filenames						//filenames to delete

) := 
function
	return 
		tools.Cleanup_Build_Files(
			 pversion			:= pversion						//version to delete
			,pFilenames		:= pFilenames
			,pFilter			:= pFilter			//regex to filter the dataset passed in
			,pIsTesting		:= pIsTesting		//just output dataset of files to delete, no deletion performed
			,pNotFilter		:= pNotFilter		//Negate the filter?
		);
	
end;