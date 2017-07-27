/* For FCRA FFD batch service */

IMPORT FFD;

EXPORT layout_BankruptcyV3_Batch_FCRA := MODULE
   EXPORT out_pre := record(BatchServices.layout_BankruptcyV3_Batch_out)
	        DATASET (FFD.Layouts.ConsumerStatementBatch) statements;
   END;
	 

END;