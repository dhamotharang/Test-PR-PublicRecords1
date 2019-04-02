export Constants := module
	
	export 	LIMIT_DIDS_PER_SEQ	:= 3000;
	export 	MAX_RES_PER_SEQ			:= 100;

	// Certain generic search options (must be a bitmask)
  export SearchCode := module
    export integer NOFAIL := 1;
    export integer ALLOW_WILDCARD := 2; // TODO: add to the library input layout before full recompile
    export integer PRESERVE_SEQUENCE := 4; // TODO: add to the library input layout before full recompile
			export integer CURRENT_RESIDENTS := 8;		
  end;
	
	export SearchCodeDescription := module
    export string NOFAIL := 'NOFAIL';
    export string ALLOW_WILDCARD := 'ALLOW_WILDCARD';
  end;
	
  //corresponds to fetch_x -- a particular fetch function.
  //A constant for a top-level main fetch may be nice to have, for completeness.
  export FetchHit := module
    export integer NOT_IMPLEMENTED := -1;
    //header indices:
    export unsigned RID          :=     1;        //AutoHeaderI.FetchI_Hdr_Indv_RID
    export unsigned DID          :=     2;        //AutoHeaderI.FetchI_Hdr_Indv_DID
    export unsigned SSN          :=     4;        //AutoHeaderI.FetchI_Hdr_Indv_SSN
    export unsigned ADDRESS      :=     8;        //AutoHeaderI.FetchI_Hdr_Indv_Address
    export unsigned NAME         :=    16;        //AutoHeaderI.FetchI_Hdr_Indv_Name
    export unsigned STNAME       :=    32;        //AutoHeaderI.FetchI_Hdr_Indv_StName
    export unsigned PHONE        :=    64;        //AutoHeaderI.FetchI_Hdr_Indv_Phone
    export unsigned ZIP          :=   128;        //AutoHeaderI.FetchI_Hdr_Indv_Zip
    export unsigned DOBNAME      :=   512;        //AutoHeaderI.FetchI_Hdr_Indv_DOBName
    export unsigned DA           :=  1024;        //AutoHeaderI.FetchI_Hdr_Indv_DA
    export unsigned DOBFNAME     := 1<<13;        //AutoHeaderI.FetchI_Hdr_Indv_DOBFname
    export unsigned STREET       := 1<<14;        //AutoHeaderI.FetchI_Hdr_Indv_Street
    export unsigned ZIP_PRLNAME  := 1<<15;        //AutoHeaderI.FetchI_Hdr_Indv_ZipPRLname //FEDEX, using autokeyi.FetchI_Indv_ZipPRLname
    export unsigned FNAMESMALL   := 1<<16;        //AutoHeaderI.FetchI_Hdr_Indv_FnameSmall
    export unsigned STCITYNAME   := 1<<17;        //AutoHeaderI.FetchI_Hdr_Indv_StCityName
    export unsigned SSN_PARTIAL  :=   256;        //AutoHeaderI.FetchI_Hdr_Indv_SSNPartial
    export unsigned STNAMESMALL  := 1<<18;        //AutoHeaderI.FetchI_Hdr_Indv_StNameSmall

    export unsigned W_ADDRESS     := 1<<19;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_Address
    export unsigned W_FNAMESMALL  := 1<<20;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_FnameSmall
    export unsigned W_NAME        := 1<<21;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_Name
    export unsigned W_PHONE       := 1<<22;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_Phone
    export unsigned W_SSN         := 1<<23;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_SSN
    export unsigned W_SSN_PARTIAL := 1<<24;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_SSNPartial
    export unsigned W_STCITYNAME  := 1<<25;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_StCityName
    export unsigned W_STNAME      := 1<<26;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_StName
    export unsigned W_STNAMESMALL := 1<<27;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_StNameSmall
    export unsigned W_STREET      := 1<<28;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_Street
    export unsigned W_ZIP         := 1<<29;        //AutoHeaderI.FetchI_Hdr_Indv_Wild_Zip
		export unsigned SALT				  := 1<<31;				 //AutoHeaderV2.fetch_SALT
		
		export unsigned SSN_TRANSPOSITION := 1<<30;    // transposition of adjacent digits in SSN

    export unsigned HH           :=  2048; // household
    export unsigned QUICK_SSN    :=  4096; // ssn quick header

    // At this point, generic: either util, or Gong, or quick header
    export unsigned QUICK_HEADER := 1 << 39;

    // Some searches may be done outside of a header file, 
    // but there's no reason we cannot share same constants' definitions
    export unsigned DL            := 1<<40;        // DL search key 
  end;

  // Not clear if we need codes for individual index hits
  export IndexHit := module
    //header indices:
    export unsigned RID             :=     1;      //doxie.key_header_rid
    export unsigned DID             :=     2;      //Doxie.Key_Did_Rid2
    export unsigned SSN             :=     4;      //doxie.key_header_SSN
    export unsigned ADDRESS         :=     8;      //doxie.key_address
    export unsigned NAME            :=    16;      //doxie.key_header_Name
    export unsigned STFNAMELNAME    :=    32;      //doxie.key_header_StFnameLname
    export unsigned PHONE           :=    64;      //doxie.key_header_phone
    export unsigned PIZ             :=   128;      //doxie.key_header_Piz
    export unsigned DOB             :=   256;      //doxie.key_header_DOBName
    export unsigned DA              :=   512;      //doxie.key_header_DA
    export unsigned DOBF            :=  1024;      //doxie.key_header_Dob_Fname
    export unsigned STREETZIPNAME   := 1<<11;      //doxie.key_header_StreetZipName
      //export unsigned ZIP_PRLname   := 1<<12; FEDEX, using autokeyi.FetchI_Indv_ZipPRLname
    export unsigned FNAMESMALL      := 1<<13;      //doxie.key_header_FnameSmall
    export unsigned STCITYLFNAME    := 1<<14;      //doxie.key_header_StCityLFName

    export unsigned DOB_PFNAME      := 1<<17;      //doxie.key_header_Dob_PFname
    export unsigned DTS_FNAMESMALL  := 1<<18;      //doxie.key_header_DTS_FnameSmall
    export unsigned NAME_ALT        := 1<<19;      //doxie.key_header_Name_alt
    export unsigned DTS_ADDRESS     := 1<<20;      //doxie.key_header_DTS_Address
    export unsigned DTS_STREETZIPNAME := 1<<21;      //doxie.key_header_DTS_StreetZipName

    export unsigned W_SSN           := 1<<22;      //doxie.key_header_Wild_SSN
    export unsigned W_ADDRESS       := 1<<23;      //doxie.key_header_Wild_Address
    export unsigned W_NAME          := 1<<24;      //doxie.key_header_Wild_Name
    export unsigned W_STFNAMELNAME  := 1<<25;      //doxie.key_header_Wild_StFnameLname
    export unsigned W_PHONE         := 1<<26;      //doxie.key_header_Wild_Phone
    export unsigned W_ZIP           := 1<<27;      //doxie.key_header_Wild_Zip
    export unsigned W_STREETZIPNAME := 1<<28;      //doxie.key_header_Wild_StreetZipName
    export unsigned W_FNAMESMALL    := 1<<29;      //doxie.key_header_Wild_FnameSmall
    export unsigned W_STCITYLFNAME  := 1<<30;      //doxie.key_header_Wild_StCityLFName

    export unsigned SSN4            := 1<<15;      //doxie.key_header_SSN4
    export unsigned SSN5            := 1<<16;      //doxie.key_header_SSN5
    export unsigned QUICK_SSN := 4096;
    export unsigned HH        := 2048;

  end;
	
  // Status provides primitive diagnostics for the search results.
  export STATUS := module
    export unsigned _OK := 0; //default: search has been executed without issues
    export unsigned _DATA := 1; // not enough data to execute a search in a given Fetch
    export unsigned _NOT_FOUND := 2; // Fetch was executed, no DIDs were found
    export unsigned _SKIP := 3; //reserved
    export unsigned _FAIL := 4; //reserved
    export unsigned _MNAME := 5; // specifies that "middle name" message should be returned to a customer.
    export unsigned _BEST := 6; // best DID has been choosen 
  end;


  // Utility function for printing out code values and descriptions	
	export PrintCodes() := function
		code_layout := record
			integer code;
			string code_description;
			string description;
		end;
		ds_fetchcodes := dataset([{FetchHit.RID, 'RID', ''},
															{FetchHit.DID, 'DID', ''},
															{FetchHit.SSN, 'SSN', ''}, 
															{FetchHit.ADDRESS, 'ADDRESS', ''},
															{FetchHit.NAME, 'NAME', ''},
															{FetchHit.STNAME, 'STNAME', ''},
															{FetchHit.PHONE, 'PHONE', ''},
															{FetchHit.ZIP, 'ZIP', ''},
															{FetchHit.SSN_PARTIAL, 'SSN_PARTIAL', ''},
															{FetchHit.DOBNAME, 'DOBNAME', ''},
															{FetchHit.DA, 'DA', ''},
															{FetchHit.HH, 'HH', ''},
															{FetchHit.QUICK_SSN, 'QUICK_SSN', ''},
															{FetchHit.DOBFNAME, 'DOBFNAME', ''},
															{FetchHit.STREET, 'STREET', ''},
															{FetchHit.ZIP_PRLNAME, 'ZIP_PRLNAME', ''},
															{FetchHit.FNAMESMALL, 'FNAMESMALL', ''},
															{FetchHit.STCITYNAME, 'STCITYNAME', ''},
															{FetchHit.W_ADDRESS, 'W_ADDRESS', ''},
															{FetchHit.W_FNAMESMALL, 'W_FNAMESMALL', ''},
															{FetchHit.W_NAME, 'W_NAME', ''},
															{FetchHit.W_PHONE, 'W_PHONE', ''},
															{FetchHit.W_SSN, 'W_SSN', ''},
															{FetchHit.W_SSN_PARTIAL, 'W_SSN_PARTIAL', ''},
															{FetchHit.W_STCITYNAME, 'W_STCITYNAME', ''},
															{FetchHit.W_STNAME, 'W_STNAME', ''},
															{FetchHit.W_STNAMESMALL, 'W_STNAMESMALL', ''},
															{FetchHit.W_STREET, 'W_STREET', ''},
															{FetchHit.W_ZIP, 'W_ZIP', ''}
															], code_layout);
		
		ds_indexcodes := dataset([{IndexHit.HH, 'HH', ''},
															{IndexHit.QUICK_SSN, 'QUICK_SSN', ''},
															{IndexHit.SSN4, 'SSN4', ''},
															{IndexHit.SSN5, 'SSN5', ''}
															], code_layout);
		
		ds_statuscodes := dataset([{STATUS._OK, 'OK', 'Search has been executed without issues'},
															{STATUS._DATA, 'DATA', 'Not enough data to execute a search in a given Fetch'},
															{STATUS._NOT_FOUND, 'NOT_FOUND', 'Fetch was executed, no DIDs were found'}, 
															{STATUS._SKIP, 'SKIP', 'Reserved: Fetch results were discarded (too many)'},
															{STATUS._FAIL, 'FAIL', 'Reserved: Fetch indicates a failure (too many)'},
															{STATUS._MNAME, 'REMOVE MIDDLE NAME', 'Specifies that "middle name" message should be returned to a customer'}
															], code_layout);
    return sequential (
      output(ds_fetchcodes, named('FetchHitCodes')),
      output(ds_indexcodes, named('IndexHitCodes')),
      output(ds_statuscodes, named('StatusCodes')));
	end;

  export string RemoteSearchServiceName := 'AutoheaderV2.LexIDSearchService';
  export string SearchLibraryName := 'AutoheaderV2.LIB_header';	
  export string SearchSALTLibraryName := 'AutoheaderV2.LIB_header_SALTPlus';
  export unsigned1 SaltLeadThreshold := 15; // default is no threshold
		
		EXPORT LibVersion := module
			EXPORT integer LEGACY := 0;
			EXPORT integer SALT := 1;
		END;
end;