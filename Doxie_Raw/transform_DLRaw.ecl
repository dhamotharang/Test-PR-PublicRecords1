import doxie, doxie_files,doxie_build,ut,drivers,mdr;

outrec := doxie_Raw.Layout_DLRawBatchInput;

export outrec transform_DLRaw
	(outrec l,doxie_files.Key_dl_number r) := 
TRANSFORM

  noskip := r.dl_number <> '' and
						ut.dppa_ok(l.input.dppa_purpose) AND drivers.state_dppa_ok(r.orig_state,l.input.dppa_purpose) and
  	 	      (l.input.ln_branded_value OR r.source_code NOT IN mdr.Source_is_lnOnly) and
						(l.input.dateVal=0 OR r.dt_first_seen <= l.input.dateVal);
	
	p_le := project(l, transform(Doxie.Layout_DlSearch, self := left));
	p_ri := project(r, transform(Doxie.Layout_DlSearch, self := left));
	
	ri := if(noskip,p_ri,p_le);
	bs := if(noskip, doxie_build.buildstate, p_le.source);
	
	self.seq := l.input.seq;
	SELF.source := bs;
	self.ssn := if (l.input.dppa_purpose not in [1,4,6],'',if((integer)ri.ssn_safe=0,'',ri.ssn_safe));
	self.ssn_safe := if (l.input.dppa_purpose not in [1,4,6],'',if((integer)ri.ssn_safe=0,'',ri.ssn_safe));
	self.restrictions := if (l.input.dppa_purpose not in [1,4,6],'',ri.restrictions);
	self.restrictions_delimited := if (l.input.dppa_purpose not in [1,4,6],'',ri.restrictions_delimited);
	SELF := ri;
	
	self.input := l.input;
END;//

