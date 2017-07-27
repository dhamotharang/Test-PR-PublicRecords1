IMPORT doxie, Data_Services;

InpFile := InstantID_Archiving.Files_Base.Delta +  InstantID_Archiving.Files_Base_Batch.key_files;

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID));

SrtFile := SORT(DstFile, transaction_ID, product, date_added, LOCAL);

DdpFile := DEDUP(SrtFile, transaction_ID, product, date_added, LOCAL);

EXPORT Key_Payload := INDEX(DdpFile, {transaction_id, product, country}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::Payload',opt);