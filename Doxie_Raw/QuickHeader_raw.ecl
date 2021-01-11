import doxie,header_quick,header,ut,suppress,mdr,census_data;
export QuickHeader_raw(
    dataset(Doxie.layout_references_hh) dids = dataset([], Doxie.layout_references_hh),
    doxie.IDataAccess mod_access,
    boolean maskSSN = true,
    boolean ApplyBpsFilter = false
) := FUNCTION

Layout_records_CCPA:= RECORD
    header_quick.layout_records;
    UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
END;

//**** JOIN TO KEY
k := join(dids, header_quick.key_DID, keyed(left.did = right.did) and
                                      (not ApplyBpsFilter or
                                      doxie.bpssearch_filter.rec_OK(
                                          right.ssn, right.lname,right.fname,right.mname,
                                          right.prim_range,right.prim_name,right.suffix,
                                          right.sec_range,right.city_name,right.zip,right.phone,'',right.dob)),
                                      atmost(ut.limits .DID_PER_PERSON));

//**** PROPER FORMAT
comm := project(if(Doxie.DataRestriction.WH, k(~mdr.sourceTools.sourceisWeeklyHeader(src)),k), Layout_records_CCPA);


//***** CHECK PERMISSIONS

header.MAC_GlbClean_Header(comm, clean, , , mod_access);


//***** ADD COUNTY NAME AND SOURCE
census_data.MAC_Fips2County_Keyed(clean, st, county, county_name, clean_ext);

suppress.MAC_Mask(clean_ext, masked, ssn, blank, true, false, maskVal := mod_access.ssn_mask);

results := if(maskSSN, masked, clean_ext);

return if(header_quick.stored_Allow, project(results, header_quick.layout_records));

END;
