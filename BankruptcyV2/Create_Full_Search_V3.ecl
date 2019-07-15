import bankruptcyv2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog,mdr,header,lib_stringlib;
export Create_Full_Search_V3(boolean useaid = true) := function

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if(lDate <= rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if(lDate >= rDate, lDate, rDate )));
return out_date ;
end ;

daily_file 	 := BankruptcyV2.file_bankruptcy_search_v3_daily_bip;
fullbasefile := Bankruptcyv2.file_bankruptcy_search_v3_supp_bip;
// Repeat the above process for full file. 

addrawaddress := record
	BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip;
	string100 address_line_1;
	string50 address_line_last;
end;	

addrawaddress addressBaseLayout(Bankruptcyv2.file_bankruptcy_search_v3_supp_bip input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.orig_Addr1,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.orig_city,left,right) + if(input.orig_city <> '',', ',''),left)
									+ trim(input.orig_st,left,right) + ' ' + trim(input.orig_zip5,left,right));

	self	:=	input;
end;

search_full_preAID	:=	distribute(project(Bankruptcyv2.file_bankruptcy_search_v3_supp_bip, addressBaseLayout(left)),hash(tmsid));


AID_base_file := distribute(bankruptcyv2.file_bk_AID,hash(tmsid));

// Join AID base file and search file to populate values for clean address fields
// from AID clean address fields.

BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip getaidaddress(addrawaddress l,AID_base_file r) := transform
self.prim_range := r.AID_Clean_Address.prim_range;
self.predir := r.AID_Clean_Address.predir;
self.prim_name := r.AID_Clean_Address.prim_name;
self.addr_suffix := r.AID_Clean_Address.addr_suffix;
self.postdir := r.AID_Clean_Address.postdir;
self.unit_desig := r.AID_Clean_Address.unit_desig;
self.sec_range := r.AID_Clean_Address.sec_range;
self.p_city_name := r.AID_Clean_Address.p_city_name;
self.v_city_name := r.AID_Clean_Address.v_city_name;
self.st := r.AID_Clean_Address.st;
self.zip := r.AID_Clean_Address.zip;
self.zip4 := r.AID_Clean_Address.zip4;
self.cart := r.AID_Clean_Address.cart;
self.cr_sort_sz := r.AID_Clean_Address.cr_sort_sz;
self.lot := r.AID_Clean_Address.lot;
self.lot_order := r.AID_Clean_Address.lot_order;
self.dbpc := r.AID_Clean_Address.dbpc;
self.chk_digit := r.AID_Clean_Address.chk_digit;
self.rec_type := r.AID_Clean_Address.rec_type;
self.county := r.AID_Clean_Address.county;
self.geo_lat := r.AID_Clean_Address.geo_lat;
self.geo_long := r.AID_Clean_Address.geo_long;
self.msa := r.AID_Clean_Address.msa;
self.geo_blk := r.AID_Clean_Address.geo_blk;
self.geo_match := r.AID_Clean_Address.geo_match;
self.err_stat := r.AID_Clean_Address.err_stat;
self := l;
end;


search_full_with_address := dedup(sort(join(search_full_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'S'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),record,local),record,local);


BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip getrecordswithnoaddress(addrawaddress l) := transform
	self := l;
end;

search_full_with_no_address := project(search_full_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));

search_full := search_full_with_address + search_full_with_no_address;


Full_BK_search_refresh := join(search_full , daily_file, left.tmsid = right.tmsid, //and left.source = right.source
                     transform({recordof(BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip)},
				     self := left),left only) ;


// Full File - Distributed

//Full_BK_search := distribute(Full_BK_search_refresh,hash(tmsid));
//file_daily_dist := distribute(daily_file,hash(tmsid)); 

// Add Full File and Daily File - If no new production header is available and if the current day is
// saturday or sunday DID full file, if not daily
// Change to SUnday
daily_plus_full := 	if(useaid, Full_BK_search_refresh + daily_file, fullbasefile + daily_file); 

daily_plus_full_dist := distribute(daily_plus_full,hash(tmsid));
// Sort and Dedup locally
//VC DF-23049: Replaced last_seen_date with process date. Last_seen is same as first seen in many instances and results in faulty rollup	
full_sort  :=sort(daily_plus_full_dist,TMSID,orig_case_number,SSN,TAX_ID,
             fname,mname,lname,name_suffix,cname,prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name,v_city_name, st, zip, zip4, county,
             name_type,debtor_type,-process_date,debtor_seq,local);   

BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip  rolluplatestparties(BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip l, BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip r) := transform
		self.Date_First_Seen := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
		self.Date_Last_Seen  := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
		self.Date_Vendor_First_Reported := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);
		self.source_rec_id							:= if(l.source_rec_id <> 0, l.source_rec_id, r.source_rec_id);		
		self.process_Date  := formatlatestdates(l.process_Date ,r.process_Date);
		self := l;
end;

// As a part of AID change, included orig_addr fields in the rollup 
// because AID return similar results for some P O BOX addresses so records were rolled
// up

full_file_rollup := rollup(full_sort,left.tmsid = right.tmsid and left.orig_case_number= right.orig_case_number
    and left.ssn = right.ssn and left.TAX_ID = right.tax_id 
    and left.fname= right.fname and left.mname = right.mname and left.lname= right.lname
    and left.name_suffix= right.name_suffix and left.cname = right.cname and left.orig_addr1 = right.orig_addr1 and 
	left.orig_addr2 = right.orig_addr2 and left.orig_city = right.orig_city and left.orig_st = right.orig_st 
	and left.orig_zip5 = right.orig_zip5 and left.orig_zip4 = right.orig_zip4 and left.prim_range= right.prim_range and 
    left.predir= right.predir and left.prim_name= right.prim_name and  left.addr_suffix= 
    right.addr_suffix and left.postdir= right.postdir and left.unit_desig= right.unit_desig and 
    left.sec_range = right.sec_range and left.p_city_name= right.p_city_name and left.v_city_name= right.v_city_name
    and left.st = right.st and left.zip = right.zip  and left.zip4= right.zip4
    and left.county= right.county and if(left.name_type[1]='A' and right.name_type[1]='A' or 
	  left.name_type='D' and right.name_type='D' or
		left.name_type[1]='T' and right.name_type[1]='T',true,false) and left.debtor_type =right.debtor_type , rolluplatestparties(LEFT,RIGHT),local); 

//Add the source_rcid to records
UT.MAC_Append_Rcid(full_file_rollup, source_rec_id, ds_output_recids);
	
	retval :=  ds_output_recids;
	
	return retval;
	
end;