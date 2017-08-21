//////////////////////////////////////////////////////////////////////////////////////////
// DEPENDENT ON : bankruptcyV2.Layout_bankruptcy_main_temp,
//				  bankruptcyV2.Layout_bankruptcy_main,
//				  
// PURPOSE	 	: Creates child datasets, distribute,sort and mapped history data with source code 
//                'S' or 'H' file to main layout
//////////////////////////////////////////////////////////////////////////////////////////


formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate <= (unsigned8)rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if((unsigned8)lDate >= (unsigned8)rDate, lDate, rDate )));
return out_date ;
end ;

file_in := BankruptcyV2.file_BK_main_history_in ;

file_in_sort := sort(distribute(file_in,hash(tmsid)),TMSID,-(unsigned)id,-date_created, -date_modified,court_code,court_name,court_location,case_number, orig_case_number,
         chapter,date_filed,orig_filing_type,filing_status,orig_chapter,-orig_filing_date,assets_no_asset_indicator,corp_flag,filer_type,corp_flag,-meeting_date,meeting_time,address_341,
         claims_deadline, complaint_deadline,-disposed_date, disposition,pro_se_ind,judge_name,judges_identification,record_type,converted_date, reopen_date,case_closing_date,-date_last_seen ,date_first_seen,local);
		 
file_in_dedup := dedup(file_in_sort,TMSID,date_created, date_modified,court_code,court_name,court_location,case_number, orig_case_number,
         chapter,date_filed,orig_filing_type,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,corp_flag,filer_type,corp_flag,meeting_date,meeting_time,address_341,
         claims_deadline, complaint_deadline,disposed_date, disposition,pro_se_ind,judge_name,judges_identification,record_type,converted_date,reopen_date,case_closing_date,date_last_seen ,date_first_seen,local);
		 

bankruptcyV2.Layout_bankruptcy_main_temp tnormalize(BankruptcyV2.layout_BK_main_history_in L, integer cnt) := transform


self.status_date := choose(Cnt, L.converted_date, L.reopen_date, l.case_closing_date,l.disposed_date);
						 
						 
self.status_type := choose(cnt,if(l.converted_date <> '', 'CONVERTED' , ''),if(L.reopen_date<> '','REOPENED',''),
                    if(l.case_closing_date <>'','CLOSED',''),if(l.disposed_date <>'',l.disposition,''));

self.description := 	'' ; 
self.filing_date :=   '' ; 				
self.date_vendor_first_reported     :=      L.process_date;
self.date_vendor_last_reported      :=      L.process_date;
self := L;

end;

main_norm := normalize(file_in_dedup, 4, tnormalize(left, counter));


bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing tmakefatrecord(bankruptcyV2.Layout_bankruptcy_main_temp L) := transform

self.status   := row(L,bankruptcyV2.Layout_bankruptcy_main.layout_status);
self.comments := row(L,bankruptcyV2.Layout_bankruptcy_main.layout_comments);
self := L;

end;

file_flat := project(main_norm, tmakefatrecord(left));

file_sort := sort(distribute(file_flat,hash(tmsid)), TMSID,orig_case_number,court_name,court_location,-date_last_seen,local) ;

bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing tmakechildren(bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing L, bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing R) := transform


self.status   := L.status + row({r.status[1].status_date, r.status[1].status_Type},bankruptcyV2.Layout_bankruptcy_main.layout_status);
self.comments := l.comments + row({r.comments[1].filing_date, r.comments[1].description},bankruptcyV2.Layout_bankruptcy_main.layout_comments);


  boolean takeLatest := (unsigned8)l.date_last_seen > (unsigned8)r.date_last_seen;
  boolean equl := (unsigned8)l.date_last_seen = (unsigned8)r.date_last_seen;

  self.Date_First_Seen               := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
  self.Date_Last_Seen                := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
  self.Date_Vendor_First_Reported    := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
  self.Date_Vendor_Last_Reported     := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);	
  self.address_341                   := if(takeLatest ,l.address_341, if(equl and l.address_341 = '' ,r.address_341,l.address_341));	   					   
  self.judge_name                    := if(takeLatest ,l.judge_name, if(equl and l.judge_name = '' ,r.judge_name,l.judge_name));	   				
  self.judges_identification         := if(takeLatest,l.judges_identification, if(equl and l.judges_identification = '' ,r.judges_identification,l.judges_identification));	   				
  self.meeting_date                  := if(takeLatest ,l.meeting_date,if(equl and l.meeting_date = '' , r.meeting_date,l.meeting_date));
  self.meeting_time                  := if(takeLatest ,l.meeting_time,if(equl and l.meeting_time = '',r.meeting_time , l.meeting_time));
  self.assets_no_asset_indicator     := if(takeLatest ,l.assets_no_asset_indicator,if(equl and l.assets_no_asset_indicator = '',r.assets_no_asset_indicator,l.assets_no_asset_indicator));
  self.converted_date                := if(takeLatest ,l.converted_date,if(equl and l.converted_date ='' , r.converted_date , l.converted_date)); 
  self.reopen_date                   := if(takeLatest ,l.reopen_date, if(equl and l.reopen_date = '' , r.reopen_date , l.reopen_date)); 
  self.case_closing_date             := if(takeLatest ,l.case_closing_date,if( equl and l.case_closing_date = '' , r.case_closing_date, l.case_closing_date)); 
  self.disposed_date                 := if(takeLatest , l.disposed_date,if(equl and l.disposed_date = '', r.disposed_date,l.disposed_date));
  self.disposition                   := if(takeLatest , l.disposition, if(equl and l.disposition = '', r.disposition, l.disposition));
  self.claims_deadline               := if(takeLatest , l.claims_deadline, if(equl and l.claims_deadline = '', r.claims_deadline, l.claims_deadline));
  self := l;

end;

					   
main_out := rollup(file_sort,TMSID+orig_case_number+court_name+court_location,tmakechildren(left, right),local);		
export Mapping_BK_Main_history := main_out;