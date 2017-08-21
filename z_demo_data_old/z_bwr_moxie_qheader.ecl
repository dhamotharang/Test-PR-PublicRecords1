import header,mdr,address,ut,header_services,header_quick;	
	
	// Moxie Keys built on demo thor and DKC'ed automatically
	
	addr1 := header.File_Headers(header.isPreGLB(header.File_Headers));
	addr2 := addr1(not mdr.Source_is_DPPA(src));
	header.MAC_Best_Address(addr2, did, 4, b)

    //note RID sequencing is not necessary for moxie
	header.mac_despray(header.File_Headers, b, full_out)
	
		rFullOut := record // Referenced string_rec layout in header.MAC_Despray
		string12 did;
		string12 rid;
		string1  src;
		string1 src2;
		string6  dt_first_seen;
		string6  dt_last_seen;
		string6  dt_vendor_last_reported;
		string6  dt_vendor_first_reported;
		string6  dt_nonglb_last_seen;
		string1  rec_type;
		string18 vendor_id;
		string10 phone;
		string9  ssn;
		string8  dob;
		string5  title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5  name_suffix;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 city_name;
		string2  st;
		string5  zip;
		string4  zip4;
		string3  county;
		string4  msa;
		string1  tnt;  
		string1  valid_ssn;
	end;


	rFullOut tSuppress(full_out l) := transform
	  self.src2 := l.src[2];
		self := l;
	end;

	full_out_suppress := project(full_out,tsuppress(left));


export bwr_moxie_qheader := sequential(
															output(full_out_suppress,,'~thor_data400::out::eq_header',overwrite)
															,Header.moxie_quick_header_keys_Part_10
										,Header.moxie_quick_header_keys_Part_8
										,Header.moxie_quick_header_keys_Part_1
										,Header.moxie_quick_header_keys_Part_3
										,Header.moxie_quick_header_keys_Part_4
										,Header.moxie_quick_header_keys_Part_7
										,Header.moxie_quick_header_keys_Part_9
										,output(header_quick.dkc_quick_hdr('edata12','/thor_back5/local_data/demo/quick_header'))
										
														);