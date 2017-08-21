IMPORT BIPV2, business_header,ut;


layout_BIPV2_DS_BASE_slim :=
	RECORD
		unsigned6   rcid := 0;
		string2   	source := '';	
		unsigned6   proxid := 0;
		unsigned6   seleid := 0;
		string1   	iscontact := '';
		string20   	fname := '';
		string20   	mname := '';
		string20   	lname := '';
		string120   company_name := '';
		string50   	company_name_type_raw := '';
		string50   	company_name_type_derived := '';
		unsigned8   company_rawaid := 0;
		unsigned8   company_aceaid := 0;
		string25   	v_city_name := '';
		string250   corp_legal_name := '';
		string250   dba_name := '';
		unsigned4   dt_first_seen := 0;
		unsigned4   dt_last_seen := 0;
		unsigned4   dt_vendor_first_reported := 0;
		unsigned4   dt_vendor_last_reported := 0;
		unsigned6   company_bdid := 0;
		string10   	company_phone := '';
		string1   	phone_type := '';
		string8   	company_sic_code1 := '';
		string8   	company_sic_code2 := '';
		string8   	company_sic_code3 := '';
		string8   	company_sic_code4 := '';
		string8   	company_sic_code5 := '';
		string6   	company_naics_code1 := '';
		string6   	company_naics_code2 := '';
		string6   	company_naics_code3 := '';
		string6   	company_naics_code4 := '';
		string6   	company_naics_code5 := '';
		string34   	vl_id := '';
		boolean   	current := '';
		unsigned6   contact_did := 0;
		string50   	company_status_derived := '';
		string30   	contact_status_derived := '';
	END;
	
BIPV2_DS_BASE_slim	:= PROJECT(BIPV2.CommonBase.DS_BASE, layout_BIPV2_DS_BASE_slim);
//-----

//"Old" Business Header
ds_Business_Header_base := DATASET(ut.foreign_prod+'thor_data400::BASE::Business_Header', business_header.Layout_Business_Header_Base, THOR);

//-----

//// Just going to hit Business Contacts.	////

layout_BusContacts := business_header.Layout_Business_Contact_Full_new;
ds_Business_Contacts_Base := DATASET(ut.foreign_prod + 'thor_data400::BASE::Business_Contacts_qa', layout_BusContacts, THOR);


EXPORT Compliance.Layout_Out_v3 xfmBHDR(layout_BusContacts LE, Compliance.Layout_orig_out RI) := 
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
		self.zip := (qstring5) LE.company_zip;
		self.zip4 := (qstring4) LE.company_zip4;
//		self.RawAID := (unsigned8) LE.company_rawaid;
		
		self.listed_name := LE.company_name;
		self.county_name := LE.company_title;
		
		self.source_value := LE.source;
		
		self.dppa := RI.dppa;
						
		SELF := LE;
		SELF := RI;
	END;