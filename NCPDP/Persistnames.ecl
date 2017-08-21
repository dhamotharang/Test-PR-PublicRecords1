IMPORT lib_fileservices;

EXPORT Persistnames := MODULE

   SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().Name + '::';

   EXPORT StandardizeInput  := root + 'Standardize_Input';
   EXPORT UpdateBase        := root + 'Update_Base';
   EXPORT AppendIdsBdid     := root + 'Append_Ids::Bdid';
	 EXPORT AsBusinessHeader  := root + 'As_Business_Header';
	 EXPORT AsBusinessContact	:= root + 'As_Business.Contact';

	 EXPORT All := DATASET([{StandardizeInput}
                          ,{UpdateBase}
                          ,{AppendIdsBdid}
			                    ,{AsBusinessHeader}
                         ], lib_fileservices.FsLogicalFileNameRecord);

END;
