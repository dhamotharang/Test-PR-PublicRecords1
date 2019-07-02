IMPORT dx_BestRecords,data_services,doxie;

EXPORT IDX_UniversalKey_File := MODULE

EXPORT Layout := RECORD
dx_BestRecords.layout_watchdog_merged;
END;

// SHARED FileName  := data_services.foreign_prod+'thor_data400::key::watchdog_' + doxie.Version_SuperKey;
SHARED FileName  := data_services.foreign_prod+'thor_data400::key::watchdog::20190701test::univesal';

EXPORT File      := DATASET(FileName,Layout, FLAT);
EXPORT IndexFile := INDEX({Layout.did}, {Layout-did}, FileName);

END;