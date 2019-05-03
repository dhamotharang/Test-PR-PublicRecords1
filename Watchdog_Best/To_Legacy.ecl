EXPORT To_Legacy(dataset($.Layouts.BestBy_did_child) file, $.mod_sources.flavors flavor) := FUNCTION

	boolean testbit(unsigned4 bits, unsigned4 bit) := IF((bits & bit) = 0, false, true);

	result := PROJECT(file, TRANSFORM($.Layouts.Legacy,
			self.did := left.did;
			ssnum_cases := sort(left.ssnum_cases(testbit(ssnum_data_permits, flavor)),ssnum_method);
			self.ssn := IF(COUNT(ssnum_cases)=0, '', ssnum_cases[1].ssnum_ssn);	// get best ssn available
			dob_cases := sort(left.dob_cases(testbit(dob_data_permits, flavor)),dob_method);
			self.dob := IF(COUNT(dob_cases)=0, 0, dob_cases[1].dob);	// get best dob available
			self.phone := IF(testbit(left.phone_data_permits, flavor), left.phone, '');
			// name
			self.title := IF(testbit(left.title_data_permits, flavor), left.title, '');
			fname_cases := sort(left.fname_cases(testbit(fname_data_permits, flavor)),fname_method);
			self.fname := IF(COUNT(fname_cases)=0, '', fname_cases[1].fname);	
			
			mname_cases := sort(left.mname_cases(testbit(mname_data_permits, flavor)),mname_method);
			self.mname := IF(COUNT(mname_cases)=0, '', mname_cases[1].mname);	
			
			lname_cases := sort(left.lastname_cases(testbit(lastname_data_permits, flavor)),lastname_method);
			self.lname := IF(COUNT(lname_cases)=0, '', lname_cases[1].lastname_lname);	

			self.name_suffix := IF(testbit(left.name_suffix_data_permits, flavor), left.name_suffix, '');
			
			// address
			address_cases := sort(left.address_cases(testbit(address_data_permits, flavor)),address_method);
			self.prim_range := IF(COUNT(address_cases)=0, '', address_cases[1].address_prim_range);
			self.predir := IF(COUNT(address_cases)=0, '', address_cases[1].address_predir);
			self.prim_name := IF(COUNT(address_cases)=0, '', address_cases[1].address_prim_name);
			self.suffix := IF(COUNT(address_cases)=0, '', address_cases[1].address_suffix);
			self.postdir := IF(COUNT(address_cases)=0, '', address_cases[1].address_postdir);
			self.unit_desig := IF(COUNT(address_cases)=0, '', address_cases[1].address_unit_desig);
			self.sec_range := IF(COUNT(address_cases)=0, '', address_cases[1].address_sec_range);
			self.city_name := IF(COUNT(address_cases)=0, '', address_cases[1].address_city_name);
			self.st := IF(COUNT(address_cases)=0, '', address_cases[1].address_st);
			self.zip := IF(COUNT(address_cases)=0, '', address_cases[1].address_zip);
			self.zip4 := IF(COUNT(address_cases)=0, '', address_cases[1].address_zip4);
			self.addr_dt_first_seen := IF(COUNT(address_cases)=0, 0, address_cases[1].address_dt_first_seen);
			self.addr_dt_last_seen := IF(COUNT(address_cases)=0, 0, address_cases[1].address_dt_last_seen);

		));
	return result;

END;
