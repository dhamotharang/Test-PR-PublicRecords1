/**
Function Search records from Header-
IF(DID in input, input_did is sent to Header, send dids searched via SALT Macro OR Header)
**/
// TODO : Are any extra restriction / suppressions required?

IMPORT doxie, iesp, AutoHeaderV2, didville, Insuranceheader_xLink;

EXPORT search_records(DATASET(layouts.in_layout) aInputData, IParam._search in_mod) := FUNCTION

  cleaned_input := IdentityManagement_Services.Functions.Cleaninput(aInputData,in_mod.use_saltFetch); // STEP1: Clean Input & check if SALT flag is set

  // SALT SEARCH LOGIC - uncomment below 2 lines and comment header search logic 2 lines.
  // Project to SALT macro layout
  rDidSaltInput_Layout :=
  record(Insuranceheader_xLink.Layout_Person_xLink)
    string5  suffix;
    string2  st;
    string5  z5;
    string10 phone10;
    string25 p_city_name;
    string   email;
    integer  seq;
  end;

  rDidSaltInput_Layout tFormat2SaltDIDInput(IdentityManagement_Services.layouts.layout_cleaner pInput) :=
  transform
    self.uniqueid    := pInput.seq;
    self.st          := pInput.taddress.state;
    self.z5          := pInput.taddress.zip5;
    self.phone10     := pInput.tphone.phone10;
    self.phone       := pInput.tphone.phone10;
    self.p_city_name := pInput.taddress.city;
    self.city        := pInput.taddress.city;
    self.state       := pInput.taddress.state;
    self.zip         := pInput.taddress.zip5;
    self.ssn         := (string)pInput.tssn.ssn;
    self.dob         := (string)pInput.tdob.dob;
    self.fname       := pInput.tname.fname;
    self.mname       := pInput.tname.mname;
    self.lname       := pInput.tname.lname;
    self.prim_name   := pInput.taddress.prim_name;
    self.prim_range  := pInput.taddress.prim_range;
    self.sec_range   := pInput.taddress.sec_range;
    self             := pInput;
    self             := [];
  end;

  cleaned_input_SALT := project(cleaned_input,tFormat2SaltDIDInput(left));

  Didville.MAC_DidAppend(cleaned_input_SALT,_fetched_dids,true,''); //Per Aleida, do_fuzzy was deprecated, but needed to pass in something as it doesn't have a default

  fetched_dids_salt := PROJECT( UNGROUP(_fetched_dids),
                                TRANSFORM(AutoHeaderV2.layouts.search_out,
                                          SELF.did       := LEFT.did,
                                          SELF.fetch_hit := 0,
                                          SELF.score     := LEFT.score));

  // by input DID: not really a search, just verification
  input_did := doxie.map_DID(PROJECT(cleaned_input,Doxie.layout_references)); // STEP2: Prepare user input did for Header
  direct_dids := PROJECT( input_did,
                          TRANSFORM(AutoHeaderV2.layouts.search_out,
                                    SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.DID));

  // Header Search Logic
  fetched_dids := IdentityManagement_Services.FetchDIDs (cleaned_input);// STEP3 & 4: Fetch dids + recs (index hit,fetch hit) from Header and DL


  //==== CASE2,3 & 4: IF BETTER, GOOD/ABOVE AVERAGE, MINIMAL/BELOW AVERAGE CONDITIONS(F12:DOCUMENTATION) PROVIDED IN INPUT ====//
  dids_selected := MAP( cleaned_input[1].did <> 0 => direct_dids,
                        in_mod.use_saltFetch      => fetched_dids_salt,
                        fetched_dids);  // STEP5: Decide dids to send to header

  dids_for_header := PROJECT(dids_selected(did<>0), doxie.layout_references_hh);

  // STEP6: if DIDs found, fetch records by DIDs from both header and dailies,
  // otherwise, if header search didn't fail with "too many" (John Smith FL), search dailies
  // Do not change to short boolean notation ~exists() and ~exists(),
  // this may lead to unwanted evaluation of fetched_dids.
  boolean search_dailies := IFF(~EXISTS(dids_for_header), ~EXISTS(fetched_dids(err_code = 203)), FALSE);


  header_recs_by_did :=  doxie.header_records_byDID (dids_for_header, true,,,,TRUE, DoSearch := search_dailies);  // Remove TRUE to run query faster (applicable for builder window) if you only care for no. of identites/dids found rather than data health.

  // Add ssn info:
  ssnrecs := IdentityManagement_Services.Functions.add_ssn_issue(header_recs_by_did);

  // Slim down header records ASAP, assign blank HRIs
  slimmed_header_recs := PROJECT(ssnrecs, IdentityManagement_Services.layouts.slimrec); // NOTE: We are not filtering invalid ssn (!= G).

  // address high risk indicators
  maxHriPer_value := IdentityManagement_Services.Constants.MaxHriPerAddr;
  doxie.mac_AddHRIAddress(slimmed_header_recs,recs_hri);

  recs_raw := IF(in_mod.include_hri, recs_hri, slimmed_header_recs);


  // STEP7: Penalize Records (done within format_search_records)- We may add filter (penalt < 10) later.
  // NOTE: SecondaryPenalty refer to penalizing using valid_ssn flag as penalty can be same for more than 1 record set.
  recs_frm := format_search_records (recs_raw); // STEP8: Transform and Rollup to desired IDM Search layout
  recs_formatted := recs_frm (_penalty <= cleaned_input[1].options.score_threshold);
  t_IDMSearchRecord_err := RECORD
    INTEGER errorcode := 0;
    INTEGER index_hit := 0;
    INTEGER status := 0;
    iesp.identitymanagementsearch.t_IDMSearchRecord;
  END;

  t_IDMSearchRecord_err seterrors() := TRANSFORM
    SELF.uniqueid := '';
    SELF.fetchcode := AutoHeaderV2.Constants.FetchHit.QUICK_HEADER;
    SELF.index_hit := 0;
    SELF.status := 0;
    SELF.errorcode := IdentityManagement_Services.Constants.lost_in_header; // If dids found but all records lost due to header, mostly due to penalizing / scorethreshold.
    SELF := [];
  END;

  recs_lost_in_header := DATASET([seterrors()]);

  _good_recs := JOIN(recs_formatted, dids_selected(did<>0),
                          ((integer)LEFT.uniqueid = RIGHT.did),
                          TRANSFORM(t_IDMSearchRecord_err,
                          SELF.fetchcode := IF(RIGHT.fetch_hit <> 0, RIGHT.fetch_hit, AutoHeaderV2.Constants.FetchHit.QUICK_HEADER),
                          SELF.score:= RIGHT.score,
                          SELF:= LEFT), LEFT OUTER, LIMIT(0), KEEP(1));

  good_recs := SORT(_good_recs, _penalty, SecondaryPenalty);

  // Header Search Logic - STEP9: Get errorcodes, fetch hits back from Header search
  _bad_recs := PROJECT(dids_selected (did = 0),TRANSFORM(t_IDMSearchRecord_err,
                                SELF.uniqueid:= '',
                                SELF.errorcode:= LEFT.err_code,
                                SELF.fetchcode:= LEFT.fetch_hit,
                                SELF.score:= LEFT.score,
                                SELF := LEFT, SELF := [])) + // []:SALT fields
                                IF(COUNT(dids_for_header) > 0 AND COUNT(header_recs_by_did(did <> 0)) = 0 ,recs_lost_in_header);

  bad_recs  := SORT(_bad_recs,-errorcode);

  // "&" makes sure that order is preserved : view gforge msg_id=4635
  searched_records := good_recs & bad_recs;

  RETURN searched_records;

END;
