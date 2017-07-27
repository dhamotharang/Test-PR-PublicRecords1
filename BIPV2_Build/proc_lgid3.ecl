/*2014-05-16T18:49:29Z (vern_p bentley)
check-in for BIPV2 Sprint 16
*/
import BIPV2_Files, BIPV2, MDR, BIPv2_LGID3;

l_base := BIPV2.CommonBase.Layout;

export proc_lgid3(
	dataset(l_base) input = dataset([],l_base),
	string iter = '') := module
	
	/* ---------------------- Logical Files ------------------------------- */
	export f_out(string istr)		:= BIPV2_Files.files_lgid3.FILE_SALT_OP + '::' + BIPV2.KeySuffix + '::it' + istr ;
	shared f_hist(string istr)	:= BIPv2_Files.files_lgid3.FILE_SALT_POSSIBLE_MATCH + '::' + BIPV2.KeySuffix + '::it' + istr ;
	shared f_init								:= BIPv2_Files.files_lgid3.FILE_INIT + '::' + BIPV2.KeySuffix;
	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_base) ds, BOOLEAN idReset) := FUNCTION
		l_base toBase(l_base L) := TRANSFORM
			isLegal	:= (L.company_name_type_derived='LEGAL' or (L.company_name_type_derived='FBN' and mdr.sourcetools.sourceisCorpV2(L.source)));
			SELF.lgid3							:= IF(L.lgid3=0 OR idReset, L.proxid, L.lgid3);
			SELF.company_name				:= if(isLegal, L.company_name, '');	// BLANK except for Legal Names
			SELF.cnp_number					:= if(isLegal, L.cnp_number, '');		// BLANK except for legal Names
			SELF := L;
		END;
		ds_base := PROJECT(ds,toBase(LEFT));
		RETURN ds_base;
	END;
	
	
	/* ---------------------- Init From Hrchy ---------------------------- */
	EXPORT init(DATASET(l_base) ds, BOOLEAN idReset=false) := SEQUENTIAL(
		BIPV2_Files.files_lgid3.clearBuilding,
		OUTPUT(preProcess(ds,idReset),,f_init,COMPRESSED,OVERWRITE),
		BIPV2_Files.files_lgid3.updateBuilding(f_init)
	);
	SHARED ds_hrchy := BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING;
	EXPORT initFromHrchy := init(ds_hrchy, TRUE); // HACK - preserve id values someday
	
	
	/* ---------------------- Post-processing ---------------------------- */
	EXPORT DATASET(l_base) postProcess(DATASET(l_base) ds, DATASET(l_base) ds_orig) := FUNCTION
	
		// Restore the fields we selectively blanked during init
		l_base toRestore(l_base L, l_base R) := TRANSFORM
			SELF.company_name	:= R.company_name;
			SELF.cnp_number		:= R.cnp_number;
			SELF := L;
		END;
		ds_restore := JOIN(ds, ds_orig, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), HASH);
				
		RETURN ds_restore;
	end;
	
	
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod := BIPV2_LGID3.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches := output(BIPv2_LGID3.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= BIPv2_LGID3.Proc_Iterate(iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain, possibleMatches);
	
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := BIPv2_Files.files_lgid3.updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter), dataset(l_base) ds_orig=ds_hrchy) := sequential(
		output(postProcess(dataset(fname,l_base,thor), ds_orig),, fname+'_post', compressed, overwrite),
		BIPv2_Files.files_lgid3.updateSuperfiles(fname+'_post')
	);
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= BIPv2_Files.files_lgid3.updateLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_LGID3._Samples(input).out;

	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	export runIter := sequential(linking, outputReviewSamples, updateBuilding(), updateLinkHist)
		: SUCCESS(mod_email.SendSuccessEmail(,'BIPv2', , 'LGID3')),
			FAILURE(mod_email.SendFailureEmail(,'BIPv2', failmessage, 'LGID3'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
			'BIPV2_LGID3 Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
  export MultIter_run(startIter, numIters,doInit,doSpec,doIter = 'true',doPost = 'true') := functionmacro
    import wk_ut, tools;
    pHint     := if(_Control.ThisEnvironment.name='Dataland','dev','20');
    cluster		:= tools.fun_Groupname(pHint);
    version		:= BIPV2.KeySuffix;
    previter	:= (string)(startiter - 1);
    lastIter	:= (string)(startiter - 1 + numIters);
    eclInit		:= 'import BIPV2_Files,BIPV2_Build;iteration := \'@iteration@\';pversion  := \'@version@\';#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' Init \');#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);BIPV2_Build.proc_lgid3().initFromHrchy;';
    eclSpec		:= 'import BIPV2_Files,BIPV2_Build;iteration := \'@iteration@\';pversion  := \'@version@\';lih := BIPV2_Files.files_lgid3.DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' Specificities \');#workunit(\'priority\',\'high\');BIPV2_Build.proc_lgid3(lih,iteration).runSpecBuild;';
    eclIter		:= 'import BIPV2_Files,BIPV2_Build;iteration := \'@iteration@\';pversion  := \'@version@\';lih := BIPV2_Files.files_lgid3.DS_BUILDING;\n#OPTION(\'multiplePersistInstances\',FALSE);#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' iter \' + iteration);#workunit(\'priority\',\'high\');BIPV2_Build.proc_lgid3(lih,iteration).runIter;';
    eclPost		:= 'import BIPV2_Build;\n#workunit(\'name\',\'BIPV2_LGID3 @version@ PostProcess\');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);' + 'BIPV2_Build.proc_lgid3(,\'' + lastIter + '\').updateSuperfiles()';
    kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Init',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ',todd.leonard@risk.lexisnexis.com');
    kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Specs',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ',todd.leonard@risk.lexisnexis.com');
    kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount[1].lgid3_count','{UNSIGNED rcid_Count,UNSIGNED lgid3_count}','PostClusterCount PostClusterCount[1].lgid3_count','{UNSIGNED rcid_Count,UNSIGNED lgid3_count}','BasicMatchesPerformed','MatchesPerformed','SlicesPerformed'],cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Iters',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ',todd.leonard@risk.lexisnexis.com');
    kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'LGID3Post',pNotifyEmails := _control.MyInfo.EmailAddressNotify + ',todd.leonard@risk.lexisnexis.com');
    return sequential(
       if(doInit  ,kickInit)
      ,if(doSpec  ,kickSpec)
      ,if(doIter  ,kickiters)
      ,if(doPost  ,kickPost)
      // ,BIPV2_Build.proc_lgid3(,lastIter).updateSuperfiles()
    );
  endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_Build.proc_lgid3().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);

	
end;