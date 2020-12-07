Import history_analysis;

Export Files(string pVersion, boolean pUseProd = False ) := Module 
    
    Export master_build_frequence_report := dataset(History_Analysis.Filenames(pVersion, pUseProd).MasterBuildTemplate, history_analysis.layouts.Layout_Master_Build, csv(heading(1)));

    Export keysizedhistory_report := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsInputTemplate, history_analysis.layouts.layout_keysizedhistory, csv(heading(1)));

    Export keysizedhistory_service := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsServiceData, history_analysis.layouts.Layout_dopsservice, thor);

    Export keysizedhistory_rawdata := dataset(History_Analysis.Filenames(pVersion, pUseProd).DopsInputRawdata, history_analysis.layouts.Layout_dopsservice, thor );

    Export orbit_buildinstance_report  := dataset(History_Analysis.Filenames(pVersion, pUseProd).OrbitinputTemplate, history_analysis.layouts.Layout_Orbit_Buildinstance, csv(heading(1)));
    
    Export counted_deltas := dataset(History_Analysis.Filenames(pVersion, pUseProd).BaseDeltas, History_Analysis.Layouts.BaseRec, thor, __compressed__);
    
    Export delta_statistics := Dataset(History_Analysis.Filenames(pVersion, pUseProd).BaseStatistics, History_Analysis.Layouts.StatisticsRec, thor, __compressed__);

End;