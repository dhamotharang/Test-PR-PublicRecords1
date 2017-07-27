IMPORT AutoKeyB2, InfoUSA, standard, doxie_raw, doxie, doxie_cbrs, ut, autokeyi, AutoStandardI, AutoHeaderI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := USAbizV2_Services.layouts.search_ids;

	ak_keyname := ut.foreign_prod + 'thor_data400::key::InfoUSA::abius::qa::autokey::';
	ak_typeStr := 'BC';

	tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := ['S','F'];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

  // create layout for autokeys
  dbase := InfoUSA.File_ABIUS_Company_Base;
  layout_slim := RECORD //should be same as in InfoUSA.Proc_Build_AutoKey
    dbase.Abi_number;	
    dbase.phone;
    dbase.company_name;
    dbase.bdid;
    standard.Name name;
    standard.L_Address.Base addr;
    unsigned1 zero := 0;
    unsigned6 fdid := 0; 
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
  bdids_from_input := if(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt)));

  string bdid_val := '' : stored('BDID');
  unsigned6 user_bdid := (unsigned6) bdid_val;
  bdids_from_user := dataset([{user_bdid}], doxie_cbrs.layout_references);

	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_from_input + IF (user_bdid != 0, bdids_from_user), all));
	DeepDives    := project (by_bdid, transform (outrec, self.isDeepDive := true, self := left));

  // by abi from user input
  string9 abi_val := '' : stored('ABI');

  // if abi_number is provided by user, ignore all other input (but other input WILL be used for penalizing!)
	dups := IF (abi_val != '', DATASET ([{abi_val}], outrec), by_auto + if (IncludeDeepDives, deepDives));
	return dedup (sort(dups, abi_number, if(isDeepDive,1,0)), abi_number);

END;

