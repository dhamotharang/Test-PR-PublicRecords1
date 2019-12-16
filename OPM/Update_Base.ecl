import business_header, VersionControl, MDR, LinkingTools, Scrubs,  tools, _control, ut, std;

export Update_Base(
	 string														pversion
	,dataset(Layouts.Sprayed_Input	)	pSprayedFile	= OPM.Files().Input.using
	,dataset(Layouts.Base           ) pBaseFile     = OPM.Files().base.qa
	,boolean											  	pShouldUpdate	= OPM._Flags.UpdateExists	
) := 
function
  
	dStandardizeInput	 := Standardize_Input.fAll	(pSprayedFile, pversion);		
	
	dBase              := IF(pShouldUpdate
													 ,PROJECT(pBaseFile, TRANSFORM(Layouts.Base, SELF.record_type :=  'H'; SELF :=  LEFT))
													 ,DATASET([],Layouts.Base));
													 
	ingestMod					 := OPM.Ingest(,,dBase,dStandardizeInput);  
	update_combined    := ingestMod.AllRecords_Notag;
	
	dStandardize_Addr	 := Standardize_NameAddr.fAll(update_combined, pversion);
	dAppendIds				 := Append_Ids.fAll(dStandardize_Addr	, pversion); 								 
	dRollup						 := Rollup_Base(dAppendIds);
	
  return dRollup;
	
end;