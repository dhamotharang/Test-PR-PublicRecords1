IMPORT PRTE2_Common;

// Removed this code from PRTE2_Foreclosure.NEW_Proc_Build_Autokeys version 5.08 hit errors with this in there.
// and I don't think it needs to be run again unless an environment is new and these don't exist.
EXPORT x_fn_create_superfiles := FUNCTION
			inkeyQA := files.keyBuildInkey+'QA::';
			inkeyBuilt := files.keyBuildInkey+'BUILT::';
			inkeyFather := files.keyBuildInkey+'FATHER::';
			inkeyGrandF := files.keyBuildInkey+'GRANDFATHER::';
			SHARED performAllClearOrCreate(STRING name) := FUNCTION
					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyQA + name));
					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyBuilt + name));
					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyFather + name));
					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyGrandF + name));
					return true;
			END;
			
			performAllClearOrCreate('Payload');
			performAllClearOrCreate('AddressB2');
			performAllClearOrCreate('CityStNameB2');
			performAllClearOrCreate('NameB2');
			performAllClearOrCreate('StNameB2');
			performAllClearOrCreate('ZipB2');
			performAllClearOrCreate('NameWords2');
			performAllClearOrCreate('Address');
			performAllClearOrCreate('CityStName');
			performAllClearOrCreate('Name');
			performAllClearOrCreate('StName');
			performAllClearOrCreate('Zip');
			performAllClearOrCreate('NameWords2');
			performAllClearOrCreate('SSN2');
	RETURN true;
END;