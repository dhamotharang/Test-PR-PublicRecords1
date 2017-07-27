/* 1. dOES DEDUP ALL 
   2. CEATES STATUS,COMMENTS CHILD DATASET 
   3. ROLLUP TO KEEP LATEST FILING*/

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if(lDate < rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if(lDate > rDate, lDate, rDate )));
return out_date ;
end ;

file_in := BankruptcyV2.file_BK_main_history_in ;

file_in_sort := sort(distribute(file_in,hash(tmsid)),TMSID,source,-date_created, -date_modified,court_code,court_name,court_location,case_number, orig_case_number,
         chapter,date_filed,orig_filing_type,filing_status,orig_chapter,-orig_filing_date,assets_no_asset_indicator,corp_flag,filer_type,corp_flag,-meeting_date,meeting_time,address_341,
         claims_deadline, complaint_deadline,-disposed_date, disposition,pro_se_ind,judge_name,judges_identification,record_type,converted_date, reopen_date,case_closing_date,-date_last_seen ,-date_first_seen,local);
		 
file_in_dedup := dedup(file_in_sort,TMSID,source,date_created, date_modified,court_code,court_name,court_location,case_number, orig_case_number,
         chapter,date_filed,orig_filing_type,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,corp_flag,filer_type,corp_flag,meeting_date,meeting_time,address_341,
         claims_deadline, complaint_deadline,disposed_date, disposition,pro_se_ind,judge_name,judges_identification,record_type,converted_date,reopen_date,case_closing_date,date_last_seen ,date_first_seen,local);
		 
count(file_in_dedup);

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
self.Date_First_Seen := formatearliestdates(l.Date_First_Seen,r.Date_First_Seen) ;
self.Date_Last_Seen  := formatlatestdates(l.Date_Last_Seen,r.Date_Last_Seen);
self.Date_Vendor_First_Reported := formatearliestdates(l.Date_Vendor_First_Reported ,r.Date_Vendor_First_Reported);
self.Date_Vendor_Last_Reported  := formatlatestdates(l.Date_Vendor_Last_Reported ,r.Date_Vendor_Last_Reported);				   
self.address_341  := if(l.date_last_seen > r.date_last_seen ,l.address_341, if(l.date_last_seen = r.date_last_seen and l.address_341 = '' ,r.address_341,l.address_341));	   					   
self.judge_name   := if(l.date_last_seen > r.date_last_seen ,l.judge_name, if(l.date_last_seen = r.date_last_seen and l.judge_name = '' ,r.judge_name,l.judge_name));	   				
self.judges_identification := if(l.date_last_seen > r.date_last_seen ,l.judges_identification, if(l.date_last_seen = r.date_last_seen and l.judges_identification = '' ,r.judges_identification,l.judges_identification));	   				
self := L;
end;

					   
main_out := rollup(file_sort,TMSID+orig_case_number+court_name+court_location,tmakechildren(left, right),local);		
export Mapping_BK_Main_history := main_out;