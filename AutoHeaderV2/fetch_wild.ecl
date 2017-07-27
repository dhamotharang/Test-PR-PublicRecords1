IMPORT doxie,AutoHeaderV2,lib_stringlib;

//NB: there's an _options.wildcard which controlled if this function is called

shared fetch_wild (dataset (AutoHeaderV2.layouts.search) ds_search_in, integer search_code=0) := function

  // here we must make a choice whether to clean the input inside the library
  ds_search := ds_search_in;  // user input is already cleaned
  // ds_search := functions.GetSearchTranslatedInput (ds_search_in);  // user input requires cleaning

  // Not a "batch" at the moment
  _row := ds_search[1];
  _options := ds_search[1].options;

  temp_ssn_value := _row.tssn.ssn;
  temp_lname_value := _row.tname.lname; //NB: same as temp_lname_wild_value
  temp_fname_value := _row.tname.fname;
  temp_prange_value := _row.taddress.prim_range;
  temp_pname_value := _row.taddress.prim_name;
//... instead of AutoStandardI.InterfaceTranslator.pname_wild.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_wild.params));
  temp_pname_wild := Stringlib.StringFind(temp_pname_value, '*', 1) <> 0 or
                     Stringlib.StringFind(temp_pname_value, '?', 1) <> 0;
  temp_addr_wild := _row.taddress._wild;
	temp_addr_range := _row.taddress._range;
  temp_addr_loose := temp_addr_wild or _row.taddress._range;
  temp_addr_error_value := _row.taddress.err[1..2]='E3' OR _row.taddress.err[1..4] IN ['E500','E502'];
  temp_any_addr_error_value := _row.taddress.err[1]='E';
  temp_city_value := _row.taddress.city;
  temp_state_value := _row.taddress.state;
  temp_zip_value := _row.taddress.zip_set;
  temp_phone_value := _row.tphone.phone10;

//... instead of AutoStandardI.InterfaceTranslator.is_inv_wildcard.val(project(in_mod,AutoStandardI.InterfaceTranslator.is_inv_wildcard.params));
  // boolean is_inv_wildcard := (Stringlib.StringFind (temp_lname_value, '*', 1) < 4) or 
                             // (Stringlib.StringFind (temp_lname_value, '?', 1) < 4) or   
                             // (Stringlib.StringFind (temp_fname_value, '*', 1) < 4) or 
                             // (Stringlib.StringFind (temp_fname_value, '?', 1) < 4) or   
                             // (Stringlib.StringFind (temp_pname_value, '*', 1) < 4) or    
                             // (Stringlib.StringFind (temp_pname_value, '?', 1) < 4);

  // IF(_options.wildcard and is_inv_wildcard, FAIL(302, doxie.ErrorCodes(302)));

  // same as in non-wild, but W/O checking the existence
  // boolean SEARCH_RID := _row.rid > 0;

  // same as in non-wild, but W/O checking the existence
  // boolean SEARCH_DID := (_row.did > 0);

  boolean SEARCH_FULL_SSN := length(trim(temp_ssn_value))=9;
  boolean SEARCH_PARTIAL_SSN := length(trim(temp_ssn_value)) in [4,5];
  boolean SEARCH_ST_NAME_SMALL := _options.score_threshold > 10;

  // same as in non-wild, but W/O checking the existence
  boolean SEARCH_PHONE := (temp_phone_value<>'');

  // same as in non-wild, but W/O checking for (...and temp_sec_range_value = '')
  boolean SEARCH_STREET := temp_pname_value<>'' AND temp_zip_value<>[]  AND // lname_value<>'' AND
            ((temp_prange_value=''/* and temp_sec_range_value = ''*/) OR temp_addr_error_value OR temp_addr_loose);

  // same as in non-wild, (lname_value == lname_wild_value)
  boolean SEARCH_ADDRESS := temp_pname_value<>'' AND (temp_prange_value<>'' or temp_lname_value='') AND 
                                   (~temp_addr_error_value or temp_addr_loose);


    Fetched_dups := MAP(
//? some fetches are redundant (by usage) -- fetch_DID, fetch_RID
// In graph they are represented by "split"
    // SEARCH_RID                           => fetch_RID (ds_search),
    // SEARCH_DID                           => fetch_DID (ds_search),

    SEARCH_FULL_SSN                      => AutoHeaderV2.fetch_wild_SSN (ds_search) +
                                            if (SEARCH_ST_NAME_SMALL, AutoheaderV2.fetch_wild_StNameSmall (ds_search)),

    SEARCH_PHONE                         => AutoHeaderV2.fetch_wild_phone (ds_search),
 
             // Given a Street name, with some (potentially accidental) fuzziness
    SEARCH_STREET                        => AutoHeaderV2.fetch_wild_street (ds_search, search_code),

             // Given an Full address, or partial with not much else to go on
    SEARCH_ADDRESS                       => AutoHeaderV2.fetch_wild_address (ds_search) + 
                                            IF(temp_any_addr_error_value and ~(temp_pname_wild or temp_addr_wild),
                                               AutoHeaderV2.fetch_wild_zip (ds_search, search_code)),

             //Allow ssn value to be 4 or 5 digits          
    SEARCH_PARTIAL_SSN                   => AutoHeaderV2.fetch_wild_SSNPartial (ds_search),  
             // Otherwise, at this point, if there's no last name...
    //lname_wild==lname
    temp_lname_value=''                  => AutoHeaderV2.fetch_wild_FnameSmall (ds_search, search_code),
             // Zip-Radius
    temp_zip_value<>[]                   => AutoHeaderV2.fetch_wild_zip (ds_search, search_code),
             // Just a Name
    temp_city_value='' AND temp_state_value=''  => AutoHeaderV2.fetch_wild_name (ds_search, search_code),
             // State+Name 
    temp_city_value=''                   => AutoHeaderV2.fetch_wild_StName (ds_search, search_code),
             // Otherwise, try the City/State/Name key
    AutoHeaderV2.fetch_wild_StCityName (ds_search, search_code)

    //TODO: add diagnostics to the default clause
    // dataset ([], layouts.search_out)
              );

//Note: this function is not used by itself -- only withing the main library search
    fetched := rollup (dedup (sort (fetched_dups, did, fetch_hit, index_hit), did, fetch_hit, index_hit),
                       left.did = right.did,
                       transform (AutoheaderV2.layouts.search_out,
                                  Self.did := left.did,
                                  Self.index_hit := left.index_hit | right.index_hit,
                                  Self.fetch_hit := left.fetch_hit | right.fetch_hit));

    return fetched;

end;
