import Doxie,suppress, data_services;

// SetRequireLinkingId:=['SSN','DID','BDID','RDID'];
// ds := DATASET(data_services.foreign_prod+'thor_data400::base::new_suppression_file',Suppress.Layout_New_Suppression,THOR);
// export File_New_Suppression_FCRA := ds(Linking_ID not in Suppress.UNsuppress_DID(true));
export File_New_Suppression_FCRA := DATASET('~thor_data400::base::new_suppression_file_fcra', Suppress.Layout_New_Suppression,THOR);