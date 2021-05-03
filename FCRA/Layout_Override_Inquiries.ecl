import Inquiry_AccLogs;

export Layout_Override_Inquiries := record
	Inquiry_AccLogs.Layout.Layout_inquiry_disclosure;
	//CCPA-1048 - Add CCPA new fields
	Inquiry_AccLogs.Layout.ccpaLayout;
	STRING20 flag_file_id;
end;