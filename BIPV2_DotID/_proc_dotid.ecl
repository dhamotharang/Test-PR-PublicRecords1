import BIPV2_Files, BIPV2, BIPV2_DOTID,wk_ut,tools,std, BIPV2_Strata,Strata,BIPV2_Build, linkingtools;
// Init receives a file in common layout, and narrows it for use in all iterations. We widen
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common  := BIPV2.CommonBase.Layout;
l_base    := BIPV2_Files.files_dotid('BIPV2_DOTID').l_DOTID;
export _proc_dotid(
	 dataset(l_base)  input                 = dataset([],l_base)
	,string           iter                  = ''
  ,string           Build_Date            = BIPV2.KeySuffix
  ,boolean          pFix_Dotid_Overlinks  = true
  
) := module
	
  shared _files_dotid := BIPV2_Files.files_dotid('BIPV2_DOTID');
  
	/* ---------------------- Files -------------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_dotid('BIPV2_DOTID').FILE_DOT_SALT_OP              + '::' + Build_Date + '::it' + istr;
	shared f_hist(string istr)	:= BIPv2_Files.files_dotid('BIPV2_DOTID').FILE_DOT_SALT_POSSIBLE_MATCH  + '::' + Build_Date + '::it' + istr;
	shared f_init								:= BIPv2_Files.files_dotid('BIPV2_DOTID').FILE_INIT                     + '::' + Build_Date;
	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := 
  FUNCTION
	
		ds_set_dotid := PROJECT(ds, transform(l_common,SELF.dotid := IF(left.dotid=0 OR idReset, left.rcid, left.dotid),self := left)); //initialize dotid
    
		ds_fix_overlinks := BIPV2_Files.tools_dotid().Fix_Dotid_Overlinks(ds_set_dotid  ,dotid  ,rcid); //fix dotid overlinks
    
    ds_base := if(pFix_Dotid_Overlinks = true  ,ds_fix_overlinks  ,ds_set_dotid);
    
    ds_return := project(ds_base  ,l_base); //slim it down for dotid internal linking
      
		RETURN ds_return;
	END;
	
	// SHARED ds_ingest := project(dataset('~thor_data400::bipv2::internal_linking::20150828_append_did_fix_dotid_overlinking',bipv2.CommonBase.layout,thor),recordof(BIPV2_Files.files_ingest.DS_BASE));
	SHARED ds_ingest := BIPV2_Files.files_ingest.DS_BASE;
	/* ----------------- Quick Simple BIP ID Sanity Check(using Strata) ------------------- */
  import strata,bipv2_strata,bipv2;
  export preProcessStrata(
     DATASET(BIPV2.CommonBase.Layout)  pingest     = BIPV2_Files.files_ingest.DS_BASE
    ,DATASET(l_base                 )  pPrep       = preProcess(pingest,false)
    ,string                            pversion    = Build_Date
    ,boolean                           pIsTesting  = wk_ut._constants.IsDev
  ) :=
    BIPV2_Strata.mac_BIP_ID_Check(pPrep,'Dotid','Preprocess',pversion,pIsTesting);
  
  export kick_copy2_storage_thor_init  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_ingest.FILE_BASE)[1].name) ,Build_Date ,'dotid_preprocess');
  export copy2StorageThor_init         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_init ,named('copy2_Storage_Thor_Preprocess_html')));  //copy orig file to storage thor

	/* ----------------- Init (from Ingest by default) ------------------- */
	EXPORT init(DATASET(l_common) ds=ds_ingest, BOOLEAN idReset=FALSE) := SEQUENTIAL(
		 _files_dotid.clearDotIdBuilding
		,OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE)
    ,if(not wk_ut._constants.IsDev ,preProcessStrata(,preProcess(ds,idReset)))
		,_files_dotid.updateDotIdBuilding(f_init)
    ,copy2StorageThor_init
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_ingest.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
	);
	/* ---------------------- Post-processing ---------------------------- */
	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_ingest) := FUNCTION
		RETURN JOIN(
			ds_common, ds,
			LEFT.rcid=RIGHT.rcid,
			TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT),
			KEEP(1), HASH);
	END;
	/* ---------------------- SALT Specificities ------------------------- */
  import SALTTOOLS22;
	shared specMod := BIPV2_DOTID.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := sequential(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift'))  ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_DOTID._SPC',input,,false,true)); //add patching of specs to spc file attribute
	
	/* ---------------------- SALT Iteration ----------------------------- */
	// shared possibleMatches := output(BIPV2_DOTID.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPV2_DOTID.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	/*-----------------------For Persistence stats of the dot cluster and records -------------*/
  import BIPV2_QA_Tool;
  shared the_base:=	dataset(f_out(iter),l_base,thor);
	shared the_father:=BIPV2.CommonBase.DS_BASE;
	shared ds_dotid_persistence_stats                := BIPV2_Strata.PersistenceStats(the_base,the_father,rcid,dotid) : independent;
	shared QA_Tool_Dotid_persistence_record_stats    := BIPV2_QA_Tool.mac_persistence_records_stats(ds_dotid_persistence_stats ,'dotid' ,Build_Date);
  shared QA_Tool_Dotid_persistence_cluster_stats   := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_dotid_persistence_stats ,'dotid' ,Build_Date);

	/* ---------------------- SALT Output -------------------------------- */

	export updateBuilding(string fname=f_out(iter)) := _files_dotid.updateDotIDBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter),DATASET(l_common) ds=ds_ingest) :=
  function
  
    kick_copy2_storage_thor_post  := BIPV2_Tools.Copy2_Storage_Thor(fname ,Build_Date ,'dotid_postprocess');
    copy2StorageThor_post         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_post ,named('copy2_Storage_Thor_Postprocess_html')));  //copy orig file to storage thor

    return sequential(
       output(postProcess(dataset(fname,l_base,thor),ds),, fname+'_post', compressed, overwrite)
      ,Strata.macf_CreateXMLStats(ds_dotid_persistence_stats ,'BIPV2','Persistence'	,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'DOTID','Stats',false,false) //group on cluster_type, stat_desc
      ,QA_Tool_Dotid_persistence_record_stats 
      ,QA_Tool_Dotid_persistence_cluster_stats
      ,_files_dotid.updateDotIdSuperfiles(fname+'_post')
      ,copy2StorageThor_post
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
    );
  end;
	
	/* ---------------------- SALT History ------------------------------- */
	// export updateLinkHist   	:= _files_dotid.updateDotIDLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_DOTID._Samples(input).out;
	/* ---------------------- Inline Iteration Run for Testing ----------- */	
	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
		ds1 := preProcess(ds, FALSE);
		ds2 := BIPV2_DOTID.matches(ds1,BIPV2_DOTID.Config.MatchThreshold).patched_infile;
		ds3 := postProcess(ds2,ds);
    RETURN ds3;
  end;
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
  import BIPV2_build;
  export runSpecs(pversion = 'BIPV2.KeySuffix',pInputfile = 'BIPV2.CommonBase.DS_BUILT',pDoSpecs = 'true') := 
  functionmacro
		eclSpec		:= 'import BIPV2_Files,BIPV2_build;\npversion  := \'@version@\';\nlih := project(' + #TEXT(pInputfile) + ',BIPV2_Files.files_dotid(\'BIPV2_DOTID\').l_DOTID);\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2 DotID \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\nBIPV2_DOTID._proc_dotid(lih).runSpecBuild;';
		cluster		:= BIPV2_build._Constants().Groupname; // NOTE: See if we can parameterize this
 		kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'DotSpecsPost',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + pversion + '::workunit_history::proc_dotid.Specificities.Post'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
    );
 
    return kickSpec;
 endmacro;
 
  import BIPV2_QA_Tool;
  export dotid_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,dotid ,Build_Date  ,iter  ,BIPV2_DotID.Config.MatchThreshold ,'BIPV2_DotID');

	export runIter := sequential(linking, outputReviewSamples, updateBuilding(),dotid_iteration_stats/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'DotID')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'DotID'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter_wuName(unsigned startIter, unsigned numIters) := 
		'BIPV2_DOTID Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
	export MultIter_run(
     startIter          = '\'\''
    ,numIters           = '3'
    ,doInit             = 'true'
    ,doSpec             = 'true'
    ,doIters            = 'true'
    ,doPost             = 'true'
    ,pversion           = 'bipv2.keysuffix'
    ,p_Init_File        = 'BIPV2_Files.files_ingest.DS_BASE'
    ,pFixDotidOverlinks = 'true'
    ,pcluster           = 'BIPV2_Build._Constants().Groupname'
    ,pEmailList         = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
    ,pCompileTest       = 'false'                                               
    
  ) := 
  functionmacro
  
		import Workman, tools,BIPV2_build;
    
    fbool_dotid(boolean pinput) := if(pinput = true,'true','false');
    lnumiters     := numIters         ;
    lnumitersmax  := numIters + 1     ;
		cluster		:= pcluster; // NOTE: See if we can parameterize this
		version		:= pversion;
		// lastIter	:= (string)(startiter - 1 + numIters);
    
		eclInit_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_DOTID \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n'                                                                            ;        
		eclSpec_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_dotid(\'BIPV2_DOTID\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_DOTID \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n'     ;
		eclIter_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_dotid(\'BIPV2_DOTID\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_DOTID \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n'  ;
		eclPost_prep		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_DOTID @version@ PostProcess\');\n'                                                                                                                                                                                                                                        ;   
                  
		eclInit		:= eclInit_prep + 'BIPV2_DOTID._proc_dotid(   ,         ,\''         + pversion + '\',' + fbool_dotid(pFixDotidOverlinks) + ').init('               + #TEXT(p_Init_File)+ ');';
		eclSpec		:= eclSpec_prep + 'BIPV2_DOTID._proc_dotid(lih,iteration,\''         + pversion + '\',' + fbool_dotid(pFixDotidOverlinks) + ').runSpecBuild;';
		eclIter		:= eclIter_prep + 'BIPV2_DOTID._proc_dotid(lih,iteration,\''         + pversion + '\',' + fbool_dotid(pFixDotidOverlinks) + ').runIter;';
		eclPost		:= eclPost_prep + 'BIPV2_DOTID._proc_dotid(   ,\'\'     ,\''         + pversion + '\',' + fbool_dotid(pFixDotidOverlinks) + ').updateSuperFiles(,'  + #TEXT(p_Init_File)+ ');';

    eclsetResults   := [ 'PreClusterCount PreClusterCount.DOTid_Cnt'        
                        ,'PostClusterCount PostClusterCount.DOTid_Cnt'       
                        ,'MatchesPerformed'      
                        ,'BasicMatchesPerformed'
                        ,'SlicesPerformed'
                        ,'DOTidsCreatedByCleave'
                        ,'LinkBlockSplits'
                        ,'recordsrejected0'
                        ,'unlinkablerecords0'
                       ];
    StopCondition   := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
    SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

    kickInit   := Workman.mac_WorkMan(eclInit   ,version,cluster ,1         ,1  ,pBuildName := 'DOTIDInit' ,pNotifyEmails := pEmailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Init'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
    );
    kickSpec   := Workman.mac_WorkMan(eclSpec   ,version,cluster ,1         ,1  ,pBuildName := 'DotSpecs' ,pNotifyEmails := pEmailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Specificities'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
    );

    kickiters := Workman.mac_WorkMan(eclIter,version ,cluster,startiter,lnumitersmax,lnumiters   
      ,pSetResults          := eclsetResults
      ,pStopCondition       := StopCondition
      ,pSetNameCalculations := SetNameCalculations
      ,pBuildName           := 'DotIters'
      ,pNotifyEmails        := pEmailList
      ,pOutputFilename      := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_dotid.iterations'
      ,pOutputSuperfile     := '~BIPV2_build::qa::workunit_history'                                            
      ,pCompileOnly         := pCompileTest
    );
    
    kickPost   := Workman.mac_WorkMan(eclPost   ,version,cluster ,1         ,1  ,pBuildName := 'DOTIDPost' ,pNotifyEmails := pEmailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Post'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pCompileOnly         := pCompileTest
    );
		return sequential(
			 if(doInit ,kickInit  )
			,if(doSpec ,kickSpec	)
			,if(doIters,kickiters )
			,if(doPost ,kickPost  )
		);
	endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 47; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 5;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		#workunit('name',BIPV2_DOTID._proc_dotid().MultIter_wuName(startIter,numIters));
	//		BIPV2_DOTID._proc_dotid().MultIter_run(startIter,numIters,doSpec);
	
end;
