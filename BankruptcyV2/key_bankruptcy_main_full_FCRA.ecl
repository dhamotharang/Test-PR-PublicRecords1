import bankruptcyv2, Doxie, ut,bankrupt,address, data_services;


bankrupt.layout_bk_main_v8  tjoin(BankruptcyV2.file_bankruptcy_main l, BankruptcyV2.file_bankruptcy_search r) := transform

self.source := l.source;
self.court_code := l.court_code;
self.case_number := l.case_number;
self.orig_case_number := l.orig_case_number;
self.id := l.id;
self.seq_number := l.seq_number;
self.date_created := l.date_created;
self.date_modified := l.date_modified;
self.court_name := l.court_name;
self.court_location := l.court_location;
self.case_closing_date := l.case_closing_date;
self.chapter := l.chapter;
self.orig_filing_type :=  l.orig_filing_type;
self.filing_status := l.filing_status;
self.orig_chapter := l.orig_chapter;
self.orig_filing_date :=  l.orig_filing_date;
self.corp_flag := l.corp_flag;
self.meeting_date := l.meeting_date;
self.meeting_time := l.meeting_time;
self.address_341 :=  l.address_341;
self.claims_deadline := l.claims_deadline;
self.complaint_deadline := l.complaint_deadline;
self.disposed_date := l.disposed_date;
self.disposition := l.disposition;
self.converted_date := l.converted_date;
self.reopen_date := l.reopen_date;
self.judge_name := l.judge_name;
self.record_type := l.record_type;
self.date_filed := l.date_filed;
self.assets_no_asset_indicator := l.assets_no_asset_indicator;
self.filing_type := l.orig_filing_type;
self.filer_type := l.filer_type;
self.pro_se_ind := l.pro_se_ind;
self.judges_identification := l.judges_identification;

self.attorney_name := if(r.name_type = 'A', r.orig_name,'');
self.attorney_phone := if(r.name_type = 'A',r.phone,'');
self.attorney_company := if(r.name_type = 'A',r.orig_company,'');
self.attorney_address1 := if(r.name_type = 'A',r.orig_addr1,'');
self.attorney_address2 := if(r.name_type = 'A',r.orig_addr2,'');
self.attorney_city := if(r.name_type = 'A',r.orig_city,'');
self.attorney_st := if(r.name_type = 'A',r.orig_st,'');
self.attorney_zip := if(r.name_type = 'A',r.orig_zip5,'');
self.attorney_zip4 := if(r.name_type = 'A',r.orig_zip4 ,'');

self.trustee_name := if(r.name_type = 'T', r.orig_name,'');
self.trustee_phone := if(r.name_type = 'T',r.phone,'');
self.trustee_company := if(r.name_type = 'T',r.orig_company,'');
self.trustee_address1 := if(r.name_type = 'T',r.orig_addr1,'');
self.trustee_address2 := if(r.name_type = 'T',r.orig_addr2,'');
self.trustee_city := if(r.name_type = 'T',r.orig_city,'');
self.trustee_st := if(r.name_type = 'T',r.orig_st,'');
self.trustee_zip := if(r.name_type = 'T',r.orig_zip5,'');
self.trustee_zip4 := if(r.name_type = 'T',r.orig_zip4 ,'');

self := [];
end ; 

  
trans_v1 := join(BankruptcyV2.file_bankruptcy_main , BankruptcyV2.file_bankruptcy_search(name_type in ['A','T']), 
             left.tmsid = right.tmsid , tjoin(left,right),left outer) ;
 
 
export key_bankruptcy_main_full_fcra := 
  index (trans_v1, 
         {typeof(case_number) s_casenum := case_number, 
          typeof(court_code) s_courtcode := court_code, 
          typeof(seq_number) s_seqnumber := seq_number}, 
		{trans_v1},
       data_services.data_location.prefix('bankruptcyv2') + 'thor_data400::key::bankruptcyv2::fcra::main_' + doxie.version_superKey);
							 




