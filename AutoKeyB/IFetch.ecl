IMPORT doxie,autokeyb2;

// Defines standard "parent" for fetching business's autokeys; 
// modules implementing this interface may override any of these calls, expand functionality, etc.
EXPORT IFetch := INTERFACE

  export Fetch_FEIN (STRING t, boolean workHard, boolean nofail = true, boolean useAllLookups = false)
      := autokeyb.Fetch_FEIN (t, workHard, nofail, useAllLookups);
  export Fetch_Phone (STRING t,boolean nofail =true,boolean useAllLookups = false)
      := autokeyb.Fetch_Phone (t, nofail, useAllLookups);
  export Fetch_Address(STRING t, boolean workHard,boolean noFail = true, boolean useAllLookups = false)
      := autokeyb.Fetch_Address (t, workHard, nofail, useAllLookups);
  export Fetch_Zip(STRING t, boolean workHard, boolean noFail = true, boolean useAllLookups = false,
					set of string1 get_skip_set=[])
      := autokeyb.Fetch_Zip (t, workHard, nofail, useAllLookups,get_skip_set);
  export Fetch_Name(STRING t, boolean workHard,boolean nofail = true, boolean useAllLookups = false)
      := autokeyb.Fetch_Name (t, workHard, nofail, useAllLookups);
  export Fetch_StName (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false)
      := autokeyb.Fetch_StName (t, workHard, nofail, useAllLookups);
  export Fetch_StCityFLName (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false,
					set of string1 get_skip_set=[])
      := autokeyB.Fetch_StCityFLName (t, workHard, nofail, useAllLookups,get_skip_set);
  export Fetch_NameWords (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false)
      := autokeyB.Fetch_NameWords (t, workHard, nofail, useAllLookups);

	export Fetch_Custom1(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokeyb2.layout_fetch);
	export Fetch_Custom2(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokeyb2.layout_fetch);
	export Fetch_Custom3(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokeyb2.layout_fetch);
	export Fetch_Custom4(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokeyb2.layout_fetch);
	export Fetch_Custom5(STRING t, boolean workHard, boolean noFail = true) 
			:= dataset([], autokeyb2.layout_fetch);
END;
