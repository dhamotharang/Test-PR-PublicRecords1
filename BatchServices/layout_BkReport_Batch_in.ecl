IMPORT BankruptcyV3_Services;

EXPORT layout_BkReport_Batch_in  := RECORD
	BankruptcyV3_Services.layouts.layout_tmsid_ext;
	STRING5 	court 		:= '';
	STRING24	case_number := '';	
END;