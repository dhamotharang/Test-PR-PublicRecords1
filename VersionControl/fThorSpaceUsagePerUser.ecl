// for all users, it takes about 1 hour 40 minutes to complete

export fThorSpaceUsagePerUser(

	 string		pOwner				= ''		// regex to filter the file owner
	,string		pCluster			= ''		// regex to filter the cluster

) :=
function

	file_orig_list	:= fileservices.LogicalFileList					();
	file_sub_list		:= fileservices.LogicalFileSuperSubList	();
		
	owner_filter						:= if(pOwner 		!= '', regexfind(pOwner			, file_orig_list.owner		, nocase), true);
	cluster_filter					:= if(pCluster	!= '', regexfind(pCluster		, file_orig_list.cluster	, nocase), true);
	
	file_list := table(file_orig_list(owner_filter,cluster_filter), {string100 owner := file_orig_list.owner, file_orig_list.size, file_orig_list.name});

	mytablelayout :=
	record

		string100 owner := file_list.owner;
		unsigned8 Total_file_sizes := sum(group, file_list.size);

	end;
	
	mytable := table(file_list, mytablelayout, owner, few);

	
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

	mytable2 := table(file_list2, mytablelayout2, owner, few);

	myjoinlayout :=
	record

		string100 owner := '';
		unsigned8 Total_Space_Usage		:= 0;
		unsigned8 Total_Not_In_Supers := 0;

	end;


	myjoinlayout tjointhem(mytablelayout l, mytablelayout2 r) :=
	transform
		self.Total_Space_Usage		:= l.Total_file_sizes;
		self.Total_Not_In_Supers	:= r.Total_file_sizes;
		self := l;

	end;

	myjoin := join(mytable
								,mytable2
								,left.owner = right.owner
								,tjointhem(left,right)
								,left outer
						);
						
	return output(myjoin, all);

end;