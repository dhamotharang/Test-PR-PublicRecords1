import doxie, AutoStandardI, Address, Suppress;

export layouts := module

  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  //  Search records definitions (define cleaned user's input)
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  export _ssn := record
    string9 ssn := '';
    set of string9 ssn_set {maxcount (82)} := []; //    derived

    //? do the following belong here or to a "general" options?
    boolean fuzzy_ssn := false;                   // 'SSNTypos'
    boolean partial_ssn := false;                 // 'UseSSNFallBack'
    boolean only_good_ssn := false;               // 'SearchGoodSSNOnly'
    boolean keep_old_ssn := false;                // ~'UsingKeepSSNs' or 'KeepOldSsns' //not needed, if prunning is done externally
  end;

  export _name := record
    string20 fname := '';
    string20 mname := '';
    string20 lname := '';
    set of string20 fname_set {maxcount (10)} := [];   //    derived
    set of string20 lname_set {maxcount (10)} := [];   //    derived
    set of string6 lname_set_phonetic {maxcount (10)} := []; //    derived
    string20 fname_rel_1 := '';                        // 'RelativeFirstName1' ('RelativeFirstName2')
    string20 fname_rel_2 := '';                        // 'RelativeFirstName2' ('RelativeFirstName1')
    string20 lname_other := '';                        // 'OtherLastName1'
    string4 lname4 := '';                              // 'Lname4'
    string3 fname3 := '';                              // 'Fname3'
				
    //? do the following belong here or to a "general" options?
    boolean nicknames := false;                        // 'AllowNickNames' ('StrictMatch')
    boolean phonetic := false;                         // 'PhoneticMatch' ('StrictMatch')
    boolean phonetic_distance := false;                // 'PhoneticDistanceMatch'
    integer distance_threshold := 3;                   // 'DistanceThreshold'
    boolean leading_name_match := false;               // 'BpsLeadingNameMatch'
    boolean allow_leading_name_match := false;         // 'AllowLeadingLname'
    boolean check_name_variants := false;              // 'CheckNameVariants'
  end;

//?   should zip5 be included or zip set is enough?
  export _address := record
    // only "cleaned" address fields used for searching
    string10 prim_range := '';
    string28 prim_name := '';
    string8 sec_range := '';
    string5 zip5 := '';
    string25 city := '';
    string2 state := '';
    string30 county := ''; //? it is strange that 'County' is present among search criteria

    string2 state_prev_1 := '';                    // 'OtherState1'
    string2 state_prev_2 := '';                    // 'OtherState2'
    string25 city_other := '';                     // 'OtherCity1'
    set of integer4 zip_set := [];                 //    derived //aka "zip_value"
    unsigned1 zip_radius := 0;                     // 'ZipRadius' ('StrictMatch')

    boolean allow_dateseen := false;               // 'AllowDateSeen'
    unsigned date_firstseen := 0;                  // 'DateFirstSeen'
    unsigned date_lastseen := 0;                   // 'DateLastSeen'
    integer sec_range_fuzziness := AutoStandardI.Constants.SECRANGE.EXACT; // 'FuzzySecRange'

    set of string10 prim_range_set := [];          //    derived, but heavy
    unsigned prange_beg := 0;                      //    derived
    unsigned prange_end := 0;                      //    derived
    string prange_wild := '';                      //    derived
    boolean _range := false;                       //    derived
    boolean _wild := false;                        //    derived

    string4 err := '';
	end;

  export _phone := record
    string10 phone10 := '';                          // 'Phone'
  end;

  export _dob := record
    integer dob := 0;                          // 'DOB'
    unsigned1 agelow := 0;                     // 'AgeLow'
    unsigned1 agehigh := 0;                    // 'AgeHigh'
    // lower and upper bounds for the DOBs; either 
    //  a) calculated according to agelow/agehigh and have Jan 1st, Dec 31st OR
    //  b) equals to input DOB, if provided (in which case they may have 0000 as a month/day)
		unsigned8 dob_low := 0;                    //    derived
		unsigned8 dob_high := 0;                   //    derived
    boolean fuzzy_dob := true;                 // 'AllowFuzzyDOBMatch' // used only in DOBFname-fetch
  end;


  // Most likely those can be search "global" options, in which case it'd be better to pack them into the module.
  // Easy to do, if needed.
  export directives := record
    unsigned1 score_threshold := 10;           // 'ScoreThreshold' ('StrictMatch')
    unsigned1 saltLeadThreshold := AutoHeaderV2.Constants.SaltLeadThreshold;
    boolean isCRS := false;                    // 'IsCRS' // TODO: needs renaming
    boolean only_best_did := false;            // 'useOnlyBestDID'
    boolean household := false;                // 'Household' or set up by caller 
    boolean include_minors := false;           // 'IncludeMinors' OR glb=2  (one field instead of two)                  
    boolean ln_branded := false;               // 'LnBranded' // TODO: consider getting rid of it
    boolean nonexclusion := false;             // 'NonExclusion' ('StrictMatch')
    boolean SearchIgnoresAddressOnly := false; // 'SearchIgnoresAddressOnly'
  	//NB: one field, instead of two: is_wildcard_search, allow_wildcard_val
    boolean wildcard := false;                 // 'AllowWildcard' (thorlib.getenv, wild: lname, fname, addr, pname)
		boolean strict_match := false;             // 'StrictMatch', 'OnlyExactMatches'
    unsigned4 _lookup := 0;                    //    derived: LookupType, SimplifiedContactReturn, ExcludeLessors,
                                               //             PartyType, company name, fein
  end;


  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  //  Library interface
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // Flat representation of a module currently passed into the library
  // Maximum unprocessed fields currently used by InterfaceTranslator to derive cleaned fields for library search
  // defaults "should be" defined as in AutoStandardI/GlobalModule
  export unprocessed_input := record
		integer seq := 0;
		//DID and RID
		string14 did := '';
		string14 rid := '';
		//SSN
		string11 ssn := '';
		string32 ApplicationType := Suppress.Constants.ApplicationTypes.DEFAULT;
		boolean ssntypos := false;
		boolean UseSSNFallBack := false;
		boolean searchgoodssnonly := false;
		//NAME
		string30 firstname := '';
		string120 unparsedfullname := '';
		//boolean cleanfmlname := false; //not sure if this one can be deprecated
		string30 middlename := '';
		string30 lastname := '';
		boolean checknamevariants := false;
		boolean phoneticdistancematch := false;
		string30 relativefirstname1 := '';
		string30 relativefirstname2 := '';
		string30 otherlastname1 := '';
		string4 lname4 := '';
		string3 fname3 := '';
		boolean allownicknames := false;
		boolean phoneticmatch := false;
		boolean BPSLeadingNameMatch := false;
		boolean AllowLeadingLname := false;
		unsigned1 distancethreshold := 3;
		//ADDRESS
		string200 addr := '';
		string25 city := '';
		string50 statecityzip := '';
		string2 state := '';
		string5 zip := '';
		boolean isPRP := false;
		string10 primrange := '';
		string28 primname := '';
		string8 secrange := '';
		string30 county := '';
		string2 otherstate1 := '';
		string2 otherstate2 := '';
		string25 othercity1 := '';
		unsigned2 zipradius := 0;
		unsigned2 mileradius := 0;
		boolean allowdateseen := false;
		unsigned datefirstseen := 0;
		unsigned datelastseen := 0;
		integer	FuzzySecRange := AutoStandardI.Constants.SECRANGE.EXACT;
		//PHONE
		string15 phone := '';
		//DOB
		unsigned8 dob := 0;
		unsigned1 agelow := 0;
		unsigned1 agehigh := 0;
		boolean AllowFuzzyDOBMatch := true;
		//OPTIONS
		unsigned1 scorethreshold := 10;
		boolean StrictMatch := false; // one field: OnlyExactMatches is not needed
		boolean isCRS := false;
		boolean useonlybestdid := false;
		boolean household := false;
		boolean lnbranded := false;
		boolean nonexclusion := false;
		boolean searchignoresaddressonly := false;
    boolean include_minors := false;
    integer _lookup := 0;
		// string10 lookuptype := '';                // used in lookup
		// string1 partytype := '';                  // used in lookup
		// boolean simplifiedcontactreturn := false; // used in lookup
		// boolean moxievehicles := false;           // used in lookup
		// string120 companyname := '';              // used in lookup
		// boolean excludelessors := false;          // used in lookup
		// string11 fein := '';                      // used in lookup
// these most likely must not be used in the library
		// boolean isFCRAval := false;
		// string6 PostalCode := ''; //to retire
		// unsigned1 addr_origin_country := address.Components.Country.US; //to retire
// variations of already provided input criteria (in most cases should be deprecated)
		// boolean UsingKeepSSNs := false;
		// string120 nameasis := '';
		// string120 asisname := '';
		// string50 lfmname := '';
		// string50 lname := '';
		// string10 prim_range := '';
		// string28 prim_name := '';
		// string50 street_name := '';
		// string5 z5 := '';
		// string8 sec_range := '';
		// string2 st := '';
		// string2 st_orig := '';
		// string120 cn := '';
		// string120 company := '';
		// string350 corpname := '';

    // wildcard search is executed when it is allowed (defined by caller), 
    // and input has valid wildcard components (decided inside the library)
    boolean allow_wildcard := false;

    // I'd love to get rid of this one, since it is not relevant to the search,
    // but this can be done only if we remove pruning out of the library.
		boolean KeepOldSsns := false;

    // extensions; not used in the library call
    unsigned1 glb := 8; //"include minors" should be enough
		string100 seisintadlservice := '';
		string20 DemoCustomerName := '';
		boolean currentResidentsOnly := false;
  end;

  // library main entry interface: remove fields used for pre and post-processing
  export lib_search := record
    //Note: allow_wildcard, currentResidentsOnly are passed to the library as a search-code
    unprocessed_input and not [seisintadlservice, DemoCustomerName, glb, allow_wildcard, currentResidentsOnly];
    unsigned1 saltLeadThreshold := AutoHeaderV2.Constants.SaltLeadThreshold ;
    // here we also can redefine the values which have different type;
    // for instance, ssn can be a good candidate (string9 for the search purpose).
    // I'm not doing it now, only because it is trimmed inside the lib anyway (to account for first5/last4)
	end;

  // interface for each and every individual fetch
  // "prefix "t" stands for "translated"
  export search := record
    integer seq := 0;
    unsigned6 did := 0;                             // 'DID'
    unsigned8 rid := 0;                             // 'RID'
    _ssn tssn;
    _name tname;
    _address taddress;
    _phone tphone;
    _dob tdob;
    directives options; 
  end;

  // library output
  export search_out := record (doxie.layout_references_hh) // has HHID indicator; we can get rid of it at some point
		integer seq := 0;           // reserved: for batch processing, if any happens in the future
    integer fetch_hit;          // individual fetch(es) used to produce results (bitmask; informational)
    integer index_hit := 0;     // indices that were hit (bitmask; informational; not used too much so far)
    integer status := 0;        // primitive diagnostics mostly for the case when no DIDs were found
    integer err_code := 0;      // reserved: we might want to keep a failure status instead of failing the search
		integer score := 0;         // currently is populated for SALT request & when "best only" is requested.
  end;
	
end;