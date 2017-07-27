import doxie, drivers, ut, doxie_files, business_header, doxie_build, mdr;

outrec := doxie_Raw.Layout_VehRawBatchInput;

export outrec transform_VehRaw
	(outrec l, doxie_files.Key_Vehicles r, unsigned1 pick, boolean IsCRS = false) := 
TRANSFORM

  noskip := r.sseq_no > 0 and
						ut.dppa_ok(l.input.dppa_purpose) AND drivers.state_dppa_ok(r.orig_state,l.input.dppa_purpose,,r.source_code) and
  	 	      (l.input.ln_branded_value OR r.source_code NOT IN mdr.Source_is_lnOnly) and
						(l.input.dateVal=0 OR r.dt_first_seen <= l.input.dateVal);
	
	p_le := project(l, transform(Doxie.Layout_VehicleSearch, self := left));
	p_ri := project(r, transform(Doxie.Layout_VehicleSearch, self := left));
	
	ri := if(noskip,p_ri,p_le);
	bs := if(noskip, doxie_build.buildstate, p_le.source);
	p := if(noskip, pick, p_le.pick);
	
	self.seq := l.input.seq;
	SELF.source := bs;
	self.own_1_ssn := if((integer)ri.own_1_feid_ssn=0, IF (IsCRS, ri.own_1_ssn, ''), ri.own_1_feid_ssn);
	self.own_2_ssn := if((integer)ri.own_2_feid_ssn=0, IF (IsCRS, ri.own_2_ssn, ''), ri.own_2_feid_ssn);
	self.reg_1_ssn := if((integer)ri.reg_1_feid_ssn=0, IF (IsCRS, ri.reg_1_ssn, ''), ri.reg_1_feid_ssn);
	self.reg_2_ssn := if((integer)ri.reg_2_feid_ssn=0, IF (IsCRS, ri.reg_2_ssn, ''), ri.reg_2_feid_ssn);
    self.dt_last_seen := if(l.input.dateVal > 0 and ri.dt_last_seen > l.input.dateVal, 
        l.input.dateVal, ri.dt_last_seen); //dt_last_seen should not go beyond dateVal.
	SELF.pick := p;
	SELF.lh_1_zip5 := regexfind('[0-9]{5}',
	                            ri.lh_1_zip5_zip4_foreign_postal,0)[1..5];
	SELF.lh_1_zip4 := regexfind('[0-9]{5}-[0-9]*',
	                            ri.lh_1_zip5_zip4_foreign_postal,0)[7..];
	SELF.lh_2_zip5 := regexfind('[0-9]{5}',
	                            ri.lh_2_zip5_zip4_foreign_postal,0)[1..5];
	SELF.lh_2_zip4 := regexfind('[0-9]{5}-[0-9]*',
	                            ri.lh_2_zip5_zip4_foreign_postal,0)[7..];
	SELF.lh_3_zip5 := regexfind('[0-9]{5}',
	                            ri.lh_3_zip5_zip4_foreign_postal,0)[1..5];
	SELF.lh_3_zip4 := regexfind('[0-9]{5}-[0-9]*',
	                            ri.lh_3_zip5_zip4_foreign_postal,0)[7..];

  //populate body style description, if empty (ESP takes body_code_name from it); 
  //see also #21423, #16424
  SELF.body_style_description := IF (R.body_style_description = '', R.body_code_name, R.body_style_description);
	                           
	SELF := ri;
	
	self.input := l.input;
END;