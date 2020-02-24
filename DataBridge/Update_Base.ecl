import business_header, VersionControl, MDR, LinkingTools, Scrubs,  tools, _control, ut, std;

export Update_Base(
	 string														pversion
	,dataset(Layouts.Sprayed_Input	)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base           ) pBaseFile     = Files().base.qa
	,boolean											  	pShouldUpdate	= _Flags.UpdateExists	
) :=
function
  
	dStandardizeInput	 :=  Standardize_Input.fAll	(pSprayedFile, pversion);	
		
	dBase              :=  IF(pShouldUpdate
														,PROJECT(pBaseFile, TRANSFORM(Layouts.Base, SELF.record_type := 'H'; SELF := LEFT))
														,DATASET([],Layouts.Base));
		
	ingestMod					 :=  Ingest(,,dBase,dStandardizeInput);  
	update_combined    :=  ingestMod.AllRecords_Notag;  
	addGlobalSID 			 :=  mdr.macGetGlobalSID(update_combined, 'DataBridge', 'source', 'global_sid'); //DF-26602: Populate Global_SID Field

	dStandardize_Addr	 :=  Standardize_NameAddr.fAll (addGlobalSID, pversion);
	dAppendIds				 :=  Append_Ids.fAll (dStandardize_Addr, pversion); 								 
	dRollup						 :=  Rollup_Base (dAppendIds);
	
	return dRollup;
	
end;