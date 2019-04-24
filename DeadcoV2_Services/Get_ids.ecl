IMPORT AutoKeyB2, InfoUSA, standard, doxie_raw, doxie, doxie_cbrs, ut, AutoKeyI, AutoStandardI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := DeadcoV2_Services.layouts.search_ids;

	ak_keyname := '~thor_data400::key::InfoUSA::deadco::qa::autokey::';
	ak_typeStr := 'BC';

	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typeStr;
		export set of string1 get_skip_set := ['S', 'F'];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  // create layout for autokeys  (//should be same as in InfoUSA.Proc_Build_AutoKey)
  dbase := InfoUSA.file_deadco_base;
  layout_slim := RECORD 
    dBase.Abi_number;
	  dbase.phone;
  	dbase.company_name;
	  dbase.bdid;
    standard.Name name;
    standard.L_Address.Base addr;
    unsigned1 zero := 0;
    unsigned6 fdid := 0;
		// Added CCPA fields RR-15150
		dBase.global_sid;
		dBase.record_sid;
  END;
  ds := DATASET ([], layout_slim);

  // Get payload and BDIDs from autokeys 
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, 0, bdid, ak_typeStr);

  outpl := project (outPLfat, {outPLfat.id, outPLfat.bdid, outPLfat.abi_number});
	by_auto := project(outpl, outrec);

  // Get bdids from payload
  hasBdid := outpl (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));

  // ENSURE THAT BDIDS ACTUALLY CAME FROM A COMPANY SEARCH
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));

  // bdid
  bdids_from_input := if(is_CompSearchL, doxie_raw.get_BDIDs ());

	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_from_input, all));
	DeepDives    := project (by_bdid, transform (outrec, self.isDeepDive := true, self := left));

	dups := by_auto + if (IncludeDeepDives, deepDives);
	return dedup (sort(dups, abi_number, if(isDeepDive,1,0)), abi_number);

END;

