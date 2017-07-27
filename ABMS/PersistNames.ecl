IMPORT lib_fileservices;

EXPORT PersistNames := MODULE

	SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

	EXPORT AppendIdsDid	   := root + 'Append_Ids::Did';
	EXPORT AppendIdsBdid   := root + 'Append_Ids::Bdid';

	EXPORT All := DATASET([
												  {AppendIdsDid}
												 ,{AppendIdsBdid}
												], lib_fileservices.FsLogicalFileNameRecord);

END;