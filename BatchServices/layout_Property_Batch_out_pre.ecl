Import FFD;
EXPORT layout_Property_Batch_out_pre := RECORD
		BatchServices.layout_Property_Batch_out;
		dataset (FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
END;