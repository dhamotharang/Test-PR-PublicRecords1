IMPORT autokey;

EXPORT MFetch := MODULE (autokey.IFetch)
  	
	export Fetch_SSN (STRING t, boolean workHard, boolean nofail = true,boolean useAllLookups = false)
      := CaseConnect_Services.FetchSSN(t, workHard, nofail);			
  export Fetch_Phone (STRING t,boolean nofail =true,boolean useAllLookups = false)
      := CaseConnect_Services.FetchPhone(t, nofail);
  export Fetch_Address(STRING t, boolean workHard,boolean noFail = true)
      := CaseConnect_Services.FetchAddress (t, workHard, nofail);
  export Fetch_Zip(STRING t, boolean workHard, boolean noFail = true)
      := CaseConnect_Services.FetchZip (t, workHard, nofail);
  export Fetch_Name(STRING t, boolean workHard,boolean nofail = true) := 
		CaseConnect_Services.FetchName (t, workHard, noFail);  
  export Fetch_StFLName(STRING t, boolean workHard,boolean nofail = true) := 
		CaseConnect_Services.FetchStName (t, workHard, noFail);  
  export Fetch_StCityFLName(STRING t, boolean workHard,boolean nofail =true)
      := CaseConnect_Services.FetchStCityName (t, workHard, nofail);
	export Fetch_ZipPRLName(STRING t, boolean workHard, boolean noFail = true)
      := CaseConnect_Services.FetchZipPRLname (t, workHard, nofail);	
	
END;