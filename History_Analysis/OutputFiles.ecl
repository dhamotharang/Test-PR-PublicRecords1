  
Import History_Analysis;

Export OutputFiles( string pVersion ) := Module
    
    counted_deltas := output(History_Analysis.Files(pVersion).counted_deltas, named('counted_deltas'));
    deltas_statistics := output(History_Analysis.Files(pVersion).delta_statistics, named('delta_statistics'));
    
    standaloneDeltas := output(History_Analysis.Files(pVersion).standaloneDeltas, named('updated_delta_report'));
    standaloneStats := output(History_Analysis.Files(pVersion).standaloneStats, Named('updated_delta_statistics'));

End;