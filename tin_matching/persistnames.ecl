import lib_fileservices;
export Persistnames(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Constants().Name;
	
	export PrepFile			:= root + '::Prep_File'		;
	export AppendAID		:= root + '::Append_AID'	;
	export AppendBdid		:= root + '::Append_Bdid'	;		
	export Ingestp			:= root + '::Ingest'			;		
	
	export All := dataset([
		 {PrepFile		}
		,{AppendAID		}
		,{AppendBdid	}
		,{Ingestp		}
		
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;
