Import history_analysis;

Export Files(string pVersion, boolean pUseProd = False ) := Module 
    
    ///////////////////////////////////////////////// primary inputs/ raw data /////////////////////////////////////////
    // other builds for future considerations
    Export master_build_frequence_report := dataset(History_Analysis.Filenames(pVersion, pUseProd).MasterBuildTemplate, history_analysis.layouts.Layout_Master_Build, csv(heading(1)));
    Export orbit_buildinstance_report  := dataset(History_Analysis.Filenames(pVersion, pUseProd).OrbitinputTemplate, history_analysis.layouts.Layout_Orbit_Buildinstance, csv(heading(1)));
    
    Export keysizedhistory_report := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsInputTemplate, history_analysis.layouts.layout_keysizedhistory, csv(heading(1)));
    Export keysizedhistory_service := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsServiceData, history_analysis.layouts.Layout_dopsservice, csv(heading(single),separator(','),quote('"')), __compressed__ );
    Export keysizedhistory_rawdata := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsInputRawdata, history_analysis.layouts.Layout_dopsservice, csv(heading(single),separator(','),quote('"')), __compressed__  );
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////// processed inputs including statistics////////////////////////////
    Export counted_deltasQA := dataset(History_Analysis.Filenames(pVersion, pUseProd).baseDeltasQA, History_Analysis.Layouts.BaseRecQA, csv(heading(single),separator(','),quote('"')), __compressed__ );
    Export counted_deltasProd := dataset(History_Analysis.Filenames(pVersion, pUseProd).baseDeltasProd, History_Analysis.Layouts.BaseRecprod, csv(heading(single),separator(','),quote('"')), __compressed__ );
    Export delta_statistics := dataset(History_Analysis.Filenames(pVersion, pUseProd).BaseStatistics, History_Analysis.Layouts.StatisticsRec, csv(heading(single),separator(','),quote('"')), __compressed__ );

    ///////////////////////////////////////////////////// for standalone reports ///////////////////////////////////////
    Export standaloneDeltas := dataset(History_Analysis.Filenames(pVersion, pUseProd).standaloneDeltas, History_Analysis.Layouts.BaseRecprod, csv(heading(single),separator(','),quote('"')), __compressed__ );
    Export standaloneStats := dataset(History_Analysis.Filenames(pVersion, pUseProd).standaloneStats, History_Analysis.Layouts.StatisticsRec, csv(heading(single),separator(','),quote('"')), __compressed__ );

    
End;