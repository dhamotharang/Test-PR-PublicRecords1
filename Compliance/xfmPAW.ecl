IMPORT PAW,ut;

layout_PAW := paw.Layout.Employment_Out;

base_PAW := DATASET(ut.foreign_prod+ 'thor_data400::base::paw::qa::data', layout_PAW, thor);


EXPORT Compliance.Layout_Out_v3 xfmPAW(layout_PAW LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.source;
		self.did := (unsigned6) LE.did;
		self.rid := (unsigned6) LE.bdid;
		self.vendor_id := LE.vendor_id;
		self.ssn := (qstring9) LE.ssn;
		
		self.phone := (qstring10) LE.company_phone;
		self.dt_first_seen := (unsigned3) LE.dt_first_seen;
		self.dt_last_seen := (unsigned3) LE.dt_last_seen;
		self.title := LE.title;
		self.fname := LE.fname;
		self.mname := LE.mname;
		self.lname := LE.lname;
		self.name_suffix := LE.name_suffix;
		self.prim_range := LE.company_prim_range;
		self.predir := LE.company_predir;
		self.prim_name := LE.company_prim_name;
		self.suffix := LE.company_addr_suffix;
		self.postdir := LE.company_postdir;
		self.unit_desig := LE.company_unit_desig;
		self.sec_range := LE.company_sec_range;
		self.city_name := LE.company_city;
		self.st := LE.company_state;
		self.zip := LE.company_zip;
		self.zip4 := LE.company_zip4;
		self.RawAID := (unsigned8) LE.company_rawaid;
		
		self.listed_name := LE.company_name;
		self.county_name := LE.company_title;
		
		self.source_value := LE.source;
						
		SELF := LE;
		SELF := RI;
	END;