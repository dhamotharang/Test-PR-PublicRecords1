/*--SALT LIBRARY--*/
// This library performs person fetches.
// All logic for performing the fetch should be based here.

IMPORT doxie,ut,_Control,AutoStandardI,AutoheaderV2;

#if(not _Control.LibraryUse.ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Indv)
  export LIB_header_saltplus(dataset (AutoheaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := MODULE, LIBRARY (AutoheaderV2.ILIB.IHeaderSearch)
#else
  export LIB_header_saltplus(dataset (AutoheaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := MODULE (AutoheaderV2.ILIB.IHeaderSearch (ds_search_in, search_code))
#end

  // here we must make a choice whether to clean the input inside the library
  shared ds_search := AutoheaderV2.LIBCALL_conversions.CleanSearchInputDataset (ds_search_in, AutoHeaderV2.Constants.LibVersion.SALT);  // input requires full cleaning
		shared ds_search_legacy := AutoheaderV2.LIBCALL_conversions.CleanSearchInputDataset (ds_search_in, AutoHeaderV2.Constants.LibVersion.LEGACY);  
		shared _row := ds_search_legacy[1];
  shared _options := ds_search_legacy[1].options;
  shared temp_ssn_value := _row.tssn.ssn;

  temp_fname_value := _row.tname.fname;
  temp_lname_value := _row.tname.lname;  
  temp_prange_value := _row.taddress.prim_range;
  temp_pname_value := _row.taddress.prim_name;  
  temp_addr_loose := _row.taddress._wild or _row.taddress._range;
  temp_addr_error_value := _row.taddress.err[1..2]='E3' OR _row.taddress.err[1..4] IN ['E500','E502'];  
  temp_city_value := _row.taddress.city;
  temp_state_value :=  _row.taddress.state;
    
  boolean SEARCH_DID := (_row.did > 0);

  boolean SEARCH_RID := _row.rid > 0;

  boolean SEARCH_ADDRESS := temp_pname_value<>'' AND (temp_prange_value<>'' or temp_lname_value='') AND 
                                   (~temp_addr_error_value or temp_addr_loose);

  // DOB boundaries depending on whether age high/low specified and formast of input DOB
  temp_dob_val_low  := _row.tdob.dob_low;  //0 or YYYY0000 or YYYY0101
  temp_dob_val_high := _row.tdob.dob_high; //0 or YYYY0000 or YYYY1231

  boolean SEARCH_DOB_NAME := doxie.DOBTools(temp_dob_val_low).IsValidYOB AND 
                             doxie.DOBTools(temp_dob_val_high).IsValidYOB AND 
                             (temp_lname_value <> '');

  boolean SEARCH_NAME := temp_fname_value <> '' and temp_lname_value <> '' and temp_city_value='' AND temp_state_value='';
	
	// always not fail with salt, because if salt does not return results we will try other ps fetches.
	INTEGER SALT_SearchCode := AutoheaderV2.Constants.SearchCode.NOFAIL; 
		
	boolean SEARCH_STATE_NAME := temp_fname_value <>'' and temp_lname_value <> '' and temp_city_value='' and temp_state_value <> '';
	
  // Choose the search path
  fetched_dups1 := MAP (
    SEARCH_RID                 => AutoHeaderV2.fetch_SaltID(ds_search), 
		
    SEARCH_DID                 => AutoHeaderV2.fetch_SaltID(ds_search), 

    SEARCH_ADDRESS             => AutoHeaderV2.fetch_address (ds_search_legacy, search_code) ,
		
									// DOB (at least YOB) + lname, optional fname, state, zip
    SEARCH_DOB_NAME  									=> AutoHeaderV2.fetch_DOBName (ds_search_legacy, search_code),
         // Just a Name
    SEARCH_NAME               => AutoHeaderV2.fetch_name (ds_search_legacy, search_code),
         // State+Name 
    SEARCH_STATE_NAME     				=> AutoHeaderV2.fetch_StName (ds_search_legacy, search_code),

         // Otherwise, try the City/State/Name key
     AutoHeaderV2.fetch_StCityName (ds_search_legacy, search_code)    
  );

	saltPlus_results := AutoHeaderV2.fetch_salt(ds_search, SALT_SearchCode);												
	boolean noSaltResults := 	count(saltPlus_results)=0;			
	
	fetched_dups := IF(SEARCH_DID or SEARCH_RID or noSaltResults  , DEDUP(SORT(fetched_dups1, 	seq, did), seq, did), saltPlus_results);
// output(fetched_dups1, named('fetched_dups1'));
// output(saltPlus_results, named('saltPlus_results'));
// output(noSaltResults, named('noSaltResults'));
// output(SEARCH_DOB_NAME, named('SEARCH_DOB_NAME'));
// output(SEARCH_STATE_NAME, named('SEARCH_STATE_NAME'));	
// output(fetched_dups, named('fetched_dups'));
	
 shared lib_dids := project(fetched_dups, transform(AutoheaderV2.layouts.search_out, 
                                                     self.seq:= _row.seq,																																																					
                                                     self     := left));
																										 
	EXPORT dataset (AutoHeaderV2.layouts.search_out) all_dids := lib_dids;
  																												
  // choose best DIDs, if requested
  bd := if(_options.only_best_did, 
           lib_dids(score>=75), 
           lib_dids);

  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;
    
  Fetch_fail := limit(bd,3000,FAIL(203, doxie.ErrorCodes(203)));
  Fetch_nofail :=limit(bd,3000,skip);

  hr1 := IF(no_fail, Fetch_nofail, Fetch_fail);

  //prune old SSNs; ssn_set contains at least an input ssn
  hr1_pruned := JOIN(hr1, doxie.Key_DID_SSN_Date (), 
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
// output(hr1_pruned, named('hr1_pruned'));
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
// output(	res_filtered, named('res_filtered'));
  EXPORT dataset (AutoheaderV2.layouts.search_out) results := hr;

  // ... if only one message is of interest to the caller, use (status = Constants.STATUS._MNAME)
  fetched_msg := dedup (sort (lib_dids (did = 0), fetch_hit, index_hit), fetch_hit, index_hit);
  EXPORT dataset (AutoheaderV2.layouts.search_out) messages := fetched_msg;

  EXPORT dataset (AutoheaderV2.layouts.search) _input := ds_search; // cleaned input: actual parameters search is done with
	// output(ds_search, named('ds_search'));
END;