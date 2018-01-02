import bankruptcyv2, Doxie, ut,bankrupt, data_services;

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


f := trans_V1((unsigned)debtor_did != 0);

export key_bankruptcy_did_FCRA := index (f,{unsigned6 s_did := (unsigned)debtor_did}, {f},
                                     data_services.data_location.prefix('bankruptcyv2') + 'thor_data400::key::bankruptcyv2::fcra::DID_' + doxie.Version_SuperKey);
									 


