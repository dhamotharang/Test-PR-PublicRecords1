import doxie,doxie_raw,header,Suppress,ut;

export Relative_Records(boolean checkRNA=true) := FUNCTION
  doxie.MAC_Selection_Declare()
  doxie.MAC_Header_Field_Declare()

  dids_pre := get_dids()(Include_relatives_val or include_associates_val);
  Suppress.MAC_Suppress(dids_pre,dids,application_type_value,suppress.constants.LinkTypes.DID,did);

  results_max := doxie_Raw.relative_raw
	  (dids,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,ln_branded_value,probation_override_value,
	   include_relatives_val,include_associates_val,Relative_Depth,max_relatives,isCRS,max_associates);

  ut.PermissionTools.GLB.mac_FilterOutMinors(results_max,results_max_fil,person2)

  doxie_raw.mac_JoinHeader_Raw(results_max_fil, recs, person2, false,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,ln_branded_value,probation_override_value)

  rr := sort(recs,p2_sort,p3_sort,p4_sort,-number_cohabits, - recent_cohabit, -isRelative, person1, person2, rid);
  header.MAC_GLB_DPPA_Clean_RNA(rr,rr_rna)
	ret_results := if (checkRNA, rr_rna, rr);

  return ret_results;
END;	