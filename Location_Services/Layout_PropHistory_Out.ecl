// Structure for the output result
IMPORT LN_Property, LN_Mortgage, doxie, risk_indicators,AVM_v2;


SummaryData := record
	integer2	TotalDeedTransfers;
	unsigned4	TotalDeedTransferPeriod; // months
	boolean	VacantLot;
	unsigned4	LastDeedTransfer;  // days since
	unsigned4	PeriodSinceOwnerVacatedProperty; // ?
	unsigned4	LastSaleDate;
	dataset({string64 warning}) warnings	{ maxcount(consts.max_warnings) };
end;

export Layout_PropHistory_Out := record
	Layout_PropHistory_In		ReqData;
	layout_address				address;
	avm_v2.layouts.layout_value_fields property_value;
	DATASET(Risk_Indicators.Layout_Desc) HRI_Address					{ maxcount(consts.max_hri_addr) };
	layout_address				mailing_address;
	dataset(Risk_indicators.layout_desc) HRI_Mailing_Address	{ maxcount(consts.max_hri_addr) };
	layout_Assessment_Data		CurrentAssessment;
	SummaryData				DeedSummary;
	DATASET(Layout_persondata)			Owners {maxcount(10)};
	DATASET(Layout_PropertyTransaction)  Transactions {maxcount(consts.max_transact)};
	DATASET(layout_Resident) 	Current_Residents {maxcount(10)};
	boolean					Incomplete_Addr := false;
end;