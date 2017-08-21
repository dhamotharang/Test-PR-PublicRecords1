v := Vehicles_Joined;

layout_slim_vehreg_v3 take_person(v l, unsigned8 cnt) := transform
		self.seq_no := l.seq_no;
		self.node := thorlib.node();
		self.rec_source := Choose(cnt,'own_1','own_2','reg_1','reg_2');
		self.FEID_SSN := choose(cnt,l.own_1_feid_ssn,l.own_2_feid_ssn,l.reg_1_feid_ssn,l.reg_2_feid_ssn);
		self.DRIVER_LICENSE_NUMBER := choose(cnt,l.own_1_DRIVER_LICENSE_NUMBER,l.own_2_DRIVER_LICENSE_NUMBER,l.reg_1_DRIVER_LICENSE_NUMBER,l.reg_2_DRIVER_LICENSE_NUMBER);
		self.DOB := choose(cnt,l.own_1_DOB,l.own_2_DOB,l.reg_1_DOB,l.reg_2_DOB);
		self.prim_range := choose(cnt,l.own_1_prim_range,l.own_2_prim_range,l.reg_1_prim_range,l.reg_2_prim_range);
		self.prim_name := choose(cnt,l.own_1_prim_name,l.own_2_prim_name,l.reg_1_prim_name,l.reg_2_prim_name);
		self.sec_range := choose(cnt,l.own_1_sec_range,l.own_2_sec_range,l.reg_1_sec_range,l.reg_2_sec_range);
		self.st := choose(cnt,l.own_1_state_2,l.own_2_state_2,l.reg_1_state_2,l.reg_2_state_2);
		self.zip5 := choose(cnt,l.own_1_zip5,l.own_2_zip5,l.reg_1_zip5,l.reg_2_zip5);
		self.fname := 	 choose(cnt,l.own_1_fname,l.own_2_fname,l.reg_1_fname,l.reg_2_fname);
		self.mname := 	 choose(cnt,l.own_1_mname,l.own_2_mname,l.reg_1_mname,l.reg_2_mname);
		self.lname := 	 choose(cnt,l.own_1_lname,l.own_2_lname,l.reg_1_lname,l.reg_2_lname);
		self.name_suffix := choose(cnt,l.own_1_name_suffix,l.own_2_name_suffix,l.reg_1_name_suffix,l.reg_2_name_suffix);
		self.company_name := choose(cnt,l.own_1_company_name, L.own_2_company_name, L.reg_1_company_name, L.reg_2_company_name);
		self.DID := 0;
		self.BDID := 0;
		self.preGLB_DID := 0;
		self.ssn := if((integer)self.feid_ssn > 999999 and self.fname <> '' and self.lname <> '', 
					   self.feid_ssn, 
					   '');

  end;


res := normalize(v,4,take_person(left,counter));

export Vehicles_Contacts_Undid := res(fname<>'' or lname<>'' or company_name != '');