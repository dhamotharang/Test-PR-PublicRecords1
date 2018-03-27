IMPORT FAA;

EXPORT Layouts := MODULE

// in faa.Aircraft_In_Allsrc - I see THREE base files
	EXPORT AlphaBase := RECORD
		STRING UNKNOWN_LAYOUT;
	END;
	EXPORT AlphaBase_Engine := FAA.layouts.aircraft_raw.engine;
	EXPORT AlphaBase_Master := FAA.layouts.aircraft_raw.master;
	EXPORT AlphaBase_ACFT := FAA.layouts.aircraft_raw.acft;

// HOWEVER - unless it is IMPOSSIBLE, we want to join these into a single spreadsheet coming in.
	// EXPORT AlphaBase := UNKNOWN_LAYOUT;
// If the boca build needs THREE files, we'll have to distribute the fields into three	files
// IF Boca does NOT need three files, we need to emulate what it has as a base file.
// check out faa.layouts and other code there.
	
/*  NOTES TO TEAM
If you have to start with a payload layout and add missing fields it might look like this

	export AlphaBaseInCommon := RECORD
		Phonesplus_v2.Layout_Phonesplus_Base;
		Unsigned8		someOtherField := 0;
		Unsigned8   yetAnotherField := 0;
		boolean     someBoolean := 0;
		STRING25	   	someStringField := '';
	END;
*/
END;