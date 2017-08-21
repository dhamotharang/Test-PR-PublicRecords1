import lib_fileservices;

export Persistnames := module
   
   shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

   export StandardizeInputCert:= root + 'Standardize_Input::Certification';
	 export StandardizeInputPol := root + 'Standardize_Input::Policy';
   export UpdateBaseCert      := root + 'Update_Base::Certification';
	 export UpdateBasePol       := root + 'Update_Base::Policy';
   export AppendIdsDid        := root + 'Append_Ids::Did';
   export AppendIdsBdid       := root + 'Append_Ids::Bdid';
	 export AsBusinessHeader		:= root + 'As_Business_Header';
	 export AsBusinessContact	  := root + 'As_Business_Contact';

	 export All := dataset([
       {StandardizeInputCert}
			,{StandardizeInputPol}
      ,{UpdateBaseCert}
			,{UpdateBasePol}
      ,{AppendIdsDid}
      ,{AppendIdsBdid}
			,{AsBusinessHeader}
   ], lib_fileservices.FsLogicalFileNameRecord);

end;
