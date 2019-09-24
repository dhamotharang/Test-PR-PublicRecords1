import business_header, VersionControl, MDR, LinkingTools, Scrubs,  tools, _control, ut, std;

export Update_Base(
	 string																				pversion
	,dataset(Database_USA.Layouts.Sprayed_Input)	pSprayedFile	= Database_USA.Files().Input.using
	,dataset(Database_USA.Layouts.Base         )	pBaseFile     = Database_USA.Files().base.qa
	,boolean																			pShouldUpdate	= Database_USA._Flags.UpdateExists	
) :=
function
  
	dStandardizeInput	 :=  Database_USA.Standardize_Input.fAll	(pSprayedFile, pversion);	
		
	dBase              :=  IF(pShouldUpdate
														,PROJECT(pBaseFile, TRANSFORM(Database_USA.Layouts.Base, SELF.record_type := 'H'; SELF := LEFT))
														,DATASET([],Database_USA.Layouts.Base));
		
	ingestMod					 :=  Database_USA.Ingest(,,dBase,dStandardizeInput);  
	update_combined    :=  ingestMod.AllRecords_Notag;  

	dStandardize_Addr	 :=  Database_USA.Standardize_NameAddr.fAll (update_combined);
	dAppendIds				 :=  Database_USA.AppendIds.fAll (dStandardize_Addr); 								 
		
	return dAppendIds;
	
end;