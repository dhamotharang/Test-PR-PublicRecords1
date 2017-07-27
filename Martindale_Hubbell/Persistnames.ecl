import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	shared root := _Dataset(pUseOtherEnvironment).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export ParseInput :=
	module
	
		export Organizations						:= root + 'Parse_Input.Organizations'							;
		export AffiliatedIndividuals		:= root + 'Parse_Input.Affiliated_Individuals'		;
		export UnaffiliatedIndividuals	:= root + 'Parse_Input.Unaffiliated_Individuals'	;
	
	end;
	
	export StandardizeOrganizations						:= root + 'Standardize_Organizations'						;
	export StandardizeAffiliatedIndividuals		:= root + 'Standardize_Affiliated_Individuals'	;
	export StandardizeUnaffiliatedIndividuals	:= root + 'Standardize_Unaffiliated_Individuals';

	export AsBusinessHeader		:= root + 'As_Business_Header'	;
	export AsBusinessContact	:= root + 'As_Business_Contact'		;

		export All := dataset([
		 {ParseInput.Organizations						}
		,{ParseInput.AffiliatedIndividuals		}
		,{ParseInput.UnaffiliatedIndividuals	}
		,{StandardizeOrganizations						}
		,{StandardizeAffiliatedIndividuals		}
		,{StandardizeUnaffiliatedIndividuals	}
		,{AsBusinessHeader			}
		,{AsBusinessHeader			}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;