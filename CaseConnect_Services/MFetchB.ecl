IMPORT autokey, autokeyB;

EXPORT MFetchB := MODULE (autokeyB.IFetch)
  export Fetch_FEIN (STRING t, boolean workHard, boolean nofail = true, boolean useAllLookups = false)
      := CaseConnect_Services.FetchBizFEIN (t, nofail);
  export Fetch_Phone (STRING t,boolean nofail =true,boolean useAllLookups = false)
       := CaseConnect_Services.FetchBizPhone (t, nofail);
  export Fetch_Address(STRING t, boolean workHard,boolean noFail = true, boolean useAllLookups = false)				
       := CaseConnect_Services.FetchBizAddress (t, workHard, nofail);
  export Fetch_Zip(STRING t, boolean workHard, boolean noFail = true, boolean useAllLookups = false,
					 set of string1 get_skip_set=[])
       := CaseConnect_Services.FetchBizZip (t, nofail, get_skip_set);
  export Fetch_Name(STRING t, boolean workHard,boolean nofail = true, boolean useAllLookups = false)
      := CaseConnect_Services.FetchBizName (t, nofail);
  export Fetch_StName (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false)
       := CaseConnect_Services.FetchBizStName (t, nofail);
  export Fetch_StCityFLName (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false,
					 set of string1 get_skip_set=[])
       := CaseConnect_Services.FetchBizStCityName (t, workHard, nofail, get_skip_set);
  export Fetch_NameWords (STRING t, boolean workHard,boolean nofail =true, boolean useAllLookups = false)
       := CaseConnect_Services.FetchBizNameWords (t, nofail);
END;