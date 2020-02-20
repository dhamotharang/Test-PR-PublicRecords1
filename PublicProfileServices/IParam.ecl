import PersonReports, doxie;

EXPORT IParam := MODULE
	
	EXPORT searchParams := INTERFACE (doxie.IDataAccess, PersonReports.IParam._report)
		EXPORT STRING12  UniqueID := '';
		EXPORT STRING30  FirstName := '';
		EXPORT STRING30  MiddleName := '';
		EXPORT STRING30  LastName := '';
		EXPORT STRING11  SSN := '';
		EXPORT UNSIGNED8 DOB := 0;
		EXPORT STRING200 Addr := '';
		EXPORT STRING25  City := '';
		EXPORT STRING2   State := '';
		EXPORT STRING6   Zip := '';
		EXPORT BOOLEAN   IncludeSSN := TRUE;
		EXPORT BOOLEAN   IncludeAddress := TRUE;
		EXPORT BOOLEAN   IncludeNameSSN := TRUE;
		EXPORT BOOLEAN   IncludeNameDOB := TRUE;
		EXPORT BOOLEAN   IncludeNameAddress := TRUE;
		EXPORT BOOLEAN   IncludeCombination := TRUE;
		EXPORT BOOLEAN   IncludeFootPrint := TRUE;
		EXPORT BOOLEAN   UseTestData := FALSE;

    // I need to keep those here temporarily, till all person reports compoenents are switched to IDataAccess;
    // (ignores will be moved to Property interface at that time, where they do belong to).
    export boolean ignoreFares := false;
    export boolean ignoreFidelity:= false;
	END;
	
END;
