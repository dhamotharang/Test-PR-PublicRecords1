IMPORT insurance;
EXPORT Layout := MODULE
EXPORT CONTRACTOR := RECORD
	STRING255  	ID;
	UNSIGNED4		RECNUM;
	STRING255		FULLNAME;
	STRING255 	CompanyName;
	STRING255 	CompanyDesc;
	STRING20		PHONE;
	STRING100		RADDRESS1;
	STRING80		RADDRESS2;
	STRING80		RCITY;
	STRING50		RSTATE;
	STRING25		RZIP;

	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	STRING255		EMAIL;
	STRING255		TRADE;
	STRING1000	EXTRAFIELDS;// ?? SIZE
END;

EXPORT CORRECTION := RECORD
	STRING255  	ID;
	STRING255		PROPERTYID;
	UNSIGNED4		RECNUM;
	STRING255		PROPERTYRECNUM;
	STRING255		CORRECTEDADDRESS1;
	STRING255		CORRECTEDADDRESS2;
	STRING80		CORRECTEDCITY;
	STRING50		CORRECTEDSTATE;
	STRING25		CORRECTEDZIP;
	UNSIGNED4		CAPASSNUMBER;
	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	DECIMAL15_10	LATITUDE;
	DECIMAL15_10	LONGITUDE;
END;

EXPORT INSPECTION := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	UNSIGNED4		RECNUM;
	STRING255		PermitRecNum;
	STRING255		InspType;
	STRING255		Description;
	STRING255		SpecialInstructions;
	STRING3			Final;
	STRING10		RequestDate;
	STRING10		RequestTime;
	STRING10		DesiredDate;
	STRING10		DesiredTime;
	STRING10		ScheduledDate;
	STRING10		ScheduledTime;
	STRING10		InspectedDate;
	STRING10		InspectedTime;
	STRING255		Result;
	STRING3			ReInspection;
	STRING1000	InspectionNotes;
	STRING40		Inspector;
	STRING1000	ExtraFields;
END;
EXPORT PERMIT := RECORD
	STRING255  	ID;
	STRING255		PropertyID;
	UNSIGNED4		RECNUM;
	UNSIGNED4		PropertyRecNum;
	STRING50		Jurisdiction;
	STRING255		PermitNum;
	STRING255		PermitClass;
	STRING255		MasterPermitNum;
	STRING100		WorkClass;
	STRING255		ProposedUse;
	STRING255		PermitStatus;
	STRING10		PreferredDate;
	STRING10		AppliedDate;
	STRING10		IssuedDate;
	STRING10		ExpiresDate;
	STRING10		CoIssuedDate;
	STRING10		CompletedDate;
	STRING10		HoldDate;
	STRING10		VoidDate;
	STRING10		StatusDate;
	STRING255		ValuationAmount;
	STRING255		ValuationAmountDecimal;
	STRING255		ProjectName;
	STRING255		PermitType;
	STRING255		PermitTypeDescription;
	STRING255		PermitTypePreferred;
	STRING1000	PermitTypeCombined;
	STRING100		ProjectID;
	STRING20		TotalSqFt;
	STRING20		TotalFinishedSqFt;
	STRING20		TotalUnfinishedSqFt;
	STRING20		TotalHeatedSqFt;
	STRING20		TotalUnHeatedSqFt;
	STRING20		TotalAccSqFt;
	STRING20		TotalSprinkledSqFt;
	UNSIGNED2		check_NewConstruction;
	UNSIGNED2		check_AlterationRemodelAddition;
	UNSIGNED2		check_PermitTypeBuilding;
	UNSIGNED2		check_PermitTypeElectrical;
	UNSIGNED2		check_PermitTypeMechanical;
	UNSIGNED2		check_PermitTypePlumbing;
	UNSIGNED2		check_PermitTypeOther;
	UNSIGNED2		check_Roof;
	UNSIGNED2		check_Pool;
	UNSIGNED2		check_Demolition;
	UNSIGNED2		check_RepairReplace;
	UNSIGNED2		check_WindDamagePrevention;
	UNSIGNED2		check_SeismicDamagePrevention;
	UNSIGNED2		check_SolarPower;
	UNSIGNED2		check_SprinklerSystems;
	UNSIGNED2		check_FireAlarm;
	UNSIGNED2		check_SecuritySystems;
	UNSIGNED2		check_ChangeofUse;
	UNSIGNED2		check_WaterDamage;
	UNSIGNED2		check_WindDamage;
	UNSIGNED2		check_FireDamage;
	UNSIGNED2		check_PestsRodents;
	UNSIGNED2		check_NaturalDisasterDamage;
	UNSIGNED2		check_MobileHome;
	UNSIGNED2		check_TankNoSeptic;
	UNSIGNED2		check_NewCommercialConstruction;
	UNSIGNED2		check_NewCommercialConstructionIndustrial;
	UNSIGNED2		check_NewCommercialConstructionRetail;
	UNSIGNED2		check_NewCommercialConstructionWarehouse;
	UNSIGNED2		check_NewCommercialConstructionOffice;
	UNSIGNED2		check_NewMultiFamilyConstruction;
	UNSIGNED2		check_PermitStatusCompleted;
	UNSIGNED2		check_PermitStatusExpiredCanceledVoid;
	UNSIGNED2		check_WindOpeningProtection;
	UNSIGNED2		check_WindOpeningProtection_StrictShutter;
	UNSIGNED2		check_WindOpeningProtection_LooseShutter;
	UNSIGNED2		check_RoofCovering_StrictReroof;
	UNSIGNED2		check_RoofCovering_LooseReroof;
  UNSIGNED2		check_LikelyValueIncreasing;
	UNSIGNED2		check_NotLikelyValueIncreasing;
	STRING1000 	Description; 
	STRING1000	ExtraFields;
END;
EXPORT PERMITCONTRACTOR := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	STRING255		ContractorID;
	UNSIGNED4		RecNum;
	UNSIGNED4		PermitRecNum;
	UNSIGNED4		ContractorRecNum;
END;
EXPORT PROPERTY := RECORD
	STRING255  	ID;
	UNSIGNED4		RecNum;
	STRING4			ERROR_CODE;
	
	STRING255		RADDRESS1;
	STRING255		RADDRESS2;
	STRING55		RCITY;
	STRING15		RSTATE;
	STRING15		RZIP;

	STRING255		OADDRESS1;
	STRING255		OADDRESS2;
	STRING55		OCITY;
	STRING2			OSTATE;
	STRING15		OZIP;

// This is used for address cleaning
	STRING255		CADDRESS1;
	STRING255		CADDRESS2;
	STRING55		CCITY;
	STRING15		CSTATE;
	STRING15		CZIP;
	STRING5			CZIP5;

	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;

	UNSIGNED4		CAPassNumber;
	UNSIGNED4		CAPassHits;
	STRING255		PIN;
	STRING255		CensusTract;
	STRING255		FloodZone;
	STRING255		Acreage;
	STRING255		Section;
	STRING255		Township;
	STRING255		Range;
	STRING255		Area;
	STRING255		Parcel;
	STRING255		Lot;
	STRING255		Block;
	STRING255		Grid;
	STRING255		PropertyMap;
	STRING255		Volume;
	STRING255		Page;
	STRING255		District;
	STRING255		Subdivision;
	STRING255		Development;
	STRING255		Elevation;
	DECIMAL15_10 LatitudeDecimal;
	DECIMAL15_10 LongitudeDecimal;
	STRING255		Zone;
	DECIMAL6_2 	CommercialPercentage;
	DECIMAL6_2 	ResidentialPercentage;
	STRING1000	CorrectAddressDescription;
	STRING100		StreetExtract;
	STRING4			YearBuilt; 
	STRING50		MuniName; 
	STRING20		CountyFIPS; 
	STRING50		CountyName; 
	STRING50		ParcelPrimary; 
	STRING50		ParcelReference; 
	STRING4			ParcelChangeYear; 
END;
EXPORT CLEANADDRESS := RECORD
	STRING255		CADDRESS1;
	STRING255		CADDRESS2;
	STRING55		CCITY;
	STRING15		CSTATE;
	STRING15		CZIP;
	STRING5			CZIP5;
	STRING4			ERROR_CODE;
	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
END;
EXPORT CONTRACTOR_SLIM:= RECORD
	STRING255  	ID;
	UNSIGNED4		RECNUM;
	STRING255		FULLNAME;
	STRING100 	CompanyName;
	STRING255 	CompanyDesc;
	STRING20		PHONE;
	STRING100		RADDRESS1;
	STRING80		RADDRESS2;
	STRING50		RCITY;
	STRING10		RSTATE;
	STRING10		RZIP;

	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	STRING50		TRADE;
END;

EXPORT CORRECTION_SLIM := RECORD
	STRING255  	ID;
	STRING255		PROPERTYID;
	UNSIGNED4		RECNUM;
	STRING255		PROPERTYRECNUM;
	STRING100		CORRECTEDADDRESS1;
	STRING80		CORRECTEDADDRESS2;
	STRING50		CORRECTEDCITY;
	STRING10		CORRECTEDSTATE;
	STRING10		CORRECTEDZIP;
	
	UNSIGNED4		CAPASSNUMBER;
	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	DECIMAL15_10	LATITUDE;
	DECIMAL15_10	LONGITUDE;
END;

EXPORT INSPECTION_SLIM := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	UNSIGNED4		RECNUM;
	STRING255		PermitRecNum;
	STRING50		InspType;
	STRING255		Description;
	STRING3			Final;
	STRING10		RequestDate;
	STRING10		RequestTime;
	STRING10		DesiredDate;
	STRING10		DesiredTime;
	STRING10		ScheduledDate;
	STRING10		ScheduledTime;
	STRING10		InspectedDate;
	STRING10		InspectedTime;
	STRING3			ReInspection;
	STRING40		Inspector;
	STRING40		Result;
END;
EXPORT PERMIT_SLIM := RECORD
	STRING255  	ID;
	STRING255		PropertyID;
	UNSIGNED4		RECNUM;
	UNSIGNED4		PropertyRecNum;
	STRING50		Jurisdiction;
	STRING50		PermitNum;
	STRING50		PermitClass;
	STRING50		MasterPermitNum;
	STRING50		WorkClass;
	STRING50		ProposedUse;
	STRING50		PermitStatus;
	STRING10		PreferredDate;
	STRING10		AppliedDate;
	STRING10		IssuedDate;
	STRING10		ExpiresDate;
	STRING10		CoIssuedDate;
	STRING10		CompletedDate;
	STRING10		HoldDate;
	STRING10		VoidDate;
	STRING10		StatusDate;
	STRING50		ValuationAmount;
	STRING50		ValuationAmountDecimal;
	STRING50		ProjectName;
	STRING50		PermitType;
	STRING50		PermitTypeDescription;
	STRING50		PermitTypePreferred;
	STRING100		PermitTypeCombined;
	STRING50		ProjectID;
	STRING20		TotalSqFt;
	STRING20		TotalFinishedSqFt;
	STRING20		TotalUnfinishedSqFt;
	STRING20		TotalHeatedSqFt;
	STRING20		TotalUnHeatedSqFt;
	STRING20		TotalAccSqFt;
	STRING20		TotalSprinkledSqFt;
	UNSIGNED2		check_NewConstruction;
	UNSIGNED2		check_AlterationRemodelAddition;
	UNSIGNED2		check_PermitTypeBuilding;
	UNSIGNED2		check_PermitTypeElectrical;
	UNSIGNED2		check_PermitTypeMechanical;
	UNSIGNED2		check_PermitTypePlumbing;
	UNSIGNED2		check_PermitTypeOther;
	UNSIGNED2		check_Roof;
	UNSIGNED2		check_Pool;
	UNSIGNED2		check_Demolition;
	UNSIGNED2		check_RepairReplace;
	UNSIGNED2		check_WindDamagePrevention;
	UNSIGNED2		check_SeismicDamagePrevention;
	UNSIGNED2		check_SolarPower;
	UNSIGNED2		check_SprinklerSystems;
	UNSIGNED2		check_FireAlarm;
	UNSIGNED2		check_SecuritySystems;
	UNSIGNED2		check_ChangeofUse;
	UNSIGNED2		check_WaterDamage;
	UNSIGNED2		check_WindDamage;
	UNSIGNED2		check_FireDamage;
	UNSIGNED2		check_PestsRodents;
	UNSIGNED2		check_NaturalDisasterDamage;
	UNSIGNED2		check_MobileHome;
	UNSIGNED2		check_TankNoSeptic;
	UNSIGNED2		check_NewCommercialConstruction;
	UNSIGNED2		check_NewCommercialConstructionIndustrial;
	UNSIGNED2		check_NewCommercialConstructionRetail;
	UNSIGNED2		check_NewCommercialConstructionWarehouse;
	UNSIGNED2		check_NewCommercialConstructionOffice;
	UNSIGNED2		check_NewMultiFamilyConstruction;
	UNSIGNED2		check_PermitStatusCompleted;
	UNSIGNED2		check_PermitStatusExpiredCanceledVoid;
	UNSIGNED2		check_WindOpeningProtection;
	UNSIGNED2		check_WindOpeningProtection_StrictShutter;
	UNSIGNED2		check_WindOpeningProtection_LooseShutter;
	UNSIGNED2		check_RoofCovering_StrictReroof;
	UNSIGNED2		check_RoofCovering_LooseReroof;
  UNSIGNED2		check_LikelyValueIncreasing;
	UNSIGNED2		check_NotLikelyValueIncreasing;
END;
EXPORT PERMITCONTRACTOR_SLIM := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	STRING255		ContractorID;
	UNSIGNED4		RecNum;
	UNSIGNED4		PermitRecNum;
	UNSIGNED4		ContractorRecNum;
END;
EXPORT PROPERTY_SLIM := RECORD
	STRING255  	ID;
	UNSIGNED4		RecNum;
	STRING4			ERROR_CODE;
	
	STRING100		RADDRESS1;
	STRING80		RADDRESS2;
	STRING50		RCITY;
	STRING10		RSTATE;
	STRING10		RZIP;

	STRING100		OADDRESS1;
	STRING80		OADDRESS2;
	STRING50		OCITY;
	STRING10		OSTATE;
	STRING10		OZIP;

// This is used for address cleaning
	STRING100		CADDRESS1;
	STRING80		CADDRESS2;
	STRING50		CCITY;
	STRING10		CSTATE;
	STRING10		CZIP;
	STRING10		CZIP5;

	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;

	UNSIGNED4		CAPassNumber;
	UNSIGNED4		CAPassHits;
	STRING50		PIN;
	STRING50		CensusTract;
	STRING50		FloodZone;
	STRING50		Acreage;
	STRING50		Section;
	STRING50		Township;
	STRING50		Range;
	STRING50		Area;
	STRING50		Parcel;
	STRING50		Lot;
	STRING50		Block;
	STRING50		Grid;
	STRING50		PropertyMap;
	STRING50		Volume;
	STRING50		Page;
	STRING50		District;
	STRING50		Subdivision;
	STRING50		Development;
	STRING50		Elevation;
	DECIMAL15_10 LatitudeDecimal;
	DECIMAL15_10 LongitudeDecimal;
	STRING50		Zone;
	DECIMAL6_2 	CommercialPercentage;
	DECIMAL6_2 	ResidentialPercentage;
	STRING100		StreetExtract;
	STRING4			YearBuilt; 
	STRING50		MuniName; 
	STRING20		CountyFIPS; 
	STRING50		CountyName; 
	STRING50		ParcelPrimary; 
	STRING50		ParcelReference; 
	STRING4			ParcelChangeYear; 
END;
EXPORT Jurisdiction := RECORD
	STRING255  	Jurisdiction;
	STRING10		GoLiveDate;
	STRING10		PreferredDate;
	STRING10		MinDate;
	STRING10		ExclusionMinDate;
	STRING10		MaxDate;
	STRING10		ExclusionMaxDate;
	STRING16		LastUpdateTime;
	STRING255		JurisdictionName;
	STRING255		OfficialName;
	STRING100		StreetAddress;
	STRING80		City;
	STRING10		STATE;
	STRING10		ZIP;
	STRING100		website;
	STRING30		Fax;
	STRING30		Office;
	STRING30		OtherPhone;
	STRING100		County;
END;
EXPORT StreetLookup := RECORD
	STRING255		STREET;
	STRING50		CITY;
	STRING2			STATE;
	STRING10		ZIP;
	STRING255		Jurisdiction;
END;
END;