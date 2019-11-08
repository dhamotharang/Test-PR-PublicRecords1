//Watchdog_V2.IDX_UniversalKey_File
IMPORT dx_BestRecords,data_services,doxie;

EXPORT IDX_UniversalKey_File := MODULE

EXPORT Layout := RECORD
dx_BestRecords.layout_watchdog_merged;
END;

SHARED FileName  := Data_Services.Data_Location.Watchdog_Best +'thor_data400::key::watchdog_' + doxie.Version_SuperKey;

EXPORT File      := DATASET(FileName,Layout, FLAT);
EXPORT IndexFile := INDEX({Layout.did}, {Layout-did}, FileName);

END;