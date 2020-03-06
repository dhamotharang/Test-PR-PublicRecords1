Import history_analysis;

Export Files := module 
    Export Master_Build_Frequence_Report := Dataset('~thor_data400::in::master_build_frequency::20200221::dops_extract01', history_analysis.layouts.Layout_Master_Build, CSV(Heading(1)));

    Export Keysizedhistory_report := Dataset('~thor_data400::in::dops_keysizedhistory::20200220::dops_extract02', history_analysis.layouts.Layout_keysizehistory, CSV(Heading(1)));

    Export Orbit_buildinstance  := Dataset('~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', history_analysis.layouts.Layout_Orbit_Buildinstance, CSV(Heading(1)));
End;