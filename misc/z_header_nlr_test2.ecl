import header,header_quick,experiancred,ut;

test_set := [9999999999999
,18319611
,5020211
,6030681
,11493131
,14608861
,18987971
,10000001,10000002,10000003,10000004
,165058936541
];

// full data files
my_hdr 	:= Header.file_headers(src in ['EN']);
// my_eq 	:= header_quick.file_header_quick;
my_en		:= Experiancred.files.base_file_out;

my_header_nlr := header.key_nlr_payload(did in test_set);

layout_results := record
	string1 eq_did_flag		:= '';
	string1 eq_name_flag	:= '';
	string1 eq_addr_flag	:= '';
	string1 eq_dob_flag		:= '';
	string1 eq_phone_flag	:= '';
	string1 eq_ssn_flag		:= '';
	string1 eq_lname_flag	:= '';
	//
	string1 en_did_flag		:= '';
	string1 en_name_flag	:= '';
	string1 en_addr_flag	:= '';
	string1 en_dob_flag		:= '';
	string1 en_ssn_flag		:= '';
	string1 en_phone_flag	:= '';
	string1 en_lname_flag	:= '';
	//
	recordof(my_header_nlr);
	end;
	
layout_results get_bits(my_header_nlr l) := transform
	self.en_did_flag 		:= if(ut.bit_test(l.not_in_bureau, 15),'x','');
	self.en_name_flag 	:= if(ut.bit_test(l.not_in_bureau, 14),'x','');
	self.en_addr_flag 	:= if(ut.bit_test(l.not_in_bureau, 13),'x','');
	self.en_dob_flag 		:= if(ut.bit_test(l.not_in_bureau, 12),'x','');
	self.en_ssn_flag 		:= if(ut.bit_test(l.not_in_bureau, 11),'x','');
	self.en_phone_flag 	:= if(ut.bit_test(l.not_in_bureau, 10),'x','');
	self.en_lname_flag 	:= if(ut.bit_test(l.not_in_bureau,  9),'x','');

	self.eq_did_flag 		:= if(ut.bit_test(l.not_in_bureau,  7),'x','');
	self.eq_name_flag 	:= if(ut.bit_test(l.not_in_bureau,  6),'x','');
	self.eq_addr_flag 	:= if(ut.bit_test(l.not_in_bureau,  5),'x','');
	self.eq_dob_flag 		:= if(ut.bit_test(l.not_in_bureau,  4),'x','');
	self.eq_ssn_flag 		:= if(ut.bit_test(l.not_in_bureau,  3),'x','');
	self.eq_phone_flag 	:= if(ut.bit_test(l.not_in_bureau,  2),'x','');
	self.eq_lname_flag 	:= if(ut.bit_test(l.not_in_bureau,  1),'x','');
	self := l;
	end;
my_header_nlr2 := project(my_header_nlr,get_bits(left));

output(sort(my_hdr(did in test_set),
			 did,rid,lname,fname,mname,name_suffix,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,phone,dob,ssn),
			{did,rid,vendor_id,src,lname,fname,mname,name_suffix,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,phone,dob,ssn},
			named('header'));
// output(sort(my_eq(did in test_set),
			 // did,lname,fname,mname,name_suffix,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,phone,dob,ssn),
			// {did,vendor_id,lname,fname,mname,name_suffix,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,phone,dob,ssn},
			// named('equifax'));
output(sort(my_en(did in test_set),
			 did,lname,fname,mname,name_suffix,zip,v_city_name,predir,prim_name,addr_suffix,postdir,prim_range,sec_range,telephone,date_of_birth,social_security_number),
 			{did,encrypted_experian_pin,lname,fname,mname,name_suffix,zip,v_city_name,predir,prim_name,addr_suffix,postdir,prim_range,sec_range,telephone,date_of_birth,social_security_number,delete_flag,suppression_code},	
			named('experian'));
output(sort(my_header_nlr2(did in test_set),
		 did,lname,fname,mname,name_suffix,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,phone,dob,ssn),
 			{		eq_did_flag,en_did_flag,did,rid,vendor_id,src,
						eq_lname_flag,eq_name_flag,en_lname_flag,en_name_flag,lname,fname,mname,name_suffix,
						eq_addr_flag,en_addr_flag,zip,city_name,predir,prim_name,suffix,postdir,prim_range,sec_range,
						eq_dob_flag,en_dob_flag,dob,
						eq_ssn_flag,en_ssn_flag,ssn,
						eq_phone_flag,en_phone_flag,phone,
						not_in_bureau},
		named('result'));

