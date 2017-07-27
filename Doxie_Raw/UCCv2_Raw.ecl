import doxie, UCCv2, autokeyb, UCCv2_Services, doxie_cbrs;

#STORED('IncludeMultipleSecured', true);
#STORED('ReturnRolledDebtors', true);
doxie.MAC_Header_Field_Declare()

export UCCv2_Raw(
	dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
	dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
	unsigned3	dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
	boolean		is_crs = false,
	string20  fname_val = '',
	string20  mname_val = '',
	string20  lname_val = '',
	string2   state_val = '',
	string17  case_number_val = '',
	string120 comp_name_value = '',
	string50	tmsidval = '',
	string6		ssn_mask_value = 'NONE',
	string1 in_party_type = ''
) := FUNCTION

//***** GATHER TMSIDS BY INPUTS
d := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,in_party_type);
b := UCCv2_Services.UCCRaw.get_tmsids_from_bdids(project(bdids,doxie_cbrs.layout_references),,in_party_type);
i := d + b + if(tmsidval <> '', dataset([{tmsidval}], UCCv2_services.layout_tmsid));

//***** GATHER RECORDS BY TMSIDS
r := UCCv2_Services.UCCRaw.source_view.by_tmsid(i,ssn_mask_value,,application_type_value);

return r(dateVal = 0 OR (unsigned3)(orig_filing_date[1..6]) <= dateVal);

END;
