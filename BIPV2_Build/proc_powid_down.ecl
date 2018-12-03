IMPORT BIPV2_Files, BIPV2, BIPv2_powid_down,wk_ut,tools,std;
l_base := BIPV2.CommonBase.Layout;
EXPORT proc_powid_down(
	DATASET(l_base) input = DATASET([],l_base),
	STRING iter = '') := MODULE
	
	/* ---------------------- Logical Files ------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_powid_down.FILE_SALT_OP + '::' + BIPV2.KeySuffix + '::it' + istr ;
	shared f_hist(string istr)	:= BIPv2_Files.files_powid_down.FILE_SALT_POSSIBLE_MATCH + '::' + BIPV2.KeySuffix + '::it' + istr ;
	shared f_init								:= BIPv2_Files.files_powid_down.FILE_INIT + '::' + BIPV2.KeySuffix;
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_base) ds, BOOLEAN idReset) := FUNCTION
		l_base toBase(l_base L) := TRANSFORM
			SELF.powid := IF(L.powid=0 OR idReset, L.proxid, L.powid);
			SELF := L;
		END;
		ds_base := PROJECT(ds,toBase(LEFT));
		RETURN ds_base;
	END;
	
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  // export dostrata_ID_Check(dataset(l_base) pDataset ,string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'POWIDDOWN','Preprocess',pversion,pIsTesting);
  export dostrata_ID_Check(dataset(BIPV2.CommonBase.Layout) pinput = dataset([],BIPV2.CommonBase.Layout),boolean pidreset = true,dataset(l_base) pDataset = preProcess(pinput,pidreset),string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'POWIDDOWN','Preprocess',pversion,pIsTesting);
	/* ---------------------- Init From LGID3 ---------------------------- */
	EXPORT init(DATASET(l_base) ds, BOOLEAN idReset=FALSE) := SEQUENTIAL(
		 BIPv2_Files.files_powid_down.clearBuilding
		,OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE)
    ,dostrata_ID_Check(ds,idReset)
		,BIPv2_Files.files_powid_down.updateBuilding(f_init)
	);
	SHARED ds_lgid3 := BIPV2_Files.files_lgid3.DS_BASE;

  export kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_lgid3.FILE_BASE)[1].name) ,bipv2.KeySuffix ,'powid_down_preprocess');
  export copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

	EXPORT initFromLGID3 := sequential(
      init(ds_lgid3, TRUE)
     ,copy2StorageThor
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_lgid3.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  ); // HACK - preserve id values someday
	
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod := BIPV2_powid_down.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches := output(BIPv2_powid_down.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPv2_powid_down.Proc_Iterate(iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain, possibleMatches);
		
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := BIPv2_Files.files_powid_down.updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter)) := BIPv2_Files.files_powid_down.updateSuperfiles(fname);
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= BIPv2_Files.files_powid_down.updateLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_powid_down._Samples(input).out;
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	/*-----------------------QA Tool Iteration Stats -------------*/
  import BIPV2_QA_Tool;
  export POWID_Down_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,POWID ,bipv2.KeySuffix  ,iter  ,BIPV2_powid_down.Config.MatchThreshold ,'BIPV2_POWID_Down');

	export runIter := sequential(linking, outputReviewSamples, updateBuilding(), updateLinkHist,POWID_Down_iteration_stats)
		: SUCCESS(mod_email.SendSuccessEmail(,'BIPv2', , 'POWID_Down')),
			FAILURE(mod_email.SendFailureEmail(,'BIPv2', failmessage, 'POWID_Down'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
			'BIPV2_powid_down Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
	export MultIter_run(startIter, numIters, doInit,doSpec,doIters = 'true',doPost = 'true') := functionmacro
//		export run(doInit,doSpec) := functionmacro
			import wk_ut, tools,BIPV2_build;
			pHint     := if(_Control.ThisEnvironment.name='Dataland','dev','20');
			cluster		:= BIPV2_build._Constants().Groupname;
			version		:= BIPV2.KeySuffix;
			previter	:= (string)(startiter - 1);
			lastIter	:= (string)(startiter - 1 + numIters);
			eclInit		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_powid_down \' + pversion + \' Init \');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_build.proc_powid_down().initFromLGID3;';
			eclSpec		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid_down.DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_powid_down \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_build.proc_powid_down(lih,iteration).runSpecBuild;';
			eclIter		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid_down.DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_powid_down \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n' + 'BIPV2_build.proc_powid_down(lih,iteration).runIter;';
      eclPost		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_powid_down @version@ PostProcess\');\n' + 'BIPV2_build.proc_powid_down(,\'' + lastIter + '\').updateSuperfiles();';
			
      kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'PowDownInit',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_powid_down.Init'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );
			kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'PowDownSpecs',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_powid_down.Specificities'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );
			kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount','PostClusterCount','BasicMatchesPerformed','MatchesPerformed','SlicesPerformed','POWIDsCreatedByCleave'],cluster,pOutputEcl := false,pUniqueOutput := 'PowDownIters',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_powid_down.iterations'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~BIPV2_build::@version@_@iteration@::summary_report::proc_powid_down.iterations'
      ,pSummarySuperfile := '~BIPV2_build::qa::summary_report::proc_powid_down.iterations'                                                 
      );
      kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'PowDownPost',pNotifyEmails := BIPV2_build.mod_email.emailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_powid_down.Post'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );			
      
      return sequential(
				 if(doInit  ,kickInit )
				,if(doSpec  ,kickSpec )
        ,if(doIters ,kickiters)
        ,if(doPost  ,kickPost )
			);
		endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_build.proc_powid_down().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);
end;
