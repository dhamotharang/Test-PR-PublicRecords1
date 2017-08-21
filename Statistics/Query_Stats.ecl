export Query_Stats(

	 dataset(Layouts.standard_stat_out) pStatFiles
	,string															pBuild_Name_Filter												= ''
	,string															pVersion_Filter														= ''
	,string															pBuild_Subset_Filter											= ''
	,string															pBuild_View_Filter												= ''
	,string															pBuild_Type_Filter												= ''
        
) := 
function

	lBuild_Name_Filter													:= if(pBuild_Name_Filter												= '', true, regexfind(pBuild_Name_Filter											,pStatFiles.Build_Name											,nocase));									
	lVersion_Filter													    := if(pVersion_Filter														= '' or pVersion_Filter	= 'latest', true, regexfind(pVersion_Filter													,pStatFiles.version													,nocase));
	lBuild_Subset_Filter										    := if(pBuild_Subset_Filter											= '', true, regexfind(pBuild_Subset_Filter										,pStatFiles.Build_Subset										,nocase));
	lBuild_View_Filter											    := if(pBuild_View_Filter												= '', true, regexfind(pBuild_View_Filter											,pStatFiles.Build_View											,nocase));
	lBuild_Type_Filter											    := if(pBuild_Type_Filter												= '', true, regexfind(pBuild_Type_Filter											,pStatFiles.Build_Type											,nocase));
                                                                                                           
	pStatFiles_filtered := pStatFiles(
	
		 lBuild_Name_Filter											
		,lVersion_Filter													
		,lBuild_Subset_Filter										
		,lBuild_View_Filter											
		,lBuild_Type_Filter											
	
	);

	pStatFiles_filtered_dedup := if(pVersion_Filter	= 'latest'
		,dedup(sort(pStatFiles_filtered, Build_Name,Build_Subset,Build_View,Build_Type, -version), Build_Name,Build_Subset,Build_View,Build_Type)
		,pStatFiles_filtered
	);

	return output(pStatFiles_filtered_dedup,all);

end;