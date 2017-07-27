import lib_fileservices;
export Persistnames(

	boolean pUseOtherEnvironment = false

) :=
module
	
	shared root := _Dataset(pUseOtherEnvironment).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export StandardizeOldFile	:= root + 'Standardize_Old_File'		;
	export StandardizeInput		:= root + 'Standardize_Input'				;
	export UpdateBase					:= root + 'Update_Base'							;
	export AppendIdsDid				:= root + 'Append_Ids::Did'					;
	export AppendIdsBdid			:= root + 'Append_Ids::Bdid'				;
	export AsBusinessHeader		:= root + 'Busreg_As_Business_Header'	;
	export AsBusinessContact	:= root + 'Busreg_As_Business_Contact';
	export AsBusinessLinking	:= root + 'Busreg_As_Business_Linking';
                            

		export All := dataset([
		 {StandardizeInput	}
		,{StandardizeOldFile}
		,{UpdateBase				}
		,{AppendIdsDid			}
		,{AppendIdsBdid			}
		,{AsBusinessHeader	}
		,{AsBusinessContact	}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;