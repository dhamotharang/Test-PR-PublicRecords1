import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Constants().Name;
	
	export StandardizeInput			:= root + '::standardize_Input'			;
	export AsPOE								:= root + '::As_POE'								;
	export AsBusinessHeader			:= root + '::As_Business_Header'		;
	export AsBusinessContact		:= root + '::As_Business_Contact'		;
	export AsBusinessLinking    := root + '::As_Business_Linking'		;
	export AppendIdsfAppendDid	:= root + '::Append_Ids.fAppendDid'	;	
	export AppendIdsfAppendBdid	:= root + '::Append_Ids.fAppendBdid';
	export AppendCompanyInfo		:= root + '::Append_Company_Info'		;
	export dall_filenames := dataset([

		 {StandardizeInput			}
		,{AsPOE									}
		,{AsBusinessHeader			}
		,{AsBusinessContact			}
		,{AsBusinessLinking     }
		,{AppendIdsfAppendDid		}
		,{AppendIdsfAppendBdid	}
		,{AppendCompanyInfo			}

		], lib_fileservices.FsLogicalFileNameRecord);
	
end;