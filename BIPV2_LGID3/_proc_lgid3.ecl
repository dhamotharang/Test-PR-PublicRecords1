import BIPV2_Files, BIPV2, MDR, BIPV2_LGID3,ut,bipv2_build,wk_ut,tools,std,BIPV2_Tools,mdr,SALTTOOLS22;  
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
			SELF.nodes_below_st			:= (string10)L.nodes_below;
			SELF.Lgid3IfHrchy				:= if(L.nodes_total>1,(string20)L.LGID3,'');
			
			SELF.OriginalSeleId			:= if(L.nodes_total>1, L.seleid, 0); //each hierarchy node get these two
			SELF.OriginalOrgId			:= if(L.nodes_total>1, L.orgid, 0);
      self.duns_number        := if(L.deleted_key = '' and mdr.sourceTools.SourceIsDunn_Bradstreet(l.source),L.duns_number  ,''  ); //blank out deleted duns numbers.  they will come back in the postprocess
			//Suggested by Chad, the leafnode LGID3 should initialize to SeleID:
			//self.LGID3							:=if(L.nodes_total>1 and L.nodes_below=0 and L.seleid>0, L.seleid, L.LGID3);
			SELF := L;
		END;
		
		ds_init := BIPV2_Tools.initParentID(ds, proxid, lgid3);
		ds_base := PROJECT(ds_init,toBase(LEFT));
				
		RETURN ds_base;
	END;
	/* ---------------------- Pre-processing ---------------------------- */
	EXPORT DATASET(l_base) preProcess2(DATASET(l_common) ds) := 
  FUNCTION
		l_base toBase(l_common L) := 
    TRANSFORM
			isLegal	:= (L.company_name_type_derived='LEGAL' or (L.company_name_type_derived='FBN' and mdr.sourcetools.sourceisCorpV2(L.source)));
			SELF.company_name				:= if(isLegal, L.company_name, '');	// BLANK except for Legal Names
			SELF.cnp_number					:= if(isLegal, L.cnp_number, '');		// BLANK except for legal Names
      self.sbfe_id            := if(mdr.sourceTools.SourceIsBusiness_Credit(l.source) ,l.vl_id ,'');
			SELF.seleid							:= if(L.seleid > 0, L.seleid, L.lgid3);
			SELF.orgid							:= if(L.orgid > 0, L.orgid, L.lgid3);
			SELF.ultid							:= if(L.ultid > 0, L.ultid, L.lgid3);
			SELF.nodes_below_st			:= (string10)L.nodes_below;
			SELF.Lgid3IfHrchy				:= if(L.nodes_total>1,(string20)L.LGID3,'');
			
			SELF.OriginalSeleId			:= if(L.nodes_total>1, L.seleid, 0); //each hierarchy node get these two
			SELF.OriginalOrgId			:= if(L.nodes_total>1, L.orgid, 0);
      self.duns_number        := if(L.deleted_key = '' and mdr.sourceTools.SourceIsDunn_Bradstreet(l.source),L.duns_number  ,''  ); //blank out deleted duns numbers.  they will come back in the postprocess
			//Suggested by Chad, the leafnode LGID3 should initialize to SeleID:
			//self.LGID3							:=if(L.nodes_total>1 and L.nodes_below=0 and L.seleid>0, L.seleid, L.LGID3);
			SELF := L;
		END;
		
		ds_init := BIPV2_Tools.initParentID(ds, proxid, lgid3);
    ds_addhash := project(ds_init,transform({unsigned8 lgid3_cnp_name_hash,recordof(left)},self.lgid3_cnp_name_hash := hash64(left.lgid3,trim(left.cnp_name)),self := left));
    ds_prop_name_type := BIPV2_Tools.Propagate_DID(ds_addhash ,'LGID3','Preprocess','propagate_company_name_type_derived',,lgid3_cnp_name_hash,company_name_type_derived,pversion);
		ds_base := PROJECT(project(ds_prop_name_type,l_common),toBase(LEFT));
		RETURN ds_base;
    
	END;		
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata, linkingtools;
  export dostrata_ID_Check(dataset(l_common) pDataset ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'LGID3','Preprocess',pversion,pIsTesting);
	/* ---------------------- Init From Hrchy ---------------------------- */
	// SHARED ds_hrchy := dataset(ut.foreign_prod + 'thor_data400::bipv2::internal_linking::building::20141015',BIPV2.CommonBase.Layout,thor);//(v_city_name in ['BOCA RATON','DAYTON','SPRINGBORO','MIAMISBURG'],st in ['FL','OH']);//HACK
	SHARED ds_hrchy := BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING;
	//SHARED ds_hrchy := dataset('~thor_data400::bipv2d::internal_linking::20170424_keep',BIPV2.CommonBase.Layout,thor);
	SHARED preprocessResult:=preProcess(ds_hrchy);
	
														//=ds_hrchy						//=preprocessResult
	export getInitialChanges(DATASET(l_common) dsb, DATASET(l_base) dsa) := Function
			lgid3Prox:=project(dsa,transform({string20 version, unsigned6 proxid,unsigned6 lgid3}, 
			   self.version:=pversion; self.proxid:=left.proxid; self.lgid3:=left.lgid3));
			lgid3Prox_ded:=dedup(sort(lgid3Prox, lgid3,proxid,skew(1.0)),lgid3,proxid);
			
			superInit:='~thor_data400::BIPV2_LGID3::init_super::lgid3prox' + pversion;
			b0:=if(STD.File.SuperFileExists(superInit)=false,
			       STD.File.CreateSuperFile(superInit));
			Lgid3ProxPath:='~thor_data400::BIPV2_LGID3::lgid3prox::init'+pversion;
			f_lgid3Prox_ded:=output(lgid3Prox_ded,,Lgid3ProxPath,COMPRESSED,OVERWRITE);
			act5:=STD.File.AddSuperFile(superInit,Lgid3ProxPath);
			
/* 			todo:=SEQUENTIAL(
   											 STD.File.StartSuperFileTransaction(),
   											 STD.File.ClearSuperFile('~thor_data400::BIPV2_LGID3::lgid3_changes',true),
   											 STD.File.FinishSuperFileTransaction()
   											);
*/
      superChange:='~thor_data400::BIPV2_LGID3::lgid3_changes::super' + pversion;
			AA:=STD.File.SuperFileExists(superChange);
			b1:=if(AA=false, STD.File.CreateSuperFile(superChange));
			
/* 			todo2:=SEQUENTIAL(
   											 STD.File.StartSuperFileTransaction(),
   											 STD.File.ClearSuperFile('~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug',true),
   											 STD.File.FinishSuperFileTransaction()
   											);
*/
      superMatch:='~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug::super' + pversion;
			AA2:=STD.File.SuperFileExists(superMatch);
			//b2:=if(AA2=true,todo2, STD.File.CreateSuperFile('~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug'));
			b2:=if(AA2<>true,STD.File.CreateSuperFile(superMatch));
		Change_rec:=RECORD
			string20 version;
			string20 iterNumber;
			unsigned6 lgid3_before;
			unsigned6 lgid3_after;
			unsigned6 seleid_before;
			unsigned6 seleid_after;
		end;		
		ds_c:=join(dsb,dsa,left.rcid=right.rcid, transform(Change_rec,
																												self.version :=pversion;
																												self.lgid3_before :=left.lgid3;
																												self.lgid3_after  :=right.lgid3;
																												self.seleid_before:=left.seleid;
																												self.seleid_after :=right.seleid;
																												self.iterNumber   :='I'+pversion));
		ds_r:= ds_c(lgid3_before <> lgid3_after or seleid_before <> seleid_after);
		ds_r1:=dedup(ds_r,version,iterNumber,lgid3_before,lgid3_after,seleid_before,seleid_after,all);
		
		qqPath:='~thor_data400::BIPV2_LGID3::lgid3_changes::I'+pversion;
		act_init:=output(ds_r1,,qqPath,COMPRESSED,OVERWRITE);
		act4:=STD.File.AddSuperFile(superChange,qqPath);
		return sequential(b1,b2,act_init,act4,b0,f_lgid3Prox_ded,act5);
		
	end;
	
	EXPORT init(DATASET(l_common) ds=ds_hrchy, BOOLEAN idReset=false) := SEQUENTIAL(
    dostrata_ID_Check(ds_hrchy) 
		,BIPV2_Files.files_lgid3.clearBuilding
		,getInitialChanges(ds_hrchy, preprocessResult)
		,OUTPUT(preprocessResult,,f_init,COMPRESSED,OVERWRITE)
		//,OUTPUT(preProcess(ds),,f_init,COMPRESSED,OVERWRITE)
		,BIPV2_Files.files_lgid3.updateBuilding(f_init)
	);
  export kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_hrchy.FILENAME_HRCY_BASE_LF_FULL_BUILDING)[1].name) ,pversion ,'lgid3_preprocess');
  export copy2StorageThor         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor
	EXPORT initFromHrchy := sequential(
     init(ds_hrchy, TRUE)
    ,copy2StorageThor
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_hrchy.FILENAME_HRCY_BASE_LF_FULL_BUILDING)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  ); // HACK - preserve id values someday
	
	
	/* ---------------------- Post-processing ---------------------------- */
/* 	EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_hrchy) := FUNCTION
   	
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
*/
	
EXPORT DATASET(l_common) postProcess(DATASET(l_base) ds, DATASET(l_common) ds_common=ds_hrchy) := FUNCTION
//merge seleids:
		TheSeleStruct :=record
			ds.seleid;
			maxSeleId := Max(group,ds.OriginalSeleId);
			maxOrgId  := Max(group,ds.OriginalOrgId);
		end;
		
		TheSeleTable0 :=table(ds,TheSeleStruct,seleid,skew(0.9));
		
		//The above we get : pair of (seleid, originalseleid), possible results : (1000,1000), (500,1000), (444,0). 
		//The (1000,1000) means (a) 1000-cluster itself or (b) a leafnode of the 1000-sele cluster or (c) a leafnode of it joining some singletons 
		//whose lgid3 have greater value than 1000. The "normal" case.
		//The (500,1000)  means a leafnode of sele-1000 joined to some singleton whose lgid3 has a smaller value of 500 and the leafnode has been updated 
		//and a new 500-sele cluster generated. The 1000-sele cluster get splitted if this happens.
		//The (444,0) means (a) there is a singleton, or (b) there is a singleton-singleton join. Either way, we don't care of them.
		
		TheSeleTable1 :=TheSeleTable0(maxSeleId>0); //Get rid of case (444,0) because we don't care.
	
//Try to get the smallest seleid for each maxSeleId (the OriginalSeleId):	
		SeleSmallStruct :=record
			TheSeleTable1.maxSeleId;
			SmallSeleID :=Min(group, TheSeleTable1.seleid);
		end;
		
		TheSeleTable2 :=table(TheSeleTable1, SeleSmallStruct,maxSeleId); 
		//The above get SmallSeleID for each maxSeleId (the OriginalSeleId). 
		//It tells OriginalSeleId actullay should be replaced by SmallSeleID in the original structure as well as any singletons which join to the leafnodes.
		
//As the first step, we merge the new sele clusters that are generated by leafnode-singleton joining back to the original sele that the leafnodes belong to:
//So, we temporarily use the OriginalSeleId as the seleid in this hierarchy structure. This will violate the ID consistency but can finish the merge.	
		dsNew :=join(ds, TheSeleTable1, Left.seleid=Right.seleid, 
										transform(l_base, self.seleid :=if(Left.seleid=Right.seleid, Right.maxSeleId, Left.seleid);
																			self.orgid  :=if(Left.seleid=Right.seleid, Right.maxOrgId, Left.orgid);
																			self.ultid  :=if(Left.seleid=Right.seleid, Right.maxOrgId, Left.ultid);
																			self        :=Left),LEFT OUTER, HASH);
																			
//As the second step, we correct the ID inconsistency in the above hrchy structure using SmallSeleID:
		dsNew1 :=join(dsNew, TheSeleTable2, Left.seleid=Right.maxSeleId, 
										transform(l_base, self.seleid :=if(Left.seleid=Right.maxSeleId, Right.SmallSeleID, Left.seleid);
																			//self.orgid  :=if(Left.seleid=Right.maxSeleId, Right.SmallSeleID, Left.orgid);
																			//self.ultid  :=if(Left.seleid=Right.maxSeleId, Right.SmallSeleID, Left.ultid);
																			self        :=Left),LEFT OUTER, HASH);
																			
																			
//If in dsNew1 the orgid > the samllest seleid in the org cluster, then the whole org need to update to keep the ID consistency
  		TheSeleTable3 :=dedup(sort(table(dsNew1(nodes_total>1), {seleid, orgid}),orgid,seleid),orgid,seleid);
			f_rec :=record
				TheSeleTable3.orgid;
				minSele :=min(group, TheSeleTable3.seleid);
			end;
			TheSeleTable4 := table(TheSeleTable3(orgid>0, seleid>0),f_rec,orgid);
			TheSeleTable5 :=TheSeleTable4(orgid>minSele);
		
		dsNew2 :=join(dsNew1, TheSeleTable5, Left.orgid=Right.orgid, 
										transform(l_base, self.orgid  :=if(Left.orgid=Right.orgid, Right.minSele, Left.orgid);
																			self.ultid  :=if(Left.orgid=Right.orgid, Right.minSele, Left.ultid);
																			self        :=Left),LEFT OUTER, HASH);
			
//----end of merge-------------------------------
		//dsNew2:=dsNew1;
		
		ds_leafNodes :=dedup(sort(dsNew2(nodes_below_st ='0' and Lgid3IfHrchy <>''),lgid3,SKEW(1,0.5)),lgid3);
		l_base tr(l_base L, l_base R) :=transform
			self.has_lgid 				:=if(R.lgid3=L.lgid3, R.has_lgid, L.has_lgid);
			self.is_sele_level		:=if(R.lgid3=L.lgid3, R.is_sele_level, L.is_sele_level);
			self.is_org_level			:=if(R.lgid3=L.lgid3, R.is_org_level, L.is_org_level);
			self.is_ult_level			:=if(R.lgid3=L.lgid3, R.is_ult_level, L.is_ult_level);
			self.parent_proxid		:=if(R.lgid3=L.lgid3, R.parent_proxid, L.parent_proxid);
			self.sele_proxid			:=if(R.lgid3=L.lgid3, R.sele_proxid, L.sele_proxid);
			self.org_proxid				:=if(R.lgid3=L.lgid3, R.org_proxid, L.org_proxid);
			self.ultimate_proxid	:=if(R.lgid3=L.lgid3, R.ultimate_proxid, L.ultimate_proxid);
			self.levels_from_top	:=if(R.lgid3=L.lgid3, R.levels_from_top, L.levels_from_top);
			self.nodes_total			:=if(R.lgid3=L.lgid3, R.nodes_total, L.nodes_total); //not accurate but just used to distinquish zero and non-zero
			self:=L;
		end;
		//j1:=join(ds,ds_leafNodes,Left.lgid3=right.lgid3, tr(left, right), Left Outer,HASH);
		j1:=join(dsNew2,ds_leafNodes,Left.lgid3=right.lgid3, tr(left, right), Left Outer,HASH);
		// Restore the fields we selectively blanked during init
		l_common toRestore(l_base L, l_common R) := TRANSFORM
			SELF.company_name	:= R.company_name;
			SELF.cnp_number		:= R.cnp_number;
      self.duns_number  := R.duns_number;
			SELF := L; // pick up any changes from linking
			SELF := R; // then re-widen back to the common layout
		END;
		
		//ds_restore := JOIN(ds, ds_common, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), HASH); //old code use ds
		ds_restore := JOIN(j1, ds_common, LEFT.rcid=RIGHT.rcid, toRestore(LEFT, RIGHT), KEEP(1), HASH);
		
		RETURN ds_restore;
	end;	
	
	/* ---------------------- SALT Specificities ------------------------- */
	shared specMod := BIPV2_LGID3.specificities(input);
	shared specBuild := specMod.Build;
	shared specDebug := parallel(OUTPUT(specMod.Specificities,NAMED('Specificities')),OUTPUT(specMod.SpcShift,NAMED('SpcShift'))
                      ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_LGID3._SPC',input,,false));
  /* ---------------------- SALT Iteration ----------------------------- */
  shared possibleMatches := output(BIPV2_LGID3.matches(input).PossibleMatches,,f_hist(iter),overwrite,compressed);
  shared saltMod  := BIPV2_LGID3.Proc_Iterate(iter, input, f_out(''));
  shared linking  := parallel(saltmod.DoAllAgain, possibleMatches);
  
  /* ---------------------- SALT Output -------------------------------- */
  import BIPV2_QA_Tool;
  shared last_lgid3_iter    := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_lgid3.FILE_BUILDING)[1].name);
  shared before_restore_ds  := dataset(last_lgid3_iter,l_base,thor);
  shared restoredDs         := postProcess(before_restore_ds,ds_hrchy);

  /* ---------------------- Persistence stats and QA tool outputs -------------------------------- */
  shared ds_lgid3_persistence_stats                 := BIPV2_Strata.PersistenceStats(restoredDs,BIPV2.CommonBase.DS_BASE,rcid,lgid3) : independent;
	shared QA_Tool_lgid3_persistence_record_stats     := BIPV2_QA_Tool.mac_persistence_records_stats(ds_lgid3_persistence_stats ,'lgid3' ,pversion);
  shared QA_Tool_lgid3_persistence_cluster_stats    := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_lgid3_persistence_stats ,'lgid3' ,pversion);
  

  export updateSuperfiles(string fname=last_lgid3_iter, dataset(l_common) ds_common=ds_hrchy) := 
  function
  
    kick_copy2_storage_thor_post  := BIPV2_Tools.Copy2_Storage_Thor(fname  ,pversion ,'lgid3_postprocess');
    copy2StorageThor_post         := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_post ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor
    return sequential(
      //output(postProcess(dataset(fname,l_base,thor),ds_common),, fname+'_post', compressed, overwrite),
       output(restoredDs,,                                        fname+'_post', compressed, overwrite)
      ,BIPV2_LGID3._ManageLgid3Indexes(before_restore_ds , restoredDs, pversion).out //added for data retrieve
      ,BIPv2_Files.files_lgid3.updateSuperfiles(fname+'_post')
      ,Strata.macf_CreateXMLStats(ds_lgid3_persistence_stats ,'BIPV2','Persistence'  ,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'LGID3','Stats',false,false) //group on cluster_type, stat_desc
      ,QA_Tool_lgid3_persistence_record_stats 
      ,QA_Tool_lgid3_persistence_cluster_stats
      ,copy2StorageThor_post
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := fname  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
    );
	end;
  
	/* ---------------------- SALT History ------------------------------- */
	shared updateLinkHist   	:= BIPv2_Files.files_lgid3.updateLinkHist(f_hist(iter));
		
	/* ---------------------- Review Samples ----------------------------- */
	export outputReviewSamples := BIPV2_LGID3._Samples(input).out;
	/* ---------------------- Inline Iteration Run for Testing ----------- */	
	export DATASET(l_common) inline_iteration(DATASET(l_common) ds) := FUNCTION
		ds1 := preProcess(ds);
		mod := BIPV2_LGID3.matches(ds1,BIPV2_LGID3.Config.MatchThreshold);
		ds2 := mod.patched_infile;
		ds3 := postProcess(ds2,ds);
		// output(mod.MatchesPerformed, named('LGID3_MatchesPerformed'));
    RETURN ds3;
  end;
	
	/* ---------------------- Take Action -------------------------------- */
	export runSpecBuild := sequential(specBuild, specDebug);
  ds_lgid3      := BIPV2_LGID3.In_LGID3    ;
  ds_commonbase := bipv2.CommonBase.ds_base (seleid = 46640408) : persist('~persist::lbentley::LNK::324::ds_filtered44');
  ds_commonbase_rcids := table(ds_commonbase  ,{rcid});
  ds_lgid3_rcids  := join(ds_lgid3  ,ds_commonbase_rcids  ,left.rcid = right.rcid ,transform(left)  ,lookup);
  ds_agg_LNK197_lgids := join(ds_lgid3  ,table(ds_lgid3_rcids,{lgid3},lgid3,merge)  ,left.lgid3 = right.lgid3 ,transform(left)  ,lookup);
  export output_lnk_197  := output(BIPV2_LGID3._AggLgid3s(ds_agg_LNK197_lgids) ,named('ds_agg_LNK197_lgids'),all);

  import BIPV2_QA_Tool;
  export lgid3_iteration_stats := BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,lgid3 ,pversion  ,iter  ,BIPV2_LGID3.Config.MatchThreshold ,'BIPV2_LGID3');

  // -- Run Iteration
  shared updateBuilding(string fname=f_out(iter)) := BIPv2_Files.files_lgid3.updateBuilding(fname);
  export runIter := sequential(linking,outputReviewSamples, updateBuilding(), updateLinkHist,BIPV2_LGID3._Lgid3Changes(iter,pversion, input).out,output_lnk_197,lgid3_iteration_stats)
    : SUCCESS(bipv2_build.mod_email.SendSuccessEmail(,'BIPv2', , 'LGID3')),
      FAILURE(bipv2_build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'LGID3'));
  
  export runSpecIter := sequential(specBuild,runIter);
  
  export MultIter(unsigned startIter, unsigned numIters) := 
      'BIPV2_LGID3 Controller ' + pversion + ' ' + (string)startiter + '-' + (string)(startiter + numiters - 1);
  export MultIter_run(
     startIter    = '\'\''  //leave it default blank to start where you left off.  pass in a number to start at that iteration #
    ,numIters     = '15'
    ,doInit       = 'true'
    ,doSpec       = 'true'
    ,doIter       = 'true'
    ,doPost       = 'true'
    ,pversion     = 'bipv2.KeySuffix'
    ,pcluster     = 'BIPV2_Build._Constants().Groupname'
    ,pCompileTest = 'false'
) := 
functionmacro
    import wk_ut, tools,bipv2_build,Workman;
    cluster		:= pcluster;
    version		:= pversion;
    // lastIter	:= (string)(startiter - 1 + numIters);
    eclInit		:= 'import BIPV2_Files,BIPV2_LGID3;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' Init \');\n#workunit(\'priority\',\'high\');\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n' + 'BIPV2_LGID3._proc_lgid3(,,pversion).initFromHrchy;\n';
    eclSpec		:= 'import BIPV2_Files,BIPV2_LGID3;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_LGID3.In_LGID3;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' Specificities \');\n#workunit(\'priority\',\'high\');\nBIPV2_LGID3._proc_lgid3(lih,iteration,pversion).runSpecBuild;\n';
    eclIter		:= 'import BIPV2_Files,BIPV2_LGID3;\niteration := \'@iteration@\';\npversion  := \'@version@\';\nlih := BIPV2_LGID3.In_LGID3;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'BIPV2_LGID3 \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\nBIPV2_LGID3._proc_lgid3(lih,iteration,pversion).runIter;\n';
    eclPost		:= 'import BIPV2_LGID3;\n\n#workunit(\'name\',\'BIPV2_LGID3 @version@ PostProcess\');\n\n#workunit(\'priority\',\'high\');\n\n#OPTION(\'multiplePersistInstances\',FALSE);\npversion  := \'@version@\';\n' + 'BIPV2_LGID3._proc_lgid3(,\'\',pversion).updateSuperfiles()';

    eclsetResults   := [ 'PreClusterCount PreClusterCount.LGID3_Cnt'        
                        ,'PostClusterCount PostClusterCount.LGID3_Cnt'       
                        ,'MatchesPerformed'      
                        ,'BasicMatchesPerformed'
                        ,'SlicesPerformed'
                        // ,'ProxidsCreatedByCleave'
                        ,'LinkBlockSplits'
                       ];
    StopCondition   := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
    SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

    kickInit	:= Workman.mac_WorkMan(eclInit,version,cluster,1,1,pBuildName := 'LGID3Init',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Init'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
   );
    kickSpec	:= Workman.mac_WorkMan(eclSpec,version,cluster,1,1,pBuildName := 'LGID3Specs',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
   );
    kickiters := Workman.mac_WorkMan(eclIter,version,cluster,startIter,numiters + 1,numiters
        ,pSetResults          := eclsetResults
        ,pStopCondition       := StopCondition
        ,pSetNameCalculations := SetNameCalculations
        ,pBuildName           := 'LGID3Iters'
        ,pNotifyEmails        := BIPV2_Build.mod_email.emailList
        ,pOutputFilename      := '~bipv2_build::@version@_@iteration@::workunit_history::proc_lgid3.iterations'
        ,pOutputSuperfile     := '~bipv2_build::qa::workunit_history' 
        ,pCompileOnly         := pCompileTest
    );
    kickPost  := Workman.mac_WorkMan(eclPost,version ,cluster  ,1         ,1        ,pBuildName := 'LGID3Post',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_lgid3.Post'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly         := pCompileTest
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
