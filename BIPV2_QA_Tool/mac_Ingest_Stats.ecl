EXPORT mac_Ingest_Stats(
   pIngestWuid                                                  //Runingest wuid
  ,pversion
  ,pBaseFile            = 'BIPV2_Files.files_ingest.DS_BASE'
  ,pFatherFile          = 'BIPV2_Files.files_ingest.DS_FATHER'
  ,pOutputDatasetsOnly  = 'false'                               //mainly used for testing without outputting the file to disk and updating the superfiles
  ,pesp                 = 'WorkMan._Config.LocalEsp'
) := 
functionmacro

  import Workman,LinkingTools;

  // -- Ingest Stats by Source
  ingest_raw_stats := 
  RECORD
      STRING50 src_name;
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

  ds_raw_ingest_stats_by_source := wk_ut.get_DS_Result(pIngestWuid  ,'ds_roll' ,ingest_raw_stats,pesp);

  ds_ingests_stats_by_source := project(ds_raw_ingest_stats_by_source  ,transform(BIPV2_QA_Tool.Layouts.ingest_stats_by_source
    ,self.src     := left.src_name
    ,self.version := pversion
    ,self.cnt_old := left.cnt_old + left.cnt_ancient
    ,self         := left
  ));

  // -- Ingest Overall Stats
  ds_ingest_overall_stats_raw := wk_ut.get_DS_Result(pIngestWuid  ,'xt_status' ,BIPV2_QA_Tool.Layouts.ingest_overall_stats_raw,pesp);
  ds_ingest_overall_stats     := project(ds_ingest_overall_stats_raw  ,transform(BIPV2_QA_Tool.Layouts.ingest_overall_stats ,self.version := pversion,self := left));

  // -- Source Stats
  in_base   := table(pBaseFile   ,{rcid,source,source_record_id,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported
  ,string sbfe_id := if(mdr.sourcetools.SourceIsBusiness_Credit(source),vl_id ,''),cnp_name,vl_id,company_fein,active_duns_number,active_enterprise_number
  ,active_domestic_corp_key,company_inc_state,company_charter_number,foreign_corp_key,company_foreign_domestic
  ,prim_range,prim_name,sec_range,v_city_name,st,zip,company_phone
  ,fname,mname,lname}) : persist('~persist::BIPV2_QA_Tool::mac_Ingest_Stats::in_base');


  in_father := table(pFatherFile   ,{rcid,source,source_record_id,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported
  ,string sbfe_id := if(mdr.sourcetools.SourceIsBusiness_Credit(source),vl_id ,''),cnp_name,vl_id,company_fein,active_duns_number,active_enterprise_number
  ,active_domestic_corp_key,company_inc_state,company_charter_number,foreign_corp_key,company_foreign_domestic
  ,prim_range,prim_name,sec_range,v_city_name,st,zip,company_phone
  ,fname,mname,lname}) : persist('~persist::BIPV2_QA_Tool::mac_Ingest_Stats::in_father');

  in_fields := [
   'cnp_name'
  ,'vl_id','sbfe_id','company_fein','active_duns_number','active_enterprise_number'
  ,'active_domestic_corp_key','company_inc_state','company_charter_number','foreign_corp_key','company_foreign_domestic'
  ,'prim_range','prim_name','sec_range','v_city_name','st','zip','company_phone'
  ,'fname','mname','lname'
  ];
  dt_fields := ['dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported'];
  source_stats_raw := LinkingTools.SourceStats(in_base  ,in_father  ,rcid ,source ,in_fields  , ,dt_fields,,debug := false) 
  : persist('~persist::BIPV2_QA_Tool::mac_Ingest_Stats::ss')
  ;

  source_stats := sort(project(source_stats_raw,transform(BIPV2_QA_Tool.Layouts.SourceStatsByDates,self.src := if(trim(left.source) != 'TOTAL' ,mdr.sourceTools.translatesource(left.source),left.source),self.version := pversion,self := left)),if(trim(src) = 'TOTAL' ,'AAAAAAAA',src));
  
  import tools;

  output_IngestStatsBySource := tools.macf_WriteFile(BIPV2_QA_Tool.Filenames(trim(pversion)).IngestStatsBySource.logical ,ds_ingests_stats_by_source  ,pOverwrite := true);
  output_IngestOverallStats  := tools.macf_WriteFile(BIPV2_QA_Tool.Filenames(trim(pversion)).IngestOverallStats .logical ,ds_ingest_overall_stats     ,pOverwrite := true);
  output_SourceStatsByDates  := tools.macf_WriteFile(BIPV2_QA_Tool.Filenames(trim(pversion)).SourceStatsByDates .logical ,source_stats                ,pOverwrite := true);

  #IF(pOutputDatasetsOnly = false)
    result := sequential(
       output_IngestStatsBySource
      ,output_IngestOverallStats 
      ,output_SourceStatsByDates 
      ,BIPV2_QA_Tool.Promote(trim(pversion)).new2qaMult
    );
    
    return result;
  #ELSE
  
    return parallel(
       output(ds_ingests_stats_by_source  ,named('IngestStatsBySource'),all)
      ,output(ds_ingest_overall_stats     ,named('IngestOverallStats' ),all)
      ,output(source_stats                ,named('SourceStatsByDates' ),all)
    );
    
  #END
  
endmacro;