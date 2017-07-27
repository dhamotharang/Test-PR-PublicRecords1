export Layout_Search := RECORD
	string11   Taxpayer_Number;
	boolean isDeepDive;
	unsigned2 penalt;
	TxBusV2_Services.Layout_taxpayer;
	dataset(Layout_Outlet) Outlet {maxcount(25)};
END;
	