/*
  // -- example of a run
EmpStartIteration  := 1   ;
EmpNumIterations   := 1   ;
doEmpid_DownInit   := true;
doEmpid_DownSpecs  := true;
doEmpid_DownIters  := true;
doEmpid_DownPost   := true;
pversion           := '20151023';
// startfile          := project(dataset('~thor_data400::bipv2::internal_linking::20150828_append_did_fix_Empid_Down_overlinking',bipv2.CommonBase.layout,thor),recordof(BIPV2_Files.files_ingest.DS_BASE));
BIPV2_EmpID_Down._proc_Empid_Down().MultIter_run (EmpStartIteration     ,EmpNumIterations      ,doEmpid_DownInit ,doEmpid_DownSpecs  ,doEmpid_DownIters  ,doEmpid_DownPost ,pversion  
,dataset('~thor_data400::bipv2_dotid_dev::salt_iter::20151023::it1_post.fixed_empids',bipv2.CommonBase.layout,thor) // if overriding the default, this should be declared here, in the parameter pass
);
*/
IMPORT BIPV2_Files, BIPV2, BIPV2_EmpID_Down,wk_ut,tools,std;
l_base := BIPV2.CommonBase.Layout;
EXPORT _proc_empid_down(
	 DATASET(l_base) input      = BIPV2_EmpID_Down.In_EmpID
	,STRING          iter       = ''
  ,string          Build_Date = BIPV2.KeySuffix
) := MODULE
	
  shared _files_empid_down := BIPV2_Files.files_empid_down('BIPV2_EmpID_Down');
	/* ---------------------- Logical Files ------------------------------- */
	export f_out(string istr)		:= _files_empid_down.FILE_SALT_OP             + '::' + Build_Date + '::it' + istr ;
	shared f_hist(string istr)	:= _files_empid_down.FILE_SALT_POSSIBLE_MATCH + '::' + Build_Date + '::it' + istr ;
	shared f_init								:= _files_empid_down.FILE_INIT                + '::' + Build_Date                 ;
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_base) ds, BOOLEAN idReset) := FUNCTION
		l_base toBase(l_base L) := TRANSFORM
			SELF.empid := IF(L.empid=0 OR idReset, L.dotid, L.empid);
			SELF := L;
		END;
		ds_base := PROJECT(ds,toBase(LEFT));
		RETURN ds_base;
	END;
	
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  export dostrata_ID_Check(dataset(BIPV2.CommonBase.Layout) pinput = dataset([],BIPV2.CommonBase.Layout),boolean pidreset = true,dataset(l_base) pDataset = preProcess(pinput,pidreset),string pversion = Build_Date ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'EMPIDDOWN','Preprocess',pversion,pIsTesting);
	
  /* ---------------------- Init From POWID ---------------------------- */
	SHARED ds_powid := BIPV2_Files.files_powid().DS_BASE;
  export kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid().FILE_BASE)[1].name) ,Build_Date ,'empid_down_preprocess');
  export copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

	EXPORT init(DATASET(l_base) ds = ds_powid, BOOLEAN idReset=FALSE) := SEQUENTIAL(
		_files_empid_down.clearBuilding
		,OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE)
    ,if(not wk_ut._constants.IsDev ,dostrata_ID_Check(ds,idReset))
		,_files_empid_down.updateBuilding(f_init)
    ,copy2StorageThor
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid().FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
	);
	EXPORT initFromPOWID := sequential(
     init(ds_powid,TRUE)
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_powid().FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  ); // HACK - preserve id values someday
	
	/* ---------------------- SALT Specificities ------------------------- */
	// shared specMod := BIPV2_EmpID_Down.specificities(input);
	// shared specBuild := specMod.Build;
	// shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches  := output(BIPV2_EmpID_Down.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	        := BIPV2_EmpID_Down.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	        := parallel(saltmod.DoAllAgain/*, possibleMatches*/);
		
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding   (string fname=f_out(iter)) := _files_empid_down.updateBuilding  (fname);
	export updateSuperfiles (string fname=f_out(iter)) := _files_empid_down.updateSuperfiles(fname);
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	  := _files_empid_down.updateLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples  := BIPV2_EmpID_Down._Samples().out;
	/* ---------------------- Take Action -------------------------------- */
	// export runSpecBuild := sequential(specBuild, specDebug);
	
	/*-----------------------QA Tool Iteration Stats -------------*/
  import BIPV2_QA_Tool;
  export Empid_Down_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,empid ,Build_Date  ,iter  ,BIPV2_Empid_down.Config.MatchThreshold ,'BIPV2_Empid_Down');

	export runIter := sequential(linking, outputReviewSamples, updateBuilding(),Empid_Down_iteration_stats/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'EmpID_Down')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'EmpID_Down'));
	
	// export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter_wuName(unsigned startIter, unsigned numIters) := 
			'BIPV2_EmpID_Down Controller ' + Build_Date + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);

	export MultIter_run(
       startIter    = '1' //starting from scratch each build, so start at one
      ,numIters     = '6'
      ,doInit       = 'true'
      ,dospec       = 'true'
      ,doIters      = 'true'
      ,doPost       = 'true'
      ,pversion     = 'bipv2.keysuffix'
      ,p_Init_File  = 'BIPV2_Files.files_powid().DS_BASE'
      ,pcluster     = 'BIPV2_Build._Constants().Groupname'
      ,pEmailList   = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
      ,pCompileTest = 'false'                                               
      
   ) :=
   functionmacro
   
			import Workman, tools,BIPV2_build;
      
			cluster		    := pcluster;
			version		    := pversion;
      lnumiters     := numIters         ;
      lnumitersmax  := numIters + 1     ;
      
			eclInit_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_EmpID_Down \' + pversion + \' Init \');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' ;
			eclIter_prep		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_empid_down(\'BIPV2_EmpID_Down\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_EmpID_Down \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n' ;
      eclPost_prep		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_EmpID_Down @version@ PostProcess\');\n' ;
      
      eclInit		:= eclInit_prep + 'BIPV2_EmpID_Down._proc_empid_down(   ,           ,\'' + pversion + '\').init            (' + #TEXT(p_Init_File)+ ');';
      eclIter		:= eclIter_prep + 'BIPV2_EmpID_Down._proc_empid_down(lih,iteration  ,\'' + pversion + '\').runIter                                    ;';
      eclPost		:= eclPost_prep + 'BIPV2_EmpID_Down._proc_empid_down(   ,\'\'       ,\'' + pversion + '\').updateSuperfiles(                         );';

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

      kickInit   := Workman.mac_WorkMan(eclInit   ,version,cluster ,1         ,1  ,pBuildName := 'EmpDownInit' ,pNotifyEmails := pEmailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid_down.Init'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );

      kickiters := Workman.mac_WorkMan(eclIter,version ,cluster,startiter,lnumitersmax,lnumiters   
        ,pSetResults          := eclsetResults
        ,pStopCondition       := StopCondition
        ,pSetNameCalculations := SetNameCalculations
        ,pBuildName           := 'EmpIDIters'
        ,pNotifyEmails        := pEmailList
        ,pOutputFilename      := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_empid_down.iterations'
        ,pOutputSuperfile     := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly         := pCompileTest
     );
     
      kickPost   := Workman.mac_WorkMan(eclPost   ,version,cluster ,1         ,1  ,pBuildName := 'EmpDownPost' ,pNotifyEmails := pEmailList
        ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid_down.Post'
        ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
        ,pCompileOnly      := pCompileTest
      );

			return sequential(
				 if(doInit  ,kickInit )
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
	//		proc := BIPV2_EmpID_Down._proc_empid_down();
	//		#workunit('name',proc.MultIter_wuName);
	//		proc.MultIter_run(startIter,numIters,doInit,doSpec);
end;
