// layouts.ecl
import doxie, LN_PropertyV2, property, ut, Risk_Indicators, advo, address, address_attributes,PropertyFieldFillInByLA2;


export layouts := module


export layout_GlinkGlinkDistNumSFDs := RECORD
  string12 geolink1;
  string12 geolink2;
  real distance;
  unsigned num_sfds1:=0;
  unsigned num_sfds2:=0;
END;

EXPORT layout_groupGeoblock := RECORD
  string12 GlinkGroupName;
  string12 mem_geolink;
  real8 distance;
  unsigned8 num_sfds2;
  integer total_sfds := 0;
END;

export 	layout_ADVO := RECORD
  Unsigned8		RawAID;
	Unsigned8		cleanaid;
  string10    prim_range; 	// [1..10]
  string2     predir;		// [11..12]
  string28    prim_name;	// [13..40]
  string4     addr_suffix;  // [41..44]
  string2     postdir;		// [45..46]
  string10    unit_desig;	// [47..56]
  string8     sec_range;	// [57..64]
  string25    p_city_name;	// [65..89]
  string25    v_city_name;  // [90..114]
  string2     st;			// [115..116]
  string5     zip;		// [117..121]
  string4     zip4;		// [122..125]
  string2    	fips_county:='';
  string3    	county:='';
  string10    geo_lat;		// [146..155]
  string11    geo_long;	// [156..166]
  string4     msa;		// [167..170]
  string7     geo_blk;		// [171..177]
  string1     geo_match;	// [178]
end;

export layout_BaseWithAverageHedonics := record
	unsigned8 	seqno;
  string12  	geolink;  
  layout_ADVO;
	string4 		standardized_land_use_code;
	string3			property_type_code;
  unsigned4   BuildingAge;
  unsigned4   AssessedAmount;
  unsigned8   BuildingArea;
  real				Stories;		
  unsigned8   Rooms;
  unsigned8   Bedrooms;
  real  			Baths;
	unsigned4			Fireplaces;
  unsigned4			garage;
	unsigned4			construction_type;
	unsigned4			exterior_walls;
	unsigned4			foundation;
	unsigned4		  roof_cover;
	unsigned4			heating;
	unsigned4			fuel_type;
	unsigned4			air_conditioning_type;
	unsigned4			floor_cover;
	unsigned8   	garage_sqft;		
	unsigned8   	basement_sqft;
	unsigned4			basement;					
	unsigned4			water;						// future phase
	unsigned4			sewer;					  // future phase
	unsigned4			Style;						// future phase
	unsigned4			Pool;							// future phase	
	// string3			parking_type;   // not populated by vendor
	// string3			fireplace_type;		// not populated by vendor


end;


EXPORT ReducedPropertyRec := RECORD
  integer seqno := 1;
	string12 geolink;
  string2 state_code;
  string3 county_code;
  integer nPropertiesInGroup := 0;
  string10 geo_lat;
  string11 geo_long;
END;

export layout_PairDistances := RECORD
  string2 state_code;
  string3 county_code;
  integer n_bPropsPer_aProp:=0;
  integer nPropertiesInGroup:=0;
  
  integer a_seqno;
  string10 a_geo_lat:='';
  string11 a_geo_long:='';

  integer b_seqno:=0;
  string10 b_geo_lat:='';
  string11 b_geo_long:='';
  
  real distance:=0;  
END;


export base :=  RECORD
  unsigned8 	seqno;
  string12  	geolink;  
  layout_ADVO;
	string4 		standardized_land_use_code;
	string3			property_type_code;
  unsigned4   BuildingAge;
  unsigned4   AssessedAmount;
  unsigned8   BuildingArea;
  real				Stories;		
  unsigned8   Rooms;
  unsigned8   Bedrooms;
  real  			Baths;
	unsigned4		Fireplaces;
	unsigned4		garage;
	string3			garage_code;
	unsigned4		construction_type;
	string3			construction_type_code;
	unsigned4		exterior_walls;
	string3			exterior_walls_code;
	unsigned4		foundation;
	string3			foundation_code;
	unsigned4	  roof_cover;
	string3		  roof_cover_code;
	unsigned4		heating;
	string3			heating_code;
	unsigned4		fuel_type;
	string3			fuel_type_code;
	unsigned4		air_conditioning_type;
	string3			air_conditioning_type_code;
	unsigned4		floor_cover;
  string3			floor_cover_code;
	unsigned8   garage_sqft;		
	unsigned8   basement_sqft;
	unsigned4		basement;
	string3			basement_code;
 END;

export codes := record
 string file_name;
 string field_name;
 string field_name2;
 string code;
 string code_2;
 string long_desc;
 string loc_avg;
 
END;
 
export update  := record
	unsigned8 	seqno;
  string12  	geolink;  
  layout_ADVO;
	string4 		standardized_land_use_code;
	string3			property_type_code;

//Characteristics Fields	
  unsigned4   BuildingAge;
	string3 		BuildingAge_ftype := '';
	
  unsigned4   AssessedAmount;
	string3 		AssessedAmount_ftype := '';
	
  unsigned8   BuildingArea;
	string3 		BuildingArea_ftype := '';
	
  real				Stories;		
	string3 		Stories_ftype := '';
	
  unsigned8   Rooms;
	string3 		Rooms_ftype := '';
	
  unsigned8   Bedrooms;
	string3 		Bedrooms_ftype := '';
	
  real  			Baths;
	string3 		Baths_ftype := '';
	
	unsigned4		Fireplaces;
	string3 		Fireplaces_ftype := '';
	
  unsigned4		garage;
	string3 		Garage_ftype := '';
	
	unsigned4		construction_type;
	string3 		Construction_ftype := '';
	
	unsigned4		exterior_walls;
	string3 		Exterior_ftype := '';
	
	unsigned4		foundation;
	string3 		Foundation_ftype := '';
	
	unsigned4		roof_cover;
	string3 		Roof_Cover_ftype := '';
	
	unsigned4		heating;
	string3 		Heating_ftype := '';
	
	unsigned4		fuel_type;
	string3			Fuel_Type_ftype := '';
	
	unsigned4		air_conditioning_type;
	string3 		Air_Conditioning_ftype := '';
	
	unsigned4		floor_cover;
	string3 		Floor_Cover_ftype := '';
	
	unsigned8  	garage_sqft;	
	string3 		Garage_sqft_ftype := '';
	
	unsigned8  	basement_sqft;
	string3 		Basement_sqft_ftype := '';
	
	unsigned4		basement;		
	string3 		Basement_ftype := '';			

//Future Fields	
	// unsigned4			water;						// future phase
	// unsigned4			sewer;					  // future phase
	// unsigned4			Style;						// future phase
	// unsigned4			Pool;							// future phase	
	

end;
 
END;