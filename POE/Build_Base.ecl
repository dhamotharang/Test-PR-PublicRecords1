import tools;

export Build_Base(

	 string									pversion
	,boolean								pPullSourceDataFromProd	= false													
 	,dataset(Layouts.Base	)	pSource_Data						= Source_Data(pPullSourceDataFromProd)
 	,dataset(Layouts.Base	)	pUpdatedBase						= Update_Base(pversion,pPullSourceDataFromProd,pSource_Data)

) :=
module

	tools.mac_WriteFile(Filenames(pversion).base.new	,pUpdatedBase	,Build_Base_File	);
	
	export full_build :=
	sequential(
		 Build_Base_File
		,Promote(pversion).New2Built

	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping POE.Build_Base attribute')
	);
		
end;