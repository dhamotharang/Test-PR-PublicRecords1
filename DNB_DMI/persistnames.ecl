import lib_fileservices;
export Persistnames(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Constants().Name;
	
	export AppendCompanyDates		:= root + '::Append_Company_Dates'		;
	export AppendAID						:= root + '::Append_AID'							;
	export AsBusinessHeader			:= root + '::As_Business_Header'			;		
	export AsBusinessContact		:= root + '::As_Business_Contact'			;
	export AppendIdsfAppendDid	:= root + '::Append_Ids.fAppendDid'		;		
	export AppendIdsfAppendBdid	:= root + '::Append_Ids.fAppendBdid'	;
	export AppendCompanyInfo		:= root + '::Append_Company_Info'			;
	export IngestCompanies			:= root + '::Ingest_Companies'				;
	export IngestContacts				:= root + '::Ingest_Contacts'					;
	export PrepFile							:= root + '::Prep_File'								;
	export FileCompaniesV1Input	:= root + '::File_Companies_V1_Input'	;
	export FileContactsV1Input	:= root + '::File_Contacts_V1_Input'	;
	export DUNSToUltimateDUNS		:= root + '::DUNS_To_Ultimate_DUNS'		;

	export All := dataset([
		 {AppendCompanyDates		}
		,{AppendAID							}
		,{AsBusinessHeader			}
		,{AsBusinessContact			}
		,{AppendIdsfAppendDid		}
		,{AppendIdsfAppendBdid	}
		,{AppendCompanyInfo			}
		,{IngestCompanies				}
		,{IngestContacts				}
		,{PrepFile							}
		,{FileCompaniesV1Input	}
		,{FileContactsV1Input		}
		,{DUNSToUltimateDUNS		}
		
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;

