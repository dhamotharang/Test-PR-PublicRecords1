import doxie, DayBatchPCNSR,address;
outrec := ssn_services.layout_SSNBatchCD_output;
export //outrec 
	fun_AppendDemoCDBatch(
	grouped dataset(layout_SSNBatchCD_wHead) inputs,
  doxie.IDataAccess mod_access) := 
FUNCTION

temprec := record
	layout_SSNBatchCD_wHead;
	typeof(inputs.acctno) temp_acctno;
end;

gi := project(inputs, transform(temprec, self.temp_acctno := ''; self := left));

gi tra_iter(gi l, gi r) := transform
	self.temp_acctno := r.acctno;
  self.acctno := if(l.acctno='','0', intformat((integer)(l.acctno)+1, 20,1));
	self := r;
end;

iter := iterate(group(gi), tra_iter(left, right));

//***** Get the Demographics
DayBatchPCNSR.Layout_clean_in tra_forPCNSRAppend(iter l) := transform
	self.name_first := l.fname;
	self.name_last := l.lname;

	self.prim_range := l.prim_Range;
	self.prim_name := l.prim_name;
	self.sec_range := l.sec_range;
	self.p_city_name := l.city_name;
	self.st := l.st;
	self.z5 := l.zip;
	self.phoneno := l.phone;

	self.predir := l.predir;
	self.addr_suffix := l.suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.z4 := l.zip4;
	self.pobox := '';
	self.err_stat := '';
	self.addr1_for_clean := '';
	self.addr2_for_clean := '';	
	self := l;
end;

fpa := project(iter, tra_forPCNSRAppend(left));

frompa := DayBatchPCNSR.Fetch_Batch_PCNSR_Full(fpa, 'AC2A'/*'USPAGE_FL137Z'*/, mod_access);

//***** Append back 
outrec tra_ab(iter l, frompa r) := transform

	self.acctno := l.temp_acctno;
	self.RecordID := l.RecordID;
	self.phone := if(r.phone = '' and length(trim(l.phone)) = 10, l.phone, r.phone);
	string4 str_dfs := ((string6)l.dt_first_seen)[1..4];
	string6 str_dls := ((string6)l.dt_last_seen)[1..6];
	self.addr_crt_dt := if(r.addr_crt_dt = '', str_dfs, r.addr_crt_dt);
	self.addr_upt_dt := if(r.addr_upt_dt = '', str_dls, r.addr_upt_dt);
	
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.suffix := l.name_suffix;
	
	user := r.zip <> '';
	
	self_prim_range := if(user, r.prim_range, l.prim_range);
	self_predir := if(user, r.predir, l.predir);
	self_prim_name := if(user, r.prim_name, l.prim_name);
	self_addr_suffix := if(user, r.addr_suffix, l.suffix);
	self_postdir := if(user, r.postdir, l.postdir);
	self_unit_desig := if(user, r.unit_desig, l.unit_desig);
	self_sec_range := if(user, r.sec_range, l.sec_range);
	self_city := if(user, r.city, l.city_name);
	self_state := if(user, r.state, l.st);
	self_zip := if(user, r.zip, l.zip);
	self_ssn := if(user, r.ssn, l.ssn);
	
	self.prim_range := self_prim_range;
	self.predir := self_predir;
	self.prim_name := self_prim_name;
	self.addr_suffix := self_addr_suffix;
	self.postdir := self_postdir;
	self.unit_desig := self_unit_desig;
	self.sec_range := self_sec_range;
	self.city := self_city;
	self.state := self_state;
	self.zip := self_zip;
	self.ssn := self_ssn;
	
	self.address1 := 
		address.Addr1FromComponents(self_prim_range, self_predir, self_prim_name,
							self_addr_suffix, self_postdir, self_unit_desig, self_sec_range);
	self.address2 := 
		address.Addr2FromComponents(self_city, self_state, self_zip);

	
	self := r;
	
end;

ab := join(group(iter, acctno), frompa, 
					 left.acctno = right.acctno, 
					 tra_ab(left, right), left outer, many lookup);

return sort(group(ab, acctno), -addr_upt_dt, -addr_crt_dt);  //group again looks strange here, but needed since self.acctno := l.temp_acctno

END;