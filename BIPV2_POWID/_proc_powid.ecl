import BIPV2_Files, BIPV2, MDR, BIPV2_POWID,wk_ut,tools,std, linkingtools;
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
  shared _files_powid := BIPV2_Files.files_powid('BIPV2_POWID');
  
	/* ---------------------- Files -------------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_powid('BIPV2_POWID').FILE_SALT_OP             + '::' + Build_Date + '::it' + istr;
	shared f_hist(string istr)	:= BIPV2_Files.files_powid('BIPV2_POWID').FILE_SALT_POSSIBLE_MATCH + '::' + Build_Date + '::it' + istr;
	shared f_init								:= BIPV2_Files.files_powid('BIPV2_POWID').FILE_INIT                + '::' + Build_Date;	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := FUNCTION
		l_common toInit(l_common L) := TRANSFORM
			SELF.powid          := IF(L.powid=0 OR idReset, L.proxid, L.powid);
			SELF := L;
		END;
		ds_init := PROJECT(ds,toInit(LEFT));
		
		ds_base := BIPV2_POWID._address_properties(ds_init).ds_wide;
		
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
  export kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid_down.FILE_BASE)[1].name) ,Build_Date ,'powid_preprocess');
  export copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor
	EXPORT initFromPOWID_Down(dataset(l_common) pds = ds_powid_down) := sequential(
     init(pds)
    ,copy2StorageThor
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid_down.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
     
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
	shared specMod := BIPV2_POWID.specificities(input);
	export specBuild := specMod.Build;
	export specDebug := sequential(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	
	/* ---------------------- SALT Iteration ----------------------------- */
	// shared possibleMatches := output(BIPV2_POWID.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPV2_POWID.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	/*-----------------------For Persistence stats of the powid cluster and records -------------*/
  import BIPV2_QA_Tool;
  shared last_powid_iter  := '~' + nothor(std.file.superfilecontents(_files_powid.FILE_BUILDING)[1].name);
  shared the_base         := dataset(last_powid_iter,l_base,thor);
	shared the_father       := BIPV2.CommonBase.DS_BASE;
	shared ds_powid_persistence_stats   :=  BIPV2_Strata.PersistenceStats(the_base      ,the_father ,rcid,powid ) : independent;
	shared ds_seleid_persistence_stats  :=  BIPV2_Strata.PersistenceStats(ds_powid_down ,the_father ,rcid,seleid) : independent;   

	shared QA_Tool_powid_persistence_record_stats     := BIPV2_QA_Tool.mac_persistence_records_stats(ds_powid_persistence_stats ,'powid' ,Build_Date);
  shared QA_Tool_powid_persistence_cluster_stats    := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_powid_persistence_stats ,'powid' ,Build_Date);

	shared QA_Tool_seleid_persistence_record_stats     := BIPV2_QA_Tool.mac_persistence_records_stats(ds_seleid_persistence_stats ,'seleid' ,Build_Date);
  shared QA_Tool_seleid_persistence_cluster_stats    := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_seleid_persistence_stats ,'seleid' ,Build_Date);
  
	/* ---------------------- SALT Output -------------------------------- */
	export updateSuperfiles(string fname=last_powid_iter, DATASET(l_common) ds_common=ds_powid_down) := 
  function
  
    kick_copy2_storage_thor_post  := BIPV2_Tools.Copy2_Storage_Thor(fname ,Build_Date ,'powid_postprocess');
    copy2StorageThor_post         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_post ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor
  
    return sequential(
       output(postProcess(dataset(fname,l_base,thor),ds_common),, fname+'_post', compressed, overwrite)
       ,Strata.macf_CreateXMLStats(ds_powid_persistence_stats  ,'BIPV2','Persistence'	,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'POWID' ,'Stats',false,false) //group on cluster_type, stat_desc
       ,Strata.macf_CreateXMLStats(ds_seleid_persistence_stats ,'BIPV2','Persistence'	,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'SELEID','Stats',false,false) //group on cluster_type, stat_desc
       ,QA_Tool_powid_persistence_record_stats 
       ,QA_Tool_powid_persistence_cluster_stats
       ,QA_Tool_seleid_persistence_record_stats 
       ,QA_Tool_seleid_persistence_cluster_stats
       ,_files_powid.updateSuperfiles(fname+'_post')
       ,copy2StorageThor_post
    );
	end;
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= _files_powid.updateLinkHist(f_hist(iter));
	
	
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_POWID._Samples(input).out;
	/* ---------------------- Inline Iteration Run for Testing ----------- */	
	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
		ds1 := preProcess(ds, FALSE);
		ds2 := BIPV2_POWID.matches(ds1,BIPV2_POWID.Config.MatchThreshold).patched_infile;
		ds3 := postProcess(ds2,ds);
    RETURN ds3;
  end;	
	
	/*-----------------------QA Tool Iteration Stats -------------*/
  import BIPV2_QA_Tool;
  export POWID_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,POWID ,Build_Date  ,iter  ,BIPV2_powid.Config.MatchThreshold ,'BIPV2_POWID');

	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	shared updateBuilding(string fname=f_out(iter)) := _files_powid.updateBuilding(fname);
	export runIter := sequential(linking, outputReviewSamples, updateBuilding(),POWID_iteration_stats/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'POWID')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'POWID'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
			'BIPV2_POWID Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
      
		export MultIter_run(
       startIter    = '\'\''  //start where powid down left off
      ,numIters     = '2'
      ,doInit       = 'true'
      ,doSpec       = 'true'
      ,doIters      = 'true'
      ,doPost       = 'true'
      ,pversion     = 'bipv2.keysuffix'
      ,p_Init_File  = 'BIPV2_Files.files_powid_down.DS_BASE'
      ,pcluster     = 'BIPV2_build._Constants().Groupname'
      ,pEmailList   = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
      ,pCompileTest = 'false'                                               
      
    ) := 
    functionmacro
    
			import Workman, tools,BIPV2_build;
      
			cluster		    := pcluster;
			version		    := pversion;
      lnumiters     := numIters         ;
      lnumitersmax  := numIters + 1     ;
      
			eclInit_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_POWID \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n';                                                                                
			eclSpec_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid(\'BIPV2_POWID\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_POWID \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n'  ;   
			eclIter_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_powid(\'BIPV2_POWID\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_POWID \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n'  ;
      eclPost_prep		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_POWID @version@ PostProcess\');\n'    ;                                                                                                                                                                                                                                        
      
      eclInit		:= eclInit_prep + 'BIPV2_POWID._proc_powid(   ,         ,\''  + pversion + '\').initFromPOWID_Down('               + #TEXT(p_Init_File)+ ');';
      eclSpec		:= eclSpec_prep + 'BIPV2_POWID._proc_powid(lih,iteration,\''  + pversion + '\').runSpecBuild;';
      eclIter		:= eclIter_prep + 'BIPV2_POWID._proc_powid(lih,iteration,\''  + pversion + '\').runIter     ;';
      eclPost		:= eclPost_prep + 'BIPV2_POWID._proc_powid(   ,\'\'     ,\''  + pversion + '\').updateSuperfiles  (,'              + #TEXT(p_Init_File)+ ')';

      eclsetResults   := [ 'PreClusterCount PreClusterCount.POWID_Cnt'        
                          ,'PostClusterCount PostClusterCount.POWID_Cnt'       
                          ,'MatchesPerformed'      
                          ,'BasicMatchesPerformed'
                          ,'SlicesPerformed'
                          // ,'LinkBlockSplits'
                          ,'recordsrejected0'
                          ,'unlinkablerecords0'
                         ];
      StopCondition       := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
      SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

      kickInit   := Workman.mac_WorkMan(eclInit   ,version,cluster ,1         ,1  ,pBuildName := 'POWIDInit' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID._proc_powid.Init'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );

      kickSpec   := Workman.mac_WorkMan(eclSpec   ,version,cluster ,1         ,1  ,pBuildName := 'POWIDSpecs' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID._proc_powid.Specificities'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );

      kickiters := Workman.mac_WorkMan(eclIter,version ,cluster,startiter,lnumitersmax,lnumiters   
        ,pSetResults          := eclsetResults
        ,pStopCondition       := StopCondition
        ,pSetNameCalculations := SetNameCalculations
        ,pBuildName           := 'PowIters'
        ,pNotifyEmails        := pEmailList
        ,pOutputFilename      := '~BIPV2_build::@version@_@iteration@::workunit_history::BIPV2_POWID._proc_powid.iterations'
        ,pOutputSuperfile     := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly         := pCompileTest
      );

      kickPost   := Workman.mac_WorkMan(eclPost   ,version,cluster ,1         ,1  ,pBuildName := 'POWIDPost' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::BIPV2_POWID._proc_powid.Post'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );
      
			return sequential(
				 if(doInit ,kickInit  )
				,if(doSpec ,kickSpec  )
				,if(doIters,kickiters )
        ,if(doPost ,kickPost  )
			);
		endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_POWID._BIPV2_POWID._proc_powid().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);
	
end;

