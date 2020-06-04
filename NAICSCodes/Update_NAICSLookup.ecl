import NAICSCodes;

export Update_NAICSLookup(

	 string																  pversion
	,dataset(Layouts.Sprayed_Input)	        pSprayedFile  = Files().Input.using
	,dataset(Layouts.NAICSLookup)           pBaseFile     = Files().NAICSLookup.qa
	,boolean																pShouldUpdate	= _Flags.UpdateExists	
) :=
function

  dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);	
	
	return dStandardizedInputFile;

end;