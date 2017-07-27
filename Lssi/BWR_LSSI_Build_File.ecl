import address, lssi, did_add, business_header_ss, header, ut, header_slimsort, didville, business_header;
//this program is to clean, did(bdid) and hhid the lssi update file

lssi_update_file := lssi.file_lssi_in(xcode = 'I');

//clean & parse address
comb_addr_record := record
	layout_in,
	string address_line1,
	string address_line2,
end;

comb_addr_record combine_address(lssi_update_file l) := transform                       
	self.address_line1 := trim(l.hseno) + 
                           trim(l.hsesx) + 
		    		       ' ' + 
				       trim(l.strt);
	self.address_line2 := trim(l.locnm) + 
				       ', ' + 
				       trim(l.state) + 
				       ' ' + 
				       trim(l.zip);
	self := l;
end; 

comb_addr_file := project(lssi_update_file, combine_address(left));

valid_addr_file := comb_addr_file(address_line1 <> '', address_line2 <> '');

address.mac_address_clean(valid_addr_file,
          	           address_line1, 
			           address_line2,
			           true,
			           clean_addr_file1);
					 
invalid_addr_file := comb_addr_file(address_line1 = '' or address_line2 = '');					 
					 
clean_addr_record := record
	comb_addr_record,
	string182 clean,
end;					 

clean_addr_record clean_others(invalid_addr_file l) := transform
	self.clean := AddrCleanLib.CleanAddress182(l.address_line1,l.address_line2);
	self := l;
end;

clean_addr_file2 := project(invalid_addr_file, clean_others(left));

clean_addr_file := clean_addr_file1 + clean_addr_file2;

parse_addr_record := record
	layout_in;
	string10	 prim_range;
	string2  	 predir;
	string28 	 prim_name;
	string4  	 addr_suffix;
	string2  	 postdir;
	string10 	 unit_desig;
	string8  	 sec_range;
	string25 	 p_city_name;
	string25	 v_city_name;
	string2  	 st;
	string5  	 zipcode;
	string4    zip4;
	string4    cart;
	string1    cr_sort_sz;
	string4  	 lot;
	string1 	 lot_order;
	string2  	 dbpc;
	string1    chk_digit;
	string2  	 rec_type;
	string5    countyname;
	string10   geo_lat_val;
	string11   geo_long_val;
	string4    msa;
	string7  	 geo_blk;
	string1    geo_match;
	string4    err_stat;
end;

parse_addr_record parse_address(clean_addr_file l) := transform
	self.prim_range := l.clean[1..10];
	self.predir := l.clean[11..12];
	self.prim_name := l.clean[13..40];
	self.addr_suffix := l.clean[41..44];
	self.postdir := l.clean[45..46];
	self.unit_desig := l.clean[47..56];
	self.sec_range := l.clean[57..64];
	self.p_city_name := l.clean[65..89];
	self.v_city_name := l.clean[90..114];
	self.st := l.clean[115..116];
	self.zipcode := l.clean[117..121];
	self.zip4 := l.clean[122..125];
	self.cart := l.clean[126..129];
	self.cr_sort_sz := l.clean[130];
	self.lot := l.clean[131..134];
	self.lot_order := l.clean[135];
	self.dbpc := l.clean[136..137];
	self.chk_digit := l.clean[138];
	self.rec_type := l.clean[139..140];
	self.countyname := l.clean[141..145];
	self.geo_lat_val := l.clean[146..155];
	self.geo_long_val := l.clean[156..166];
	self.msa := l.clean[167..170];
	self.geo_blk := l.clean[171..177];
	self.geo_match := l.clean[178];
	self.err_stat := l.clean[179..182];
	self := l;
end;

parse_addr_file := project(clean_addr_file, parse_address(left));

//clean phone
clean_phone_record := record
	parse_addr_record;
	string10  clean_phone;
end;

clean_phone_record clean_phone(parse_addr_file l) := transform
	self.clean_phone := address.cleanphone(l.npa + l.telno);
	self := l; 
end;

clean_phone_file := project(parse_addr_file, clean_phone(left));

//clean & parse name
clean_name_record := record
	clean_phone_record;
	string73 clean_name; 
end;

string73 clean_name_str(clean_phone_file l1) :=  
         addrcleanlib.CleanPersonFML73(trim(l1.LSTGN) + ' ' + trim(l1.LSTNM));
	     	   
clean_name_record clean_name(clean_phone_file l2) := transform
	self.clean_name := if((l2.split = '1'),clean_name_str(l2),'');
	self := l2;
end;  

clean_name_file := project(clean_phone_file,clean_name(left));

parse_name_record := record
	clean_phone_record;
	string5    title;
	string20   fname;
	string20   mname;
	string20   lname;
	string5    name_suffix;
	string3    name_error;
end;

integer clean_errorcode(clean_name_file l1) := (integer)(l1.clean_name[71..73]);

parse_name_record parse_name(clean_name_file l2) := transform	
	self.title := if(clean_errorcode(l2) < 70, '', l2.clean_name[1..5]);
	self.fname := if(clean_errorcode(l2) < 70, '', l2.clean_name[6..25]);
	self.mname := if(clean_errorcode(l2) < 70, '', l2.clean_name[26..45]);
	self.lname := if(clean_errorcode(l2) < 70, '', l2.clean_name[46..65]);
	self.name_suffix := if(clean_errorcode(l2) < 70, '', l2.clean_name[66..70]);
	self.name_error := if(clean_errorcode(l2) < 70, '', l2.clean_name[71..73]);
	self := l2;
end;

parse_name_file := project(clean_name_file, parse_name(left));

//clean company
clean_compname_record := record
	parse_name_record;
	string120  clean_compname; 
end;

clean_compname_record clean_compname(parse_name_file l) := transform
	self.clean_compname := if((l.split <> '1'),
                                datalib.CompanyClean(trim(l.LSTNM) + ' ' + trim(l.LSTGN)),
	   			            '');
	self := l;
end;  
  
lssi_clean_file := project(parse_name_file,clean_compname(left)); 

lssi_hhid_did_record := record
	clean_compname_record;
	unsigned8 hhid := 0;
	unsigned6 did := 0;
	unsigned1 did_score := 0;
	unsigned6 b_did := 0;
	unsigned1 b_did_score := 0;
end;

lssi_filepos_record := record
	lssi_hhid_did_record;
	unsigned8 __filepos {virtual(fileposition)};
end;

//build residential hhid
res_lssi := lssi_clean_file(split = '1');
res_lssi_ready := distribute(res_lssi, random());

lssi_filepos_record pre_hhid_tran(res_lssi_ready l) := transform
	self.lname := if(l.lname != '', l.lname, ut.Word(l.fsn, 1));
	self.clean_phone := if((l.lsttyp = '3' OR l.lsttyp = '4'), '', l.clean_phone);
	self := l;
end;

res_lssi_addname := project(res_lssi_ready, pre_hhid_tran(left));
res_lssi_hasname := res_lssi_addname(lname != '');

res_hhid_ready := distribute(res_lssi_hasname, hash(lname,prim_name));

didville.MAC_HHID_Append_By_Address(
	res_hhid_ready, res_hhid_out, hhid, lname,
	prim_range, prim_name, sec_range, st, zipcode)

//build residential did

res_matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex(res_hhid_out,res_matchset,
                       foo,foo,fname,mname,lname,name_suffix,
				   prim_range,prim_name,sec_range,zipcode,st,clean_phone,
				   did,lssi_hhid_did_record,true,did_score,75,res_lssi_out);

//build bdid
bus_lssi := lssi_clean_file(split <> '1');
bus_lssi_ready := distribute(bus_lssi, random());

bus_matchset := ['A', 'P'];

business_header_ss.MAC_Add_BDID_Flex(bus_lssi_ready, bus_matchset,
                                     clean_compname,
				                 prim_range, prim_name, zipcode, 
						       sec_range, st, 
						       clean_phone, foo,
				                 b_did, 
						       lssi_hhid_did_record, 
						       true, b_did_score, 
						       bus_lssi_out);

//merge did, hhided residential records with dided nonresidential records
lssi_build_out := res_lssi_out + bus_lssi_out; 

export bwr_lssi_build_file := lssi_build_out;