import $, doxie;

export Search_ids(boolean includeDeepDive = true, boolean isMoxie = false) := FUNCTION

  doxie.MAC_Header_Field_Declare()

  outrec := $.layouts.search_id;

  //***** AUTOKEY PEICE
  byak := $.Autokey_ids;

  //***** DIDs
  mdid := (unsigned6) did_value;
  m_did := dataset([mdid], doxie.layout_references);
  bydid := $.raw.get_death_ids.from_dids(m_did);
  searchByDid := mdid != 0;

  dd_dids := if(includeDeepDive, doxie.Get_Dids(true,true));
  by_dd_did := $.raw.get_death_ids.from_dids(dd_dids);

  //***** BY DEATH ID
  searchByDeathID := StateDeathID_value <> '';
  bydeathID := dataset([{StateDeathID_value}],$.layouts.death_id);

  //***** BY DOD
  bydod := $.dod_ids.result;

  //***** BY DOB
  bydob := $.dob_ids.result;

  //***** DO I HAVE INPUT THAT PRECLUDES MY NEED FOR AUTOKEYS
  skip_ak := pname_value = '' and prange_value = '' and ssn_value = '' and //the goal here is to only skip autokeys in favor of a date if we have only (valid)date + (zip or state or name)
             ($.dod_ids.valid_input((string8)dod_value) or
             $.dob_ids.valid_input((string8)dob_val) or
             StateDeathID_value <> '');

  search_ind := $.Constants.SearchIndicators;
  //***** ALL IDS FOUND USING A SEARCH CRITERIA OTHER THAN DID OR DEATHID
  ids := project(if(not skip_ak, byak) + bydod + bydob, transform(outrec, self.SearchIndicator := search_ind.OTHERS, self.isDeepDive := FALSE, self := left));
  deep_dive_ids := project(by_dd_did, transform(outrec, self.SearchIndicator := search_ind.DEEP_DIVE, self.isDeepDive := TRUE, self := left));

  other_ids := deep_dive_ids + ids;
  deathid_ids := project(bydeathID, transform(outrec, self.SearchIndicator := search_ind.DEATH_ID, self.isDeepDive := FALSE, self := left));
  did_ids := project(bydid, transform(outrec, self.SearchIndicator := search_ind.DID, self.isDeepDive := FALSE, self := left));

  //***** BUG63016: MAKING RESULTS MUTUALLY EXCLUSIVE BASED ON SEARCH CRITERIA
  all_ids := MAP(searchByDeathID => deathid_ids,
                 searchByDid => did_ids,
                 other_ids);

  sids := dedup(sort(all_ids, state_death_id, if(isDeepDive, 0, 1)), state_death_id);

  return sids;

END;
