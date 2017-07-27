import doxie;

export best_address_target(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

thebest := doxie_cbrs.best_records_prs_target(bdids);

doxie.layout_addressSearch prep(thebest l) := transform
	self.seq := 0;
	self.zip := (string5)l.zip;
	self := l;
end;

return project(thebest, prep(left));
END;