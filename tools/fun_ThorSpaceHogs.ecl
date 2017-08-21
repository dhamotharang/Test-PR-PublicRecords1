// for all users, it takes about 13 minutes to complete
#option('maxLength', 131072); 				// have to increase for the remote directory child datasets
import ut,std;
export fun_ThorSpaceHogs(
	 string		pOwner				= ''		// regex to filter the file owner
	,string		pCluster			= ''		// regex to filter the cluster
) :=
function

	file_orig_list	:= std.file.LogicalFileList					() : independent;
//	file_sub_list		:= std.file.LogicalFileSuperSubList	() : independent; //this takes too long.  it is much faster to take the above dataset and check each file for superowners below.

//from Danny to make this faster
FsLogicalSuperSubRecordBig := record
   string supername{maxlength(4096)};
   string subname{maxlength(4096)};
end;

MyFileServices := SERVICE
  dataset(FsLogicalSuperSubRecordBig) LogicalFileSuperSubListBig() :  library='plugins/libfileservices', c,context,entrypoint='fsLogicalFileSuperSubList';
END;

file_sub_list     :=  MyFileServices.LogicalFileSuperSubListBig() : independent;

		
	owner_filter						:= if(pOwner 		!= '', regexfind(pOwner			, file_orig_list.owner		, nocase), true);
	cluster_filter					:= if(pCluster	!= '', regexfind(pCluster		, file_orig_list.cluster	, nocase), true);
	
	file_list := table(file_orig_list(owner_filter,cluster_filter), {string100 owner := file_orig_list.owner, file_orig_list.size, file_orig_list.name});

//	file_sub_list := file_list(not regexfind('([^:]:[^:]|::::|[/])',name,nocase),not regexfind('^.*?::$',name,nocase),std.file.fileexists('~' + trim(name,all)),count(std.file.LogicalFileSuperOwners('~' + trim(name,all))) = 0)  : independent;

	mytablelayout :=
	record
		string100 owner := file_list.owner;
		unsigned8 Total_file_sizes := sum(group, file_list.size);
	end;
	
	mytable := table(file_list, mytablelayout, owner, few) : independent;
	
//    file_list2 := file_sub_list;
file_list2 := join(file_list
                  ,file_sub_list
                  ,left.name = right.subname
                  ,transform(recordof(file_list), self := left)
                  ,left only
              );
	
	mytablelayout2 :=
	record
		string100 owner := file_list2.owner;
		unsigned8 Total_file_sizes := sum(group, file_list2.size);
	end;
	// mytable2 := table(file_list2, mytablelayout2, owner, few) : independent;
	mytable2 := dataset([], mytablelayout2) ;
  
  statslay := 
  record
    unsigned8 size		      := 0;
		string    size_Pretty		:= '';
    real8     size_Percent  := 0.0;
  end;
  
	myjoinlayout :=
	record
		string100 owner                       := '' ;
    statslay  total_space                       ;
    statslay  total_not_in_supers_space         ;
    statslay  Running_total_space               ;
    statslay  Running_total_not_in_supers_space ;
    unsigned8 Total_size_of_all_files                ;
    unsigned8 Total_size_of_all_files_not_in_supers           ;
    string Total_size_of_all_files_pretty                ;
    string Total_size_of_all_files_not_in_supers_pretty           ;
 	end;
  
  total_file_space          := sum(mytable ,Total_file_sizes);
  total_not_in_supers_space := sum(mytable2,Total_file_sizes);

	myjoinlayout tjointhem(mytablelayout l, mytablelayout2 r) :=
	transform
		self.Total_Space.size		                            := l.Total_file_sizes;
		self.Total_Space.size_Pretty	                      := ut.FHumanReadableSpace(l.Total_file_sizes);
		self.Total_Space.size_Percent                       := l.Total_file_sizes / total_file_space * 100.0;
		self.total_not_in_supers_space.size		    	        := r.Total_file_sizes;
		self.total_not_in_supers_space.size_Pretty          := ut.FHumanReadableSpace(r.Total_file_sizes);
		self.total_not_in_supers_space.size_Percent	        := r.Total_file_sizes / total_not_in_supers_space * 100.0;
		self.Running_total_space.size		    	              := l.Total_file_sizes;
		self.Running_total_space.size_Pretty                := ut.FHumanReadableSpace(l.Total_file_sizes);
		self.Running_total_space.size_Percent	              := 0.0;
		self.Running_total_not_in_supers_space.size		    	:= r.Total_file_sizes;
		self.Running_total_not_in_supers_space.size_Pretty  := ut.FHumanReadableSpace(r.Total_file_sizes);
		self.Running_total_not_in_supers_space.size_Percent	:= 0.0;
    self.Total_size_of_all_files                        := total_file_space        ; 
    self.Total_size_of_all_files_not_in_supers          := total_not_in_supers_space;
    self.Total_size_of_all_files_pretty                 := ut.FHumanReadableSpace(total_file_space        ); 
    self.Total_size_of_all_files_not_in_supers_pretty   := ut.FHumanReadableSpace(total_not_in_supers_space);
		self                                                := l;
	end;
	myjoin := join(mytable
								,mytable2
								,left.owner = right.owner
								,tjointhem(left,right)
								,left outer
						);
  dsort := sort(myjoin,-total_not_in_supers_space.size);
  diterate := iterate(dsort,transform(recordof(left)
    ,self.Running_total_space.size                        := left.Running_total_space.size + right.Running_total_space.size
    ,self.Running_total_space.size_Pretty                 := ut.FHumanReadableSpace(self.Running_total_space.size)
    ,self.Running_total_space.size_Percent                := self.Running_total_space.size / total_file_space * 100.0
    ,self.Running_total_not_in_supers_space.size          := left.Running_total_not_in_supers_space.size + right.Running_total_not_in_supers_space.size
    ,self.Running_total_not_in_supers_space.size_Pretty   := ut.FHumanReadableSpace(self.Running_total_not_in_supers_space.size)
    ,self.Running_total_not_in_supers_space.size_Percent  := self.Running_total_not_in_supers_space.size / total_not_in_supers_space * 100.0
    ,self := right
  ));
  
  dsort2 := sort(myjoin,-total_space.size);
  diterate2 := iterate(dsort2,transform(recordof(left)
    ,self.Running_total_space.size                        := left.Running_total_space.size + right.Running_total_space.size
    ,self.Running_total_space.size_Pretty                 := ut.FHumanReadableSpace(self.Running_total_space.size)
    ,self.Running_total_space.size_Percent                := self.Running_total_space.size / total_file_space * 100.0
    ,self.Running_total_not_in_supers_space.size          := left.Running_total_not_in_supers_space.size + right.Running_total_not_in_supers_space.size
    ,self.Running_total_not_in_supers_space.size_Pretty   := ut.FHumanReadableSpace(self.Running_total_not_in_supers_space.size)
    ,self.Running_total_not_in_supers_space.size_Percent  := self.Running_total_not_in_supers_space.size / total_not_in_supers_space * 100.0
    ,self := right
  ));

	return parallel(output(diterate,named('SortedByNotInSupersSpace'), all),output(diterate2,named('SortedByTotalSpace'), all));
end;
