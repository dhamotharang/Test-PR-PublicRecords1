import doxie_raw,doxie;

export doxie_raw.Layout_HeaderRawBatchInput transform_SSNForHead
	(doxie.layout_inBatchMaster l, ssn_services.layout_ssn r, unsigned1 DPPA, unsigned1 GLBA) := 
transform

	self.input.seq := l.seq;
	self.input.did := r.did;
	self.input.dateVal := 0;
	self.input.dppa_purpose := dppa;
	self.input.glb_purpose := glba;
	self.input.ln_branded_value := true;
	self.input.probation_override_Value := true;
	self.input.ssn_mask_value := 'NONE';
	self := [];
end;