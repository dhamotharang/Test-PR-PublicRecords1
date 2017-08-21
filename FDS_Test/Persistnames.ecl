import lib_fileservices;
export Persistnames(

	boolean puseotherenvironment = false

) :=
module
	
	shared root := _Dataset(puseotherenvironment).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export ConsumerStandardizeInput		:= root + 'Consumer_Standardize_Input'	;
	export ConsumerAppendIds					:= root + 'Consumer_Append_Ids'					;
                            

	export All := dataset([
		 {ConsumerStandardizeInput	}
		,{ConsumerAppendIds					}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;