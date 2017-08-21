// Bug # 75908
// In order to create a daily base file we had to split Mapping_BK_main into two attributes
// l. Mapping BK Main creates daily base dataset
// 2. Create_Full_Main_V3 creates full base dataset. This attribute uses 
// BankruptcyV2.file_bankruptcy_main_v3_daily attribute to read the daily base
// file which is created in Mapping_BK_Main.
// refresh full base file with update file and   
//			      rollup full file.
//				  {RMSID will be different if debtors per case disposed separately.
//                It is created to link main with search file if debtors got different disposition.
//                RMSID will be addressed in MOAB rewrite} 


import bankruptcyV2, _control,did_add, address, lib_fileservices, lib_stringlib, ut, header_slimsort, didville, watchdog, idl_header;
export Create_Full_Main_V3(boolean useaid = true) := function

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate <= (unsigned8)rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate >= (unsigned8)rDate, lDate, rDate )));
return out_date ;
end ;



AID_base_file := distribute(bankruptcyv2.file_bk_AID,hash(tmsid));

daily_file := BankruptcyV2.file_bankruptcy_main_v3_daily;

// This is Bk histroy data with source 'H' & 'S' this file already added to base file and its one time. 

// Full_BK_Main_nondist_V8 := dataset('~thor_data400::base::Bankruptcy::Main_history',BankruptcyV2.layout_bankruptcy_main.layout_bankruptcy_main_filing_supp,thor); 

// Full File - non distributed 

// Repeat the above process for full file. 

fullbasefile := Bankruptcyv2.file_bankruptcy_main_v3_supplemented; 

addrawaddress := record
	BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp;
	string100 address_line_1;
	string50 address_line_last;
end;

addrawaddress addressBaseLayout(fullbasefile input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.trusteeAddress,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.trusteecity,left,right) + if(input.trusteecity <> '',', ',''),left)
									+ trim(input.trusteestate,left,right) + ' ' + trim(input.trusteezip,left,right));

	self	:=	input;
end;

main_full_preAID	:=	distribute(project(fullbasefile, addressBaseLayout(left)),hash(tmsid));


BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp getaidaddress(addrawaddress l,AID_base_file r) := transform
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



Full_BK_Main_nondist_with_address := dedup(sort(join(main_full_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'M'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),TMSID,orig_case_number,court_name,court_location,-date_last_seen,local),record,local);

BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp getrecordswithnoaddress(addrawaddress l) := transform
	self := l;
end;

Full_BK_Main_nondist_with_no_address := project(main_full_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));

Full_BK_Main_nondist := Full_BK_Main_nondist_with_address + Full_BK_Main_nondist_with_no_address;


	// REFRESH BASE FILE WITH CURRENT OKC RECORDS 

Full_BK_Main_refreshed := join(Full_BK_Main_nondist , daily_file, left.tmsid = right.tmsid /*and left.source = right.source*/,
                     	 transform({recordof(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp)},
				         self := left),left only,local) ;

Full_BK_Main := distribute(Full_BK_Main_refreshed,hash(tmsid));
					  
// Add Full File and Daily file (distributed)

daily_plus_full := if(useaid,Full_BK_Main + distribute(daily_file,hash(tmsid)),distribute(fullbasefile,hash(tmsid)) + distribute(daily_file,hash(tmsid)));

// Sort and rollup full file 

full_sort := sort(daily_plus_full,TMSID,orig_case_number,court_name,court_location,-date_last_seen,local);

bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp  rollupXform(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp l, bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp r) := transform
        
		boolean takeLatest 					:= (unsigned8)l.date_last_seen > (unsigned8)r.date_last_seen;
		boolean equl 						:= (unsigned8)l.date_last_seen = (unsigned8)r.date_last_seen;
		
		self.Date_First_Seen             	:= formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
		self.Date_Last_Seen              	:= formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
		self.Date_Vendor_First_Reported  	:= formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported   	:= formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);
		self.process_date				   	:= formatlatestdates(l.process_Date ,r.process_Date);
		self.address_341                 	:= if(takeLatest ,l.address_341, if(equl and l.address_341 = '' ,r.address_341,l.address_341));	   					   
		self.judge_name                  	:= if(takeLatest ,l.judge_name, if(equl and l.judge_name = '' ,r.judge_name,l.judge_name));	   				
		self.judges_identification       	:= if(takeLatest,l.judges_identification, if(equl and l.judges_identification = '' ,r.judges_identification,l.judges_identification));	   				
		self.meeting_date                	:= if(takeLatest ,l.meeting_date,if(equl and l.meeting_date = '' , r.meeting_date,l.meeting_date));
		self.meeting_time                	:= if(takeLatest ,l.meeting_time,if(equl and l.meeting_time = '',r.meeting_time , l.meeting_time));
		self.assets_no_asset_indicator   	:= if(takeLatest ,l.assets_no_asset_indicator,if(equl and l.assets_no_asset_indicator = '',r.assets_no_asset_indicator,l.assets_no_asset_indicator));
		self.reopen_date                 	:= if(takeLatest ,l.reopen_date, if(equl and l.reopen_date = '' , r.reopen_date , l.reopen_date)); 
		self.case_closing_date           	:= if(takeLatest ,l.case_closing_date,if( equl and l.case_closing_date = '' , r.case_closing_date, l.case_closing_date)); 
		self.dateReclosed		         	:= if(takeLatest ,l.dateReclosed,if( equl and l.dateReclosed = '' , r.dateReclosed, l.dateReclosed)); 
		self.claims_deadline             	:= if(takeLatest , l.claims_deadline, if(equl and l.claims_deadline = '', r.claims_deadline, l.claims_deadline));
		self.trusteeName		         	:= if(takeLatest ,l.trusteeName,if( equl and l.trusteeName = '' , r.trusteeName, l.trusteeName)); 
		self.trusteeAddress	             	:= if(takeLatest ,l.trusteeAddress,if( equl and l.trusteeAddress = '' , r.trusteeAddress, l.trusteeAddress)); 
		self.trusteeCity		         	:= if(takeLatest ,l.trusteeCity,if( equl and l.trusteeCity = '' , r.trusteeCity, l.trusteeCity)); 
		self.trusteeState		         	:= if(takeLatest ,l.trusteeState,if( equl and l.trusteeState = '' , r.trusteeState, l.trusteeState)); 
		self.trusteeZip		           		:= if(takeLatest ,l.trusteeZip,if( equl and l.trusteeZip = '' , r.trusteeZip, l.trusteeZip)); 
		self.trusteeZip4		           	:= if(takeLatest ,l.trusteeZip4,if( equl and l.trusteeZip4 = '' , r.trusteeZip4, l.trusteeZip4)); 
		self.trusteePhone		           	:= if(takeLatest ,l.trusteePhone,if( equl and l.trusteePhone = '' , r.trusteePhone, l.trusteePhone)); 
		self.trusteeID		           	 	:= if(takeLatest ,l.trusteeID,if( equl and l.trusteeID = '' , r.trusteeID, l.trusteeID)); 
		self.caseID 						:= if(takeLatest ,l.caseID,if( equl and l.caseID = '' , r.caseID, l.caseID)); 
		self.barDate                     	:= if(takeLatest ,l.barDate,if( equl and l.barDate = '' , r.barDate, l.barDate)); 
		self.transferIn 	               	:= if(takeLatest ,l.transferIn,if( equl and l.transferIn = '' , r.transferIn, l.transferIn)); 
		self.splitCase 	                 	:= if(takeLatest ,l.splitCase,if( equl and l.splitCase = '' , r.splitCase, l.splitCase));	
		self := l;
end;

BK_Main := rollup(full_sort,rollupXform(LEFT,RIGHT),TMSID+orig_case_number+court_name+court_location+process_date,local);

retval :=  BK_Main;

return retval;

end;