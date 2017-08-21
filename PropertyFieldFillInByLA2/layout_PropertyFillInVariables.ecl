export layout_PropertyFillInVariables := RECORD
  unsigned seqno := 1;
  string2 state_code;
  string3 county_code;
  string12 geolink;
  string12 ogeolink:='';
  Unsigned8 cleanaid;
  integer nPropertiesInGroup := 0;
  string10 geo_lat;
  string11 geo_long;
  
  real Baths;
  real normBaths;
  unsigned BathsBit;
  string3 Baths_ftype := '';
	
  real Bedrooms;
  real normBedrooms;
  unsigned BedroomsBit;
  string3 Bedrooms_ftype := '';
	
  real BuildingArea;
  real normBuildingArea;
  unsigned BuildingAreaBit;
  string3 BuildingArea_ftype := '';
	
  real Rooms;
  real normRooms;
  unsigned RoomsBit;
  string3 Rooms_ftype := '';
	
  real BuildingAge;
  real normBuildingAge;
  unsigned BuildingAgeBit;
  string3 BuildingAge_ftype := '';
	
  real Stories;
  real normStories;
  unsigned StoriesBit;
  string3 Stories_ftype := '';
	
  real AssessedAmount;
  real normAssessedAmount;
  unsigned AssessedAmountBit; 
  string3 AssessedAmount_ftype := '';
	
	// New Fields
	real Fireplaces;
	real normFireplaces; 
  unsigned FireplacesBit;
  string3 Fireplaces_ftype := '';
	
	real Garage;
	real normGarage;
  unsigned GarageBit;
  string3 Garage_ftype := '';
	
	real Construction;
	real normConstruction;
  unsigned ConstructionBit;
	string3 Construction_ftype := '';
	
	real Exterior;
	real normExterior;
  unsigned ExteriorBit;
  string3 Exterior_ftype := '';
	
	real Foundation;
	real normFoundation;
  unsigned FoundationBit;
  string3 Foundation_ftype := '';
	
	real Heating;
	real normHeating;
  unsigned HeatingBit;
  string3 Heating_ftype := '';
	
	real Air_Conditioning_Type;
	real normAir_Conditioning;
  unsigned Air_ConditioningBit;
  string3 Air_Conditioning_ftype := '';
	
	real Roof_Cover;
	real normRoof_Cover;
  unsigned Roof_CoverBit;
  string3 Roof_Cover_ftype := '';
	
	real Floor_Cover;
	real normFloor_Cover;
  unsigned Floor_CoverBit;
  string3 Floor_Cover_ftype := '';
	
	real Garage_sqft;
	real normGarageSqft;
  unsigned Garage_sqftBit;
  string3 Garage_sqft_ftype := '';
	
	real Basement_sqft;
	real normBasementSqft;
  unsigned Basement_sqftBit;
  string3 Basement_sqft_ftype := '';
	
	
//Additional Variables		
	real Fuel_Type;
	real normFuel_Type;
  unsigned Fuel_TypeBit;
  string3 Fuel_Type_ftype := '';
	
	real Basement;
	real normBasement;
  unsigned BasementBit;
  string3 Basement_ftype := '';
	
	// string3 Fireplace_Type;
  // unsigned Fireplace_TypeBit;
  // string3 Fireplace_Type_ftype := '';
	// string3 Parking_Type;
  // unsigned Parking_TypeBit;
  // string3 Parking_Type_ftype := '';
	
	
  unsigned1 BitVector := 0;
	unsigned Bites;
	real lAssessedValueRen;
  real lbareaRen;
  real StoriesRen;
  real BAgeResRen;
  real BedroomsRes;
  real BathsRes;
  real RoomsRen;
	unsigned8 b_cleanaid :=0;
	real adistance:=0; 
	
END;
