export layout_PropertyPairs := RECORD
  string2 state_code;
  string3 county_code;
  string12 geolink;

  real TenthLowestDist:=999;
  integer n_bPropertiesByA:=0;
  integer nPropertiesInGroup:=0;
  boolean EnoughBitSynergy := false;
  
  unsigned a_seqno:=1;
  unsigned8 a_cleanaid;
  string12 a_ogeolink;
	
  real a_Baths;
  unsigned a_BathsBit;
  string3 a_Baths_ftype := '';
	
  real a_Bedrooms;
  unsigned a_BedroomsBit;
  string3 a_Bedrooms_ftype := '';
	
  real a_BuildingArea;
  unsigned a_BuildingAreaBit;
  string3 a_BuildingArea_ftype := '';
	
  real a_Rooms;
  unsigned a_RoomsBit;
  string3 a_Rooms_ftype := '';
	
  real a_BuildingAge;
  unsigned a_BuildingAgeBit;
  string3 a_BuildingAge_ftype := '';
	
  real a_Stories;
  unsigned a_StoriesBit;
  string3 a_Stories_ftype := '';
	
  real a_AssessedAmount;
  unsigned a_AssessedAmountBit;
  string3 a_AssessedAmount_ftype := '';
	
  unsigned a_Bites;
  unsigned1 a_BitVector := 0;

//New Variables	
	real 	a_Fireplaces;
  unsigned 	a_FireplacesBit:=0;
  string3		a_Fireplaces_ftype := '';
	
	real 	a_Garage;
  unsigned 	a_GarageBit:=0;
  string3 	a_Garage_ftype := '';
	
	real 	a_Construction;
  unsigned 	a_ConstructionBit:=0;
  string3 	a_Construction_ftype := '';
	
	real 	a_Exterior;
  unsigned 	a_ExteriorBit:=0;
  string3 	a_Exterior_ftype := '';
	
	real 	a_Foundation;
  unsigned 	a_FoundationBit:=0;
  string3 	a_Foundation_ftype := '';
	
	real 	a_Heating;
  unsigned 	a_HeatingBit:=0;
  string3 	a_Heating_ftype := '';
	
	real 	a_Air_Conditioning_Type;
  unsigned 	a_Air_ConditioningBit:=0;
  string3 	a_Air_Conditioning_ftype := '';
	
	real 	a_Roof_Cover;
  unsigned 	a_Roof_CoverBit:=0;
  string3 	a_Roof_Cover_ftype := '';
	
	real 	a_Floor_Cover;
  unsigned 	a_Floor_CoverBit:=0;
  string3 	a_Floor_Cover_ftype := '';
	
	real 	a_Garage_sqft;
  unsigned 	a_Garage_sqftBit:=0;
  string3 	a_Garage_sqft_ftype := '';
	
  real 	a_Basement_sqft;
  unsigned 	a_Basement_sqftBit:=0;
  string3 	a_Basement_sqft_ftype := '';

//Additonal Variables	
	real 	a_Fuel_Type;
  unsigned 	a_Fuel_TypeBit:=0;
  string3 	a_Fuel_Type_ftype := '';
	
	real 	a_Basement;
  unsigned 	a_BasementBit:=0;
  string3 	a_Basement_ftype := '';
	
// Not provided by vendor	
	// string3 	a_Fireplace_Type	:= '';
  // unsigned 	a_Fireplace_TypeBit:=0;
  // string3		a_Fireplace_Type_ftype := '';
	// string3 	a_Parking_Type	:= '';
  // unsigned 	a_Parking_TypeBit:=0;
  // string3		a_Parking_Type_ftype := '';
	
  unsigned b_seqno:=1;
  unsigned8 b_cleanaid;
  string12 b_ogeolink;
	
  real b_Baths:=0;
  unsigned b_BathsBit:=0;
  string3 b_Baths_ftype := '';
	
  real b_Bedrooms:=0;
  unsigned b_BedroomsBit:=0;
  string3 b_Bedrooms_ftype := '';

  real b_BuildingArea:=0;
  unsigned b_BuildingAreaBit:=0;
  string3 b_BuildingArea_ftype := '';
	
  real b_Rooms:=0;
  unsigned b_RoomsBit:=0;
  string3 b_Rooms_ftype := '';
	
  real b_BuildingAge:=0;
  unsigned b_BuildingAgeBit:=0;
  string3 b_BuildingAge_ftype := '';
	
  real b_Stories:=0;
  unsigned b_StoriesBit:=0;
  string3 b_Stories_ftype := '';
	
  real b_AssessedAmount:=0;
  unsigned b_AssessedAmountBit:=0; 
  string3 b_AssessedAmount_ftype := '';
	
  unsigned b_Bites:=0;
  unsigned1 b_BitVector := 0;
	
//New Variables	
	real		b_Fireplaces:=0;
  unsigned 	b_FireplacesBit:=0;
  string3 	b_Fireplaces_ftype := '';
	
	real 	b_Garage := 0;
  unsigned 	b_GarageBit:=0;
  string3 	b_Garage_ftype := '';
	
	real 	b_Construction := 0;
  unsigned 	b_ConstructionBit:=0;
  string3 	b_Construction_ftype := '';
	
	real 	b_Exterior := 0;
  unsigned 	b_ExteriorBit:=0;
  string3 	b_Exterior_ftype := '';
	
	real 	b_Foundation := 0;
  unsigned 	b_FoundationBit:=0;
  string3 	b_Foundation_ftype := '';
	
	real 	b_Heating := 0;
  unsigned 	b_HeatingBit:=0;
  string3 	b_Heating_ftype := '';
	
	real 	b_Air_Conditioning_Type := 0;
  unsigned 	b_Air_ConditioningBit:=0;
  string3 	b_Air_Conditioning_ftype := '';
	
	real 	b_Roof_Cover := 0;
  unsigned 	b_Roof_CoverBit:=0;
  string3 	b_Roof_Cover_ftype := '';
	
	real 	b_Floor_Cover := 0;
  unsigned 	b_Floor_CoverBit:=0;
  string3 	b_Floor_Cover_ftype := '';
	
	real 	b_Garage_sqft:= 0;
  unsigned 	b_Garage_sqftBit:=0;
  string3 	b_Garage_sqft_ftype := '';
	
  real 	b_Basement_sqft:= 0;
  unsigned 	b_Basement_sqftBit:=0;
  string3 	b_Basement_sqft_ftype := '';

	
//Additonal Variables		
	real 	b_Fuel_Type:= 0;
  unsigned 	b_Fuel_TypeBit:=0;
  string3 	b_Fuel_Type_ftype := '';
	
	real 	b_Basement:= 0;
  unsigned 	b_BasementBit:=0;
  string3 	b_Basement_ftype := '';

//Not provided by vendor	
	// string3 	b_Fireplace_Type	:= '';
  // unsigned 	b_Fireplace_TypeBit:=0;
  // string3		b_Fireplace_Type_ftype := '';
	// string3 	b_Parking_Type	:= '';
  // unsigned 	b_Parking_TypeBit:=0;
  // string3		b_Parking_Type_ftype := '';
	
  boolean hasHedonic := false;
  real adistance:=0;  
  real edistance:=0;  
  real total_wgt := 0;
	unsigned8 match_id:=0;
END;
