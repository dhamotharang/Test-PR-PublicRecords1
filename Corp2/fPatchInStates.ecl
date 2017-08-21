import versioncontrol;

export fPatchInStates(

	 string					pPullFileVersion
	,set of string	pSetExtractStatesFromPullFile
	,set of string	pSetFlushStatesFromCurrent		= []
	,string					pNewFileVersion

) :=
function
	
	shared corpy 	:= corp2.files(pPullFileVersion).base.corp.new	(corp_state_origin in pSetExtractStatesFromPullFile);
	shared cont 	:= corp2.files(pPullFileVersion).base.cont.new	(corp_state_origin in pSetExtractStatesFromPullFile);
	shared events := corp2.files(pPullFileVersion).base.events.new(corp_state_origin in pSetExtractStatesFromPullFile);
	shared stock 	:= corp2.files(pPullFileVersion).base.stock.new	(corp_state_origin in pSetExtractStatesFromPullFile);
	shared ar 		:= corp2.files(pPullFileVersion).base.ar.new		(corp_state_origin in pSetExtractStatesFromPullFile);

	shared corpy_new 		:= corp2.files().base.corp.qa		(corp_state_origin not in pSetFlushStatesFromCurrent)	+ corpy ;
	shared cont_new 		:= corp2.files().base.cont.qa		(corp_state_origin not in pSetFlushStatesFromCurrent)	+ cont 	;
	shared events_new 	:= corp2.files().base.events.qa	(corp_state_origin not in pSetFlushStatesFromCurrent)	+ events;
	shared stock_new 		:= corp2.files().base.stock.qa	(corp_state_origin not in pSetFlushStatesFromCurrent)	+ stock ;
	shared ar_new 			:= corp2.files().base.ar.qa			(corp_state_origin not in pSetFlushStatesFromCurrent)	+ ar 		;
                                                
	versionControl.macBuildNewLogicalFile(corp2.Filenames(pNewFileVersion).base.corp.new		,corpy_new 	,Update_corp_Base		);
	versionControl.macBuildNewLogicalFile(corp2.Filenames(pNewFileVersion).base.cont.new		,cont_new 	,Update_cont_Base		);
	versionControl.macBuildNewLogicalFile(corp2.Filenames(pNewFileVersion).base.events.new	,events_new ,Update_events_Base	);
	versionControl.macBuildNewLogicalFile(corp2.Filenames(pNewFileVersion).base.stock.new		,stock_new 	,Update_stock_Base	);
	versionControl.macBuildNewLogicalFile(corp2.Filenames(pNewFileVersion).base.ar.new			,ar_new 		,Update_ar_Base			);
																																						
	return 
	sequential(
		 Update_corp_Base		
		,Update_cont_Base		
		,Update_events_Base	
		,Update_stock_Base	
		,Update_ar_Base			
		,corp2.Promote(pNewFileVersion,'base').buildfiles.New2Built
		,corp2.Promote_Built_To_QA
	);

end;