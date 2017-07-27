import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Constants().Name;
	
	export StandardizeInputCC		:= root + '::standardize_Input_CC'	;
	export StandardizeInputRSIH	:= root + '::standardize_Input_RSIH';
	export AsBusinessHeader			:= root + '::As_Business_Header'		;
	export AsBusinessContact		:= root + '::As_Business_Contact'		;
	export AppendIdsfAppendDid	:= root + '::Append_Ids.fAppendDid'	;	
	export AppendIdsfAppendBdid	:= root + '::Append_Ids.fAppendBdid';
	export AppendCompanyInfo		:= root + '::Append_Company_Info'		;

	export dall_filenames := dataset([

		 {StandardizeInputCC		}
		,{StandardizeInputRSIH	}
		,{AsBusinessHeader			}
		,{AsBusinessContact			}
		,{AppendIdsfAppendDid		}
		,{AppendIdsfAppendBdid	}
		,{AppendCompanyInfo			}

		], lib_fileservices.FsLogicalFileNameRecord);
	
end;