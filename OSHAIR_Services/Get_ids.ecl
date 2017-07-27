IMPORT OSHAIR, AutoKeyB2, doxie_raw, doxie, doxie_cbrs, ut, AutoKeyI, AutoStandardI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := OSHAIR_Services.layouts.search_ids;

	ak_keyname := '~thor_data400::key::oshair::qa::autokey::';
	ak_typeStr := 'AK';

	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := ['C','Q'];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  // create layout for autokeys
  layout_autokey_app := RECORD (OSHAIR.layout_autokeys)
    unsigned1 zero := 0;
    string1 blank  := '';
    unsigned6 fdid := 0;
  END;
  ds := DATASET ([], layout_autokey_app);

  // Get payload and BDIDs from autokeys 
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, 0, bdid, ak_typeStr);

  outpl := project (outPLfat, {outPLfat.id, outPLfat.bdid, outPLfat.activity_number});
	by_auto := project(outpl, outrec);

  // Get bdids from payload
  hasBdid := outpl (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));

  // ENSURE THAT BDIDS ACTUALLY CAME FROM A COMPANY SEARCH
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));

  // bdid
  bdids_from_input := if(is_CompSearchL, doxie_raw.get_BDIDs ());

  string bdid_val := '' : stored('BDID');
  unsigned6 user_bdid := (unsigned6) bdid_val;
  bdids_from_user := dataset([{user_bdid}], doxie_cbrs.layout_references);

  all_bdids := DEDUP (bdid_search + bdids_from_input + IF (user_bdid != 0, bdids_from_user), ALL);

  by_bdid := OSHAIR_Services.raw.get_ids_from_bdids (all_bdids);
  DeepDives := project (by_bdid, transform (outrec, self.isDeepDive := true, self := left));

  // by activity number from user input (internally, this is an integer)
  unsigned activity_val := 0 : stored('ActivityNumber');

  // if activity_number is provided by user, ignore all other input (but other input WILL be used for penalizing!)
  dups := IF (activity_val != 0, DATASET ([{activity_val}], outrec), by_auto + if (IncludeDeepDives, deepDives));
  return dedup (sort(dups, activity_number, if(isDeepDive,1,0)), activity_number);

END;
