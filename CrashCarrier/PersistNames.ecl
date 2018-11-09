IMPORT lib_fileservices;

EXPORT Persistnames := MODULE

	export root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().pName + '::';

	export AppendIds		 				:= root + 'append_Ids::bdid'			;
	export StandardizeInput			:= root + 'standardizeinputfile'  ;
	export StandardizeNameAddr	:= root + 'standardize_nameaddr'	;
	

	EXPORT All := DATASET([
													 {StandardizeInput			}
													,{StandardizeNameAddr   }
													,{AppendIds	}
	                      ] , lib_fileservices.FsLogicalFileNameRecord);

END;