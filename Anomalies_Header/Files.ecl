Import Anomalies_Header;
Import Data_Services;
Import dx_Header;
Import History_Analysis;
Import Watchdog;


Export Files := Module

    Hdr := Dataset(Data_services.foreign_prod + 'thor_data400::base::header_raw::latest_built', dx_header.layout_header, Thor): Independent;
    Export Header := Choosen(hdr, 1000000); // Temporary 

    Wd := Dataset(Data_Services.foreign_prod + 'thor_data400::BASE::Watchdog_Best', Watchdog.Layout_Best, Thor): Independent;
    Export Watchdog := Choosen(Wd, 1000000); // Temporary 
    
End;

