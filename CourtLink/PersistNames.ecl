import lib_fileservices;
export Persistnames := module
   
	shared root					:= _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
   
	export StandardizeInput		:= root + 'Standardize_Input_new';
	export UpdateBase			:= root + 'Update_Base';
	export AppendIdsDid			:= root + 'Append_Ids::Did';
	export AppendIdsBdid		:= root + 'Append_Ids::Bdid';
	export All 					:= dataset([
											{StandardizeInput}
											,{UpdateBase}
											,{AppendIdsDid}
											,{AppendIdsBdid}
											], lib_fileservices.FsLogicalFileNameRecord);
end;