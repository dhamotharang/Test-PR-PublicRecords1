IMPORT AutoKeyB2, autokeyi, AutoStandardI, SANCTN, SANCTN_Services;

// Note: there's no deepdive for SANCTN
EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, 
   boolean is_CompSearchL = false) := FUNCTION

  // by autokey
	ak_keyname := SANCTN_Services.Constants.ak_keyname;
	ak_typeStr := SANCTN_Services.Constants.ak_typeStr;

	tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := SANCTN_Services.constants.set_skip;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

  // create layout for autokeys
  layout_autokey_app := RECORD (SANCTN.layout_autokeys)
    integer zero := 0;
    string0 blk  := '';
//    unsigned6 fdid := 0;
  END;
  ds := DATASET ([], layout_autokey_app);

  // Get IDs from autokeys 
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, 0, 0, ak_typeStr);
  
  // CCPA - because there is company and individual info in a single record,
  //        suppression of fields needs to be done at the payload transform 
  //        Here, only IDs are being returned.
  by_autokey := 
    PROJECT(outPLfat, Sanctn_Services.layouts.search_ids);

/*
  outpl := project (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.bdidL, outPLfat.batch_number, outPLfat.incident_number});
	by_auto := project(outpl, outrec);

  // Get DIDs, BDIDs from payload
  hasdid  := outpl (didL > 0 and ~AutokeyB2.ISFakeID (didL, ak_typeStr));
  hasBdid := outpl (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));

  // Ensure that BDIDs/DIDs actually came from a person/company search
  did_search := join (hasDid, ids (isdid),
                     left.id = right.id,
                     transform (doxie.Layout_references, self.did := left.did));
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));
*/

  // search will be done only if no "direct search" parameters specified.
  string8 batch_number_in    := '' : stored ('BatchNumber');
  string8 incident_number_in := '' : stored ('IncidentNumber');
  boolean IsInputID := (batch_number_in != '') and (incident_number_in != '');
  by_incident := IF (IsInputID, DATASET ([{batch_number_in, incident_number_in}], SANCTN_Services.layouts.search_ids));

  string20 case_number_in := '' : stored ('CaseNumber');
  all_cases := sanctn.Key_SANCTN_casenum (keyed (case_number = case_number_in));
  by_case_number := IF (case_number_in != '', 
                        PROJECT (CHOOSEN (all_cases, SANCTN_Services.Constants.ID_PER_CASENUMBER), SANCTN_Services.layouts.search_ids));

  // in order of preference
  dups := MAP (IsInputID => by_incident,               // incident id
              case_number_in != '' => by_case_number,  // case number
              by_autokey);                             // autokey

  return dedup (dups, batch_number, incident_number, ALL);
END;
