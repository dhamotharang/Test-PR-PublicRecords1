Import history_analysis;

Export Files := module 
    Export Master_Build_Frequence_Report := Dataset('~thor_data400::in::master_build_frequency::20200221::dops_extract01', history_analysis.layouts.Layout_Master_Build, CSV(Heading(1)));

    Export Keysizedhistory_report := Dataset('~thor_data400::in::dops_keysizedhistory::20200220::dops_extract02', history_analysis.layouts.Layout_keysizehistory, CSV(Heading(1)));

    Export Orbit_buildinstance_report  := Dataset('~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', history_analysis.layouts.Layout_Orbit_Buildinstance, CSV(Heading(1)));
    
    Export History_Analysis_SF := Dataset('~thor_data400::history_analysis::base::counted_deltas', History_Analysis.Layouts.BaseRec, Thor, __Compressed__);
    
    Export Delta_Statistics := Dataset('~thor_data400::history_analysis::base::Delta_Statistics', History_Analysis.Layouts.StatisticsRec, Thor, __Compressed__);

End;