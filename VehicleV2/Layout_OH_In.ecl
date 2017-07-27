//---------------------------------------------------------
//-----------OH INPUT FORMAT LAYOUT
//---------------------------------------------------------
EXPORT Layout_OH_In := RECORD
STRING2 	CategoryCode;
STRING20 	VIN;
STRING4 	ModelYr;
STRING20 	TitleNum;
STRING1 	OwnerCode;
STRING6 	GrossWeight;
STRING35 	OwnerName;
STRING30 	OwnerStreetAddress;
STRING15 	OwnerCity;
STRING2 	OwnerState;
STRING9 	OwnerZip;
STRING2 	CountyNumber;
STRING8 	VehiclePurchaseDt;
STRING6 	VehicleTaxWeight;
STRING1 	VehicleTaxCode;
STRING6 	VehicleUnladdenWeight;
STRING35 	AdditionalOwnerName;
STRING8 	RegistrationIssueDt;
STRING4 	VehicleMake;
STRING2 	VehicleType;
STRING8 	VehicleExpDt;
STRING8 	PreviousPlateNum;
STRING8 	PlateNum;
STRING2		EOL;
END;
