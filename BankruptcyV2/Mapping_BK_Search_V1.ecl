import bankrupt,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header_SS, Business_Header,lib_fileservices,_control;

export Mapping_BK_Search_V1(string filedate) := function

//***//***//***//***//***//***//***//***REMAPPING***//***//***//***//***//***//***//***//***//

bankrupt.Layout_BK_Search_v8  treformat(layout_bankruptcy_search  l) := transform 

self.seq_number := l.seq_number;
self.court_code := l.court_code;
self.case_number := l.case_number;
self.debtor_type :=  l.debtor_type;
self.debtor_seq := l.debtor_seq;
self.orig_ssn := if(l.cname = '', l.ssn, l.tax_id) ; // check this  
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
self.debtor_DID := if(regexfind('[1-9]', l.did), l.did, '');
self.debtor_ssn := if(l.cname = '', l.app_SSN, l.tax_id);
self.debtor_DID_score := '';
self.bdid := if(regexfind('[1-9]', l.bdid ), l.bdid , '');
self.GLB_flag := '';
end ; 

//////CNG CHANGED DISTRIBUTE 20080306
INreffile := project(BankruptcyV2.file_bankruptcy_search(name_type ='D') , treformat(left));

reffileP := distribute(INreffile(debtor_did <> ''), hash((integer)debtor_DID));
reffileNP := INreffile(debtor_did = '');

reffile := reffileP + reffileNP;
//////CNG CHANGED DISTRIBUTE 20080306

nonglb := distribute(pull(watchdog.Key_Watchdog_nonglb),hash(did));

bankrupt.Layout_BK_Search_v8 take_r_nonglb(bankrupt.Layout_BK_Search_v8 le, nonglb ri) := transform
  self.GLB_flag := if(le.orig_ssn != le.debtor_ssn and ri.glb_ssn='Y', 'Y', 'N');
  self := le;
  end;
						
joinedfile  := join(reffile,nonglb,
						(integer)left.debtor_did=right.did,
						take_r_nonglb(left,right), left outer, local);

out5 := OUTPUT(joinedfile,,'~thor_data400::out::bankruptV2::'+filedate+'::search',OVERWRITE);


/*DESPRAY*/

super_search := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankruptV2_search_Delete', '~thor_data400::base::bankruptV2_search',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankruptV2_search'),
				FileServices.AddSuperFile('~thor_data400::base::bankruptV2_search', '~thor_data400::out::bankruptV2::'+filedate+'::search'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankruptV2_search_delete',true));

// moved to proc_misc_tasks
bk_file_despray := fileservices.Despray('~thor_data400::base::bankruptv2_search',_Control.IPAddress.edata12,
 									'/hds_180/bkv3/build/bk_search_v8.d00',,,,TRUE);

retval := sequential(out5,super_search/*,bk_file_despray*/);
// retval := sequential(out5);

return retval;

end; 

