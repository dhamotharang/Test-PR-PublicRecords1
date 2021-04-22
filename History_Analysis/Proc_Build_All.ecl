Import History_Analysis, STD, dops, PromoteSupers, _Control, lib_stringlib, wk_ut,ut, Data_Services;


// datasetname = dataset name from dops
// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// start date of ten day range
// end date of ten day range
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB


Export Proc_Build_All(string vip, string path, string contacts, string pVersion, string datasetname, string location, string cluster,string fromdate, string todate ) := Function 
    
    todays_date := (string)Std.Date.today();

    yesterdays_date := (string)Std.Date.AdjustDate((integer)todays_date,0,0,-1);
    tomorrows_date := (string)Std.Date.AdjustDate((integer)todays_date,0,0,1);

    /////////////////////////////////////////// Input File for Prod and QA /////////////////////////////////////////////////////////
    update_source := History_Analysis.fspray(vip,pVersion, datasetname, location, cluster, yesterdays_date, tomorrows_date ).build_3; // params 

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
    destinationIP := vip;

    DeltaUpdateQA := History_Analysis.Filenames(pVersion).BaseDeltasQA;

    DeltaUpdateProd := History_Analysis.Filenames(pVersion).BaseDeltasProd;

    DeltasStats := History_Analysis.Filenames(pVersion).BaseStatistics;
    
    destdirectory := path;

    desprayDeltaUpdateQA := STD.File.DeSpray(DeltaUpdateQA, destinationIP, destdirectory+'DeltaBase-UpdateQA.csv', allowoverwrite := true );

    desprayDeltaUpdateProd := STD.File.DeSpray(DeltaUpdateProd, destinationIP, destdirectory+'DeltaBase-UpdateProd.csv', allowoverwrite := true );

    desprayDeltaStats := STD.File.DeSpray(DeltasStats, destinationIP, destdirectory+'Deltas.csv', allowoverwrite := true );

    dopspath := 'Desprayed to the server bctlpedata12 in path: '+destdirectory+' (Production)';

    buildALL := ordered(update_source,
                                    writeDeltasQA,
                                    writeDeltasProd,
                                    writeStats,
                                    output(dopsService, named('dops_service')),
                                    desprayDeltaUpdateQA,
                                    desprayDeltaUpdateProd,
                                    desprayDeltaStats,
                                    output(dopspath, named('path_location')),
                                  ):Success(Send_Email(pVersion, contacts).build_success), Failure(Send_Email(pVersion, contacts).build_failure);

    Return buildAll;
    
End;