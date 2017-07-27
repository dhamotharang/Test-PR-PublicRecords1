EXPORT LayoutExports := MODULE

// contractor: all contractors associated with permits
// ID 								varchar(255) 				Unique-across-jurisdictions identifier; will change from database version to database version
// RecNum						int(10) unsigned		Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); 
																			// will change from database version to database version
// FullName					varchar(255)				Full Name of the contractor, which can mean names of individuals or names of companies. If a jurisdiction stores only one field for 
																			// contractors in its database, and some of the contractors are listed as individuals, all of the contractor names and company names will be 
																			// in this field.
// CompanyName				varchar(255)				Company Name of the contractor; mapped only if the vast majority of source records have a company (as opposed to an individual) listed in this field.
// CompanyDesc				varchar(255)				Company description
// Phone							varchar(255)				Contractor phone number
// Address1					varchar(255)				Contractor street address
// Address2					varchar(255)				Contractor street address 2
// City							varchar(255)				Contractor city
// State							varchar(255)				Contractor state
// Zip								varchar(255)				Contractor zip
// Email							varchar(255)				Contractor email address
// Trade							varchar(255)				Contractor trade; also used to designate contractor’s relationship to permitted work (e.g. Architect, Engineer, Contractor, Applicant, etc)
// ExtraFields				text								Source fields that BuildFax engineers found interesting but could not logically map to one of the above fields.

EXPORT CONTRACTOR := RECORD
	STRING255  	ID;
	UNSIGNED4		RECNUM;
	STRING255		FULLNAME;
	STRING255 	CompanyName;
	STRING255 	CompanyDesc;
	STRING255		PHONE;
	STRING255		RADDRESS1;
	STRING255		RADDRESS2;
	STRING255		RCITY;
	STRING255		RSTATE;
	STRING255		RZIP;
	STRING255		EMAIL;
	STRING255		TRADE;
	STRING5000	EXTRAFIELDS;//50000 rollbacked to 5000 in order to speed up 
END;

// corrections: every possible address correction found for each property Field Data Type Description
// ID					varchar(255)				Unique-across-jurisdictions identifier; will change from database version to database version
// PropertyID	varchar(255)				Unique-across-jurisdictions property identifier
// RecNum			int(10) unsigned		Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); will change from database version to database version
// PropertyRecNum	int(10) unsigned Jurisdiction-specific property identifier
// CorrectedAddress1 varchar(255)	Corrected street address (line 1)
// CorrectedAddress2	varchar(255)	Corrected street address (line 2)
// CorrectedCity			varchar(100)	Corrected city
// CorrectedState		varchar(25)		Corrected state
// CorrectedZip			varchar(25)		Corrected zip
// CAPassNumber	int(10) unsigned	CorrectAddress pass number on which the correction was found. The higher the pass number, the less sure CorrectAddress is about the accuracy of the correction.
// Latitude			double						Latitude returned from CorrectAddress
// Longitude			double						Longitude returned from CorrectAddress
EXPORT CORRECTION := RECORD
	STRING255  	ID;
	STRING255		PROPERTYID;
	UNSIGNED4		RECNUM;
	STRING255		PROPERTYRECNUM;
	STRING255		CORRECTEDADDRESS1;
	STRING255  	CORRECTEDADDRESS2;
	STRING255		CORRECTEDCITY;
	STRING255		CORRECTEDSTATE;
	STRING255		CORRECTEDZIP;
	UNSIGNED4		CAPASSNUMBER;
	DECIMAL15_10	LATITUDE;
	DECIMAL15_10	LONGITUDE;
END;

// inspection: all inspections associated with permits Field Data Type Description
// ID						varchar(255)				Unique-across-jurisdictions identifier; will change from database version to database version
// PermitID			varchar(255)				Unique-across-jurisdictions permit identifier
// RecNum				int(10) unsigned		Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); will change from database version to database version
// PermitRecNum	int(10) unsigned		Jurisdiction-specific permit identifier
// InspType			varchar(255)				Abbreviated/shorthand type of inspection
// Description		varchar(255)				Longer description of inspection
// SpecialInstructions	varchar(255)	Special instructions on the inspection (e.g., “make sure to check the smoke detectors”)
// Final					char(3)							Indicator as to whether or not the inspection is a final inspection
// RequestDate		date								Date on which the inspection was requested
// RequestTime		varchar(100)				Time at which the inspection was requested
// DesiredDate		date								Date desired for inspection
// DesiredTime		varchar(100)				Time desired for inspection
// ScheduledDate	date								Date scheduled for inspection
// ScheduledTime	varchar(100)				Time scheduled for inspection
// InspectedDate	date								Actual date inspected
// InspectedTime	varchar(100)				Actual time inspected
// Result				varchar(255)				Result of inspection
// ReInspection	char(3)							Indicator as to whether a reinspection is needed
// InspectionNotes	text							Notes from the inspector—if populated after a failed inspection, usually consists of an explanation of why the inspection failed
// Inspector			varchar(40)					Name and/or identifier of inspector
// ExtraFields		text								Source fields that BuildFax engineers found interesting but could not logically map to one of the above fields.
EXPORT inspection := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	UNSIGNED4		RECNUM;
	STRING255		PermitRecNum;
	STRING255		InspType;
	STRING255		Description;
	STRING255		SpecialInstructions;
	STRING3			Final;
	STRING255		RequestDate;
	STRING100		RequestTime;
	STRING255		DesiredDate;
	STRING100		DesiredTime;
	STRING255		ScheduledDate;
	STRING100		ScheduledTime;
	STRING255		InspectedDate;
	STRING100		InspectedTime;
	STRING255		Result;
	STRING3			ReInspection;
	STRING5000	InspectionNotes;//50000 rollbacked to 5000 in order to speed up 
	STRING40		Inspector;
	STRING5000	ExtraFields;		//50000 rollbacked to 5000 in order to speed up 
END;
// permit: all permits
// ID								varchar(255)				Unique-across-jurisdictions identifier; will change from database version to database version
// PropertyID				varchar(255)				Unique-across-jurisdictions property identifier
// RecNum						int(10) unsigned		Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); will change from database version to database version
// PropertyRecNum		int(10) unsigned		Jurisdiction-specific property identifier
// Jurisdiction			varchar(50)					BuildFax Jurisdiction ID
// PermitNum					varchar(255)				Permit number
// PermitClass				varchar(255)				Permit class (e.g., Residential, Commercial)
// MasterPermitNum		varchar(255)				Master permit number
// Description				mediumtext					Description of work permitted
// WorkClass					varchar(100)				Permit work class
// ProposedUse				varchar(255)				Proposed use of permitted work
// PermitStatus			varchar(255)				Status of permit
// PreferredDate			date								Algorithmically-chosen date for each permit; it will be one of the below dates, but because different jurisdictions populate different sets of dates, 
																			// if you just need a date for a permit, use PreferredDate, because it is the most frequently populated date.
// AppliedDate				date								Date on which the permit was applied
// IssuedDate				date								Date on which the permit was issued
// ExpiresDate				date								Date on which the permit will/would have expire(d)
// CoIssuedDate			date								Date on which the related certificate of occupancy was issued
// CompletedDate			date								Date on which the permit was completed
// HoldDate					date								Date on which the permit was put on hold
// VoidDate					date								Date on which the permit was voided
// StatusDate				date								A less-well-defined date for the permit; usually indicates the last time a permit was updated in the jurisdiction’s database, 
																			// but can also be a composite of the above dates.
// ValuationAmount		varchar(255)				Text container for the permit’s valuation; some jurisdictions store multiple valuations, and some jurisdictions store valuation as a text field 
                                      // and store text in their valuation field, so BuildFax preserves those values here
// ValuationAmountDecimal decimal(15,2)	Algorithmically-generated decimal version of the jurisdiction’s valuation
// ProjectName				varchar(255)				Name of the project related to the permit
// PermitType				varchar(255)				Abbreviated/shorthand type of permit
// PermitTypeDescription	varchar(255)		Longer description of permit type
// PermitTypePreferred		varchar(255)		PermitTypeDescription if it is populated; otherwise PermitType. This allows you to use a single field to get the best populated PermitType field.
// PermitTypeCombined		varchar(1000)		PermitType + PermitTypeDescription
// ProjectID					varchar(100)				ID within the jurisdiction’s database of the project related to the permit
// TotalSqFt					varchar(20)					Total square footage relevant to the permit
// TotalFinishedSqFt	varchar(20)					Total finished square footage relevant to the permit
// TotalUnfinishedSqFt	varchar(20)				Total unfinished square footage relevant to the permit
// TotalHeatedSqFt		varchar(20)					Total heated square footage relevant to the permit
// TotalUnHeatedSqFt	varchar(20)					Total unheated square footage relevant to the permit
// TotalAccSqFt			varchar(20)					Total accessory square footage relevant to the permit
// TotalSprinkledSqFt	varchar(20)				Total sprinkled square footage relevant to the permit
// ExtraFields				text								Source fields that BuildFax engineers found interesting but could not logically map to one of the above
// check_NewConstruction	tinyint(1)			BuildFax New Construction check (see public BuildFax data dictionary for in-depth description of this and other BuildFax Checks)
// check_AlterationRemodelAddition	tinyint(1)	BuildFax Alteration/Remodel/Addition check
// check_PermitTypeBuilding	tinyint(1)	BuildFax Permit Type: Building check
// check_PermitTypeElectrical	tinyint(1)	BuildFax Permit Type: Electrical check
// check_PermitTypeMechanical	tinyint(1)	BuildFax Permit Type: Mechanical check
// check_PermitTypePlumbing	tinyint(1)	BuildFax Permit Type: Plumbing check
// check_PermitTypeOther	tinyint(1)			BuildFax Permit Type: Other check
// check_Roof				tinyint(1)					BuildFax Roof check
// check_Pool				tinyint(1)					BuildFax Pool check
// check_Demolition	tinyint(1)					BuildFax Demolition check
// check_RepairReplace	tinyint(1)				BuildFax Repair/Replace check
// check_WindDamagePrevention	tinyint(1)	BuildFax Wind Damage Prevention check
// check_SeismicDamagePrevention	tinyint(1)	BuildFax Seismic Damage Prevention check
// check_SolarPower	tinyint(1)					BuildFax Solar Power check
// check_SprinklerSystems	tinyint(1)		BuildFax Sprinkler Systems check
// check_FireAlarm		tinyint(1)					BuildFax Fire Alarm check
// check_SecuritySystems	tinyint(1)			BuildFax Security Systems check
// check_ChangeofUse	tinyint(1)					BuildFax Change of Use check
// check_WaterDamage	tinyint(1)					BuildFax Water Damage check
// check_WindDamage	tinyint(1)					BuildFax Wind Damage check
// check_FireDamage	tinyint(1)					BuildFax Fire Damage check
// check_PestsRodents	tinyint(1)				BuildFax Pests/Rodents check
// check_NaturalDisasterDamage	tinyint(1)	BuildFax Natural Disaster Damage check
// check_MobileHome	tinyint(1)					BuildFax Mobile Home check
// check_TankNoSeptic	tinyint(1)				BuildFax Tank (but not septic tanks) check
// check_NewCommercialConstruction	tinyint(1)	BuildFax New Commercial Construction check
// check_NewCommercialConstructionIndustrial	tinyint(1)	BuildFax New Commercial Construction – Industrial check
// check_NewCommercialConstructionRetail	tinyint(1)	BuildFax New Commercial Construction – Retail check
// check_NewCommercialConstructionWarehouse	tinyint(1)	BuildFax New Commercial Construction – Warehouse check
// check_NewCommercialConstructionOffice	tinyint(1)	BuildFax New Commercial Construction – Office check
// check_NewMultiFamilyConstruction	tinyint(1)	BuildFax New Multi-Family Construction check
// check_PermitStatusCompleted	tinyint(1)	BuildFax Permit Status: Completed check
// check_PermitStatusExpiredCanceledVoid	tinyint(1)	BuildFax Permit Status: Expired/Canceled/Void check
// check_WindOpeningProtection     check_WindOpeningProtection_StrictShutter      check_WindOpeningProtection_LooseShutter        check_RoofCovering_StrictReroof check_RoofCovering_LooseReroof  check_LikelyValueIncreasing     check_NotLikelyValueIncreasing

EXPORT PERMIT := RECORD
	STRING255  	ID;
	STRING255		PropertyID;
	UNSIGNED4		RECNUM;
	UNSIGNED4		PropertyRecNum;
	STRING50		Jurisdiction;
	STRING255		PermitNum;
	STRING255		PermitClass;
	STRING255		MasterPermitNum;
	STRING1000	Description; //628407 rollbacked to 50000 from 650000 in order to speed up now 1000
	STRING100		WorkClass;
	STRING255		ProposedUse;
	STRING255		PermitStatus;
	STRING255		PreferredDate;
	STRING255		AppliedDate;
	STRING255		IssuedDate;
	STRING255		ExpiresDate;
	STRING255		CoIssuedDate;
	STRING255		CompletedDate;
	STRING255		HoldDate;
	STRING255		VoidDate;
	STRING255		StatusDate;
	STRING255		ValuationAmount;
	STRING255 	ValuationAmountDecimal;
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
	STRING5000	ExtraFields;     //50000 rollbacked to 5000 in order to speed up
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
// permitandcontractor: linking table between permits and contractors
// ID								varchar(255)				Unique-across-jurisdictions identifier; will change from database version to database version
// PermitID					varchar(255)				Unique-across-jurisdictions permit identifier
// ContractorID			varchar(255)				Unique-across-jurisdictions contractor identifier
// RecNum						int(10) unsigned		Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); will change from database version to database version
// PermitRecNum			int(10) unsigned		Jurisdiction-specific permit identifier
// ContractorRecNum	int(10) unsigned		Jurisdiction-specific contractor identifier
EXPORT PERMITCONTRACTOR := RECORD
	STRING255  	ID;
	STRING255		PermitID;
	STRING255		ContractorID;
	UNSIGNED4		RecNum;
	UNSIGNED4		PermitRecNum;
	UNSIGNED4		ContractorRecNum;
END;
// property: all properties associated with permits
// ID								varchar(255)					Unique-across-jurisdictions identifier; will change from database version to database version
// RecNum						int(10) unsigned			Jurisdiction-specific unique identifier (smaller than ID, but only unique within the jurisdiction); will change from database version to database version
// Address1					varchar(255)					Corrected property street address (line 1)
// Address2					varchar(255)					Corrected property street address (line 2)
// City							varchar(255)					Corrected property city
// State							varchar(255)					Corrected property state
// Zip								varchar(255)					Corrected property zip code
// OriginalAddress1	varchar(255)					Original property street address (line 1), as stored by the jurisdiction
// OriginalAddress2	varchar(255)					Original property street address (line 2), as stored by the jurisdiction
// OriginalCity			varchar(255)					Original property city, as stored by the jurisdiction
// OriginalState			varchar(2)						Original property state, as stored by the jurisdiction
// OriginalZip				Varchar(255)					Original property zip code, as stored by the jurisdiction
// CAPassNumber			int(10) unsigned			CorrectAddress pass number on which the correction was found. The higher the pass number, the less sure CorrectAddress is about the accuracy of the correction.
// CAPassHits				int(10) unsigned			Number of different corrected addresses found for the jurisdiction-stored address at CAPassNumber; a number greater than 1 in this field indicates that the jurisdiction-stored address may not resolve to a single address
// CorrectAddressDescription	text					Description of how CorrectAddress took the jurisdiction-stored address and came up with the corrected address
// PIN								varchar(255)					Property PIN
// CensusTract				varchar(255)					Property Census tract
// FloodZone					varchar(255)					Property flood zone
// Acreage						varchar(255)					Property acreage
// Section						varchar(255)					Property section
// Township					varchar(255)					Property township
// Range							varchar(255)					Property range
// Area							varchar(255)					Property area
// Parcel						varchar(255)					Property parcel number
// Lot								varchar(255)					Property lot number
// Block							varchar(255)					Property block number
// Grid							varchar(255)					Property grid number
// Map								varchar(255)					Property map number
// Volume						varchar(255)					Property volume number
// Page							varchar(255)					Property page number
// District					varchar(255)					Property district
// Subdivision				varchar(255)					Property subdivision
// Development				varchar(255)					Property development
// Elevation					varchar(255)					Property elevation
// LatitudeDecimal		decimal(15,10)				Property latitude returned from CorrectAddress
// LongitudeDecimal	decimal(15,10)				Property longitude returned from CorrectAddress
// Zone							varchar(255)					Property zone
// CommercialPercentage	decimal(6,2)			Algorithmically-determined (using phonebook data) probability that the address is used for commercial purposes. An address may be “mixed-use” in that it is used for both commercial as well as residential purposes.
// ResidentialPercentage	decimal(6,2)			Algorithmically-determined (using phonebook data) probability that the address is used for residential purposes. An address may be “mixed-use” in that it is used for both commercial as well as residential purposes.
// StreetExtract			char(100)							Algorithmically-extracted property street name.
// "YearBuilt"     "MuniName"   "CountyFIPS"    "CountyName"    "ParcelPrimary" "ParcelReference"       "ParcelChangeYear"

EXPORT property := RECORD
	STRING255  	ID;
	UNSIGNED4		RecNum;
	STRING255		RADDRESS1;
	STRING255		RADDRESS2;
	STRING55		RCITY;
	STRING15		RSTATE;
	STRING15		RZIP;
	STRING255		OADDRESS1;
	STRING255		OADDRESS2;
	STRING255		OCITY;
	STRING2			OSTATE;
	STRING255		OZIP;
	UNSIGNED4		CAPassNumber;
	UNSIGNED4		CAPassHits;
	STRING5000	CorrectAddressDescription;//50000 rollbacked to 5000 in order to speed up
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
	STRING100		StreetExtract;
	STRING10		YearBuilt; 
	STRING255		MuniName; 
	STRING20		CountyFIPS; 
	STRING255		CountyName; 
	STRING255		ParcelPrimary; 
	STRING255		ParcelReference; 
	STRING10		ParcelChangeYear; 
END;
// Jurisdiction	GoLiveDate	PreferredDate	MinDate	ExclusionMinDate	MaxDate	ExclusionMaxDate	LastUpdateTime	JurisdictionName	OfficialName	StreetAddress	City	State	Zip	Website	Fax	Office	OtherPhone	County
// RAW Header
// Jurisdiction GoLiveDate PreferredDate MinDate ExclusionMinDate MaxDate ExclusionMaxDate LastUpdateTime JurisdictionName OfficialName StreetAddress City State Zip Website Fax Office OtherPhone County
// RAW file record:
// mo_florissant   10/20/2010      Issued  1/4/1960        8/1/1955        10/4/2010       10/4/2010       11/5/2010 13:11 Florissant      "City of Florissant, Permits Department"        955 Rue St.     Florissant      MO      63031   www.florissantmo.com            (314) 921-5700  (314) 839-7642  SAINT LOUIS

EXPORT Jurisdiction := RECORD
	STRING255  	Jurisdiction;
	STRING255		GoLiveDate;
	STRING255		PreferredDate;
	STRING255		MinDate;
	STRING255		ExclusionMinDate;
	STRING255		MaxDate;
	STRING255		ExclusionMaxDate;
	STRING255		LastUpdateTime;
	STRING255		JurisdictionName;
	STRING255		OfficialName;
	STRING255		StreetAddress;
	STRING255		City;
	STRING255		STATE;
	STRING255		ZIP;
	STRING255		website;
	STRING255		Fax;
	STRING255		Office;
	STRING255		OtherPhone;
	STRING255		County;
END;

// +----------------------------+------------------+------+-----+---------+----------------+
// | Field                      | Type             | Null | Key | Default | Extra          |
// +----------------------------+------------------+------+-----+---------+----------------+
// | street                     | varchar(100)     | NO   | MUL | NULL    |                |
// | city                       | varchar(255)     | NO   | MUL | NULL    |                |
// | state                      | char(2)          | NO   | MUL | NULL    |                |
// | zip                        | char(6)          | NO   | MUL | NULL    |                |
// | jurisdiction               | varchar(255)     | NO   | MUL | NULL    |                |
// +----------------------------+------------------+------+-----+---------+----------------+

EXPORT StreetLookup := RECORD
	STRING100		STREET;
	STRING255		CITY;
	STRING2			STATE;
	STRING6			ZIP;
	STRING255		Jurisdiction;
END;
END;