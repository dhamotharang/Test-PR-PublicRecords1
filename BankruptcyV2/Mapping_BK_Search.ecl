import bankruptcyV2, address;

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if(lDate < rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if(lDate > rDate, lDate, rDate )));
return out_date ;
end ;

file_in := BankruptcyV2.File_Bankruptcy_search_in;

BankruptcyV2.layout_bankruptcy_search treformat(BankruptcyV2.layout_bankruptcy_search_in L) := transform

self.title       := L.clean_name[1..5] ;
self.fname       := L.clean_name[6..25];
self.mname       := L.clean_name[26..45];
self.lname       := L.clean_name[46..65];
self.name_suffix := L.clean_name[66..70];
self.name_score  :=  L.clean_name[71..73];

self.prim_range 		    := 		L.clean_address[1..10]				;
self.predir     		    :=		L.clean_address[11..12]				;
self.prim_name			    := 		L.clean_address[13..40]				;
self.addr_suffix		    := 		L.clean_address[41..44]				;
self.postdir				:=		L.clean_address[45..46]				;
self.unit_desig			    := 		L.clean_address[47..56]				;
self.sec_range				:= 		L.clean_address[57..64]				;
self.p_city_name			:= 		L.clean_address[65..89]				;
self.v_city_name			:= 		L.clean_address[90..114]				;
self.st					    := 		L.clean_address[115..116]			;
self.zip					:=		L.clean_address[117..121]			;
self.zip4					:=		L.clean_address[122..125]			;
self.cart					:=		L.clean_address[126..129]			;
self.cr_sort_sz			    :=		L.clean_address[130]					;
self.lot					:=		L.clean_address[131..134]			;
self.lot_order				:=		L.clean_address[135]					;
self.dbpc					:=		L.clean_address[136..137]			;
self.chk_digit				:=		L.clean_address[138]					;
self.rec_type			    :=		L.clean_address[139..140]			;
self.county			        :=		L.clean_address[141..145]			;
self.geo_lat				:=		L.clean_address[146..155]			;
self.geo_long				:=		L.clean_address[156..166]			;
self.msa					:=		L.clean_address[167..170]			;
self.geo_blk                :=      L.clean_address[171..177]   ;
self.geo_match				:=		L.clean_address[178]					;
self.err_stat				:=		L.clean_address[179..182]		;

self.date_first_seen                :=      L.date_first_seen;
self.date_last_seen                 :=      L.date_last_seen;
self.date_vendor_first_reported     :=      L.process_date;
self.date_vendor_last_reported      :=      L.process_date;
self := L;
end;

mapping_file := project(distribute(file_in,hash(tmsid)), treformat(left));

file_sort  := sort(mapping_file,TMSID,court_code,case_number,orig_case_number,SSN,TAX_ID,name_type,
             fname,mname,lname,name_suffix,cname,prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name,v_city_name, st, zip, zip4, county,
             -date_last_seen,debtor_seq,local);

// ALL ORIG FILEDS ARE EMPTY IN HISTORY FILE SO ROLLUP DOESN'T USE ORIG FIELDS.

BankruptcyV2.layout_bankruptcy_search  rolluplatestparties(BankruptcyV2.layout_bankruptcy_search l, BankruptcyV2.layout_bankruptcy_search r) := transform
		
		self.Date_First_Seen := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
		self.Date_Last_Seen  := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
		self.Date_Vendor_First_Reported := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);
		
		self := l;
end;

export Mapping_BK_search := rollup(file_sort,left.tmsid = right.tmsid and left.court_code = right.court_code and
    left.case_number= right.case_number and left.orig_case_number= right.orig_case_number and 
    left.SSN = right.ssn and left.TAX_ID = right.tax_id and left.name_type = right.name_type
    and left.fname= right.fname and left.mname = right.mname and 
    left.lname= right.lname and left.name_suffix= right.name_suffix and left.cname = right.cname and left.prim_range= right.prim_range and 
    left.predir= right.predir and left.prim_name= right.prim_name and  left.addr_suffix= 
    right.addr_suffix and left.postdir= right.postdir and left.unit_desig= right.unit_desig and 
    left.sec_range = right.sec_range and left.p_city_name= right.p_city_name and left.v_city_name= right.v_city_name
    and left.st = right.st and left.zip = right.zip  and left.zip4= right.zip4
    and left.county= right.county , rolluplatestparties(LEFT,RIGHT),local) ; 
                                
