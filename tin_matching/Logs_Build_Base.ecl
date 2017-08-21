import Inquiry_AccLogs;

import tools;
export Logs_Build_base(
	 string																pversion
	,boolean															pIsTesting			= _Constants().IsDataland
	,boolean															pWriteFileOnly	= false
	,dataset(layouts.input.sprayed			)	pInputfile			= Files().input.logs_thor.using
	,dataset(Inquiry_Acclogs.Layout_MBS	)	pMBSFile				= Inquiry_AccLogs.File_MBS.File
	,dataset(layouts.input.sprayed			)	pFilteredFile		= Logs_Preprocess(pInputfile,pMBSFile)
) :=
function

	tools.mac_WriteFile(Filenames(pversion).base.logs_thor.new	,pFilteredFile	,Build_Base_File	,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 if(not pWriteFileOnly	,Promote(,'logs_thor').Inputfiles.Sprayed2Using			)
				,Build_Base_File	
				,if(not pWriteFileOnly	,Promote(pversion,'logs_thor').buildfiles.New2Built)
			)		
			,output('No Valid version parameter passed, skipping tin_matching.Logs_Build_Base atribute')
		);
		
end;
