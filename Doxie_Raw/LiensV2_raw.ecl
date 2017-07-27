import doxie, liensv2,autokeyb,liensv2_services,doxie_cbrs;
export LiensV2_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
    dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
		dataset(liensv2_services.layout_tmsid) tmsids = doxie_raw.ds_EmptyTMSIDs,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    boolean	is_crs = false,
    string20  fname_val = '',
    string20  mname_val = '',
    string20  lname_val = '',
    string2   state_val = '',
    string17  case_number_val = '',
    string120 comp_name_value = '',
    string6 ssn_mask_value = 'NONE',
		string1 in_party_type = '',
	  string32 appType
) := FUNCTION

//***** GATHER TMSIDS BY INPUTS
d := liensv2_services.liens_raw.get_tmsids_from_dids(dids,in_party_type);
b := liensv2_services.liens_raw.get_tmsids_from_bdids(project(bdids,doxie_cbrs.layout_references),,in_party_type);

i := d + b + tmsids;

//***** GATHER RECORDS BY TMSIDS
r := liensv2_services.liens_raw.source_view.by_tmsid(i,ssn_mask_value,appType);
		  

return r(dateVal = 0 OR (unsigned3)(orig_filing_date[1..6]) <= dateVal);

END;