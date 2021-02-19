Import History_Analysis, STD, dops, PromoteSupers, _Control;

Export Proc_Build_All( string pVersion, string datasetname, string location, string cluster,string fromdate, string todate ) := Function 
    

    /////////////////////////////////////////// Input File for Prod and QA /////////////////////////////////////////////////////////
    update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, fromdate, todate ).build_3; // params 

    dopsService := History_Analysis.Files(pVersion).keysizedhistory_service;


    /////////////////////////////////////////////// Writing QA Deltas ///////////////////////////////////////////////////////////
    convertToDeltasQA := History_Analysis.Fn_BuildDeltas.fn_buildQADeltas(History_Analysis.Files(pVersion).keysizedhistory_rawdata);

    PromoteSupers.MAC_SF_BuildProcess(convertToDeltasQA, History_Analysis.Filenames(pVersion).BaseDeltasQA, writeDeltasQA, 3,true,true);

    /////////////////////////////////////////////// Writing Prod Files /////////////////////////////////////////////////////////////////////
    convertToDeltasProd := History_Analysis.Fn_BuildDeltas.fn_buildProdDeltas(History_Analysis.Files(pVersion).keysizedhistory_rawdata);

    PromoteSupers.MAC_SF_BuildProcess(convertToDeltasProd, History_Analysis.Filenames(pVersion).BaseDeltasProd, writeDeltasProd, 3,true,true);

    calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).counted_deltasProd);

    PromoteSupers.Mac_SF_BuildProcess(calculateStats, History_Analysis.Filenames(pVersion).BaseStatistics, writeStats, 3,true,true);


    ///////////////////////////////////////// The Despraying Process Begins ///////////////////////////////////////////////////////////////
    destinationIP := _control.IPAddress.bctlpedata10;

    DeltaUpdateQA := History_Analysis.Filenames(pVersion).BaseDeltasQA;

    DeltaUpdateProd := History_Analysis.Filenames(pVersion).BaseDeltasProd;

    DeltasStats := History_Analysis.Filenames(pVersion).BaseStatistics;
    
    destdirectory := '/data/Builds/builds/DataInsight_Dashboard/data/';

    desprayDeltaUpdateQA := STD.File.DeSpray(DeltaUpdateQA, destinationIP, destdirectory+'DeltaBase-UpdateQA.csv', allowoverwrite := true );

    desprayDeltaUpdateProd := STD.File.DeSpray(DeltaUpdateProd, destinationIP, destdirectory+'DeltaBase-UpdateProd.csv', allowoverwrite := true );

    desprayDeltaStats := STD.File.DeSpray(DeltasStats, destinationIP, destdirectory+'Deltas.csv', allowoverwrite := true );

    path := 'Desprayed to the server bctlpedata10 in path: '+destdirectory+' (Dataland)';

    buildAll := ordered(update_source,
                                    writeDeltasQA,
                                    writeDeltasProd,
                                    writeStats,
                                    output(dopsService, named('dops_service')),
                                    desprayDeltaUpdateQA,
                                    desprayDeltaUpdateProd,
                                    desprayDeltaStats,
                                    output(path, named('path_location')),
                                  ):Success(Send_Email(pVersion).build_success), Failure(Send_Email(pVersion).build_failure);

    Return buildAll;
End;