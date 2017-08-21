import Bair, bair_importer;

EXPORT Queries := Module 
	EXPORT WhyMOisQuarantined(unsigned pOri, string pIRNumber) := FUNCTION
		x := dataset('~thor_data400::in::prepped::event::dbo::mo::built',bair.layouts.event_dbo_mo_In,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])))(ori = pOri and ir_number = pIRNumber);
		x;

		dpl := Bair.files().DataProviderLoc_Base.built(dataProviderID = (unsigned4) x[1].ori);

		output(dpl[1].BoundingBoxSouthWestLong + ' >= ' + x[1].x_coordinate +  ' <= ' + dpl[1].BoundingBoxNorthEastLong + ' | ' + dpl[1].BoundingBoxSouthWestLat +  ' >= ' + x[1].y_coordinate + ' <= ' + dpl[1].BoundingBoxNorthEastLat);
												
		//pORI 					:= (unsigned4)x[1].ori;
		pFirstDate 		:= x[1].first_date;
		pLastDate 		:= x[1].last_date;
		pFirstTime 		:= x[1].first_time;
		pLastTime 		:= x[1].first_time;
		pAddress 			:= x[1].address_of_crime;
		X_Coordinate 	:= (unsigned4)x[1].x_coordinate;
		Y_Coordinate 	:= (unsigned4)x[1].y_coordinate;
		pBoundingboxsouthwestlat 	:= (real8) dpl[1].Boundingboxsouthwestlat;
		pBoundingboxsouthwestlong := (real8) dpl[1].Boundingboxsouthwestlong;
		pBoundingboxnortheastlat 	:= (real8) dpl[1].Boundingboxnortheastlat;
		pBoundingboxnortheastlong := (real8) dpl[1].boundingboxnortheastlong;
		pAccuracy := 8;
		pCode := true; 

		quarantined := bair_importer.validate_input.QuarantineMo(pORI,  pFirstDate,  pLastDate,  pFirstTime,  pLastTime,  pAddress, X_Coordinate,  Y_Coordinate, pBoundingboxsouthwestlat,  pBoundingboxsouthwestlong,  pBoundingboxnortheastlat,  pBoundingboxnortheastlong,  pAccuracy,  pCode);

		quarantined_desc := case(quarantined, 
		'1'=>'First Date time and time missing',
		'2'=>'Unknown geocoding error',
		'3'=>'Low Accuracy',
		'4'=>'Invalid date string',
		'5'=>'First Date Time after Last Date Time',
		'6'=>'Future Last Date',
		'7'=>'Future Last Date Time',
		'8'=>'Invalid time string',
		'9'=>'Excessive intersection offset distance',
		'10'=>'Missing address',
		'11'=>'Last Date Time before 1900',
		'12'=>'Unknown addresss',
		'13'=>'Out of bounds',
		'14'=>'Entire ORI-IR set quarantined',
		'15'=>'First Date after Last Date',
		'16'=>'First Date Time before 1900',
		'17'=>'Future First Date Time',
		'18'=>'First Date time did not match date and time',
		'19'=>'Entire ORI-IR set quarantined',
		'20'=>'Entire ORI-IR set quarantined',
		'');

		return quarantined_desc;
	END;

	// EXPORT WhyCFSisQuarantined(unsigned pOri, string pIRNumber) := FUNCTION
		// x := dataset('~thor_data400::in::prepped::event::dbo::mo::built',bair.layouts.event_dbo_mo_In,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])))(ori = pOri and ir_number = pIRNumber);
		// x;

		// dpl := Bair.files().DataProviderLoc_Base.built(dataProviderID = (unsigned4) x[1].ori);

		// output('Boundingboxsouthwestlat: ' + dpl[1].Boundingboxsouthwestlat + ' | Boundingboxsouthwestlong: ' + dpl[1].Boundingboxsouthwestlong + ' | Boundingboxnortheastlat: ' + dpl[1].Boundingboxnortheastlat + '| boundingboxnortheastlong: ' + dpl[1].boundingboxnortheastlong);

		// pDateTimeReceived
		// pInitialType
		// pDateTimeDispatched
		// pDateTimeEnroute
		// pDateTimeArrived
		// pDateTimeCleared
		// pUnit
		// pOfficerName
		// pAddress 			:= x[1].address_of_crime;
		// X_Coordinate 	:= (unsigned4)x[1].x_coordinate;
		// Y_Coordinate 	:= (unsigned4)x[1].y_coordinate;
		// pBoundingboxsouthwestlat 	:= (real8) dpl[1].Boundingboxsouthwestlat;
		// pBoundingboxsouthwestlong := (real8) dpl[1].Boundingboxsouthwestlong;
		// pBoundingboxnortheastlat 	:= (real8) dpl[1].Boundingboxnortheastlat;
		// pBoundingboxnortheastlong := (real8) dpl[1].boundingboxnortheastlong;
		// pAccuracy := 8;
		// pCode := true; 

		// quarantined := QuarantineCFS( pORI,  pDateTimeReceived, pInitialType, pDateTimeDispatched,  pDateTimeEnroute,  pDateTimeArrived,  pDateTimeCleared,  pUnit,  pOfficerName,  pAddress,  X_Coordinate,  Y_Coordinate,  pBoundingboxsouthwestlat,  pBoundingboxsouthwestlong,  pBoundingboxnortheastlat,  pBoundingboxnortheastlong,  pAccuracy,  pCode) 

		// quarantined_desc := case(quarantined, 
		// '1'=>'First Date time and time missing',
		// '2'=>'Unknown geocoding error',
		// '3'=>'Low Accuracy',
		// '4'=>'Invalid date string',
		// '5'=>'First Date Time after Last Date Time',
		// '6'=>'Future Last Date',
		// '7'=>'Future Last Date Time',
		// '8'=>'Invalid time string',
		// '9'=>'Excessive intersection offset distance',
		// '10'=>'Missing address',
		// '11'=>'Last Date Time before 1900',
		// '12'=>'Unknown addresss',
		// '13'=>'Out of bounds',
		// '14'=>'Entire ORI-IR set quarantined',
		// '15'=>'First Date after Last Date',
		// '16'=>'First Date Time before 1900',
		// '17'=>'Future First Date Time',
		// '18'=>'First Date time did not match date and time',
		// '19'=>'Entire ORI-IR set quarantined',
		// '20'=>'Entire ORI-IR set quarantined',
		// '');

		// return quarantined_desc;
	// END;


END;

