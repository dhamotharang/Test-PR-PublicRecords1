import bankrupt,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header_SS, Business_Header,lib_fileservices,_control;

export Mapping_BK_Main_V1(string filedate) := function

//***//***//***//***//***//***//***//***REMAPPING***//***//***//***//***//***//***//***//***//

layout_bk_main_v8_did := record 
bankrupt.layout_bk_main_v8;
  integer8   ATT_DID  := 0;
  integer8   TRU_DID  := 0;
end;

layout_bk_main_v8_did  tjoin(BankruptcyV2.file_bankruptcy_main l, layout_bankruptcy_search r) := transform

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
self.filing_status := if(regexfind('(unknown)|(UNKNOWN)|(Unknown)', l.filing_status), '', l.filing_status);
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
self.attorney_name := if(regexfind('A', r.name_type), r.orig_name,'');
self.attorney_phone := if(regexfind('A', r.name_type),r.phone,'');
self.attorney_company := if(regexfind('A', r.name_type),r.orig_company,'');
self.attorney_address1 := if(regexfind('A', r.name_type),r.orig_addr1,'');
self.attorney_address2 := if(regexfind('A', r.name_type),r.orig_addr2,'');
self.attorney_city := if(regexfind('A', r.name_type),r.orig_city,'');
self.attorney_st := if(regexfind('A', r.name_type),r.orig_st,'');
self.attorney_zip := if(regexfind('A', r.name_type),r.orig_zip5,'');
self.attorney_zip4 := if(regexfind('A', r.name_type),r.orig_zip4 ,'');
self.trustee_name := if(regexfind('T', r.name_type), r.orig_name,'');
self.trustee_phone := if(regexfind('T', r.name_type),r.phone,'');
self.trustee_company := if(regexfind('T', r.name_type),r.orig_company,'');
self.trustee_address1 := if(regexfind('T', r.name_type),r.orig_addr1,'');
self.trustee_address2 := if(regexfind('T', r.name_type),r.orig_addr2,'');
self.trustee_city := if(regexfind('T', r.name_type),r.orig_city,'');
self.trustee_st := if(regexfind('T', r.name_type),r.orig_st,'');
self.trustee_zip := if(regexfind('T', r.name_type),r.orig_zip5,'');
self.trustee_zip4 := if(regexfind('T', r.name_type),r.orig_zip4 ,'');
self.tru_did := if(regexfind('T', r.name_type),(integer8)r.did,0);
self.att_did := if(regexfind('A', r.name_type),(integer8)r.did,0);
self := [];
end ; 

bkv2 := join(BankruptcyV2.file_bankruptcy_main , BankruptcyV2.file_bankruptcy_search(name_type[1..1] in ['A','T']), 
             left.court_code = right.court_code and left.case_number=right.case_number 
			 and left.date_last_seen = right.date_last_seen, tjoin(left,right),left outer);
			 

/*////////ROLLUP - ATTORNEY1 ATTORNERY2 TRUSTEE ON SAME LINE tested - W20070723-120842 cng////////*/ 

/* attorney names filled */
bkv2_atty := distribute(bkv2(attorney_name <> ''),hash(court_code,case_number, seq_number, attorney_name));

/* attorney names not filled for regrouping */
bkv2_trus := bkv2(attorney_name = '');

/* sort dedupes ascending atorney names */
lDEDbkv2_atty := dedup(sort(bkv2_atty, 
					source,court_code,case_number,orig_case_number,id,seq_number,date_created,date_modified,court_name,court_location,case_closing_date,chapter,orig_filing_type,filing_status,orig_chapter,orig_filing_date,corp_flag,meeting_date,meeting_time,address_341,claims_deadline,complaint_deadline,disposed_date,disposition,converted_date,reopen_date,judge_name,record_type,date_filed,assets_no_asset_indicator,filing_type,filer_type,pro_se_ind,judges_identification,attorney_name, 
					local), except tru_did, att_did, local, left);

/* sort dedupes descending atorney names */
rDEDbkv2_atty := dedup(sort(bkv2_atty,
					source,court_code,case_number,orig_case_number,id,seq_number,date_created,date_modified,court_name,court_location,case_closing_date,chapter,orig_filing_type,filing_status,orig_chapter,orig_filing_date,corp_flag,meeting_date,meeting_time,address_341,claims_deadline,complaint_deadline,disposed_date,disposition,converted_date,reopen_date,judge_name,record_type,date_filed,assets_no_asset_indicator,filing_type,filer_type,pro_se_ind,judges_identification,attorney_name, 
					local), except tru_did, att_did, local, right); 
					
/* join transform for the deduped records */
layout_bk_main_v8_did dojoin(layout_bk_main_v8_did l, layout_bk_main_v8_did r) := transform
	self.attorney2_name := r.attorney_name;
	self.attorney2_phone := r.attorney_phone;
	self.attorney2_company := r.attorney_company;
	self.attorney2_address1 := r.attorney_address1;
	self.attorney2_address2 := r.attorney_address2;
	self.attorney2_city := r.attorney_city;
	self.attorney2_st := r.attorney_st; 
	self.attorney2_zip := r.attorney_zip;
	self.attorney2_zip4 := r.attorney_zip4;
	self := l;
end;

/* perform join transform for the deduped records, left outer */
matchback := join(lDEDbkv2_atty, rDEDbkv2_atty, 
	left.source = right.source and
	left.court_code = right.court_code and
	left.case_number = right.case_number and
	left.orig_case_number = right.orig_case_number and
	left.id = right.id and
	left.seq_number = right.seq_number and
	left.date_created = right.date_created and
	left.date_modified = right.date_modified and
	left.court_name = right.court_name and
	left.court_location = right.court_location and
	left.case_closing_date = right.case_closing_date and
	left.chapter = right.chapter and
	left.orig_filing_type = right.orig_filing_type and
	left.filing_status = right.filing_status and
	left.orig_chapter = right.orig_chapter and
	left.orig_filing_date = right.orig_filing_date and
	left.corp_flag = right.corp_flag and
	left.meeting_date = right.meeting_date and
	left.meeting_time = right.meeting_time and
	left.address_341 = right.address_341 and
	left.claims_deadline = right.claims_deadline and
	left.complaint_deadline = right.complaint_deadline and
	left.disposed_date = right.disposed_date and
	left.disposition = right.disposition and
	left.converted_date = right.converted_date and
	left.reopen_date = right.reopen_date and
	left.judge_name = right.judge_name and
	left.record_type = right.record_type and
	left.date_filed = right.date_filed and
	left.assets_no_asset_indicator = right.assets_no_asset_indicator and
	left.filing_type = right.filing_type and
	left.filer_type = right.filer_type and
	left.pro_se_ind = right.pro_se_ind and
	left.judges_identification = right.judges_identification, dojoin(left,right),left outer);
	
/* reformat transform to blank attorney2 fields that are like the attorney fields */
layout_bk_main_v8_did refPutback(layout_bk_main_v8_did l) := transform
	
  self.attorney2_name := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_name);
  self.attorney2_phone := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_phone);
  self.attorney2_company := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_company);
  self.attorney2_address1 := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_address1);
  self.attorney2_address2 := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_address2);
  self.attorney2_city := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_city);
  self.attorney2_st := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_st);
  self.attorney2_zip := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_zip);
  self.attorney2_zip4 := if(l.attorney2_name = l.attorney_name and l.attorney2_company = l.attorney_company, '', l.attorney2_zip4);
  self := l;
 end;

/* preform reformat transform */
putback := sort(distribute(bkv2_trus + project(dedup(sort(matchback, record), record) , refPutback(left)), hash(court_code, case_number, seq_number)), record, local);

/* Rollup (from ananths testing code) to get the trustee names */
layout_bk_main_v8_did rollup_recs1(putback l,putback r) := transform
	self.seq_number := if(l.seq_number < r.seq_number, r.seq_number,l.seq_number);
	self.attorney_name := if(l.attorney_name <> '',l.attorney_name,r.attorney_name);
	self.attorney_phone := if(l.attorney_phone <> '',l.attorney_phone,r.attorney_phone);
	self.attorney_company := if(l.attorney_company <> '',l.attorney_company,r.attorney_company);
	self.attorney_address1 := if(l.attorney_address1 <> '',l.attorney_address1,r.attorney_address1);
	self.attorney_address2 := if(l.attorney_address2 <> '',l.attorney_address2,r.attorney_address2);
	self.attorney_city := if(l.attorney_city <> '',l.attorney_city,r.attorney_city);
	self.attorney_st := if(l.attorney_st <> '',l.attorney_st,r.attorney_st);
	self.attorney_zip := if(l.attorney_zip <> '',l.attorney_zip,r.attorney_zip);
	self.attorney_zip4 := if(l.attorney_zip4 <> '',l.attorney_zip4,r.attorney_zip4);
	self.attorney2_name := if(l.attorney2_name <> '',l.attorney2_name,r.attorney2_name);
	self.attorney2_phone := if(l.attorney2_phone <> '',l.attorney2_phone,r.attorney2_phone);
	self.attorney2_company := if(l.attorney2_company <> '',l.attorney2_company,r.attorney2_company);
	self.attorney2_address1 := if(l.attorney2_address1 <> '',l.attorney2_address1,r.attorney2_address1);
	self.attorney2_address2 := if(l.attorney2_address2 <> '',l.attorney2_address2,r.attorney2_address2);
	self.attorney2_city := if(l.attorney2_city <> '',l.attorney2_city,r.attorney2_city);
	self.attorney2_st := if(l.attorney2_st <> '',l.attorney2_st,r.attorney2_st);
	self.attorney2_zip := if(l.attorney2_zip <> '',l.attorney2_zip,r.attorney2_zip);
	self.attorney2_zip4 := if(l.attorney2_zip4 <> '',l.attorney2_zip4,r.attorney2_zip4);
	self.trustee_name := if(l.trustee_name <> '',l.trustee_name,r.trustee_name);
	self.trustee_phone := if(l.trustee_phone <> '',l.trustee_phone,r.trustee_phone);
	self.trustee_company := if(l.trustee_company <> '',l.trustee_company,r.trustee_company);
	self.trustee_address1 := if(l.trustee_address1 <> '',l.trustee_address1,r.trustee_address1);
	self.trustee_address2 := if(l.trustee_address2 <> '',l.trustee_address2,r.trustee_address2);
	self.trustee_city := if(l.trustee_city <> '',l.trustee_city,r.trustee_city);
	self.trustee_st := if(l.trustee_st <> '',l.trustee_st,r.trustee_st);
	self.trustee_zip := if(l.trustee_zip <> '',l.trustee_zip,r.trustee_zip);
	self.trustee_zip4 := if(l.trustee_zip4 <> '',l.trustee_zip4,r.trustee_zip4);
	self := l;
end;

/* perform rollup */
roll_recs1 := rollup(putback, rollup_recs1(left,right), court_code, case_number, seq_number, local);
/*////////ROLLUP END//////////*/ 

/* Create Base and Remove WA Phones WU - W20081023-061541 Dataland CNG*/
create_base := project(roll_recs1, transform(bankrupt.layout_bk_main_v8, self := left));

out5 := OUTPUT(create_base,,'~thor_data400::out::bankruptV2::'+filedate+'::main',OVERWRITE);

ut.mac_suppress_by_phonetype(roll_recs1,attorney_phone,attorney_st,roll_recs1_out,true,att_did);
ut.mac_suppress_by_phonetype(roll_recs1_out,trustee_phone,trustee_st,pre_moxie_base,true,tru_did);

moxie_base := project(pre_moxie_base, transform(bankrupt.layout_bk_main_v8, self := left));

out6 := OUTPUT(moxie_base,,'~thor_data400::out::bankruptv2::main_moxie',OVERWRITE);

/* DESPRAY */

super_search := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankruptV2_main_Delete','~thor_data400::base::bankruptV2_main',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankruptV2_main'),
				FileServices.AddSuperFile('~thor_data400::base::bankruptV2_main', '~thor_data400::out::bankruptV2::'+filedate+'::main'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankruptV2_main_delete',true));

// included in proc_misc_tasks macro
bk_file_despray := fileservices.Despray('~thor_data400::out::bankruptv2::main_moxie',_Control.IPAddress.edata12,
 									'/hds_180/bkv3/build/bk_main_v8.d00',,,,TRUE);

retval := sequential(parallel(out5,out6),super_search/*,bk_file_despray*/);
// retval := out5;

return retval;

end; 
