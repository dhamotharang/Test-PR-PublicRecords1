import BIPV2_Files, BIPV2, MDR, BIPv2_EmpID, BIPV2_Tools,tools,wk_ut,std;
// Init receives a file in common layout, and widens it for use in all iterations. We thin
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common := BIPV2.CommonBase.Layout;
//l_base := BIPV2_Files.files_empid().Layout_EmpID;
l_base:= RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.empid;
		BIPV2.CommonBase.Layout.seleid;
		BIPV2.CommonBase.Layout.orgid;
		BIPV2.CommonBase.Layout.ultid;
		BIPV2.CommonBase.Layout.contact_job_title_derived;
		BIPV2.CommonBase.Layout.prim_range;
		BIPV2.CommonBase.Layout.prim_name;
		BIPV2.CommonBase.Layout.zip;
		BIPV2.CommonBase.Layout.zip4;
		BIPV2.CommonBase.Layout.fname;
		BIPV2.CommonBase.Layout.lname;
		BIPV2.CommonBase.Layout.contact_phone;
		BIPV2.CommonBase.Layout.contact_did;
		BIPV2.CommonBase.Layout.contact_ssn;
		BIPV2.CommonBase.Layout.company_name;
		BIPV2.CommonBase.Layout.sec_range;
		BIPV2.CommonBase.Layout.v_city_name;
		BIPV2.CommonBase.Layout.st;
		BIPV2.CommonBase.Layout.company_inc_state;
		BIPV2.CommonBase.Layout.company_charter_number;
		BIPV2.CommonBase.Layout.active_duns_number;
		BIPV2.CommonBase.Layout.hist_duns_number;
		BIPV2.CommonBase.Layout.active_domestic_corp_key;
		BIPV2.CommonBase.Layout.hist_domestic_corp_key;
		BIPV2.CommonBase.Layout.foreign_corp_key;
		BIPV2.CommonBase.Layout.unk_corp_key;
		BIPV2.CommonBase.Layout.company_fein;
		BIPV2.CommonBase.Layout.cnp_btype;
		BIPV2.CommonBase.Layout.cnp_name;
		BIPV2.CommonBase.Layout.company_name_type_derived;
		BIPV2.CommonBase.Layout.company_bdid;
		BIPV2.CommonBase.Layout.nodes_total;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
		BIPV2.CommonBase.Layout.isCorp;
		TYPEOF(BIPV2.CommonBase.Layout.company_name) cname_devanitize;
		STRING1 isCorpEnhanced;
	END;
export proc_empid_PlatForm(
	dataset(l_base) input = dataset([],l_base),
	string iter = '') := module
	
	
	/* ---------------------- Logical Files ------------------------------- */
	//EXPORT f_out(STRING istr)		:= BIPV2_Files.files_empid().FILE_SALT_OP + '::' + BIPV2.KeySuffix + '::it' + istr ;
	EXPORT f_out(STRING istr)		:= '~thor_data400::bipv2_empid_PlatForm::salt_iter::20160112::it'  + istr ;
	//SHARED f_hist(STRING istr)	:= BIPV2_Files.files_empid().FILE_SALT_POSSIBLE_MATCH + '::' + BIPV2.KeySuffix + '::it' + istr ;
	SHARED f_hist(STRING istr)	:= '~thor_data400::bipv2_empid_PlatForm::possiblematches::20160112::it' + istr ;
	//SHARED f_init								:= BIPV2_Files.files_empid().FILE_INIT + '::' + BIPV2.KeySuffix;
	SHARED f_init								:= '~thor_data400::bipv2_empid_PlatForm::init::20160112';
	//SHARED f_post								:= BIPV2_Files.files_empid().FILE_POST + '::' + BIPV2.KeySuffix;
	SHARED f_post								:= '~thor_data400::bipv2_empid_PlatForm::post::20160112';
	
	
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess(DATASET(l_common) ds, BOOLEAN idReset) := FUNCTION
		l_base toBase(l_common L) := TRANSFORM
			SELF.empid						:= IF(L.empid=0 OR idReset, L.dotid, L.empid);
			SELF.cname_devanitize	:= BIPV2_Tools.fn_devanitize(L.cnp_name, L.fname, L.lname);
			SELF.isCorpEnhanced		:= ''; // actual value assigned below
			SELF := L;
		END;
		ds_base := PROJECT(ds,toBase(LEFT));
		ds_enhanced := bipv2_empid_PlatForm._setCorpEnhanced(ds_base);
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
  // export dostrata_ID_Check(dataset(l_base) pDataset ,string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'EMPID','Preprocess',pversion,pIsTesting);
  export dostrata_ID_Check(dataset(l_common) pinput = dataset([],l_common),boolean pidreset = false,dataset(l_base) pDataset = preProcess(Vanity_ADL_Orgid_Collapse(pinput),pidreset),string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'EMPID','Preprocess',pversion,pIsTesting);
	/* ---------------------- Init From EmpID_Down ------------------------ */
	EXPORT init(DATASET(l_common) ds, BOOLEAN idReset=false) := SEQUENTIAL(
		 BIPV2_Files.files_empid().clearBuilding
		,OUTPUT(preProcess(Vanity_ADL_Orgid_Collapse(ds),idReset),,f_init,COMPRESSED,OVERWRITE)
    ,dostrata_ID_Check(ds,idReset)
		,BIPV2_Files.files_empid().updateBuilding(f_init)
	);
	SHARED ds_empid_down := BIPV2_Files.files_empid_down().DS_BASE(st='CA');
	EXPORT initFromEmpID_Down := sequential(
     init(ds_empid_down)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_empid_down().FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  );
	
	
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
	shared specMod := bipv2_empid_PlatForm.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift')));
	
	
	/* ---------------------- SALT Iteration ----------------------------- */
	shared possibleMatches := output(bipv2_empid_PlatForm.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
	shared saltMod 	:= bipv2_empid_PlatForm.Proc_Iterate(iter, input, f_out(''));
	shared linking	:= parallel(saltmod.DoAllAgain/*, possibleMatches*/);
	
	
	/* ---------------------- SALT Output -------------------------------- */
	shared updateBuilding(string fname=f_out(iter)) := BIPV2_Files.files_empid().updateBuilding(fname);
	export updateSuperfiles(string fname=f_out(iter)) := sequential(
		 output(postProcess(dataset(fname,l_base,thor)),, f_post, compressed, overwrite)
		,BIPV2_Files.files_empid().updateSuperfiles(f_post)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
	);
	
	
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= BIPV2_Files.files_empid().updateLinkHist(f_hist(iter));
	
	
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := bipv2_empid_PlatForm._Samples(input).out;
	
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
	
	export runIter := sequential(linking, outputReviewSamples, updateBuilding()/*, updateLinkHist*/)
		: SUCCESS(BIPV2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'EmpID')),
			FAILURE(BIPV2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'EmpID'));
	
	export runSpecIter := sequential(specBuild,runIter);
	
	export MultIter(unsigned startIter, unsigned numIters) := 
		'bipv2_empid_PlatForm Controller ' + BIPV2.KeySuffix + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
	
	export MultIter_run(startIter, numIters,doInit,doSpec,doIters = 'true',doPost = 'true') := functionmacro
		import wk_ut, tools;
		// pHint     := if(_Control.ThisEnvironment.name='Dataland','dev','20');
		pHint     := if(_Control.ThisEnvironment.name='Dataland','staging','20');
		cluster		:= BIPV2_build._Constants().Groupname;
		version		:= BIPV2.KeySuffix;
		previter	:= (string)(startiter - 1);
		lastIter	:= (string)(startiter - 1 + numIters);
		eclInit		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'bipv2_empid_PlatForm \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\nBIPV2_build.proc_empid().initFromEmpID_Down;';
		eclSpec		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\nlih := BIPV2_Files.files_empid().DS_BUILDING;\n#workunit(\'name\',\'bipv2_empid_PlatForm \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\nBIPV2_build.proc_empid(lih,iteration).runSpecBuild;';
		eclIter		:= 'import BIPV2_Files,BIPV2_build;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\nlih := BIPV2_Files.files_empid().DS_BUILDING;\n#workunit(\'name\',\'bipv2_empid_PlatForm \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\nBIPV2_build.proc_empid(lih,iteration).runIter;';
	  eclPost		:= 'import BIPV2_build;\n#workunit(\'name\',\'bipv2_empid_PlatForm @version@ PostProcess\');\n' + 'BIPV2_build.proc_empid(,\'' + lastIter + '\').updateSuperfiles();';
    kickInit	:= wk_ut.mac_ChainWuids(eclInit,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'EmpIDInit',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Init'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
    );
		kickSpec	:= wk_ut.mac_ChainWuids(eclSpec,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'EmpIDSpecs',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Specificities'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
    );
		kickIters	:= wk_ut.mac_ChainWuids(eclIter,startiter,numiters,version,['PreClusterCount[1].empid_count','{UNSIGNED rcid_Count,UNSIGNED empid_count}','PostClusterCount PostClusterCount[1].empid_count','{UNSIGNED rcid_Count,UNSIGNED empid_count}','BasicMatchesPerformed','MatchesPerformed','SlicesPerformed'],cluster,pOutputEcl := false,pUniqueOutput := 'EmpIDIters',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::@version@_@iteration@::workunit_history::proc_empid.iterations'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~BIPV2_build::@version@_@iteration@::summary_report::proc_empid.iterations'
      ,pSummarySuperfile := '~BIPV2_build::qa::summary_report::proc_empid.iterations'                                                 
    );
    kickPost	:= wk_ut.mac_ChainWuids(eclPost,1,1,version,,cluster,pOutputEcl := false,pUniqueOutput := 'EmpIDPost',pNotifyEmails := BIPV2_build.mod_email.emailList
      ,pOutputFilename   := '~BIPV2_build::' + version + '::workunit_history::proc_empid.Post'
      ,pOutputSuperfile  := '~BIPV2_build::qa::workunit_history' 
    );
		return sequential(
			 if(doInit  ,kickInit )
			,if(doSpec  ,kickSpec )
			,if(doIters ,kickiters)
      ,if(doPost  ,kickPost )
			// ,BIPV2_build.proc_empid(,lastIter).updateSuperfiles()
		);
	endmacro;
	// EXAMPLE for calling MultIter...
	//		startIter	:= 1; // REMINDER: Check these three inputs carefully!
	//		numIters	:= 3;
	//		doInit		:= true;
	//		doSpec		:= true;
	//		#workunit('priority','high');
	//		#workunit('protect' ,true);
	//		multi := BIPV2_build.proc_empid().MultIter(startIter,numIters);
	//		#workunit('name',multi.wuName);
	//		multi.run(doInit,doSpec);
	
end;
