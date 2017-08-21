import bankruptcyV2, address;

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate <= (unsigned8)rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate >= (unsigned8)rDate, lDate, rDate )));
return out_date ;
end ;

file_in1 	:= 	BankruptcyV2.File_Bankruptcy_search_in;

file_in 	:= file_in1(latestFlag = '1'); 

//set Debtor sequence. 
sort_file := sort(file_in(name_type='D') , tmsid,debtor_type); 
sort_file_grd := group(sort_file,tmsid,debtor_type);
 
sort_file_grd tkeepseq(sort_file_grd L, sort_file_grd R) := transform
   self.debtor_seq   := (string)(intformat(((integer)l.debtor_seq)+1,3,1)) ;
   self := r;
end;

set_sequence := group(iterate(sort_file_grd, tkeepseq(left, right))) + file_in(name_type <>'D');

//added filter W20070817-175446 dataland cng

BankruptcyV2.layout_bankruptcy_search_v3_supp treformat(BankruptcyV2.layout_bankruptcy_search_in L) := transform

self.title       		:= 	L.clean_name[1..5] ;
self.fname       		:= 	if((trim(L.clean_name[6..25]) = 'NOT' or regexfind('(INFORMATIO)|(INFORAMTION)', L.clean_name[6..25])) and regexfind('(VAILABLE)', L.clean_name[46..65]), '', L.clean_name[6..25]);
self.mname       		:= 	L.clean_name[26..45];
self.lname       		:= 	if((trim(L.clean_name[6..25]) = 'NOT' or regexfind('(INFORMATIO)|(INFORAMTION)', L.clean_name[6..25])) and regexfind('(VAILABLE)', L.clean_name[46..65]), '', L.clean_name[46..65]);
self.name_suffix 		:= 	L.clean_name[66..70];
self.name_score  		:= 	L.clean_name[71..73];

self.prim_range			:=	L.clean_address[1..10];
self.predir				:=	L.clean_address[11..12];
self.prim_name			:=	L.clean_address[13..40];
self.addr_suffix		:=	L.clean_address[41..44];
self.postdir			:=	L.clean_address[45..46];
self.unit_desig			:= 	L.clean_address[47..56];
self.sec_range			:= 	L.clean_address[57..64];
self.p_city_name		:= 	L.clean_address[65..89];
self.v_city_name		:= 	L.clean_address[90..114];
self.st					:= 	L.clean_address[115..116];
self.zip				:=	L.clean_address[117..121];
self.zip4				:=	L.clean_address[122..125];
self.cart				:=	L.clean_address[126..129];
self.cr_sort_sz			:=	L.clean_address[130];
self.lot				:=	L.clean_address[131..134];
self.lot_order			:=	L.clean_address[135];
self.dbpc				:=	L.clean_address[136..137];
self.chk_digit			:=	L.clean_address[138];
self.rec_type			:=	L.clean_address[139..140];
self.county				:=	L.clean_address[141..145];
self.geo_lat			:=	L.clean_address[146..155];
self.geo_long			:=	L.clean_address[156..166];
self.msa				:=	L.clean_address[167..170];
self.geo_blk            :=	L.clean_address[171..177];
self.geo_match			:=	L.clean_address[178];
self.err_stat			:=	L.clean_address[179..182];

self.cname              :=	StringLib.StringToUpperCase(L.cname); 
self.orig_company       :=	StringLib.StringToUpperCase(L.orig_company); 
self.orig_name          :=	StringLib.StringToUpperCase(L.orig_name); 
self.orig_fname         :=	StringLib.StringToUpperCase(L.orig_fname); 
self.orig_mname         :=	StringLib.StringToUpperCase(L.orig_mname); 
self.orig_lname         :=	StringLib.StringToUpperCase(L.orig_lname); 
self.orig_name_suffix   :=	StringLib.StringToUpperCase(L.orig_name_suffix); 

self.date_first_seen    :=	L.date_first_seen;
self.date_last_seen     :=	L.date_last_seen;
self.date_vendor_first_reported	:=	L.process_date;
self.date_vendor_last_reported	:=	L.process_date;
self.orig_County		:=	L.county;
self 					:= 	L;
end;

mapping_file := project(distribute(set_sequence,hash(tmsid)), treformat(left));


file_sort  := sort(mapping_file,TMSID,orig_case_number,SSN,TAX_ID,
             fname,mname,lname,name_suffix,cname,prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name,v_city_name, st, zip, zip4, county,
             name_type,debtor_type,-date_last_seen,debtor_seq,local);


BankruptcyV2.layout_bankruptcy_search_v3_supp  rolluplatestparties(BankruptcyV2.layout_bankruptcy_search_v3_supp l, BankruptcyV2.layout_bankruptcy_search_v3_supp r) := transform
		
		
		self.Date_First_Seen := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
		self.Date_Last_Seen  := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
		self.Date_Vendor_First_Reported := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);
		self.process_Date := formatlatestdates(l.process_Date ,r.process_Date);
		self := l;
end;

export Mapping_BK_search := rollup(file_sort,left.tmsid = right.tmsid and left.orig_case_number= right.orig_case_number
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
	  left.name_type='D' and right.name_type='D',true,false) and left.debtor_type =right.debtor_type , rolluplatestparties(LEFT,RIGHT),local);// : persist('~thor_data400::persist::mapping_bk_search');
                                
