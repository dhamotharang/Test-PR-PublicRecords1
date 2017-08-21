export Prep_File(

	 string															pfileversion			= 'using'
	,boolean														pUseOtherEnviron	= _Constants().isdataland
	,dataset(Layouts.Input.Sprayed		)	pSprayedFile			= Files(pfileversion,pUseOtherEnviron).Input.logical
	,dataset(Layouts.Input.SprayedOLD	)	pSprayedOldFile		= Files(pfileversion,pUseOtherEnviron).InputOld.logical

) :=
function

	return if(pSprayedFile[1].CU_NAME = 'Address'
						,project(pSprayedOldFile,Layouts.Input.Sprayed)
						,pSprayedFile
				)[2..];
	

end;