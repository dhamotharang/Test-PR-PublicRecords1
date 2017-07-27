import doxie_cbrs;

export business_property(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

idsBDID := doxie_cbrs.getPropertyIDsByBDID(bdids);

layout_fid bdidtra(idsBDID l) := transform
	self := l;
end;

ib := project(idsBDID, bdidtra(left));
					 
// only preserve the 'property' address records
ids := dedup(sort(ib(source_code[2] = 'P'), fid), fid);

RETURN ids;
END;