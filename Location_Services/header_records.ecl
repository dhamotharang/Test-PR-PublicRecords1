import header, doxie, doxie_raw, location_services;

export header_records(DATASET(layout_did_addr) dids_addrs) := FUNCTION
doxie.MAC_Header_Field_Declare()
header.Layout_Header getHeaderRecs(doxie.Key_Header r) := TRANSFORM
	SELF := r;
END;

headerRecs1 := JOIN(dids_addrs,doxie.Key_Header,
									 KEYED(LEFT.did = RIGHT.s_did)
									 and LEFT.prim_name = RIGHT.prim_name
									 and LEFT.st = RIGHT.st,
									 getHeaderRecs(RIGHT));

header.MAC_Filter_Sources(headerRecs1, headerRecs2, src, doxie.DataRestriction.fixed_DRM);
headerRecs2_filt := header.FilterDMVInfo(headerRecs2);
headerRecs := if(suppressDMVInfo_value, headerRecs2_filt, HeaderRecs2);

headerRecsLimited := TOPN(headerRecs, location_services.CONSTS.MAX_HEADER, -dt_last_seen, -dt_first_seen, record); 									 

RETURN headerRecsLimited;
END;