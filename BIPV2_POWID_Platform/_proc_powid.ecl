import BIPV2_Files, BIPV2, MDR, BIPV2_POWID_Platform,wk_ut,tools,std,BIPV2_Testing;
// Init receives a file in common layout, and widens it for use in all iterations. We thin
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common := BIPV2.CommonBase.Layout;
l_base   := BIPV2_Files.files_powid().Layout_POWID;
export _proc_powid(
	 dataset(l_base)  input      = dataset([],l_base)
	,string           iter       = ''
  ,string           Build_Date  = bipv2.KeySuffix
  
) := module
	
	
	/* ---------------------- Logical Files ------------------------------- */
  shared _files_powid := BIPV2_Files.files_powid('BIPV2_POWID_Platform');
  
	/* ---------------------- Files -------------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_powid('BIPV2_POWID_Platform').FILE_SALT_OP             + '::' + Build_Date + '::it' + istr;
	shared f_hist(string istr)	:= BIPV2_Files.files_powid('BIPV2_POWID_Platform').FILE_SALT_POSSIBLE_MATCH + '::' + Build_Date + '::it' + istr;
	shared f_init								:= BIPV2_Files.files_powid('BIPV2_POWID_Platform').FILE_INIT                + '::' + Build_Date;	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := FUNCTION
		l_common toInit(l_common L) := TRANSFORM
			SELF.powid          := IF(L.powid=0 OR idReset, L.proxid, L.powid);
			SELF := L;
		END;
		ds_init := PROJECT(ds,toInit(LEFT));
		
		ds_base := BIPV2_POWID_Platform._address_properties(ds_init).ds_wide;
		
		RETURN project(ds_base  ,transform(l_base,self.RID_If_Big_Biz := if(left.cnt_prox_per_lgid3 > 1 or left.nodes_total > 1,(string)left.rcid,'') ,self := left));
	END;
	
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  // export dostrata_ID_Check(dataset(l_base) pDataset ,string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'POWID','Preprocess',pversion,pIsTesting);
  export dostrata_ID_Check(dataset(l_common) pinput = dataset([],l_common),boolean pidreset = false,dataset(l_base) pDataset = preProcess(pinput,pidreset),string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'POWID','Preprocess',pversion,pIsTesting);
	/* ---------------------- Init From POWID_Down ------------------------ */
	EXPORT init(DATASET(l_common) ds, BOOLEAN idReset=FALSE) := SEQUENTIAL(
		 _files_powid.clearBuilding
		,OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE)
    ,if(not wk_ut._constants.IsDev ,dostrata_ID_Check(ds,idReset))
		,_files_powid.updateBuilding(f_init)
	);
	SHARED ds_powid_down := BIPV2_Files.files_powid_down.DS_BASE;
	EXPORT initFromPOWID_Down(dataset(l_common) pds = ds_powid_down) := sequential(
     init(pds)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid_down.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
     
  );
	
	
	/* ---------------------- Post-processing ---------------------------- */
	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_powid_down) := FUNCTION	
		l_common toRestore(l_base L, l_common R) := TRANSFORM
			SELF := L; // pick up any changes from linking
			SELF := R; // then re-widen back to the common layout
		END;
		ds_restore := JOIN(ds, ds_common, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), SMART);		
		RETURN ds_restore;
	END;
	
	
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod := BIPV2_POWID_Platform.specificities(input);
	export specBuild := specMod.Build;
	export specDebug := sequential(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	
	/* ---------------------- SALT Iteration ----------------------------- */
	// shared possibleMatches := output(BIPV2_POWID_Platform.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPV2_POWID_Platform.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := _files_powid.updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter), DATASET(l_common) ds_common=ds_powid_down) := sequential(
		 output(postProcess(dataset(fname,l_base,thor),ds_common),, fname+'_post', compressed, overwrite)
		,_files_powid.updateSuperfiles(fname+'_post')
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
	);
	
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= _files_powid.updateLinkHist(f_hist(iter));
	
	
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_POWID_Platform._Samples(input).out;
	/* ---------------------- Inline Iteration Run for Testing ----------- */	
	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
		ds1 := preProcess(ds, FALSE);
		ds2 := BIPV2_POWID_Platform.matches(ds1,BIPV2_POWID_Platform.Config.MatchThreshold).patched_infile;
		ds3 := postProcess(ds2,ds);
    RETURN ds3;
  end;	
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	export runIter := sequential(linking, outputReviewSamples, updateBuilding()/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'POWID')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'POWID'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
			'BIPV2_POWID_Platform Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
		export MultIter_run(startIter, numIters,doInit,doSpec,doIters = 'true',doPost = 'true',pversion = 'bipv2.keysuffix',p_Init_File = 'BIPV2_Files.files_powid_down.DS_BASE',pcluster = 'BIPV2_build._Constants().Groupname') := functionmacro
			import wk_ut, tools,BIPV2_build;
			pHint     := if(_Control.ThisEnvironment.name='Dataland','dev','20');
			// pHint     := if(_Control.ThisEnvironment.name='Dataland','staging','20');
			cluster		:= pcluster;
			version		:= pversion;
			previter	:= (string)(startiter - 1);
			lastIter	:= (string)(startiter - 1 + numIters);
			eclInit		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_POWID_Platform \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n'                                                                                + 'BIPV2_POWID_Platform._proc_powid(,,            \''          + pversion + '\').initFromPOWID_Down('               + #TEXT(p_Init_File)+ ');';
			eclSpec		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid(\'BIPV2_POWID_Platform\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_POWID_Platform \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n'     + 'BIPV2_POWID_Platform._proc_powid(lih,iteration,\''          + pversion + '\').runSpecBuild;';
			eclIter		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid(\'BIPV2_POWID_Platform\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_POWID_Platform \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n'  + 'BIPV2_POWID_Platform._proc_powid(lih,iteration,\''          + pversion + '\').runIter;';
      eclPost		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_POWID_Platform @version@ PostProcess\');\n'                                                                                                                                                                                                                                            + 'BIPV2_POWID_Platform._proc_powid(,\'' + lastIter + '\',\''  + pversion + '\').updateSuperfiles(,'               + #TEXT(p_Init_File)+ ')';
			kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'POWIDInit',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID_Platform._proc_powid.Init'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );
			kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'POWIDSpecs',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID_Platform._proc_powid.Specificities'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );
			kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount[1].powid_count','{UNSIGNED rcid_Count,UNSIGNED powid_count}','PostClusterCount PostClusterCount[1].powid_count','{UNSIGNED rcid_Count,UNSIGNED powid_count}','BasicMatchesPerformed','MatchesPerformed','SlicesPerformed'],cluster,pOutputEcl := false,pUniqueOutput := 'POWIDIters',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::@version@_@iteration@::workunit_history::BIPV2_POWID_Platform._proc_powid.iterations'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~BIPV2_build::@version@_@iteration@::summary_report::BIPV2_POWID_Platform._proc_powid.iterations'
      ,pSummarySuperfile := '~BIPV2_build::qa::summary_report::BIPV2_POWID_Platform._proc_powid.iterations'                                                 
      );
      kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'POWIDPost',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID_Platform._proc_powid.Post'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      );
			return sequential(
				 if(doInit ,kickInit  )
				,if(doSpec ,kickSpec  )
				,if(doIters,kickiters )
        ,if(doPost ,kickPost  )
				// ,BIPV2_POWID_Platform._BIPV2_POWID_Platform._proc_powid(,lastIter).updateSuperfiles()
			);
		endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_POWID_Platform._BIPV2_POWID_Platform._proc_powid().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);
	
end;

