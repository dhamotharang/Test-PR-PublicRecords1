import lib_fileservices;
export Persistnames :=
module
	
	export Root := _Dataset.Thor_Cluster_Persists + 'persist::' + _Dataset.Name;
	
	export StandardizeNJ := root + '::standardize_NJ';
	export AsBusinessHeaderNJ := root + '::As_Business_Header::NJ'	;
	export AsBusinessContactNJ	:= root + '::As_Business_Contact::NJ';
	export AppendIdsDidNJ := root + '::AppendIDsDid::NJ';	
	export AppendIdsBdidNJ := root + '::AppendIDsBDid::NJ';

	export All := dataset([
		 {StandardizeNJ			}
		,{AsBusinessHeaderNJ	}
		,{AsBusinessContactNJ	}
		,{AppendIdsDidNJ	}
		,{AppendIdsBdidNJ	}
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;