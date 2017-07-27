import BIPV2_Files, BIPV2, BIPV2_Ingest;
import wk_ut,tools,std;
export proc_ingest(STRING omitDisposition='') := module
	/* ---------------------- Files -------------------------------------- */
	export f_ingest_in	:= BIPv2_Files.files_ingest.FILE_IN  + '_' + BIPV2.KeySuffix;
	export f_ingest_out	:= BIPv2_Files.files_ingest.FILE_OUT + '_' + BIPV2.KeySuffix;
	export f_ingest_typ	:= BIPv2_Files.files_ingest.FILE_TYP + '_' + BIPV2.KeySuffix;
	export f_ingest_err	:= BIPV2_Files.files_ingest.FILE_ERR + '_' + BIPV2.KeySuffix;
	
	
	/* ---------------------- Data Prep ---------------------------------- */
	
	// NOTE: Remember to update BIPV2.KeySuffix each time we run prepIngest!!!
	// prep  W20150422-113510 --maybe err_summary, other three counts + count of err_summary total
    
  // export lay_total_status   := {string9 ingest_status,unsigned cnt};
  export lay_Total_Counts   := {string File ,unsigned countgroup,unsigned count};
  
  shared ds_err_summary     := BIPV2_Files.tools_dotid(BIPV2_Files.files_ingest.ds_as_linking).err_summary;
  export lay_err_summary    := recordof(ds_err_summary);
  import strata;
  
  export do_Prepingest_strata(
     string                               pversion            = bipv2.KeySuffix
		,dataset(BIPV2_Files.layout_ingest)   pds_as_linking      = BIPV2_Files.files_ingest.ds_as_linking
    ,dataset(lay_err_summary          )   pErr_Summary        = BIPV2_Files.tools_dotid(pds_as_linking).err_summary
    ,dataset(lay_Total_Counts         )   pAs_Linking_Counts  = dataset([
                                                                   {'Input As Linking'              ,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_In	,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_In	}
                                                                  ,{'Input As Linking BIP Sources'  ,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_Tops,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_Tops}
                                                                  ,{'Input As Linking Good'         ,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_Good,BIPV2_Files.tools_dotid(pds_as_linking).count_ds_Good}
                                                                ],lay_Total_Counts)
    ,boolean                              pIsTesting          = false
    ,boolean                              pOverwrite          = false
  ) := 
  function
  
    ds_err_summ_strata := project(pErr_Summary,transform({lay_err_summary - cnt,unsigned countgroup,unsigned count},self.countgroup := left.cnt,self.count := left.cnt,self := left));
  
    return parallel(
       Strata.macf_CreateXMLStats(ds_err_summ_strata  ,'BIPV2','PrepIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Remedies' ,'ErrorSummary' 	,pIsTesting,pOverwrite) //group on src_name
      ,Strata.macf_CreateXMLStats(pAs_Linking_Counts  ,'BIPV2','PrepIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'stats'    ,'AsLinking'	    ,pIsTesting,pOverwrite) //group on File
      
    );
  end;
  
	EXPORT fn_prepIngest(
		dataset(BIPV2_Files.layout_ingest) ds_as_linking = BIPV2_Files.files_ingest.ds_as_linking
	) := SEQUENTIAL(
		// convert as_linking to as_header - store in Ingest SuperFile
		BIPV2.KeySuffix_mod2.SanityCheck,
		OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).base,, f_ingest_in, COMPRESSED, OVERWRITE),
		OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).err_rec,, f_ingest_err, COMPRESSED, OVERWRITE),
		OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).err_summary, NAMED('err_summary'), ALL),
		BIPV2_Files.tools_dotid(ds_as_linking).outCounts,
    do_Prepingest_strata(pds_as_linking := ds_as_linking),
		BIPV2_Files.files_ingest.updateBuilding(f_ingest_in),
		BIPV2_Files.files_ingest.updateErrorFile(f_ingest_err)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := BIPV2.filenames(bipv2.KeySuffix).Source_Ingest.new  ,pDeleteSourceFile  := true)) //copy source ingest file to storage thor after using it.
	);
	
	// runIngest needs a reasonable response for sources omitted altogether from the ingest file
	// (relative to the base file).  By default we want to FAIL so the issue doesn't go unnoticed.
	// However, when intentional, we need to choose between preserving the base file records with
	// the "ingest_status" they came in with _or_ setting it to Old.  The former is useful when a
	// source is temporary witheld from Ingest due to a data build problem, and the latter is useful
	// when a source is eliminated from the product (but still needed for archival purposes).
	// 
	// omitDisposition values...
	//   null:     FAIL on source omission (default)
	//   preserve: Preserve the "ingest_status" value from base file for omitted sources
	//   ghost:    Set "ingest_status" to "Old" for omitted sources
	//
	EXPORT omittedSources := MODULE
		xt_base		:= TABLE(BIPV2_Ingest.In_BASE, {source}, source, MERGE);
		xt_ingest	:= TABLE(BIPV2_Ingest.In_INGEST, {source}, source, MERGE);
		SHARED ds_omits := JOIN(xt_base, xt_ingest, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LEFT ONLY, LOOKUP);
		
		EXPORT check := IF(
			omitDisposition<>'',
			ASSERT(NOT EXISTS(ds_omits), 'Sources omitted from Ingest file'),
			ASSERT(NOT EXISTS(ds_omits), 'Sources omitted from Ingest file -- pass \'preserve\' or \'ghost\'', FAIL)
		);
		
		EXPORT preserve(DATASET(RECORDOF(BIPV2_Ingest.In_BASE)) ds) := FUNCTION
			ds_bypass		:= JOIN(ds, ds_omits, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LEFT ONLY, LOOKUP);
			ds_work			:= JOIN(ds, ds_omits, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LOOKUP);
			ds_preserve	:= JOIN(BIPV2_Ingest.In_BASE, ds_work, LEFT.rcid=RIGHT.rcid, TRANSFORM(LEFT), KEEP(1), HASH);
			results			:= ds_bypass + ds_preserve;
			RETURN IF(omitDisposition='preserve' AND EXISTS(ds_omits), results, ds);
		END;
	END;
	
	ingest_results := PROJECT(BIPV2_Ingest.Ingest.AllRecords, TRANSFORM(BIPV2.CommonBase.Layout, SELF.ingest_status:=BIPV2_Ingest.Ingest.RTToText(LEFT.__Tpe), SELF:=LEFT));
  SHARED ds_re_DID   := BIPV2_Files.tools_dotid().APPEND_DID(distribute(omittedSources.preserve(ingest_results)));//this can get skewed, so add distribute
	SHARED ds_ingested := project(ds_re_DID,recordof(BIPV2_Ingest.In_BASE));  
	
	SHARED xt_src_status	:= TABLE(ds_ingested, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), ingest_status, UNSIGNED cnt:=COUNT(GROUP)}, source, ingest_status, MERGE);
	SHARED xt_agg_status	:= TABLE(xt_src_status, {src_name, ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, src_name, ingest_status, FEW);
	SHARED xt_status			:= TABLE(xt_src_status, {ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, ingest_status, FEW);
	SHARED ds_unused			:= BIPV2_Files.files_ingest.ds_as_linking(NOT BIPV2.mod_sources.srcInBIPV2Header(source));
	SHARED xt_src_unused	:= TABLE(ds_unused, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), UNSIGNED cnt := COUNT(GROUP)}, source, MERGE);
	export xt_agg_unused	:= TABLE(xt_src_unused, {src_name, UNSIGNED cnt := SUM(GROUP,cnt)}, src_name);
	
	SHARED xt_src_base		:= TABLE(BIPV2_Ingest.In_BASE, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), ingest_status, UNSIGNED cnt:=COUNT(GROUP)}, source, ingest_status, MERGE);
	SHARED xt_agg_base		:= TABLE(xt_src_base, {src_name, ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, src_name, ingest_status, FEW);
	SHARED xt_evolve := 
		JOIN(
			xt_agg_status, xt_agg_base, 
			left.src_name=right.src_name and left.ingest_status='Old' and right.ingest_status='Old',
			transform(recordof(xt_agg_status), self.ingest_status:='Ancient', self.cnt:=right.cnt, self:=left))
		+ JOIN(
			xt_agg_status, xt_agg_base, 
			left.src_name=right.src_name and left.ingest_status='Old' and right.ingest_status='Old',
			transform(recordof(xt_agg_status), self.cnt:=left.cnt-right.cnt, self:=left),
			LEFT OUTER);
	export l_roll := RECORD
		xt_evolve.src_name;
		unsigned cnt_ancient;
		unsigned cnt_old;
		unsigned cnt_unchanged;
		unsigned cnt_updated;
		unsigned cnt_new;
		real pct_tot_ancient;
		real pct_tot_old;
		real pct_tot_unchanged;
		real pct_tot_updated;
		real pct_tot_new;
		real pct_ingest_unchanged;
		real pct_ingest_updated;
		real pct_ingest_new;
	END;
	shared l_roll toRoll(xt_evolve L) := TRANSFORM
		SELF.cnt_ancient		:= IF(L.ingest_status='Ancient', L.cnt, 0);
		SELF.cnt_old				:= IF(L.ingest_status='Old', L.cnt, 0);
		SELF.cnt_unchanged	:= IF(L.ingest_status='Unchanged', L.cnt, 0);
		SELF.cnt_updated		:= IF(L.ingest_status='Updated', L.cnt, 0);
		SELF.cnt_new				:= IF(L.ingest_status='New', L.cnt, 0);
		SELF := L;
		SELF := [];
	END;
	shared l_roll doRoll(l_roll L, l_roll R) := TRANSFORM
		SELF.src_name				:= IF(L.src_name<>'', L.src_name, R.src_name);
		SELF.cnt_ancient		:= IF(L.cnt_ancient<>0, L.cnt_ancient, R.cnt_ancient);
		SELF.cnt_old				:= IF(L.cnt_old<>0, L.cnt_old, R.cnt_old);
		SELF.cnt_unchanged	:= IF(L.cnt_unchanged<>0, L.cnt_unchanged, R.cnt_unchanged);
		SELF.cnt_updated		:= IF(L.cnt_updated<>0, L.cnt_updated, R.cnt_updated);
		SELF.cnt_new				:= IF(L.cnt_new<>0, L.cnt_new, R.cnt_new);
		
		cnt_tot := SELF.cnt_ancient + SELF.cnt_old + SELF.cnt_unchanged + SELF.cnt_updated + SELF.cnt_new;
		cnt_ingest := SELF.cnt_unchanged + SELF.cnt_updated + SELF.cnt_new;
		
		SELF.pct_tot_ancient			:= 100.0 * SELF.cnt_ancient / cnt_tot;
		SELF.pct_tot_old					:= 100.0 * SELF.cnt_old / cnt_tot;
		SELF.pct_tot_unchanged		:= 100.0 * SELF.cnt_unchanged / cnt_tot;
		SELF.pct_tot_updated			:= 100.0 * SELF.cnt_updated / cnt_tot;
		SELF.pct_tot_new					:= 100.0 * SELF.cnt_new / cnt_tot;
		
		SELF.pct_ingest_unchanged	:= 100.0 * SELF.cnt_unchanged / cnt_ingest;
		SELF.pct_ingest_updated		:= 100.0 * SELF.cnt_updated / cnt_ingest;
		SELF.pct_ingest_new				:= 100.0 * SELF.cnt_new / cnt_ingest;
	END;
	shared ds_roll := ROLLUP(PROJECT(SORT(xt_evolve,src_name),toRoll(LEFT)), doRoll(LEFT,RIGHT), src_name);
	EXPORT doStats := PARALLEL(
		OUTPUT(COUNT(BIPV2_Ingest.In_BASE), NAMED('cnt_base')),
		OUTPUT(COUNT(BIPV2_Ingest.In_INGEST), NAMED('cnt_ingest')),
		OUTPUT(COUNT(ds_ingested), NAMED('cnt_out')),
		OUTPUT(COUNT(TABLE(ds_ingested,{dotid},dotid,MERGE)), NAMED('cnt_out_dotids')),
		OUTPUT(TABLE(ds_ingested,{ingest_status, cnt:=COUNT(GROUP)},ingest_status,FEW), NAMED('xtab_types')),
		BIPV2_Ingest.Ingest.DoStats,
		// and now some new ones...
		OUTPUT(SORT(xt_status,RECORD), NAMED('xt_status'), ALL),
		OUTPUT(SORT(xt_src_status,RECORD), NAMED('xt_src_status'), ALL),
		OUTPUT(SORT(xt_agg_status,RECORD), NAMED('xt_agg_status'), ALL),
		OUTPUT(SORT(xt_src_unused,-cnt), NAMED('xt_src_unused'), ALL),
		OUTPUT(SORT(xt_agg_unused,-cnt), NAMED('xt_agg_unused'), ALL),
		OUTPUT(SORT(xt_evolve,RECORD), NAMED('xt_evolve'), ALL),
		OUTPUT(SORT(ds_roll,RECORD), NAMED('ds_roll'), ALL)
	);
  // export lay_Rec_Counts   := {unsigned cnt_base,unsigned cnt_ingest,unsigned cnt_out,unsigned cnt_dotids};
  // export lay_Total_Counts   := {string File ,unsigned cnt};
  shared ds_Total_counts       := dataset([
     {'Input Base File'   ,COUNT(BIPV2_Ingest.In_BASE                   ),COUNT(BIPV2_Ingest.In_BASE                   )}
    ,{'Ingest File'       ,COUNT(BIPV2_Ingest.In_INGEST                 ),COUNT(BIPV2_Ingest.In_INGEST                 )}
    ,{'Output Base File'  ,COUNT(ds_ingested                            ),COUNT(ds_ingested                            )}
    ,{'Output Base Dotids',COUNT(TABLE(ds_ingested,{dotid},dotid,MERGE) ),COUNT(TABLE(ds_ingested,{dotid},dotid,MERGE) )}
  ],lay_Total_Counts);
  
  export lay_total_status := {string9 ingest_status,unsigned countgroup};
  shared ds_Total_status     := project(TABLE(ds_ingested,{ingest_status, countgroup:=COUNT(GROUP)},ingest_status,FEW),lay_total_status);
  import strata;
  
  export l_roll_strata := 
  RECORD
    STRING50 source;
    unsigned countgroup;
    unsigned count;
    unsigned cnt_ancient;
    unsigned cnt_old;
    unsigned cnt_unchanged;
    unsigned cnt_updated;
    unsigned cnt_new;
  end;
  export xt_agg_unused_lay  := {string50 src_name,unsigned countgroup,unsigned cnt};
  export ds_agg_unused	    := project(xt_agg_unused  ,transform(xt_agg_unused_lay  ,self.countgroup := left.cnt, self := left));
  export lay_re_DID         := recordof(ds_re_DID);
  
  export do_runingest_strata(
     string                       pversion        = bipv2.KeySuffix
    ,dataset(l_roll           )   pDS_Roll        = ds_roll
    ,dataset(lay_total_status )   pTotal_Status   = ds_Total_status
    ,dataset(lay_Total_Counts )   pTotal_Counts   = ds_Total_counts
    ,dataset(xt_agg_unused_lay)   pds_agg_unused  = ds_agg_unused
    ,dataset(lay_re_DID       )   pds_re_DID      = ds_re_DID
    ,boolean                      pIsTesting      = false
    ,boolean                      pOverwrite      = false
  ) := 
  function
  
    isneg1(unsigned pint) := if(pint = 18446744073709470961,0,pint);
    
    dds_roll := project(pDS_Roll  ,transform(l_roll_strata,self.source := left.src_name,self.cnt_ancient := isneg1(left.cnt_ancient),self.cnt_old := isneg1(left.cnt_old), self.cnt_unchanged := isneg1(left.cnt_unchanged), self.cnt_updated := isneg1(left.cnt_updated) ,self.cnt_new := isneg1(left.cnt_new),
    ,self.countgroup := self.cnt_ancient + self.cnt_old + self.cnt_unchanged + self.cnt_updated + self.cnt_new,self.count := self.countgroup,self := left));
    dds_Total_status := project(pTotal_Status,transform({lay_total_status,unsigned count},self.count := left.countgroup,self := left));
    ds_RE_DID_Stats := BIPV2_Files.tools_dotid().RE_DID_Stats(pds_re_DID);
    return parallel(
    
       Strata.macf_CreateXMLStats(dds_roll        ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'status' ,'Source' 	,pIsTesting,pOverwrite) //group on src_name
      ,Strata.macf_CreateXMLStats(dds_Total_status,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'status' ,'Total'	  ,pIsTesting,pOverwrite) //group on ingest_status
      ,Strata.macf_CreateXMLStats(pTotal_Counts   ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'counts' ,'Total' 	  ,pIsTesting,pOverwrite) //group on File
      ,Strata.macf_CreateXMLStats(pds_agg_unused  ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Sources','Unused'   ,pIsTesting,pOverwrite) //group on src_name
      ,Strata.macf_CreateXMLStats(ds_RE_DID_Stats ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Stats'  ,'ReDID'    ,pIsTesting,pOverwrite) //group on source,ingest_status,field
      
    );
  
  end;
  
	// Merge Base SuperFile with Ingest SuperFile - queue up the results for DOT
  // for strata: ds_roll,xtab_types and the count fields(put into 1 dataset)
	EXPORT fn_runIngest := SEQUENTIAL(
		omittedSources.check,
		OUTPUT(ds_ingested,, f_ingest_out, COMPRESSED, OVERWRITE),
		OUTPUT(TABLE(ds_ingested,{rcid, ingest_status}),, f_ingest_typ, COMPRESSED, OVERWRITE),
		doStats,
    do_runingest_strata(),
		BIPV2_Files.files_ingest.updateSuperFiles(f_ingest_out)
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := f_ingest_in  ,pDeleteSourceFile  := true)) //copy prepingest file to storage thor after using it.
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2.CommonBase.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy commonbase file to storage thor
	);
	
	// Mimic Ingest by pulling data from prod
	EXPORT fakeIngest(boolean doSample=false, boolean doInit=false, boolean doClean=false) := FUNCTION
		ds_prod := project(BIPV2.CommonBase.DS_PROD, transform(BIPV2.CommonBase.Layout,self:=left,self:=[]));
		ds_samp := IF(doSample, BIPV2_Files.tools_dotid().city_samp(ds_prod,st,v_city_name), ds_prod);
		ds_init := IF(doInit, BIPV2_Files.tools_dotid().reInitIDs(ds_samp), ds_samp);
		ds_clean := IF(doClean, BIPV2_Files.tools_dotid().reclean(ds_init), ds_init);
		RETURN SEQUENTIAL(
			OUTPUT(ds_clean,, f_ingest_out, COMPRESSED, OVERWRITE),
			BIPV2_Files.files_ingest.updateSuperFiles(f_ingest_out)
		);
	END;
	
	import bipv2_build;
	EXPORT prepIngest(pversion = 'BIPV2.KeySuffix') := FUNCTIONMACRO
		eclsample	:= '#workunit(\'name\',\'BIPV2 prepIngest @version@\');\n'
		             + '#workunit(\'priority\',\'high\');\n'
		             + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
		             + 'BIPV2_Build.proc_ingest().fn_prepIngest();';
		cluster		:= BIPV2_Build._Constants().Groupname;
		
		kickBuild	  := wk_ut.mac_ChainWuids(
			eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildPrepIngest'
			,pNotifyEmails := BIPV2_Build.mod_email.emailList
			,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::build_prepIngest'
			,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
		);
		
		RETURN kickBuild;
	ENDMACRO;
	
	EXPORT runIngest(pversion = 'BIPV2.KeySuffix', omitDisposition='') := FUNCTIONMACRO
		eclsample	:= '#workunit(\'name\',\'BIPV2 runIngest @version@\');\n'
		             + '#workunit(\'priority\',\'high\');\n'
		             + '#OPTION(\'multiplePersistInstances\',FALSE);\n'
		             + 'BIPV2_Build.proc_ingest(\'' + omitDisposition + '\').fn_runIngest;';
		cluster		:= BIPV2_Build._Constants().Groupname;
		
		kickBuild	  := wk_ut.mac_ChainWuids(
			eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'BuildRunIngest'
			,pNotifyEmails := BIPV2_Build.mod_email.emailList
			,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::build_runIngest'
			,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
		);
		
		RETURN kickBuild;
	ENDMACRO;
	
END;
