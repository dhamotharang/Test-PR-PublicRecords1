import doxie, FFD, BankruptcyV3_Services;
export Layout_BK_child_ext := record(doxie.layout_bk_child)
	BankruptcyV3_Services.layouts.withdrawn_status_rec WithdrawnStatus;
	FFD.Layouts.CommonRawRecordElements;
end;