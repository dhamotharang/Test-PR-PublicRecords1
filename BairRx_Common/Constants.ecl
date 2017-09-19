EXPORT Constants := MODULE
	EXPORT Mode := MODULE
		EXPORT STRING3 EVE := 'EVE';
		EXPORT STRING3 CFS := 'CFS';
		EXPORT STRING3 CRA := 'CRA';
		EXPORT STRING3 LPR := 'LPR';
		EXPORT STRING3 INT := 'INT';
		EXPORT STRING3 SHO := 'SHO';
		EXPORT STRING3 OFF := 'OFF';
	END;
	EXPORT SkipModeSet := MODULE
		EXPORT EVE := [Mode.CFS,Mode.CRA,Mode.LPR,Mode.INT,Mode.SHO,Mode.OFF];
		EXPORT CFS := [Mode.EVE,Mode.CRA,Mode.LPR,Mode.INT,Mode.SHO,Mode.OFF];
		EXPORT CRA := [Mode.EVE,Mode.CFS,Mode.LPR,Mode.INT,Mode.SHO,Mode.OFF];
		EXPORT LPR := [Mode.EVE,Mode.CFS,Mode.CRA,Mode.INT,Mode.SHO,Mode.OFF];
		EXPORT INT := [Mode.EVE,Mode.CFS,Mode.CRA,Mode.LPR,Mode.SHO,Mode.OFF];
		EXPORT SHO := [Mode.EVE,Mode.CFS,Mode.CRA,Mode.LPR,Mode.INT,Mode.OFF];
		EXPORT OFF := [Mode.EVE,Mode.CFS,Mode.CRA,Mode.LPR,Mode.INT,Mode.SHO];
	END;
	EXPORT SearchType := ENUM(UNSIGNED1, None=0, Event=1, CFS=2, Crash=3, LPR=4, Intel=5, ShotSpotter=6, Offender=7, MapIncident=8);
	EXPORT GeoSearchType := ENUM(UNSIGNED1, None=0, Box=1, PointRadius=2, Polygon=3);
	EXPORT NoteType := ENUM(UNSIGNED1, EventSynopsis=1, Persons=2, Vehicles=3, Dispatcher=4, CfsSynopsis=5, CrashNarrative=6, ShotIncident=7, Offender=8, IntelIncident=9, IntelEntity=10, IntelVehicle=11);
	EXPORT NoteTypeLabel(unsigned1 t) := MAP(
		t = NoteType.EventSynopsis => 'Synopsis', // event.mo.synopsis_of_crime
		t = NoteType.Persons => 'Person Notes', // event.person.persons_notes
		t = NoteType.Vehicles => 'Vehicle Notes', // event.vehicle.description
		t = NoteType.Dispatcher => 'Dispatcher Comments', // cfs.dispatcher_comments
		t = NoteType.CfsSynopsis => 'Call Synopsis', // cfs.synopsis
		t = NoteType.CrashNarrative => 'Crash Narrative', // crash.narrative
		t = NoteType.ShotIncident => 'Shot Incident Notes', // shotspotterr.shot_incident_notes
		t = NoteType.Offender => 'Offender Notes', // offender_notes
		t = NoteType.IntelIncident => 'Incident Notes', // incident_notes
		t = NoteType.IntelEntity => 'Entity Notes', // entity_notes
		t = NoteType.IntelVehicle => 'Vehicle Notes', // vehicle_notes
		'Notes'
		);
			
	EXPORT REAL MAX_RADIUS	:= 5.0;
	EXPORT REAL MIN_RADIUS	:= 0.25;
	EXPORT MAX_JOIN_LIMIT 	:= 10000;
	EXPORT MAX_GEOHASH 			:= 100000;		// geo search limit
	EXPORT MAX_PAYLOAD 			:= 50000;			// full payload for reports and search results
	EXPORT MAX_SRCH_RESULT	:= 500;				// search results
	EXPORT MAX_RPT_RESULT 	:= 100000;		// reports
	EXPORT DEFAULT_MAX_RPT_RESULT := 5000;// reports
	EXPORT MAX_SLIM_SORT		:= 750;
	EXPORT MAX_EID_SRCH_RESULTS	:= 100000;
	EXPORT ACCURACY_ADDRESS_CODE := 8;
	EXPORT ACCURACY_INTERSECTION_CODE := 7;
	EXPORT ACCURACY_STREET_CODE := 6;
	EXPORT AccuracyLabel(unsigned acc) := MAP(
		acc = ACCURACY_ADDRESS_CODE => 'Address',
		acc = ACCURACY_INTERSECTION_CODE => 'Intersection',
		acc = ACCURACY_STREET_CODE => 'Street',
		''
		);
	
	EXPORT FILTER := MODULE
			EXPORT UNSIGNED8 MaxResults 					:= 500000;
			EXPORT UNSIGNED8 MaxResultsSub				:= 2000;
			EXPORT UNSIGNED8 MaxResultsThisTime		:= 2000;
			EXPORT UNSIGNED8 SkipRecords					:= 0;
			EXPORT UNSIGNED8 MaxFocusDocs					:= 2000;
			EXPORT UNSIGNED8 MinWildArgLen				:= 2;
	END;
	
	EXPORT REAL_TO_INT_SCALE := 10000;
	EXPORT LPR_CLASS := '9999';	
	EXPORT LPR_CLASS_CODE := 600;	
	
	EXPORT LAYER := MODULE
		EXPORT UNSIGNED1 GeoJSONText := 1;
		EXPORT UNSIGNED1 WKTText 		 := 2;
	END;	
END;