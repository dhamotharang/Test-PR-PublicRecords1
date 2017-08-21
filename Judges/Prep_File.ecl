export Prep_File(
	 dataset(Layouts.Input.Sprayed		)	pSprayedFile		= Files().Input.using
	,dataset(Layouts.Input.SprayedOLD	)	pSprayedOldFile	= Files().InputOld.using
) :=
function
	return if(pSprayedFile[1].CU_NAME = 'Address'
						,project(pSprayedOldFile,Layouts.Input.Sprayed)
						,pSprayedFile
				)[2..];
	
end;
