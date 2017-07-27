IMPORT Autokey_batch;

export layout_BankruptcyV3_Batch_in := record
	Autokey_batch.Layouts.rec_inBatchMaster;
	UNSIGNED6 DotID := 0;
	UNSIGNED6 EmpID := 0;
	UNSIGNED6 POWID := 0;
	UNSIGNED6 ProxID := 0;
	UNSIGNED6 SELEID := 0; 
	UNSIGNED6 OrgID := 0;
	UNSIGNED6 UltID := 0;
end;