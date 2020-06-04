IMPORT CrashCarrier, data_services;

EXPORT In_CrashCarrier := CrashCarrier.Files().Input.Using;

// EXPORT In_CrashCarrier := dataset(data_services.foreign_prod + 'thor_data400::in::crashcarrier::20200403::data', 
																	// CrashCarrier.layouts.Input.Sprayed, csv(separator('\t'),heading(1),terminator(['\n','\r\n'])));	