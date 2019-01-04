import doxie, doxie_raw, header, Suppress;

export Relative_Records(boolean checkRNA=true) := FUNCTION
  doxie.MAC_Selection_Declare()
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

  dids_pre := get_dids()(Include_relatives_val or include_associates_val);
  Suppress.MAC_Suppress(dids_pre, dids, mod_access.application_type, suppress.constants.LinkTypes.DID, did);

  results_max := doxie_Raw.relative_raw
	  (dids, mod_access,
	   include_relatives_val,include_associates_val,Relative_Depth,max_relatives,max_associates);

  results_max_fil := doxie.compliance.MAC_FilterOutMinors (results_max, person2, , mod_access.show_minors);

  doxie_raw.mac_JoinHeader_Raw(results_max_fil, recs, person2, false, mod_access);

  rr := sort(recs,p2_sort,p3_sort,p4_sort,-number_cohabits, - recent_cohabit, -isRelative, person1, person2, rid);
  header.MAC_GLB_DPPA_Clean_RNA(rr, rr_rna, mod_access)
	ret_results := if (checkRNA, rr_rna, rr);

  return ret_results;
END;
	