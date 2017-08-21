import lib_fileservices;
export Persistnames(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	
	export Root := _Dataset(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Dataset().Name;
	
	export StandardizeInput			:= root + '::standardize_Input'			;
	export AsPOE								:= root + '::As_POE'								;
	export AsBusinessHeader			:= root + '::As_Business_Header'		;
	export AsBusinessContact		:= root + '::As_Business_Contact'		;
	export AppendIdsfAppendDid	:= root + '::Append_Ids.fAppendDid'	;	
	export AppendIdsfAppendBdid	:= root + '::Append_Ids.fAppendBdid';
	export AppendIdsfAppendBid	:= root + '::Append_Ids.fAppendBid'	;
	export AppendCompanyInfo		:= root + '::Append_Company_Info'		;
	export ImproveBdids					:= root + '::Improve_Bdids'					;
	
	export All := dataset([
		 {StandardizeInput			}
		,{AsPOE									}
		,{AsBusinessHeader			}
		,{AsBusinessContact			}
		,{AppendIdsfAppendDid		}
		,{AppendIdsfAppendBdid	}
		,{AppendIdsfAppendBid		}
		,{AppendCompanyInfo			}
		,{ImproveBdids					}
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;

