import tools,bipv2_proxid,bipv2_proxid_mj6,BIPV2_Best,TopBusiness_BIPV2,BIPV2_PostProcess,BIPv2_HRCHY,BIPV2;

EXPORT filenames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  ,string   pID                   = ''
) :=
module

	shared lfileprefix		:= _Config(pUseOtherEnvironment).GenericTemplate	;

  // -- Ingest Stats
	export IngestStatsBySource := tools.mod_FilenamesBuild(lfileprefix             + 'IngestStatsBySource' ,pversion);
	export IngestOverallStats  := tools.mod_FilenamesBuild(lfileprefix             + 'IngestOverallStats'  ,pversion);
	export SourceStatsByDates  := tools.mod_FilenamesBuild(lfileprefix             + 'SourceStatsByDates'  ,pversion);

  // -- Iteration Stats
	export Iteration_Stats            := tools.mod_FilenamesBuild(lfileprefix + trim(pID) +             '_Iteration_Stats'      ,pversion);
	export Proxid_Iteration_Stats     := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_proxid_Iteration_Stats'      ,pversion);
	export Lgid3_Iteration_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Lgid3_Iteration_Stats'       ,pversion);
	export Proxid_mj6_Iteration_Stats := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Proxid_mj6_Iteration_Stats'  ,pversion);
	export dotid_Iteration_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Dotid_Iteration_Stats'       ,pversion);
	export empid_Iteration_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Empid_Iteration_Stats'       ,pversion);
	export empid_down_Iteration_Stats := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Empid_Down_Iteration_Stats'  ,pversion);
	export powid_Iteration_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Powid_Iteration_Stats'       ,pversion);
	export powid_down_Iteration_Stats := tools.mod_FilenamesBuild(lfileprefix             + 'BIPV2_Powid_Down_Iteration_Stats'  ,pversion);

  // -- Persistence Stats
	export Persistence_Record_Stats             := tools.mod_FilenamesBuild(lfileprefix + trim(pID) +       '_Persistence_Record_Stats'   ,pversion);
	export Persistence_Cluster_Stats            := tools.mod_FilenamesBuild(lfileprefix + trim(pID) +       '_Persistence_Cluster_Stats'  ,pversion);
	export Proxid_Persistence_Record_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'Proxid_Persistence_Record_Stats'   ,pversion);
	export Proxid_Persistence_Cluster_Stats     := tools.mod_FilenamesBuild(lfileprefix             + 'Proxid_Persistence_Cluster_Stats'  ,pversion);
	export Seleid_Persistence_Record_Stats      := tools.mod_FilenamesBuild(lfileprefix             + 'Seleid_Persistence_Record_Stats'   ,pversion);
	export Seleid_Persistence_Cluster_Stats     := tools.mod_FilenamesBuild(lfileprefix             + 'Seleid_Persistence_Cluster_Stats'  ,pversion);

  // -- Entity Stats
	export Entity_Stats           := tools.mod_FilenamesBuild(lfileprefix + trim(pID) +       '_Entity_Stats'   ,pversion);
	export Seleid_Entity_Stats    := tools.mod_FilenamesBuild(lfileprefix             + 'Seleid_Entity_Stats'   ,pversion);
	export Proxid_Entity_Stats    := tools.mod_FilenamesBuild(lfileprefix             + 'Proxid_Entity_Stats'   ,pversion);

  // -- PostLink Stats
	export PostLink_Stats           := tools.mod_FilenamesBuild(lfileprefix + trim(pID) +       '_PostLink_Stats'    ,pversion);
	export Seleid_PostLink_Stats    := tools.mod_FilenamesBuild(lfileprefix             + 'Seleid_PostLink_Stats'    ,pversion);
	export Proxid_PostLink_Stats    := tools.mod_FilenamesBuild(lfileprefix             + 'Proxid_PostLink_Stats'    ,pversion);

  export dall_filenames := 
      IngestStatsBySource               .dall_filenames
    + IngestOverallStats                .dall_filenames
    + SourceStatsByDates                .dall_filenames

    + Proxid_Iteration_Stats            .dall_filenames
    + Lgid3_Iteration_Stats             .dall_filenames
    + Proxid_mj6_Iteration_Stats        .dall_filenames

    + dotid_Iteration_Stats             .dall_filenames
    + empid_Iteration_Stats             .dall_filenames
    + empid_down_Iteration_Stats        .dall_filenames
    + powid_Iteration_Stats             .dall_filenames
    + powid_down_Iteration_Stats        .dall_filenames
    
    + Proxid_Persistence_Record_Stats   .dall_filenames
    + Proxid_Persistence_Cluster_Stats  .dall_filenames
    + Seleid_Persistence_Record_Stats   .dall_filenames
    + Seleid_Persistence_Cluster_Stats  .dall_filenames
    + Seleid_Entity_Stats               .dall_filenames
    + Proxid_Entity_Stats               .dall_filenames
    + Seleid_PostLink_Stats             .dall_filenames
    + Proxid_PostLink_Stats             .dall_filenames
    ;   

end;