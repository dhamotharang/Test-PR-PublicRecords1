import BIPV2_Files, BIPV2, BIPV2_Ingest,BIPV2_Tools; 
import wk_ut,tools,std;
export proc_ingest(STRING omitDisposition='') := module
	/* ---------------------- Files -------------------------------------- */
	export f_ingest_in	    := BIPv2_Files.files_ingest.FILE_IN            + '_' + BIPV2.KeySuffix;
	export f_ingest_out	    := BIPv2_Files.files_ingest.FILE_OUT           + '_' + BIPV2.KeySuffix;
	export f_ingest_typ	    := BIPv2_Files.files_ingest.FILE_TYP           + '_' + BIPV2.KeySuffix;
	export f_ingest_err	    := BIPV2_Files.files_ingest.FILE_ERR           + '_' + BIPV2.KeySuffix;
	export f_ingest_drcids	:= BIPV2_Files.files_ingest.FILE_DROPPED_RCIDS + '_' + BIPV2.KeySuffix;
	
	
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
    As_Linking_Counts := pAs_Linking_Counts : independent;
    
    return parallel(
       // Strata.macf_CreateXMLStats(ds_err_summ_strata  ,'BIPV2','PrepIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Remedies' ,'ErrorSummary' 	,pIsTesting,pOverwrite) //group on src_name
       Strata.macf_CreateXMLStats(As_Linking_Counts  ,'BIPV2','PrepIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'stats'    ,'AsLinking'	    ,pIsTesting,pOverwrite) //group on File
      
    );
  end;
  
	EXPORT fn_prepIngest(
		dataset(BIPV2_Files.layout_ingest) ds_as_linking  = BIPV2_Files.files_ingest.ds_as_linking
   ,string                             pversion       = bipv2.KeySuffix
	) := 
  function
    
    kick_copy2_storage_thor_prepingest  := BIPV2_Tools.Copy2_Storage_Thor(BIPV2.filenames(pversion).Source_Ingest.new ,pversion ,'Prep_Ingest');
    copyempid2StorageThor_prepingest    := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_prepingest ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

    return SEQUENTIAL(
      // convert as_linking to as_header - store in Ingest SuperFile
       BIPV2.KeySuffix_mod2.SanityCheck
      ,OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).base       ,, f_ingest_in , COMPRESSED, OVERWRITE)
      ,OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).err_rec    ,, f_ingest_err, COMPRESSED, OVERWRITE)
      ,OUTPUT(BIPV2_Files.tools_dotid(ds_as_linking).err_summary, NAMED('err_summary'), ALL)
      ,BIPV2_Files.tools_dotid(ds_as_linking).outCounts
      ,do_Prepingest_strata(pversion,pds_as_linking := ds_as_linking)
      ,BIPV2_Files.files_ingest.updateBuilding (f_ingest_in )
      ,BIPV2_Files.files_ingest.updateErrorFile(f_ingest_err)
      ,copyempid2StorageThor_prepingest
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := BIPV2.filenames(bipv2.KeySuffix).Source_Ingest.new  ,pDeleteSourceFile  := true)) //copy source ingest file to storage thor after using it.
    );
  end;
	
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
    import mdr;
		xt_base		:= TABLE(BIPV2_Ingest.In_BASE, {source}, source, MERGE);
		xt_ingest	:= TABLE(BIPV2_Ingest.In_INGEST, {source}, source, MERGE);
		SHARED ds_omits := JOIN(xt_base, xt_ingest, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LEFT ONLY, LOOKUP);
		EXPORT set_omitted_sources := set(ds_omits, mdr.sourceTools.translatesource(source));
    
		EXPORT check := IF(
			omitDisposition<>'',
			ASSERT(NOT EXISTS(ds_omits), 'Sources omitted from Ingest file'),
			ASSERT(NOT EXISTS(ds_omits), 'Sources omitted from Ingest file -- pass \'preserve\' or \'ghost\'', FAIL)
		);
		
		EXPORT preserve(DATASET(RECORDOF(BIPV2_Ingest.In_BASE)) ds) := FUNCTION
			ds_bypass		:= JOIN(ds, ds_omits, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LEFT ONLY, LOOKUP);  //sources that we still get
			ds_work			:= JOIN(ds, ds_omits, LEFT.source=RIGHT.source, TRANSFORM(LEFT), LOOKUP);             //records from sources omitted
			ds_preserve	:= JOIN(BIPV2_Ingest.In_BASE, ds_work, LEFT.rcid=RIGHT.rcid, TRANSFORM(LEFT), KEEP(1), HASH); //preserve status from last build for omitted sources
			results			:= ds_bypass + ds_preserve;
			RETURN IF(omitDisposition='preserve' AND EXISTS(ds_omits), results, ds);
		END;
	END;
	
	shared suppressedData := BIPV2_Files.files_suppressions().ds_suppressions;
	shared ingest_results := PROJECT(BIPV2_Ingest.Ingest().AllRecords, TRANSFORM(BIPV2.CommonBase.Layout, SELF.ingest_status:=BIPV2_Ingest.Ingest().RTToText(LEFT.__Tpe), SELF:=LEFT));
	SHARED ds_re_DID      := BIPV2_Files.tools_dotid().APPEND_DID(distribute(omittedSources.preserve(ingest_results)));//this can get skewed, so add distribute
	SHARED ds_setsos      := BIPV2_Files.tools_dotid().SetSOS(project(ds_re_DID,BIPV2.CommonBase.Layout));//set sos again because the ingest status affects it.

	SHARED ds_removesuppressed := join(ds_setsos, suppressedData(suppressed), 
															left.fname = right.fname and
															left.mname = right.mname and
															left.lname = right.lname and
															left.name_suffix = right.name_suffix and
															left.cnp_name = right.cnp_name and
															left.cnp_number = right.cnp_number and
															left.cnp_store_number = right.cnp_store_number and
															left.prim_range = right.prim_range and
															left.predir = right.predir and
															left.prim_name = right.prim_name and
															left.addr_suffix = right.addr_suffix and
															left.postdir = right.postdir and
															left.unit_desig = right.unit_desig and
															left.sec_range = right.sec_range and
															left.v_city_name = right.v_city_name and
															left.st = right.st and
															left.zip = right.zip and
															left.active_duns_number = right.active_duns_number and
															left.active_enterprise_number = right.active_enterprise_number and
															left.ebr_file_number = right.ebr_file_number and
															left.active_domestic_corp_key = right.active_domestic_corp_key and
															left.foreign_corp_key = right.foreign_corp_key and
															left.unk_corp_key = right.unk_corp_key and
															left.company_fein = right.company_fein and
															left.company_phone = right.company_phone and
															left.company_ticker = right.company_ticker and
															left.company_ticker_exchange = right.company_ticker_exchange and
															left.company_foreign_domestic = right.company_foreign_domestic and
															left.company_url = right.company_url and
															left.company_inc_state = right.company_inc_state and
															left.company_charter_number = right.company_charter_number and
															left.vl_id = right.vl_id and
															left.duns_number = right.duns_number and
															left.contact_ssn = right.contact_ssn and
															left.contact_dob = right.contact_dob and					
															left.company_name = right.company_name and
															left.contact_dob = right.contact_dob and
															left.contact_email = right.contact_email,
								                  transform(left), left only, lookup);
											   
	SHARED ds_ingested := project(ds_removesuppressed,recordof(BIPV2_Ingest.In_BASE));  
	// SHARED ds_ingested := project(dataset('~thor_data400::bipv2_ingest::out_20161216',bipv2.CommonBase.layout,thor),recordof(BIPV2_Ingest.In_BASE));  

	SHARED xt_src_status	:= TABLE(ds_ingested, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), ingest_status, UNSIGNED cnt:=COUNT(GROUP)}, source, ingest_status, MERGE);
	SHARED xt_agg_ingest	:= TABLE(xt_src_status, {src_name, ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, src_name, ingest_status, FEW);

	SHARED xt_status			:= TABLE(xt_src_status, {ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, ingest_status, FEW);
	SHARED ds_unused			:= BIPV2_Files.files_ingest.ds_as_linking(NOT BIPV2.mod_sources.srcInBIPV2Header(source));
	SHARED xt_src_unused	:= TABLE(ds_unused, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), UNSIGNED cnt := COUNT(GROUP)}, source, MERGE);
	export xt_agg_unused	:= TABLE(xt_src_unused, {src_name, UNSIGNED cnt := SUM(GROUP,cnt)}, src_name);
	
	SHARED xt_src_base		:= TABLE(BIPV2_Ingest.In_BASE, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), ingest_status, UNSIGNED cnt:=COUNT(GROUP)}, source, ingest_status, MERGE);
	// SHARED xt_src_base		:= TABLE(BIPV2.CommonBase.DS_STATIC, {source, STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), ingest_status, UNSIGNED cnt:=COUNT(GROUP)}, source, ingest_status, MERGE);
	SHARED xt_agg_base		:= TABLE(xt_src_base, {src_name, ingest_status, UNSIGNED cnt:=SUM(GROUP,cnt)}, src_name, ingest_status, FEW);

  shared ds_ingest_slim := table(ds_ingested            ,{rcid,STRING50 src_name:=mdr.sourceTools.translatesource(source),ingest_status});
  // shared ds_base_slim   := table(BIPV2_Ingest.In_BASE   ,{rcid,STRING50 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source),ingest_status});
  shared ds_base_slim   := table(BIPV2.CommonBase.DS_STATIC   ,{rcid,STRING50 src_name:=mdr.sourceTools.translatesource(source),ingest_status});

	SHARED xt_evolve1 :=
  //this join tries to get the ancient status records.  what was old in the previous build is now ancient in teh current build
  //this is not perfect because some old records might come back to life in the ingest, but we don't account for those here...
		JOIN(
			ds_ingest_slim, ds_base_slim, 
			left.rcid = right.rcid and left.ingest_status='Old' and right.ingest_status='Old' and left.src_name not in omittedSources.set_omitted_sources,
			transform(recordof(ds_ingest_slim), self.ingest_status:='Ancient', , self:=left),hash)
  //try to subtract the old record count from the previous base from the old record count from current ingest.
  //problem is, this could be negative number
		+ JOIN(
			ds_ingest_slim, ds_base_slim, 
			left.rcid = right.rcid and left.ingest_status='Old' and right.ingest_status='Old' and left.src_name not in omittedSources.set_omitted_sources,
			transform(recordof(ds_ingest_slim), self:=left),
			LEFT only,hash);
  shared xt_evolve := table(xt_evolve1  ,{src_name,ingest_status,unsigned8 cnt := count(group)},src_name,ingest_status,merge);
  
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
	export ds_roll := ROLLUP(PROJECT(SORT(xt_evolve,src_name),toRoll(LEFT)), doRoll(LEFT,RIGHT), src_name);
	
	export dropped_rcids := join(BIPV2_Ingest.In_BASE, ds_ingested,
	                             left.rcid = right.rcid,
															 transform(left), left only, hash);
	
	EXPORT doStats := PARALLEL(
		OUTPUT(COUNT(BIPV2_Ingest.In_BASE), NAMED('cnt_base')),
		OUTPUT(COUNT(BIPV2_Ingest.In_INGEST), NAMED('cnt_ingest')),
		OUTPUT(COUNT(ds_ingested), NAMED('cnt_out')),
		OUTPUT(COUNT(TABLE(ds_ingested,{dotid},dotid,MERGE)), NAMED('cnt_out_dotids')),
		OUTPUT(TABLE(ds_ingested,{ingest_status, cnt:=COUNT(GROUP)},ingest_status,FEW), NAMED('xtab_types')),
		BIPV2_Ingest.Ingest().DoStats,
		// and now some new ones...
		OUTPUT(SORT(xt_status,RECORD), NAMED('xt_status'), ALL),
		OUTPUT(SORT(xt_src_status,RECORD), NAMED('xt_src_status'), ALL),
		OUTPUT(SORT(xt_agg_ingest,RECORD), NAMED('xt_agg_ingest'), ALL),
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

  export fileTyp(unsigned c_ancient, unsigned c_old, unsigned c_unchanged, unsigned c_updated, unsigned c_new):=
  function
      //so, if the percentage of new records vs old records is too high, then flag it.  if new > 30% of old
      //also, if the percentage of new records
      pct_diff_old_new              := c_new / c_old * 100.0;
      pct_new_vs_updated_unchanged  := c_new / (c_unchanged + c_updated + c_new)  * 100.0;
      pct_unchanged_vs_all          := c_unchanged / (c_old + c_unchanged + c_updated + c_new)  * 100.0;
      pct_new_vs_all                := c_new / (c_unchanged + c_updated + c_new + c_old + c_ancient)  * 100.0;
      
      
			return map(
         pct_new_vs_all               > 90.0  => 'NEW SOURCE'
			  ,pct_new_vs_updated_unchanged > 30.0  => 'SOURCE RECORD ID NOT PERSISTENT'
				,pct_unchanged_vs_all         > 99.9  => 'SAME SOURCE FILE'
        ,                                        ''
      );
  end;

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
		rec0:=record
			string source;
			string valuename;
			unsigned8 countval;
		end;
    isneg1(unsigned pint) := if(pint > 1000000000000,0,pint);    
		
		dropped_rcids_strata    := dataset(f_ingest_drcids,recordof(BIPV2_Ingest.In_BASE),thor,opt);
		ds_dropped_rcids_by_src := sort(table(dropped_rcids_strata,
		                                      {source, unsigned countval := count(group)},
																					source,
																					FEW), 
		                                -countval
																	  )
                                     : independent;
		
    dds_rollX := project(pDS_Roll  ,transform(l_roll_strata,self.source := left.src_name,self.cnt_ancient := isneg1(left.cnt_ancient),self.cnt_old := isneg1(left.cnt_old), self.cnt_unchanged := isneg1(left.cnt_unchanged), self.cnt_updated := isneg1(left.cnt_updated) ,self.cnt_new := isneg1(left.cnt_new),
    ,self.countgroup := self.cnt_ancient + self.cnt_old + self.cnt_unchanged + self.cnt_updated + self.cnt_new,self.count := self.countgroup,self := left)) : independent;
    ds_logicalfilelist := nothor(std.file.logicalfilelist())(regexfind('profilestat::strata::bipv2_full_build_orbit_item_list::' + pversion + '::.*csv',name,nocase));

    ds_orbit_items := dataset('~' + ds_logicalfilelist[1].name,{unsigned sortfield,string name,unsigned countgroup,unsigned cnt},csv(heading(1)));

		dds_roll:=project(dds_rollX, transform(recordof(dds_rollX), 
											self.source:=trim(left.source);
											self:=left));
    Q_orbititems :=project(ds_orbit_items, transform(rec0, 
										 self.source:=left.name; self.valuename:='';
										 self.countval:=0));
    Q_type:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:=fileTyp(left.cnt_ancient, left.cnt_old, left.cnt_unchanged, left.cnt_updated, left.cnt_new);
										 self.countval:=0))(valuename != '');
    Q_countgroup:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='population';
										 self.countval:=left.countgroup));	
		Q_ancient:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='cnt_ancient';
										 self.countval:=left.cnt_ancient));	
		Q_old:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='cnt_old';
										 self.countval:=left.cnt_old));
		Q_unchanged:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='cnt_unchanged';
										 self.countval:=left.cnt_unchanged));
		Q_updated:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='cnt_updated';
										 self.countval:=left.cnt_updated));
		Q_new:=project(dds_roll, transform(rec0, 
										 self.source:=left.source; self.valuename:='cnt_new';
										 self.countval:=left.cnt_new));
		Q_All:=	Q_orbititems + Q_type + Q_countgroup + Q_ancient + Q_old + Q_unchanged + Q_updated + Q_new;
		Q_Final:=sort(Q_All,source, valuename, skew(1.0)) : independent;
    
    // ds_alerts_for_email := join(Q_Final  ,Q_type ,left.source = right.source  ,transform(left),lookup);
    source_stats_email_string_prep := project(sort(Q_type,valuename,source)  ,transform({unsigned cnt,string valuename,string source,string emailstring},self.emailstring := trim(left.source),self := left,self.cnt := counter));
    source_stats_email_string := rollup(sort(source_stats_email_string_prep,valuename,source) ,true 
      ,transform(recordof(left)
        ,self.emailstring := map(left.cnt = 1 and left.valuename = right.valuename
                                => trim(left.valuename) + ':\n\t' + left.source  + '\n\t'
                                                                  + right.source + '\n'
                                ,left.cnt = 1
                                => trim(left.valuename) + ':\n\t' + left.source  + '\n' +
                                   trim(right.valuename) + ':\n\t' + right.source + '\n'
                            ,left.valuename = right.valuename => 
                                left.emailstring + '\t' + right.source + '\n'
                            ,left.valuename != right.valuename => 
                                left.emailstring + trim(right.valuename) + ':\n\t' + right.source  + '\n'  
                            ,left.emailstring + right.emailstring
                            )
        ,self := right
      ));
    
    email_ingest_alerts := iff(exists(Q_type) 
      ,STD.System.Email.SendEmail( bipv2_build.mod_email.emailList 
                                  ,'BIPV2 Runingest Source Status Alerts ' + pversion
                                  ,source_stats_email_string[1].emailstring
      ));
    
		dds_Total_status := project(pTotal_Status,transform({lay_total_status,unsigned count},self.count := left.countgroup,self := left));
    ds_RE_DID_Stats := BIPV2_Files.tools_dotid().RE_DID_Stats(pds_re_DID) : independent;
//-------simplify the ReDID part to construct another alert:
		ds2:=table(ds_RE_DID_Stats(source<>'source') ,{source, field,unsigned countgroup := sum(group,countgroup)  
      ,unsigned total_new   := sum(group,total_new)  
      ,unsigned total_old   := sum(group,total_old)  
      ,unsigned gained      := sum(group,gained)  
      ,unsigned lost        := sum(group,lost)  
      ,unsigned changed     := sum(group,changed)  
      ,unsigned same        := sum(group,same)  
      },source, field,merge);

		rec1:=record
			string source;
			string field;
			string valuename;
			unsigned8 countval;
		end;
		
		P_countgroup:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='population';
										 self.countval:=left.countgroup));
		P_new:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='total_new';
										 self.countval:=left.total_new));
		P_old:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='total_old';
										 self.countval:=left.total_old));
		P_gained:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='gained';
										 self.countval:=left.gained));
		P_lost:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='lost';
										 self.countval:=left.lost));
		P_changed:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='changed';
										 self.countval:=left.changed));
		P_same:=project(ds2, transform(rec1, 
										 self.source:=left.source; self.field:=left.field; self.valuename:='same';
										 self.countval:=left.same));
		P_ALL:=P_countgroup+P_new+P_old+P_gained+P_lost+P_changed+P_same;
		P_Final:=sort(P_ALL, source, field, valuename, skew(1.0)) : independent;
    lds_agg_unused := pds_agg_unused : independent;
    Total_Counts := pTotal_Counts : independent;
    return parallel(
     //Strata.macf_CreateXMLStats(dds_roll,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'status'     ,'Source' 	,pIsTesting,pOverwrite) //group on src_name
       email_ingest_alerts
      ,Strata.macf_CreateXMLStats(Q_Final, 'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'statusSmpl' ,'Source' 	,pIsTesting,pOverwrite) //group on src_name
      // ,Strata.macf_CreateXMLStats(dds_Total_status,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'status' ,'Total'	  ,pIsTesting,pOverwrite) //group on ingest_status
      ,Strata.macf_CreateXMLStats(Total_Counts   ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'counts' ,'Total' 	  ,pIsTesting,pOverwrite) //group on File
      ,Strata.macf_CreateXMLStats(lds_agg_unused  ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Sources','Unused'   ,pIsTesting,pOverwrite) //group on src_name
      ,Strata.macf_CreateXMLStats(ds_RE_DID_Stats ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Stats'  ,'ReDID'    ,pIsTesting,pOverwrite) //group on source,field //group on source,ingest_status,field (old)
      ,Strata.macf_CreateXMLStats(P_Final ,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'StatsSmpl'  ,'ReDID'    ,pIsTesting,pOverwrite) //group on source,field //group on source,ingest_status,field (old)
      ,Strata.macf_CreateXMLStats(ds_dropped_rcids_by_src,'BIPV2','RunIngest'	,pversion	,BIPV2_Build.mod_email.emailList	,'Rcids'  ,'Dropped'    ,pIsTesting,pOverwrite)
    );
  
  end;
  
  shared build_days_apart          := ut.DaysApart((string8)tools.fun_GetFilenameVersion(BIPV2.CommonBase.file_base),(string8)Std.Date.Today());
  shared ingested_commonbase_file  := nothor(FileServices.SuperFileContents(BIPV2.CommonBase.file_base)[1].name);
  // shared ds_commonbase_files       := global(nothor(std.file.logicalfilelist()),few)(regexfind(BIPV2.CommonBase.filePrefix + '[[:digit:]]{8}',name,nocase));
  // shared latest_commonbase_file    := sort(ds_commonbase_files,-name)[1].name;
  // shared ds_commonbase_files       := global(nothor(std.file.logicalfilelist(BIPV2.CommonBase.filePrefix + '*')),few);
  #option('outputLimit',500);
  shared ds_commonbase_files       := global(nothor(std.file.logicalfilelist()),few);
  shared ds_filtered_commonbase    := ds_commonbase_files(regexfind('^' + BIPV2.CommonBase.filePrefix + '[[:digit:]]{8}.*$',name,nocase));
  shared latest_commonbase_record  := topn(ds_filtered_commonbase,3,-modified);
  shared latest_commonbase_file    := latest_commonbase_record[1].name;
  shared ingested_file_modified_date := ds_commonbase_files(regexfind('^' + ingested_commonbase_file + '$',name,nocase))[1].modified;
  shared daysapart := ut.DaysApart(
     latest_commonbase_record[1].modified[1..4] + latest_commonbase_record[1].modified[6..7] + latest_commonbase_record[1].modified[9..10]
    ,ingested_file_modified_date[1..4]          + ingested_file_modified_date[6..7]          + ingested_file_modified_date[9..10]
  );
  #UNIQUENAME(CONFIRM_INGEST_FILE_EVENT   )
  import wk_ut;
  shared latest_3_commonbase_files := rollup(project(sort(latest_commonbase_record,-modified),transform({string name},self.name := '\t' + left.name)),true,transform(recordof(left),self.name := left.name + '\n' + right.name));
  shared email_subject := 'BIPV2_Runingest ' + bipv2.KeySuffix + ' ALERT!!! Please confirm the commonbase file ingested!';
  shared email_body    :=    
                      'The commonbase file pulled in for this ' + bipv2.KeySuffix + ' runingest build is ' 
                      + (string)build_days_apart + ' build date days old and ' + daysapart + ' days old according to the modified date:\n'
                    + '\t' + trim(ingested_commonbase_file)  + '\n\n'
                    + 'Please verify that you are pulling in the correct base file.\n\n'
                    + if(trim(ingested_commonbase_file) != trim(latest_commonbase_file)
                        ,'The newest commonbase file is this one:\n\t' + trim(latest_commonbase_file) + '\n\n'
                        ,   'For reference, the latest base files are these:\n'
                          + latest_3_commonbase_files[1].name
                          + '\n\n'
                      )
                        
                    + 'http://' + wk_ut._constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary'

                    // + 'After you have fixed the file, or confirmed it was ok, click the following link:\n'
                    // + wk_ut.Push_Event_Result_Link(%'CONFIRM_INGEST_FILE_EVENT'%,'Rerun') + '\n' //removed because of this bug: https://track.hpccsystems.com/browse/HPCC-11172
                    ;
                    
  export debug_alert := parallel(
     output(build_days_apart          ,named('build_days_apart'         ))
    ,output(ingested_commonbase_file  ,named('ingested_commonbase_file' ))
    ,output(ds_commonbase_files       ,named('ds_commonbase_files'      ))
    ,output(latest_commonbase_file    ,named('latest_commonbase_file'   ))
    ,output(email_subject             ,named('email_subject'            ))
    ,output(email_body                ,named('email_body'               ))
  );
  
  export email_alert := 
    iff(build_days_apart >= 45 or daysapart >= 45 or ingested_commonbase_file != latest_commonbase_file
      ,sequential(
         STD.System.Email.SendEmail ( BIPV2_Build.mod_email.emaillist, email_subject, email_body)
        // ,wait(%'CONFIRM_INGEST_FILE_EVENT'%) //blocked by hpcc bug https://track.hpccsystems.com/browse/HPCC-11172 
        // ,STD.System.Email.SendEmail ( 'laverne.bentley@lexisnexis.com', 'BIPV2_Runingest ' + bipv2.KeySuffix + ' commonbase file confirmed, build continuing...', 'Giddy up!')
      ));

  export debug_email_alert := sequential(debug_alert  ,email_alert);
  
  shared uu:=sort(BIPV2_Ingest.Scrubs_Stats.SummaryStats_smpl,-totalerr);
  shared vv:=uu(totalerr>=100) : independent;

  shared ww:=BIPV2_Ingest.Scrubs_Stats.BadValues;
  shared xx:=choosen(ww,200) : independent;

  export Scrub_Strata_SummaryStats :=Strata.macf_CreateXMLStats(vv ,'BIPV2','Ingest',BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'SummaryStatsSmpl','Scrubs',false,false);
  export Scrub_Strata_BadValues :=Strata.macf_CreateXMLStats(xx ,'BIPV2','Ingest',BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'BadValues','Scrubs',false,false);

  import BIPV2_QA_Tool;
	// Merge Base SuperFile with Ingest SuperFile - queue up the results for DOT
  // for strata: ds_roll,xtab_types and the count fields(put into 1 dataset)
	EXPORT fn_runIngest(
    string pversion = bipv2.KeySuffix
  ) := 
  function
    kick_copy2_storage_thor_prepingestfile   := BIPV2_Tools.Copy2_Storage_Thor(f_ingest_in                                                                   ,pversion ,'Run_Ingest_Prep_Ingest_file'  );
    kick_copy2_storage_thor_fathercommonbase := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2.CommonBase.FILE_BASE)[1].name)  ,pversion ,'Run_ingest_father_common_base');

    copyempid2StorageThor_prepingestfile      := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_prepingestfile   ,named('copy2_Storage_Thor_prep_ingest_file__html' )));  //copy orig file to storage thor
    copyempid2StorageThor_fathercommonbase    := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor_fathercommonbase ,named('copy2_Storage_Thor_father_commonbase__html')));  //copy orig file to storage thor

    return SEQUENTIAL(
       email_alert
      ,parallel(
         omittedSources.check
        ,OUTPUT(ds_ingested,, f_ingest_out, COMPRESSED, OVERWRITE)
        ,OUTPUT(TABLE(ds_ingested,{rcid, ingest_status}),, f_ingest_typ, COMPRESSED, OVERWRITE)
        ,OUTPUT(dropped_rcids,, f_ingest_drcids, COMPRESSED, OVERWRITE)
        ,doStats
        ,do_runingest_strata()
      )      
      ,BIPV2_Files.files_ingest.updateSuperFiles(f_ingest_out)
      ,BIPV2_QA_Tool.mac_Ingest_Stats(workunit,pversion)
      ,copyempid2StorageThor_prepingestfile  
      ,copyempid2StorageThor_fathercommonbase
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := f_ingest_in  ,pDeleteSourceFile  := true)) //copy prepingest file to storage thor after using it.
      // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2.CommonBase.FILE_BASE)[1].name)  ,pDeleteSourceFile  := true))  //copy commonbase file to storage thor
      ,Scrub_Strata_SummaryStats
      ,Scrub_Strata_BadValues
    );
	end;
  
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
	
	EXPORT runIngest(pversion = 'BIPV2.KeySuffix', omitDisposition='\'\'') := FUNCTIONMACRO
		eclsample	:= '#workunit(\'name\',\'BIPV2 runIngest @version@\');\n'
		             + '#workunit(\'priority\',\'high\');\n'
		             + '#OPTION(\'multiplePersistInstances\',FALSE);\n'
		             + 'BIPV2_Build.proc_ingest(\'' + omitDisposition + '\').fn_runIngest(\'@version@\');';
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
