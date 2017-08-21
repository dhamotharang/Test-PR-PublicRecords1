//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: MAPPING_NYC_MAIN

// DEPENDENT ON : liensv2.layout_liens_main_temp,
//				  liensV2.Layout_Liens_temp_base,
//				  liensV2.mapping_NYC,
//				  liensv2.Layout_liens_main_module.layout_liens_main,
//				  liensv2.Layout_liens_main_module.layout_filing_status

// PURPOSE	 	: distribute(tmsid) and sort the mapped main daily NYC file  
//			      and add to the distributed full file and rollup
//				  the fill file.
//////////////////////////////////////////////////////////////////////////////////////////

import LiensV2, address;

// Process daily file (distribute, sort and flatten)

filing_status_desc1(string1 code) := case(code,

'A' => 'AMENDED',  
'B' => 'BREACH OF CONTRACT',  
'C' => 'CANCELLATION',  
'D' => 'DISCHARGE BY BOND',  
'E' => 'EXTENSION',  
'F' => 'FORECLOSE ON MORTGAGE',  
'M' => 'FORECLOSE ON MECHANICS LIEN',  
'P' => 'PAYMENT TO COURT',  
'R' => 'RELEASE',  
'S' => 'SPECIAL PERFORMANCE',  
'T' => 'APPOINTED ADMINISTRATOR',  
'V' => 'JUDGMENT VACATED', '');  


filing_status_desc2(string code) := case(code,

'ACATED' => 'VACATED',
'VACATED' => 'VACATED',
'ESTERED' => 'REGISTERED',
'EVERSED' => 'REVERSED',
'REVERSED' => 'REVERSED',
'AMEDED' => 'AMENDED', '');

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_Liens_temp_base L) := transform

self.filing_status_desc := if(length(trim(L.filing_status, left, right)) > 2, filing_status_desc2(trim(L.filing_status, left, right)), filing_status_desc1(trim(L.filing_status, left, right)));
self := L;

end;

NYC_main_temp := project(liensV2.mapping_NYC, tmakemain(left));

NYC_main_dist := distribute(NYC_main_temp, hash(tmsid));
NYC_main_temp_sort  := sort(NYC_main_dist, tmsid, rmsid,record_code,date_vendor_removed, filing_jurisdiction,filing_state, orig_filing_number,orig_filing_type, 
                              -orig_filing_date,-orig_filing_time,case_number,filing_number,filing_type_desc, -filing_date,filing_time, -vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,-release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,filing_status,filing_status_desc,-process_date,local);
NYC_main_temp_dedup := dedup(NYC_main_temp_sort, record, except process_date,orig_filing_time,local);

liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(liensv2.layout_liens_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

file_flat := project(NYC_main_temp_dedup, tmakefatrecord(left), local);

// Full File - distributed (tmsid)

Full_NYC_Main_nondist := dataset('~thor_data400::base::Liens::Main::NYC',liensv2.layout_liens_main_module.layout_liens_main,thor);

Full_NYC_Main := distribute(Full_NYC_Main_nondist,hash(tmsid));

// Add Full File and Daily file (distributed)

daily_plus_full := LiensV2.fAddEvictionFlag(Full_NYC_Main + file_flat);

// Sort and rollup full file (local)

full_sort := sort(daily_plus_full,record,except process_date,orig_filing_time,local);

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

NYC_main_out := rollup(full_sort,  tmsid +rmsid+record_code+date_vendor_removed+ filing_jurisdiction+filing_state+orig_filing_number+orig_filing_type+ 
                              orig_filing_date+orig_filing_time + case_number+filing_number+filing_type_desc+ filing_date + filing_time+ vendor_entry_date+judge+case_title+ 
							  filing_book+filing_page+release_date+amount+eviction+satisifaction_type+judg_satisfied_date+judg_vacated_date+tax_code+irs_serial_number+effective_date+
							  lapse_date+accident_date+sherrif_indc+expiration_date+agency+agency_city+agency_state+agency_county+legal_lot+legal_block+legal_borough, tmakechildren(left, right), local);




export mapping_NYC_main:= NYC_main_out;



