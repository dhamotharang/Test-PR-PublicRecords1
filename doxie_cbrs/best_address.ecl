import doxie;
thebest := doxie_cbrs.best_records;

doxie.layout_addressSearch prep(thebest l) := transform
	self.seq := 0;
	self.zip := (string5)l.zip;
	self := l;
end;

export best_address := dedup(project(thebest, prep(left)),all);