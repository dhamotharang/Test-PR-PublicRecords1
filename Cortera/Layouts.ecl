import corp2, aid;

EXPORT Layouts	:=	MODULE

Export Input		:= module

Export AttrLayout	:=	record
	unsigned4	UltimateLinkid;
	unsigned4	CorteraScore;
	unsigned4	CPRScore;
	unsigned4	CPRSegment;
	unsigned4	DBT;
	unsigned4	AvgBal;
	unsigned4	AirSpend;
	unsigned4	FuelSpend;
	unsigned4	LeasingSpend;
	unsigned4	LTLSpend;
	unsigned4	RailSpend;
	unsigned4	TLSpend;
	unsigned4	TranSvcSpend;
	unsigned4	TranSupSpend;
	unsigned4	BSTSpend;
	unsigned4	DGSpend;
	unsigned4	ElectricalSpend;
	unsigned4	HVACSpend;
	unsigned4	OtherBldgSpend;
	unsigned4	PlumbingSpend;
	unsigned4	RSSpend;
	unsigned4	WPSpend;
	unsigned4	ChemicalSpend;
	unsigned4	ElectronicSpend;
	unsigned4	MetalSpend;
	unsigned4	OtherMatlSpend;
	unsigned4	PackagingSpend;
	unsigned4	PVFSpend;
	unsigned4	PlasticSpend;
	unsigned4	TextileSpend;
	unsigned4	BSSpend;
	unsigned4	CESpend;
	unsigned4	HardwareSpend;
	unsigned4	IESpend;
	unsigned4	ISSpend;
	unsigned4	ITSpend;
	unsigned4	MLSSpend;
	unsigned4	OSSpend;
	unsigned4	PPSpend;
	unsigned4	SISSpend;
	unsigned4	ApparelSpend;
	unsigned4	BeveragesSpend;
	unsigned4	ConstrSpend;
	unsigned4	ConsultingSpend;
	unsigned4	FSSpend;
	unsigned4	FPSpend;
	unsigned4	InsuranceSpend;
	unsigned4	LSSpend;
	unsigned4	OilGasSpend;
	unsigned4	UtilitiesSpend;
	unsigned4	OtherSpend;
	unsigned4	AdvtSpend;
	unsigned4	AirGrowth;
	unsigned4	FuelGrowth;
	unsigned4	LeasingGrowth;
	unsigned4	LTLGrowth;
	unsigned4	RailGrowth;
	unsigned4	TLGrowth;
	unsigned4	TranSvcGrowth;
	unsigned4	TranSupGrowth;
	unsigned4	BSTGrowth;
	unsigned4	DGGrowth;
	unsigned4	ElectricalGrowth;
	unsigned4	HVACGrowth;
	unsigned4	OtherBldgGrowth;
	unsigned4	PlumbingGrowth;
	unsigned4	RSGrowth;
	unsigned4	WPGrowth;
	unsigned4	ChemicalGrowth;
	unsigned4	ElectronicGrowth;
	unsigned4	MetalGrowth;
	unsigned4	OtherMatlGrowth;
	unsigned4	PackagingGrowth;
	unsigned4	PVFGrowth;
	unsigned4	PlasticGrowth;
	unsigned4	TextileGrowth;
	unsigned4	BSGrowth;
	unsigned4	CEGrowth;
	unsigned4	HardwareGrowth;
	unsigned4	IEGrowth;
	unsigned4	ISGrowth;
	unsigned4	ITGrowth;
	unsigned4	MLSGrowth;
	unsigned4	OSGrowth;
	unsigned4	PPGrowth;
	unsigned4	SISGrowth;
	unsigned4	ApparelGrowth;
	unsigned4	BeveragesGrowth;
	unsigned4	ConstrGrowth;
	unsigned4	ConsultingGrowth;
	unsigned4	FSGrowth;
	unsigned4	FPGrowth;
	unsigned4	InsuranceGrowth;
	unsigned4	LSGrowth;
	unsigned4	OilGasGrowth;
	unsigned4	UtilitiesGrowth;
	unsigned4	OtherGrowth;
	unsigned4	AdvtGrowth;
	unsigned4	Top5Growth;
	unsigned4	ShippingY1;
	unsigned4	ShippingGrowth;
	unsigned4	MaterialsY1;
	unsigned4	MaterialsGrowth;
	unsigned4	OperationsY1;
	unsigned4	OperationsGrowth;
	unsigned4	TotalPaidAverage0T12;
	unsigned4	TotalPaidMonthsPastWorst24;
	unsigned4	TotalPaidSlope0T12;
	unsigned4	TotalPaidSlope0T6;
	unsigned4	TotalPaidSlope6T12;
	unsigned4	TotalPaidSlope6T18;
	unsigned4	TotalPaidVolatility0T12;
	unsigned4	TotalPaidVolatility0T6;
	unsigned4	TotalPaidVolatility12T18;
	unsigned4	TotalPaidVolatility6T12;
	unsigned4	TotalSpendMonthsPastLeast24;
	unsigned4	TotalSpendMonthsPastMost24;
	unsigned4	TotalSpendSlope0T12;
	unsigned4	TotalSpendSlope0T24;
	unsigned4	TotalSpendSlope0T6;
	unsigned4	TotalSpendSlope6T12;
	unsigned4	TotalSpendSum12;
	unsigned4	TotalSpendVolatility0T12;
	unsigned4	TotalSpendVolatility0T6;
	unsigned4	TotalSpendVolatility12T18;
	unsigned4	TotalSpendVolatility6T12;
	unsigned4	MfgMatPaidAverage12;
	unsigned4	MfgMatPaidMonthsPastWorst24;
	unsigned4	MfgMatPaidSlope0T12;
	unsigned4	MfgMatPaidSlope0T24;
	unsigned4	MfgMatPaidSlope0T6;
	unsigned4	MfgMatPaidVolatility0T12;
	unsigned4	MfgMatPaidVolatility0T6;
	unsigned4	MfgMatSpendMonthsPastLeast24;
	unsigned4	MfgMatSpendMonthsPastMost24;
	unsigned4	MfgMatSpendSlope0T12;
	unsigned4	MfgMatSpendSlope0T24;
	unsigned4	MfgMatSpendSlope0T6;
	unsigned4	MfgMatSpendSum12;
	unsigned4	MfgMatSpendVolatility0T6;
	unsigned4	MfgMatSpendVolatility6T12;
	unsigned4	OpsPaidAverage12;
	unsigned4	OpsPaidMonthsPastWorst24;
	unsigned4	OpsPaidSlope0T12;
	unsigned4	OpsPaidSlope0T24;
	unsigned4	OpsPaidSlope0T6;
	unsigned4	OpsPaidVolatility0T12;
	unsigned4	OpsPaidVolatility0T6;
	unsigned4	OpsSpendMonthsPastLeast24;
	unsigned4	OpsSpendMonthsPastMost24;
	unsigned4	OpsSpendSlope0T12;
	unsigned4	OpsSpendSlope0T24;
	unsigned4	OpsSpendSlope0T6;
	unsigned4	OpsSpendSum12;
	unsigned4	OpsSpendVolatility0T6;
	unsigned4	OpsSpendVolatility6T12;
	unsigned4	FleetPaidAverage12;
	unsigned4	FleetPaidMonthsPastWorst24;
	unsigned4	FleetPaidSlope0T12;
	unsigned4	FleetPaidSlope0T24;
	unsigned4	FleetPaidSlope0T6;
	unsigned4	FleetPaidVolatility0T12;
	unsigned4	FleetPaidVolatility0T6;
	unsigned4	FleetSpendMonthsPastLeast24;
	unsigned4	FleetSpendMonthsPastMost24;
	unsigned4	FleetSpendSlope0T12;
	unsigned4	FleetSpendSlope0T24;
	unsigned4	FleetSpendSlope0T6;
	unsigned4	FleetSpendSum12;
	unsigned4	FleetSpendVolatility0T6;
	unsigned4	FleetSpendVolatility6T12;
	unsigned4	CarrierPaidAverage12;
	unsigned4	CarrierPaidMonthsPastWorst24;
	unsigned4	CarrierPaidSlope0T12;
	unsigned4	CarrierPaidSlope0T24;
	unsigned4	CarrierPaidSlope0T6;
	unsigned4	CarrierPaidVolatility0T12;
	unsigned4	CarrierPaidVolatility0T6;
	unsigned4	CarrierSpendMonthsPastLeast24;
	unsigned4	CarrierSpendMonthsPastMost24;
	unsigned4	CarrierSpendSlope0T12;
	unsigned4	CarrierSpendSlope0T24;
	unsigned4	CarrierSpendSlope0T6;
	unsigned4	CarrierSpendSum12;
	unsigned4	CarrierSpendVolatility0T6;
	unsigned4	CarrierSpendVolatility6T12;
	unsigned4	BldgMatsPaidAverage12;
	unsigned4	BldgMatsPaidMonthsPastWorst24;
	unsigned4	BldgMatsPaidSlope0T12;
	unsigned4	BldgMatsPaidSlope0T24;
	unsigned4	BldgMatsPaidSlope0T6;
	unsigned4	BldgMatsPaidVolatility0T12;
	unsigned4	BldgMatsPaidVolatility0T6;
	unsigned4	BldgMatsSpendMonthsPastLeast24;
	unsigned4	BldgMatsSpendMonthsPastMost24;
	unsigned4	BldgMatsSpendSlope0T12;
	unsigned4	BldgMatsSpendSlope0T24;
	unsigned4	BldgMatsSpendSlope0T6;
	unsigned4	BldgMatsSpendSum12;
	unsigned4	BldgMatsSpendVolatility0T6;
	unsigned4	BldgMatsSpendVolatility6T12;
	unsigned4	Top5PaidAverage12;
	unsigned4	Top5PaidMonthsPastWorst24;
	unsigned4	Top5PaidSlope0T12;
	unsigned4	Top5PaidSlope0T24;
	unsigned4	Top5PaidSlope0T6;
	unsigned4	Top5PaidVolatility0T12;
	unsigned4	Top5PaidVolatility0T6;
	unsigned4	Top5SpendMonthsPastLeast24;
	unsigned4	Top5SpendMonthsPastMost24;
	unsigned4	Top5SpendSlope0T12;
	unsigned4	Top5SpendSlope0T24;
	unsigned4	Top5SpendSlope0T6;
	unsigned4	Top5SpendSum12;
	unsigned4	Top5SpendVolatility0T6;
	unsigned4	Top5SpendVolatility6T12;
	unsigned4	TotalNumrelAvg12;
	unsigned4	TotalNumrelMonthpsPastMost24;
	unsigned4	TotalNumrelMonthsPastLeast24;
	unsigned4	TotalNumrelSlope0T12;
	unsigned4	TotalNumrelSlope0T24;
	unsigned4	TotalNumrelSlope0T6;
	unsigned4	TotalNumrelSlope6T12;
	unsigned4	TotalNumrelVar0T12;
	unsigned4	TotalNumrelVar0T24;
	unsigned4	TotalNumrelVar12T24;
	unsigned4	TotalNumrelVar6T18;
	unsigned4	MfgMatNumrelAvg12;
	unsigned4	MfgMatNumrelSlope0T12;
	unsigned4	MfgMatNumrelSlope0T24;
	unsigned4	MfgMatNumrelSlope0T6;
	unsigned4	MfgMatNumrelSlope6T12;
	unsigned4	MfgMatNumrelVar0T12;
	unsigned4	MfgMatNumrelVar12T24;
	unsigned4	OpsNumrelAvg12;
	unsigned4	OpsNumrelSlope0T12;
	unsigned4	OpsNumrelSlope0T24;
	unsigned4	OpsNumrelSlope0T6;
	unsigned4	OpsNumrelSlope6T12;
	unsigned4	OpsNumrelVar0T12;
	unsigned4	OpsNumrelVar12T24;
	unsigned4	FleetNumrelAvg12;
	unsigned4	FleetNumrelSlope0T12;
	unsigned4	FleetNumrelSlope0T24;
	unsigned4	FleetNumrelSlope0T6;
	unsigned4	FleetNumrelSlope6T12;
	unsigned4	FleetNumrelVar0T12;
	unsigned4	FleetNumrelVar12T24;
	unsigned4	CarrierNumrelAvg12;
	unsigned4	CarrierNumrelSlope0T12;
	unsigned4	CarrierNumrelSlope0T24;
	unsigned4	CarrierNumrelSlope0T6;
	unsigned4	CarrierNumrelSlope6T12;
	unsigned4	CarrierNumrelVar0T12;
	unsigned4	CarrierNumrelVar12T24;
	unsigned4	BldgMatsNumrelAvg12;
	unsigned4	BldgMatsNumrelSlope0T12;
	unsigned4	BldgMatsNumrelSlope0T24;
	unsigned4	BldgMatsNumrelSlope0T6;
	unsigned4	BldgMatsNumrelSlope6T12;
	unsigned4	BldgMatsNumrelVar0T12;
	unsigned4	BldgMatsNumrelVar12T24;
	unsigned4	TotalMonthsOutstandingSlope24;
	unsigned4	TotalPercProv30Avg0T12;
	unsigned4	TotalPercProv30Slope0T12;
	unsigned4	TotalPercProv30Slope0T24;
	unsigned4	TotalPercProv30Slope0T6;
	unsigned4	TotalPercProv30Slope6T12;
	unsigned4	TotalPercProv60Avg0T12;
	unsigned4	TotalPercProv60Slope0T12;
	unsigned4	TotalPercProv60Slope0T24;
	unsigned4	TotalPercProv60Slope0T6;
	unsigned4	TotalPercProv60Slope6T12;
	unsigned4	TotalPercProv90Avg0T12;
	unsigned4	TotalPercProv90LowerLim0T12;
	unsigned4	TotalPercProv90Slope0T24;
	unsigned4	TotalPercProv90Slope0T6;
	unsigned4	TotalPercProv90Slope6T12;
	unsigned4	TotalPercProvOutstandingAdjustedSlope0T12;
	unsigned4	MfgMatMonthsOutstandingSlope24;
	unsigned4	MfgMatPercProv30Slope0T12;
	unsigned4	MfgMatPercProv30Slope6T12;
	unsigned4	MfgMatPercProv60Slope0T12;
	unsigned4	MfgMatPercProv60Slope6T12;
	unsigned4	MfgMatPercProv90Slope0T24;
	unsigned4	MfgMatPercProv90Slope0T6;
	unsigned4	MfgMatPercProv90Slope6T12;
	unsigned4	MfgMatPercProvOutstandingAdjustedSlope0T12;
	unsigned4	OpsMonthsOutstandingSlope24;
	unsigned4	OpsPercProv30Slope0T12;
	unsigned4	OpsPercProv30Slope6T12;
	unsigned4	OpsPercProv60Slope0T12;
	unsigned4	OpsPercProv60Slope6T12;
	unsigned4	OpsPercProv90Slope0T24;
	unsigned4	OpsPercProv90Slope0T6;
	unsigned4	OpsPercProv90Slope6T12;
	unsigned4	OpsPercProvOutstandingAdjustedSlope0T12;
	unsigned4	FleetMonthsOutstandingSlope24;
	unsigned4	FleetPercProv30Slope0T12;
	unsigned4	FleetPercProv30Slope6T12;
	unsigned4	FleetPercProv60Slope0T12;
	unsigned4	FleetPercProv60Slope6T12;
	unsigned4	FleetPercProv90Slope0T24;
	unsigned4	FleetPercProv90Slope0T6;
	unsigned4	FleetPercProv90Slope6T12;
	unsigned4	FleetPercProvOutstandingAdjustedSlope0T12;
	unsigned4	CarrierMonthsOutstandingSlope24;
	unsigned4	CarrierPercProv30Slope0T12;
	unsigned4	CarrierPercProv30Slope6T12;
	unsigned4	CarrierPercProv60Slope0T12;
	unsigned4	CarrierPercProv60Slope6T12;
	unsigned4	CarrierPercProv90Slope0T24;
	unsigned4	CarrierPercProv90Slope0T6;
	unsigned4	CarrierPercProv90Slope6T12;
	unsigned4	CarrierPercProvOutstandingAdjustedSlope0T12;
	unsigned4	BldgMatsMonthsOutstandingSlope24;
	unsigned4	BldgMatsPercProv30Slope0T12;
	unsigned4	BldgMatsPercProv30Slope6T12;
	unsigned4	BldgMatsPercProv60Slope0T12;
	unsigned4	BldgMatsPercProv60Slope6T12;
	unsigned4	BldgMatsPercProv90Slope0T24;
	unsigned4	BldgMatsPercProv90Slope0T6;
	unsigned4	BldgMatsPercProv90Slope6T12;
	unsigned4	BldgMatsPercProvOutstandingAdjustedSlope0T12;
	unsigned4	Top5MonthsOutstandingSlope24;
	unsigned4	Top5PercProv30Slope0T12;
	unsigned4	Top5PercProv30Slope6T12;
	unsigned4	Top5PercProv60Slope0T12;
	unsigned4	Top5PercProv60Slope6T12;
	unsigned4	Top5PercProv90Slope0T24;
	unsigned4	Top5PercProv90Slope0T6;
	unsigned4	Top5PercProv90Slope6T12;
	unsigned4	Top5PercProvOutstandingAdjustedSlope0T12;
end;

Export HdrLayout	:=	record
	unsigned4	LinkId;
	string100	Name;
	string100	AlternateBusinessName;
	string80	Address;
	string80	Address2;
	string80	City;
	string50	State;
	string2		Country;
	string20	Postalcode;
	string30	Phone;
	string30	Fax;
	string10	Latitude;
	string11	Longitude;
	string200	Url;
	string9		Fein;
	string1		PositionType;
	unsigned4	UltimateLinkid;
	string100	UltimateName;
	string8		LocDateLastSeen;
	string20	PrimarySic;
	string100	SicDesc;
	string20	PrimaryNaics;
	string200	NaicsDesc;
	unsigned4	SegmentId;
	string255	SegmentDesc;
	string4		YearStart;
	string1		Ownership;
	string10	TotalEmployees;
	string30	EmployeeRange;
	string15	TotalSales;
	string50	SalesRange;
	string250	ExecutiveName1;
	string250	Title1;
	string250	ExecutiveName2;
	string250	Title2;
	string250	ExecutiveName3;
	string250	Title3;
	string250	ExecutiveName4;
	string250	Title4;
	string250	ExecutiveName5;
	string250	Title5;
	string250	ExecutiveName6;
	string250	Title6;
	string250	ExecutiveName7;
	string250	Title7;
	string250	ExecutiveName8;
	string250	Title8;
	string250	ExecutiveName9;
	string250	Title9;
	string250	ExecutiveName10;
	string250	Title10;
	string1		Status;
	string1		IsClosed;
	string8		ClosedDate;
end;

end;

end;
