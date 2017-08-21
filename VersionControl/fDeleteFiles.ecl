////////////////////////////////////////////////////////////////////////////
// -- fDeleteFiles() function
// -- Description:  This function find files(that are not in superfiles) on thor that match certain 
// --								criteria, and has an option to delete them.  You pass in two filter criteria, 
// --								one on the file owner, and the second on the filename.  This allows you to narrow 
// --								down the files to what you want.  
// --									Such as:
/*
VersionControl.fDeleteFiles(
	 pOwner								:= 'lbentley'			// regex to filter the file owner
	,pFilename						:= '::persist::'			// regex to filter the filenames
	,pCluster							:= ''			// regex to filter the cluster
	,pModified						:= ''			// regex to filter the modified time
	,pSizeMinimum					:= 0			// regex to filter by size
	,pIsTesting						:= true		// If true	, just output the dataset of files matched
																	// If false	, output the dataset, and delete the files in the dataset 
	,pOutputLimit					:= 0			// Limit the amount of files returned
	,pIncludeNormalFiles	:= true		// If true,  return logical files 
	,pIncludeSuperFiles		:= false	// If true,  return super files 
);
*/
// -- 
// --								This will output a dataset of all of the files I own that match the '::persist::'
// --								regex that are not in superfiles.  If the dataset that was output to the workunit
// --								contains the files I want to delete, I simply change the last parameter from true to 
// -- 							false, then run it again, and it will delete those files.
////////////////////////////////////////////////////////////////////////////

#option ('globalAutoHoist', false)	// added because of bug 28526

export fDeleteFiles(

	 string			pOwner							= ''		// regex to filter the file owner
	,string			pFilename						= ''		// regex to filter the filenames
	,string			pCluster						= ''		// regex to filter the cluster
	,string			pModified						= ''		// regex to filter the modified time
	,unsigned8	pSizeMinimum				= 0			// regex to filter by size
	,boolean		pIsTesting					= true	// If true	, just output the dataset of files matched
																				// If false	, output the dataset, and delete the files in the dataset 
	,unsigned		pOutputLimit				= 0			// Limit the amount of files returned
	,boolean		pIncludeNormalFiles	= true	// If true,  return logical files 
	,boolean		pIncludeSuperFiles	= false	// If true,  return super files 
) :=
function

	file_list								:= fileservices.LogicalFileList(includenormal := pIncludeNormalFiles,includesuper := pIncludeSuperFiles);
	
	owner_filter						:= if(pOwner 				!= '', regexfind(pOwner			, file_list.owner		, nocase), true);
	filename_filter					:= if(pFilename			!= '', regexfind(pFilename	, file_list.name		, nocase), true);
	cluster_filter					:= if(pCluster			!= '', regexfind(pCluster		, file_list.cluster	, nocase), true);
	modified_filter					:= if(pModified			!= '', regexfind(pModified	, file_list.modified, nocase), true);
	size_filter							:= if(pSizeMinimum	!= 0 , file_list.size > pSizeMinimum										 , true);
	
	myfile_list							:= file_list(owner_filter
																			,filename_filter
																			,cluster_filter
																			,modified_filter
																			,size_filter
																			);

	myfile_list_notinsupers := myfile_list(fileservices.fileexists('~' + name), count(fileservices.LogicalFileSuperOwners('~' + name)) = 0);	

	largest									:= sort(myfile_list_notinsupers, -size);

	filesfordeletion 				:= table(myfile_list_notinsupers, {name});

	todo := sequential(
						 if(pOutputLimit = 0
						,output(largest, all)
						,output(choosen(largest,pOutputLimit), all)
						)
						,if(not pIsTesting
							,nothor(apply(filesfordeletion, if(fileservices.SuperFileExists(name)
								,versioncontrol.mUtilities.removesuper	(name,false)
								,versioncontrol.mUtilities.DeleteLogical(name)
							)))
						)
					);

	return todo;

end;
/*
VersionControl.fDeleteFiles('lbentley'	,'base::corp2'					, false);
VersionControl.fDeleteFiles('lbentley'	,'persist'							, false);
VersionControl.fDeleteFiles('lbentley'	,'key::corp2'						, false);
VersionControl.fDeleteFiles('lbentley'	,'adtemp'								, false);
VersionControl.fDeleteFiles('lbentley'	,'temp'									, false);
VersionControl.fDeleteFiles('lbentley'	,'base::business_header', false);
VersionControl.fDeleteFiles('lbentley'	,'::key::'							, false);
VersionControl.fDeleteFiles('lbentley'	,'::in::'								, false);
VersionControl.fDeleteFiles('lbentley'	,'::in::bernalillo'			, false);
VersionControl.fDeleteFiles('lbentley', '::in::ebr', false);
VersionControl.fDeleteFiles('lbentley', '::out::', false);
*/