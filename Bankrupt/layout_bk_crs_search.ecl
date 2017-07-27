import bankrupt, ffd, BankruptcyV3_Services;

EXPORT layout_bk_crs_search := record(bankrupt.layout_bk_search)
	BankruptcyV3_Services.layouts.withdrawn_status_rec WithdrawnStatus;
	FFD.Layouts.CommonRawRecordElements;
END;