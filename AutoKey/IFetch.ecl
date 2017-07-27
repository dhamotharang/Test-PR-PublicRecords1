IMPORT doxie;

// Defines standard "parent" for fetching person's autokeys; 
// modules implementing this interface may override any of these calls, expand functionality, etc.
EXPORT IFetch := INTERFACE

  export Fetch_SSN (STRING t, boolean workHard, boolean nofail = true,boolean useAllLookups = false)
      := autokey.Fetch_SSN (t, workHard, nofail, useAllLookups);
  export Fetch_Phone (STRING t,boolean nofail =true,boolean useAllLookups = false)
      := autokey.Fetch_Phone (t, nofail, useAllLookups);
  export Fetch_Address(STRING t, boolean workHard,boolean noFail = true)
      := autokey.Fetch_Address (t, workHard, nofail);
  export Fetch_Zip(STRING t, boolean workHard, boolean noFail = true)
      := autokey.Fetch_Zip (t, workHard, nofail);
  export Fetch_Name(STRING t, boolean workHard,boolean nofail = true)
      := autokey.Fetch_Name (t, workHard, nofail);
  export Fetch_StFLName(STRING t, boolean workHard,boolean nofail =true)
      := autokey.Fetch_StFLName (t, workHard, nofail);
  export Fetch_StCityFLName(STRING t, boolean workHard,boolean nofail =true)
      := autokey.Fetch_StCityFLName (t, workHard, nofail);
	export Fetch_ZipPRLName(STRING t, boolean workHard, boolean noFail = true)
      := autokey.Fetch_ZipPRLName (t, workHard, nofail);
	
	export Fetch_Custom1(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokey.layout_fetch);
	export Fetch_Custom2(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokey.layout_fetch);
	export Fetch_Custom3(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokey.layout_fetch);
	export Fetch_Custom4(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokey.layout_fetch);
	export Fetch_Custom5(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokey.layout_fetch);
END;