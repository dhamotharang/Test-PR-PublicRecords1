import Equifax_Business_Data;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Sprayed_Input					  )	pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base                     ) pBaseFile   = Files().base.qa
	,boolean																		pShouldUpdate		= _Flags.UpdateExists	
) :=
function

  dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);	
		
	MyDelta :=  IF(pShouldUpdate
								 ,PROJECT(pBaseFile, TRANSFORM(Equifax_Business_Data.Layouts.Base, SELF.record_type := 'H'; SELF := LEFT))
								 ,DATASET([],Equifax_Business_Data.Layouts.Base));						 

	ingestMod := Equifax_Business_Data.Ingest(FALSE,,MyDelta,dStandardizedInputFile);
	
	//Ingest Output File
	dIngest := ingestMod.AllRecords_Notag;	
	
	dStandardize_NameAddr		:= Standardize_NameAddr.fAll (dIngest);
	
	dAppendIds							:= Append_Ids.fAll					(dStandardize_NameAddr			); 								 
	
	dRollup									:= Rollup_Base							(dAppendIds									);
	
	return dRollup;

end;