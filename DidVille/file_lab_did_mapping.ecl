import data_services;

// DID = 1791860725, MICKEY MOUSE, 111 DISNEY LN, ORLANDO FL 11111, 19111100
dummy := dataset([{999999999, 1791860725, 'DUMMY', 'Y', 100}], layout_lab_did_mapping);

EXPORT file_lab_did_mapping := dataset( data_services.Data_Location.Relatives + 'thor_data400::base::lab::did_mapping',layout_lab_did_mapping,flat,opt) + dummy;
