import SICCodes;

export Update_SICLookup(

	 string																  pversion
	,dataset(Layouts.Sprayed_Input)	pSprayedFile  = Files().Input.using
	,dataset(Layouts.SICLookup)          pBaseFile     = Files().SICLookup.qa
	,boolean																pShouldUpdate	= _Flags.UpdateExists	
) :=
function

  dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);	
		
	return dStandardizedInputFile;

end;