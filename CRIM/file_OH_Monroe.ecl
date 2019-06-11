IMPORT crim, data_services;

EXPORT file_OH_Monroe := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_Monroe',crim.layout_OH_monroe.raw_in,csv(separator('|'), heading(single)));