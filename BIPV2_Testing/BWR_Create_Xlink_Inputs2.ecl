import BIPV2_Testing,business_dot,bipv2;

/* ****************
W20130726-123557 is where property was subsequently added
**************** */

size_sample := 5000;

allem := dataset('~thor_data400::bipv2::xlink::allv2', BIPV2_Testing.layouts.xlink, flat);

import BankruptcyV2;
dBK := BankruptcyV2.file_bankruptcy_search(cname <> '');
dBKFiltered:=enth(Business_DOT.Files.city_samp(dBK,st,v_city_name), size_sample);
dBKP :=
project(
	dBKFiltered,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter + (4*size_sample);
		self.src := 'BK';
		self.bdid_input := (unsigned6)left.bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		

		self.company_name := left.cname;
		self.company_prim_range := left.prim_range;
		self.company_prim_name := left.prim_name;
		self.company_zip := left.zip;
		self.company_sec_range := left.sec_range;
		self.company_city := left.v_city_name;
		self.company_state := left.st;
		self.company_phone := left.phone;
		self.company_fein := left.tax_id;

		self.email_address := '';									
		self.fname := left.fname;	
		self.mname := left.mname;	
		self.lname := left.lname;			
		
	)
) : persist('~thor_data400::bipv2::xlink::BK');

allem2 := allem & dBKP;
output(allem2,,'~thor_data400::bipv2::xlink::allv3', overwrite);
