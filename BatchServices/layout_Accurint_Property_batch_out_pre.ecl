Import FFD;
EXPORT layout_Accurint_Property_batch_out_pre := record
	layout_Accurint_Property_batch_out;
	dataset (FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
end;