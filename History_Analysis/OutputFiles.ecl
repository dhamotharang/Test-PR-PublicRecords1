  
Import History_Analysis;
Export OutputFiles( string pVersion ) := Module

    Export dopsService := output(History_Analysis.Files(pVersion).keysizedhistory_service, all, named('dops_service'));


    Export raw_data := output(History_Analysis.Files(pVersion).keysizedhistory_rawdata, all, named('raw_data'));
    Export counted_deltas := output(History_Analysis.Files(pVersion).counted_deltas,, all, named('counted_deltas'));
    Export deltas_statistics := output(History_Analysis.Files(pVersion).delta_statistics, all, named('delta_statistics'));
    
    Export standaloneDeltas := output(History_Analysis.Files(pVersion).standaloneDeltas, all, named('updated_delta_report'));
    Export standaloneStats := output(History_Analysis.Files(pVersion).standaloneStats, all, named('updated_delta_statistics'));

End;