import Autokey_batch;

export Layout_MLPL_Combined_Input := record
  Autokey_batch.Layouts.rec_inBatchMaster; // standard batch input layout
  string20 license_number := ''; // used on Medlic_Batch_Service input
  string2 license_state := ''; // used on Medlic_Batch_Service input
	string10 TaxID := '';          // used on Medlic_Batch_Service input
	string20 UPIN := '';	         // used on Medlic_Batch_Service input
	string10 npi;                  // used on PL_Batch_Service input
end;