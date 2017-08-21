import lib_fileservices;
export Persistnames :=
module
	
	shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export AppendIdsDid				:= root + 'Append_Ids::Did'					;
	export AppendIdsBdid			:= root + 'Append_Ids::Bdid'				;
	export AsBusinessHeader		:= root + 'AMS_As_Business_Header'	;
	export AsBusinessContact	:= root + 'AMS_As_Business_Contact';
                            

		export All := dataset([
		 {AppendIdsDid			}
		,{AppendIdsBdid			}
		,{AsBusinessHeader	}
		,{AsBusinessContact	}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;