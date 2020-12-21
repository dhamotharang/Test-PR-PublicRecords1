  
Import History_Analysis;

Export OutputFiles( string pVersion ) := Module

    Export dopsService := output(History_Analysis.Files(pVersion).keysizedhistory_service, named('dops_service'));


    Export raw_data := output(History_Analysis.Files(pVersion).keysizedhistory_rawdata, named('raw_data'));
    Export counted_deltas := output(History_Analysis.Files(pVersion).counted_deltas, named('counted_deltas'));
    Export deltas_statistics := output(History_Analysis.Files(pVersion).delta_statistics, named('delta_statistics'));
    
    Export standaloneDeltas := output(History_Analysis.Files(pVersion).standaloneDeltas, named('updated_delta_report'));
    Export standaloneStats := output(History_Analysis.Files(pVersion).standaloneStats, named('updated_delta_statistics'));

End;