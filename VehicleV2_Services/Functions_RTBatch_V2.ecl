import Autokey_batch,address,didville,ut, VehicleV2_Services, STD;

today := (STRING8)Std.Date.Today();

export Functions_RTBatch_V2 := module
	
	export clean(dataset(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2) ds, VehicleV2_Services.IParam.RTBatch_V2_params in_mod) := function
// boolean use_year, string yr_since,boolean checkdate = False

		boolean use_year := in_mod.select_years and in_mod.years > 0;
		yr_today := (integer) today[1..4];
		yr_since := (string) (yr_today - in_mod.years);
		boolean checkdate := in_mod.use_date;

		VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 clean(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2 le) := transform
		// Converted name to uppercase as -Filter on first name-vixie ,Last Name-Inkhothavong was not working for VehicleV2_Services.RealTime_Batch_Service_V2_records.
			is_fullname := le.name_full <> '';
			cn := address.CleanNameFields(address.CleanPerson73(stringLib.stringToUpperCase(le.name_full)));
			self.name_first := if(is_fullname, cn.fname, stringLib.stringToUpperCase(le.name_first));
			self.name_middle := if(is_fullname, cn.mname, stringLib.stringToUpperCase(le.name_middle));
			self.name_last := if(is_fullname, cn.lname, stringLib.stringToUpperCase(le.name_last));
			self.name_suffix := if(is_fullname, cn.name_suffix, stringLib.stringToUpperCase(le.name_suffix));
			// address
			a1 := trim(le.addr1) + ' ' + le.addr2;
			a2 := le.p_city_name + ' ' + le.st + ' ' + le.z5;
			ca := address.GetCleanAddress(a1, a2, 0).results; // 0: USA, 1: Canada
			self.prim_range := ca.prim_range;
			self.predir := ca.predir;
			self.prim_name := ca.prim_name;
			self.addr_suffix := ca.suffix;
			self.postdir := ca.postdir;
			self.unit_desig := ca.unit_desig;
			self.sec_range := ca.sec_range;
			self.p_city_name := ca.p_city;
			self.st := if(ca.state<>'',ca.state,le.st);
			self.z5 := ca.zip;
			self.zip4 := ca.zip4;
			self.date := MAP( use_year => yr_since
											,~checkdate => ''
											, le.date);
			self.make  := stringlib.stringtouppercase(trim(le.make, left, right));
			self.model := stringlib.stringtouppercase(trim(le.model, left, right));
			self.dob := if(LENGTH(TRIM(le.dob))=8 and le.dob<>'',trim(le.dob, left, right),'');
			self.ssn := trim(le.ssn, left, right);
			self.comp_name := stringlib.stringtouppercase(trim(le.comp_name, left, right));
			self := le;
		end;
		return project(ds, clean(left));
	end;

	EXPORT boolean ValidExpirationDate(string date_exp) := function
    days_2yr := ut.DaysInNYears(2);
		days_apart := ut.DaysApart(today, date_exp);
		is_exp := (integer) today - (integer) date_exp >= 0;
		return not(is_exp and days_apart >= days_2yr);
	end;
	
	// returns the min of two dates (unless one is empty)
	EXPORT string min_date(string l, string r) :=		
	FUNCTION
		return if(l<>'' and r<>'', min(l, r), if(l<>'', l, r)); 
	END;	
	
	export VehicleV2_Services.Batch_Layout.LicPlate_InLayout to_licplate (VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 le) := transform
		SELF.plateState := IF(le.plateState<>'',le.plateState,le.st);
		self.color := '';
		self := le;
	end;
	
	export VehicleV2_Services.Batch_Layout.Vin_BatchIn to_vin (VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 le) := transform
		self.vin := le.vinin;
		self := le;
	end;

	export DidVille.Layout_Did_OutBatch to_reg1(VehicleV2_Services.Layouts_RTBatch_V2.rec_out le) := transform
		self.seq := le.seq;
		self.fname := le.reg_1_fname;
		self.mname := le.reg_1_mname;
		self.lname := le.reg_1_lname;
		self.suffix := le.reg_1_name_suffix;
		a1 := le.reg_1_addr1 + ' ' + le.reg_1_addr2;
		a2 := le.reg_1_v_city_name + ' ' + le.reg_1_state + ' ' + le.reg_1_zip;
		ca := address.GetCleanAddress(a1, a2, 0).results;
		self.prim_range := ca.prim_range;
		self.predir := ca.predir;
		self.prim_name := ca.prim_name;
		self.addr_suffix := ca.suffix;
		self.postdir := ca.postdir;
		self.unit_desig := ca.unit_desig;
		self.sec_range := ca.sec_range;
		self.p_city_name := ca.p_city;
		self.st := ca.state;
		self.z5 := ca.zip;
		self.zip4 := ca.zip4;
		self := [];
	end;

	export DidVille.Layout_Did_OutBatch to_reg2(VehicleV2_Services.Layouts_RTBatch_V2.rec_out le) := transform
		self.seq := le.seq;
		self.fname := le.reg_2_fname;
		self.mname := le.reg_2_mname;
		self.lname := le.reg_2_lname;
		self.suffix := le.reg_2_name_suffix;
		a1 := le.reg_2_addr1 + ' ' + le.reg_2_addr2;
		a2 := le.reg_2_v_city_name + ' ' + le.reg_2_state + ' ' + le.reg_2_zip;
		ca := address.GetCleanAddress(a1, a2, 0).results;
		self.prim_range := ca.prim_range;
		self.predir := ca.predir;
		self.prim_name := ca.prim_name;
		self.addr_suffix := ca.suffix;
		self.postdir := ca.postdir;
		self.unit_desig := ca.unit_desig;
		self.sec_range := ca.sec_range;
		self.p_city_name := ca.p_city;
		self.st := ca.state;
		self.z5 := ca.zip;
		self.zip4 := ca.zip4;
		self := [];
	end;

end;