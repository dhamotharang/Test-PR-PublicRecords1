/*--LIBRARY--*/
// This library performs person fetches.
// All logic for performing the fetch should be based here.

IMPORT dx_header,doxie,_Control,AutoStandardI,AutoheaderV2;

#if(not _Control.LibraryUse.ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Indv)
  export LIB_header(dataset (AutoheaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := MODULE, LIBRARY (AutoheaderV2.ILIB.IHeaderSearch)
#else
  export LIB_header(dataset (AutoheaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := MODULE (AutoheaderV2.ILIB.IHeaderSearch (ds_search_in, search_code))
#end

  // here we must make a choice whether to clean the input inside the library
  // shared ds_search := ds_search_in;  // input is already cleaned
  // shared ds_search := project (ds_search_in, LIBCALL_conversions.DeriveSearchInput (Left));  // input was partially processed
  shared ds_search := AutoheaderV2.LIBCALL_conversions.CleanSearchInputDataset (ds_search_in);  // input requires full cleaning
  
  // Not a "batch" at the moment
  shared _row := ds_search[1];
  shared _options := ds_search[1].options;
  shared temp_ssn_value := _row.tssn.ssn;

  temp_fname_value := _row.tname.fname;
  temp_lname_value := _row.tname.lname;
  temp_lname4_value := _row.tname.lname4;
  temp_prange_value := _row.taddress.prim_range;
  temp_pname_value := _row.taddress.prim_name;
  temp_sec_range_value := _row.taddress.sec_range;
  temp_addr_loose := _row.taddress._wild or _row.taddress._range;
  temp_addr_error_value := _row.taddress.err[1..2]='E3' OR _row.taddress.err[1..4] IN ['E500','E502'];
  temp_any_addr_error_value := _row.taddress.err[1]='E';
  temp_city_value := _row.taddress.city;
  temp_state_value :=  _row.taddress.state;
  temp_zip_value := _row.taddress.zip_set;
  temp_phone_value := _row.tphone.phone10;
  

  //check if wildcard is allowed and was actually requested
  boolean SEARCH_WILDCARD := (search_code & AutoheaderV2.Constants.SearchCode.ALLOW_WILDCARD > 0) and _options.wildcard;

  boolean SEARCH_DID := (_row.did > 0);

  boolean SEARCH_RID := _row.rid > 0;

  boolean SEARCH_FULL_SSN := length(trim(temp_ssn_value))=9;

  boolean SEARCH_PARTIAL_SSN := length(trim(temp_ssn_value)) in [4,5];
  boolean SEARCH_ST_NAME_SMALL := _options.score_threshold > 10;

  fetched_phones := if (temp_phone_value<>'', AutoheaderV2.fetch_phone (ds_search));
  boolean SEARCH_PHONE := (temp_phone_value<>'') and exists (fetched_phones(did !=0));

  boolean SEARCH_STREET := temp_pname_value<>'' AND temp_zip_value<>[]  AND // lname_value<>'' AND
            ((temp_prange_value='' and temp_sec_range_value = '') OR temp_addr_error_value OR temp_addr_loose);

  boolean SEARCH_ADDRESS := temp_pname_value<>'' AND (temp_prange_value<>'' or temp_lname_value='') AND 
                                   (~temp_addr_error_value or temp_addr_loose);

  boolean SEARCH_FEDEX := temp_pname_value='' AND temp_zip_value<>[] AND temp_prange_value<>'';

  boolean SEARCH_DIR_ASST  := temp_lname4_value <> '';

  // DOB boundaries depending on whether age high/low specified and formast of input DOB
  temp_dob_val_low  := _row.tdob.dob_low;  //0 or YYYY0000 or YYYY0101
  temp_dob_val_high := _row.tdob.dob_high; //0 or YYYY0000 or YYYY1231

  boolean SEARCH_DOB_NAME := doxie.DOBTools(temp_dob_val_low).IsValidYOB AND 
                             doxie.DOBTools(temp_dob_val_high).IsValidYOB AND 
                             (temp_lname_value <> '');

  boolean SEARCH_DOB_FNAME := doxie.DOBTools (temp_dob_val_low).IsValidDOB AND 
                              doxie.DOBTools (temp_dob_val_high).IsValidDOB AND (temp_fname_value != '') AND 
                             (temp_lname_value = '');

  boolean SEARCH_FNAME := temp_lname_value=''; 

  boolean SEARCH_ZIP := temp_zip_value <> [];

  boolean SEARCH_NAME := temp_city_value='' AND temp_state_value='';

  boolean SEARCH_STATE_NAME := temp_city_value='';

  // Choose the search path
  fetched_dups := MAP (
    SEARCH_RID                           => AutoHeaderV2.fetch_RID (ds_search),
    SEARCH_DID                           => AutoHeaderV2.fetch_DID (ds_search),

    //change: wild search moved here; TODO: consider unwrapping it (wild card search isn't used anywhere by itself)
    SEARCH_WILDCARD                      => fetch_wild (ds_search, search_code),
      
    SEARCH_FULL_SSN                      => AutoHeaderV2.fetch_SSN (ds_search) + if (SEARCH_ST_NAME_SMALL, AutoHeaderV2.fetch_stnamesmall (ds_search)),

    SEARCH_PHONE                         => fetched_phones,
 
          // Given a Street name, with some (potentially accidental) fuzziness
    SEARCH_STREET                        => AutoHeaderV2.fetch_street (ds_search, search_code),

          // Given an Full address, or partial with not much else to go on
          // For bug 50096 (and to not disturb existing behavior), need to do both an address fetch *and* a 
          // partial SSN fetch and combine the results
    SEARCH_ADDRESS                       => AutoHeaderV2.fetch_address (ds_search, search_code) + 
                                            IF(temp_any_addr_error_value, AutoHeaderV2.fetch_zip (ds_search, search_code)) +
                                            IF(SEARCH_PARTIAL_SSN, AutoHeaderV2.fetch_ssnpartial (ds_search)),

    SEARCH_PARTIAL_SSN                   => AutoHeaderV2.fetch_SSNPartial (ds_search),  

          // Looks like a Fedex search
    SEARCH_FEDEX                         => AutoHeaderV2.fetch_zipPRLname (ds_search, search_code),
          
          // Looks like a Directory Assistance search
    SEARCH_DIR_ASST                      => AutoHeaderV2.fetch_DA (ds_search),
          // Otherwise, at this point, if there's no last name...

          // DOB (at least YOB) + lname, optional fname, state, zip
    SEARCH_DOB_NAME                      => AutoHeaderV2.fetch_DOBName (ds_search, search_code),
          // DOB+fname + optional state, zip
    SEARCH_DOB_FNAME                     => AutoHeaderV2.fetch_DOBFname (ds_search, search_code),

    SEARCH_FNAME                         => AutoHeaderV2.fetch_FnameSmall (ds_search, search_code),

          // Zip-Radius
    SEARCH_ZIP                           => AutoHeaderV2.fetch_zip (ds_search, search_code),

          // Just a Name
    SEARCH_NAME                          => AutoHeaderV2.fetch_name (ds_search, search_code),
          // State+Name 
    SEARCH_STATE_NAME                    => AutoHeaderV2.fetch_StName (ds_search, search_code),

          // Otherwise, try the City/State/Name key
    AutoHeaderV2.fetch_StCityName (ds_search, search_code)
    //TODO: add diagnostics to the default clause
    // dataset ([], layouts.search_out)
  );
	
  shared lib_dids := project(fetched_dups, transform(AutoheaderV2.layouts.search_out, 
                                                     self.seq:= _row.seq,
                                                     self     := left));

    // in the future, if we want to save failure message and fail here instead of failing in place.
    // ds_fail := lib_dids (did = 0, status = Constants.STATUS._FAIL);
    // doFailures := APPLY (ds_fail, FAIL (err_code, doxie.ErrorCodes(err_code)));
    // resultWithFailures := WHEN (ds_fail, doFailures, SUCCESS);

  // rollup indicators
  fetched := rollup (sort (lib_dids (did !=0), seq, did),
                            (left.seq = right.seq) and
                            (left.did = right.did),
                           transform (AutoheaderV2.layouts.search_out,
                                      Self.seq			 := left.seq,
																			Self.did 			 := left.did,
                                      Self.index_hit := left.index_hit | right.index_hit,
                                      Self.fetch_hit := left.fetch_hit | right.fetch_hit));

  // choose best DIDs, if requested
  bd := if(_options.only_best_did, 
           AutoheaderV2.functions.ChooseBestDID (fetched, ds_search), 
           fetched);

  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;
    
  Fetch_fail := limit(bd,3000,FAIL(203, doxie.ErrorCodes(203)));
  Fetch_nofail :=limit(bd,3000,skip);

  hr1 := IF(no_fail, Fetch_nofail, Fetch_fail);

  //prune old SSNs; ssn_set contains at least an input ssn
  hr1_pruned := JOIN(hr1, dx_header.key_DID_SSN_date (), 
                     keyed (LEFT.did = RIGHT.did and RIGHT.ssn in _row.tssn.ssn_set),
                     transform (Left), LEFT ONLY);
                       
  hr1_new := IF(temp_ssn_value <> '' and ~_row.tssn.keep_old_ssn, hr1_pruned, hr1);

  hr3 := doxie.Get_Household_DIDs(project (hr1_new, doxie.layout_references));
   
  AutoheaderV2.layouts.search_out getHH(hr3 l, hr1_new r) := TRANSFORM
    by_hhid := (l.did <> 0) and (r.did = 0);
    SELF.includedByHHID := by_hhid;
    SELF.did := IF(l.did <> 0, l.did, r.did);
    Self.fetch_hit := if (by_hhid, AutoheaderV2.Constants.FetchHit.HH, r.fetch_hit);
    Self.index_hit := if (by_hhid, AutoheaderV2.Constants.FetchHit.HH, r.index_hit);
  END;
   
  hr4 := join(hr3, hr1_new, left.did = right.did, getHH(left, right), full outer);
         
  // If whole house then do 'double bounce' to get dids back
  hr := if( _options.household, 
           IF(no_fail, hr4, LIMIT(hr4, 3000, FAIL(203, doxie.ErrorCodes(203)))), hr1_new );

  // filter minors
  perm_mod := module(AutoStandardI.PermissionI_Tools.params);
    export boolean AllowAll := false;
    export boolean AllowGLB := false;
    export boolean AllowDPPA := false;
    export unsigned1 DPPAPurpose := 0;
    export unsigned1 GLBPurpose := 0; // no need: can be controlled just by "include"
    export boolean IncludeMinors := _options.include_minors;
  end;
  AutoStandardI.PermissionI_Tools.val(perm_mod).GLB.mac_FilterOutMinors(hr,res_filtered,,perm_mod);

  EXPORT dataset (AutoheaderV2.layouts.search_out) results := res_filtered;

  // ... if only one message is of interest to the caller, use (status = Constants.STATUS._MNAME)
  fetched_msg := dedup (sort (lib_dids (did = 0), fetch_hit, index_hit), fetch_hit, index_hit);
  EXPORT dataset (AutoheaderV2.layouts.search_out) messages := fetched_msg;

  EXPORT dataset (AutoheaderV2.layouts.search) _input := ds_search; // cleaned input: actual parameters search is done with

END;
