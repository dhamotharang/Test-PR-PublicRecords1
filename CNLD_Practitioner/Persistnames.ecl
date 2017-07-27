IMPORT lib_fileservices;

EXPORT Persistnames := MODULE

   SHARED root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().Name + '::';

   EXPORT StandardizeInput  := root + 'Standardize_Input';
   EXPORT UpdateBase        := root + 'Update_Base';
   EXPORT AppendIdsDID	    := root + 'Append_Ids::DID';
	 EXPORT AsBusinessHeader  := root + 'As_Business_Header';
	 EXPORT AsBusinessContact	:= root + 'As_Business.Contact';

	 EXPORT All := DATASET([{StandardizeInput}
                          ,{UpdateBase}
                          ,{AppendIdsBdid}
			                    ,{AsBusinessHeader}
                         ], lib_fileservices.FsLogicalFileNameRecord);

END;