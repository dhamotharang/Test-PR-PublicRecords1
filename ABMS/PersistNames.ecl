IMPORT lib_fileservices;

EXPORT PersistNames := MODULE

	SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

	EXPORT AppendIdsDid	   := root + 'Append_Ids::Did';
	EXPORT AppendIdsBdid   := root + 'Append_Ids::Bdid';
  EXPORT AppendIdsLnpid  := root + 'Append_Ids::Lnpid';
	EXPORT All := DATASET([
												  {AppendIdsDid}
												 ,{AppendIdsBdid}
												 ,{AppendIdsLnpid}
												], lib_fileservices.FsLogicalFileNameRecord);

END;