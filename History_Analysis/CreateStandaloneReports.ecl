Import History_Analysis, dops, PromoteSupers;

// The user can simply run individual reports using this module

Export CreateStandaloneReports := Module

    Export StandaloneQAReport( string pVersion, string datasetname, string location, string cluster, string fromdate, string todate, string dopsenv ) := Function

        update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, fromdate, todate, dopsenv ).build_4;

        convertToDeltas := History_Analysis.Fn_BuildDeltas.fn_buildQADeltas(History_Analysis.Files(pVersion).keysizedhistory_service);

        writeDeltas := output(convertToDeltas,, History_Analysis.Filenames(pVersion).standaloneDeltas, csv(heading(single),separator(','),quote('"')), overwrite, __compressed__ );

        calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).standaloneDeltas);

        writeStats := output(calculateStats,, History_Analysis.Filenames(pVersion).standaloneStats, csv(heading(single),separator(','),quote('"')), overwrite, __compressed__ );

        standaloneQA := ordered(update_source, 
                                    writeDeltas,
                                    writeStats,
                                    );

    Return standaloneQA;

    End;

    Export StandaloneProdReport( string pVersion, string datasetname, string location, string cluster, string fromdate, string todate, string dopsenv ) := Function

        
        update_source := History_Analysis.fspray(pVersion, datasetname, location, cluster, fromdate, todate, dopsenv ).build_4;

        convertToDeltas := History_Analysis.Fn_BuildDeltas.fn_buildProdDeltas(History_Analysis.Files(pVersion).keysizedhistory_service);

        writeDeltas := output(convertToDeltas,, History_Analysis.Filenames(pVersion).standaloneDeltas, csv(heading(single),separator(','),quote('"')), overwrite, __compressed__ );

        calculateStats := History_Analysis.MLCoreCalculateStatistics(History_Analysis.Files(pVersion).standaloneDeltas);

        writeStats := output(calculateStats,, History_Analysis.Filenames(pVersion).standaloneStats, csv(heading(single),separator(','),quote('"')), overwrite, __compressed__ );

        standaloneProd := ordered(update_source, 
                                    writeDeltas,
                                    writeStats,
                                    );

    Return standaloneProd;
    
    End;

End;
