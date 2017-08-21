//Defines persist files that are used by throughout the build to 
//improve speed and make build itself restartable
import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	export Root := _Dataset(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Dataset().Name;
	
	//export AsBusinessHeader				:= root + '::As_Business_Header'		;
	//export AsBusinessContact			:= root + '::As_Business_Contact'		;
	export AsPOE									:= root + '::As_POE'		;
	export AppendAID									:= root + '::Append_Aid'		;
	export GetUidPatterns					:= root + '::Get_UID_Patterns_In_Email'	;	
	//export AttachBestBDIDAddrPh		:= root + '::Attach_Best_BDID_Addr_Ph_2Emails'	;	
	export AddDomainBDID2Emails		:= root + '::Add_Domain_BDID_2Eamils_With_Patterns';

	export All := dataset([
	/*	 {AsBusinessHeader			}
		,{AsBusinessContact			}		
	*/
		{AsPOE			}
		,{GetUidPatterns		}
		,{AddDomainBDID2Emails	}	
		,{AppendAID}
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;