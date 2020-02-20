import header, doxie, dx_header, location_services, Suppress;

export header_records(DATASET(layout_did_addr) dids_addrs, doxie.IDataAccess mod_access) := FUNCTION


dx_header.Layout_Header getHeaderRecs(dx_header.Layout_Key_Header r) := TRANSFORM
	SELF := r;
END;

headerRecs1 := JOIN(dids_addrs,dx_header.Key_Header(),
									 KEYED(LEFT.did = RIGHT.s_did)
									 and LEFT.prim_name = RIGHT.prim_name
									 and LEFT.st = RIGHT.st,
									 getHeaderRecs(RIGHT));

header.MAC_Filter_Sources(headerRecs1, headerRecs2, src, doxie.DataRestriction.fixed_DRM);
headerRecs2_filt := header.FilterDMVInfo(headerRecs2);
headerRecs_all := if(mod_access.suppress_dmv, headerRecs2_filt, HeaderRecs2);
headerRecs := Suppress.MAC_SuppressSource(headerRecs_all, mod_access);
headerRecsLimited := TOPN(headerRecs, location_services.CONSTS.MAX_HEADER, -dt_last_seen, -dt_first_seen, record); 									 

RETURN headerRecsLimited;
END;