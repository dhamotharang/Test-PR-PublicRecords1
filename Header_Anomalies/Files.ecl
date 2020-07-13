Import Data_Services;
Import dx_Header;
Import Watchdog;


Export Files := Module

    
    Export Header := Dataset(Data_services.foreign_prod + 'thor_data400::base::header_raw::latest_built', dx_header.layout_header, Thor): Independent;
    // For testing purposes you can use this version to limit the amount of records
    //Export Header := Choosen(hdr, 100000); // Temporary for testing

    Export Watchdog := Dataset(Data_Services.foreign_prod + 'thor_data400::BASE::Watchdog_Best', Watchdog.Layout_Best, Thor): Independent;
    // For testing purposes you can use this version to limit the amount of records
    //Export Watchdog := Choosen(Wd, 100000); // Temporary for testing 
    
End;

