import BIPV2_Files, BIPV2, MDR, BIPV2_LGID3_dev2,ut,bipv2_build,wk_ut,tools,std,BIPV2_Tools,mdr,SALTTOOLS22;

// Init receives a file in common layout, and narrows it for use in all iterations. We widen
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common  := BIPV2.CommonBase.Layout;
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;

export _proc_lgid3(

 	 dataset(l_base)  input     = dataset([],l_base)
  ,string           iter      = ''
  ,string           pversion  = BIPV2.KeySuffix

) := module
	
	/* ---------------------- Logical Files ------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_lgid3.FILE_SALT_OP + '::' + pversion + '::it' + istr ;
	shared f_hist(string istr)	:= BIPv2_Files.files_lgid3.FILE_SALT_POSSIBLE_MATCH + '::' + pversion + '::it' + istr ;
	shared f_init								:= BIPv2_Files.files_lgid3.FILE_INIT + '::' + pversion;
	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds) := FUNCTION
		l_base toBase(l_common L) := TRANSFORM
			isLegal	:= (L.company_name_type_derived='LEGAL' or (L.company_name_type_derived='FBN' and mdr.sourcetools.sourceisCorpV2(L.source)));
			SELF.company_name				:= if(isLegal, L.company_name, '');	// BLANK except for Legal Names
			SELF.cnp_number					:= if(isLegal, L.cnp_number, '');		// BLANK except for legal Names
      self.sbfe_id            := if(mdr.sourceTools.SourceIsBusiness_Credit(l.source) ,l.vl_id ,'');
			SELF.seleid							:= if(L.seleid > 0, L.seleid, L.lgid3);
			SELF.orgid							:= if(L.orgid > 0, L.orgid, L.lgid3);
			SELF.ultid							:= if(L.ultid > 0, L.ultid, L.lgid3);
			SELF := L;
		END;
		
		ds_init := BIPV2_Tools.initParentID(ds, proxid, lgid3);
		ds_base := PROJECT(ds_init,toBase(LEFT));
		RETURN ds_base;

	END;
		
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  export dostrata_ID_Check(dataset(l_common) pDataset ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'LGID3','Preprocess',pversion,pIsTesting);

	/* ---------------------- Init From Hrchy ---------------------------- */
	// SHARED ds_hrchy := dataset(ut.foreign_prod + 'thor_data400::bipv2::internal_linking::building::20141015',BIPV2.CommonBase.Layout,thor);//(v_city_name in ['BOCA RATON','DAYTON','SPRINGBORO','MIAMISBURG'],st in ['FL','OH']);//HACK
	SHARED ds_hrchy := BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING;
	EXPORT init(DATASET(l_common) ds=ds_hrchy, BOOLEAN idReset=false) := SEQUENTIAL(
     dostrata_ID_Check(ds_hrchy)
		,BIPV2_Files.files_lgid3.clearBuilding
		,OUTPUT(preProcess(ds),,f_init,COMPRESSED,OVERWRITE)
		,BIPV2_Files.files_lgid3.updateBuilding(f_init)
	);


	EXPORT initFromHrchy := sequential(
     init(ds_hrchy, TRUE)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_hrchy.FILENAME_HRCY_BASE_LF_FULL_BUILDING)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  ); // HACK - preserve id values someday
	
	
	/* ---------------------- Post-processing ---------------------------- */
	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_hrchy) := FUNCTION
	
		// Restore the fields we selectively blanked during init
		l_common toRestore(l_base L, l_common R) := TRANSFORM
			SELF.company_name	:= R.company_name;
			SELF.cnp_number		:= R.cnp_number;
			SELF := L; // pick up any changes from linking
			SELF := R; // then re-widen back to the common layout
		END;
		ds_restore := JOIN(ds, ds_common, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), HASH);
				
		RETURN ds_restore;
	end;
	
	
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod := BIPV2_LGID3_dev2.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift'))
                      ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_LGID3_dev2._SPC',input,,false));
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches := output(BIPV2_LGID3_dev2.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPV2_LGID3_dev2.Proc_Iterate(iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain, possibleMatches);
	
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := BIPv2_Files.files_lgid3.updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter), dataset(l_common) ds_common=ds_hrchy) := sequential(
		output(postProcess(dataset(fname,l_base,thor),ds_common),, fname+'_post', compressed, overwrite),
		BIPv2_Files.files_lgid3.updateSuperfiles(fname+'_post')
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
	);
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= BIPv2_Files.files_lgid3.updateLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_LGID3_dev2._Samples(input).out;

	/* ---------------------- Inline Iteration Run for Testing ----------- */	
	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
		ds1 := preProcess(ds);
		mod := BIPV2_LGID3_dev2.matches(ds1,BIPV2_LGID3_dev2.Config.MatchThreshold);
		ds2 := mod.patched_infile;
		ds3 := postProcess(ds2,ds);
		// output(mod.MatchesPerformed, named('LGID3_MatchesPerformed'));
    RETURN ds3;
  end;
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	export runIter := sequential(linking, outputReviewSamples, updateBuilding(), updateLinkHist)
		: SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'LGID3')),
			FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'LGID3'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
			'BIPV2_LGID3_dev2 Controller ' + pversion + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
  export MultIter_run(startIter, numIters,doInit,doSpec,doIter = 'true',doPost = 'true') := functionmacro
    import wk_ut, tools,bipv2_build;
    pHint     := if(_Control.ThisEnvironment.name='Dataland','40'/*HACK*/,'20');
    cluster		:= BIPV2_Build._Constants().Groupname;
    version		:= pversion;
    previter	:= (string)(startiter - 1);
    lastIter	:= (string)(startiter - 1 + numIters);
    eclInit		:= 'import BIPV2_Files,BIPV2_LGID3_dev2;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_LGID3_dev2 \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n' + 'BIPV2_LGID3_dev2._proc_lgid3(,,pversion).initFromHrchy;\n';
    eclSpec		:= 'import BIPV2_Files,BIPV2_LGID3_dev2;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_LGID3_dev2.In_LGID3;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_LGID3_dev2 \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\nBIPV2_LGID3_dev2._proc_lgid3(lih,iteration,pversion).runSpecBuild;\n';
    eclIter		:= 'import BIPV2_Files,BIPV2_LGID3_dev2;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_LGID3_dev2.In_LGID3;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_LGID3_dev2 \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\nBIPV2_LGID3_dev2._proc_lgid3(lih,iteration,pversion).runIter;\n';
    eclPost		:= 'import BIPV2_LGID3_dev2;\n\n#workunit(\'name\',\'BIPV2_LGID3_dev2 @version@ PostProcess\');\n\n#workunit(\'priority\',\'high\');\n\n#OPTION(\'multiplePersistInstances\',FALSE);\npversion  := \'@version@\';\n' + 'BIPV2_LGID3_dev2._proc_lgid3(,\'' + lastIter + '\',pversion).updateSuperfiles()';
    kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Init',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Init'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
   );
    kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Specs',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
   );
    kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount[1].lgid3_count','{UNSIGNED rcid_Count,UNSIGNED lgid3_count}','PostClusterCount PostClusterCount[1].lgid3_count','{UNSIGNED rcid_Count,UNSIGNED lgid3_count}','BasicMatchesPerformed','MatchesPerformed','SlicesPerformed'],cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Iters',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::@version@_@iteration@::workunit_history::proc_lgid3.iterations'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_lgid3.iterations'
      ,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_lgid3.iterations'                                                 
    );
    kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Post',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Post'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
    );
    return sequential(
       if(doInit  ,kickInit)
      ,if(doSpec  ,kickSpec)
      ,if(doIter  ,kickiters)
      ,if(doPost  ,kickPost)
      // ,BIPV2_Build._proc_lgid3(,lastIter).updateSuperfiles()
    );
  endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_Build._proc_lgid3().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);

	
end;