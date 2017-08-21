IMPORT POE,ut;

layout_POE := POE.Layouts.Base;

base_POE_WPL := DATASET(ut.foreign_prod+ 'thor_data400::base::poe::qa::data', POE.Layouts.Base, thor);


EXPORT Compliance.Layout_Out_v3 xfmPOE(layout_POE LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.source;
		self.did := (unsigned6) LE.did;
		self.rid := (unsigned6) LE.bdid;
		self.vendor_id := LE.vendor_id;
		self.ssn := (qstring9) LE.subject_ssn;
		self.dob := LE.subject_dob;
		self.phone := (qstring10) LE.company_phone;
		self.dt_first_seen := (unsigned3) LE.dt_first_seen;
		self.dt_last_seen := (unsigned3) LE.dt_last_seen;
		self.title := LE.subject_name.title;
		self.fname := LE.subject_name.fname;
		self.mname := LE.subject_name.mname;
		self.lname := LE.subject_name.lname;
		self.name_suffix := LE.subject_name.name_suffix;
		self.prim_range := LE.company_address.prim_range;
		self.predir := LE.company_address.predir;
		self.prim_name := LE.company_address.prim_name;
		self.suffix := LE.company_address.addr_suffix;
		self.postdir := LE.company_address.postdir;
		self.unit_desig := LE.company_address.unit_desig;
		self.sec_range := LE.company_address.sec_range;
		self.city_name := LE.company_address.city_name;
		self.st := LE.company_address.st;
		self.zip := LE.company_address.zip;
		self.zip4 := LE.company_address.zip4;
		self.RawAID := (unsigned8) LE.company_rawaid;
		
		self.listed_name := LE.company_name;
		
		self.source_value := LE.source;
						
		SELF := LE;
		SELF := RI;
	END;