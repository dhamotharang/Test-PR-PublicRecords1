import lib_fileservices;

export Persistnames := module
   
   shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

   export StandardizeInput    := root + 'Standardize_Input';
   export UpdateBase          := root + 'Update_Base';
   export AppendIdsBdid       := root + 'Append_Ids::Bdid';
	 export AsBusinessHeader		:= root + 'As_Business_Header';
	 export AsBusinessContact	  := root + 'As_Business.Contact';
	 export AsBusinessLinking		:= root + 'As_Business_Linking';

	 export All := dataset([
       {StandardizeInput}
      ,{UpdateBase}
      ,{AppendIdsBdid}
			,{AsBusinessHeader}
			,{AsBusinessLinking}
   ], lib_fileservices.FsLogicalFileNameRecord);

end;
