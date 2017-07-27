IMPORT autokeyB;

EXPORT MFetchB := MODULE (autokeyB.IFetch)
  export Fetch_Zip (STRING t, boolean workHard, boolean noFail = true, boolean useAllLookups = false,set of string1 get_skip_set=[]) := CAN_PH.Fetch_ZipB (t, workHard, noFail,useAllLookups,get_skip_set);
  export Fetch_Address (string t, boolean workHard, boolean noFail = true, boolean useAllLookups = false) := CAN_PH.Fetch_AddressB (t, workHard, noFail,useAllLookups);
END;