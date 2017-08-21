import VersionControl;

export mBuild_All(
	 
	 string 				pversion
	,string					pPullFileVersion							= ''
	,set of string	pSetExtractStatesFromPullFile	= []
	,set of string	pSetFlushStatesFromCurrent		= []
	,string					pNewFileVersion								= ''
	,boolean				pBuildBaseFiles								= true
	,string					pRebuildReason								= ''

) :=
module

	export build_bases			:= mBuild_BaseFiles(pversion).Build_All;
	export build_roxie_keys	:= mBuild_Roxie_Keys(pversion).Build_All;
	export promote2QA				:= Promote_Built_To_QA;
	export stratapop				:= strata_population_stats(pversion).all_stats;
	export build_boolean		:= Proc_Build_Boolean_Keys(pversion);
	export PatchInStates		:= fPatchInStates(pPullFileVersion,pSetExtractStatesFromPullFile,pSetFlushStatesFromCurrent,pNewFileVersion);
	export NewRecs4QA				:= QA_records(files().base.corp.qa);
	
//	export AddRebuildReason	:= VersionControl.fSetFileDescription();
	
	export corp2keys := 
	sequential(
		 if(pPullFileVersion != '',PatchInStates)
		,if(pBuildBaseFiles				,build_bases	)		
		,build_roxie_keys
		,promote2QA
		,stratapop
		,build_boolean
		
	) : success(Send_Email(pversion).Roxie.corp2keys.QA), failure(Send_Email(pversion).BuildFailure);


	export All :=
	sequential(
	
		 corp2keys
		,NewRecs4QA
	
	) : success(Send_Email(pversion).buildsuccess), failure(Send_Email(pversion).BuildFailure);

/*
	//Above includes all of the below code
	export Corp := sequential(
		 nothor(corp2.Promote.Input.Corp.Sprayed2Using)
		,corp2.mBuild_BaseFiles.Update_Corp_Base
		,nothor(corp2.Promote.Base.Corp.New2Built)
		,nothor(corp2.Promote.Input.Corp.Using2Used)
		,corp2.mBuild_roxie_keys.Corp.build_all
		,nothor(corp2.Promote.Roxiekeys.Corp.New2Built)
		,nothor(corp2.Promote.Base.Corp.Built2QA2Father)
		,nothor(corp2.Promote.Roxiekeys.Corp.Built2QA2Father)
		,corp2.strata_population_stats.corp_base_stats
	);

	export Cont := sequential(
		 nothor(corp2.Promote.Input.Cont.Sprayed2Using)
		,corp2.mBuild_BaseFiles.Update_Cont_Base
		,nothor(corp2.Promote.Base.Cont.New2Built)
		,nothor(corp2.Promote.Input.Cont.Using2Used)
		,corp2.mBuild_roxie_keys.Cont.build_all
		,nothor(corp2.Promote.Roxiekeys.Cont.New2Built)
		,nothor(corp2.Promote.Base.Cont.Built2QA2Father)
		,nothor(corp2.Promote.Roxiekeys.Cont.Built2QA2Father)
		,corp2.strata_population_stats.cont_base_stats
	);

	export Events := sequential(
		 nothor(corp2.Promote.Input.Events.Sprayed2Using)
		,corp2.mBuild_BaseFiles.Update_Event_Base
		,nothor(corp2.Promote.Base.Events.New2Built)
		,nothor(corp2.Promote.Input.Events.Using2Used)
		,corp2.mBuild_roxie_keys.events.build_all
		,nothor(corp2.Promote.Roxiekeys.Events.New2Built)
		,nothor(corp2.Promote.Base.Events.Built2QA2Father)
		,nothor(corp2.Promote.Roxiekeys.Events.Built2QA2Father)
		,corp2.strata_population_stats.events_base_stats
	);

	export Stock := sequential(
		 nothor(corp2.Promote.Input.Stock.Sprayed2Using)
		,corp2.mBuild_BaseFiles.Update_Stock_Base
		,nothor(corp2.Promote.Base.Stock.New2Built)
		,nothor(corp2.Promote.Input.Stock.Using2Used)
		,corp2.mBuild_roxie_keys.Stock.build_all
		,nothor(corp2.Promote.Roxiekeys.Stock.New2Built)
		,nothor(corp2.Promote.Base.Stock.Built2QA2Father)
		,nothor(corp2.Promote.Roxiekeys.Stock.Built2QA2Father)
		,corp2.strata_population_stats.stock_base_stats
	);

	export AR := sequential(
		 nothor(corp2.Promote.Input.AR.Sprayed2Using)
		,corp2.mBuild_BaseFiles.Update_AR_Base
		,nothor(corp2.Promote.Base.AR.New2Built)
		,nothor(corp2.Promote.Input.AR.Using2Used)
		,corp2.mBuild_roxie_keys.AR.build_all
		,nothor(corp2.Promote.Roxiekeys.AR.New2Built)
		,nothor(corp2.Promote.Base.AR.Built2QA2Father)
		,nothor(corp2.Promote.Roxiekeys.AR.Built2QA2Father)
		,corp2.strata_population_stats.ar_base_stats
	);
*/
end;