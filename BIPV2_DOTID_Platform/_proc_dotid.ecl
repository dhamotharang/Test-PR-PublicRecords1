import BIPV2_Files, BIPV2, bipv2_build, BIPV2_DOTID_PLATFORM,BIPV2_Testing,wk_ut,tools,std;
// Init receives a file in common layout, and narrows it for use in all iterations. We widen
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common  := BIPV2_Testing.Test_Layout;
l_base    := BIPV2_Files.files_dotid('BIPV2_DOTID_PLATFORM').l_DOTID;
export _proc_dotid(
	 dataset(l_base)  input                 = dataset([],l_base)
	,string           iter                  = ''
  ,string           Build_Date            = BIPV2.KeySuffix
  ,boolean          pFix_Dotid_Overlinks  = true
  
) := module
	
  shared _files_dotid := BIPV2_Files.files_dotid('BIPV2_DOTID_PLATFORM');
  
	/* ---------------------- Files -------------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_dotid('BIPV2_DOTID_PLATFORM').FILE_DOT_SALT_OP              + '::' + Build_Date + '::it' + istr;
	shared f_hist(string istr)	:= BIPv2_Files.files_dotid('BIPV2_DOTID_PLATFORM').FILE_DOT_SALT_POSSIBLE_MATCH  + '::' + Build_Date + '::it' + istr;
	shared f_init								:= BIPv2_Files.files_dotid('BIPV2_DOTID_PLATFORM').FILE_INIT                     + '::' + Build_Date;
	
	
	/* ---------------------- Pre-processing ---------------------------- */
/* 	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := 
     FUNCTION
   	
   		ds_set_dotid := PROJECT(ds, transform(l_common,SELF.dotid := IF(left.dotid=0 OR idReset, left.rcid, left.dotid),self := left)); //initialize dotid
       
   		ds_fix_overlinks := BIPV2_Files.tools_dotid().Fix_Dotid_Overlinks(ds_set_dotid  ,dotid  ,rcid); //fix dotid overlinks
       
       ds_base := if(pFix_Dotid_Overlinks = true  ,ds_fix_overlinks  ,ds_set_dotid);
       
       ds_return := project(ds_base  ,l_base); //slim it down for dotid internal linking
         
   		RETURN ds_return;
   	END;
*/
	
	// SHARED ds_ingest := project(dataset('~thor_data400::bipv2::internal_linking::20150828_append_did_fix_dotid_overlinking',bipv2.CommonBase.layout,thor),recordof(BIPV2_Files.files_ingest.DS_BASE));
	SHARED ds_ingest := BIPV2_Files.files_ingest.DS_BASE;
	/* ----------------- Quick Simple BIP ID Sanity Check(using Strata) ------------------- */
  import strata,bipv2_strata,bipv2;
/*   export preProcessStrata(
        DATASET(BIPV2.CommonBase.Layout)  pingest     = BIPV2_Files.files_ingest.DS_BASE
       ,DATASET(l_base                 )  pPrep       = preProcess(pingest,false)
       ,string                            pversion    = Build_Date
       ,boolean                           pIsTesting  = wk_ut._constants.IsDev
     ) :=
       BIPV2_Strata.mac_BIP_ID_Check(pPrep,'Dotid','Preprocess',pversion,pIsTesting);
     
*/
	/* ----------------- Init (from Ingest by default) ------------------- */
/* 	EXPORT init(DATASET(l_common) ds=ds_ingest, BOOLEAN idReset=FALSE) := SEQUENTIAL(
   		 _files_dotid.clearDotIdBuilding
   		,OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE)
       ,if(not wk_ut._constants.IsDev ,preProcessStrata(,preProcess(ds,idReset)))
   		,_files_dotid.updateDotIdBuilding(f_init)
       ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_ingest.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
   	);
*/
	/* ---------------------- Post-processing ---------------------------- */
/* 	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_ingest) := FUNCTION
   		RETURN JOIN(
   			ds_common, ds,
   			LEFT.rcid=RIGHT.rcid,
   			TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT),
   			KEEP(1), HASH);
   	END;
*/
	/* ---------------------- SALT Specificities ------------------------- */
/*   import SALTTOOLS22;
   	shared specMod := BIPV2_DOTID_PLATFORM.specificities(input);
   	shared specBuild := specMod.Build;
   	shared specDebug := sequential(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift'))  ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_DOTID_PLATFORM._SPC',input,,false,true)); //add patching of specs to spc file attribute
   	
*/
	/* ---------------------- SALT Iteration ----------------------------- */
	// shared possibleMatches := output(BIPV2_DOTID_PLATFORM.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPV2_DOTID_PLATFORM.Proc_Iterate(Build_Date,iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	/* ---------------------- SALT Output -------------------------------- */
	export updateBuilding(string fname=f_out(iter)) := _files_dotid.updateDotIDBuilding(fname);
/* 	export updateSuperfiles(string fname=f_out(iter),DATASET(l_common) ds=ds_ingest) := sequential(
   		 output(postProcess(dataset(fname,l_base,thor),ds),, fname+'_post', compressed, overwrite)
   		,_files_dotid.updateDotIdSuperfiles(fname+'_post')
       ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
   	);
*/
	
	/* ---------------------- SALT History ------------------------------- */
	// export updateLinkHist   	:= _files_dotid.updateDotIDLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_DOTID_PLATFORM._Samples(input).out;
	/* ---------------------- Inline Iteration Run for Testing ----------- */	
/* 	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
   		ds1 := preProcess(ds, FALSE);
   		ds2 := BIPV2_DOTID_PLATFORM.matches(ds1,BIPV2_DOTID_PLATFORM.Config.MatchThreshold).patched_infile;
   		ds3 := postProcess(ds2,ds);
       RETURN ds3;
     end;
*/
	
	/* ---------------------- Take Action -------------------------------- */
/* 	export runSpecBuild := sequential(specBuild, specDebug);
     import BIPV2_build;
     export runSpecs(pversion = 'BIPV2.KeySuffix',pInputfile = 'BIPV2.CommonBase.DS_BASE',pDoSpecs = 'true') := 
     functionmacro
   		eclSpec		:= 'import BIPV2_Files,BIPV2_build;\npversion  := \'@version@\';\nlih := project(' + #TEXT(pInputfile) + ',BIPV2_Files.files_dotid(\'BIPV2_DOTID_PLATFORM\').l_DOTID);\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2 DotID \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\nBIPV2_DOTID_PLATFORM._proc_dotid(lih).runSpecBuild;';
   		cluster		:= BIPV2_build._Constants().Groupname; // NOTE: See if we can parameterize this
    		kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'DotSpecsPost',pNotifyEmails := BIPV2_build.mod_email.emailList
         ,pOutputFilename   := '~BIPV2_build::' + pversion + '::workunit_history::proc_dotid.Specificities.Post'
         ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
       );
    
       return kickSpec;
    endmacro;
*/
  
	export runIter := sequential(linking, outputReviewSamples, updateBuilding()/*, updateLinkHist*/)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'DotID')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'DotID'));
	
/* 	export runSpecIter := sequential(specBuild,runIter);
   	
   	export MultIter_wuName(unsigned startIter, unsigned numIters) := 
   		'BIPV2_DOTID_PLATFORM Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
   	export MultIter_run(startIter, numIters, doInit, doSpec, doIters='true', doPost='true',pversion = 'bipv2.keysuffix',p_Init_File = 'BIPV2_Files.files_ingest.DS_BASE',pFixDotidOverlinks = 'true') := functionmacro
   		import wk_ut, tools,BIPV2_build;
       fbool(boolean pinput) := if(pinput = true,'true','false');
   		cluster		:= BIPV2_build._Constants().Groupname; // NOTE: See if we can parameterize this
   		version		:= pversion;
   		previter	:= (string)(startiter - 1);
   		lastIter	:= (string)(startiter - 1 + numIters);
   		eclInit		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_DOTID_PLATFORM \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n'                                                                                + 'BIPV2_DOTID_PLATFORM._proc_dotid(   ,         ,\''         + pversion + '\',' + fbool(pFixDotidOverlinks) + ').init('               + #TEXT(p_Init_File)+ ');';
   		eclSpec		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_dotid(\'BIPV2_DOTID_PLATFORM\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_DOTID_PLATFORM \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\n'     + 'BIPV2_DOTID_PLATFORM._proc_dotid(lih,iteration,\''         + pversion + '\',' + fbool(pFixDotidOverlinks) + ').runSpecBuild;';
   		eclIter		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_Files.files_dotid(\'BIPV2_DOTID_PLATFORM\').DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_DOTID_PLATFORM \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n'  + 'BIPV2_DOTID_PLATFORM._proc_dotid(lih,iteration,\''         + pversion + '\',' + fbool(pFixDotidOverlinks) + ').runIter;';
   		eclPost		:= 'import BIPV2_build;\n#workunit(\'name\',\'BIPV2_DOTID_PLATFORM @version@ PostProcess\');\n'                                                                                                                                                                                                                                            + 'BIPV2_DOTID_PLATFORM._proc_dotid(,\'' + lastIter + '\',\'' + pversion + '\',' + fbool(pFixDotidOverlinks) + ').updateSuperFiles(,'  + #TEXT(p_Init_File)+ ')';
   		kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'DOTIDInit',pNotifyEmails := BIPV2_build.mod_email.emailList
         ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Init'
         ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
       );
   		kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'DotSpecs',pNotifyEmails := BIPV2_build.mod_email.emailList
         ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Specificities'
         ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
       );
   		kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount[1].Dotid_Count'   ,'{UNSIGNED rcid_Count,UNSIGNED Dotid_Count}','PostClusterCount PostClusterCount[1].Dotid_Count'  ,'{UNSIGNED rcid_Count,UNSIGNED Dotid_Count}','MatchesPerformed','BasicMatchesPerformed','SlicesPerformed','DOTidsCreatedByCleave'],cluster,pOutputEcl := false,pUniqueOutput := 'DotIters',pNotifyEmails := BIPV2_build.mod_email.emailList
         ,pOutputFilename   := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_dotid.iterations'
         ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history'                                            
         ,pSummaryFilename  := '~BIPV2_build::@version@_@iteration@::summary_report::proc_dotid.iterations'
         ,pSummarySuperfile := '~BIPV2_build::qa::summary_report::proc_dotid.iterations'                                                 
       );
   		kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'DOTIDPost',pNotifyEmails := BIPV2_build.mod_email.emailList
         ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_dotid.Post'
         ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
       );
   		return sequential(
   			 if(doInit ,kickInit  )
   			,if(doSpec ,kickSpec	)
   			,if(doIters,kickiters )
   			,if(doPost ,kickPost  )
   		);
   	endmacro;
*/
	// EXAMPLE for calling MultIter...
	//		startIter	:= 47; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 5;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		#workunit('name',BIPV2_DOTID_PLATFORM._proc_dotid().MultIter_wuName(startIter,numIters));
	//		BIPV2_DOTID_PLATFORM._proc_dotid().MultIter_run(startIter,numIters,doSpec);
	
end;
