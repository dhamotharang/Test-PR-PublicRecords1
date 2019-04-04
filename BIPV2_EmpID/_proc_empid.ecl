import BIPV2_Files, BIPV2, BIPV2_EmpID, BIPV2_Tools,tools,wk_ut,std,bipv2_build,linkingtools;
// Init receives a file in common layout, and widens it for use in all iterations. We thin
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common := BIPV2.CommonBase.Layout;
l_base   := BIPV2_Files.files_empid().Layout_EmpID;
export _proc_empid(
	 dataset(l_base) input                  = dataset([],l_base)
	,string          iter                   = ''
  ,string          Build_Date             = BIPV2.KeySuffix
  ,boolean         pFix_Dotid_Overlinks   = true
  
) := module
	
  shared _mod := 'BIPV2_EmpID';
  
  shared _files_empid := BIPV2_Files.files_empid(_mod);
	
	/* ---------------------- Logical Files ------------------------------- */
	EXPORT f_out(STRING istr)		:= BIPV2_Files.files_empid(_mod).FILE_SALT_OP              + '::' + Build_Date + '::it' + istr ;
	SHARED f_hist(STRING istr)	:= BIPV2_Files.files_empid(_mod).FILE_SALT_POSSIBLE_MATCH  + '::' + Build_Date + '::it' + istr ;
	SHARED f_init								:= BIPV2_Files.files_empid(_mod).FILE_INIT                 + '::' + Build_Date;
	SHARED f_post								:= BIPV2_Files.files_empid(_mod).FILE_POST                 + '::' + Build_Date;
	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := FUNCTION
		l_base toBase(l_common L) := TRANSFORM
			SELF.empid						:= IF(L.empid=0 OR idReset, L.dotid, L.empid);
			SELF.cname_devanitize	:= BIPV2_Tools.fn_devanitize(L.cnp_name, L.fname, L.lname);
			SELF.isCorpEnhanced		:= ''; // actual value assigned below
			SELF := L;
		END;
		ds_base := PROJECT(ds,toBase(LEFT));
		ds_enhanced := BIPV2_EmpID._setCorpEnhanced(ds_base);
		RETURN ds_enhanced;
	END;
	
	
	/* ---------------------- Use Vanity ADL to collapse single address orgids ---------------------------- */
	EXPORT DATASET(l_common) Vanity_ADL_Orgid_Collapse(DATASET(l_common) ds) := 
  FUNCTION
    single_addr_orgids        := table(table(ds,{orgid,prim_range,prim_name,v_city_name,st},orgid,prim_range,prim_name,v_city_name,st,merge),{orgid,unsigned cnt := count(group)},orgid)(cnt = 1);
    ds_onlysingle_addr_orgids := join(ds,single_addr_orgids,left.orgid = right.orgid,transform(left),hash);
    withDid_didnonzero        := ds_onlysingle_addr_orgids(vanity_owner_did != 0);
    withDid_didzero           := ds_onlysingle_addr_orgids(vanity_owner_did = 0);
    withDid_notcorp             := withDid_didnonzero(iscorp = '');//blank seems to mean nocorp
    //only want 1 address in orgid i think
    withDid_notcorp_lowestOrgid := table(withDid_notcorp ,{vanity_owner_did,unsigned6 orgid := min(group,orgid)} ,vanity_owner_did,merge);
    
    withDid_patchorgid          := join(withDid_notcorp  ,withDid_notcorp_lowestOrgid,left.vanity_owner_did = right.vanity_owner_did,transform(
      {unsigned6 vanity_did,unsigned6 did,unsigned6 new_orgid,unsigned6 orgid,recordof(left) - orgid - vanity_owner_did},
      self.vanity_did := left.vanity_owner_did;
      self.did        := left.contact_did;
      self.new_orgid  := right.orgid;
      self.orgid      := left.orgid;
      self            := left;
    ));
    
    //get old orgid to new orgid table
    orgid_patch_table := table(withDid_patchorgid(orgid != new_orgid) ,{orgid,unsigned6 new_orgid := min(group,new_orgid)},orgid,merge);
    
    ds_patch_orgid := join(ds,orgid_patch_table,left.orgid = right.orgid,transform(recordof(left),self.orgid := if(right.orgid != 0,right.new_orgid,left.orgid),self := left),left outer,hash);
  
    ds_unique_orgids        := table(ds            ,{orgid},orgid,merge);
    ds_patch_unique_orgids  := table(ds_patch_orgid,{orgid},orgid,merge);
    countsingle_addr_orgids          := count(single_addr_orgids         );
    countds_onlysingle_addr_orgids   := count(ds_onlysingle_addr_orgids  );
    countwithDid_didnonzero          := count(withDid_didnonzero         );
    countwithDid_didzero             := count(withDid_didzero            );
    countwithDid_notcorp             := count(withDid_notcorp            );
    countwithDid_notcorp_lowestOrgid := count(withDid_notcorp_lowestOrgid);
    countwithDid_patchorgid          := count(withDid_patchorgid         );
    countorgid_patch_table           := count(orgid_patch_table          );
    countds_patch_orgid              := count(ds_patch_orgid             );
    countds_unique_orgids            := count(ds_unique_orgids           );
    countds_patch_unique_orgids      := count(ds_patch_unique_orgids     );
    
    outputdiagnostics := parallel(
       output(countsingle_addr_orgids          ,named('countsingle_addr_orgids'         ))
      ,output(countds_onlysingle_addr_orgids   ,named('countds_onlysingle_addr_orgids'  ))
      ,output(countwithDid_didnonzero          ,named('countwithDid_didnonzero'         ))
      ,output(countwithDid_didzero             ,named('countwithDid_didzero'            ))
      ,output(countwithDid_notcorp             ,named('countwithDid_notcorp'            ))
      ,output(countwithDid_notcorp_lowestOrgid ,named('countwithDid_notcorp_lowestOrgid'))
      ,output(countwithDid_patchorgid          ,named('countwithDid_patchorgid'         ))
      ,output(countorgid_patch_table           ,named('countorgid_patch_table'          ))
      ,output(countds_patch_orgid              ,named('countds_patch_orgid'             ))
      ,output(countds_unique_orgids            ,named('countds_unique_orgids'           ))
      ,output(countds_patch_unique_orgids      ,named('countds_patch_unique_orgids'     ))
    
      ,output(choosen(single_addr_orgids          ,100),named('single_addr_orgids'         ))
      ,output(choosen(ds_onlysingle_addr_orgids   ,100),named('ds_onlysingle_addr_orgids'  ))
      ,output(choosen(withDid_didnonzero          ,100),named('withDid_didnonzero'         ))
      ,output(choosen(withDid_didzero             ,100),named('withDid_didzero'            ))
      ,output(choosen(withDid_notcorp             ,100),named('withDid_notcorp'            ))
      ,output(choosen(withDid_notcorp_lowestOrgid ,100),named('withDid_notcorp_lowestOrgid'))
      ,output(choosen(withDid_patchorgid          ,100),named('withDid_patchorgid'         ))
      ,output(choosen(orgid_patch_table           ,100),named('orgid_patch_table'          ))
      ,output(choosen(ds_patch_orgid              ,100),named('ds_patch_orgid'             ))
      ,output(choosen(ds_unique_orgids            ,100),named('ds_unique_orgids'           ))
      ,output(choosen(ds_patch_unique_orgids      ,100),named('ds_patch_unique_orgids'     ))
    
    );
    
    // return when(ds_patch_orgid  ,outputdiagnostics);
    return ds_patch_orgid  ;
    
	END;
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  // export dostrata_ID_Check(dataset(l_base) pDataset ,string pversion = Build_Date ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'EMPID','Preprocess',pversion,pIsTesting);
  export dostrata_ID_Check(dataset(l_common) pinput = dataset([],l_common),boolean pidreset = false,dataset(l_base) pDataset = preProcess(Vanity_ADL_Orgid_Collapse(pinput),pidreset),string pversion = Build_Date ,boolean pIsTesting = wk_ut._constants.IsDev) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'EMPID','Preprocess',pversion,pIsTesting);
	/* ---------------------- Init From EmpID_Down ------------------------ */
	EXPORT init(DATASET(l_common) ds, BOOLEAN idReset=false) := SEQUENTIAL(
		 _files_empid.clearBuilding
		,OUTPUT(preProcess(Vanity_ADL_Orgid_Collapse(ds),idReset),,f_init,COMPRESSED,OVERWRITE)
    ,if(not wk_ut._constants.IsDev ,dostrata_ID_Check(ds,idReset))
		,_files_empid.updateBuilding(f_init)
	);
	SHARED ds_empid_down := BIPV2_Files.files_empid_down().DS_BASE;
	EXPORT initFromEmpID_Down(dataset(recordof(BIPV2_Files.files_empid_down().DS_BASE)) pdataset = BIPV2_Files.files_empid_down().DS_BASE) := 
  function
    kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_empid_down().FILE_BASE)[1].name) ,Build_Date ,'empid_preprocess');
    copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

    return sequential(
       init(pdataset)
      ,copy2StorageThor
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_empid_down().FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
    );
  end;
	/* ---------------------- Post-processing ---------------------------- */
	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_empid_down) := FUNCTION
		// Restore original layout
		l_common toRestore(l_base L, l_common R) := TRANSFORM
			SELF := L; // pick up any changes from linking
			SELF := R; // then re-widen back to the common layout
		END;
		ds_restore := JOIN(ds, ds_common, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), SMART);		
		RETURN ds_restore;
	END;
		
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod    := BIPV2_EmpID.specificities(input);
	shared specBuild  := specMod.Build;
	shared specDebug  := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches  := output(BIPV2_EmpID.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	        := BIPV2_EmpID.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	        := parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	/*-----------------------For Persistence stats of the emp cluster and records -------------*/
  import BIPV2_QA_Tool;
  shared the_base:=	dataset(f_out(iter),l_base,thor);
	shared the_father:=BIPV2.CommonBase.DS_BASE;
	shared ds_empid_persistence_stats                := BIPV2_Strata.PersistenceStats(the_base,the_father,rcid,empid) : independent;
	shared QA_Tool_Empid_persistence_record_stats    := BIPV2_QA_Tool.mac_persistence_records_stats(ds_empid_persistence_stats ,'empid' ,Build_Date);
  shared QA_Tool_Empid_persistence_cluster_stats   := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_empid_persistence_stats ,'empid' ,Build_Date);
	
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := _files_empid.updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter), DATASET(l_common) ds_common=ds_empid_down) := 
  function
  
    kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor(fname ,Build_Date ,'empid_postprocess');
    copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

    return sequential(
       output(postProcess(dataset(fname,l_base,thor),ds_common),, f_post, compressed, overwrite)
      ,_files_empid.updateSuperfiles(f_post)
      ,Strata.macf_CreateXMLStats(ds_empid_persistence_stats ,'BIPV2','Persistence'	,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'EMPID','Stats',false,false) //group on cluster_type, stat_desc
      ,QA_Tool_Empid_persistence_record_stats 
      ,QA_Tool_Empid_persistence_cluster_stats
      ,copy2StorageThor
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
    );
  end;
	
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= _files_empid.updateLinkHist(f_hist(iter));
	
	
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_EmpID._Samples(input).out;
	
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	/*-----------------------QA Tool Iteration Stats -------------*/
  import BIPV2_QA_Tool;
  export Empid_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,empid ,Build_Date  ,iter  ,BIPV2_Empid.Config.MatchThreshold ,'BIPV2_Empid');

	export runIter := sequential(linking, outputReviewSamples, updateBuilding(),Empid_iteration_stats/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'EmpID')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'EmpID'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
		'BIPV2_EmpID Controller ' + Build_Date + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
	
	export MultIter_run(
       startIter    = '\'\'' //start where empid down left off
      ,numIters     = '3'
      ,doInit       = 'true'
      ,doSpec       = 'true'
      ,doIters      = 'true'
      ,doPost       = 'true'
      ,pversion     = 'bipv2.keysuffix'
      ,p_Init_File  = 'BIPV2_Files.files_empid_down().DS_BASE'
      ,pcluster     = 'BIPV2_Build._Constants().Groupname'
      ,pEmailList   = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
      ,pCompileTest = 'false'                                               
    ) := 
    functionmacro
    
      import Workman, tools,BIPV2_build;
      
      cluster		:= pcluster;
      version		:= pversion;

      lnumiters     := numIters         ;
      lnumitersmax  := numIters + 1     ;
      
      eclInit_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_EmpID \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n' ;
      eclSpec_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\nlih := BIPV2_Files.files_empid(\'BIPV2_EmpID\').DS_BUILDING;\n#workunit(\'name\',\'BIPV2_EmpID \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n'    ;
      eclIter_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\nlih := BIPV2_Files.files_empid(\'BIPV2_EmpID\').DS_BUILDING;\n#workunit(\'name\',\'BIPV2_EmpID \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n' ;    
      eclPost_prep		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_EmpID @version@ PostProcess\');\n';
     
      eclInit		:= eclInit_prep + 'BIPV2_EmpID._proc_empid(                                   ).initFromEmpID_Down('  + #TEXT(p_Init_File)+ ');';
      eclSpec		:= eclSpec_prep + 'BIPV2_EmpID._proc_empid(lih,iteration,\'' + pversion + '\' ).runSpecBuild;';
      eclIter		:= eclIter_prep + 'BIPV2_EmpID._proc_empid(lih,iteration,\'' + pversion + '\' ).runIter;';
      eclPost		:= eclPost_prep + 'BIPV2_EmpID._proc_empid(,\'\',\'' + pversion + '\'         ).updateSuperfiles  (,' + #TEXT(p_Init_File)+ ');';

      eclsetResults   := [ 'PreClusterCount PreClusterCount.empid_cnt'        
                          ,'PostClusterCount PostClusterCount.empid_cnt'       
                          ,'MatchesPerformed'      
                          ,'BasicMatchesPerformed'
                          ,'SlicesPerformed'
                          // ,'LinkBlockSplits'
                          ,'recordsrejected0'
                          ,'unlinkablerecords0'
                         ];
      StopCondition   := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
      SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

      kickInit   := Workman.mac_WorkMan(eclInit   ,version,cluster ,1         ,1  ,pBuildName := 'EmpIDInit' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Init'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );

      kickSpec   := Workman.mac_WorkMan(eclSpec   ,version,cluster ,1         ,1  ,pBuildName := 'EmpIDSpecs' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Specificities'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );
      
      kickiters := Workman.mac_WorkMan(eclIter,version ,cluster,startiter,lnumitersmax,lnumiters   
        ,pSetResults          := eclsetResults
        ,pStopCondition       := StopCondition
        ,pSetNameCalculations := SetNameCalculations
        ,pBuildName           := 'EmpIDIters'
        ,pNotifyEmails        := pEmailList
        ,pOutputFilename      := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_empid.iterations'
        ,pOutputSuperfile     := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly         := pCompileTest
      );

      kickPost   := Workman.mac_WorkMan(eclPost   ,version,cluster ,1         ,1  ,pBuildName := 'EmpIDPost' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Post'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
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
	//		multi := BIPV2_EmpID._proc_empid().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);
	
end;
