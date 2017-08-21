IMPORT tools;

////////////////////////////////////////////////////////////////////////////////////////////////
// The purpose of this attribute is to try to catch some cases, where it's fairly obvious that
// facility_name and facility_name2 should be concatinated together, to make what should've
// been just in facility_name to begin with.
////////////////////////////////////////////////////////////////////////////////////////////////
EXPORT Standardize_Facility_Name(DATASET(Layouts.Base) pRawFileInput) := FUNCTION

  // We currently don't need the add_space parameter, but you never know about future cases
  Combine_Strings(STRING in_string1, STRING in_string2, BOOLEAN add_space = TRUE) := FUNCTION
    RETURN in_string1 + IF(add_space, ' ', '') + in_string2;
  END;

  Create_New_Facility_Name(STRING in_facility_name, STRING in_facility_name2) := FUNCTION
	  RETURN MAP(in_facility_name2 IN ['INC', 'LLC', 'PLLC'] => Combine_Strings(in_facility_name,
		                                                                          in_facility_name2),
		           in_facility_name);
	END;

	Layouts.Base tPreProcessRecords(Layouts.Base L) := TRANSFORM
	  clean_facility_name := TRIM(L.facility_name, LEFT, RIGHT);
	  clean_facility_name2 := TRIM(L.facility_name2, LEFT, RIGHT);
		new_facility_name := Create_New_Facility_Name(clean_facility_name, clean_facility_name2);

		SELF.facility_name := new_facility_name;
		// If we've combined the facility names, we need to clear out this attribute.
		SELF.facility_name2 := IF(clean_facility_name != new_facility_name, '', L.facility_name2);

		SELF := L;
	END;

	RETURN PROJECT(pRawFileInput, tPreProcessRecords(LEFT));

END;