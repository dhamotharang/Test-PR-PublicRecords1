////////////////////////////////////////////////////////////////////////////
// -- find_copied_files_owners() function
// -- Description:  This function find files on one thor(probably the thor400_31_store) that exist on other thors and tries to find out the owner
// --                 of the thor400_31_store file by using patterns that match other files with that pattern. 
// --                 it can put the real owner into the description field when pIsTesting is set to false.
/*
tools.find_copied_files_owners(
	 pOwner								:= 'ananth_prod'			// regex to filter the file owner
	,pFilename						:= ''			// regex to filter the filenames
	,pCluster							:= 'thor400_31_store'			// regex to filter the cluster
	,pModified						:= ''			// regex to filter the modified time
	,pSizeMinimum					:= power(2.0,40)			// regex to filter by size
	,pIsTesting						:= true		// If true	, just output the dataset of files matched
																	// If false	, output the dataset, and delete the files in the dataset 
	,pOutputLimit					:= 0			// Limit the amount of files returned
	,pIncludeNormalFiles	:= true		// If true,  return logical files 
	,pIncludeSuperFiles		:= false	// If true,  return super files 
	,pIncludeSubfiles		  := true	// If true,  return sub files 
);
*/
////////////////////////////////////////////////////////////////////////////
#option ('globalAutoHoist', false);	// added because of bug 28526
import ut,wk_ut;

export find_copied_files_owners(
	 string			pOwner							= ''		// regex to filter the file owner
	,string			pFilename						= ''		// regex to filter the filenames
	,string			pCluster						= ''		// regex to filter the cluster
	,string			pModified						= ''		// regex to filter the modified time
	,unsigned8	pSizeMinimum				= 0			// regex to filter by size
	,unsigned8	pSizeMaximum    		= 0			// regex to filter by size
	,boolean		pIsTesting					= true	// If true	, just output the dataset of files matched
																				// If false	, output the dataset, and delete the files in the dataset 
	,unsigned		pOutputLimit				= 0			// Limit the amount of files returned
	,boolean		pIncludeNormalFiles	= true	// If true,  return logical files 
	,boolean		pIncludeSuperFiles	= false	// If true,  return super files 
	,boolean		pIncludeSubfiles		= false	// If true,  return sub files 
  ,string     pRegexPattern       = '([[:digit:]]{8}(([-][[:digit:]]{6})|[[:alpha:]])?|thor[[:alnum:]_]*::)'
  ,string     pRegexversion       = '([[:digit:]]{8}(([-][[:digit:]]{6})|[[:alpha:]])?)'
  // ,string     pRegexPattern       = '[[:digit:]]{8}(([-][[:digit:]]{6})|[[:alpha:]])?'

) :=
function

  // lowner := powner;
  
  file_list          := wk_ut.get_DFUQuery(,pCluster,,,,/*pOwner*/,,,,,,500000).largest;  //hack

	file_list2				 := fileservices.LogicalFileList(includenormal := pIncludeNormalFiles,includesuper := pIncludeSuperFiles);
	
	owner_filter						:= if(pOwner 				!= '', regexfind(pOwner			, file_list.owner		    , nocase), true);
	filename_filter					:= if(pFilename			!= '', regexfind(pFilename	, file_list.name		    , nocase), true);
	cluster_filter					:= if(pCluster			!= '', regexfind(pCluster		, file_list.ClusterName , nocase), true);
	modified_filter					:= if(pModified			!= '', regexfind(pModified	, file_list.modified    , nocase), true);
	size_filter							:= if(pSizeMinimum	!= 0 , file_list.longsize >= pSizeMinimum						, true);
	size_max_filter				  := if(pSizeMaximum	!= 0 , file_list.longsize <= pSizeMaximum						, true);
	
	owner_filter2						:= if(pOwner 				!= '', regexfind(pOwner			, file_list2.owner		    , nocase), true);
	filename_filter2			  := if(pFilename			!= '', regexfind(pFilename	, file_list2.name		    , nocase), true);
	cluster_filter2					:= if(pCluster			!= '', regexfind(pCluster		, file_list2.Cluster , nocase), true);
	modified_filter2				:= if(pModified			!= '', regexfind(pModified	, file_list2.modified    , nocase), true);
	// size_filter2						:= if(pSizeMinimum	!= 0 , file_list2.longsize >= pSizeMinimum						, true);
	// size_max_filter2				:= if(pSizeMaximum	!= 0 , file_list2.longsize <= pSizeMaximum						, true);

	myfile_list1							:= file_list(
                                       owner_filter
																			,filename_filter
																			,cluster_filter
																			,modified_filter
																			,size_filter
                                      ,size_max_filter
																			);

	myfile_list2							:= file_list2(
                                       owner_filter2
																			,filename_filter2
																			,cluster_filter2
																			,modified_filter2
																			// ,size_filter2
                                      // ,size_max_filter2
																			);
  //get uncompressed file size
  myfile_list             := join(myfile_list1,myfile_list2 ,left.name = right.name,transform(recordof(left),self.longsize := right.size,self.realsize := if(left.realsize = 0,right.size,left.realsize),self := left),hash);
                                      
	myfile_list_notinsupers := myfile_list(fileservices.fileexists('~' + name), pIncludeSubfiles or count(fileservices.LogicalFileSuperOwners('~' + name)) = 0) ;	
  
  total_size := sum(myfile_list_notinsupers,realsize);
  
  myregex := pRegexPattern;
  
	largest									:= iterate(project(sort(myfile_list_notinsupers, -longsize),transform({string name,string sizepretty,unsigned realsize,string realsize_,real8 percent,unsigned8 running_total_size,string running_total_sizepretty,real8 running_total_percent,recordof(left) - name
    ,string name_pattern,string version,unsigned8 cnt_pattern := 0,unsigned8 pattern_size := 0,string pattern_size_pretty := ''}
                                ,self.sizepretty                := ut.FHumanReadableSpace(left.longsize)
                                ,self.realsize                  := left.realsize;
                                ,self.realsize_                 := ut.FHumanReadableSpace(left.realsize)
                                ,self.percent                   := left.realsize / total_size * 100.0;
                                ,self.running_total_size        := left.realsize
                                ,self.running_total_sizepretty  := ''
                                ,self.running_total_percent     := 0
                                ,self.name_pattern              := regexreplace('::copy(from[[:alnum:]]*)?',regexreplace('\\*+',if(regexfind(myregex,left.name,nocase)  ,regexreplace(myregex,left.name,'*',nocase), left.name),'*',nocase),'',nocase)
                                ,self.version                   := if(regexfind(pRegexversion,left.name,nocase)  ,regexfind(pRegexversion,left.name,0), '')
                                ,self                           := left
                             )) 
                             ,transform(recordof(left),self.running_total_size := left.running_total_size + right.running_total_size,self.running_total_sizepretty := ut.FHumanReadableSpace(self.running_total_size),self.running_total_percent := self.running_total_size / total_size * 100.0,self := right))
                             
                             : independent;
  
// --
	ds_all									:= project(file_list2,transform({string name,string name_pattern,string version,recordof(left) - name}
                                ,self.name_pattern              := regexreplace('::copy(from[[:alnum:]]*)?',regexreplace('\\*+',if(regexfind(myregex,left.name,nocase)  ,regexreplace(myregex,left.name,'*',nocase), left.name),'*',nocase),'',nocase)
                                ,self.version                   := if(regexfind(pRegexversion,left.name,nocase)  ,regexfind(pRegexversion,left.name,0), '')
                                ,self                           := left
                             )) 
                             : independent;

  ds_all_filt := join(ds_all  ,largest  ,left.name = right.name,transform(left),left only); //remove the files we are looking for owners for
  
  ds_latest_owner_per_pattern := dedup(sort (ds_all_filt,name_pattern,-modified),name_pattern);
  
  ds_other_files := join(ds_latest_owner_per_pattern ,largest  ,left.name_pattern = right.name_pattern ,transform(left));
  ds_store_files := join(ds_latest_owner_per_pattern ,largest  ,left.name_pattern = right.name_pattern and left.name != right.name ,transform({string new_owner,string name,string matched_filename,recordof(right) - name},self.new_owner := left.owner ,self.matched_filename := left.name,self := right));
  
  sum_largest := sum(largest, realsize) : independent;
  
	todo := sequential(
             output(topn(project(ds_store_files,transform({string new_owner, string name, string modified,string size,string ClusterName},self.size := left.sizepretty,self := left))  ,500,new_owner,name)            ,named('Delete_These_Files'             ),all)
            ,output(choosen(file_list  ,100),named('DFUQueryFileList'))
						,if(pOutputLimit = 0
              ,output(largest, all)
              ,output(choosen(largest,pOutputLimit), all)
						)
						,output(sum_largest	,named('TotalSpaceUsed'))
						,output(ut.FHumanReadableSpace( sum_largest)	,named('TotalSpaceUsedPretty'))
            // /*
            ,output(topn(ds_all   ,100,name_pattern,-modified)                   ,named('ds_all'                     ),all)
            ,output(topn(ds_all_filt   ,100,name_pattern,-modified)                   ,named('ds_all_filt'                     ),all)
            ,output(topn(ds_latest_owner_per_pattern ,100,name_pattern),named('ds_latest_owner_per_pattern'),all)
            ,output(topn(ds_other_files  ,100,name_pattern)            ,named('ds_other_files'             ),all)
            ,output(topn(ds_store_files  ,500,new_owner,name_pattern)            ,named('ds_store_files'             ),all)
            ,if(pIsTesting  = false ,nothor(apply(global(ds_store_files,few)  ,FileServices.SetFileDescription('~' + name, new_owner))))
        );

	return todo;
end;
