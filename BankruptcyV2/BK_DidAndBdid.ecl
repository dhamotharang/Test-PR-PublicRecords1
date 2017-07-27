//////////////////////////////////////////////////////////////////////////////////////////
// DEPENDENT ON : BankruptcyV2.layout_bankruptcy_search,
//                Bankruptcyv2.Mapping_BK_Search
//				  				  
// PURPOSE	 	: Distribute,sort and maps main daily bankruptcy/okc file to search layout, 
//                refresh full base file with update file and rolls up full file.  
//                {RMSID created to link main and search file if debtors are disposed speparately 
//                on same case. This will be addressed in MOAB rewrite.} 
//						: Revised (Ananth) - In addition to the did of daily file. This code also
//							checks to see if there is a new production data and re-DID's the full file
//	
//////////////////////////////////////////////////////////////////////////////////////////


import bankruptcyv2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog,mdr,header,lib_stringlib;

export BK_DidAndBdid(boolean boolean_value) := function

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if(lDate <= rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if(lDate >= rDate, lDate, rDate )));
return out_date ;
end ;

// Add first and last address lines

addrawaddress := record
	BankruptcyV2.Layout_bankruptcy_search_v3;
	string100 address_line_1;
	string50 address_line_last;
end;	

// Populate values for first and last address line

addrawaddress trfToBaseLayout(Bankruptcyv2.Mapping_BK_Search input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.orig_Addr1,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.orig_city,left,right) + if(input.orig_city <> '',', ',''),left)
									+ trim(input.orig_st,left,right) + ' ' + trim(input.orig_zip5,left,right));

	self	:=	input;
end;

search_daily_preAID	:=	distribute(project(Bankruptcyv2.Mapping_BK_Search, trfToBaseLayout(left)),hash(tmsid));

AID_base_file := distribute(bankruptcyv2.file_bk_AID,hash(tmsid));

// Join AID base file and search file to populate values for clean address fields
// from AID clean address fields.

BankruptcyV2.Layout_bankruptcy_search_v3 getaidaddress(addrawaddress l,AID_base_file r) := transform
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


search_daily_with_address := dedup(sort(join(search_daily_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'S'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),record,local),record,local);

// There might be records in AID base file which has
// clean address fields in old records and no clean address fields
// in the new daily file.

BankruptcyV2.Layout_bankruptcy_search_v3 getrecordswithnoaddress(addrawaddress l) := transform
	self := l;
end;

search_daily_with_no_address := project(search_daily_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));

search_daily := search_daily_with_address + search_daily_with_no_address;


// Repeat the above process for full file. 

addrawaddress addressBaseLayout(Bankruptcyv2.file_bankruptcy_search_v3 input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.orig_Addr1,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.orig_city,left,right) + if(input.orig_city <> '',', ',''),left)
									+ trim(input.orig_st,left,right) + ' ' + trim(input.orig_zip5,left,right));

	self	:=	input;
end;

search_full_preAID	:=	distribute(project(Bankruptcyv2.file_bankruptcy_search_v3, addressBaseLayout(left)),hash(tmsid));

search_full_with_address := dedup(sort(join(search_full_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'S'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),record,local),record,local);


search_full_with_no_address := project(search_full_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));

search_full := search_full_with_address + search_full_with_no_address;


// If new production header is available and if the current day is
// saturday or sunday DID full file, if not daily

file_in := 	if ( 	boolean_value = true and 
					(ut.Weekday((integer)ut.GetDate) = 'SATURDAY' or ut.Weekday((integer)ut.GetDate) = 'SUNDAY'),
							search_daily + search_full,
							search_daily
			   ); 

PreDID_Rec
 :=
  record
    
	qstring34  source_group := '';
	qstring34  vendor_id := '';
	BankruptcyV2.layout_bankruptcy_search_v3;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	string9 appended_SSN := '';
    string9 appended_tax_id := '';
	
	
  end
 ;

PreDID_Rec taddDID(file_in L)
 :=
  transform
    self.source_group 	:=  l.court_code + l.case_number; 
	self.vendor_id    	:=  l.court_code + l.case_number + l.debtor_type + l.name_type;
	self				:=	L;
	
  end
 ;

Prefile	:= project(file_in,taddDID(left));

Prefile_a:= Prefile(fname ='' and lname ='') ;
Prefile_b:= Prefile(fname !='' and lname ='') ;
Prefile_c:= Prefile(fname ='' and lname !='') ;
Prefile_d:= Prefile(fname !='' and lname !='') ;

prefile_did := Prefile_b + Prefile_c + Prefile_d ;

//append src
src_rec := record
header_slimsort.Layout_Source;
PreDID_Rec;
end;

DID_ADD.Mac_Set_Source_Code(prefile_did, src_rec, MDR.sourceTools.src_Bankruptcy, prefile_did_src)

//append DID
temp_layout := record
string either_ssn := '';
prefile_did_src;
end;

temp_layout trecs(prefile_did_src L) := transform
self.either_ssn := if((unsigned)L.ssnMatch = 0, L.ssn,L.ssnMatch);
self := L;
end;

prefile_did_eitherssn := project(prefile_did_src,trecs(left));

matchset :=['A', 'Z', 'S', 'P','4'];
did_Add.MAC_Match_Flex(prefile_did_eitherssn, matchset,
	 either_ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 prefile_did_eitherssn, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID_src,true,src)

//remove src 
postDID := project(postDID_src, transform(PreDID_Rec, self := left));

full_update_DID := Prefile_a + postDID ;

//append BDID 

preBDID_no_company  := full_update_DID(cname  = '');
preBDID := full_update_DID(cname <> '');

business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
								 false,temp_BDID,
								 false,MDR.sourceTools.src_Bankruptcy,	
								 TRUE, source_group,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch;

dWithSourceMatch			:=	dPostSourceMatchPersist(temp_BDID != 0);
dWithNoSourceMatch			:=	dPostSourceMatchPersist(temp_BDID = 0);

myset := ['A', 'N', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dWithNoSourceMatch,myset,
						cname,
						prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,   //these should default to zero in definition
						postbdid);

					
post_DID_BDID := preBDID_no_company + postbdid  + dWithSourceMatch;  //format DID and BDID

//Append SSN 

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, temp_did, appended_SSN, file_search_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_search_ssn, temp_bdid, appended_tax_id, file_search_fein);



BankruptcyV2.layout_bankruptcy_search_v3 reformattemp(file_search_fein L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	self.app_SSN        := l.appended_SSN ;
    self.app_tax_id     := l.appended_tax_id ;
	self := L;
	end;

file_daily := project(file_search_fein, reformattemp(left));

// Commented next line because we will use "search_full" 

// Full_Bk_search_nondist := dataset(ut.foreign_prod+'thor_data400::base::bankruptcy::search_v3',BankruptcyV2.layout_bankruptcy_search_v3,thor);


Full_BK_search_refresh := join(search_full , file_daily, left.tmsid = right.tmsid, //and left.source = right.source
                     transform({recordof(BankruptcyV2.layout_bankruptcy_search_v3)},
				     self := left),left only) ;


// Full File - Distributed

Full_BK_search := distribute(Full_BK_search_refresh,hash(tmsid));
file_daily_dist := distribute(file_daily,hash(tmsid)); 

// Add Full File and Daily File - If no new production header is available and if the current day is
// saturday or sunday DID full file, if not daily
// Change to SUnday
daily_plus_full := 	if ( 	boolean_value and 
							(ut.Weekday((integer)ut.GetDate) = 'SATURDAY' or ut.Weekday((integer)ut.GetDate) = 'SUNDAY'),
								file_daily_dist
								,Full_BK_search + file_daily_dist 
						); 
						
// Sort and Dedup locally

full_sort  :=sort(daily_plus_full,TMSID,orig_case_number,SSN,TAX_ID,
             fname,mname,lname,name_suffix,cname,prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name,v_city_name, st, zip, zip4, county,
             name_type,debtor_type,-date_last_seen,debtor_seq,local);

BankruptcyV2.layout_bankruptcy_search_v3  rolluplatestparties(BankruptcyV2.layout_bankruptcy_search_v3 l, BankruptcyV2.layout_bankruptcy_search_v3 r) := transform
		self.Date_First_Seen := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
		self.Date_Last_Seen  := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
		self.Date_Vendor_First_Reported := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);
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
                                
retval :=  full_file_rollup;

return retval;

end;