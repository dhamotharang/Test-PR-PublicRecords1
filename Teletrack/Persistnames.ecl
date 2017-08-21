//Defines persist files that are used by throughout the build to 
//improve speed and make build itself restartable
import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	export Root := _Dataset(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Dataset().Name;
	
	export StandardizeTeletrack		:= root + '::standardize_Teletrack'	;
	export AsBusinessHeader				:= root + '::As_Business_Header'		;
	export AsBusinessContact			:= root + '::As_Business_Contact'		;
	export AsPOE									:= root + '::As_POE'								;
	export AppendIdsfAppendDid		:= root + '::Append_Ids.fAppendDid'	;	
	export AppendIdsfAppendBdid		:= root + '::Append_Ids.fAppendBdid';
	
	export All := dataset([
		 {StandardizeTeletrack	}
		,{AsBusinessHeader			}
		,{AsBusinessContact			}
		,{AsPOE									}
		,{AppendIdsfAppendDid		}
		,{AppendIdsfAppendBdid	}
	 ], lib_fileservices.FsLogicalFileNameRecord);
	
end;