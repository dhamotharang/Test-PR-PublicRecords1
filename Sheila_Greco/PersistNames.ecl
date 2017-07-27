import lib_fileservices;
export Persistnames :=
module
	
	shared root := _Dataset.thor_cluster_Persists + 'persist::' + _Dataset.name + '::';
	
	export ParseInput :=
	module
	
		export Companies	:= root + 'Parse_Input::Companies';
		export Contacts		:= root + 'Parse_Input::Contacts'	;
	
	end;

	export ParsedContacts			      	:= root + 'ParsedContacts'					 ;
	export StandardizeContNameDates	 	:= root + 'StandardizeContNameDates' ;
	export PreppedContacts        	 	:= root + 'PreppedContacts' ;
	
	export StandardizeCompanies				:= root + 'Standardize_Companies'					;
	export StandardizeContacts				:= root + 'Standardize_Contacts'					;

	export AsBusinessHeader						:= root + 'As_Business_Header'	;
	export AsBusinessContact					:= root + 'As_Business_Contact'	;

		export All := dataset([
		 {ParseInput.Companies				}
		,{ParsedContacts              }
		,{StandardizeContNameDates    }
		,{PreppedContacts    }
		,{ParseInput.Contacts 				}
		,{StandardizeCompanies				}
		,{StandardizeContacts					}
		,{AsBusinessHeader						}
		,{AsBusinessContact						}
		    
	], lib_fileservices.FsLogicalFileNameRecord);


end;