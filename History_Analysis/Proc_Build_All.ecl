Import History_Analysis, STD, dops;

Export Proc_Build_All( string pVersion, string datasetname, string location, string cluster, string enviroment, string start_date, string end_date, string dopsenv ) := Function 
    
    update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, enviroment, start_date, end_date, dopsenv ).build_all; // params 
    updated_deltas := History_Analysis.Fn_BuildDeltas(pVersion);
    update_statistics := History_Analysis.MLCoreCalculateStatistics(pVersion);

    deltas_output      := output(History_Analysis.Files(pVersion).counted_deltas, named('updated_delta_report'));
    delta_stats_output := output(History_Analysis.Files(pVersion).delta_statistics, Named('updated_delta_statistics'));
    

    unique_new_base_files := ordered(update_source,
                                  updated_deltas,
                                  update_statistics,
                                  deltas_output,
                                  delta_stats_output,
                                  ): Success(Send_Email(pVersion).build_success), Failure(Send_Email(pVersion).build_failure);

    Return unique_new_base_files;
End;