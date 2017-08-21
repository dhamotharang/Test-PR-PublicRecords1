import lib_fileservices;
export Persistnames :=
module
	
	export Root 								:= _Dataset.Thor_Cluster_Persists + 'persist::' + _Dataset.Name;
	
	export StandardizeCA 				:= root + '::standardize_CA'					;
	export StandardizeCT 				:= root + '::standardize_CT'					;
	export StandardizeIN 				:= root + '::standardize_IN'					;
	export StandardizeLA 				:= root + '::standardize_LA'					;
	export StandardizeOH 				:= root + '::standardize_OH'					;
	export StandardizePA 				:= root + '::standardize_PA'					;
	export StandardizeTX 				:= root + '::standardize_TX'					;
	export AsBusinessHeaderCA		:= root + '::As_Business_Header::CA'	;
	export AsBusinessHeaderCT		:= root + '::As_Business_Header::CT'	;
	export AsBusinessHeaderIN		:= root + '::As_Business_Header::IN'	;
	export AsBusinessHeaderLA		:= root + '::As_Business_Header::LA'	;
	export AsBusinessHeaderOH		:= root + '::As_Business_Header::OH'	;
	export AsBusinessHeaderPA		:= root + '::As_Business_Header::PA'	;
	export AsBusinessHeaderTX		:= root + '::As_Business_Header::TX'	;
	export AsBusinessContactCA	:= root + '::As_Business_Contact::CA'	;
	export AsBusinessContactCT	:= root + '::As_Business_Contact::CT'	;
	export AsBusinessContactIN	:= root + '::As_Business_Contact::IN'	;
	export AsBusinessContactLA	:= root + '::As_Business_Contact::LA'	;
	export AsBusinessContactOH	:= root + '::As_Business_Contact::OH'	;
	export AsBusinessContactPA	:= root + '::As_Business_Contact::PA'	;
	export AsBusinessContactTX	:= root + '::As_Business_Contact::TX'	;


	export All := dataset([
		 {StandardizeCA 			}
		,{StandardizeCT 			}
		,{StandardizeIN 			}
		,{StandardizeLA 			}
		,{StandardizeOH 			}
		,{StandardizePA 			}
		,{StandardizeTX 			}
		,{AsBusinessHeaderCA	}
		,{AsBusinessHeaderCT	}
		,{AsBusinessHeaderIN	}
		,{AsBusinessHeaderLA	}
		,{AsBusinessHeaderOH	}
		,{AsBusinessHeaderPA	}
		,{AsBusinessHeaderTX	}
		,{AsBusinessContactCA	}
		,{AsBusinessContactCT	}
		,{AsBusinessContactIN	}
		,{AsBusinessContactLA	}
		,{AsBusinessContactOH	}
		,{AsBusinessContactPA	}
		,{AsBusinessContactTX	}
      
	], lib_fileservices.FsLogicalFileNameRecord);
	
end;