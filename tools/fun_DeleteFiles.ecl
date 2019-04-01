/*2015-09-24T21:56:10Z (lbentley_prod)
C:\Users\bentlela\AppData\Roaming\HPCC Systems\eclide\lbentley_prod\prod_run_build\tools\fun_DeleteFiles\2015-09-24T21_56_10Z.ecl
*/
////////////////////////////////////////////////////////////////////////////
// -- fun_DeleteFiles() function
// -- Description:  This function find files(that are not in superfiles) on thor that match certain 
// --								criteria, and has an option to delete them.  You pass in two filter criteria, 
// --								one on the file owner, and the second on the filename.  This allows you to narrow 
// --								down the files to what you want.  
// --									Such as:
/*
Tools.fun_DeleteFiles(
	 pOwner								:= 'lbentley'			// regex to filter the file owner
	,pFilename						:= ''			// regex to filter the filenames
	,pCluster							:= ''			// regex to filter the cluster
	,pModified						:= ''			// regex to filter the modified time
	,pSizeMinimum					:= 0			// regex to filter by size
	,pPercentOfFiles    	:= 100.0	// Size Percentage of files you want returned.  For the total amount of files matched, it will sort descending and give you 100 percent of those file.  if you specify 90.0 it will only give you 90%.
	,pIsTesting						:= true		// If true	, just output the dataset of files matched
																	// If false	, output the dataset, and delete the files in the dataset 
  ,pDeletePatternfiles  := false 
	,pOutputLimit					:= 0			// Limit the amount of files returned
	,pIncludeNormalFiles	:= true		// If true,  return logical files 
	,pIncludeSuperFiles		:= false	// If true,  return super files 
	,pIncludeSubfiles		  := true	// If true,  return sub files 
);
*/
// -- 
// --								This will output a dataset of all of the files I own that match the '::persist::'
// --								regex that are not in superfiles.  If the dataset that was output to the workunit
// --								contains the files I want to delete, I simply change the last parameter from true to 
// -- 							false, then run it again, and it will delete those files.
////////////////////////////////////////////////////////////////////////////
#option ('globalAutoHoist', false);	// added because of bug 28526
#option('maxLength', 131072); 				// have to increase for the remote directory child datasets
import ut,wk_ut,WsDFU;

export fun_DeleteFiles(
	 string			pOwner							= ''		// regex to filter the file owner
	,string			pFilename						= ''		// regex to filter the filenames
	,string			pCluster						= ''		// regex to filter the cluster
	,string			pModified						= ''		// regex to filter the modified time
	,unsigned8	pSizeMinimum				= 0			// regex to filter by size
	,unsigned8	pSizeMaximum    		= 0			// regex to filter by size
	,real8    	pPercentOfFiles    	= 100.0	// Size Percentage of files you want returned.  For the total amount of files matched, it will sort descending and give you 100 percent of those file.  if you specify 90.0 it will only give you 90%.
	,boolean		pIsTesting					= true	// If true	, just output the dataset of files matched
																				// If false	, output the dataset, and delete the files in the dataset 
  ,boolean    pDeletePatternfiles = false 
	,unsigned		pOutputLimit				= 0			// Limit the amount of files returned
	,boolean		pIncludeNormalFiles	= true	// If true,  return logical files 
	,boolean		pIncludeSuperFiles	= false	// If true,  return super files 
	,boolean		pIncludeSubfiles		= false	// If true,  return sub files 
) :=
function

  lowner := powner;
  
  file_list          := wk_ut.get_DFUQuery(,pCluster,pOwner := lowner,pFirstN := 300000).largest;  //hack

	file_list2				 := fileservices.LogicalFileList(includenormal := pIncludeNormalFiles,includesuper := pIncludeSuperFiles);
	
	owner_filter						:= if(pOwner 				!= '', regexfind(pOwner			, file_list.owner		    , nocase), true);
	filename_filter					:= if(pFilename			!= '', regexfind(pFilename	, file_list.name		    , nocase), true);
	cluster_filter					:= if(pCluster			!= '', regexfind(pCluster		, file_list.ClusterName	, nocase), true);
	modified_filter					:= if(pModified			!= '', regexfind(pModified	, file_list.modified    , nocase), true);
	size_filter							:= if(pSizeMinimum	!= 0 , file_list.longsize >= pSizeMinimum						, true);
	size_max_filter				  := if(pSizeMaximum	!= 0 , file_list.longsize <= pSizeMaximum						, true);
	
	myfile_list1							:= file_list(owner_filter
																			,filename_filter
																			,cluster_filter
																			,modified_filter
																			,size_filter
                                      ,size_max_filter
																			);
  //get uncompressed file size
  myfile_list             := join(myfile_list1,file_list2 ,left.name = right.name,transform(recordof(left),self.longsize := right.size,self.realsize := if(left.realsize = 0,right.size,left.realsize),self := left),hash);
                                      
	myfile_list_notinsupers := myfile_list(fileservices.fileexists('~' + name), pIncludeSubfiles or count(fileservices.LogicalFileSuperOwners('~' + name)) = 0) ;	
  
  total_size := sum(myfile_list_notinsupers,realsize);
  
  myregex := '[[:digit:]]{8}(([-][[:digit:]]{6})|[[:alpha:]])?';
  
	largest									:= iterate(project(sort(myfile_list_notinsupers, -longsize),transform({string name,string sizepretty,unsigned realsize,string realsize_,real8 percent,unsigned8 running_total_size,string running_total_sizepretty,real8 running_total_percent,recordof(left) - name
    ,string name_pattern,string version,unsigned8 cnt_pattern := 0,unsigned8 pattern_size := 0,string pattern_size_pretty := ''}
                                ,self.sizepretty := ut.FHumanReadableSpace(left.longsize)
                                ,self.realsize    := left.realsize;
                                ,self.realsize_   := ut.FHumanReadableSpace(left.realsize)
                                ,self.percent := left.realsize / total_size * 100.0;
                                ,self.running_total_size := left.realsize
                                ,self.running_total_sizepretty := ''
                                ,self.running_total_percent := 0
                                ,self.name_pattern := if(regexfind(myregex,left.name,nocase)  ,regexreplace(myregex,left.name,'*',nocase), left.name)
                                ,self.version := if(regexfind(myregex,left.name,nocase)  ,regexfind(myregex,left.name,0), '')
                                ,self := left
                             )) 
                             ,transform(recordof(left),self.running_total_size := left.running_total_size + right.running_total_size,self.running_total_sizepretty := ut.FHumanReadableSpace(self.running_total_size),self.running_total_percent := self.running_total_size / total_size * 100.0,self := right))
                             
                             (running_total_percent <= pPercentOfFiles): independent;
  
  
  name_pattern_table := table(largest,{name_pattern,unsigned8 cnt := count(group),unsigned8 total_size := sum(group,longsize)},name_pattern,merge);
  
  patch_pattern := join(largest ,name_pattern_table,left.name_pattern = right.name_pattern,transform(recordof(left),self.cnt_pattern := right.cnt,self.pattern_size := right.total_size,self.pattern_size_pretty := ut.FHumanReadableSpace(right.total_size),self := left),hash)(cnt_pattern > 1);
  
  files_in_supers := patch_pattern(exists(fileservices.LogicalFileSuperOwners('~' + name)));
  
  patch_supers := join(patch_pattern,files_in_supers,left.name = right.name,transform({boolean IsSubfile,recordof(left)},self.IsSubfile := if(right.name != '',true,false),self := left),hash,left outer);
  
  patterns_for_deletion := patch_supers(IsSubfile = false,cnt_pattern > 3);
  
  total_size_pattern_deletes          := sum(patterns_for_deletion,realsize);
  total_size_pattern_deletes_readable := ut.FHumanReadableSpace(total_size_pattern_deletes);

  pattern_versions := sort(table(patterns_for_deletion,{version,unsigned8 cnt := count(group)},version),-version);

	filesfordeletion  := table(myfile_list_notinsupers(fileservices.FileExists('~' + name)), {name});
  total_cnt1         := count(filesfordeletion);
  files2delete      := project(filesfordeletion,transform({unsigned rid,string name,unsigned total_cnt},self.rid := counter,self := left,self.total_cnt := total_cnt1));
  
  import std;
	fdelete(string pname,unsigned cnt,unsigned ptotal_cnt) :=
	function
	
		return
    sequential(
		if(fileservices.SuperFileExists(pname)
			,Tools.mod_Utilities.removesuper	(pname,false)           //it is a superfile
			
      ,if(count(fileservices.LogicalFileSuperOwners(pname)) = 0
        
        ,Tools.mod_Utilities.DeleteLogical(pname)               //not a member of superfiles, just delete
        
        ,sequential(                                            //it is a member of superfile(s), clear it from them and then delete
           fileservices.StartSuperFileTransaction()
          ,apply(fileservices.LogicalFileSuperOwners(pname)   ,fileservices.RemoveSuperFile('~' + name, pName))
          ,fileservices.finishSuperFileTransaction()
          ,Tools.mod_Utilities.DeleteLogical(pname)
        )
      )
		)
    ,output(cnt,named('Number_Files_Deleted'),overwrite)
    ,STD.System.Log.addWorkunitInformation ('Number of files deleted so far: ' + (string)cnt + ' out of a total of ' + ptotal_cnt + ' files.')
    );
        
 		// return
		// if(fileservices.SuperFileExists(pname)
			// ,Tools.mod_Utilities.removesuper	(pname,false)
			// ,Tools.mod_Utilities.DeleteLogical(pname)
		// );
	
	
	end;
  
  // files2delete := if(pDeletePatternfiles  = true  ,global(table(patterns_for_deletion(fileservices.FileExists('~' + name)),{name}),few)  ,global(table(filesfordeletion(fileservices.FileExists('~' + name)),{name})  ,few));

  // ------------------------
  // -- examine skews
  // ------------------------
  lay_dfuparts := recordof(WsDFU.GetFileParts());
  
  add_Skews := project(largest,transform({recordof(largest),dataset(lay_dfuparts) DfuPartsInfo },
     self               := left                                       ;
     self.DfuPartsInfo  := WsDFU.GetFileParts('~' + left.name)  ;
  ));
  
 lay_skews := {largest.name,largest.sizepretty,largest.realsize,largest.realsize_,lay_dfuparts.diff_avg_,lay_dfuparts.minskew,lay_dfuparts.maxskew,lay_dfuparts.partsize_,lay_dfuparts.avg_part_size_  
  ,recordof(largest) -name - sizepretty - realsize - realsize_ or lay_dfuparts - diff_avg_ - minskew - maxskew - partsize_ - avg_part_size_}  ;
  
  
  add_skews_norm := normalize(add_skews,left.DfuPartsInfo,transform(lay_skews,self := left, self := right));
  
  // -- find out which nodes have most space used
  total_up_By_IP := table(add_skews_norm  ,{ip,id,unsigned8 Used_Space := sum(group,partsize_int),string used_space_ := ut.FHumanReadableSpace(sum(group,partsize_int)) } ,ip,id);
  top5_nodes_ := topn(total_up_By_IP  ,20,-Used_Space);
  
  // -- what files are contributing to the skew on those 5 nodes?
  join_back_2_files := join(add_skews_norm  ,total_up_By_IP,left.ip = right.ip and left.id = right.id,transform({recordof(left),unsigned8 used_space,string used_space_},self := left,self := right),lookup);
  // join_back_2_files := join(add_skews_norm  ,top5_nodes_,left.ip = right.ip and left.id = right.id,transform({recordof(left),unsigned8 used_space,string used_space_},self := left,self := right),lookup);
  
  // -- find out which files are contributing to the problem
  
  join_back_2_files_dedup := dedup(sort(join_back_2_files ,name,-above_the_min),name);
  // ------------------------
  // -- examine skews done
  // ------------------------

  // files2clearsupers := project(files2delete,transform(recordof(left),self.name := '~' + left.name));
  
  sum_largest := sum(largest, realsize) : independent;
  
	todo := sequential(
						 if(pOutputLimit = 0
              ,output(largest, all)
              ,output(choosen(largest,pOutputLimit), all)
						)
            ,output(sort(patch_supers(cnt_pattern > 3),-pattern_size, -cnt_pattern),named('Files_With_More_Than_3_Generations'),all)
            ,output(topn(join_back_2_files_dedup,100,-above_the_min)              ,named('Top_Heavily_Skewed_Files'),all)
						,output(sum_largest	,named('TotalSpaceUsed'))
						,output(ut.FHumanReadableSpace( sum_largest)	,named('TotalSpaceUsedPretty'))
            ,output(sort(patch_supers,-cnt_pattern, -pattern_size),named('SortPatternCount'),all)
            ,output(sort(patch_supers,-pattern_size, -cnt_pattern),named('SortPatternSize'),all)
            ,output(sort(patterns_for_deletion(cnt_pattern > 3),-pattern_size, -cnt_pattern),named('SortPatternSizeGT3GensForDeletion'),all)
            ,output(sort(patterns_for_deletion(cnt_pattern > 3),-version, name),named('SortPatternSizeGT3GensForDeletion_DescenVersion'),all)
            ,output(pattern_versions  ,named('Pattern_Deleted_Versions'),all )
            ,output(total_size_pattern_deletes_readable ,named('Total_Pattern_Size_To_Delete'))
            //,output(add_Skews ,named('add_Skews'),all)
            ,output(choosen(add_skews_norm,5000)   ,named('add_skews_norm'),all)
            ,output(total_up_By_IP                 ,named('total_up_By_IP'),all)
            ,output(top5_nodes_                    ,named('top5_nodes_'),all)
            ,output(choosen(join_back_2_files,300)              ,named('join_back_2_files'),all)
            ,output(topn(join_back_2_files,100,-diff_avg)              ,named('join_back_2_files_diff_avg'),all)
            ,output(topn(join_back_2_files,300,ip,-above_the_min)              ,named('join_back_2_files_ip'),all)
            // ,output(topn(join_back_2_files(ip = '10.241.60.1'),100,-above_the_min)              ,named('join_back_2_files_above_the_min'),all)
            
						,if(not pIsTesting
							,sequential(
								 // if(pIncludeSubfiles, fun_ClearfilesFromSupers(files2clearsupers  ,false))
								 // fun_ClearfilesFromSupers(global(files2clearsupers,few)  ,false)
								 // if(pIncludeSubfiles, nothor(fun_ClearfilesFromSupers(files2clearsupers  ,false)))
								nothor(apply(global(files2delete,few), fdelete('~' + name,rid,total_cnt)))  //works
							)
						)
					);
	return todo;
end;
/*
  get all files with a date or workunit in them
  then, replace that date with [[:digit:]]{8} or pattern for wuid [[:digit:]]{8}[-][[:digit:]]{6}
  then, do a table and sum up instances of that pattern(# of occurences and total space used for each)
  then, join #2 to #3 and pach # of occurences and total size to it.
  then you can sort that dataset decending by total_size and # of occurences to see what types of files do you have the most of
  
*/
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
