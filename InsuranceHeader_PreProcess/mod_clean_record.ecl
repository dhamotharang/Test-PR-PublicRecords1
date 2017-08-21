import idl_header, ngadl;
export mod_clean_record(dataset(idl_header.Layout_Header_Link) ds) := module

	idl_header.Layout_Header_Link cleanNameAddress(ds l) := transform

		// Clean Name
		cleanName := InsuranceHeader_PreProcess.mod_clean_name(trim(l.sname), trim(l.fname), trim(l.mname), trim(l.lname));
		self.sname := cleanName.suffix_name;
		self.fname := cleanName.first_name;
		self.mname := cleanName.middle_name;
		self.lname := cleanName.last_name;

		// Clean Address
		cleanAddress := InsuranceHeader_PreProcess.mod_clean_address(trim(l.prim_name), trim(l.sec_range));
		self.sec_range := cleanAddress.secRange;
		
		self := l;
	end;

// Clean Name And Address
r1 := project(ds, cleanNameAddress(left));

// Clean POBox and RR
mod2 := NGADL.mod_StandardizeBoxes(r1);

export records := mod2.records;

end;