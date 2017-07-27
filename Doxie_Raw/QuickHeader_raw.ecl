import doxie,header_quick,header,ut,suppress,mdr,census_data;
export QuickHeader_raw(
    dataset(Doxie.layout_references_hh) dids = dataset([], Doxie.layout_references_hh),
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
	string6 ssn_mask_value = 'NONE',
	boolean ln_branded_value = false,
	boolean probation_override_value = false,
	string5 industry_class_value = '',
	boolean maskSSN = true,
	boolean ApplyBpsFilter = false
) := FUNCTION

//**** JOIN TO KEY
k := join(dids, header_quick.key_DID, keyed(left.did = right.did) and
																			(not ApplyBpsFilter or 
																			doxie.bpssearch_filter.rec_OK(
																					right.ssn, right.lname,right.fname,right.mname,
																					right.prim_range,right.prim_name,right.suffix,
																					right.sec_range,right.city_name,right.zip,right.phone,'',right.dob)), 
																			atmost(ut.limits .DID_PER_PERSON));

//**** PROPER FORMAT
comm := project(if(Doxie.DataRestriction.WH, k(~mdr.sourceTools.sourceisWeeklyHeader(src)),k), header_quick.layout_records);
	
//***** CHECK PERMISSIONS
dppa_ok := ut.dppa_ok(dppa_purpose);
glb_ok := ut.glb_ok(glb_purpose);
no_scrub := true;
header.MAC_GlbClean_Header(comm, clean);

//***** ADD COUNTY NAME AND SOURCE
census_data.MAC_Fips2County_Keyed(clean, st, county, county_name, clean_ext);

suppress.MAC_Mask(clean_ext, masked, ssn, blank, true, false);

results := if(maskSSN, masked, clean_ext);

return if(header_quick.stored_Allow, project(results, header_quick.layout_records));

END;