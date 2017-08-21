import tools, corp;

export Proc_Build_BaseFiles(
	 string																				    pversion
	,boolean																			    pShouldDesprayCorpLogs	= true  
	,boolean																					pMoveFiles							= true
) :=
module

	export files_processed  := Corp2.List_Using(pversion,pMoveFiles);
	
	export Pre_Build_Input_manipulation :=
		Corp2.Promote(pversion).Inputfiles.Sprayed2Using : success(output('Pre build input superfile manipulation complete'));
	
	export Post_Build_Input_manipulation :=
		sequential(
			 Corp2.Promote(pversion).Inputfiles.Using2Used
			,Corp2.Promote(pversion,'Base.*?xtnd').buildfiles.New2Built
		
		) : success(output('Post build input superfile manipulation complete'));
		
	export Update_all_Bases	:=	Corp2.Update_Bases(pversion).All;

	export Build_All :=
	sequential(
		files_processed
		,Pre_Build_Input_manipulation
		// ,if(pShouldDesprayCorpLogs = true,DesprayCorpLogs(pversion, 'using'))
		,Update_All_Bases
		,Post_Build_Input_manipulation

	);

end;