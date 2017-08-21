import address, lssi, did_add, business_header_ss, header, ut, header_slimsort, didville, business_header,_control,instantid_logs, aid, address, ut, did_add, header_slimsort, didville, header, address, watchdog, yellowpages, gong, cellphone, risk_indicators, lib_stringlib;
//this program is to clean, did(bdid) and hhid the lssi update file

lssi_update_file := lssi.file_lssi_in(xcode = 'I');

//clean & parse address
comb_addr_record := record
	layout_in,
	string address_line1,
	string address_line2,
	unsigned8 rawAIDin := 0;
end;

comb_addr_record combine_address(lssi_update_file l) := transform                       
	self.address_line1 := stringlib.stringtouppercase(trim(l.hseno) + ' ' +
				        if(trim(l.hsesx)  <> '', trim(l.hsesx)  +  ' ', '') +
				       trim(l.strt));
	self.address_line2 := stringlib.stringtouppercase(trim(l.locnm) + 
				        if(l.state <> '', ', ' + trim(l.state) , '') +
				       ' ' + 
				       trim(l.zip[1..5]));
	self := l;
end; 

comb_addr_file := project(lssi_update_file, combine_address(left));

//valid_addr_file := comb_addr_file(address_line1 <> '', address_line2 <> '');

//address.mac_address_clean(valid_addr_file,
          	         //  address_line1, 
			           //address_line2,
			           //true,
			           //clean_addr_file1);
					 
//invalid_addr_file := comb_addr_file(address_line1 = '' or address_line2 = '');					 
					 
clean_addr_record := record
	comb_addr_record,
	string182 clean,
end;					 

////////////////// AID APPENDS ////////////////////////////////////////////////////////////////////////////

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;
	
aid.MacAppendFromRaw_2Line(comb_addr_file, 
														address_line1, address_line2,
														rawAIDin, historical_out, laidappendflags);

cleaned := historical_out : persist('~thor400_84::persist::lssi::clean',_Control.TargetQueue.BDL_400);
// cleaned := dataset('~thor400_88_staging::persist::infutorcid::clean',recordof(historical_out), thor);

DenormedRecOut := RECORD
comb_addr_record;

/* AID fields */
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zipcode;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string5 countyname;
   string10 geo_lat_val;
   string11 geo_long_val;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;

END;

DenormedRecOut tNormAidAppends(recordof(cleaned) l) := TRANSFORM
 SELF.rawAIDin := 		L.aidwork_rawaid;
 SELF.prim_range := 	L.aidwork_acecache.prim_range;
 SELF.predir := 	L.aidwork_acecache.predir;
 SELF.prim_name := 	L.aidwork_acecache.prim_name;
 SELF.addr_suffix := 	L.aidwork_acecache.addr_suffix;
 SELF.postdir := 	L.aidwork_acecache.postdir;
 SELF.unit_desig := 	L.aidwork_acecache.unit_desig;
 SELF.sec_range := 	L.aidwork_acecache.sec_range;
 SELF.p_city_name := 	L.aidwork_acecache.p_city_name;
 SELF.v_city_name := 	L.aidwork_acecache.v_city_name;
 SELF.st := 	L.aidwork_acecache.st;
 SELF.zipcode := 	L.aidwork_acecache.zip5;
 SELF.zip4 := 	L.aidwork_acecache.zip4;
 SELF.cart := 	L.aidwork_acecache.cart;
 SELF.cr_sort_sz := 	L.aidwork_acecache.cr_sort_sz;
 SELF.lot := 	L.aidwork_acecache.lot;
 SELF.lot_order := 	L.aidwork_acecache.lot_order;
 SELF.dbpc := 	L.aidwork_acecache.dbpc;
 SELF.chk_digit := 	L.aidwork_acecache.chk_digit;
 SELF.rec_type := 	L.aidwork_acecache.rec_type;
 SELF.countyname := 	L.aidwork_acecache.county;
 SELF.geo_lat_val := 	L.aidwork_acecache.geo_lat;
 SELF.geo_long_val := 	L.aidwork_acecache.geo_long;
 SELF.msa := 	L.aidwork_acecache.msa;
 SELF.geo_blk := 	L.aidwork_acecache.geo_blk;
 SELF.geo_match := 	L.aidwork_acecache.geo_match;
 SELF.err_stat := 	L.aidwork_acecache.err_stat;
 SELF := L;
END;

clean_addr_file := NORMALIZE(cleaned, 1, tNormAidAppends(LEFT));


 parse_addr_record := record
	 layout_in;
	unsigned8 rawAIDin := 0;
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
	self := l;
end;

parse_addr_file := project(clean_addr_file, parse_address(left)) : persist('~thor_200::persist::lssi::normclean', _Control.TargetQueue.thor_200);
// parse_addr_file := dataset('~thor_200::persist::lssi::normclean', recordof(parse_addr_record), thor);

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
         Address.CleanPersonFML73(trim(l1.LSTGN) + ' ' + trim(l1.LSTNM));
	     	   
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
res := res_lssi_out: persist('~thor_data400::persist::resDID',_control.TargetQueue.ADL_400);
bus := bus_lssi_out: persist('~thor_data400::persist::busDID',_control.TargetQueue.ADL_400); 

lssi_build_out := res+bus;
export bwr_lssi_build_file := lssi_build_out;