import tools, header;

export Build_Base(

	 string																							pversion
	,boolean																						pIsTesting			= false
	,boolean																						pDeltaRun				= false
	,dataset(Cortera_Tradeline.Layout_Tradeline     )		pSprayedAddFile	= Cortera_Tradeline.Files().input.Tradeline_Adds.Using
	,dataset(Cortera_Tradeline.Layout_Delete				)		pSprayedDelFile	= Cortera_Tradeline.Files().input.Tradeline_Dels.Using
	,dataset(Cortera_Tradeline.Layout_Tradeline_Base)		pBaseFile				= Cortera_Tradeline.Files().base.Tradeline.qa
	,boolean																						pWriteFileOnly	= false
	
) :=
function

	pPrevBaseFile := if(pDeltaRun, 
											pBaseFile, // Though passing previous base file, but is not used in the delta run
											Cortera_Tradeline.Rollup_Delta_Base(pBaseFile)  //Rolling the delta files with the full file in the full run.
										 );
	
	allrecs        := Cortera_Tradeline.Ingest(pversion,pDeltaRun,pSprayedAddFile,,pPrevBaseFile).AllRecords_notag;
	allrecs_w_dels := Cortera_Tradeline.proc_delete_records(pversion,pDeltaRun,pSprayedDelFile,allrecs);
	newbase        := Cortera_Tradeline.proc_link_bip(Cortera_tradeline.proc_remove_dups(allrecs_w_dels));

	tools.mac_WriteFile(Filenames(pversion).base.tradeline.new	,newbase	,Build_Base_File	,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 if(not pWriteFileOnly ,Promote().Inputfiles.Sprayed2Using)
				,Build_Base_File
				,OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest(pversion,pDeltaRun,pSprayedAddFile,,pPrevBaseFile).newrecords, 500), named('newrecords'))
				,OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest(pversion,pDeltaRun,pSprayedAddFile,,pPrevBaseFile).updatedrecords, 500), named('updated'))
				,OUTPUT(Cortera_Tradeline.Ingest(pversion,pDeltaRun,pSprayedAddFile,,pPrevBaseFile).StandardStats(), ALL, NAMED('StandardStats'))
				,Cortera_Tradeline.Ingest(pversion,pDeltaRun,pSprayedAddFile,,pPrevBaseFile).DoStats
				,Cortera_Tradeline.Ingest().ValidityStats
				,Cortera_Tradeline.Promote(pversion,'base',pIsDeltaBuild:=pDeltaRun).buildfiles.New2Built				
			)
			,output('No Valid version parameter passed, skipping Cortera_Tradeline.Build_Base atribute') 
		);
		
end;