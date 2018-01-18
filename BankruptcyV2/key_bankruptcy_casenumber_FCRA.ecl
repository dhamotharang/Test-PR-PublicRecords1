import doxie,ut,bankrupt,bankruptcyv2, data_services;

//get_recs := BankruptcyV2.file_bankruptcy_search;

bankrupt.Layout_BK_Search_v8  treformat(BankruptcyV2.layout_bankruptcy_search  l) := transform 

self.seq_number := l.seq_number;
self.court_code := l.court_code;
self.case_number := l.case_number;
self.debtor_type :=  l.debtor_type;
self.debtor_seq := l.debtor_seq;
self.orig_ssn := l.ssn; // check this  
self.debtor_title := l.title;
self.debtor_fname := l.fname;
self.debtor_mname := l.mname;
self.debtor_lname := l.lname;
self.debtor_name_suffix := l.name_suffix;
self.score := l.name_score;
self.debtor_company := l.cname;
self.prim_range := l.prim_range;
self.predir := l.predir;
self.prim_name := l.prim_name;
self.suffix := l.addr_suffix;
self.postdir := l.postdir;
self.unit_desig := l.unit_desig;
self.sec_range := l.sec_range;
self.p_city_name := l.p_city_name;
self.v_city_name := l.v_city_name;
self.st := l.st;
self.z5 := l.zip;
self.zip4 := l.zip4;
self.cart := l.cart;
self.cr_sort_sz := l.cr_sort_sz;
self.lot := l.lot;
self.lot_order := l.lot_order;
self.dbpc := l.dbpc;
self.chk_digit := l.chk_digit;
self.rec_type := l.rec_type;
self.county := l.county;
self.geo_lat := l.geo_lat;
self.geo_long := l.geo_long;
self.msa := l.msa;
self.geo_blk := l.geo_blk ;
self.geo_match := l.geo_match;
self.err_stat := l.err_stat;
self.debtor_DID := l.did;
self.debtor_ssn := l.app_SSN;
self.debtor_DID_score := '';
self.bdid := l.bdid;
self.GLB_flag := '';
end ; 

trans_V1 := project(BankruptcyV2.file_bankruptcy_search(name_type ='D') , treformat(left)) ;
 
export key_bankruptcy_casenumber_FCRA := index(trans_V1,{typeof(case_number) s_casenum := case_number, 
							 typeof(court_code) s_courtcode := court_code, 
							 typeof(seq_number) s_seqnumber := seq_number}, {trans_V1},
							 data_services.data_location.prefix('bankruptcyv2') + 'thor_data400::key::BankruptcyV2::fcra::case_number_'  + doxie.Version_SuperKey);


/*

strip_leadingzeroes(string25 number) := regexreplace('^[ |0]*',number,'');

get_recs tnorm(get_recs L, integer cnt) := transform
string25 s_case_number        := if(strip_leadingzeroes(L.case_number)   <> '', L.case_number, ''); 
string25 s_orig_case_number   := if(strip_leadingzeroes(L.orig_case_number)   <> '', L.orig_case_number, ''); 

self.case_number := choose(cnt, s_case_number, s_orig_case_number);						  
self := L;

end;
					   
get_recs_file := normalize(get_recs(case_number <> '' or orig_case_number <> '' ), 2, tnorm(left, counter));


get_recs_file tformat(get_recs_file L, integer cnt) := transform

self.case_number := choose(cnt, L.case_number, strip_leadingzeroes(L.case_number));
self := L;

end;

get_recs_norm := normalize(get_recs_file(case_number<> ''), 2, tformat(left, counter));

get_recs_dedup := dedup(get_recs_norm,all); 

export key_bankruptcy_casenumber_FCRA := index (get_recs_norm, 
  {typeof(case_number) s_casenum := case_number, 
   typeof(court_code) s_courtcode := court_code, 
   typeof(seq_number) s_seqnumber := seq_number}, 
  {get_recs_norm},data_services.data_location.prefix() + 'thor_data400::key::BankruptcyV2::fcra::case_number_' + doxie.Version_SuperKey);
 */ 