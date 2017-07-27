IMPORT lib_fileservices;

EXPORT PersistNames := MODULE

	SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

	EXPORT AppendIdsDid	 := root + 'Append_Ids::Did';

	EXPORT All := DATASET([
												  {AppendIdsDid}
												], lib_fileservices.FsLogicalFileNameRecord);

END;