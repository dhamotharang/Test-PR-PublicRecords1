IMPORT Email_Data,ut;

layout_EMAIL := Email_Data.Layout_Email.Scrubs_bits_base;

Base_Email_Addr := DATASET(ut.foreign_prod + 'thor_data400::base::email_data', layout_EMAIL, THOR);


EXPORT Compliance.Layout_Out_v3 xfmEMAIL(layout_EMAIL LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.email_src;
		self.did := (unsigned6) LE.did;
		self.rid := (unsigned6) LE.email_rec_key;
		self.vendor_id := LE.clean_email;
		self.ssn := LE.best_ssn;
		self.dob := LE.best_dob;
		self.dt_first_seen := (unsigned3) LE.date_first_seen;
		self.dt_last_seen := (unsigned3) LE.date_last_seen;
		self.dt_vendor_last_reported := (unsigned3) LE.date_vendor_last_reported;
		self.dt_vendor_first_reported := (unsigned3) LE.date_vendor_first_reported;
		self.title := LE.clean_name.title;
		self.fname := LE.clean_name.fname;
		self.mname := LE.clean_name.mname;
		self.lname := LE.clean_name.lname;
		self.name_suffix := LE.clean_name.name_suffix;
		self.prim_range := LE.clean_address.prim_range;
		self.predir := LE.clean_address.predir;
		self.prim_name := LE.clean_address.prim_name;
		self.suffix := LE.clean_address.addr_suffix;
		self.postdir := LE.clean_address.postdir;
		self.unit_desig := LE.clean_address.unit_desig;
		self.sec_range := LE.clean_address.sec_range;
		self.city_name := LE.clean_address.v_city_name;
		self.st := LE.clean_address.st;
		self.zip := LE.clean_address.zip;
		self.zip4 := LE.clean_address.zip4;
		
		self.source_value := LE.email_src;
						
		SELF := LE;
		SELF := RI;
	END;