import business_header;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile		= Files().Input.using

) :=
function

	dStandardize_NameAddr		:= Standardize_NameAddr.fAll(pSprayedFile,	pversion	);
	dAppendIds							:= Append_Ids.fAll					(dStandardize_NameAddr			);

	return dAppendIds;

end;