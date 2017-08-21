Footer := '</Entity_List></Watchlist>\r\n';
EXPORT WriteXGFormat(dataset(Layout_XG) entities, dataset(hdr_layout) hdr, string lfn, string version) := FUNCTION

	cnt := count(entities);
	intro := hdr_construct(hdr, cnt, version);
	return OUTPUT(entities,,lfn,
			xml('Entity', heading(FROMUNICODE(intro, 'utf8'),Footer),trim, OPT), overwrite);
END;