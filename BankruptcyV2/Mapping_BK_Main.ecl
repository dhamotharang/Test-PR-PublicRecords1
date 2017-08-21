//////////////////////////////////////////////////////////////////////////////////////////
// DEPENDENT ON : bankruptcyV2.Layout_bankruptcy_main_temp,
//				  bankruptcyV2.Layout_bankruptcy_main,
//				  
// PURPOSE	 	: Creates child datasets, distribute,sort and mapped main daily 
//                bankruptcy/okc file to main layout
//////////////////////////////////////////////////////////////////////////////////////////

import bankruptcyV2, _control,did_add, address, lib_fileservices, lib_stringlib, ut, header_slimsort, didville, watchdog, idl_header;

export Mapping_BK_Main(boolean boolean_value,boolean useaid = true) := function

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate <= (unsigned8)rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate >= (unsigned8)rDate, lDate, rDate )));
return out_date ;
end ;

file_in := 	BankruptcyV2.File_Bankruptcy_main_in;


////////// ALERT RECORDS WITH BAD C3 CODES ////////// CNG W20071009-181143

// counted := (string)count(file_in(court_code = ''));

// leMailTarget := 'cguyton@seisint.com, Joseph.Lezcano@lexisnexis.com, Christopher.Brodeur@lexisnexis.com';

// fSendMail(string pSubject,string pBody)
 // := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);


// fSendMail('BankruptcyV3 '+ _Control.ThisEnvironment.Name + ' - '+counted+' C3Code Translation Issues','Data from workunit ' + Thorlib.WUID());

/////////////////////////////////////////////////////

file_in_sort := sort(distribute(file_in,hash(tmsid)),TMSID,-(unsigned)id,-date_created, date_modified,court_code,court_name,court_location,case_number,orig_case_number,
							-date_filed,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,filer_type,-meeting_date,meeting_time,address_341,
							claims_deadline, complaint_deadline,judge_name,judges_identification,filing_jurisdiction,assets,liabilities, CaseType, 
							AssocCode, SplitCase ,FiledInError,reopen_date,case_closing_date,reclosed_date,-date_last_seen ,date_first_seen,local);
		 
file_in_dedup := dedup(file_in_sort,TMSID,date_created, date_modified,court_code,court_name,court_location,case_number, orig_case_number,
							date_filed,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,filer_type,meeting_date,meeting_time,address_341,
							claims_deadline, complaint_deadline,judge_name,judges_identification,filing_jurisdiction,assets,liabilities, CaseType, 
							AssocCode, SplitCase ,FiledInError,reopen_date,case_closing_date,reclosed_date,date_last_seen ,date_first_seen,local);
		 
bankruptcyV2.Layout_bankruptcy_main_temp tnormalize(BankruptcyV2.layout_bankruptcy_main_in L, integer cnt) := transform
	self.status_date 				:= choose(Cnt, L.reopen_date, l.case_closing_date, l.reclosed_date);
					 
	self.status_type 				:= choose(cnt,	if(L.reopen_date<> '','REOPENED',''),
														if(l.case_closing_date <>'','CLOSED',''),
														if(l.reclosed_date <>'','RECLOSED','') );
					
	self.description 				:=  choose(cnt,if(l.AssocCode = '2' ,'MULTIPLE DEBTORS','SINGLE DEBTOR') ,
														if(l.SplitCase ='True','CASE IS A SPLIT RECORD',''),
														if(l.FiledInError= 'True','FILED IN ERROR',''));	
																	
	self.filing_date 				:=  choose(cnt,l.date_filed,
														if(l.SplitCase ='True',l.date_filed,''),
														if(l.FiledInError= 'True',l.date_filed,''));					
																	
	self.date_vendor_first_reported := 	L.process_date;
	self.date_vendor_last_reported  :=	L.process_date;
	
	self.transferIn					:=	stringlib.StringToUpperCase(l.transferIn);
	self.splitCase					:=	stringlib.StringToUpperCase(l.splitCase);
	
	self.title       				:=	L.clean_name[1..5] ;
	self.fname       				:=	if((trim(L.clean_name[6..25]) = 'NOT' or regexfind('(INFORMATIO)|(INFORAMTION)', L.clean_name[6..25])) and regexfind('(VAILABLE)', L.clean_name[46..65]), '', L.clean_name[6..25]);
	self.mname       				:=	L.clean_name[26..45];
	self.lname       				:=	if((trim(L.clean_name[6..25]) = 'NOT' or regexfind('(INFORMATIO)|(INFORAMTION)', L.clean_name[6..25])) and regexfind('(VAILABLE)', L.clean_name[46..65]), '', L.clean_name[46..65]);
	self.name_suffix 				:=	L.clean_name[66..70];
	self.name_score  				:=	L.clean_name[71..73];

	self.prim_range 				:=	L.clean_address[1..10]				;
	self.predir     				:=	L.clean_address[11..12]				;
	self.prim_name					:=	L.clean_address[13..40]				;
	self.addr_suffix				:=	L.clean_address[41..44]				;
	self.postdir					:=	L.clean_address[45..46]				;
	self.unit_desig					:=	L.clean_address[47..56]				;
	self.sec_range					:=	L.clean_address[57..64]				;
	self.p_city_name				:=	L.clean_address[65..89]				;
	self.v_city_name				:=	L.clean_address[90..114]				;
	self.st					    	:=	L.clean_address[115..116]			;
	self.zip						:=	L.clean_address[117..121]			;
	self.zip4						:=	L.clean_address[122..125]			;
	self.cart						:=	L.clean_address[126..129]			;
	self.cr_sort_sz					:=	L.clean_address[130]					;
	self.lot						:=	L.clean_address[131..134]			;
	self.lot_order					:=	L.clean_address[135]					;
	self.dbpc						:=	L.clean_address[136..137]			;
	self.chk_digit					:=	L.clean_address[138]					;
	self.rec_type			 		:=	L.clean_address[139..140]			;
	self.county			    		:=	L.clean_address[141..145]			;
	self.geo_lat					:=	L.clean_address[146..155]			;
	self.geo_long					:=	L.clean_address[156..166]			;
	self.msa						:=	L.clean_address[167..170]			;
	self.geo_blk        			:=	L.clean_address[171..177]   ;
	self.geo_match					:=	L.clean_address[178]					;
	self.err_stat					:=	L.clean_address[179..182]		;	
	self.trusteePhone				:=	lib_stringlib.stringlib.stringfilter(trim(l.trusteePhone,left,right),'0123456789');
		
	self.judge_name     			:= if(trim(l.judge_name,left,right) ='INFORMATION UNAVAILABLE','',StringLib.StringToUpperCase(l.judge_name));
	self := L;
end;

main_norm := normalize(file_in_dedup, 3, tnormalize(left, counter));

MainLayoutPlus	:=	record, maxlength(10000)
	bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp;
	string	filing_date;
end;

MainLayoutPlus tmakefatrecord(bankruptcyV2.Layout_bankruptcy_main_temp L) := transform

  self.status   := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
  self.comments := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_comments);
  self := L;

end;

file_flat := project(main_norm, tmakefatrecord(left));

file_sort := sort(distribute(file_flat,hash(tmsid)), TMSID,orig_case_number,court_name,court_location,-date_last_seen,local) ;

MainLayoutPlus tmakechildren(MainLayoutPlus L, MainLayoutPlus R) := transform


  self.status   					:= L.status + row({r.status[1].status_date, r.status[1].status_Type},bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
  self.comments 					:= l.comments + row({r.comments[1].filing_date, r.comments[1].description},bankruptcyV2.Layout_bankruptcy_main_v3.layout_comments);

  boolean takeLatest 				:= (unsigned8)l.date_last_seen > (unsigned8)r.date_last_seen;
  boolean equl 						:= (unsigned8)l.date_last_seen = (unsigned8)r.date_last_seen;

  self.Date_First_Seen				:= formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
  self.Date_Last_Seen				:= formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
  self.Date_Vendor_First_Reported	:= formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
  self.Date_Vendor_Last_Reported	:= formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);	
  self.process_Date					:= formatlatestdates(l.process_Date ,r.process_Date);	
  self.address_341                  := if(takeLatest ,l.address_341, if(equl and l.address_341 = '' ,r.address_341,l.address_341));	   					   
  self.judge_name                   := if(takeLatest ,l.judge_name, if(equl and l.judge_name = '' ,r.judge_name,l.judge_name));	   				
  self.judges_identification        := if(takeLatest,l.judges_identification, if(equl and l.judges_identification = '' ,r.judges_identification,l.judges_identification));	   				
  self.meeting_date                 := if(takeLatest ,l.meeting_date,if(equl and l.meeting_date = '' , r.meeting_date,l.meeting_date));
  self.meeting_time                 := if(takeLatest ,l.meeting_time,if(equl and l.meeting_time = '',r.meeting_time , l.meeting_time));
  self.assets_no_asset_indicator    := if(takeLatest ,l.assets_no_asset_indicator,if(equl and l.assets_no_asset_indicator = '',r.assets_no_asset_indicator,l.assets_no_asset_indicator));
  self.reopen_date                  := if(takeLatest ,l.reopen_date, if(equl and l.reopen_date = '' , r.reopen_date , l.reopen_date)); 
  self.case_closing_date            := if(takeLatest ,l.case_closing_date,if( equl and l.case_closing_date = '' , r.case_closing_date, l.case_closing_date));
  self.dateReclosed		        	:= if(takeLatest ,l.dateReclosed,if( equl and l.dateReclosed = '' , r.dateReclosed, l.dateReclosed)); 
  self.claims_deadline              := if(takeLatest , l.claims_deadline, if(equl and l.claims_deadline = '', r.claims_deadline, l.claims_deadline));
	
  self.trusteeName					:= if(takeLatest ,l.trusteeName,if( equl and l.trusteeName = '' , r.trusteeName, l.trusteeName)); 
  self.trusteeAddress				:= if(takeLatest ,l.trusteeAddress,if( equl and l.trusteeAddress = '' , r.trusteeAddress, l.trusteeAddress)); 
  self.trusteeCity					:= if(takeLatest ,l.trusteeCity,if( equl and l.trusteeCity = '' , r.trusteeCity, l.trusteeCity)); 
  self.trusteeState					:= if(takeLatest ,l.trusteeState,if( equl and l.trusteeState = '' , r.trusteeState, l.trusteeState)); 
  self.trusteeZip					:= if(takeLatest ,l.trusteeZip,if( equl and l.trusteeZip = '' , r.trusteeZip, l.trusteeZip)); 
  self.trusteeZip4					:= if(takeLatest ,l.trusteeZip4,if( equl and l.trusteeZip4 = '' , r.trusteeZip4, l.trusteeZip4)); 
  self.trusteePhone					:= if(takeLatest ,l.trusteePhone,if( equl and l.trusteePhone = '' , r.trusteePhone, l.trusteePhone)); 
  self.trusteeID					:= if(takeLatest ,l.trusteeID,if( equl and l.trusteeID = '' , r.trusteeID, l.trusteeID)); 
  self.caseID						:= if(takeLatest ,l.caseID,if( equl and l.caseID = '' , r.caseID, l.caseID)); 
  self.barDate						:= if(takeLatest ,l.barDate,if( equl and l.barDate = '' , r.barDate, l.barDate)); 
  self.transferIn					:= if(takeLatest ,l.transferIn,if( equl and l.transferIn = '' , r.transferIn, l.transferIn)); 
  self.splitCase					:= if(takeLatest ,l.splitCase,if( equl and l.splitCase = '' , r.splitCase, l.splitCase)); 
  self := l;

end;

main_daily_temp := rollup(file_sort,TMSID+orig_case_number+court_name+court_location+process_date,tmakechildren(left, right),local);	

// Populate values for first and last address line

addrawaddress := record
	BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp;
	string100 address_line_1;
	string50 address_line_last;
end;	

addrawaddress trfToBaseLayout(MainLayoutPlus input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.trusteeAddress,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.trusteecity,left,right) + if(input.trusteecity <> '',', ',''),left)
									+ trim(input.trusteestate,left,right) + ' ' + trim(input.trusteezip,left,right));

	self	:=	input;
end;

main_daily_preAID	:=	project(main_daily_temp, trfToBaseLayout(left));

AID_base_file := distribute(bankruptcyv2.file_bk_AID,hash(tmsid));

// Join AID base file and search file to populate values for clean address fields
// from AID clean address fields.


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

main_daily_with_address := dedup(sort(join(main_daily_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'M'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),TMSID,orig_case_number,court_name,court_location,-date_last_seen,local),record,local);


// There might be records in AID base file which has
// clean address fields in old records and no clean address fields
// in the new daily file.

BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp getrecordswithnoaddress(addrawaddress l) := transform
	self := l;
end;

main_daily_with_no_address := project(main_daily_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));					

// if useaid is false then don't use data from AID instead use the 
// regular address cleaner data

BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp dontuseaidaddress(MainLayoutPlus l) := transform
	self := l;
end;

main_daily_noaid := project(main_daily_temp,dontuseaidaddress(left));					




main_daily := if (useaid,main_daily_with_address + main_daily_with_no_address,main_daily_noaid);



preDIDFile	:=	main_daily; 

PreDID_Rec := record,maxlength(10000)
	bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp;
	integer8	temp_DID		  := 0;
	string9 appended_SSN 		:= '';	
end;
////////////////////////////////////////////////////////////////////////////////////////
// Pass to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(preDIDFile,fname,mname,lname,DIDFile);


// append DID
matchset :=['A', 'Z', 'P'];

did_Add.MAC_Match_Flex_V2(DIDFile, matchset,
	 '', '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, trusteePhone,
	 temp_did,   			
	 PreDID_Rec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID);
	 
did_add.MAC_Add_SSN_By_DID(postDID, temp_did, appended_SSN, file_search_ssn, false);

bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp reformattemp(file_search_ssn L) :=  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
		self.app_SSN    := l.appended_SSN ;		
		self := L;
end;

BK_Main_WithDID := distribute(project(file_search_ssn, reformattemp(left)),hash(tmsid));

return BK_Main_WithDID;

end;