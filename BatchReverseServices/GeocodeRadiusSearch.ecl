IMPORT Advo,ut;

EXPORT GeocodeRadiusSearch(
	REAL in_latitude,
	REAL in_longitude,
	REAL in_mile_radius) := FUNCTION

	temp_mod := module(GeocodeSearch_Interfaces.Records)
		EXPORT BOOLEAN exclude_persons := FALSE : STORED('ExcludePersons');             // Includes people in the output.
		EXPORT BOOLEAN exclude_businesses := FALSE : STORED('ExcludeBusinesses');          // Includes businesses in the output.
		
		EXPORT UNSIGNED3 dt_range_start := 0 : STORED('DateRangeStart');                // YYYYMM format, or 0.
		EXPORT UNSIGNED3 dt_range_end := 0 : STORED('DateRangeEnd');                  // YYYYMM format, or 0.
		
		EXPORT BOOLEAN exclude_if_match_is_best := FALSE : STORED('ExcludeIfMatchIsBest');    // Don't return if the found record matches best record
		EXPORT BOOLEAN exclude_if_match_isnt_best := FALSE : STORED('ExcludeIfMatchIsntBest');  // Don't return if the found record doesn't match best record
	end;

	// CONSTANTS
	REAL PI := 3.1415926535;
	REAL METERS_PER_MILE := 1609.344;
	REAL POLAR_RADIUS := 6356752.314; // METERS
	REAL EQUATORIAL_RADIUS := 6378137.0; // METERS
	
	// We need these calculated QUASI-CONSTANTS
	REAL LATITUDE_IN_RADIANS := in_latitude * PI / 180.0;
	REAL MILES_PER_DEGREE_LATITUDE :=
		(PI/180.0)*power(POLAR_RADIUS*EQUATORIAL_RADIUS,2)/power(power(EQUATORIAL_RADIUS*cos(LATITUDE_IN_RADIANS),2)+power(POLAR_RADIUS*sin(LATITUDE_IN_RADIANS),2),1.5)/METERS_PER_MILE;
	REAL MILES_PER_DEGREE_LONGITUDE :=
		(PI/180.0)*cos(LATITUDE_IN_RADIANS)*power(POLAR_RADIUS,2)/power(power(EQUATORIAL_RADIUS*cos(LATITUDE_IN_RADIANS),2)+power(POLAR_RADIUS*sin(LATITUDE_IN_RADIANS),2),0.5)/METERS_PER_MILE;
	
	// Get the ADVO data, and pull records within the mile radius (plus our allowance)
	matching_addresses := PROJECT(Advo.Files().File_Cleaned_Base(
			(real)geo_lat between (in_latitude - (in_mile_radius / MILES_PER_DEGREE_LATITUDE)) and (in_latitude + (in_mile_radius / MILES_PER_DEGREE_LATITUDE)) and
			(real)geo_long between (in_longitude - (in_mile_radius / MILES_PER_DEGREE_LONGITUDE)) and (in_longitude + (in_mile_radius / MILES_PER_DEGREE_LONGITUDE)) and
			ut.LL_Dist((real)geo_lat,(real)geo_long,in_latitude,in_longitude) <= in_mile_radius),
		TRANSFORM(GeocodeSearch_Layouts.Address,
			SELF.geo_lat := (real)LEFT.geo_lat,
			SELF.geo_long := (real)LEFT.geo_long,
			SELF := LEFT));
	
	// Records
	matching_records := GeocodeSearch_Records(matching_addresses,temp_mod);
	
	RETURN matching_records;
	
END;
