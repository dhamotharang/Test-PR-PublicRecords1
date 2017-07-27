import doxie;
export ssn_services.layout_ssn transform_SSNBatchCDInputToSSN(doxie.layout_inBatchMaster l) := transform
	self.seq := l.seq;
	self.ssn := l.ssn;
	self.did := 0;
end;