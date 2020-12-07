
Import History_Analysis, dops, PromoteSupers;

  
// The user can simply run individual reports using this module

Export CreateStandaloneReports( string pVersion, string datasetname, string location, string cluster, string enviroment, string start_date, string end_date, string dopsenv ) := Function
    
    update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, enviroment, start_date, end_date, dopsenv).build_4;

    convertToDeltas := History_Analysis.Fn_BuildDeltas(History_Analysis.Files(pVersion).keysizedhistory_service);

    PromoteSupers.MAC_SF_BuildProcess(convertToDeltas, History_Analysis.Filenames(pVersion).standaloneDeltas, writeDeltas, 3,,true);

    calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).standaloneDeltas);

    PromoteSupers.Mac_SF_BuildProcess(calculateStats, History_Analysis.Filenames(pVersion).standaloneStats, writeStats, 3,, true);

    standaloneReports := ordered(update_source, 
                                writeDeltas,
                                writeStats,
                                );

Return standaloneReports;

End;