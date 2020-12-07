Import History_Analysis, STD, dops, PromoteSupers;

Export Proc_Build_All( string pVersion, string datasetname, string location, string cluster, string enviroment, string start_date, string end_date, string dopsenv ) := Function 
    
    update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, enviroment, start_date, end_date, dopsenv ).build_3; // params 

    convertToDeltas := History_Analysis.Fn_BuildDeltas(History_Analysis.Files(pVersion).keysizedhistory_rawdata);

    PromoteSupers.MAC_SF_BuildProcess(convertToDeltas, History_Analysis.Filenames(pVersion).BaseDeltas, writeDeltas, 3,,true);

    calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).counted_deltas);

    PromoteSupers.Mac_SF_BuildProcess(calculateStats, History_Analysis.Filenames(pVersion).BaseStatistics, writeStats, 3,, True);
    
    buildAll := ordered(update_source,
                                  writeDeltas,
                                  writeStats,
                                  ): Success(Send_Email(pVersion).build_success), Failure(Send_Email(pVersion).build_failure);

    Return buildAll;
End;