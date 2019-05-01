import PersonReports;

EXPORT IParam := MODULE
	
	EXPORT searchParams := INTERFACE (PersonReports.IParam._report)
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
	END;
	
END;
