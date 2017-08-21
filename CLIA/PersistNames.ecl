IMPORT lib_fileservices;

EXPORT Persistnames := MODULE

	SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

	EXPORT AppendIdsBdid		 := root + 'Append_Ids::Bdid';
	EXPORT AppendIdsLNpid		 := root + 'Append_Ids::LNpid';


	EXPORT All := DATASET([
		                     {AppendIdsBdid}
	                      ], lib_fileservices.FsLogicalFileNameRecord);

END;