import lib_fileservices;
export Persistnames :=
module
	
	shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export StandardizeInput		:= root + 'Standardize_Input'				;
	export UpdateBase					:= root + 'Update_Base'							;
	export AppendIdsDid				:= root + 'Append_Ids::Did'					;
	export AppendIdsBdid			:= root + 'Append_Ids::Bdid'				;
	export AsBusinessHeader		:= root + 'Zoom_As_Business_Header'	;
	export AsBusinessContact	:= root + 'Zoom_As_Business_Contact';
	export AsBusinessLinking	:= root + 'Zoom_As_Business_Linking';	
                            

		export All := dataset([
		 {StandardizeInput	}
		,{UpdateBase				}
		,{AppendIdsDid			}
		,{AppendIdsBdid			}
		,{AsBusinessHeader	}
		,{AsBusinessContact	}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;