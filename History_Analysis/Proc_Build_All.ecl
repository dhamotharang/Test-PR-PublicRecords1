Import History_Analysis, STD, dops, PromoteSupers, _Control;

Export Proc_Build_All( string pVersion, string datasetname, string location, string cluster,string fromdate, string todate, string dopsenv ) := Function 
    
    update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, enviroment, start_date, end_date, dopsenv ).build_3; // params 

    convertToDeltas := History_Analysis.Fn_BuildDeltas(History_Analysis.Files(pVersion).keysizedhistory_rawdata);

    PromoteSupers.MAC_SF_BuildProcess(convertToDeltas, History_Analysis.Filenames(pVersion).BaseDeltas, writeDeltas, 3,true,true);

    calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).counted_deltas);

    PromoteSupers.Mac_SF_BuildProcess(calculateStats, History_Analysis.Filenames(pVersion).BaseStatistics, writeStats, 3,true,true);
    

    ///////////////////////////////////////// The Despraying Process Begins ///////////////////////////////////////////////////////////////
    destinationIP := _control.IPAddress.bctlpedata10;

    DeltaUpdate := History_Analysis.Filenames(pVersion).BaseDeltas;

    DeltasStats := History_Analysis.Filenames(pVersion).BaseStatistics;
    
    destdirectory := '/data/Builds/builds/DataInsight_Dashboard/data/';

    desprayDeltaUpdate := STD.File.DeSpray(DeltaUpdate, destinationIP, destdirectory+'DeltaBase-Update'+pVersion+'.csv', allowoverwrite := true );

    desprayDeltaStats := STD.File.DeSpray(DeltasStats, destinationIP, destdirectory+'Deltas'+Pversion+'.csv', allowoverwrite := true );

    path := 'Desprayed to the server bctlpedata10 in path: '+destdirectory+' (Dataland)';

    buildAll := ordered(update_source,
                                  writeDeltas,
                                  writeStats,
                                  History_Analysis.OutputFiles(pVersion).dopsService,
                                  desprayDeltaUpdate,
                                  desprayDeltaStats,
                                  output(path, named('path_location')),
                                  ):Success(Send_Email(pVersion).build_success), Failure(Send_Email(pVersion).build_failure);

    Return buildAll;
End;