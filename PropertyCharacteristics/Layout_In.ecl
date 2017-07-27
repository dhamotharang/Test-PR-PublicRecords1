import	AID;

export	Layout_In	:=
module

	export	MLS1	:=
	record,maxlength(12288)
		string	MLS;
		string	ZipCode;
		string	Price;
		string	State;
		string	City;
		string	Address;
		string	Address2;
		string	PropertyType;
		string	Rental;
		string	YearBuilt;
		string	NumBeds;
		string	NumBaths;
		string	SqFootage;
		string	Acre;
		string	NumUnits;
		string	Status;
		string	Area;
		string	County;
		string	LowListPrice;
		string	HighListPrice;
		string	CoolingFeatures;
		string	HeatingFeatures;
		string	InteriorFeatures;
		string	ExteriorFeatures;
		string	ExteriorConstruction;
		string	ExteriorFinish;
		string	Siding;
		string	Roofing;
		string	SchoolDistrict;
		string	NumStories;
		string	ParkingFeatures;
		string	Carport;
		string	Basement;
		string	FireplaceFeatures;
		string	Stylies;
		string	ParkingFeatures1;
		string	Carport1;
		string	Basement1;
		string	FireplaceFeatures1;
		string	Style;
		string	PoolFeatures;
		string	View;
		string	Description;
		string	FeaturesDump;
	end;
	
	export	MLS1_Prepped	:=
	record(MLS1),maxlength(12288)
		string14				BBPropertyID;
		string8					ProcessDate;
		string5					VendorSource;
		string100				PreppedLogicalName;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;
	
	export	MLS2	:=
	record,maxlength(12288)
		string	MLS;
		string	ZipCode;
		string	Price;
		string	State;
		string	City;
		string	Address;
		string	Address2;
		string	PropertyType;
		string	Rental;
		string	YearBuilt;
		string	NumBeds;
		string	NumBaths;
		string	SqFootage;
		string	Acre;
		string	NumUnits;
		string	Status;
		string	Area;
		string	County;
		string	LowListPrice;
		string	HighListPrice;
		string	CoolingFeatures;
		string	HeatingFeatures;
		string	InteriorFeatures;
		string	ExteriorFeatures;
		string	ExteriorConstruction;
		string	ExteriorFinish;
		string	Siding;
		string	Roofing;
		string	SchoolDistrict;
		string	NumStories;
		string	ParkingFeatures;
		string	Carport;
		string	Basement;
		string	FireplaceFeatures;
		string	Stylies;
		string	ParkingFeatures1;
		string	Carport1;
		string	Basement1;
		string	FireplaceFeatures1;
		string	Style;
		string	PoolFeatures;
		string	View;
		string	Description;
		string	FeaturesDump;
	end;
	
	export	MLS2_Prepped	:=
	record(MLS2),maxlength(12288)
		string14				BBPropertyID;
		string8					ProcessDate;
		string5					VendorSource;
		string100				PreppedLogicalName;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;
	
	export	MLS3	:=
	record,maxlength(12288)
		string	MLSBOARDID;
		string	PROPERTYID;
		string	LISTINGDATE;
		string	PROPSTATUSID;
		string	PROPCLASSID;
		string	PROPTYPEID;
		string	STREETNUMBER;
		string	STREETNAME;
		string	CITY;
		string	STATE;
		string	ZIP;
		string	COUNTYNAME;
		string	COUNTRY;
		string	ORIGINALADDRESS;
		string	ORIGINALCITY;
		string	ORIGINALSTATE;
		string	ORIGINALZIP;
		string	SUBDIVISIONNAME;
		string	MAPCODE;
		string	MLSAREA;
		string	LISTPRICE;
		string	LISTOFFICEID;
		string	LISTAGENTID;
		string	OFFMARKETDATE;
		string	STATUSDATE;
		string	ACRES;
		string	LOTSIZE;
		string	FOUNDATIONSIZE;
		string	ZONING;
		string	REMARKS;
		string	SALEPRICE;
		string	SELLERAGENTCOMP;
		string	SOLDDATE;
		string	VIRTUALTOURURL;
		string	BEDROOMS;
		string	TOTALROOMS;
		string	FULLBATHS;
		string	HALFBATHS;
		string	THREEQTRBATHS;
		string	QTRBATHS;
		string	BATHSTOTAL;
		string	GROSSLIVINGAREA;
		string	STYLE;
		string	ELEMENTARYSCHOOL;
		string	MIDDLESCHOOL;
		string	HIGHSCHOOL;
		string	AMENITIES;
		string	APPLIANCES;
		string	ASSCFEEINCLUDES;
		string	ASSESSEDVALUE;
		string	BASEMENT;
		string	BASEMENTFEATURE;
		string	BEACH;
		string	BUYERSAGENTCOMP;
		string	CONDOMINIUMNAME;
		string	CONDOASSOC;
		string	COOLING;
		string	SELLERDISCLOSURE;
		string	FIREPLACES;
		string	FOUNDATIONTYPE;
		string	FRONTAGE;
		string	GARAGEDESC;
		string	GARAGECAPACITY;
		string	HEATING;
		string	IMPROVEMENTS;
		string	LANDDESC;
		string	LEVELS;
		string	LISTINGAGREEMENT;
		string	LOTDESCRIPTION;
		string	MANAGEMENT;
		string	STATUSDESC;
		string	DAYSONMARKET;
		string	MASTERBATH;
		string	LIVINGLEVELS;
		string	LOTS;
		string	OPTFEE;
		string	OPTFEEINCLUDES;
		string	PARKINGFEATURE;
		string	PARKINGSPACES;
		string	MANDHOMEOWNERASSOC;
		string	RESTRICTIONS;
		string	SEWER;
		string	SEWERWATER;
		string	TAXES;
		string	TERMSFEATURE;
		string	MULTIFAMILYROOMSTOTAL;
		string	UFFI;
		string	UNITSINCOMPLEX;
		string	UNITNOBUILDNO;
		string	UNITLEVEL;
		string	UNITPLACEMENT;
		string	UPDATEDATE;
		string	WATERFRONT;
		string	WATERDESC;
		string	YEARBUILT;
		string	YEARCONVERTED;
		string	SOURCE;
		string	SCHOOLDISTRICT;
		string	IMAGEID;
		string	OWNTYPE;
		string	LISTTYPE;
		string	PROPTYPE;
		string	PRICERANGEDESC;
		string	LISTINGURL;
		string	TAXID;
		string	TAXAMOUNT;
		string	TAXYEAR;
		string	LANDVALUE;
		string	CENSUS;
		string	LEGALDESC;
		string	LOTNO;
		string	TOPOGRAPHY;
		string	GOLFCOURSEYN;
		string	GOLFCOURSEDESC;
		string	OTHERUTILITY;
		string	CABLEYN;
		string	VIEW;
		string	BOATYN;
		string	BOATDESC;
		string	HORSEYN;
		string	HORSEDESC;
		string	TENNISYN;
		string	TENNISDESC;
		string	FENCEYN;
		string	FENCEDESC;
		string	ALLEYYN;
		string	SIDEWALKSYN;
		string	CURBSYN;
		string	STREETPAVEDYN;
		string	STREETUNPAVEDYN;
		string	EASEMENTYN;
		string	EASEMENTDESC;
		string	ARCHSTYLE;
		string	NEWCONSTRYN;
		string	FIRSTFLOORSQFT;
		string	SECONDFLOORSQFT;
		string	HEATYN;
		string	HEATDESC;
		string	COOLYN;
		string	COOLDESC;
		string	ROOFDESC;
		string	MAINBEDDIM;
		string	BED2DIM;
		string	BED3DIM;
		string	BED4DIM;
		string	BED5DIM;
		string	BED6DIM;
		string	BED7DIM;
		string	LIVINGDIM;
		string	FAMILYDIM;
		string	DININGDIM;
		string	KITCHENDIM;
		string	GREATDIM;
		string	BREAKDIM;
		string	FLORIDADIM;
		string	INTERIORCONSTRUCTIONDESC;
		string	HANDICAPYN;
		string	FIREALARMYN;
		string	SECURITYYN;
		string	SECURITYDESC;
		string	PETSYN;
		string	PETRESTRICTIONS;
		string	FLOORDESC;
		string	FIRSTFLOORDESC;
		string	SECONDFLOORDESC;
		string	KITCHENFLOORDESC;
		string	DISHWASHERYN;
		string	WASHERDRYERYN;
		string	REFRIGYN;
		string	MICROWAVEYN;
		string	RANGEOVENYN;
		string	DISPOSALYN;
		string	CENTRALVACYN;
		string	TRASHCOMPYN;
		string	WASHERYN;
		string	DRYERYN;
		string	POOLYN;
		string	POOLDESC;
		string	PATIOYN;
		string	PATIODESC;
		string	COMPLEXNAME;
		string	COMMGATEDYN;
		string	CLUBHOUSEYN;
		string	COMMPOOLYN;
		string	COMMTENNISYN;
		string	COMMGOLFYN;
		string	COMMLAUNDRYYN;
		string	COMMHORSEYN;
		string	COMMGYMYN;
		string	COMMSAUNAYN;
		string	COMMSPAYN;
		string	COMMPLAYGROUNDYN;
		string	OWNERCARRYYN;
		string	ASSUMABLEYN;
		string	PHOTOCOUNT;
		string	LATITUDE;
		string	LONGITUDE;
		string	DIRECTIONS;
		string	AcreageYN;
		string	AnnualExpenses;
		string	AnnualFuelCost;
		string	AssmentRatio;
		string	AssumptionFee;
		string	BasementYN;
		string	BuilderName;
		string	Bldg2Dim;
		string	BuildingNo;
		string	BusinessName;
		string	CeilingHgt;
		string	CeilingInsulation;
		string	ColumnSpan;
		string	CombinedIncome;
		string	Construction;
		string	CorporateLimits;
		string	DoorHgt;
		string	FeatureCodeList;
		string	GrossIncome;
		string	GroundLevelUnit;
		string	ImprovementAssessment;
		string	LandAssessment;
		string	LandSqFt;
		string	LeasePrPerSqFt;
		string	LeasePurchaseOpt;
		string	LeaseType;
		string	MillageRate;
		string	MoPmtIncludes;
		string	NearCrossStreet;
		string	NetIncome;
		string	NetOperatingInc;
		string	NoDocks;
		string	NoDriveInDoors;
		string	Office1Size;
		string	Office2Size;
		string	Office3Size;
		string	Office4Size;
		string	ParkingGarageYN;
		string	PavedParkDim;
		string	PaymentType;
		string	PricePerAcre;
		string	PricePerSqFt;
		string	SpecialAssment;
		string	SqFtTotal;
		string	SubjTaxRollback;
		string	TotBuildings;
		string	WallInsulation;
		string	RentalPrice;
	end;
	
	export	MLS3_Prepped	:=
	record(MLS3),maxlength(12288)
		string14				BBPropertyID;
		string8					ProcessDate;
		string5					VendorSource;
		string100				PreppedLogicalName;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;
	
	export	MLS4	:=
	record,maxlength(12288)
		string	MLS;
		string	ZipCode;
		string	Price;
		string	State;
		string	City;
		string	Address;
		string	Address2;
		string	PropertyType;
		string	Rental;
		string	YearBuilt;
		string	NumBeds;
		string	NumBaths;
		string	SqFootage;
		string	Acre;
		string	NumUnits;
		string	Status;
		string	Area;
		string	County;
		string	LowListPrice;
		string	HighListPrice;
		string	CoolingFeatures;
		string	HeatingFeatures;
		string	InteriorFeatures;
		string	ExteriorFeatures;
		string	ExteriorConstruction;
		string	ExteriorFinish;
		string	Siding;
		string	Roofing;
		string	SchoolDistrict;
		string	NumStories;
		string	ParkingFeatures;
		string	Carport;
		string	Garage;
		string	Zoning;
		string	UtilitiesPresent;
		string	TotalFullBaths;
		string	Basement;
		string	FireplaceFeatures;
		string	Stylies;
		string	ParkingFeatures1;
		string	Basement1;
		string	FireplaceFeatures1;
		string	Style;
		string	PoolFeatures;
		string	Inclusions;
	end;
	
	export	MLS4_Prepped	:=
	record(MLS4),maxlength(12288)
		string14				BBPropertyID;
		string8					ProcessDate;
		string5					VendorSource;
		string100				PreppedLogicalName;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;
	
	export	BB_Extract	:=
	record
		string	PolicyID;
		string	StreetName;
		string	City;
		string	State;
		string	PostalCode;
		string	County;
		string	FipsCode;
		string	CensusTract;
		string	AttrSubtradeID;
		string	Description;
		string	Value;
		string	TradeID;
	end;
	
	export	StructureDetail	:=
	record,maxlength(1000)
		unsigned8	PolicyID;
		PropertyCharacteristics.Layout_Codes.TradeMaterials;
	end;
	
	export	BlueBook	:=
	record,maxlength(12288)
		unsigned8	PolicyID;
		string100	StreetName;
		string40	City;
		string2		State;
		string10	PostalCode;
		string50	County;
		string5		FipsCode;
		string10	CensusTract;
		string3		ResidenceType;
		string20	Stories;
		string8		LivingArea;
		string5		Bedrooms;
		string5		TotalRooms;
		string8		Baths;
		string5		Fireplaces;
		string1		Pool;
		string1		AC;
		string4		YearBuilt;
		string1		Condition;
		string20	LotArea;
		dataset(StructureDetail)	IBCodes	{maxcount(PropertyCharacteristics.Constants.MAX_COUNT_PROP_CHAR)};
	end;
	
	export	BlueBook_Prepped	:=
	record(BlueBook),maxlength(12288)
		string14				BBPropertyID;
		string8					ProcessDate;
		string5					VendorSource;
		string100				PreppedLogicalName;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;

	export	BB_RawAddress_Slim	:=
	record
		string14				BBPropertyID;
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	end;

end;