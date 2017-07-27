////////////////////////////////////////////////////////////////////////////
// -- fun_CheckSpaceUsed() function
// -- Description:  This function find files(that are not in superfiles) on thor that match certain 
// --								criteria, and has an option to delete them.  You pass in two filter criteria, 
// --								one on the file owner, and the second on the filename.  This allows you to narrow 
// --								down the files to what you want.  
// --									Such as:
/*
fun_CheckSpaceUsed(
	 pOwner								:= 'lbentley'			// regex to filter the file owner
	,pFilename						:= '::persist::'			// regex to filter the filenames
	,pCluster							:= ''			// regex to filter the cluster
	,pModified						:= ''			// regex to filter the modified time
	,pSizeMinimum					:= 0			// regex to filter by size
  ,pUniqueOutput        := ''    // if call this multiple times in one wuid, use this to keep the result outputs diff names
	,pOutputLimit					:= 0			// Limit the amount of files returned
	,pIncludeNormalFiles	:= true		// If true,  return logical files 
	,pIncludeSuperFiles		:= false	// If true,  return super files 
	,pIncludeSubfiles		  := false	// If true,  return sub files 
);
*/
// -- 
// --								This will output a dataset of all of the files I own that match the '::persist::'
// --								regex that are not in superfiles.  If the dataset that was output to the workunit
// --								contains the files I want to delete, I simply change the last parameter from true to 
// -- 							false, then run it again, and it will delete those files.
////////////////////////////////////////////////////////////////////////////
import ut,std;
#option ('globalAutoHoist', false);	// added because of bug 28526
export fun_CheckSpaceUsed(
   string     pversion
	,string			pOwner							= ''		// regex to filter the file owner
	,string			pFilename						= ''		// regex to filter the filenames
	,string			pCluster						= ''		// regex to filter the cluster
	,string			pModified						= ''		// regex to filter the modified time
	,unsigned		pModifiedBefore			= 0		  // Files must be modified before this date(yyyymmdd).  zero(0) means no restrictions
	,unsigned		pModifiedAfter			= 0		  // Files must be modified after this date (yyyymmdd).  zero(0) means no restrictions
	,unsigned8	pSizeMinimum				= 0			// regex to filter by size
	,boolean		pIncludeNormalFiles	= true	// If true,  return logical files 
	,boolean		pIncludeSuperFiles	= false	// If true,  return super files 
	,boolean		pIncludeSubfiles		= false	// If true,  return sub files 
  ,string     pNote               = ''    // Extra field in dataset for comments
) :=
function

	file_list								:= nothor(std.file.LogicalFileList(/*'*bipv2*',*/includenormal := pIncludeNormalFiles,includesuper := pIncludeSuperFiles));
	fgetdate(string pdate)  := (unsigned)(trim(pdate,all)[1..4] + trim(pdate,all)[6..7] + trim(pdate,all)[9..10]);
  
	owner_filter						:= if(pOwner 				  != '', regexfind(pOwner			, file_list.owner		, nocase), true);
	filename_filter					:= if(pFilename			  != '', regexfind(pFilename	, file_list.name		, nocase), true);
	cluster_filter					:= if(pCluster			  != '', regexfind(pCluster		, file_list.cluster	, nocase), true);
	modified_filter					:= if(pModified			  != '', regexfind(pModified	, file_list.modified, nocase), true);
	size_filter							:= if(pSizeMinimum	  != 0 , file_list.size > pSizeMinimum										 , true);
	ModifiedBefore_filter		:= if(pModifiedBefore	!= 0 , fgetdate(file_list.modified) <= pModifiedBefore	 , true);
	ModifiedAfter_filter		:= if(pModifiedAfter	!= 0 , fgetdate(file_list.modified) >= pModifiedAfter		 , true);

//20131203
//2013-11-28T20:49:28

	
	myfile_list							:= global(file_list(owner_filter
																			,filename_filter
																			,cluster_filter
																			,modified_filter
																			,size_filter
                                      ,ModifiedBefore_filter	
                                      ,ModifiedAfter_filter	
																			),few);
	myfile_list_notinsupers := nothor(myfile_list(fileservices.fileexists('~' + name), pIncludeSubfiles or count(fileservices.LogicalFileSuperOwners('~' + name)) = 0));	
	largest									:= nothor(project(global(sort(myfile_list_notinsupers, -size),few),transform(Layout_Space_Used.FileInfo,self.isSubFile := count(fileservices.LogicalFileSuperOwners('~' + left.name)) <> 0,self := left,self.size_pretty := ut.FHumanReadableSpace(left.size))));

  dsummary := dataset([{pversion,workunit,ut.GetTimeDate(),pNote
  ,count(largest),sum(largest, size),ut.FHumanReadableSpace(sum(largest, size))
  ,count(largest(isSubFile)),sum(largest(isSubFile), size),ut.FHumanReadableSpace(sum(largest(isSubFile), size))
  ,count(largest(~isSubFile)),sum(largest(~isSubFile), size),ut.FHumanReadableSpace(sum(largest(~isSubFile), size))
  ,largest}],Layout_Space_Used.big);

	return dsummary;
  
end;
/*
Tools.fun_DeleteFiles('lbentley'	,'base::corp2'					, false);
Tools.fun_DeleteFiles('lbentley'	,'persist'							, false);
Tools.fun_DeleteFiles('lbentley'	,'key::corp2'						, false);
Tools.fun_DeleteFiles('lbentley'	,'adtemp'								, false);
Tools.fun_DeleteFiles('lbentley'	,'temp'									, false);
Tools.fun_DeleteFiles('lbentley'	,'base::business_header', false);
Tools.fun_DeleteFiles('lbentley'	,'::key::'							, false);
Tools.fun_DeleteFiles('lbentley'	,'::in::'								, false);
Tools.fun_DeleteFiles('lbentley'	,'::in::bernalillo'			, false);
Tools.fun_DeleteFiles('lbentley', '::in::ebr', false);
Tools.fun_DeleteFiles('lbentley', '::out::', false);
*/
