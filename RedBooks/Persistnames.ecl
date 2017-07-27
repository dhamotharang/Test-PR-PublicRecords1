import lib_fileservices;
export Persistnames :=
module
	
	export Root 								:= _Dataset.Thor_Cluster_Persists + 'persist::' + _Dataset.Name;
	
	export StandardizeCombined 				:= root + '::Standardize_Combined'					  ;
	export AsBusinessHeaderCombined		:= root + '::As_Business_Header::Combined'	  ;
	export AsBusinessContactCombined 	:= root + '::As_Business_Contact::Combined'	;
	

	export All := dataset([
		 {StandardizeCombined 			}
		,{AsBusinessHeaderCombined	}
		,{AsBusinessContactCombined	}
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;