import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

export best_address_full(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

thebest := doxie_cbrs.best_records_bdids(bdids);

best_rec := RECORD
	doxie.layout_addressSearch;
	thebest.company_name;
END;

best_rec prep(thebest l) := transform
	self.seq := 0;
	self.zip := (string5)l.zip;
	self := l;
end;

return dedup(project(thebest, prep(left)),all);
END;
